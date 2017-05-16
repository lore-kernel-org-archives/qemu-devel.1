Received: from eggs.gnu.org ([2001:4830:134:3::10]:45559)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dAU2v-00025x-Am
	for qemu-devel@nongnu.org; Tue, 16 May 2017 00:25:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dAU2u-0007Uu-Bn
	for qemu-devel@nongnu.org; Tue, 16 May 2017 00:25:17 -0400
Date: Tue, 16 May 2017 12:55:48 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170516025548.GB30022@umbus.fritz.box>
References: <20170515083509.24607-1-nikunj@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="VrqPEDrXMn8OVzN4"
Content-Disposition: inline
In-Reply-To: <20170515083509.24607-1-nikunj@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] target/ppc: reset reservation in do_rfi()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, rth@twiddle.net


--VrqPEDrXMn8OVzN4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 15, 2017 at 02:05:09PM +0530, Nikunj A Dadhania wrote:
> For transitioning back to userspace after the interrupt.
>=20
> Suggested-by: Richard Henderson <rth@twiddle.net>
> Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>

Applied to ppc-for-2.10. thanks.

> ---
>  target/ppc/excp_helper.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> index a6bcb47..9cb2123 100644
> --- a/target/ppc/excp_helper.c
> +++ b/target/ppc/excp_helper.c
> @@ -995,6 +995,9 @@ static inline void do_rfi(CPUPPCState *env, target_ul=
ong nip, target_ulong msr)
>       */
>      cs->interrupt_request |=3D CPU_INTERRUPT_EXITTB;
> =20
> +    /* Reset the reservation */
> +    env->reserve_addr =3D -1;
> +
>      /* Context synchronizing: check if TCG TLB needs flush */
>      check_tlb_flush(env, false);
>  }

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--VrqPEDrXMn8OVzN4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZGmo0AAoJEGw4ysog2bOSa4MP/ikztcv294ftMZLokh+gqsR2
ahy8ENc92Scov4tklQpDqxFZvpyi0e+OGOLOkXHHGVcGqDnxPyeu4/zd2rxT1k/O
R7yjuAphmola8zdluDFsH+wHqcvWoMMhpUS1PUEym/2qeaStlZrlIbZ0xjdpbEJX
mV60SMgK1eYP38AsDeoq7EzI7r3ZYOnwwNz0N9l9FNU/TQrkgpUUCixOoupwJKlm
T3QfMylswBjCPU6mMuBYe9aBeSwuGFV1Q9MQlXfgMPJNAFEoR6XEK4Vta70CZ1N1
PZ00FAcAxbs2wLyX1RfPvOjbpooE2WpYY0DE3T2BDIgTPdRHJETwcH/kVald5e8I
9WilulrEqgshp9Trktd3uEU2a6PHb+cUdnkvpGYdyF5E+LJOgSZgIZRGKBaxG9R5
ha9eqEg5FLvrGcrdf2ZQNMB8BWe12sDhCCiosqP97r5TvMmgCvR3dyey0u6wOVH2
7nFfJMyen62ad6L2QdvlTItrcKSjr5PGoaxLj7RIzP3iZOrPd1TLkKWSk6eMaD1a
eYrVx6LLUGPF4RwJmrtanb0jSMTm54ePHsrxqkzMJlLBPN5xMXjhGlD8M3ALrOaI
OPk2QHzSVN9jVTMJHrSws5+Nlv+x/Vk9boOy921LUwUaHfhmIv5ps2xKYMCJZ/BP
E2BFLEHsC0uKWqGa8JgY
=nI1f
-----END PGP SIGNATURE-----

--VrqPEDrXMn8OVzN4--
