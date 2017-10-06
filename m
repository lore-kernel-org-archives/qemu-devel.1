Received: from eggs.gnu.org ([2001:4830:134:3::10]:45176)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e0OeE-0003wH-Am
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 05:10:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e0Oe8-00052z-Eo
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 05:10:22 -0400
Date: Fri, 6 Oct 2017 20:08:00 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171006090800.GE10961@umbus.fritz.box>
References: <20171005164959.26024-1-clg@kaod.org>
	<20171005164959.26024-3-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wchHw8dVAp53YPj8"
Content-Disposition: inline
In-Reply-To: <20171005164959.26024-3-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH 2/2] spapr/rtas: do not reset the MSR in
 stop-self command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Alexey Kardashevskiy <aik@ozlabs.ru>


--wchHw8dVAp53YPj8
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 05, 2017 at 06:49:59PM +0200, C=E9dric Le Goater wrote:
> When a CPU is stopped with the 'stop-self' RTAS call, its state
> 'halted' is switched to 1 and, in this case, the MSR is not taken into
> account anymore in the cpu_has_work() routine. Only the pending
> hardware interrupts are checked with their LPCR:PECE* enablement bit.
>=20
> The CPU is now also protected from the decrementer interrupt by the
> LPCR:PECE* bits which are disabled in the 'stop-self' RTAS
> call. Reseting the MSR is pointless.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/ppc/spapr_rtas.c | 10 ----------
>  1 file changed, 10 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
> index 2389220c9738..7f5ddce89ef2 100644
> --- a/hw/ppc/spapr_rtas.c
> +++ b/hw/ppc/spapr_rtas.c
> @@ -209,16 +209,6 @@ static void rtas_stop_self(PowerPCCPU *cpu, sPAPRMac=
hineState *spapr,
> =20
>      cs->halted =3D 1;
>      qemu_cpu_kick(cs);
> -    /*
> -     * While stopping a CPU, the guest calls H_CPPR which
> -     * effectively disables interrupts on XICS level.
> -     * However decrementer interrupts in TCG can still
> -     * wake the CPU up so here we disable interrupts in MSR
> -     * as well.
> -     * As rtas_start_cpu() resets the whole MSR anyway, there is
> -     * no need to bother with specific bits, we just clear it.
> -     */
> -    env->msr =3D 0;
> =20
>      if (env->mmu_model =3D=3D POWERPC_MMU_3_00) {
>          env->spr[SPR_LPCR] &=3D ~LPCR_DEE;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--wchHw8dVAp53YPj8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnXR/AACgkQbDjKyiDZ
s5LwUw//UTg6Tw+8i+Y0sRyAu1ylXcMngBJ9IhWZIM7j4zbydJzAEInVKizaWSFX
93G5T5iecR1NDncOCIFc4Jkr9IdwA4Fo9+M7P7fo51Uu6ROLZtubJhJ0Vv72mxCG
In2taIr+xCi/v0M60pbl2djz11g6d/hr5xn4IuXDdHPu45kg0GtOkAXfHkwYcp5t
4PpIU3R+fv+uJbBjwvpI1MfCKp7ouKoCuuvhg+/raR42aW2u+3yoRZLITBOO/AgF
S12xJIdKGXUZbmTepWDC31R94ONEVah8PAf9a8LxdhawnIhYJV3npfH6pWb9v1n/
3p/vP9Tdzo3IDwGMluATyViLu5e2+BDU3aWb7n7aaszFmToudfRk0NjfBlrPvuh0
UHhIvQx0oUpAqVkc+krORcBP4EQ8uhLq/oYUkShfXX0Q7cxEicYUD4e5B4AC/gBg
HEG6n3VVjWsV7SNUYBtA17AxIJv7hUELkpSGLujp11x2aCdEPbxO/s8dlqKzZ544
Yn1RPfskfubvxnRRsxg4aZ5PTEysKHn4MHdmwiHnD7G9vyrQA1HH35PY+WfO7sZj
/2DFgSs1COxSWyHaBM+FOH+XXcZCxWVTklQDzIBl+eU8IO6lHIYPrLDkqZJO/FM9
aNOEg3XMVLIACenEjXCbp5UVS8ivI8r+e7ZSxo9K5I/NNINhyNU=
=RAJR
-----END PGP SIGNATURE-----

--wchHw8dVAp53YPj8--
