Return-Path: <SRS0=NHD5=ZG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95A5CC43141
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 17:44:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64526206DC
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 17:44:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64526206DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=keithp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVJAW-0006RA-Fz
	for qemu-devel@archiver.kernel.org; Thu, 14 Nov 2019 12:44:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38607)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <keithp@keithp.com>) id 1iVJ9C-0005PK-AY
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 12:43:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <keithp@keithp.com>) id 1iVJ9B-0008Kx-Bc
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 12:43:10 -0500
Received: from home.keithp.com ([63.227.221.253]:37774 helo=elaine.keithp.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <keithp@keithp.com>) id 1iVJ9B-0008KX-5X
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 12:43:09 -0500
Received: from localhost (localhost [127.0.0.1])
 by elaine.keithp.com (Postfix) with ESMTP id 3ECF83F29ADC;
 Thu, 14 Nov 2019 09:43:08 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at keithp.com
Received: from elaine.keithp.com ([127.0.0.1])
 by localhost (elaine.keithp.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 4PelEd9RSo2U; Thu, 14 Nov 2019 09:43:08 -0800 (PST)
Received: from keithp.com (koto.keithp.com [10.0.0.2])
 by elaine.keithp.com (Postfix) with ESMTPSA id EE52F3F29ADB;
 Thu, 14 Nov 2019 09:43:07 -0800 (PST)
Received: by keithp.com (Postfix, from userid 1000)
 id D1065158212B; Thu, 14 Nov 2019 09:43:07 -0800 (PST)
From: "Keith Packard" <keithp@keithp.com>
To: Alistair Francis <alistair23@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] Semihost SYS_READC implementation (v4)
In-Reply-To: <CAKmqyKNneo1NOn=mPmFmE-AxiaJPC2oiykZsW49Soiy=1aW__g@mail.gmail.com>
References: <89ada4b1-ee3d-a512-07c2-9bc1ba5806da@redhat.com>
 <20191024224622.12371-1-keithp@keithp.com> <8736fhm9tw.fsf@linaro.org>
 <87pnik4w9n.fsf@keithp.com>
 <CAFEAcA-g+RkvYjseDE=1Z=gnLum0Cjvn_7bqB3ti+cBq9UZ3Eg@mail.gmail.com>
 <87mudo4owu.fsf@keithp.com>
 <CAFEAcA-nnkHuj4y8+vFu5=virUoxwarg=kqQvUWeN73SDs+TzA@mail.gmail.com>
 <87eeymx603.fsf@keithp.com>
 <CAFEAcA9rSS8jwSOSFjHd7GZ0gNywEDDJPBJhJ4FxhyqqtjU6OQ@mail.gmail.com>
 <CAKmqyKNneo1NOn=mPmFmE-AxiaJPC2oiykZsW49Soiy=1aW__g@mail.gmail.com>
Date: Thu, 14 Nov 2019 09:43:07 -0800
Message-ID: <8736equzf8.fsf@keithp.com>
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
Cc: Atish Patra <Atish.Patra@wdc.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Alistair Francis <alistair23@gmail.com> writes:

> This sounds like something that the platform spec should contain.

I'm frankly happy with it specifying the semantics by reference to the
ARM docs -- that way we can easily share existing code without concern
about subtle semantic differences.

The only thing that would be useful is to clarify the low-level ABI
details about argument passing, but given that the ARM semihosting spec
passes arguments in the standard registers, extrapolating that to RISC-V
is not exactly difficult.

> +Atish +Palmer who are in charge of that.
>
> @Keith maybe you should contact the platform spec group and ask them
> to look into this?

I can certainly ask to have the argument passing details clarified; I
doubt that group would be interested in adopting the whole semihosting
spec and publishing it separately.

=2D-=20
=2Dkeith

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEw4O3eCVWE9/bQJ2R2yIaaQAAABEFAl3NkisACgkQ2yIaaQAA
ABHpvA//TWpV/tV8OsbsNV9GNGg60sbjOGcSkVuYDwTk2zlOob9QZkksraQGdZOH
c8CrVZ4B+Hu6rEb62wpXbsJ9z2bSjQ6CpACHjvgxSMoPJ0MyOUYpRAWAgRhRWz2w
eKabN4aU7D7n+vvEBHChJSFqU9UIpFiAX8kUvdev2cHoY0tU4KkZs6ZBeEm6skye
LSx4y5yRK/lRBSMRCEqAZyUY7mrp9c2ZRE/T7ZK4sw7zJwRtAs2Y3Tck30t9VceU
SA0LB4cWJ9SuG7qoSmVvQq5EsRmrHOc4RvrZH3e01rPa+iUXofHd4tqudPd5JavL
bhB5pQF06U5N0Hos+6BssnPGS9pFxwfUo0XWCaiz7KyG+02ggrXrEUZbXts5XKU4
ujiS4DKKarpw7skjTDuoCmyFJKKC4Zo5HDEcfI3GiQuQFaLY2To8Dmn8qq/O90c6
v61WDY8bXcHO6kzgdlO7lBpzkKhFJ57ax3Qf6FeLuetYSXS0J10RM20R5Qzx6z6g
ngQSJHLiMKrDsTLfomaeddb+Y4TVfq6zh8pq9qbs9k+uzAPdPnPnYHfRyhWTloqm
qOfqFPuEOm0LSjIV/ZYSURzhihuPVyH5pNmk/JpyRIIBc5TjKxrmpwW679GsSXVk
BPo2HFNdybqh0vC5Me17SGdKH2XQ+67FtxobIPUncYp0V56afGo=
=FNyt
-----END PGP SIGNATURE-----
--=-=-=--

