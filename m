Received: from eggs.gnu.org ([2001:4830:134:3::10]:52741)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dL3d7-0001hP-Un
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 04:26:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dL3d3-000265-FR
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 04:26:21 -0400
Date: Wed, 14 Jun 2017 14:52:13 +0800
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170614065213.GH13420@umbus>
References: <20170614064452.23167-1-sjitindarsingh@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="WRT3RXLOp/bBMgTI"
Content-Disposition: inline
In-Reply-To: <20170614064452.23167-1-sjitindarsingh@gmail.com>
Subject: Re: [Qemu-devel] [PATCH] target/ppc: Fix return value in tcg radix
 mmu fault handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, agraf@suse.de


--WRT3RXLOp/bBMgTI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 14, 2017 at 04:44:52PM +1000, Suraj Jitindar Singh wrote:
> The mmu fault handler should return 0 if it was able to successfully
> handle the fault and a positive value otherwise.
>=20
> Currently the tcg radix mmu fault handler will return 1 after
> successfully handling a fault in virtual mode. This is incorrect
> so fix it so that it returns 0 in this case.
>=20
> The handler already correctly returns 0 when a fault was handled
> in real mode and 1 if an interrupt was generated.
>=20
> Fixes: d5fee0bbe68d ("target/ppc: Implement ISA V3.00 radix page fault ha=
ndler")
>=20
> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

Applied to ppc-for-2.10, thanks.

> ---
>  target/ppc/mmu-radix64.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/target/ppc/mmu-radix64.c b/target/ppc/mmu-radix64.c
> index de18c0b..69fde65 100644
> --- a/target/ppc/mmu-radix64.c
> +++ b/target/ppc/mmu-radix64.c
> @@ -255,5 +255,5 @@ int ppc_radix64_handle_mmu_fault(PowerPCCPU *cpu, vad=
dr eaddr, int rwx,
> =20
>      tlb_set_page(cs, eaddr & TARGET_PAGE_MASK, raddr & TARGET_PAGE_MASK,
>                   prot, mmu_idx, 1UL << page_size);
> -    return 1;
> +    return 0;
>  }

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--WRT3RXLOp/bBMgTI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZQN0dAAoJEGw4ysog2bOSOAkQAK2sZNyJ9SpkwjKxSNuczZbg
XLa7M2cwtvy4KI0I0bptGhedM8VM9HFBw0JMEdk8tyZQS+iVNYyJshsPfMWFgXmx
4Ox6vtnweSoQJRTJc9gepcawXzoU5NGR31ACm7PZCbBz+GjExp+CJuJ9Miy64MKC
R7wbMGhEFtajI8THb3UuFd66QaHQKpa5Qo9xIRqlvZ4Nv81XoZp1ZxFxotwHkoSq
hf1+ROORJL8+p9Pt9sfDCmE+txAodqDlnB9d2a1zFZKoYJbuh50WaSC5pPaSONh/
9ORnu58y072EZ8GPcwWBWQ0Gpl5oSBXGCt0RAU1oN0m8aozsvkuet/VXAqrkNDNN
MWcX8cZJImeF4Vb2mCmMCzzCYaFs60fk2dr2KVKrO7Gc/UzOugE+QylgmPbE2vxc
4/SwDsJlTXRnp2A11SzUHGKXYzUHlZBs0uHsJP+jpSnLpvO+FVq9wSe0T5Ya0vga
h25cRtpAHHZAViQq1RsF01sDFuYx5YTtqBlSpIFdNsrTJITlDk6aDg6d3yAHAZwX
CwLzjNgk13bgdkhGukzde8Jd6Bao2709cCTKyEs+qP0xQjTsX0zHz06x3FPeliDJ
ZCC++n8wgcPs1g0il4TcSmCIJyW21A7LAs1vtF74trhcfYT3L+RGD1ff1QvkvttS
2lvTv5VRIKpcN2QmDlV5
=Sufs
-----END PGP SIGNATURE-----

--WRT3RXLOp/bBMgTI--
