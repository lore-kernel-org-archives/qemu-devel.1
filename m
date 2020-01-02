Return-Path: <SRS0=Q/S9=2X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7618CC2D0DC
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 11:21:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A9E720863
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 11:21:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k/0RoUNp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A9E720863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1imyXd-0002eh-Ag
	for qemu-devel@archiver.kernel.org; Thu, 02 Jan 2020 06:21:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43471)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1imyX1-0002FX-QK
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 06:20:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1imyX0-0005KD-KE
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 06:20:47 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:50577)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1imyX0-0005Jk-CG
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 06:20:46 -0500
Received: by mail-wm1-x343.google.com with SMTP id a5so5298127wmb.0
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2020 03:20:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=AUR896I9TyKE0eXc8cnNC8DGIdNPim5WuipxVBdpiDI=;
 b=k/0RoUNpdniTUcoxIBgd5OUCilMnV1QMF4l6bU/37UVpvykDG/iOM+AefPOzzJgnE9
 vLEKzg5xH93sanFe4NkLhV+5YbxGC0/IVE8XXaInhnpKgJAmL6Rk+nA7iiuiIxh6U+92
 ecs8Jw/2XzSK3gCf0tSa9cAzVWtm42jo0QYUNePGgOvc+O9OcSpZ+FRAJPfkdXoos33Q
 O7zi9IFjn0+d7yZLx9V9mZEXKwPCY8W8kF2jHHz74QV9xcGoBxE1bKI8YdELZa3kuh+f
 85GjD5DoaGuBJfzWdUbi+MELi3/hQZwHAZbW+UBlUmyB08L+6J/wBrv0QvKuZQB8wAAJ
 vJgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=AUR896I9TyKE0eXc8cnNC8DGIdNPim5WuipxVBdpiDI=;
 b=SveSld7KE48KsS/BzQGhlR6yu1W2lvX7GvZakcpvOeT4uY8l2TXDubWw3b4aK4AAGN
 uyvlXqa/0HSCaM+eH+LkjN/ycO0jyQ/23emvLoSPIPyDPK0kyDnfX4MN7ghqfc7EZSYA
 9DGKm6kGbaa7ovuTvzpNkDIf0D01DBdInG5zsJXT3OZo/KAP0V1EPYH92mZa61qBMbrv
 rEEB58Oxal1Lf5nw1NcMjmq7sn4ELNo/NbbG4qWGNEJ1EVeb0nMQH8mVyNg2Puw+biTD
 yH5zbCv/NGVtkdX7CnHbRQNTGyg/lew9iO8s00y3igNOVsTdcRsD9WVZuKeB2KNp/AiJ
 eccQ==
X-Gm-Message-State: APjAAAXTWqRITIL16DXig5R/j/YI+Y8MyJBCfksm81tRft4CyucuDHYq
 jKr7lDeaq+B25+/tFTLa3rc=
X-Google-Smtp-Source: APXvYqxUBziZT6xlWXYdPcRGZmuhga5ZCgthnCmTNGMPk8lyS6VUn88t3PUPwWTv9Kv2KStGl1+Daw==
X-Received: by 2002:a1c:4d18:: with SMTP id o24mr13863519wmh.35.1577964045014; 
 Thu, 02 Jan 2020 03:20:45 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id u14sm55646470wrm.51.2020.01.02.03.20.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jan 2020 03:20:44 -0800 (PST)
Date: Thu, 2 Jan 2020 11:20:43 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Wangyong <wang.yongD@h3c.com>
Subject: Re: issue about virtio-blk queue size
Message-ID: <20200102112043.GH121208@stefanha-x1.localdomain>
References: <8920655f41aa4d1bbd5b7590ac0d1bef@h3c.com>
 <20191203143731.GD230219@stefanha-x1.localdomain>
 <18dcb1c11c1d481eadf491f9074f6306@h3c.com>
 <20191220095321.GB1635864@stefanha-x1.localdomain>
 <1ab2f9ecb3c04728aeffaa1e6d8beb0f@h3c.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="9sSKoi6Rw660DLir"
Content-Disposition: inline
In-Reply-To: <1ab2f9ecb3c04728aeffaa1e6d8beb0f@h3c.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>, "hch@lst.de" <hch@lst.de>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--9sSKoi6Rw660DLir
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Dec 21, 2019 at 02:07:19AM +0000, Wangyong wrote:
> > From: Stefan Hajnoczi [mailto:stefanha@gmail.com]
> > Sent: Friday, December 20, 2019 5:53 PM
> > To: wangyong (Cloud) <wang.yongD@h3c.com>
> > Cc: Stefan Hajnoczi <stefanha@redhat.com>; pbonzini@redhat.com;
> > mark.kanda@oracle.com; hch@lst.de; qemu-devel@nongnu.org
> > Subject: Re: issue about virtio-blk queue size
> >
> > On Thu, Dec 05, 2019 at 01:30:09AM +0000, Wangyong wrote:
> > > >
> > > > On Thu, Nov 28, 2019 at 08:44:43AM +0000, Wangyong wrote:
> > > > > Hi all,
> > > >
> > > > This looks interesting, please continue this discussion on the QEMU
> > > > mailing list <qemu-devel@nongnu.org> so that others can participate.
> > > >
> > > > >
> > > > > This patch makes virtio_blk queue size configurable
> > > > >
> > > > > commit 6040aedddb5f474a9c2304b6a432a652d82b3d3c
> > > > > Author: Mark Kanda <mark.kanda@oracle.com>
> > > > > Date:   Mon Dec 11 09:16:24 2017 -0600
> > > > >
> > > > >     virtio-blk: make queue size configurable
> > > > >
> > > > > But when we set the queue size to more than 128, it will not take effect.
> > > > >
> > > > > That's because linux aio's maximum outstanding requests at a time
> > > > > is always less than or equal to 128
> > > > >
> > > > > The following code limits the outstanding requests at a time:
> > > > >
> > > > > #define MAX_EVENTS 128
> > > > >
> > > > > laio_do_submit()
> > > > > {
> > > > >
> > > > >     if (!s->io_q.blocked &&
> > > > >         (!s->io_q.plugged ||
> > > > >          s->io_q.in_flight + s->io_q.in_queue >= MAX_EVENTS)) {
> > > > >         ioq_submit(s);
> > > > >     }
> > > > > }
> > > > >
> > > > > Should we make the value of MAX_EVENTS configurable ?
> > > >
> > > > Increasing MAX_EVENTS to a larger hardcoded value seems reasonable
> > > > as a shortterm fix.  Please first check how /proc/sys/fs/aio-max-nr
> > > > and
> > > > io_setup(2) handle this resource limit.  The patch must not break
> > > > existing systems where 128 works today.
> > > [root@node2 ~]# cat /etc/centos-release CentOS Linux release 7.5.1804
> > > (Core)
> > >
> > > [root@node2 ~]# cat /proc/sys/fs/aio-max-nr
> > > 4294967296
> > >
> > > > > MAX_EVENTS should have the same value as queue size ?
> > > >
> > > > Multiple virtio-blk devices can share a single AioContext,
> > > Is multiple virtio-blk configured with one IOThread?
> > > Multiple virtio-blk performance will be worse.
> >
> > Yes.  By default IOThreads are not used and all virtio-blk devices share the
> > main loop's AioContext.
> >
> > When IOThreads are configured it's up to the user how to assign devices to
> > IOThreads.  Assigning multiple devices to one IOThread is realistic because
> > it's common to create only num_vcpus IOThreads.
> >
> > A good starting point would be a patch that raises the limit to a higher
> > hardcoded number.  Then you can investigate how to size the AioContext
> > appropriately (maybe dynamically?) for a full fix.
> >
> Okay.  Raising MAX_EVENT to 1024 may be more appropriate? If possible I can try to make a patch.

Sounds good.

Stefan

--9sSKoi6Rw660DLir
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl4N0goACgkQnKSrs4Gr
c8jLgQgAo4NgePjPbXW/56Ms1SVLeSVKboQp7Os0TsOgeyn7niHgyzJJLgyKO+l+
diC4TC0T/sbheSQnexPnJ70xiNj+sEdb3Of3k2SHBuARyUdItaHbgfkDf+dBrqpJ
Y3cSV6IjEdCxGbj7aKb2GH4utXIdSx9GkUpPWTF2EyuiGiFwkKC+n4b4ReXlwKhu
wcw20dSF1diUG+8rFMA26s4g/JYyN2mzjvHB81xHsdwoTu96O283gv1YsEwiz8rJ
lLYya3v3n7xcM8QEPyLkNuCFeaTI62nVbIP1KJVzaqW+ko4TM8JgSVBpH1d2ljHR
n35L6spxthw3UVavWdZBrHf8jL17xQ==
=0uD9
-----END PGP SIGNATURE-----

--9sSKoi6Rw660DLir--

