Received: from eggs.gnu.org ([2001:4830:134:3::10]:35270)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1drcpR-0004f3-5z
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 00:29:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1drcpP-0005OS-Sh
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 00:29:41 -0400
Date: Tue, 12 Sep 2017 14:10:20 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170912041020.GE2774@umbus.fritz.box>
References: <150516312603.27897.5390701685108186266.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="JBi0ZxuS5uaEhkUZ"
Content-Disposition: inline
In-Reply-To: <150516312603.27897.5390701685108186266.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH] spapr_cpu_core: fail gracefully with
 non-pseries machine types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Sam Bobroff <sam.bobroff@au1.ibm.com>


--JBi0ZxuS5uaEhkUZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 11, 2017 at 10:52:06PM +0200, Greg Kurz wrote:
> Since commit 7cca3e466eb0 ("ppc: spapr: Move VCPU ID calculation into
> sPAPR"), QEMU aborts when started with a *-spapr-cpu-core device and
> a non-pseries machine.
>=20
> Let's rely on the already existing call to object_dynamic_cast() instead
> of using the SPAPR_MACHINE() macro.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Applied to ppc-for-2.11.

> ---
>  hw/ppc/spapr_cpu_core.c |    5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> index d04d1e0d8164..dc9df0d393d1 100644
> --- a/hw/ppc/spapr_cpu_core.c
> +++ b/hw/ppc/spapr_cpu_core.c
> @@ -201,7 +201,7 @@ error:
> =20
>  static void spapr_cpu_core_realize(DeviceState *dev, Error **errp)
>  {
> -    sPAPRMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
> +    sPAPRMachineState *spapr;
>      sPAPRCPUCore *sc =3D SPAPR_CPU_CORE(OBJECT(dev));
>      sPAPRCPUCoreClass *scc =3D SPAPR_CPU_CORE_GET_CLASS(OBJECT(dev));
>      CPUCore *cc =3D CPU_CORE(OBJECT(dev));
> @@ -211,7 +211,8 @@ static void spapr_cpu_core_realize(DeviceState *dev, =
Error **errp)
>      void *obj;
>      int i, j;
> =20
> -    if (!object_dynamic_cast(qdev_get_machine(), TYPE_SPAPR_MACHINE)) {
> +    spapr =3D (sPAPRMachineState *) qdev_get_machine();
> +    if (!object_dynamic_cast((Object *) spapr, TYPE_SPAPR_MACHINE)) {
>          error_setg(errp, "spapr-cpu-core needs a pseries machine");
>          return;
>      }
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--JBi0ZxuS5uaEhkUZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlm3XisACgkQbDjKyiDZ
s5KW5Q/+N8KY7vGjWa4ht3MkgpYHEjEPXMkbP2WHxVja1AV+dgwlH209N+7mcdap
Tpb9LpiaPZnGYwobESxN3tMg6920oegRR290e6vACV0kTzFiDcZLcuiZFl9U6IDx
asMYZ99rlkKRXMk8fL+RIGEZrbhsZAY4aXmT6oKwatpEkuQiaOlapL4sxo7uvcxU
PQ0/dVnZ/biBx2/uVeF2T+FWB7SQ3F03B4fx/SDN32xoP7Yu6qHwOdfMS5wHFoC5
PuxoiYlnzFP7wSrc8hZPjO9y8ZpDuVIEpPqSwBS6kt3CGod6nFTYZGssh8V2Hg+z
k7jYejbxyeCYExCkTVmNTBIJ9zaYQyqsBJmC7li57AtpFFAGb1hRbfe9o6pRoND0
+GV15AIIeXaScxXgZIzgSjHtD7Z7D5h3ehYcuSk9yNCvIzeJjRtp2M477zo4fi3T
GcxP+qCuD/puaXFFGqofNbtu1U9u2TZXLauTj1mkmCh4ChXn5WPpzrVC8LOK6929
KHHQKXsXrKYMq0wBmEukBWCWQl6jRlomRo76FmppIIZeZhomRAjU7cji3mWzR8A9
rwKzsKBXeSVZqev71m8DF/gV5LOjkC1Pp93kZoJIzpxMpznvDOf+mToSk3P6LJHV
39CD5Twri1F4ZobxlT14lfAlpDa08UVmQTa6/cyPz8t8Xugds/k=
=q1fF
-----END PGP SIGNATURE-----

--JBi0ZxuS5uaEhkUZ--
