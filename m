Received: from eggs.gnu.org ([209.51.188.92]:46649)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gzCnt-00044F-Ni
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 22:56:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gzCns-0005nM-Bg
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 22:56:13 -0500
Date: Thu, 28 Feb 2019 14:50:56 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190228035056.GC27799@umbus.fritz.box>
References: <20190227043008.12059-1-sjitindarsingh@gmail.com>
	<20190227061611.GB6872@umbus.fritz.box>
	<1551309360.2210.16.camel@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="XWOWbaMNXpFDWE00"
Content-Disposition: inline
In-Reply-To: <1551309360.2210.16.camel@gmail.com>
Subject: Re: [Qemu-devel] [QEMU-PPC] [PATCH v2 1/4] target/ppc/spapr: Add
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


--XWOWbaMNXpFDWE00
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 28, 2019 at 10:16:00AM +1100, Suraj Jitindar Singh wrote:
> On Wed, 2019-02-27 at 17:16 +1100, David Gibson wrote:
> > On Wed, Feb 27, 2019 at 03:30:05PM +1100, Suraj Jitindar Singh wrote:
> > > Add spapr_cap SPAPR_CAP_LARGE_DECREMENTER to be used to control the
> > > availability of the large decrementer for a guest.
> > >=20
> > > Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
> >=20
> > This series looks good now, except for one nit...
> >=20
> > > ---
> > >  hw/ppc/spapr.c         |  2 ++
> > >  hw/ppc/spapr_caps.c    | 17 +++++++++++++++++
> > >  include/hw/ppc/spapr.h |  5 ++++-
> > >  3 files changed, 23 insertions(+), 1 deletion(-)
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
> > ... since this is now a boolean, it should use SPAPR_CAP_OFF /
> > SPAPR_CAP_ON instead of bare 0 and 1.
>=20
> True, do you want me to fix-up and resend? Or can you fix it when you
> apply?

Fix and resend, please.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--XWOWbaMNXpFDWE00
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlx3WqAACgkQbDjKyiDZ
s5JkhxAAvLhhjobCD/ULKQw3+sPaUNSYrX1FEcAQ+2Je9L2RsHjaVCNDxy/GqUK1
b0FsL2QBDz2TZhUlb1RORrOxyGZjTafMf7yWNody+K4od7skUc2uO2MTI8rwSOfC
4AW3SilrHiDUVneTRcyKdc+Dac1KgFcm1iP8iod6LNyVVrnbAv+i3BX9BJisuk2M
I71ZEvAlxeiyc2BDa5+lfBJrKBpZttjTv+b2Rs8D8GT5++gLA89tYMhaMjDUKaen
eTkGiajL2xBkplzm0jMLeE55G03NQyX4W0ui1+gxOHI9A4rkvIPUTxV2sWcaTnzy
u7pkLyqUD7a+hC3opEtR7ZkzUSDnGYV76ecxfg9Jb3qR0x1Ebsq6aR89/WX74AUt
Has1YXJg6nuwLbppDrSUenpUORc3zstpza1pn4t8dtNswuZV2zWsa8VZ5tvJvrL8
6L5cRamipP3sADgWSQwhdnEmcz/ja2Wn1mF2urTea3IedZbXQ+UA2j7BSkGpgCp6
FhW0BHecFJkyAkdPWK5XQ9hvHwarC5qVJfpFbU0acLSAq1estkg3O1Sr1CcB/m68
YcD6wgtltgQipv9sehVNOlKxsdoBx07ofllYuSz6rodfEOIzgWG584mnAa7PZ4Zc
+ZGgrQoCjnrYLrv8DtWygxR6rAnD6IlJO36WmS9SgkaPZSB6g04=
=5pXl
-----END PGP SIGNATURE-----

--XWOWbaMNXpFDWE00--
