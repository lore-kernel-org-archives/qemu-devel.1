Received: from eggs.gnu.org ([2001:4830:134:3::10]:40277)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cQmyH-0002Se-Pi
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 22:19:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cQmyE-0004Nk-Uk
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 22:19:37 -0500
Date: Tue, 10 Jan 2017 11:39:24 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170110003924.GL12515@umbus.fritz.box>
References: <1483966644-14049-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="f54savKjS/tSNRaU"
Content-Disposition: inline
In-Reply-To: <1483966644-14049-1-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] hw/ppc/spapr: Allow POWER9 as
 hot-pluggable CPU for pseries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Alexander Graf <agraf@suse.de>, Bharata B Rao <bharata@linux.vnet.ibm.com>


--f54savKjS/tSNRaU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 09, 2017 at 01:57:24PM +0100, Thomas Huth wrote:
> Running "qemu-system-ppc64 -M pseries -cpu POWER9" currently does not work
> yet and results in this error message:
>=20
>  qemu-system-ppc64: Unable to find sPAPR CPU Core definition
>=20
> Since we want to support the pseries machine with POWER9 in the future,
> allow using POWER9 as hot-pluggable CPU there, too.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>

I'm not sure it makes sense to apply this until we have at least the
basics of the POWER9 PAPR pieces implemented in qemu.

> ---
>  hw/ppc/spapr_cpu_core.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> index 9dddaeb..71253f9 100644
> --- a/hw/ppc/spapr_cpu_core.c
> +++ b/hw/ppc/spapr_cpu_core.c
> @@ -360,6 +360,9 @@ static const char *spapr_core_models[] =3D {
> =20
>      /* POWER8NVL */
>      "POWER8NVL_v1.0",
> +
> +    /* POWER9 */
> +    "POWER9_v1.0",
>  };
> =20
>  void spapr_cpu_core_class_init(ObjectClass *oc, void *data)

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--f54savKjS/tSNRaU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYdC05AAoJEGw4ysog2bOSYwIQANRga2yD+Haa1UCvAbzr/L8w
TvfvKSB4qklNINcFbPbGn9+7adgz2Zu1vinHezC4hKmwKmkNsfhbad+mu9FICiqn
4+L8pSWhThq97gLrcAJ+F/YzxcqXLPrd8xsPFR1vYPtgIvYKTR7m4bBnKCeDkLBZ
FUnBuZ46TzMHoBbwMtD0swU3Vy2AlVH4I0+J1QiyxsGeQMN6BSftf+u4BUJ1IUSV
INjVJAr8Mz3cldcG7rw2HV7oALOnNpc09MuKchWw2cTD2igaE7p8rXkEMhVfdYa1
JfnwtG3Sef81hnCZP7LS755TdNkzyNVPbj+WZewZXrwgOzT5tSqZb72FNU/T+oVu
K4BKTySkHD036SPVpYvxJFQfVhKj/KlkCYoq4gzS7w3ftiscMyxjOsUl7WUj/nm6
RgFakfKQDMpKSyIgTF9pR60MJII5tlBGLaBAl+C7jhw0iLnxobkqr9gLaR45JER9
UwKFK2OtUxl93FFWPsyQxdgLwGAcMbgAz0kdhOqTzkxVnFdDs3S7aJF0txX84B7a
0tAop1I1dzFlc39+a+IXwQHn1KhzXzJn2Vfj9tUVbiDJCBIqMNhueSZeFRQxyvPQ
Uw/hz/lWBLHI+NAqbTcX7qkyloilRUZ3w9brreKdq9BVXzipQCWBga8WFzvYOZLw
eZOYQ0MojhjPDZ1ypaBT
=4j9B
-----END PGP SIGNATURE-----

--f54savKjS/tSNRaU--
