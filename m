Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E36C1C282DD
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 17:05:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD1F220692
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 17:05:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gVOIVxom"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD1F220692
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipElj-00030Q-MJ
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 12:05:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53070)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1ipEiy-0008Ak-BJ
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 12:02:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1ipEix-0006TT-1X
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 12:02:28 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:46682)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1ipEiw-0006SD-MS
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 12:02:26 -0500
Received: by mail-wr1-x442.google.com with SMTP id z7so4107744wrl.13
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2020 09:02:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=RT+LBwtrs+pIJFlKOpml16o4HIJLwdAdQjf3NKvN6f0=;
 b=gVOIVxomZZH+oZpd9czekdLzOmB9usKbfLCPm65pzA+DtOpYm3atEfAVrrmXk5NzF9
 cRRPf3rMiZafMCh1MpaFbB/hoOoJ98742aR6Gy22zjbdwnHUTWdN+f/fsjhXP8POJ1dd
 yMOCgdKCrTQje2n/sMhCSxui+VcZuVY2g4maYlXQSeEPqHMiO73N9PERrAW60oMGX74n
 TKLZv0QyZgnJ5msy7CDJSra8UrOXY5vrrBwjet2UIC5RPNQIZY9vpBwAXMfycQTTG3KP
 8E0TUNkOxCks5fTdLbfom7HegCMHDd4190R+kX/y/v+Gxk20+8FvdBlyyf1bRr3tH8K1
 KJhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=RT+LBwtrs+pIJFlKOpml16o4HIJLwdAdQjf3NKvN6f0=;
 b=ZGNBN4poD20HcslLeXRFMhlA7cdfx7nR2DUnFMKiBFnpVXFP4g45QjJsr8RtfHV4Pi
 BqAVBHZmH1lrGu8Q4YKUHWzjsCR7KtXM1Fw7+FcuO6p93PP8oPT01wfWS+T/RTcCotlw
 3mrOgsmFAH7uAOKXogxMQJFdFhOVtGRHQ245H+7M5wAC3w5lP5xfqMtzj0j6SMuRKHyB
 RxLIOb3YwEVo+wVSrt5kKSGU1Ok3TV5GSMBmMyTFa4XqpXio4CbW0KU3FjiQR6vcTNJI
 WSsVchszPawj3tan73xkwHx7FBp3KwbjS/ZFCQQdlCKgqYNvYdfBd9slp2OORxPkFrf+
 dSYQ==
X-Gm-Message-State: APjAAAX0R1zpOL3GB2GF4HxRmPHU/PIWFKJvm0c29fytoTrSdf/bMnbq
 pfyH8hkLM5u7rrqKzkUdVPI=
X-Google-Smtp-Source: APXvYqwVwrbZohM3tvgiBLU1yU4CFrH62oqr9pkv0QqhXTNUou0zN0ztx2w7U9a4+zU1UgxnGIBx9Q==
X-Received: by 2002:adf:f58a:: with SMTP id f10mr5923072wro.105.1578502944951; 
 Wed, 08 Jan 2020 09:02:24 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id t125sm4620483wmf.17.2020.01.08.09.02.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2020 09:02:22 -0800 (PST)
Date: Wed, 8 Jan 2020 17:02:21 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Coiby Xu <coiby.xu@gmail.com>
Subject: Re: [RFC] Implementing vhost-user-blk device backend
Message-ID: <20200108170221.GC501521@stefanha-x1.localdomain>
References: <CAJAkqrWm28qXtsFmaENAcsDNQV7gE=sd+YyA5ADmm2Vo9DKrUQ@mail.gmail.com>
 <20191219143141.GF1624084@stefanha-x1.localdomain>
 <CAJAkqrXKnwPhQMAT6dhvxDgs+7t3o89QSBPPDeP8AxQmwMi2Xw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="wxDdMuZNg1r63Hyj"
Content-Disposition: inline
In-Reply-To: <CAJAkqrXKnwPhQMAT6dhvxDgs+7t3o89QSBPPDeP8AxQmwMi2Xw@mail.gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: Kevin Wolf <kwolf@redhat.com>, Bharat Singh <bharatlkmlkvm@gmail.com>,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--wxDdMuZNg1r63Hyj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 05, 2020 at 12:06:17AM +0800, Coiby Xu wrote:
> Hi Stefan,
>=20
> Thank you for reviewing my work! All the improvements have been
> applied except for a small issue regarding object_add.

Excellent, thanks for your work!

> >  (qemu) object_add vhost-user-server,id=3DID,chardev=3DCHARDEV,writable=
=3Don|off
>=20
> Currently I implement object_add feature in the following syntax which use
> unix_socket directly instead of chardev,
>=20
>   (qemu) object_add
> vhost-user-server,id=3Did=3Ddisk,unix_socket=3D/tmp/vhost-user-blk_vhost.=
socket,name=3Ddisk,writable=3Doff
>=20
> I know in QEMU we can create a socket server using chardev-add,
>   (qemu) chardev-add socket,id=3Dchar1,path=3D/tmp/vhost-user-blk_vhost.s=
ocket
>=20
> But it seems it's a bit cumbersome to utilize chardev. Take QMP over sock=
et
> as an example,
>=20
>   $ x86_64-softmmu/qemu-system-x86_64 -drive
> file=3Ddpdk.img,format=3Draw,if=3Dnone,id=3Ddisk -device
> ide-hd,drive=3Ddisk,bootindex=3D0 -m 128 -enable-kvm -chardev
> socket,id=3Dmon1,path=3D/tmp/mon.sock,server,nowait -mon
> chardev=3Dmon1,mode=3Dcontrol,pretty=3Don

This convenience syntax is fine for now.

Maybe later it will be necessary to use chardev instead if the user
wishes to takes advantage of -chardev socket options (server=3Don|off,
wait=3Don|off, tls-creds=3D..., etc).

> It doesn't support multiple concurrent client connections because of the
> limitation of chardev/char-socket.c.

That's fine, vhost-user UNIX domain sockets typically don't handle
multiple concurrent connections.

Stefan

--wxDdMuZNg1r63Hyj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl4WCx0ACgkQnKSrs4Gr
c8jQGwf/ez5bwsiavlZAgHInkX2dh3jJ5UhUGy4RULWwrNJpF2KsMUzIz7Z8dFhC
ofIO//ux7c7CdeXy8Yhcc0XRWVUghyroa9dkmYQFov4Fny3l9AFwhnOJjuDT7e9k
cvjwJR/d/tyhu5yPE/satn/WNN4SgZqd7/CtysP73LH6pG223Ft64JA3qi0dYV5E
QZHjIjyEuUOVNwULjLsmCar1nyP/9sYJ/toko7cOtj4nzOp1M7U2Zfr9T7U+aWgj
fPWpGWa57qMpgt08b8PMEL0ghYpaNeJ0JHi+AgQ6uabMQNfwN3G3e99sdaItDPcT
45luzGPUry5xIc+yVvvCurdw4+zviQ==
=F+nz
-----END PGP SIGNATURE-----

--wxDdMuZNg1r63Hyj--

