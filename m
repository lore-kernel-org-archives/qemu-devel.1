Received: from eggs.gnu.org ([2001:4830:134:3::10]:54466)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fSX9g-0006qn-LY
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 20:27:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fSX9d-0002qD-CK
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 20:27:24 -0400
Date: Tue, 12 Jun 2018 10:21:51 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180612002151.GJ2737@umbus.fritz.box>
References: <20180611121655.19616-1-david@redhat.com>
	<20180611121655.19616-2-david@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="M9pltayyoy9lWEMH"
Content-Disposition: inline
In-Reply-To: <20180611121655.19616-2-david@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v1 01/11] pc-dimm: remove leftover "struct
 pc_dimms_capacity"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Alexander Graf <agraf@suse.de>


--M9pltayyoy9lWEMH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 11, 2018 at 02:16:45PM +0200, David Hildenbrand wrote:
> Not needed anymore, let's drop it.
>=20
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/mem/pc-dimm.c | 5 -----
>  1 file changed, 5 deletions(-)
>=20
> diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
> index 12da89d562..62b34a992e 100644
> --- a/hw/mem/pc-dimm.c
> +++ b/hw/mem/pc-dimm.c
> @@ -27,11 +27,6 @@
>  #include "sysemu/numa.h"
>  #include "trace.h"
> =20
> -typedef struct pc_dimms_capacity {
> -     uint64_t size;
> -     Error    **errp;
> -} pc_dimms_capacity;
> -
>  void pc_dimm_memory_plug(DeviceState *dev, MachineState *machine,
>                           uint64_t align, Error **errp)
>  {

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--M9pltayyoy9lWEMH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsfEhoACgkQbDjKyiDZ
s5LBThAAl0lM4t/Z8aqmljrNRMrjRHucP3ONHf7BE1wLLx2QsN89rz2qSB9eV1Kl
vfnXhjxmQ8SdtVssXqAfSXH7lJSvuSdifg3KOECooI9WSY3en9HU3FERoXhqTXR+
YGHfR1Uo8CHHvyXSmM4HGALJcY7+YdUc58cdXv6XcmrMLhQp0KSLzKomFqZtp4TS
BsZnjlfavd6I0EaVsyrEe6tvEnwhwiwy8C1E4i6XyeCVbcbI0gfl4R0Rx6K6wZ9K
Qnt7uORMq8obSBlfv5W6wQ/J2POmLp/kULC2ja/AOmwX3DqrWwg37+6pYBVekfju
ENINc5vwq+cOK3tnowzI0+bdIASw92S4cUBc4qVV4ZDDC0pYHb/vVPX57aFM+CPR
yjhurP0hVEph/0tP0f+nU6SQM+pCEo4iFwLCeDrKWm2h8jkKVjncMyJB2Pd8pFN7
+mPGtO1spEP2wPRU8ZvpIeVjGE9g2zUAJj94A/740xeKshMVzZR0mrpl50+Vc6Ne
eCW52X41s9MOEmenav4ixeM7NGozx1KSGx3oS/qrYfbyDh+CI1Id+eZTkanYzgEd
U5bQMwMvaImC8FaZETA4Qpm6XZvtUbmoInjZrrN4MxxxtLUvXxaltKFkxdkUrU/D
GCiJAzD2RrBuBbyqlfot6eTYUZnz8YlSb1X6k4Eo6Js54Rr7lEI=
=MGqc
-----END PGP SIGNATURE-----

--M9pltayyoy9lWEMH--
