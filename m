Received: from eggs.gnu.org ([2001:4830:134:3::10]:52851)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fR8u1-0007aH-RI
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 00:21:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fR8u0-0007d8-OY
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 00:21:29 -0400
Date: Fri, 8 Jun 2018 13:28:08 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180608032808.GH3344@umbus.fritz.box>
References: <20180607165218.9558-1-david@redhat.com>
	<20180607165218.9558-3-david@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="OgApRN/oydYDdnYz"
Content-Disposition: inline
In-Reply-To: <20180607165218.9558-3-david@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v1 2/8] spapr: no need to verify the node
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


--OgApRN/oydYDdnYz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 07, 2018 at 06:52:12PM +0200, David Hildenbrand wrote:
> The node property can always be queried and the value has already been
> verified in pc_dimm_realize().
>=20
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/ppc/spapr.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 2375cbee12..d038f3243e 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -3578,14 +3578,7 @@ static void spapr_machine_device_plug(HotplugHandl=
er *hotplug_dev,
>              error_setg(errp, "Memory hotplug not supported for this mach=
ine");
>              return;
>          }
> -        node =3D object_property_get_uint(OBJECT(dev), PC_DIMM_NODE_PROP=
, errp);
> -        if (*errp) {
> -            return;
> -        }
> -        if (node < 0 || node >=3D MAX_NODES) {
> -            error_setg(errp, "Invaild node %d", node);
> -            return;
> -        }
> +        node =3D object_property_get_uint(OBJECT(dev), PC_DIMM_NODE_PROP=
, NULL);
> =20
>          spapr_memory_plug(hotplug_dev, dev, node, errp);
>      } else if (object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_CPU_CORE)) {

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--OgApRN/oydYDdnYz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsZ98UACgkQbDjKyiDZ
s5KbdRAA13Cgb7cm1OsguJK4/Vgc+zNThMGlVlHsQ8JYreR5/BDi8rFuSItT/RkL
K0j/e2nsOcDl1+tvVi5iNsQlxidul1mxzHn3juv6ElpVPEipX362X6NV5gznToZo
3uCe/fXDDDyKoQ26pH5CvWgtVQkewmhAPqe0PhYSb4+Uoz8oXKaesKBY9Y6slx7x
A6mJqcWL7W1Ro/4pf0D2yg6pz4CXCUWB1suslsyK2D3EvW0HFF9dNziwrmb4gg0k
8YYaDHYRQgtedJAMsgs67lCnhsMMepeun7h9DQYb+oJIsuWpc8VeCUruo+I0bDd9
XyqD9SU6NR200hB8KpwMyY0vcvZhFviQVSp9xHZHpCFPZhAi3jLmlff+sc/wde18
Q9KIrNFk5vsS+uT/SUZAuvi7lB/bpOU1oHtfF6Qsruw4DZivMzTts5zpZ7m1EnHr
+dsptf/utbHtOoa1OGS9vbTW9sNOyL9oYZhpEtrsDf5zNPsVNEfTvt7dMpMA9YNu
cy3xvQ4fcnBVNTdtGdXRmxmley/SyMbZZgWDLAfb/+k7v/7KJdRpyN54uFQoBfhR
XaAGLgbJACR9aqbNGglxpcTjn9pt6NL/WOKuKcnHNubrLG6bEa25bKtoxFwSG2r6
ViyD4mt+ljvI0n/I0M+t3lovg8f8lpfSq14YiISz371oz8B+gtE=
=rkO2
-----END PGP SIGNATURE-----

--OgApRN/oydYDdnYz--
