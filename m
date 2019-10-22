Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 009CCCA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 18:13:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC65B20B7C
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 18:13:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC65B20B7C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=keithp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39608 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMyec-0004Xe-0D
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 14:13:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56359)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <keithp@keithp.com>) id 1iMydl-0003vo-S3
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 14:12:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <keithp@keithp.com>) id 1iMydk-00046I-Sj
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 14:12:17 -0400
Received: from home.keithp.com ([63.227.221.253]:39872 helo=elaine.keithp.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <keithp@keithp.com>)
 id 1iMydi-00044f-Fj; Tue, 22 Oct 2019 14:12:14 -0400
Received: from localhost (localhost [127.0.0.1])
 by elaine.keithp.com (Postfix) with ESMTP id 30C373F230CE;
 Tue, 22 Oct 2019 11:12:12 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at keithp.com
Received: from elaine.keithp.com ([127.0.0.1])
 by localhost (elaine.keithp.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id Y7HqjLvEgwMl; Tue, 22 Oct 2019 11:12:12 -0700 (PDT)
Received: from keithp.com (keithp-172.keithp.com [10.0.0.172])
 by elaine.keithp.com (Postfix) with ESMTPSA id E3B6E3F22EBE;
 Tue, 22 Oct 2019 11:12:11 -0700 (PDT)
Received: by keithp.com (Postfix, from userid 1000)
 id B896B1582187; Tue, 22 Oct 2019 11:12:11 -0700 (PDT)
From: "Keith Packard" <keithp@keithp.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH] Semihost SYS_READC implementation
In-Reply-To: <d7470bfa-ba4e-3287-326f-ee63c5d76407@redhat.com>
References: <20191022031335.9880-1-keithp@keithp.com>
 <d7470bfa-ba4e-3287-326f-ee63c5d76407@redhat.com>
Date: Tue, 22 Oct 2019 11:12:11 -0700
Message-ID: <87sgnk3b0k.fsf@keithp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha256; protocol="application/pgp-signature"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 63.227.221.253
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Paolo Bonzini <pbonzini@redhat.com> writes:

Thanks so much for looking at this patch.

> I'm a bit confused, why is it not using semihosting_get_chardev?  That
> would be
>
> 	-chardev stdio,id=3Dsemihost
> 	-semihosting-config on,chardev=3Dsemihost

Because I didn't realize the semihosting code already had a Chardev
option.  Thanks much for pointing it out. I've changed the code to use
the semihosting chardev instead of serial_hd(0). That change was quite
simple:

 void qemu_semihosting_console_init(void)
 {
=2D    if (semihosting_enabled()) {
=2D        qemu_chr_fe_init(&console.backend, serial_hd(0), &error_abort);
+    Chardev *chr =3D semihosting_get_chardev();
+
+    if  (chr) {
+        qemu_chr_fe_init(&console.backend, chr, &error_abort);
         qemu_chr_fe_set_handlers(&console.backend,
                                  console_can_read,
                                  console_read,

(I left the call to qemu_semihosting_console_init() late in the
initialization process so that the semihosting I/O ended up with the
stdio mux focus instead of the monitor)

Your example command line was really helpful in figuring out how to get
this to work. Here's the full command line I ended up using so that
semihost, serial and monitor are all muxed to stdio:

$ qemu-system-arm -chardev stdio,mux=3Don,id=3Dstdio0 -serial chardev:stdio=
0 -semihosting-config enable=3Don,chardev=3Dstdio0 -mon chardev=3Dstdio0,mo=
de=3Dreadline=20

It might be nice if this could be shortened, but it certainly provides
the necessary options to make it all work.

I'll post an updated version of the patch in a while, after waiting to
see if there are any additional comments.

=2D-=20
=2Dkeith

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEw4O3eCVWE9/bQJ2R2yIaaQAAABEFAl2vRnsACgkQ2yIaaQAA
ABHuuA/+LkJ6ZfdfZ+wCjEtpm9M63MQblGwO1TZAwHDeoRAWtfZeeCni/D3PzJIQ
O2fUsRrCYfFrJxoMK7xyAswQMpv7e4Fn4q9WCPzQ6gjs0SvoC1YUeahXeO5gHj41
db6P86RcQQ4Hg/uJXKWskVxGEZGZT/VKMH90YC4j5PuylCP2r6iGwznbl48bEqa7
hUkZxedMDZEl8wAHYJSCIAhzC4Lk58PMsK82jninKoE93r5xBPKpVqBuChlGEV1J
rABmwZjf+Nuj1idIUvylkGSY8sO/GvkjaoZDuz19V9yEUMhfgsN6DG59tDLDmG/I
PLMtSgVR+JmnksZIof0X+BLerS6zIouI1yj7/ZfobnycZqcULTMAmpEcr+BWAyX9
r83S3Oj8IxvecCm4TuQsKlAfoWJ2a2A7g92ytdCCu1/1z29ScZ2GsfJMwyBzoBRK
rnc9ULexi0V9OgY8WIziHhEUSUGZzRu7QjmJeSdvq9xgyTQRGVX4rp9UPcT/uo76
QEYCUGGJJQtnNxnldaLoeA1fDp6OOogwr+ysw6hILkCAP/fwH5sEZxz7UVjuzAUp
BTXPAbgkUF7eyOTXUEyM0n+D387ibaJi2X+VInRQJ09GwoYu7siHFm25MV/AHcEh
x5sTBS9FZ52tFqjbhfuwyLLcKpzZKur8NX8TAn9UmRQNGj2ZIrk=
=I6jL
-----END PGP SIGNATURE-----
--=-=-=--

