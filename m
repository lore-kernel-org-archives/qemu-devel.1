Received: from eggs.gnu.org ([2001:4830:134:3::10]:40364)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gV7S0-0002O6-UG
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 23:09:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gV7Rw-0006lG-CN
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 23:09:16 -0500
Date: Fri, 7 Dec 2018 14:59:45 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181207035945.GB10945@umbus.fritz.box>
References: <20181205232251.10446-1-clg@kaod.org>
	<20181205232251.10446-13-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="TRYliJ5NKNqkz5bu"
Content-Disposition: inline
In-Reply-To: <20181205232251.10446-13-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v6 12/37] spapr: initialize VSMT before
 initializing the IRQ backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>


--TRYliJ5NKNqkz5bu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 06, 2018 at 12:22:26AM +0100, C=E9dric Le Goater wrote:
> We will need to use xics_max_server_number() to create the sPAPRXive
> object modeling the interrupt controller of the machine which is
> created before the CPUs.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> Reviewed-by: Greg Kurz <groug@kaod.org>

This one stands on its own, so I've applied.

> ---
>  hw/ppc/spapr.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 7afd1a175bf2..50cb9f9f4a02 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2466,11 +2466,6 @@ static void spapr_init_cpus(sPAPRMachineState *spa=
pr)
>          boot_cores_nr =3D possible_cpus->len;
>      }
> =20
> -    /* VSMT must be set in order to be able to compute VCPU ids, ie to
> -     * call xics_max_server_number() or spapr_vcpu_id().
> -     */
> -    spapr_set_vsmt_mode(spapr, &error_fatal);
> -
>      if (smc->pre_2_10_has_unused_icps) {
>          int i;
> =20
> @@ -2593,6 +2588,11 @@ static void spapr_machine_init(MachineState *machi=
ne)
>      /* Setup a load limit for the ramdisk leaving room for SLOF and FDT =
*/
>      load_limit =3D MIN(spapr->rma_size, RTAS_MAX_ADDR) - FW_OVERHEAD;
> =20
> +    /* VSMT must be set in order to be able to compute VCPU ids, ie to
> +     * call xics_max_server_number() or spapr_vcpu_id().
> +     */
> +    spapr_set_vsmt_mode(spapr, &error_fatal);
> +
>      /* Set up Interrupt Controller before we create the VCPUs */
>      smc->irq->init(spapr, &error_fatal);
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--TRYliJ5NKNqkz5bu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwJ8C4ACgkQbDjKyiDZ
s5KN4RAAlXnEjYOSvN4KOA2IYitbSConyFzoTb6tdgM/5/LgRhQAoYULbT92poTg
DetylBGOFaQew1SNPbKYqcMKSLIk4SsVtQg6HnOf9VDDFnJxjOMBB/A9PxB8+JSS
R1e3AhY63HsiagEbRAMVliL3L01LOXiXAR5lglZyhDEYUS/AArTJ/YSAbpQvXGLK
zQ/xB+FuX9+miSuG1ahNYtBlJR/C98qtsW+sdNG5x0ocoHzIos/JNX1qKpt13MWW
km3qwTtNqqzqCwijl5nmjetuKbGrOFoUBx4tUmd+NES+z3blHdK0ygjmINC9dhu7
ozauK7LTvAPR33RFNS94JPTnmrwW+ji9HFy6TDtj5DcrJoAUXmlFYSVytZie+G3j
RlOEfOgKV6PHyyZpFNU3Exj+Z/drvie+TR8Gx97kKDYgDkitXlAFZnbmkr3C5XKm
RW0KONM5x2zL16yE0KjZ4q/srmIKLmq7b5pzQYXfQkjn97HJJ7glc8pcXM7JBQcz
O4mVCUcpZlYOlb19inPqJjs1IqFgSeuWcX2gPgUVzpUoUznUOtTrlS4esRddnjAg
BFj2NFseWB3rvfGA+nyruGE07L9tvEnYcZfnskWPK2WGZ17U8N6TXVYKc0wc5CFu
ozYggKCEmfnp6VlsH8ZFjnBgmx1eDDhfLhLZ5qCFdz3elERSp1g=
=dzz7
-----END PGP SIGNATURE-----

--TRYliJ5NKNqkz5bu--
