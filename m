Received: from eggs.gnu.org ([208.118.235.92]:50033)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gfHwe-0002ph-EC
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 00:23:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gfHwa-0002yw-6w
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 00:22:56 -0500
Date: Fri, 4 Jan 2019 16:16:15 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190104051615.GC2801@umbus.fritz.box>
References: <20181221054606.22007-1-david@gibson.dropbear.id.au>
	<20181221054606.22007-36-david@gibson.dropbear.id.au>
	<CAFEAcA9ZV0O7VohX-_S7mgerGU6Y+jAHMRgK9TB8tyBgBxbNOA@mail.gmail.com>
	<1f070fd5-1d27-36c7-6f86-d70be560cf57@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="JgQwtEuHJzHdouWu"
Content-Disposition: inline
In-Reply-To: <1f070fd5-1d27-36c7-6f86-d70be560cf57@kaod.org>
Subject: Re: [Qemu-devel] [PULL 35/40] spapr: extend the sPAPR IRQ backend
 for XICS migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-ppc <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, gkurz@redhat.com, Laurent Vivier <lvivier@redhat.com>


--JgQwtEuHJzHdouWu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 03, 2019 at 10:57:21PM +0100, C=E9dric Le Goater wrote:
> On 1/3/19 8:07 PM, Peter Maydell wrote:
> > On Fri, 21 Dec 2018 at 05:46, David Gibson <david@gibson.dropbear.id.au=
> wrote:
> >>
> >> From: C=E9dric Le Goater <clg@kaod.org>
> >>
> >> Introduce a new sPAPR IRQ handler to handle resend after migration
> >> when the machine is using a KVM XICS interrupt controller model.
> >>
> >> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> >> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> >> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> >=20
> >> @@ -1758,6 +1750,11 @@ static int spapr_post_load(void *opaque, int ve=
rsion_id)
> >>          }
> >>      }
> >>
> >> +    err =3D spapr_irq_post_load(spapr, version_id);
> >> +    if (err) {
> >> +        return err;
> >> +    }
> >> +
> >=20
> > Hi; this change causes Coverity to complain (CID 1398591) that
> > we're now overwriting the setting of err in the earlier
> >  err =3D spapr_rtc_import_offset(&spapr->rtc, spapr->rtc_offset);
> > without ever testing it. (We also do this in the existing
> > codepath that calls kvmppc_configure_v3_mmu().)
>=20
> yes. I suppose we have been missing something like :
>=20
> @@ -1754,6 +1754,9 @@ static int spapr_post_load(void *opaque,
>       * value into the RTC device */
>      if (version_id < 3) {
>          err =3D spapr_rtc_import_offset(&spapr->rtc, spapr->rtc_offset);
> +        if (err) {
> +            return err;
> +        }
>      }
> =20
>      if (kvm_enabled() && spapr->patb_entry) {

Yeah, looks like it.  Can you send a patch please?


>=20
>=20
> C.=20
>=20
> >=20
> > Should the call to spapr_rtc_import_offset() have its
> > own "if (err) do something" code, or should it simply
> > be ignoring its return value entirely, or something
> > more complicated ?
> >=20
> > thanks
> > -- PMM
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--JgQwtEuHJzHdouWu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwu7BoACgkQbDjKyiDZ
s5JNVw/+NJIMnQsbL+PT1pexu1Tq1pckhuWURyZIZN/h6rOSjX20T4O496piK3LJ
x+kDs5QIoEsfybRgdURhNCXOxAglSpYf5xJLJ9cXQBUh0TRWnSQ+du3eNzWHA7Db
srb3e2uSfoNOu0Vl8NaxUqGtFrCKoW8yts7vcWcoGusx6lVFfNHu+h3/m/qAyMKt
O5wipa/+LW//Umv4PsZqLkmdSO0Rv3mO9kgFiz3SZ8em40YP4aGK8IB1GYx03TXc
HmS8PqU2F9ijkYcKtDb0x9ooCNU1xklmgz/F7mFa7xFmFzbi8PIxmWGWb6I7TTCv
XA7ibPVvN/wFdtIbnst3JjouFr+R8o5iv5UtY2Vyo1VYMC/dYQn7/q0mZeH2WKEy
izHvaQWAVhIV2SxHdKE6hTOcsmU9buUFfQr+haiLcArBENbnjVfnFV4hPOYlaUhL
w5qZ4LBsGkgvFyHltUVfsDV4bqjuGiw3KdBNUt2xCTZwT0SKEQPTV3qhrhWugZPC
AEQ0Uw/p4dpdGvR1rh2VsKqqPAEoDhdLHyqfbsqWGsnBch+owSf0AB+Xx+z4a116
L7XQakSlDy9eUBanUyyrCSiQFz5yxYEeMU3gYUcHLBo3bFBKxZCxetQyfC8kCeIl
OzCotFHb8m42LVkeKZvD4uzMh+WqYJfmpT3LSQmx/EEpWqPIWWY=
=OYCy
-----END PGP SIGNATURE-----

--JgQwtEuHJzHdouWu--
