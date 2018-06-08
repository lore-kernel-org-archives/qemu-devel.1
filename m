Received: from eggs.gnu.org ([2001:4830:134:3::10]:52888)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fR8u3-0007ad-Rs
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 00:21:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fR8u0-0007dF-Oi
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 00:21:31 -0400
Date: Fri, 8 Jun 2018 13:29:49 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180608032949.GK3344@umbus.fritz.box>
References: <20180607165218.9558-1-david@redhat.com>
	<20180607165218.9558-6-david@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="DozTQjXnjm3C9Xhk"
Content-Disposition: inline
In-Reply-To: <20180607165218.9558-6-david@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v1 5/8] spapr: introduce machine unplug
 handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Greg Kurz <groug@kaod.org>


--DozTQjXnjm3C9Xhk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 07, 2018 at 06:52:15PM +0200, David Hildenbrand wrote:
> We'll be handling unplug of e.g. CPUs and PCDIMMs  via the general
> hotplug handler soon, so let's add that handler function.
>=20
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/ppc/spapr.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 4447cb197f..bcb72d9fa7 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -3586,6 +3586,11 @@ static void spapr_machine_device_plug(HotplugHandl=
er *hotplug_dev,
>      error_propagate(errp, local_err);
>  }
> =20
> +static void spapr_machine_device_unplug(HotplugHandler *hotplug_dev,
> +                                        DeviceState *dev, Error **errp)
> +{
> +}
> +
>  static void spapr_machine_device_unplug_request(HotplugHandler *hotplug_=
dev,
>                                                  DeviceState *dev, Error =
**errp)
>  {
> @@ -3988,6 +3993,7 @@ static void spapr_machine_class_init(ObjectClass *o=
c, void *data)
>      mc->get_default_cpu_node_id =3D spapr_get_default_cpu_node_id;
>      mc->possible_cpu_arch_ids =3D spapr_possible_cpu_arch_ids;
>      hc->unplug_request =3D spapr_machine_device_unplug_request;
> +    hc->unplug =3D spapr_machine_device_unplug;
> =20
>      smc->dr_lmb_enabled =3D true;
>      mc->default_cpu_type =3D POWERPC_CPU_TYPE_NAME("power8_v2.0");

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--DozTQjXnjm3C9Xhk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsZ+C0ACgkQbDjKyiDZ
s5IiuhAA2FewRuxTom6C+hLUCDwEexPd+Ep5zqWWN0K3JgpyqvXYXIr/INWgjDKI
ncP0tKk2qFMEd+MFKxrhyOw/vU5v2p8v4w6HDks2Z83UDy5ekKyWH1EGDE6OcEmc
puCtUFnbnkCMK/UYRmBN64o/5oDoyv88YKfn99XUw6q55aMWJofGizv7CZdpgdwr
M6M1RfjASNUVyQPK/f+5i5pgvmHntoZbUpHZKnQaouar7cUZ/BJwcXAfzCRpdy0z
BNgbYRpfjJKEP/pe+Fjv2KtmqZv3UILs8BmrC846ciUzS+95h5Uxzg37qmIwW4bf
aag6BE1mG8Bg9JWqhHQFbp81VtkJYBUHtkXZgEESb52gv/uRjB9bJ7dXg6UCdn7A
SdU2A6A2m3HwGb+cdg0bp47GFSravz8hPEWDXn7VwafR7QNV99YsSzTtwZaBKjhv
xi2ZLDoFKESJ3/z9J1mcbCub/ZLROFaHfBk0LFWvJbgeSjkOhqd9MHGbWNzgON/u
KzzBVWVx28YWxx/J0xxTcGVGVx656UAZ/KCRFLwFtCgo2fonYPld/MVrrow2qME9
tTyG+q2Ktefi5HKTyCQn5f5QIQRLRNpuG/cXVeM/4jBQ1jFdCHz9MyQu+uXU6jN3
3G4+8jHCgG1GFi4kESMlsiS8eu7kGmq7zwRvPUzgcVDbudbGrZo=
=wkCg
-----END PGP SIGNATURE-----

--DozTQjXnjm3C9Xhk--
