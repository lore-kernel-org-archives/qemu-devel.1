Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B661C432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 23:41:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E485F206D6
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 23:41:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E485F206D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=keithp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVlDn-000137-1N
	for qemu-devel@archiver.kernel.org; Fri, 15 Nov 2019 18:41:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35295)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <keithp@keithp.com>) id 1iVlDA-0000ch-SR
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 18:41:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <keithp@keithp.com>) id 1iVlD9-0005Sp-SP
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 18:41:08 -0500
Received: from home.keithp.com ([63.227.221.253]:58898 helo=elaine.keithp.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <keithp@keithp.com>) id 1iVlD9-0005SP-Ma
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 18:41:07 -0500
Received: from localhost (localhost [127.0.0.1])
 by elaine.keithp.com (Postfix) with ESMTP id 71F243F29B26;
 Fri, 15 Nov 2019 15:41:04 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at keithp.com
Received: from elaine.keithp.com ([127.0.0.1])
 by localhost (elaine.keithp.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id fT4qjkNEgsCj; Fri, 15 Nov 2019 15:41:04 -0800 (PST)
Received: from keithp.com (unknown [172.58.45.253])
 by elaine.keithp.com (Postfix) with ESMTPSA id C3F6D3F29B25;
 Fri, 15 Nov 2019 15:41:03 -0800 (PST)
Received: by keithp.com (Postfix, from userid 1000)
 id 3C0B9158212B; Fri, 15 Nov 2019 15:40:59 -0800 (PST)
From: "Keith Packard" <keithp@keithp.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] Semihost SYS_READC implementation (v4)
In-Reply-To: <CAFEAcA8FyDVOrJPYGKs_Lgq1oMHuVENu=ggJe69OugQvZRZ0cA@mail.gmail.com>
References: <89ada4b1-ee3d-a512-07c2-9bc1ba5806da@redhat.com>
 <20191024224622.12371-1-keithp@keithp.com> <8736fhm9tw.fsf@linaro.org>
 <87pnik4w9n.fsf@keithp.com>
 <CAFEAcA-g+RkvYjseDE=1Z=gnLum0Cjvn_7bqB3ti+cBq9UZ3Eg@mail.gmail.com>
 <87mudo4owu.fsf@keithp.com>
 <CAFEAcA-MRtr9WUpqqwJiX9kc+ybGdgfv7ZB5Tc6_q9xwHwebsQ@mail.gmail.com>
 <d4baa0c3-694a-293a-385a-b3eba7d52d0d@linaro.org> <87r22at7po.fsf@keithp.com>
 <CAFEAcA8FyDVOrJPYGKs_Lgq1oMHuVENu=ggJe69OugQvZRZ0cA@mail.gmail.com>
Date: Fri, 15 Nov 2019 15:40:58 -0800
Message-ID: <87imnku2r9.fsf@keithp.com>
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
Cc: Alex =?utf-8?Q?Benn?= =?utf-8?Q?=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Peter Maydell <peter.maydell@linaro.org> writes:

> It's on my queue to review if nobody else gets to it first, but since
> we're in freeze right now it won't be landing til after the release
> happens (expected mid-December).

Thanks in advance! I'll get started pushing questions about the RISC-V
semihosting ABI into that standard group and see if we can't at least
have the existing situation clarified. I think at a minimum we need:

 1) Explicit reference to the intended ARM API, with an explicit mapping
    between ARM architecture concepts to the ones used for RISC-V,
    especially for how arguments are passed.

 2) Resolution of how to handle sequence which cross page boundaries.

=2D-=20
=2Dkeith

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEw4O3eCVWE9/bQJ2R2yIaaQAAABEFAl3PN4oACgkQ2yIaaQAA
ABH4IQ/6AugMYtN0MpZtZsrtTHcjS/88ei+CRC0qrTZjzTPF9Wj0/Ai76ila1y8K
z5deL7dU+QcX5IDPh/cmOwmdL1kEzsJcIEuXzTwas7Fczl0+KpvnGbU9Ucr5DOjK
D7ZIStBYEcJUgzyIdd85a+xPQ8AsFiF5tevnIUVlS1LJTxND8ul+4mAvCXeLBWwT
c6YxHZwVHxVyNkBVrmAbnoJshuJ6fw9eOVF308ilX4F5HCGKLS7T4IzCwqsFL6BI
sS8gXbWDZj12AAxZbzaZ5CLop1PTjrrZHfFa8Cvn/AvvsN7BoB5kfZcmHBcn2/bQ
t39+JOzESCLeJ1HPCqHwC9gefxRqHYhFQWsraegGFB/0bGHgGOICKc6S/ex5HD9t
U7mIvt6x7v8vximu1lFgOOCxXgHz6FIgygokv+ylrFdCteHJmuTIR5g2gvUkOx7V
NzON8etFC0DSHs12cs6AEKPJW5cBNCI8JTw1qzGWSXFftWS7a7OZGF+wCeRPTGVK
ctFHWrS5BqRw0L3jlriqprJdiR7WDHgi+n3PYyycDae5uJ0LEZTbl+54CtNQr/6o
RhF7yM/wAuz6pItwmC8CxLydT+8qzYSeVDQamT6h201fkxt24L4vSlR+VDhMjtUd
o/FDqEzLWHlYiT9LTc4itKSy0AGsA8+CBaOimZfL+otCKMOgq1w=
=DEwE
-----END PGP SIGNATURE-----
--=-=-=--

