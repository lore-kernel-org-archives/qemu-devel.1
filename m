Received: from eggs.gnu.org ([2001:4830:134:3::10]:40944)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dVxSs-0002Vw-UQ
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 06:04:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dVxSo-00031e-Rw
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 06:04:50 -0400
Date: Fri, 14 Jul 2017 18:34:49 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170714083449.GC17539@umbus.fritz.box>
References: <150001864048.7077.16008343547703241545.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qtZFehHsKgwS5rPz"
Content-Disposition: inline
In-Reply-To: <150001864048.7077.16008343547703241545.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH] spapr: fix memory leak in
 spapr_core_pre_plug()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-stable@nongnu.org


--qtZFehHsKgwS5rPz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 14, 2017 at 09:50:40AM +0200, Greg Kurz wrote:
> In case of error, we must ensure the dynamically allocated base_core_type
> is freed, like it is done everywhere else in this function.
>=20
> This is a regression introduced in QEMU 2.9 by commit 8149e2992f78.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Applied to ppc-for-2.10.

> ---
>  hw/ppc/spapr.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 638b8243de04..ed9b57d1fc2a 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -3150,9 +3150,9 @@ static void spapr_core_pre_plug(HotplugHandler *hot=
plug_dev, DeviceState *dev,
>       * total vcpus not a multiple of threads-per-core.
>       */
>      if (mc->has_hotpluggable_cpus && (cc->nr_threads !=3D smp_threads)) {
> -        error_setg(errp, "invalid nr-threads %d, must be %d",
> +        error_setg(&local_err, "invalid nr-threads %d, must be %d",
>                     cc->nr_threads, smp_threads);
> -        return;
> +        goto out;
>      }
> =20
>      core_slot =3D spapr_find_cpu_slot(MACHINE(hotplug_dev), cc->core_id,=
 &index);
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--qtZFehHsKgwS5rPz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAllogiYACgkQbDjKyiDZ
s5J2hg/9Fw0nhjKdlrlANGRG0qvxKreR3o/pUthlaDFgcPIBESSjs48wOfMNaRGS
HfHOtdgh8Jk+gWxgWbxTUHweuKL2ykpXWRrENj1UejMWP8Vi+mDZceXFyFBQD4Nq
JpRVfzsmth7GWgHYvZWcRgVCdOWNZaSLRivDUHe2c/yz9OC7r1vnqBWQPmqMmEkn
Y35MNV5dWo5vJyMTakVndHgK9LObSWsZSa+axz0YbqnlM9yKX+wm3TMdl1TKJR5c
bo3QPkJRoT2xiQQ1N3PNGt4c55Q87ik+c6D93mgJMCdRKhVKyGy/hPIjDnVfQYhD
1cN3T7TmFphLVwFUiCWxmIkDa66WKhWUvMki56sMMbVVe2f8QwVU5dJ1mWxGOcRj
XTCIvu+5IcFq70ZXwaZyBMGafre9+3lAsOsg63BGHQBLZJuSlVllKTnDLDFolvEA
kGF5oum7DMfFPQ5mlUqQEiAk3OxfJq26iwsVD9zBfUSmdTA1GjJ3/J5UpG1eFEar
q1bMiFN+HPeysb0v0mula3Aw7C7GDBR4z+hJ9S9zsPt247+/karWZcAmLDGQFryw
P/XP5nlPCcOrv6z9DwbM0xFepX7wh9+vsD0CKlX4eLFIDowxpgUm0XC/O3zO2LyX
606DxW83thyWyjPJ/Ii74RByKhDCchlWAEyOdnDD0mzJx+b5oPM=
=Dx7v
-----END PGP SIGNATURE-----

--qtZFehHsKgwS5rPz--
