Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51E0DC43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 09:54:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 187972465E
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 09:54:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fGWQOZUJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 187972465E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiEzD-0003Xm-9g
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 04:54:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59190)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1iiEyR-000308-H0
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 04:53:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1iiEyP-0002a1-0X
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 04:53:30 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:39330)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1iiEyN-0002Xb-4X
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 04:53:28 -0500
Received: by mail-wm1-x344.google.com with SMTP id 20so8422451wmj.4
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2019 01:53:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=CAiXWTv8Tdq52DJ9aX8Fe1qF7AvbUrPylCyNHA+njOw=;
 b=fGWQOZUJE+4BCxUsToF9rTTwLgkdRhG6RvNZnZkClwWrWGncX77XuKOj1aDMdUbAlx
 dNtq0hPfWqfVa/ekQ3WDNuWzFi1r9w49RbtsCyzt8jvL47fIH386LAvkY8KP0D4jjsyR
 RS1Sky2e7QNMH1U4CYbmCMvxYkuLkvhcnjeN7TxlA3y4j+Gjd+CJzyViyrakHsjDqHNR
 CPG69k4k7HnNXk0znRTGpnWGrmnQSbT+ogMyJeBSuev5i86ll80UQgKyNlC1wN7R8X4B
 3fCmhXPoN7fgggZ/SdlRS4zRyRqI5nht2BXyyGNMF3AHmcSCZjocRZz2k5IcryGCmZir
 3IUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=CAiXWTv8Tdq52DJ9aX8Fe1qF7AvbUrPylCyNHA+njOw=;
 b=a5hmbPkp+Lfc/NLgoIPuZd3FXH0TUX5ma+cYcObUVWceU7EpceUv6aQvOVQdIMCkbj
 XGBiz99n3nShCvJzzZ66hFSaIXi/s8P9d/aon8hUTu0sChFf+qi2QX+qDjSMselOSEb8
 wDdayco7NlHNAoSGhZG0+tQzKVbN+bxMJ6iuot3Z/cvvGN5bKCsVZAD7LSlCmY8o02lx
 4akixGiTDqiyHyEl7nrDJVTuyYiya+/S0sXRlMQOSPXCMW9gVLU07BWS6GRKk/xuIOgW
 wUJ805EfA+BMY2lk/7laSUtkEcB9/E+9I9oxHAlSwZqD03GglkHG6ek1XqYohMyfn9h4
 NFIA==
X-Gm-Message-State: APjAAAW1owOgwOK30IafxQ3Su6T3kc3Pd3kcTM+TXorYmgL3Shzq0/Zc
 UUZOrimc301bwJJ9GZ2sFEU=
X-Google-Smtp-Source: APXvYqwcVi2nXd4iy4X/13MDNvHJraBmYR7ZEGhV296CHgXV0d0OAndSnjGfvUtGy4tEn36O8d+iSQ==
X-Received: by 2002:a1c:48c1:: with SMTP id v184mr15678215wma.5.1576835604284; 
 Fri, 20 Dec 2019 01:53:24 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id a14sm9655116wrx.81.2019.12.20.01.53.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2019 01:53:22 -0800 (PST)
Date: Fri, 20 Dec 2019 09:53:21 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Wangyong <wang.yongD@h3c.com>
Subject: Re: issue about virtio-blk queue size
Message-ID: <20191220095321.GB1635864@stefanha-x1.localdomain>
References: <8920655f41aa4d1bbd5b7590ac0d1bef@h3c.com>
 <20191203143731.GD230219@stefanha-x1.localdomain>
 <18dcb1c11c1d481eadf491f9074f6306@h3c.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Y7xTucakfITjPcLV"
Content-Disposition: inline
In-Reply-To: <18dcb1c11c1d481eadf491f9074f6306@h3c.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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


--Y7xTucakfITjPcLV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 05, 2019 at 01:30:09AM +0000, Wangyong wrote:
> >
> > On Thu, Nov 28, 2019 at 08:44:43AM +0000, Wangyong wrote:
> > > Hi all,
> >
> > This looks interesting, please continue this discussion on the QEMU mai=
ling list
> > <qemu-devel@nongnu.org> so that others can participate.
> >
> > >
> > > This patch makes virtio_blk queue size configurable
> > >
> > > commit 6040aedddb5f474a9c2304b6a432a652d82b3d3c
> > > Author: Mark Kanda <mark.kanda@oracle.com>
> > > Date:   Mon Dec 11 09:16:24 2017 -0600
> > >
> > >     virtio-blk: make queue size configurable
> > >
> > > But when we set the queue size to more than 128, it will not take eff=
ect.
> > >
> > > That's because linux aio's maximum outstanding requests at a time is
> > > always less than or equal to 128
> > >
> > > The following code limits the outstanding requests at a time:
> > >
> > > #define MAX_EVENTS 128
> > >
> > > laio_do_submit()
> > > {
> > >
> > >     if (!s->io_q.blocked &&
> > >         (!s->io_q.plugged ||
> > >          s->io_q.in_flight + s->io_q.in_queue >=3D MAX_EVENTS)) {
> > >         ioq_submit(s);
> > >     }
> > > }
> > >
> > > Should we make the value of MAX_EVENTS configurable ?
> >
> > Increasing MAX_EVENTS to a larger hardcoded value seems reasonable as a
> > shortterm fix.  Please first check how /proc/sys/fs/aio-max-nr and
> > io_setup(2) handle this resource limit.  The patch must not break exist=
ing
> > systems where 128 works today.
> [root@node2 ~]# cat /etc/centos-release
> CentOS Linux release 7.5.1804 (Core)
>=20
> [root@node2 ~]# cat /proc/sys/fs/aio-max-nr
> 4294967296
>=20
> > > MAX_EVENTS should have the same value as queue size ?
> >
> > Multiple virtio-blk devices can share a single AioContext,
> Is multiple virtio-blk configured with one IOThread?
> Multiple virtio-blk performance will be worse.

Yes.  By default IOThreads are not used and all virtio-blk devices share
the main loop's AioContext.

When IOThreads are configured it's up to the user how to assign devices
to IOThreads.  Assigning multiple devices to one IOThread is realistic
because it's common to create only num_vcpus IOThreads.

A good starting point would be a patch that raises the limit to a
higher hardcoded number.  Then you can investigate how to size the
AioContext appropriately (maybe dynamically?) for a full fix.

Stefan

--Y7xTucakfITjPcLV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl38mhEACgkQnKSrs4Gr
c8jcjggAgPYA3PIEvFz29kGayJ9V75iq1wOW2Kk423Dfxw3lQgUO5fwrHvQ9CIys
9hb2J6hToSR+pZYzxlsWnaPeF+ee4U34wRFXqFCEA/9DTu8F5tgyF5z73VvqrFxW
gnOWaNNzGG5I4AbK2DWgRhDs8FaLGYaFt+P8RHCwhjMJbq1krobYLNHXM+sqfzzp
yEtbMBqeQHM3JwPEwml5a8U/44jZTl3udWuhtCl7vqfSEDklhxq37tFPjrKv9PD8
gQS9BLuQPUsWXcHl4Z4zW7zBiis0B7aKx897dFnsBCc2snB+B7rzzX4BVMPEnCOv
sYFayrxyymr5Ird2yz9QJXdMcZpa7Q==
=CD9F
-----END PGP SIGNATURE-----

--Y7xTucakfITjPcLV--

