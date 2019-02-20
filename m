Received: from eggs.gnu.org ([209.51.188.92]:54018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gwIbX-0005dQ-Hy
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 22:31:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gwIbO-0003cM-M4
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 22:31:24 -0500
Date: Wed, 20 Feb 2019 14:28:19 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190220032819.GL9345@umbus.fritz.box>
References: <155059665292.1466090.8750653555749574947.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
	<155059671405.1466090.535964535260503283.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="cW0eHRJ76X8TDo3d"
Content-Disposition: inline
In-Reply-To: <155059671405.1466090.535964535260503283.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v5 12/17] spapr_events: add support for phb
 hotplug events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, Alexey Kardashevskiy <aik@ozlabs.ru>, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Dmitry Fleytman <dmitry.fleytman@gmail.com>, Thomas Huth <thuth@redhat.com>


--cW0eHRJ76X8TDo3d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 19, 2019 at 06:18:34PM +0100, Greg Kurz wrote:
> From: Michael Roth <mdroth@linux.vnet.ibm.com>
>=20
> Extend the existing EPOW event format we use for PCI
> devices to emit PHB plug/unplug events.
>=20
> Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> Signed-off-by: Greg Kurz <groug@kaod.org>

Applied, thanks.

> ---
>  hw/ppc/spapr_events.c |    3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
> index b9c7ecb9e987..ab9a1f0063d5 100644
> --- a/hw/ppc/spapr_events.c
> +++ b/hw/ppc/spapr_events.c
> @@ -526,6 +526,9 @@ static void spapr_hotplug_req_event(uint8_t hp_id, ui=
nt8_t hp_action,
>      case SPAPR_DR_CONNECTOR_TYPE_CPU:
>          hp->hotplug_type =3D RTAS_LOG_V6_HP_TYPE_CPU;
>          break;
> +    case SPAPR_DR_CONNECTOR_TYPE_PHB:
> +        hp->hotplug_type =3D RTAS_LOG_V6_HP_TYPE_PHB;
> +        break;
>      default:
>          /* we shouldn't be signaling hotplug events for resources
>           * that don't support them
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--cW0eHRJ76X8TDo3d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxsyVMACgkQbDjKyiDZ
s5LJnhAAn/n2tNkhZB+wsUkBIMV5f7Pi7W4dqQBRWuS/l7XykHOwAZ3nyFyzJGZr
Ze9V9LUpx3M39VhPovikdScCVxmRaGJgzDpq90BXMLJ0uZwDvIr7uQBej9LN80aW
wS5abBjO6O+bhIEnevLumP27h78ItNf54/jSQ/iSxeSVP025HsnYH/N0lmYoxwji
DsFJ9nfMun9CodX9qSnc0isnGxHiOgxXd4Z88ktnzom8DAN57fa673Aen5h2kE9v
HSvdi7cNcy7xLWGgm+sB5CDFbxtOQDGecX8VRQAiOvWPqN7cVRKsAoR7k6LdVhyI
GLlPkPtsTkRQR8BKQ8WlJ0ELI+Ma/SMQHpA3g2Gz32gZxZUXFDbQJ7xTwpJSkoEk
GK70PV0GNRLe1KI52OkVwH9RTRnsyzehZtpA2cW+MIZtsyrb/GOo763nqfxcFDDr
/gZCZUAzs6hzU90vpwHoOgwiRSl419NwBWEfNl1iCKYDpGdyz5gtjKojYJxtrp7e
Jgkix6V20apdQVTz6Hs6FSkl3xwWcVlcULEd/9/uAkg3VQnm2SbNe6wON8SaFp3r
sBVuGpki2FUeJbnuq/OQWydyjNINa6kB+qje2qNvGzqqOFNughY26n2Y8pgHE/RM
jPlafsFPteNtQrFoCduvpNWc4TU2bXK/5glzlxxc91E1foDpnlk=
=qu/7
-----END PGP SIGNATURE-----

--cW0eHRJ76X8TDo3d--
