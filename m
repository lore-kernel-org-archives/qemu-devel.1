Received: from eggs.gnu.org ([2001:4830:134:3::10]:50887)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gA6dI-0002vk-TN
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 01:02:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gA6dH-0000gZ-Vy
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 01:02:04 -0400
Date: Wed, 10 Oct 2018 15:32:31 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181010043230.GK7004@umbus.fritz.box>
References: <20181008032539.6437-1-sjitindarsingh@gmail.com>
	<20181008032539.6437-3-sjitindarsingh@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3NJww9yp20AXRsxZ"
Content-Disposition: inline
In-Reply-To: <20181008032539.6437-3-sjitindarsingh@gmail.com>
Subject: Re: [Qemu-devel] [QEMU-PPC] [PATCH V2 2/3] target/ppc: Add one reg
 id for ptcr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, paulus@ozlabs.org


--3NJww9yp20AXRsxZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 08, 2018 at 02:25:38PM +1100, Suraj Jitindar Singh wrote:
> The ptcr (partition table control register) is used to store the address
> and size of the partition table. For nested kvm-hv we have a level 1
> guest register the location of it's partition table with the hypervisor.
> Thus to support migration we need to be able to read this out of kvm
> and restore it post migration.
>=20
> Add the one reg id for the ptcr.
>=20
> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  target/ppc/translate_init.inc.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.=
inc.c
> index 263e63cb03..487196800b 100644
> --- a/target/ppc/translate_init.inc.c
> +++ b/target/ppc/translate_init.inc.c
> @@ -8197,11 +8197,11 @@ static void gen_spr_power9_mmu(CPUPPCState *env)
>  {
>  #if !defined(CONFIG_USER_ONLY)
>      /* Partition Table Control */
> -    spr_register_hv(env, SPR_PTCR, "PTCR",
> -                    SPR_NOACCESS, SPR_NOACCESS,
> -                    SPR_NOACCESS, SPR_NOACCESS,
> -                    &spr_read_generic, &spr_write_ptcr,
> -                    0x00000000);
> +    spr_register_kvm_hv(env, SPR_PTCR, "PTCR",
> +                        SPR_NOACCESS, SPR_NOACCESS,
> +                        SPR_NOACCESS, SPR_NOACCESS,
> +                        &spr_read_generic, &spr_write_ptcr,
> +                        KVM_REG_PPC_PTCR, 0x00000000);
>  #endif
>  }
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--3NJww9yp20AXRsxZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlu9gN4ACgkQbDjKyiDZ
s5IKUxAApo+PXazLukjK5igC/2RWxmnzQFbvD304IuRxwKsvkx9BQ2/n40gEG5ju
dyCWbdUkb2uuRi+Zdd9AH+1b+eN/mrDEwOaFNFzeBB0kvj7TqDaFT/yqetQrR5HL
d4iyb/5IVOVYfqIOVPYUiWsbxVhuUdrJfmFe3o2dqMJF2WoxEc7+Uv6Hb2U17RNA
jYGbjxgQrMsbgw3zGAnS9NvI+yOSeivmrFVFwIZP5dFaZ+IfWLwIQMVufe+KR/El
PG0zgW95KGTFuaEI8LcdlFJ+aDChIlwGxtVOE5ni2QpMTnmykvnIc9YDWoP+XpeN
26E7Vu5vBKbK6wgmAkgRx9GQWhc24zcFjjqHaleOMqmnRjtsJTYcQqEX1Ntq9ake
DfezqG9Tv8PrwWST5Sh50srKrO9B+m+OxWkhpL2hNB4dIHKR9PdUXCKrSlN9/DsR
nrShQ03N7IbuDgbX8crkEOr7sl2+WIo11io7JQoRhSd54q2c5MDPLW8I6QYSTk6u
YQg6Ya17k/LobZD09rLQQm8U7xJe0TQw9w63KqtSUkcs/8DTFNR+l24gsOj27Zgt
j2F6pLVN2igwkE1BBpm+OyfwcgWbaU1OzlcY9GE5KnqEfkJ03PvJZ6QxZT0DNe+w
hzlJRv5l25T+ITmRQMKTUQ6tSgDFP1BCidiJVFPWBUab6b4LOnE=
=vTxB
-----END PGP SIGNATURE-----

--3NJww9yp20AXRsxZ--
