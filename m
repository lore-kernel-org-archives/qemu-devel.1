Received: from eggs.gnu.org ([2001:4830:134:3::10]:45379)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eJE04-0008Ch-DX
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 02:38:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eJE03-000074-Cr
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 02:38:44 -0500
Date: Mon, 27 Nov 2017 18:19:54 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171127071954.GI11775@umbus.fritz.box>
References: <20171124070550.6433-1-clg@kaod.org>
	<20171124070550.6433-4-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="QDIl5R72YNOeCxaP"
Content-Disposition: inline
In-Reply-To: <20171124070550.6433-4-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v4 3/3] spapr/rtas: do not reset the MSR in
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>


--QDIl5R72YNOeCxaP
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 24, 2017 at 08:05:50AM +0100, C=E9dric Le Goater wrote:
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
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

Applied to ppc-for-2.12.

> ---
>  hw/ppc/spapr_rtas.c | 10 ----------
>  1 file changed, 10 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
> index 858adb1bf3a9..4bb939d3d111 100644
> --- a/hw/ppc/spapr_rtas.c
> +++ b/hw/ppc/spapr_rtas.c
> @@ -206,16 +206,6 @@ static void rtas_stop_self(PowerPCCPU *cpu, sPAPRMac=
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
>      /* Disable Power-saving mode Exit Cause exceptions for the CPU.
>       * This could deliver an interrupt on a dying CPU and crash the

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--QDIl5R72YNOeCxaP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlobvJoACgkQbDjKyiDZ
s5K4CA/7By0bZ2VXTaQoI3b6kk1eahkQx612yhnMjZ3EqxdZCUY7vUiS50bbsYal
5vL01GBouxbuaWgM9RQfoD00GBcSz19dmibcR8nBFvkfrNBK9N6XvEm6IX0q48Rh
+KcmU4IqQyAj+7XV9NXcguBBbrP7ZS3vPpLUW/koNd01s1vBRVFVqCd9ChFX0rpV
M+OYaLbWf8Xm+2NEWNy6aET1o/7yRWZct/bpyyeRURiCVr0wWoXO+GD0Eb4hubje
TN6mqlApQEQzjD63fP2TbvVXO+kATKnaMLzBqQ8sgF7rdP0B6ZAcTr6R7+FUoEvS
AC2zclMq8TZt6FRoHHxqr3TkQX9zobjeVvtdQx0HAXJ41lJs28A3fZASeV9yEFCn
NiR2mNRWz9YTGMIN6ms4Wa1UgTkmdWyn1OgbxK8kyBypvX6FPsgMsVi02zPLBKbN
JTZWqxnBQuLX/0hunG/9dlZSweQTCm0vMIKCEcHKHWpZHrYf1PAjDXgp7Y4HbgnH
4BnomuFltZTXJ6PxC11KwOmQe412m/KlMuLdowcdmkz6h2Wuf9Ag59hWZrVE+s2O
6x69tm2ABGGL08ZsRpm10UUAS/xQodk99sN2u9JwUiBtr/YyutncG+OUHYAlb+oZ
wRkjtXJ9BRHojHOH6Qrmt8rJ1B4/sjiWxdJJp9U/SLPRuKRJKUk=
=hTrW
-----END PGP SIGNATURE-----

--QDIl5R72YNOeCxaP--
