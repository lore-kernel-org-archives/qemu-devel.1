Received: from eggs.gnu.org ([209.51.188.92]:59150)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gylyq-0001KF-TF
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 18:17:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gylyp-00077u-SQ
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 18:17:44 -0500
Date: Wed, 27 Feb 2019 09:49:12 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190226224912.GQ6872@umbus.fritz.box>
References: <20190226030531.9932-1-sjitindarsingh@gmail.com>
	<20190226033914.GK6872@umbus.fritz.box>
	<1551162370.2210.0.camel@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="25rOlkxR6a4U87uN"
Content-Disposition: inline
In-Reply-To: <1551162370.2210.0.camel@gmail.com>
Subject: Re: [Qemu-devel] [QEMU-PPC] [PATCH 1/4] target/ppc/spapr: Add
 SPAPR_CAP_LARGE_DECREMENTER
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Cc: qemu-ppc@nongnu.org, clg@kaod.org, qemu-devel@nongnu.org


--25rOlkxR6a4U87uN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 26, 2019 at 05:26:10PM +1100, Suraj Jitindar Singh wrote:
> On Tue, 2019-02-26 at 14:39 +1100, David Gibson wrote:
> > On Tue, Feb 26, 2019 at 02:05:28PM +1100, Suraj Jitindar Singh wrote:
> > > Add spapr_cap SPAPR_CAP_LARGE_DECREMENTER to be used to control the
> > > availability and size of the large decrementer made available to
> > > the
> > > guest.
> > >=20
> > > Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
> > > ---
> > >  hw/ppc/spapr.c         |  2 ++
> > >  hw/ppc/spapr_caps.c    | 45
> > > +++++++++++++++++++++++++++++++++++++++++++++
> > >  include/hw/ppc/spapr.h |  5 ++++-
> > >  3 files changed, 51 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > > index b6a571b6f1..acf62a2b9f 100644
> > > --- a/hw/ppc/spapr.c
> > > +++ b/hw/ppc/spapr.c
> > > @@ -2077,6 +2077,7 @@ static const VMStateDescription vmstate_spapr
> > > =3D {
> > >          &vmstate_spapr_irq_map,
> > >          &vmstate_spapr_cap_nested_kvm_hv,
> > >          &vmstate_spapr_dtb,
> > > +        &vmstate_spapr_cap_large_decr,
> > >          NULL
> > >      }
> > >  };
> > > @@ -4288,6 +4289,7 @@ static void
> > > spapr_machine_class_init(ObjectClass *oc, void *data)
> > >      smc->default_caps.caps[SPAPR_CAP_IBS] =3D SPAPR_CAP_BROKEN;
> > >      smc->default_caps.caps[SPAPR_CAP_HPT_MAXPAGESIZE] =3D 16; /*
> > > 64kiB */
> > >      smc->default_caps.caps[SPAPR_CAP_NESTED_KVM_HV] =3D
> > > SPAPR_CAP_OFF;
> > > +    smc->default_caps.caps[SPAPR_CAP_LARGE_DECREMENTER] =3D 0;
> >=20
> > This looks basically fine, but the name kind of suggests it's a
> > boolean, whereas it's actually a number of bits.  I wonder if just
> > calling it "decrementer bits" would be clearer, with it defaulting to
> > 32.
>=20
> Yes, except there's a difference between a decrementer with 32 bits and
> a large decrementer with 32 bits...

Ok, and that difference is..?

> SPAPR_CAP_LARGE_DECR_NR_BITS?

That could work.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--25rOlkxR6a4U87uN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlx1wmYACgkQbDjKyiDZ
s5IclRAA2IjPHozau+3k5e0giJwLecNupQM2waFRsP/kSMs22BcYl7lXt6YC5S8o
QeYnuzahJDY2atHJ+5MxNhV/Bx6USSK3p63PzYgNgladIjdIMqVyukOGhYPbuzFe
uBswvc/Kgjbwr4E4qIBs+AjFyUJem3VFzPwnOThXKG9rOw2pfM7k2xX4Juc7hPNS
Idx5Htk/v/fBQn6hu79G5fSrXCXnV0Rhdae7UCUGQw2q63BwB6fYS56PVDtEqo3R
DP26Q9zNRGoO93sDsdfg4u48qENApIfDz5NyD40LitmJZxvxCNoE+opXwURT3+bz
D4WWdMpKJg3qDpJ28KMMmjuGvT0lyUorM/h2BdAFLiIy74RwfXQZt4gWb/TinQyk
lKcaPiGJ++wsVL3SO2QGo+TND4DIBV0knabt5IRtxxQS1AkneIhC+dTUafElY9Z4
s5dFu7g93Ucp+qiWNBHvDwyVotHeORP/rqKCMXP6wCy1FIy/7D16Z2TLrkR39W/2
xVrDkACo8tzgUvcZFSR7B4VuYgVkMs/2eb45lMBAM7H+L7JnuD9K3Wn8qGaRbiV0
N7EveAURdH4PHbNr4fMazVMm81DY7csUnMKfASETpyc72YaFQe4fTWOjq2ZBMRhV
qa4UJnvqGC1p/CZnmQYgo7aSX75QFG9NOOdv3Nwo12Srxw/xCrA=
=NM+q
-----END PGP SIGNATURE-----

--25rOlkxR6a4U87uN--
