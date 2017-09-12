Received: from eggs.gnu.org ([2001:4830:134:3::10]:40140)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dridZ-0002ag-LR
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 06:41:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dridT-0002Zb-QN
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 06:41:49 -0400
Date: Tue, 12 Sep 2017 20:23:31 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170912102331.GB7550@umbus.fritz.box>
References: <150519908146.11227.1999305745123047542.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="i0/AhcQY5QxfSsSZ"
Content-Disposition: inline
In-Reply-To: <150519908146.11227.1999305745123047542.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH v3] spapr_cpu_core: cleaning up
 qdev_get_machine() calls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>


--i0/AhcQY5QxfSsSZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 12, 2017 at 08:51:21AM +0200, Greg Kurz wrote:
> This patch removes the qdev_get_machine() calls that are made
> in spapr_cpu_core.c in situations where we can get an existing
> pointer for the MachineState by either passing it as an argument
> to the function or by using other already available pointers.
>=20
> Credits to Daniel Henrique Barboza for the idea and the changelog
> text.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Applied to ppc-for-2.11.

> ---
> v3: - dropped spapr_cpu_reset() hunk
> ---
>  hw/ppc/spapr_cpu_core.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> index dc9df0d393d1..dea298a796c4 100644
> --- a/hw/ppc/spapr_cpu_core.c
> +++ b/hw/ppc/spapr_cpu_core.c
> @@ -162,10 +162,10 @@ static void spapr_cpu_core_unrealizefn(DeviceState =
*dev, Error **errp)
>      g_free(sc->threads);
>  }
> =20
> -static void spapr_cpu_core_realize_child(Object *child, Error **errp)
> +static void spapr_cpu_core_realize_child(Object *child,
> +                                         sPAPRMachineState *spapr, Error=
 **errp)
>  {
>      Error *local_err =3D NULL;
> -    sPAPRMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
>      CPUState *cs =3D CPU(child);
>      PowerPCCPU *cpu =3D POWERPC_CPU(cs);
>      Object *obj;
> @@ -254,7 +254,7 @@ static void spapr_cpu_core_realize(DeviceState *dev, =
Error **errp)
>      for (j =3D 0; j < cc->nr_threads; j++) {
>          obj =3D sc->threads + j * size;
> =20
> -        spapr_cpu_core_realize_child(obj, &local_err);
> +        spapr_cpu_core_realize_child(obj, spapr, &local_err);
>          if (local_err) {
>              goto err;
>          }
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--i0/AhcQY5QxfSsSZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlm3taEACgkQbDjKyiDZ
s5LwyA/9HdifXrw/gOtOkHysp5YzGZjBYbxt3ADBz6lzhDFGSGcXa4cqHNruD2Ll
+p23K+E6M3tFxl4kX+kfaQkNEl8314cPEenFWcyqR8L947xvu70QaFFA3te4VyYV
G+HfqM7vH0l8SSwdMZP1H8mvSdtDXhVTrDXprAAEaWtiBRxQACKGpDsZ750chc5a
1FQAR5+8ogiGQmSNpiNO6+UHoVcDvys1aouErFDnfJisLz7s7yuAEhPlt7AR+jiQ
a5ugzH27W3jws4cCoxa9rbmNeD8NsfW0Ef0Zpn5PFGFzE+XiF6Rh17DMThyejnkW
xY6245Ss+Bj5yEA4fOzMrswZ4B5+DzKNsBvEYqOMuJIUfMKn58Za+BOpRP06NPm+
MhRUbG+7UK1X2P8N1TTl7d6V7zUm/cETx4TU1e0FbM2aQikd0Lib01c2nhyDcAEz
n17cxAUSttmR8aTe5oWP6e1MiYnle+A7jxlvGbdryTB1KOTRW65X1ClsmD00+z6F
/ZUBSGhfx+yAygo+IVaT7VIgMHEL4sokaiIOC2JPQcDdRQu8ObbGYrXEkk5P8me8
IrpljLIn6YMzYpHJedTU3z1s6LT0m48uGRFEA8cjwkVFCzuywa1OBSSpn6oZHi5x
cMEzMYBqXjXKHQj2Y64lV3Dr6FS277bP1YfEji+85GhXDGEZ4i0=
=X0FY
-----END PGP SIGNATURE-----

--i0/AhcQY5QxfSsSZ--
