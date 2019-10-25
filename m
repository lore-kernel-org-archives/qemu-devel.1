Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4246ECA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 19:18:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 144E820679
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 19:18:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 144E820679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=keithp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35308 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iO56U-000098-Du
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 15:18:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55561)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <keithp@keithp.com>) id 1iO53u-0003l2-Db
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 15:15:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <keithp@keithp.com>) id 1iO53t-0002hy-4r
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 15:15:50 -0400
Received: from home.keithp.com ([63.227.221.253]:45460 helo=elaine.keithp.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <keithp@keithp.com>) id 1iO53s-0002gA-Ux
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 15:15:49 -0400
Received: from localhost (localhost [127.0.0.1])
 by elaine.keithp.com (Postfix) with ESMTP id C4F0D3F22EBE;
 Fri, 25 Oct 2019 12:15:46 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at keithp.com
Received: from elaine.keithp.com ([127.0.0.1])
 by localhost (elaine.keithp.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id e0TfT_6YBjXi; Fri, 25 Oct 2019 12:15:46 -0700 (PDT)
Received: from keithp.com (c-73-35-169-234.hsd1.wa.comcast.net [73.35.169.234])
 by elaine.keithp.com (Postfix) with ESMTPSA id 5F5533F22EAC;
 Fri, 25 Oct 2019 12:15:46 -0700 (PDT)
Received: by keithp.com (Postfix, from userid 1000)
 id CD7CB158212D; Fri, 25 Oct 2019 12:15:45 -0700 (PDT)
From: "Keith Packard" <keithp@keithp.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] Semihost SYS_READC implementation (v4)
In-Reply-To: <CAFEAcA-g+RkvYjseDE=1Z=gnLum0Cjvn_7bqB3ti+cBq9UZ3Eg@mail.gmail.com>
References: <89ada4b1-ee3d-a512-07c2-9bc1ba5806da@redhat.com>
 <20191024224622.12371-1-keithp@keithp.com> <8736fhm9tw.fsf@linaro.org>
 <87pnik4w9n.fsf@keithp.com>
 <CAFEAcA-g+RkvYjseDE=1Z=gnLum0Cjvn_7bqB3ti+cBq9UZ3Eg@mail.gmail.com>
Date: Fri, 25 Oct 2019 12:15:45 -0700
Message-ID: <87mudo4owu.fsf@keithp.com>
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
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Peter Maydell <peter.maydell@linaro.org> writes:

> Is there a specification for RISC-V semihosting? This is
> likely to be my first question when the support comes
> round for review, so you can have it early :-)  We'd
> prefer to implement specified interfaces, not random
> ad-hoc "this seems to be what newlib wants to see,
> which is turn got hacked together by copying some other
> architecture's code".

There seems to be convergence on a pretty simple interface which uses
ebreak surrounded by a couple of specific no-ops:

      slli x0, x0, 0x1f
      ebreak
      srai x0, x0, 0x7

There are implementations in rust and openocd, and I've got one for
picolibc. The risc-v semihosting code is sitting on a branch in my repo
on github:

        https://github.com/keith-packard/qemu/tree/riscv-semihost

> (describing a mechanism to avoid stopping the emulator)
> This feels to me like it's a bit overcomplicated unless it turns out
> we actually require it though.

Would also be nice for multi-core setups. I'd like to start with the
simple plan for now.

> Isn't the answer to this "don't use a command line that tries
> to connect stdio to multiple things" ?

Uh, we do that all the time? The mux device is designed to handle this
so that you can use stdio for both monitor commands and application
I/O. It's very convenient, the only issue is that the last device that
hooks to the mux ends up getting input first (you use ^Ac to rotate
among the selected devices).

=2D-=20
=2Dkeith

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEw4O3eCVWE9/bQJ2R2yIaaQAAABEFAl2zSeEACgkQ2yIaaQAA
ABHczg/+MEA9igCCLng4b6efXd/OZ9XMWgHRGWJ/AdQ4A3T0DWWACqk7CKc4DQBL
GtRIoZLXAEEFkVbL35vovHaMa5jwo1vS7YnEBXOxIG2fzEUONdVVIgEFLe2hCqBW
cSmoveGztyUyzoIjyBRHCRoT2M5UU+laHCeelA+lObhjzuPbCuBJscW2itODBZUG
7+hASJWj2wngKdmxjoGwlWolAIMhNCkTyQzDVqvgeBOQGXugkZ/f6+2heWC2+ZAe
73/5nQJ0i1s6H8cMLHCsSI0kpVf0mZYN1fkRTf1Sh4KO/Gt9Hk0J6wYlUD5wGjsN
wyDI9MPgdF+utDG3orIN5jhyArj0PYWmza51r7/EtTN8srnuynt2etWmRHYkIJof
cqJ/FWy2SzswNTLZqXv+7zvmcuGdm7jKloHRTs4Lzgiuc3qqAROnIPJYewTHcYLm
DEGnzZjssCMfB62PTpN3LPQqZY+mJIczg9qqd6TriwgNMmaQ/8dSRYyHYDff/j/Y
Q8KqjRgfszRFqqEliBW8a+nmjsdHbpxXrev+9vXiCLdrg5Cl+PYT0bW2pxEP393d
FBAbN+ucoGoG5oVnEMk/h0TuwAYRL9IeqT16ONWrY5g5V6nl8pWX/Eh1s9QD3R/g
lA77Q2xwmbqTmWVBO0nzIfxu1pvvzHCrnFrT8NQQXcz+eXqBIxo=
=sRIS
-----END PGP SIGNATURE-----
--=-=-=--

