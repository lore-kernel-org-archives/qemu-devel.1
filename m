Received: from eggs.gnu.org ([2001:4830:134:3::10]:36078)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gKio7-0006rP-8c
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 06:49:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gKio2-0007SY-C6
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 06:49:07 -0500
Received: from 14.mo3.mail-out.ovh.net ([188.165.43.98]:59033)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gKio2-0007I2-3R
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 06:49:02 -0500
Received: from player732.ha.ovh.net (unknown [10.109.146.163])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 4C5131E4471
	for <qemu-devel@nongnu.org>; Thu,  8 Nov 2018 12:48:54 +0100 (CET)
Date: Thu, 8 Nov 2018 12:48:45 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20181108124845.25053d19@bahia.lan>
In-Reply-To: <20181107044635.GE5575@umbus.fritz.box>
References: <153933509870.3834759.13291133122604475240.stgit@bahia.lan>
	<153933511983.3834759.10815543413375425072.stgit@bahia.lan>
	<e77c6869-d89e-c5df-c43f-a2b5df3fbf59@ozlabs.ru>
	<20181107044635.GE5575@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	boundary="Sig_/eT5Cl26v.syNLts7Q6Qy33z";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH v2 2/2] spapr_pci: rename some structured
 types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>

--Sig_/eT5Cl26v.syNLts7Q6Qy33z
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 7 Nov 2018 15:46:35 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Mon, Oct 15, 2018 at 12:49:53PM +1100, Alexey Kardashevskiy wrote:
> >=20
> >=20
> > On 12/10/2018 20:05, Greg Kurz wrote: =20
> > > According to CODING_STYLE, structured types names are expected to be
> > > in CamelCase but we have:
> > >=20
> > > typedef struct spapr_pci_msi {
> > >     uint32_t first_irq;
> > >     uint32_t num;
> > > } spapr_pci_msi;
> > >=20
> > > typedef struct spapr_pci_msi_mig {
> > >     uint32_t key;
> > >     spapr_pci_msi value;
> > > } spapr_pci_msi_mig;
> > >=20
> > > Acronyms are often written in upper-case, but here we would en up with
> > > a lot of upper-case letters in a row (ie, sPAPRPCIMSI) which defeats =
the
> > > purpose of CamelCase. It even displays "RPC" which looks awkward. =20
> >=20
> > Yet more common than this. I vote for sPAPRPCIMSI as PCI is an acronym.
> > "pci" is small letters hurts my eyes :) =20
>=20
> Hrm.  So, yes, I know I kind of started it, but these various
> compromises about how to captialize things means this patch is now
> "change from non-camelcase to.. something that's also not really
> camelcase".
>=20
> At which point I'm not particularly convinced it's worth the bother.
>=20
> If we really want to go ahead with CamelCasing this, I think we'd need
> to start by fixing up the existing sorta-camelcase-but-not-really
> stuff to actual camelcase.  Which would mean the slightly odd reading
> "Spapr" and "Pci" and "Msi" and so forth, but it might be worth it for
> consistency.
>=20

Looking at sPAPR only we already get:

$ git grep sPAPR | wc -l
1070

I understand your point but this would cause a lot of changes,
ie, a lot of noise in git blame and probably harder backports
of subsequent commits... I guess it isn't worth the pain.

Maybe we can just forget this patch and live with this minor
coding style violation. :)

--Sig_/eT5Cl26v.syNLts7Q6Qy33z
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAlvkIp0ACgkQcdTV5YIv
c9aoMw//Tux7eQmr4iuQI2n5iHQtCohbc6GApnNaW4BQtGqKkgjf6Bc4OdKsMDca
VHJZ11a78iuaWvhxW1IDHLTRGhOWxct+BYS71PAkpJmgCpCR3ZDRTfDfyT33ubpU
wW0+BmRQnVUSyoU2i5zKhse/vU6AAA7YSf4NB3T/rfGDCh9lJI/q7vn5qJDmzc7Q
Wim1F9f5HNIHvosRL5WTtGgPalFTa7D0l705qHiCAlMLAQdTijAEGyY9dDcqb5KB
CEVhABwtyVmNoRsTmEtO+FSKOJvrv50YesYsJgYUud+V3U5FVWRBhjWlglYkIZ8t
48QeHVfuGyAl+fL+cmp+XlEC8HoVBzIiIwTmpXPT68gFFKdas60wXO3uHj4y83cA
2lIcUrcHLxdYFPUn+1JBJr6omFE1kSANpepY/DzuVGLX3gpTsi3C+UC7NJaBW8mR
LAEMvPj1vT7/1DLFRdWAVURAomU8n4C4tKlrtmA9/ZQAX8x473TpRXX5pQnzhog1
pFfG8RFM/G2uMH20pDRr2meqIZALLHM80QXImbqUdNn1Lc33YJa1/HsKgHhP17Sc
tQZDeytJ6f2rR/DDWDyIfBtIcRIdy6QcObNght9Nt3s9NKdw3usf/VuKlpLFtkdX
KfXJgvlBa8Qg/TbgBhw3lQuBQ1mUZlDEO8CauYhkjqpvvijZN3I=
=BXni
-----END PGP SIGNATURE-----

--Sig_/eT5Cl26v.syNLts7Q6Qy33z--
