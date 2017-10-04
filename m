Received: from eggs.gnu.org ([2001:4830:134:3::10]:60000)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dzis8-0000u2-Ci
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 08:33:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dzis3-00055x-Gv
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 08:33:56 -0400
Received: from 19.mo1.mail-out.ovh.net ([178.32.97.206]:32873)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dzis3-000555-7S
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 08:33:51 -0400
Received: from player756.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id 35219937C0
	for <qemu-devel@nongnu.org>; Wed,  4 Oct 2017 14:33:49 +0200 (CEST)
Date: Wed, 4 Oct 2017 14:33:43 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20171004143343.4a4c120e@bahia.lan>
In-Reply-To: <20171004094226.GX3260@umbus.fritz.box>
References: <150710659849.14714.9839994452901108634.stgit@bahia.lan>
	<20171004094226.GX3260@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/gpz8ntQ3ygc3CFSicUyW4vk";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH] spapr: fix RTAS method name in comment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>

--Sig_/gpz8ntQ3ygc3CFSicUyW4vk
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 4 Oct 2017 20:42:26 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Wed, Oct 04, 2017 at 10:43:18AM +0200, Greg Kurz wrote:
> > Signed-off-by: Greg Kurz <groug@kaod.org> =20
>=20
> Applied, except I corrected the short description.
> ibm,client-architecture-support is an OF word, not actually an RTAS
> method.
>=20

Oops you're right... not quite sure what I was thinking to when I wrote
that :)

> > ---
> >  hw/ppc/spapr.c |    3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index 352ff3d614e8..b284e0b9d43e 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -2334,7 +2334,8 @@ static void ppc_spapr_init(MachineState *machine)
> >      /* Set up Interrupt Controller before we create the VCPUs */
> >      xics_system_init(machine, XICS_IRQS_SPAPR, &error_fatal);
> > =20
> > -    /* Set up containers for ibm,client-set-architecture negotiated op=
tions */
> > +    /* Set up containers for ibm,client-architecture-support negotiate=
d options
> > +     */
> >      spapr->ov5 =3D spapr_ovec_new();
> >      spapr->ov5_cas =3D spapr_ovec_new();
> > =20
> >  =20
>=20


--Sig_/gpz8ntQ3ygc3CFSicUyW4vk
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQQr1DtEU17Ap5iU26IC/DrrAQHbwgUCWdTVJwAKCRAC/DrrAQHb
wkUPAKCKaAtACY0ImPew1+FT3nJCJYC2fQCdFm9/+4I9ljPMa4eCxf7+lcBvFEw=
=nJ/S
-----END PGP SIGNATURE-----

--Sig_/gpz8ntQ3ygc3CFSicUyW4vk--
