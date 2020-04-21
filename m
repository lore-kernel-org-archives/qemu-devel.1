Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4F51C38A30
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 00:40:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FA30206E9
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 00:40:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="oYbD0gB5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FA30206E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQgxs-0001bK-O4
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 20:40:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51246)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jQgx5-000101-UC
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 20:39:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jQgx4-0004IS-6Z
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 20:39:51 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:37473)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jQgx0-00042G-A4; Mon, 20 Apr 2020 20:39:49 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 495l7r2y3mz9sSJ; Tue, 21 Apr 2020 10:39:36 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1587429576;
 bh=nwT16vwQmzQ1AUICLk9CcpwMjPBoWQOFlkSf3ZdIrcA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=oYbD0gB5fV5OjLrWBkOVTwcbW9PugogBSt7+8VEHcAGrOPaG0VX1PJHVzsmg7AdZ1
 6HOzQidYrfGwEOigi+5H310qMiLv+ZJDC+w5ZpTGAWVNsiJdgyZmQVLhJHT33xMKmM
 dQdAWnzy+cYSnrOwPbG7TbKsnBrgHBdaR00xkkZo=
Date: Tue, 21 Apr 2020 10:31:36 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH-for-5.0?] target/ppc: Fix TCG temporary leaks in
 gen_slbia()
Message-ID: <20200421003136.GA52174@umbus.fritz.box>
References: <20200417090749.14310-1-f4bug@amsat.org>
 <CAFEAcA-aj77=19d+8jmoWYXBDdm=U8eV8CsHpovMN8bE9uNSvg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="h31gzZEtNLTqOjlF"
Content-Disposition: inline
In-Reply-To: <CAFEAcA-aj77=19d+8jmoWYXBDdm=U8eV8CsHpovMN8bE9uNSvg@mail.gmail.com>
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2401:3900:2:1::2
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>,
 Nicholas Piggin <npiggin@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>,
 qemu-ppc <qemu-ppc@nongnu.org>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 Dennis Clarke <dclarke@blastwave.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 20, 2020 at 07:56:50PM +0100, Peter Maydell wrote:
> On Fri, 17 Apr 2020 at 10:08, Philippe Mathieu-Daud=E9 <f4bug@amsat.org> =
wrote:
> >
> > This fixes:
> >
> >   $ qemu-system-ppc64 \
> >   -machine pseries-4.1 -cpu power9 \
> >   -smp 4 -m 12G -accel tcg ...
> >   ...
> >   Quiescing Open Firmware ...
> >   Booting Linux via __start() @ 0x0000000002000000 ...
> >   Opcode 1f 12 0f 00 (7ce003e4) leaked temporaries
> >   Opcode 1f 12 0f 00 (7ce003e4) leaked temporaries
> >   Opcode 1f 12 0f 00 (7ce003e4) leaked temporaries
> >
> > [*] https://www.mail-archive.com/qemu-discuss@nongnu.org/msg05400.html
> >
> > Fixes: 0418bf78fe8 ("Fix ISA v3.0 (POWER9) slbia implementation")
> > Reported-by: Dennis Clarke <dclarke@blastwave.org>
> > Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
>=20
> I propose to apply this patch for 5.0 rc4 (as well as the
> ppc pullreq already sent), since the iscsi bugfix means
> we need an rc4 anyway. Any objections?

Works for me.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--h31gzZEtNLTqOjlF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl6ePuUACgkQbDjKyiDZ
s5JFBxAAhxZ/3gguuvWsd4Fzlu5OXS1FkkkhXEwmUqkaazYtndo6hxOKmnMT3Ypy
waXbKt+HsDl8nzKWbRLdE4HDtv291spD3HhDyL86507qGzJLkcKCrYZxAZVqqbUS
F4CvYbu6efC2ynLF679y6vfMJ5ekdeqjfm5k2kkLbNK+yw2d7tBVCqmkGxc0NUHI
C5QplfitZi7GlSJjhpZWr8UlAgS9e/qRZ+vzsgAslesNOyqwmvhIeqYHZRREmkTa
L/aBwd8YWHnZPxwhk4ZpagF314iNNhThgS/iRkJUffs/dK34Tcz2O/sniwnJP+DO
eeHu5Y1u9AQkow4gRp3LQaTeJyB+rnLdXMSmoTmaY0bSf5qYzfRGeIZXyLvWlRHC
6siQUnrCyw3qq+Rni/29Atc/2emWZuhdt/gMVXtf2o7yYOUssQ55QhbkBGul2lwY
juQJxpqovWIIUB9edCOfrr4EpM6kLo8ikCdvI56LDCysrT/t7dDgOrUL0IUmGQqf
HoxTslBpGPvGs7HZ4A3mfJ0uiSoOh8qhoL++DbjqoPzP5Eje3bkkgi/DRB+5292t
kAGeErt0fK17SViIzjq5q9SctcSKmj5aTVDHvnSWxcYIQdQfWiLjGvjuI6FyeO5Z
ZGyYxYHEf49wuOusv759bY2l1yasUESFBhrCQtfqXC2JHNJ09xk=
=yFT+
-----END PGP SIGNATURE-----

--h31gzZEtNLTqOjlF--

