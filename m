Received: from eggs.gnu.org ([2001:4830:134:3::10]:42365)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gSEBH-0004aV-7c
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 23:44:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gSEBF-0008Mk-QA
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 23:44:03 -0500
Date: Thu, 29 Nov 2018 15:11:07 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181129041107.GG14697@umbus.fritz.box>
References: <20181116105729.23240-1-clg@kaod.org>
	<20181116105729.23240-32-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="UKNXkkdQCYZ6W5l3"
Content-Disposition: inline
In-Reply-To: <20181116105729.23240-32-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v5 31/36] spapr/xive: export the
 spapr_xive_kvm_init() routine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>


--UKNXkkdQCYZ6W5l3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 16, 2018 at 11:57:24AM +0100, C=E9dric Le Goater wrote:
> We will need it to initialize the KVM XIVE device globally from the
> machine when the XIVE interrupt mode is selected.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

This is so trivial, I think it's better to fold it into the patch
which uses it.

> ---
>  include/hw/ppc/spapr_xive.h | 2 ++
>  hw/intc/spapr_xive_kvm.c    | 2 +-
>  2 files changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
> index fa7f3d7718da..1d134a681326 100644
> --- a/include/hw/ppc/spapr_xive.h
> +++ b/include/hw/ppc/spapr_xive.h
> @@ -107,4 +107,6 @@ void spapr_xive_mmio_map(sPAPRXive *xive);
>  #define TYPE_XIVE_TCTX_KVM   "xive-tctx-kvm"
>  #define XIVE_TCTX_KVM(obj)   OBJECT_CHECK(XiveTCTX, (obj), TYPE_XIVE_TCT=
X_KVM)
> =20
> +void spapr_xive_kvm_init(sPAPRXive *xive, Error **errp);
> +
>  #endif /* PPC_SPAPR_XIVE_H */
> diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
> index b9fee4ea240f..cb2aa6e81274 100644
> --- a/hw/intc/spapr_xive_kvm.c
> +++ b/hw/intc/spapr_xive_kvm.c
> @@ -809,7 +809,7 @@ static void spapr_xive_kvm_instance_init(Object *obj)
>                                NULL);
>  }
> =20
> -static void spapr_xive_kvm_init(sPAPRXive *xive, Error **errp)
> +void spapr_xive_kvm_init(sPAPRXive *xive, Error **errp)
>  {
>      Error *local_err =3D NULL;
>      size_t tima_len;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--UKNXkkdQCYZ6W5l3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlv/ZtsACgkQbDjKyiDZ
s5ICKQ/6An3HNVPJ+SyuGCjBxD7+c82SpnHB7ky/EbJSeYtvmw3BuqU92WuJ3wE1
LIRyIVo5xLPOLljcr/mwwE3Yl6WKMyxMYU2/CY7ftJtftw2YOHiSiRQeYDSmDHfY
4caCgJIgDRwgU2XKFpvFOvseX+4qqZXnjjBxHFqdyNQsiKUuoQr25Yfka9dy66T/
l4uaXyvK7dGnIxG3nag6rCcOumOC7YPtRYSXpWsGwkcB4hZXBDuEp9NJpFaAExwp
P2eY1K3JdEhuOLhRHF9sMa7jVsnK+ARxiKNw+wx/+KVQWG8mkt/Y09H+7zKNuN+w
Q1CtCT/4tTwqe+S3XIwx8BqnQElSOAZ6hnlp4fiZHYXYMLxArCT9/1jr4p5P9ItM
mnerswLghE7kbshubCi5qlC+/ijKkZ3JHqHePAj3fhEIBDnbBABnut6TAP+vzfIL
w5pKDh7IxNXAldjZTIfc/ElEYFpLCg2kBMKix7EOqlnJNFcYzQFC+B19kW+ulT/y
0f9BvHz4znqlzug8fnP5KGfQXopcQItks509UM5MbNGHNAf/hGKulRGuM7pxb09U
saVdwsYRVFr8kJVv2nRfjlh9DQkYgQkwjtf9nkiNFxbJT0RWHLM6PU2TfIrpnzMY
GRq0FhYP/spIk+5qF3FRZ/c6xj6GyHoImocoaoJX/vametemqGs=
=tVa6
-----END PGP SIGNATURE-----

--UKNXkkdQCYZ6W5l3--
