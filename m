Return-Path: <SRS0=zNqU=ZC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DA6AC17442
	for <qemu-devel@archiver.kernel.org>; Sun, 10 Nov 2019 21:12:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16FC9206C3
	for <qemu-devel@archiver.kernel.org>; Sun, 10 Nov 2019 21:12:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="NZ4kBzEU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16FC9206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iTuVY-0000Iv-PP
	for qemu-devel@archiver.kernel.org; Sun, 10 Nov 2019 16:12:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55953)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iTuU9-0007FO-Ss
 for qemu-devel@nongnu.org; Sun, 10 Nov 2019 16:11:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iTuU8-0004lF-Kg
 for qemu-devel@nongnu.org; Sun, 10 Nov 2019 16:11:01 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:34107 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iTuU6-0004Tt-M1; Sun, 10 Nov 2019 16:11:00 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47B69h1WVCz9sPV; Mon, 11 Nov 2019 08:10:47 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1573420248;
 bh=dPLpKbVSRM7C2r1HJoFAQmTeJAQlAkxtorMSpk1OMVo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=NZ4kBzEUZgs6QChY4UvrZZXqHSoAvx/+sMOyO8nPI8bzniePWCMUn/S5GSvvdswQb
 MadIeWSpDDPtYGUkaoQ4kKdaF2y2hNI/DncsjxzFEo2Jyz12VRZDxPVbxSKD/5Pl/k
 E2HRidJHf1KzvA4+st46EVAYzRzt2tw8c1f1VC8s=
Date: Sun, 10 Nov 2019 21:10:33 +0000
From: David Gibson <david@gibson.dropbear.id.au>
To: Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH] RISC-V: virt: This is a "sifive,test1" test finisher
Message-ID: <20191110211033.GU2461@umbus.Home>
References: <CAFEAcA8k+t2qKCSvMjENitvCXyc-qwiG2qbg6gQFKR_+v_zihg@mail.gmail.com>
 <mhng-3242a5ea-9d0c-49fb-bcf6-d8482328b272@palmer-si-x1c4>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="oGy11dVowAZA6eXT"
Content-Disposition: inline
In-Reply-To: <mhng-3242a5ea-9d0c-49fb-bcf6-d8482328b272@palmer-si-x1c4>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 203.11.71.1
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-riscv@nongnu.org,
 palmer@sifive.com, qemu-devel@nongnu.org,
 Christoph Hellwig <hch@infradead.org>, alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--oGy11dVowAZA6eXT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 08, 2019 at 10:13:16AM -0800, Palmer Dabbelt wrote:
> On Fri, 08 Nov 2019 10:04:47 PST (-0800), Peter Maydell wrote:
> > On Fri, 8 Nov 2019 at 17:15, Alistair Francis <alistair23@gmail.com> wr=
ote:
> > >=20
> > > On Fri, Nov 8, 2019 at 9:05 AM Palmer Dabbelt <palmer@sifive.com> wro=
te:
> > > >
> > > > The test finisher implements the reset command, which means it's a
> > > > "sifive,test1" device.  This is a backwards compatible change, so i=
t's
> > > > also a "sifive,test0" device.  I copied the odd idiom for adding a
> > > > two-string compatible field from the ARM virt board.
> > > >
> > > > Fixes: 9a2551ed6f ("riscv: sifive_test: Add reset functionality")
> > > > Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
> > > > Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
> > > > ---
> > > >  hw/riscv/virt.c | 5 ++++-
> > > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> > > > index 23f340df19..74f2dce81c 100644
> > > > --- a/hw/riscv/virt.c
> > > > +++ b/hw/riscv/virt.c
> > > > @@ -359,7 +359,10 @@ static void create_fdt(RISCVVirtState *s, cons=
t struct MemmapEntry *memmap,
> > > >      nodename =3D g_strdup_printf("/test@%lx",
> > > >          (long)memmap[VIRT_TEST].base);
> > > >      qemu_fdt_add_subnode(fdt, nodename);
> > > > -    qemu_fdt_setprop_string(fdt, nodename, "compatible", "sifive,t=
est0");
> > > > +    {
> > > > +        const char compat[] =3D "sifive,test1\0sifive,test0";
> > >=20
> > > Does this really work? Why not use qemu_fdt_setprop_cells()?
> > >=20
> > > Alistair
> > >=20
> > > > +        qemu_fdt_setprop(fdt, nodename, "compatible", compat, size=
of(compat));
> > > > +    }
> >=20
> > qemu_fdt_setprop_cells() is for "set this property to
> > contain this list of 32-bit integers" (and it does a byteswap
> > of each 32-bit value from host to BE). That's not what
> > you want for a string (or a string list, which is what
> > we have here).
> >=20
> > Cc'ing David Gibson who's our device tree expert to see if there's
> > a nicer way to write this. Oddly, given that it's used in the
> > ubiquitous 'compatible' prop, the dtc Documentation/manual.txt
> > doesn't say anything about properties being able to be
> > 'string lists', only 'strings', '32 bit numbers', 'lists of
> > 32-bit numbers' and 'byte sequences'. You have to dig through
> > the header file comments to deduce that a string list is
> > represented by a string with embedded NULs separating
> > each list item.
>=20
> I copied this from hw/arm/virt.c, but messed up.  There they use
>=20
>        const char compat[] =3D "arm,armv8-timer\0arm,armv7-timer";
>        qemu_fdt_setprop(vms->fdt, "/timer", "compatible",
>                         compat, sizeof(compat));

I'm not sure what you're saying is messed up.  AFAICT, this matches
the code you have above, and both should be correct.

> I'll send a v2, but I'd be happy to add some sort of setprop_stringlist
> function.  Maybe we just indicate the length with two '\0's?  IIRC that's
> how other similar-looking data structures are encoded.
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--oGy11dVowAZA6eXT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl3IfMgACgkQbDjKyiDZ
s5Iy2RAAt3YXZOqcT47TtaZIOVsv93SI1qBvIvw24mQfVd7owu7HLXjkg5F/DXZF
o5NSHeoNOrW/FC9c0ZH8AmWRQirPxstNKKmmL5v4C/E17d/ny/wYtX0SmF7fGq5V
RN6FARFfHAepOJvxnNzVokn2Fn5/MPlV5KZ8prImWy/boPPcTuqlYHugWdPvQ9PT
3Psu6qB2Rp+97+6vh50vqCXw2ApF4uggjxKno8q1BfqV9nLGaspbxxgbM7IJLGVf
rUji2S5dXmCUlX0NNk7aVFB5EoKBKL9g2qsK57E/qgzZUwnSE7DoVrFsqkCW39qZ
dbTo+E+gGhLB7gK16RtC4NjVt9zniKtUz5nFBzdyuRm/CYktTBDC9NSW9m0XqDNU
MflwzN3xKXKNvBdwDk4mW/UU3ZbmBEpNUgs5BVJGj63LabYcJSdIO9T5+FH4UW0t
tsmhaUELfn09Eo9JU1nS6epFQFA/B/KuH8l96i1Xe1oNyz1cKK7B/jmpz8BsJBAL
Qf7EmuIbXWkYPMou403fPEOTaBmlO9CrGul89BsiuWNOhedoRRvzdKoIlS5Squ3J
mJkjzzjDqPEKO/ww45ok3RmN3KxSGkX9YDN/5VqlErKHiyzx5UjWHJri2qASP+Ri
IAQJltgKyfNwcfN1PLylnRkCxehNGgYQ23U+i2X94qRxvxSgNTo=
=41z9
-----END PGP SIGNATURE-----

--oGy11dVowAZA6eXT--

