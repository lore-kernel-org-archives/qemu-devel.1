Return-Path: <SRS0=qU7A=VV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F050C76191
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 09:12:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AB3422ADF
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 09:12:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="AFgb730Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AB3422ADF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqDJd-0007JY-8E
	for qemu-devel@archiver.kernel.org; Wed, 24 Jul 2019 05:12:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41169)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hqDJK-0006SK-Bf
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 05:11:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hqDJJ-0005QC-2r
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 05:11:46 -0400
Received: from ozlabs.org ([203.11.71.1]:57525)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hqDJI-0005JK-0v; Wed, 24 Jul 2019 05:11:45 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45tqN55dtqz9sBF; Wed, 24 Jul 2019 19:11:33 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1563959493;
 bh=ecABDlLs7AqG7OoYm1WKQCXaArWZYEUKkdBa4cNCzNY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=AFgb730ZzUc30NF21KNtScCRED1HONyc/AK6tt0X7JDhhXgWkIYfHu23gTPnmtJx0
 K2zz7lp11jtno716uFyeNLg2OQOlZ6IOhll1CNv4s9/jSBMMS7K6nWv/8LY7CPBtGv
 J6EyXAyO41U5bAN8r+OiOLFxHNUqRP3TsWoNc474=
Date: Wed, 24 Jul 2019 18:57:30 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Message-ID: <20190724085730.GX25073@umbus.fritz.box>
References: <20190723090138.30623-1-clg@kaod.org>
 <20190724032308.GV25073@umbus.fritz.box>
 <0b80925b-c25b-04ee-2875-cbd155497a55@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="fqQSV+MVmQEkpBtA"
Content-Disposition: inline
In-Reply-To: <0b80925b-c25b-04ee-2875-cbd155497a55@kaod.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [PATCH] ppc/pnv: Generate phandle for the
 "interrupt-parent" property
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
Cc: Joel Stanley <joel@jms.id.au>, qemu-ppc@nongnu.org,
 Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--fqQSV+MVmQEkpBtA
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 24, 2019 at 09:11:54AM +0200, C=E9dric Le Goater wrote:
> On 24/07/2019 05:23, David Gibson wrote:
> > On Tue, Jul 23, 2019 at 11:01:38AM +0200, C=E9dric Le Goater wrote:
> >> Devices such as the BT or serial devices require a valid
> >> "interrupt-parent" phandle in the device tree and it is currently
> >> empty (0x0). It was not a problem until now but since OpenFirmare
> >> started using a recent libdft (>=3D 1.4.7), petitboot fails to boot the
> >> system image with error :
> >>
> >>    dtc_resize: fdt_open_into returned FDT_ERR_BADMAGIC
> >>
> >> Provide a phandle for the LPC bus.
> >>
> >> Suggested-by: Greg Kurz <groug@kaod.org>
> >> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> >=20
> > I've applied this, since it looks to be correct.
> >=20
> > But.. can you connect the dots for me in how this being missing
> > results in a BADMAGIC error??
>=20
> Some binary called by petitboot segfaults when trying to kexec an image o=
n=20
> a system with a bogus DT (generated by QEMU). I don't know exactly which =
one=20
> as I only see the error message above and the segv message in dmesg

Ok, I'm still not seeing how that gets you to a BADMAGIC error.

>=20
> I didn't notice before because I was using an old open-power-v2.1 image. =
I have
> switched to more recent ones now :
>=20
>   https://openpower.xyz/job/openpower/job/openpower-op-build/label=3Dslav=
e,target=3Dwitherspoon/lastSuccessfulBuild/
>   https://openpower.xyz/job/openpower/job/openpower-op-build/label=3Dslav=
e,target=3Dpalmetto/lastSuccessfulBuild/
>=20
> Btw, where could we keep some images of reference ? I have a couple of pa=
tches=20
> which enables the QEMU PowerNV machine to boot directly from the PNOR usi=
ng :
> =20
>   -drive file=3D./witherspoon.pnor,format=3Draw,if=3Dmtd
>=20
> Thanks,
>=20
> C.=20
>=20
> >=20
> >> ---
> >>  hw/ppc/pnv.c | 5 +++++
> >>  1 file changed, 5 insertions(+)
> >>
> >> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> >> index 36f57479a1f5..2deceecdccb5 100644
> >> --- a/hw/ppc/pnv.c
> >> +++ b/hw/ppc/pnv.c
> >> @@ -431,9 +431,14 @@ static void pnv_dt_isa(PnvMachineState *pnv, void=
 *fdt)
> >>          .fdt =3D fdt,
> >>          .offset =3D isa_offset,
> >>      };
> >> +    uint32_t phandle;
> >> =20
> >>      _FDT((fdt_setprop(fdt, isa_offset, "primary", NULL, 0)));
> >> =20
> >> +    phandle =3D qemu_fdt_alloc_phandle(fdt);
> >> +    assert(phandle > 0);
> >> +    _FDT((fdt_setprop_cell(fdt, isa_offset, "phandle", phandle)));
> >> +
> >>      /* ISA devices are not necessarily parented to the ISA bus so we
> >>       * can not use object_child_foreach() */
> >>      qbus_walk_children(BUS(pnv->isa_bus), pnv_dt_isa_device, NULL, NU=
LL, NULL,
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--fqQSV+MVmQEkpBtA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl04HXoACgkQbDjKyiDZ
s5K7uhAAy0rMz6eTtDft3/Uf4dXtkcvn3yTMRgir6Lb8GuEBDxhVvtXBBacqo1Hp
wEm4Xrl5izl4TetWA1aTrFgghYiTfvVO4sWF2AcfaHsmaiU/p6MjMOiovqIo/A+h
PNn9HcYFfapYp1uaJPMieISgcd+g49rwzl0nCciM1ytPIw/C1plkX/gZT9brwn+T
v75uuRSBEvoMlsSqsxraNGTOVsd2o/7BLjG+Ym+WsQhoLJyoMN0h1gh30Hv1jwux
xV/RGU2Qzo5bXuPDml7fmBtgIlYlugw6Uh7TRocfc+TTxbhhqWqQ2wW/Fdhuw6T5
ZO8u9EEx3wXaUywDaTJ4xrBveiaQB9Rw4GpedZnFwpzan55K1oEH75QKf69iYamX
0BTajHwjT8Pa6svfk30VZhy6B4lNnkJBO+fh9MP8ugo2xcPpqWdwSMmXZ1yc8PWJ
PTBWQgLbBl83+bygg0jCInJVSvY4CnwhyUaX50NrqBBRNh7YJ6c87mH6aujVqs8x
DDbz7qiVhEt50PB7yyBdnbaLy2rYJv84vE/XZxqxHmpFd/fZoDnJZFUZ6WVCeq8M
1u0GEXEb9+Ad6A1q/AfHgAbQW1qrb9snfWi7UYz0HB1oXxvSr2iqRyeeXAN08OMQ
X95YG9DbTjidaKLdiE7laG3ndLmP3RefzM5FW6jvCmrsj+0nYBI=
=H1Kc
-----END PGP SIGNATURE-----

--fqQSV+MVmQEkpBtA--

