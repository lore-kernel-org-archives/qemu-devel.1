Received: from eggs.gnu.org ([2001:4830:134:3::10]:54173)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cRTC4-0004V7-UP
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 19:24:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cRTC1-0005CW-QI
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 19:24:40 -0500
Date: Thu, 12 Jan 2017 10:22:07 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170111232207.GC14026@umbus.fritz.box>
References: <1484169085-2962-1-git-send-email-joserz@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="32u276st3Jlj2kUU"
Content-Disposition: inline
In-Reply-To: <1484169085-2962-1-git-send-email-joserz@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCHi v2] ppc: Fix a warning in bcdcfz code and
 improve BCD_DIG_BYTE macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, nikunj@linux.vnet.ibm.com, eblake@redhat.com, 655708@bugs.launchpad.net, thuth@redhat.com


--32u276st3Jlj2kUU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 11, 2017 at 07:11:25PM -0200, Jose Ricardo Ziviani wrote:
> This commit fixes a warning in the code "(i * 2) ? .. : ..", which
> should be better as "i ? .. : ..", and improves the BCD_DIG_BYTE
> macro by placing parentheses around its argument to avoid possible
> expansion issues like: BCD_DIG_BYTE(i + j).
>=20
> Signed-off-by: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>

Applied to ppc-for-2.9.

> ---
>  target/ppc/int_helper.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
> index 24e5964..bd8282c 100644
> --- a/target/ppc/int_helper.c
> +++ b/target/ppc/int_helper.c
> @@ -2583,9 +2583,9 @@ void helper_vsubecuq(ppc_avr_t *r, ppc_avr_t *a, pp=
c_avr_t *b, ppc_avr_t *c)
>  #define NATIONAL_NEG    0x2D
> =20
>  #if defined(HOST_WORDS_BIGENDIAN)
> -#define BCD_DIG_BYTE(n) (15 - (n/2))
> +#define BCD_DIG_BYTE(n) (15 - ((n) / 2))
>  #else
> -#define BCD_DIG_BYTE(n) (n/2)
> +#define BCD_DIG_BYTE(n) ((n) / 2)
>  #endif
> =20
>  static int bcd_get_sgn(ppc_avr_t *bcd)
> @@ -2908,7 +2908,7 @@ uint32_t helper_bcdcfz(ppc_avr_t *r, ppc_avr_t *b, =
uint32_t ps)
>      }
> =20
>      for (i =3D 0; i < 16; i++) {
> -        zone_digit =3D (i * 2) ? b->u8[BCD_DIG_BYTE(i * 2)] >> 4 : zone_=
lead;
> +        zone_digit =3D i ? b->u8[BCD_DIG_BYTE(i * 2)] >> 4 : zone_lead;
>          digit =3D b->u8[BCD_DIG_BYTE(i * 2)] & 0xF;
>          if (unlikely(zone_digit !=3D zone_lead || digit > 0x9)) {
>              invalid =3D 1;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--32u276st3Jlj2kUU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYdr4eAAoJEGw4ysog2bOS/FIP/0f06YsSu0+LfRFdtqQzsaqA
5MpfFr18lP+PBExuvQ0en+YqC+l+K9PTepTr8sdjQS4imvybD0iMxW5f6ByMu4LL
VRg1jUxAumZDyWtjXtgZmzSIMTGNzU4qS2HnCSkJisOWk+wQLy+9mL8FGIJ/bE97
zGKY29piBoW1dI2I1kTt/yN1PVaAuq7bPvae3H6rLRSmUEaLoNKf3lNbRzDAR9m0
bNaW3/0eOx4MGEz3MJAkJ0QNSUGuxRoJ7GU4kZ0MaLoiFKdaS5Rhj2tEBPEvgZ2u
GOkNn9My9QxZBP06FUR+h3uW6u/XdjipVLdShdeiOPvcLtGsIauzUpW7/6rpPH3k
Q8ChRlSIoNCo9jAdcASuN5RHIGq3BLV46q3SPLBzqKfziMNgwPdCk+ezgt33Qj3I
B6ThvwqCM3zTGJNBxT0kanz1+DiGCkrCBgB3lTsPSsUTwVEYDWUsBG7zkZ2lPN/W
0Bd3gDEjJyzUKUnDTvuVZmB3QbqN/bTiuRDDEvsa9x33OA2eELIyvtI4ZNvRDy2k
eOyE53sC9gSHPANsCCun8xhTKar0BQf/prE4SEwuflYcuArm4vca5kdn9fISOT5Q
BFe6w3IiPeOaSH67Xxa9kAs56kMCs0tkP1JYnYy2c4hHYLpiSt6bpJrxKtFi2Q4R
OP77lD4wttbKPiEiik9Q
=JCUL
-----END PGP SIGNATURE-----

--32u276st3Jlj2kUU--
