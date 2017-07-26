Received: from eggs.gnu.org ([2001:4830:134:3::10]:60372)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1daDrA-0002Wt-La
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 00:23:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1daDr9-0005n6-Eg
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 00:23:32 -0400
Date: Wed, 26 Jul 2017 14:08:37 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170726040837.GW8978@umbus.fritz.box>
References: <150100547373.27487.3154210751350595400.stgit@bahia>
	<150100560947.27487.8779404117672050454.stgit@bahia>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="OFtM20PmL5gDcvsL"
Content-Disposition: inline
In-Reply-To: <150100560947.27487.8779404117672050454.stgit@bahia>
Subject: Re: [Qemu-devel] [for-2.11 PATCH 10/26] spapr_iommu: pass object
 ownership to parent/owner
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>


--OFtM20PmL5gDcvsL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 25, 2017 at 08:00:09PM +0200, Greg Kurz wrote:
> From: Michael Roth <mdroth@linux.vnet.ibm.com>
>=20
> TCE table objects attach themselves to an owner as a child
> property. unref afterward to allow them to be finalized
> when their owner is finalized.
>=20
> Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> Signed-off-by: Greg Kurz <groug@kaod.org>

Applied to ppc-for-2.11.

> ---
> Changes since RFC:
> - s/DRC/TCE table/ in changelog
> ---
>  hw/ppc/spapr_iommu.c |    1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/hw/ppc/spapr_iommu.c b/hw/ppc/spapr_iommu.c
> index d4eca2a77225..8ec4e7a40834 100644
> --- a/hw/ppc/spapr_iommu.c
> +++ b/hw/ppc/spapr_iommu.c
> @@ -321,6 +321,7 @@ sPAPRTCETable *spapr_tce_new_table(DeviceState *owner=
, uint32_t liobn)
>      tmp =3D g_strdup_printf("tce-table-%x", liobn);
>      object_property_add_child(OBJECT(owner), tmp, OBJECT(tcet), NULL);
>      g_free(tmp);
> +    object_unref(OBJECT(tcet));
> =20
>      object_property_set_bool(OBJECT(tcet), true, "realized", NULL);
> =20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--OFtM20PmL5gDcvsL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAll4FcQACgkQbDjKyiDZ
s5JY+hAAprlb8FHRmS4uTu8SxgqauOpdfsp1bUasJSR6TH9RR3uqUAyaqgD8RWed
C/WR6xDov5KKMjU5KZ6nP3BtoJaC8+lWU1Nnud5iUR401y3Nt6FI8SsGkW0LCX4R
DnKeIlvZemW/orsmS3OkfrBB+ST6V9kvUJC/gc/GYkun/oMU+gwthbfGb6AI5OZE
V5duiVZcsdggoX24Dk2iT7CItsi82p8hGhSwVhL5RAxFw0BmsSM3HSWGB/cmE28A
90KT5G9gsqaU3NRzeQkP9JxNMDKmaO6yuRM4oIs1srXVKsfoBsQdmjhRnABdXOpc
ZwvwCNBVY+NNMeq+o1KGvO2q+DNe6gNj7qUEh1y9f0bZqsuHYJm2RpcnnGXBCDgQ
WY9SlVTEj9TseoznrfHpWqJcbbGngToNgEV/keiO+x+ItJ9HAYyTBjPAXVNuSeno
m5Y+5WVf0SOHTdteb0dNX0BM4NA5sz5JGL3C4KsEqYLaUWfZov3jA8FYHJePnmsS
oZbNL+esLqoNhCQKsXgOu0YZDCaKvU9B20PGV6b5M7GiTSavaOl9dRObMTNKEAzX
fJ7uQApYmRRCWwRKE6NVsFawntqUuE1GNWipbJEeKmAYWpuGbj2nIV2tj7YLrzIZ
7b/RcbUbJgV0YyrAoJxMackYkt7jk6cFE2ZSSmd7X19U7/I1kEc=
=75Gm
-----END PGP SIGNATURE-----

--OFtM20PmL5gDcvsL--
