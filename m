Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 517CFC4CEC9
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 09:40:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AF0321897
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 09:40:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SZekF6zI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AF0321897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56566 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAWRm-0002Zl-4k
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 05:40:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57560)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1iAWQz-0002AI-Pr
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 05:39:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1iAWQy-0007Np-Oz
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 05:39:37 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:36447)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1iAWQy-0007NE-Hs
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 05:39:36 -0400
Received: by mail-wm1-x343.google.com with SMTP id t3so1747517wmj.1
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2019 02:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=WnBCWCVfB3ADc1fi9xg2nzKjb1OX56zbQBjRCriykOU=;
 b=SZekF6zI+QAAGj8243Yz6zKcuusYEzYqtFBfl7xjZNQhsgBGZVZ44T0PeQGmlAwCJu
 sgYF4mjqhAqHP7qo+m1XoAbS/AUw5wcg3RzcSMSLfG54fOEeXLI5UQ5zeiCVX9WFPb7q
 2qDCi8ys26YexbXcRGw7KaHKLMxB4T9yk10Uk9AatpyxJr/NZ6LJWHTTn/jTG6vreN1x
 l0sZxuyVuEsv9WZGWAj4x8SSoAicD27zh6yWuzpNHvTZhFXbz+rHOKecahv2hp15jQKG
 IuNfvi7WdMcAitPVqIDqSmFUSI7iHmBSoqgIUzlgPn3J42PU7s9iZGZByvTEp16Tf+8s
 0CgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=WnBCWCVfB3ADc1fi9xg2nzKjb1OX56zbQBjRCriykOU=;
 b=bFxAl5QWWIF3bIJqFEPcp1ys2EwdcOVvfH6POkxpPTtwZEfLsEs5ZUU+xyMwT7Rqzd
 oivFuujMy8HtJA5K11TU/RZkMUK1rvToFM8fPLN9VJxPWDRu77q1hEos2xY+b9cOQ4N3
 uFQNmavwQInwKVJHdBPv1WZl++lb7n0WUJIttVSl1zxgP8XqIrmjJ3mcLJTDSwU4arE/
 MUc2Qq+6Rbq/1PPlRISVWdj+LUuTy7zlagt9XtyDRBIbPWqMPy/JHs2Dawtp++ph8ZON
 lio4K8tSnS/BfvfQpQ9Tbu8XchhYEkjhBRD0+jxmdwJnoszaFmohMkJuAx5iXwDNTQmv
 nAog==
X-Gm-Message-State: APjAAAWTbHdiAiigtOZk6n2betgJindAj5GB5tg9BD/4M96jSAsQkD5K
 v1IqJq/uFdIYuW8K0kPdbbU=
X-Google-Smtp-Source: APXvYqwno0zJEDTc4uoVLAN7YevClyHgGG4Y5h+VnkRGNDxMGZqycg4GtPnkSyVU8jlQ6ksby0nYQA==
X-Received: by 2002:a05:600c:20c4:: with SMTP id
 y4mr1802339wmm.87.1568799575320; 
 Wed, 18 Sep 2019 02:39:35 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id h7sm1343360wmb.34.2019.09.18.02.39.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Sep 2019 02:39:34 -0700 (PDT)
Date: Wed, 18 Sep 2019 10:39:32 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Message-ID: <20190918093932.GC26027@stefanha-x1.localdomain>
References: <20190917122559.15555-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="7gGkHNMELEOhSGF6"
Content-Disposition: inline
In-Reply-To: <20190917122559.15555-1-johannes@sipsolutions.net>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: Re: [Qemu-devel] [PATCH] libvhost-user: handle NOFD flag in
 call/kick/err better
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
Cc: qemu-devel@nongnu.org, Johannes Berg <johannes.berg@intel.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--7gGkHNMELEOhSGF6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 17, 2019 at 02:25:59PM +0200, Johannes Berg wrote:
> diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-use=
r/libvhost-user.c
> index f1677da21201..17b7833d1f6b 100644
> --- a/contrib/libvhost-user/libvhost-user.c
> +++ b/contrib/libvhost-user/libvhost-user.c
> @@ -920,6 +920,7 @@ static bool
>  vu_check_queue_msg_file(VuDev *dev, VhostUserMsg *vmsg)
>  {
>      int index =3D vmsg->payload.u64 & VHOST_USER_VRING_IDX_MASK;
> +    bool nofd =3D vmsg->payload.u64 & VHOST_USER_VRING_NOFD_MASK;
> =20
>      if (index >=3D dev->max_queues) {
>          vmsg_close_fds(vmsg);
> @@ -927,8 +928,12 @@ vu_check_queue_msg_file(VuDev *dev, VhostUserMsg *vm=
sg)
>          return false;
>      }
> =20
> -    if (vmsg->payload.u64 & VHOST_USER_VRING_NOFD_MASK ||
> -        vmsg->fd_num !=3D 1) {
> +    if (nofd) {
> +        vmsg_close_fds(vmsg);
> +        return true;
> +    }

With the following change to vmsg_close_fds():

  for (i =3D 0; i < vmsg->fd_num; i++) {
      close(vmsg->fds[i]);
  }
+ for (i =3D 0; i < sizeof(vmsg->fd_num) / sizeof(vmsg->fd_num[0]); i++) {
+     vmsg->fds[i] =3D -1;
+ }
+ vmsg->fd_num =3D 0;

=2E..the message handler functions below can use vmsg->fds[0] (-1) without
worrying about NOFD.  This makes the code simpler.

--7gGkHNMELEOhSGF6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl2B+1QACgkQnKSrs4Gr
c8hEJwf+MkodCq0ngzmHQxQDi5T+9cE953luTKmmra/1n198DoiFNywaQ0gmXQDB
SH1SEUqilIYJCRtRTiXXtp7iajHPFUJY6Q51WQGoVJoz2z8Ty5HwsZBuB+LAHNZQ
cnZYMqUKcrSA3FYjecQC4cNgIzc6WQuCdN5A8cKn6kCsw81F8rme0KmZV3Rdhdir
ofQkUvdx+h2YHQcOP26nmiolBJpVZC/34/bsGgg1XJtJJFY3cu/CJXOdKt+N3SOt
8r5rxiYXHXgK5QbwGch5ZJ2d/H98LOxdPBXMKoAATrjaPaAKo3a2kRBQtWS6u5Qx
vxnqB3mMnOsIn0E1V5HPrS7jMymRYQ==
=5gA/
-----END PGP SIGNATURE-----

--7gGkHNMELEOhSGF6--

