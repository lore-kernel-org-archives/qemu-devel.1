Received: from eggs.gnu.org ([2001:4830:134:3::10]:59023)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fasLu-0000a6-NA
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 20:42:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fasLt-0008VK-CO
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 20:42:30 -0400
Date: Thu, 5 Jul 2018 10:16:41 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180705001641.GE3450@umbus.fritz.box>
References: <20180704183855.18304-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mR8QP4gmHujQHb1c"
Content-Disposition: inline
In-Reply-To: <20180704183855.18304-1-laurent@vivier.eu>
Subject: Re: [Qemu-devel] [PATCH] target/ppc: fix build on ppc64 host
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, qemu-ppc@nongnu.org


--mR8QP4gmHujQHb1c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 04, 2018 at 08:38:55PM +0200, Laurent Vivier wrote:
1;5202;0c> When I try to build a ppc64 target on a ppc64 host (gcc 8.1.1), =
I have:
>=20
> .../target/ppc/int_helper.c: In function 'helper_vinsertb':
> .../target/ppc/int_helper.c:1954:32: error: array subscript 1844674407370=
9551608 is above array bounds of 'uint8_t[16]' {aka 'unsigned char[16]'} [-=
Werror=3Darray-bounds]
>          memmove(&r->u8[index], &b->u8[8 - sizeof(r->element)],          =
    \
>                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> .../target/ppc/int_helper.c:1965:1: note: in expansion of macro 'VINSERT'
>=20
> If we compare with the macro for ppc64le, we can see
> sizeof(r->element[0]) should be used instead of sizeof(r->element).
>=20
> And VINSERT uses only u8, u16, u32 and u64, so the maximum value
> of sizeof(r->element[0]) is 8
>=20
> Suggested-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>

Applied to ppc-for-3.0, thanks.

> ---
>  target/ppc/int_helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
> index 03d37da79f..d52338ed71 100644
> --- a/target/ppc/int_helper.c
> +++ b/target/ppc/int_helper.c
> @@ -1951,7 +1951,7 @@ VSPLT(w, u32)
>  #define VINSERT(suffix, element)                                        =
    \
>      void helper_vinsert##suffix(ppc_avr_t *r, ppc_avr_t *b, uint32_t ind=
ex) \
>      {                                                                   =
    \
> -        memmove(&r->u8[index], &b->u8[8 - sizeof(r->element)],          =
    \
> +        memmove(&r->u8[index], &b->u8[8 - sizeof(r->element[0])],       =
    \
>                 sizeof(r->element[0]));                                  =
    \
>      }
>  #else

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--mR8QP4gmHujQHb1c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAls9Y2gACgkQbDjKyiDZ
s5LN+hAA5FK751LxSNeizuOu6fxvx39YcJ75gDsnCP7DZpmpoAOkLkganWTXrPax
zw7/NflGjpZXJxvHILgIYUUdDJCTShOkm2Hcy3DCkMDDwFz6C0R5q0cyww7wsKFE
vjM1wX4LTWvZq0AMTXJQjgzKrsZZaJmZ/iH/2E4yFmGOHbM6F+Pf+tH4AN9GCjZk
cNHnIb6+Uyu6pwEIzzcGtIN3E5a9ZDHsKidqvfZz1KKCCaM/0SI9/EjVZ7iDRq6d
Duk08RzXV2529neYEDQAO93vrH8JYPz+Hb/E7dTwZy4C0NVnVu8zt9vT0FSuSj77
sw//eHqd7iRP0Ow+YhhnbtJ3Z8dQHdJuVvWLdQyniIpZ//IPLDi8PdvCyuMKhvZS
8n8xJl9UbY7d6x1FZtJZKJkTbgKghXAsVCY808pIycVjczp/32qlrNj8V6Lyqqt3
lgEmOG1YYARlfwbAXrEiAgahKZcHA+e5xdIyaYPQO0Lkw14dPChdIQLalkfDc3FB
kYn0RUjwQQA72Q3q2kvMFPyGrhg6N6IlX2JXjLBgZSIoota9nwHZzJPwaFgaLwr1
XJw1lDKL7TiooL0uf7yhvB63Syoo4TPem/zxybKoGTjBCX0MW7R0BjvMokIk0zDa
LzUOthgxv594jAem52Vk/u9VO9tK08Kz0XPv3LCvc/34ZOz22ko=
=Pdo5
-----END PGP SIGNATURE-----

--mR8QP4gmHujQHb1c--
