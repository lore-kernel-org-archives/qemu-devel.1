Received: from eggs.gnu.org ([2001:4830:134:3::10]:36216)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e2o0C-0007eh-23
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 20:39:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e2o0A-0006MT-W1
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 20:39:00 -0400
Date: Fri, 13 Oct 2017 10:53:38 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171012235338.GF28032@umbus.fritz.box>
References: <1507823114-270153-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/aVve/J9H4Wl5yVO"
Content-Disposition: inline
In-Reply-To: <1507823114-270153-1-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] fixup! ppc: spapr: use cpu type name
 directly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, agraf@suse.de, groug@kaod.org


--/aVve/J9H4Wl5yVO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 12, 2017 at 05:45:14PM +0200, Igor Mammedov wrote:
> follow up commit that registers host-spapr-cpu-core type unconditionally
>  "ppc: spapr: register 'host' core type  along with the rest of core type=
s"
>=20
> makes 'non' machine crash
>  ppc64-softmmu/qemu-system-ppc64 -M none -device host-spapr-cpu-core
>  ERROR:qom/object.c:217:object_type_get_instance_size: assertion failed: =
(type !=3D NULL)
>  Aborted
>=20
> before it qemu fails cleanly with
>  ppc64-softmmu/qemu-system-ppc64 -M none -device host-spapr-cpu-core
>  qemu-system-ppc64: -device host-spapr-cpu-core: 'host-spapr-cpu-core' is=
 not a valid device model name
>=20
> spapr_cpu_core_realize() already has explicit check for pseries machine,
> so move access to host cpu type after it so 'none' machine would fail
> cleanly as expected.
>=20
> Reported-by: Greg Kurz <groug@kaod.org>
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Applied (folded into the original patch).

> ---
>  hw/ppc/spapr_cpu_core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> index b5bbb6a..7dbf9c3 100644
> --- a/hw/ppc/spapr_cpu_core.c
> +++ b/hw/ppc/spapr_cpu_core.c
> @@ -151,7 +151,7 @@ static void spapr_cpu_core_realize(DeviceState *dev, =
Error **errp)
>      sPAPRCPUCore *sc =3D SPAPR_CPU_CORE(OBJECT(dev));
>      sPAPRCPUCoreClass *scc =3D SPAPR_CPU_CORE_GET_CLASS(OBJECT(dev));
>      CPUCore *cc =3D CPU_CORE(OBJECT(dev));
> -    size_t size =3D object_type_get_instance_size(scc->cpu_type);
> +    size_t size;
>      Error *local_err =3D NULL;
>      void *obj;
>      int i, j;
> @@ -162,6 +162,7 @@ static void spapr_cpu_core_realize(DeviceState *dev, =
Error **errp)
>          return;
>      }
> =20
> +    size =3D object_type_get_instance_size(scc->cpu_type);
>      sc->threads =3D g_malloc0(size * cc->nr_threads);
>      for (i =3D 0; i < cc->nr_threads; i++) {
>          char id[32];

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--/aVve/J9H4Wl5yVO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlngAH8ACgkQbDjKyiDZ
s5JDPA/+P6IW068Ehcy2SC3t/dhtsvT//pCbETmGz4QIA6EH45n8IN7VWoVOnJ/O
lz9FzF4NF1UDT+vUSgna6KfAuyPzogtlVw+D30t6iSKzZ/s2Ly63/xa5Xf8LrPWp
iuqqANBmLcl1MtM/HtIDrKFr+IqSd5aqzT05Smt+76C2f9/ZlKVRyz0Bn9UB84c1
5oToV6dYDETVpOeBPLIYtJnulipxOaOssXnPvWngDdBYYURah89XTr8Jb8/75Mpf
aS7cRMwqUqGBITdoalS/bBg3EGynMH/8AEOizKbMKgmWkUZM35n7RA+aP6IBmh5X
L4+K3JrI+OukgnEi5gjvmkiRZOIeM8jXgxD7/MjIM8G5H0tPHgirKFG2G4RbVw34
qHGJORH+IJohTwUGTdFq2sqECTOlnzHJxuRcEhFcEqqCZ7TUQcdhfJELnOdnnycD
NEVtdI4f59ZRoyQD/oto32roCB54/zrX9WUU2Ziy7KoNQpK9A01OOORvum5PEDMc
PTv4SoIJnY4A1Kztc1nuHRPTwgbHkQjR4KAgNgITRhfsmJhLMq7Qft/fMPu0iqbp
IvFho5ul7xnhYS+pCH0XIILCacj4+Kxh3fQt/L1ACa4QVljFQqhQ4hmr8ZqRN7Kv
hjjJmrukO7E0oNVexhGDaGxcN+nluEftKLoKjVZPulznUP34T3E=
=bF87
-----END PGP SIGNATURE-----

--/aVve/J9H4Wl5yVO--
