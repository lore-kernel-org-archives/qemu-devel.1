Received: from eggs.gnu.org ([2001:4830:134:3::10]:60340)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1daDr9-0002Vp-Kl
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 00:23:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1daDr8-0005mX-KW
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 00:23:31 -0400
Date: Wed, 26 Jul 2017 14:07:21 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170726040721.GV8978@umbus.fritz.box>
References: <150100547373.27487.3154210751350595400.stgit@bahia>
	<150100559681.27487.12465113775325434061.stgit@bahia>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9o1Xi4ZMQ45MudWG"
Content-Disposition: inline
In-Reply-To: <150100559681.27487.12465113775325434061.stgit@bahia>
Subject: Re: [Qemu-devel] [for-2.11 PATCH 09/26] spapr_drc: pass object
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


--9o1Xi4ZMQ45MudWG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 25, 2017 at 07:59:56PM +0200, Greg Kurz wrote:
> From: Michael Roth <mdroth@linux.vnet.ibm.com>
>=20
> DRC objects attach themselves to an owner as a child
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
> - rebased against ppc-for-2.10
> ---
>  hw/ppc/spapr_drc.c |    1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
> index 105ce85b6d04..eb8024d37c54 100644
> --- a/hw/ppc/spapr_drc.c
> +++ b/hw/ppc/spapr_drc.c
> @@ -544,6 +544,7 @@ sPAPRDRConnector *spapr_dr_connector_new(Object *owne=
r, const char *type,
>      prop_name =3D g_strdup_printf("dr-connector[%"PRIu32"]",
>                                  spapr_drc_index(drc));
>      object_property_add_child(owner, prop_name, OBJECT(drc), NULL);
> +    object_unref(OBJECT(drc));
>      object_property_set_bool(OBJECT(drc), true, "realized", NULL);
>      g_free(prop_name);
> =20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--9o1Xi4ZMQ45MudWG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAll4FXkACgkQbDjKyiDZ
s5K6Qw//TtfzXEkGCFpJfNe0eT1oSSQYnOV6w2PO5SXemv0fOeIXZpT9Cegjsfts
b8dZSDQQY/Y9neLeS2qIecSGvmWHLmadgkZ0CZD+6f4XDa/fXyDXJRpMoLpwD+di
FaEfQkuKIkAbSxZVpgq728FWpPKE2wQ0+3YxzFNsfIPtMX1yBZFMsb1wWC9Mln7Y
fl7UgDoOhgUCMpk5hgBXL9bBPzZZ4cL3LprwZn69dk2aG6+JcipDB1ALxjTBHU+U
9k+CUQPu4/7r6pFPHS1ij3BkZeWDk0Jf20NSFam3/82OARcrWHfBmHlcqh8HIy5m
lYSldoprWUbAjULEKrd6rlAN08fOxR/GFjAEu59JmcmHfVuaoCmy8YtRtGRn+5zv
Tk+Zukywnaxbe58LHGXgpOH8+M5+MiddV5v2mOBS749/SiX2wWhDr1g4YEIz8i6C
uNuXZw2R9qzRMGdl9nK/RZLZ9gBZpIjH+NBSh5YTkWJwFxmHa30mp7GgilRbVR5n
x7k0wMFZ08plqqSpA960bMdAVDN8NjNrxAqZDyIwn689cCjNQR0K+fp5N9URk+N2
wp/HSZsI8K2u5b83E6pRx5noLKil+K2BRYhvFHnA0ahB2hdOh51RWt/ySEYtf0Q8
f41SlHYrODaYDqJVUBht57V05ey5pNuvg99ezthpkd04TpHy4ew=
=sxGV
-----END PGP SIGNATURE-----

--9o1Xi4ZMQ45MudWG--
