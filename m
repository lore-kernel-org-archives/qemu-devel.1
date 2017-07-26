Received: from eggs.gnu.org ([2001:4830:134:3::10]:56667)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1daDTc-0004Lt-QQ
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 23:59:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1daDTb-0004Ab-JY
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 23:59:12 -0400
Date: Wed, 26 Jul 2017 13:52:40 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170726035240.GM8978@umbus.fritz.box>
References: <150100547373.27487.3154210751350595400.stgit@bahia>
	<150100549536.27487.11322702271540744350.stgit@bahia>
	<f278e478-83a7-0842-5cfb-f0582aec3b5d@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="pP0ycGQONqsnqIMP"
Content-Disposition: inline
In-Reply-To: <f278e478-83a7-0842-5cfb-f0582aec3b5d@ozlabs.ru>
Subject: Re: [Qemu-devel] [for-2.11 PATCH 01/26] spapr: move
 spapr_create_phb() to core machine code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>


--pP0ycGQONqsnqIMP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 26, 2017 at 01:32:41PM +1000, Alexey Kardashevskiy wrote:
> On 26/07/17 03:58, Greg Kurz wrote:
> > This function is only used when creating the default PHB. Let's rename
> > it and move it to the core machine code for clarity.
> >=20
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > ---
> >  hw/ppc/spapr.c              |   13 ++++++++++++-
> >  hw/ppc/spapr_pci.c          |   11 -----------
> >  include/hw/pci-host/spapr.h |    2 --
> >  3 files changed, 12 insertions(+), 14 deletions(-)
> >=20
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index 2a3e53d5d58c..53969315ac24 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -2142,6 +2142,17 @@ static void spapr_init_cpus(sPAPRMachineState *s=
papr)
> >      g_free(type);
> >  }
> > =20
> > +static PCIHostState *spapr_create_default_phb(sPAPRMachineState *spapr)
>=20
>=20
> Nit: you could get rid of the *spapr here.
>=20
> Anyway,
>=20
> Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--pP0ycGQONqsnqIMP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAll4EgYACgkQbDjKyiDZ
s5JOLw//Z+CvAO95JeuTpPF3w97xkFpmBAdwIEtu3cuFIqS+iAbQ7vVhpOgn0eUR
bo4+kg4/IrwOrxiXR09cZWNoPl8do6uu1H2o0XKptzlQfWxp3xa0cEQLLsHGWsIq
uWrad14Sbzv0E/NUfaqLhpFN4cDhjoy89kNhZMAlwOIKbpsrBL1HqzOGWBO7r9Sy
G0TrLHOyB27GhsMxlC40B/Grt9uBGlh0WSCsW4GGi4nND91dOFXheiK1xK5O/eck
xP2bhOkTJnv9RYo57KyyXOh8bJB9rA1SdXSHWvS9F15RzDWbVmGFrIAJ7YIcOiOl
GFP/f2zTyrXRCFCrVkCeVYiBbFh3dV0/NEJy2ZPC1k8imhuPr3YHt1VjnFkCOMOr
4fW3//CDA3zf9CCvJZnNvryfSpj8hkrPa5zkRZD4p5ZsfHLQJhMre2AmskB4gTVe
XU6xSBv9SNGf8fJbpLqE/aY+0IoYllxWq2VvAMH4nGYmnpfBvEMSREAhAW3A+ZYk
2dAiZyTcZOpZnlgRv5oKOedhPVkS74zQ4hxpEnvGnwPS/pXWvzMhczQkoXcbGyiF
JhIQj0Zl9dgaqgRU1wCAKcDkhoWg7E3Y6GDrio/MIsX8dONH1GpXAjEypu1c4c6r
fcz8BpHYynxYMjjr+jdUwsNuEsMSgawSyragwjpfxu5mkED8eQ8=
=0jrZ
-----END PGP SIGNATURE-----

--pP0ycGQONqsnqIMP--
