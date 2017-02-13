Received: from eggs.gnu.org ([2001:4830:134:3::10]:49766)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cd8Ra-0002Qo-Et
	for qemu-devel@nongnu.org; Sun, 12 Feb 2017 23:40:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cd8RX-00026W-Cw
	for qemu-devel@nongnu.org; Sun, 12 Feb 2017 23:40:54 -0500
Date: Mon, 13 Feb 2017 15:35:12 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170213043512.GW25381@umbus>
References: <1486704360-27361-1-git-send-email-sjitindarsingh@gmail.com>
	<1486704360-27361-11-git-send-email-sjitindarsingh@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="nqu5fpgjE+BQlEdo"
Content-Disposition: inline
In-Reply-To: <1486704360-27361-11-git-send-email-sjitindarsingh@gmail.com>
Subject: Re: [Qemu-devel] [QEMU-PPC] [PATCH V2 10/10] hw/ppc/spapr: Add
 POWER9 to pseries cpu models
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Cc: qemu-ppc@nongnu.org, agraf@suse.de, qemu-devel@nongnu.org, sam.bobroff@au1.ibm.com


--nqu5fpgjE+BQlEdo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 10, 2017 at 04:26:00PM +1100, Suraj Jitindar Singh wrote:
> Add POWER9 cpu to list of spapr core models which allows it to be specifi=
ed
> as the cpu model for a pseries guest (e.g. -machine pseries -cpu POWER9).
>=20
> This now allows a POWER9 cpu to boot to userspace in tcg emulation for a
> pseries machine with a legacy kernel.
>=20
> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

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

--nqu5fpgjE+BQlEdo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYoTeAAAoJEGw4ysog2bOSnQMP/08NQpAqaWDAWfmNQg2vNVe9
AqlIk/h189PWDfYZ9f0m9NkBw3XZlbMNLtACbe7z2OV62KhMVdUF/ppKwp2/GLXi
hA7YZ+6GWPJEwxNaIIkWuDIoTTyaAhIlIF/4iUv24T2lQTBzlW26KZhQOvAVsQgW
8HItuNJHrXSk5in1L+NUJzJW7IaRA+t2Lk7Gc959ca1FjTzqZ0pBWMs5qsPJKfav
8l1LiRqWhhRvocXalnbsB8KgKsgDp7LheUHazEt3f0gWlM23tK5gZSeroJqHvF/W
+gjDh0idn/UeF6T75G/teNch2n9zkDAKi2uE3fzRWDyS3KqGP4qkshgE8pLW9CMw
TrgqpTsOlmRhj29KUGGzcxT30EXR+FsuU1DKmbANHru07c+4M/lOEdAR2yLMsHHK
smNaTRikoSwRhyomBBSz/WpBbAAknGwYjCavc4S2ImXuVq+1tqOU0faaXo5tcARy
OuoYh0trLmWaBdtzz+sFz+8IlzV7ByJEkXL7XqK+376/8/FFEblYhaxzRs88pmQC
+n9i0+NAdAUL0QQTCTexaBGAGXMLs6rRrBE/O9PQWmVgrbjdedwwMHpYVYFoClGs
RHdeEyMuQaM35Ey2wR+5oJ10SU21Do112eznLNkpPfFJJS5HyvvsuksbONP4smLA
bcnba4hEHfldMa7d1I52
=xFnq
-----END PGP SIGNATURE-----

--nqu5fpgjE+BQlEdo--
