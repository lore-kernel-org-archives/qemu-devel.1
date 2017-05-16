Received: from eggs.gnu.org ([2001:4830:134:3::10]:49629)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dAUTh-0000Jo-0p
	for qemu-devel@nongnu.org; Tue, 16 May 2017 00:52:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dAUTg-0003VN-1X
	for qemu-devel@nongnu.org; Tue, 16 May 2017 00:52:57 -0400
Date: Tue, 16 May 2017 14:41:13 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170516044113.GI30022@umbus.fritz.box>
References: <149484833874.20089.4164801378197848306.stgit@bahia.lan>
	<149484839512.20089.2730407279712230463.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="MPkR1dXiUZqK+927"
Content-Disposition: inline
In-Reply-To: <149484839512.20089.2730407279712230463.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH 5/6] spapr-cpu-core: release ICP object
 when realization fails
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>, Cedric Le Goater <clg@kaod.org>


--MPkR1dXiUZqK+927
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 15, 2017 at 01:39:55PM +0200, Greg Kurz wrote:
> While here we introduce a single error path to avoid code duplication.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Applied to ppc=3Dfor-2.10.

> ---
>  hw/ppc/spapr_cpu_core.c |   16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> index 4389ef4c2aef..63d160f7e010 100644
> --- a/hw/ppc/spapr_cpu_core.c
> +++ b/hw/ppc/spapr_cpu_core.c
> @@ -147,25 +147,25 @@ static void spapr_cpu_core_realize_child(Object *ch=
ild, Error **errp)
>      object_property_add_const_link(obj, "xics", OBJECT(spapr), &error_ab=
ort);
>      object_property_set_bool(obj, true, "realized", &local_err);
>      if (local_err) {
> -        error_propagate(errp, local_err);
> -        return;
> +        goto error;
>      }
> =20
>      object_property_set_bool(child, true, "realized", &local_err);
>      if (local_err) {
> -        object_unparent(obj);
> -        error_propagate(errp, local_err);
> -        return;
> +        goto error;
>      }
> =20
>      spapr_cpu_init(spapr, cpu, &local_err);
>      if (local_err) {
> -        object_unparent(obj);
> -        error_propagate(errp, local_err);
> -        return;
> +        goto error;
>      }
> =20
>      xics_cpu_setup(XICS_FABRIC(spapr), cpu, ICP(obj));
> +    return;
> +
> +error:
> +    object_unparent(obj);
> +    error_propagate(errp, local_err);
>  }
> =20
>  static void spapr_cpu_core_realize(DeviceState *dev, Error **errp)
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--MPkR1dXiUZqK+927
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZGoLpAAoJEGw4ysog2bOSE/AP/A45CgKkHdjT055+VUyWYbZ6
lUGHzDrR/qcmM2wTem+Tf2EuO8ea0JLd4O1NBGVSswP1BWFeYpejDE1gi8DaI1g/
R2djYkKFTJYHS92ZX9Wy+wQoV10aHQpGn4B6d0AQRUdH/XmbQZ9ryHp0sRtFhj5V
8e8C61P2C7ZZv2A3hwGm17UmD639TvdaPfGrDlx3suuIFmL+DsQJ3VS1HpnotVBs
BOzlaQeAxOOlERG+N6WtIF2hk7/ENFAvU9zplE+KmEXLdfQnWQfPr9bM+DXFGJi3
tN/+ct7J+7aJDzUZ6NKTpDVFOe5izE8grAMKS9UEc99cM/A/KYlbDBnfJqykYOeb
cVTnrAzu75XRLD1+UFjgYQ+Z+pLFTPLRj3uS1Nyzrm6R7H7V7mp5D95PjD6EXDhk
GPIvkwO0KHNzzp588S10rW6xoU2FHyp8yl8XObMABPGkDanpboMtQfh9QRxlraKk
/1ztkcphtOr3/mL6OeUMnFsMZLZxDlr5M80Z7R6CI2Lbor6LyPgGfxrDoE1NLFbN
vNPj4MGvNnfhprluJI8zBV/ZqT+gY6JV3ApUXOVlQuB+3UdQ9YuZ8Ui4YeMBlltp
1scl3oT1A0QXMUPWjiteaFE4Db9PlRHtswp6IQWFxYOGzwt/0bqODGUlVxXPf/8h
iywrtnzz+OsRgSrf9cvJ
=672n
-----END PGP SIGNATURE-----

--MPkR1dXiUZqK+927--
