Received: from eggs.gnu.org ([2001:4830:134:3::10]:34874)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1faAFI-0004Dh-D5
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 21:36:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1faAFH-0004Mj-B4
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 21:36:44 -0400
Date: Tue, 3 Jul 2018 11:13:22 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180703011322.GH3422@umbus.fritz.box>
References: <cover.1530225513.git.balaton@eik.bme.hu>
	<bf4086546f08124e57b9676e6c0b81386ee59b67.1530225513.git.balaton@eik.bme.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="saTAHnV464s+57Yq"
Content-Disposition: inline
In-Reply-To: <bf4086546f08124e57b9676e6c0b81386ee59b67.1530225513.git.balaton@eik.bme.hu>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v6 5/5] target/ppc: Relax
 reserved bitmask of indexed store instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--saTAHnV464s+57Yq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 29, 2018 at 12:38:33AM +0200, BALATON Zoltan wrote:
> The PPC440 User Manual says that if bit 31 is set, the contents of
> CR[CR0] are undefined for indexed store instructions but this form is
> not invalid. Other PPC variants confirming to recent ISA where this
> bit may be reserved should ignore reserved bits and not raise invalid
> instruction exception. In particular, MorphOS has an stwx instruction
> with bit 31 set and fails to boot currently because of this. With this
> patch it gets further.
>=20
> ---
> On sam460ex MorhpOS still has problems accessing PCI devices so cannot
> yet boot but does not hit the invalid instruction exception and gets
> further and fails due to not finding boot volume or display controller.
> On mac99 it actually boots but needs an OpenBIOS patch to get USB
> working (needed for mouse and keyboard). I'll prepare some docs on how
> to run different guests but for the impatient here's a little hint:
> -M mac99 -m 512 -vga none -device sm501 \
> -prom-env 'boot-device=3Dcd:,\mac_ppc32\boot.img'
>=20
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>

Applied to ppc-for-3.0, thanks.

> ---
>  target/ppc/translate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index 3a215a1..525d55e 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -6886,7 +6886,7 @@ GEN_HANDLER(stop##u, opc, 0xFF, 0xFF, 0x00000000, t=
ype),
>  #define GEN_STUX(name, stop, opc2, opc3, type)                          =
      \
>  GEN_HANDLER(name##ux, 0x1F, opc2, opc3, 0x00000001, type),
>  #define GEN_STX_E(name, stop, opc2, opc3, type, type2, chk)             =
      \
> -GEN_HANDLER_E(name##x, 0x1F, opc2, opc3, 0x00000001, type, type2),
> +GEN_HANDLER_E(name##x, 0x1F, opc2, opc3, 0x00000000, type, type2),
>  #define GEN_STS(name, stop, op, type)                                   =
      \
>  GEN_ST(name, stop, op | 0x20, type)                                     =
      \
>  GEN_STU(name, stop, op | 0x21, type)                                    =
      \

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--saTAHnV464s+57Yq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAls6zbEACgkQbDjKyiDZ
s5LUFBAA5baa1uFefCfHY3vcoLDXZO5f1GXcYx+P/sqOOVvgO6EojywSKpHG3AIb
9V8DECu84rUaDQnYYlG0o/CZQE0heVz7W3w/5tEWit3x5Y6FRDT2vGxRa1o2h3NS
QamSk3MVbfHhjwtG/TI1iGcrUqiM/58RkUsrvryTpYswd6dZVW7dnYbxCbV6Nnpx
AV+W3UWotezoz15HQ1lhA2jHMxJ7uCDOOYrPF8AS0Rb4KKI5qlGKiOuUTdh5v+eY
E8ucEoaKmWx7L1qxkvdt2EOTUU4hfDeEHy/ttss8tluTttgYh7XsXhKH+cvU5TIe
ukhpdzGPS3iCcddUSdrgn0jNmL2UqXlKR9gEB9FdgLHcYf60NMNIyY4Mr9Blxv6D
hQGxj0ctPBB1PhPvUE6kXU4C2P1FgxE0EAGGSSX3IiT5AMdkgela9vdMq5mo+/zX
lWDrP+23d2s6Li/cO55tVCZecWgSV+B5HMXjxCZFYlkzg/6RBxwE34s08B/RD7Mx
c6lEWzl3FG7rYBH0Q0+eaEB1uuappzCNJcYhlAGnfZpvSWb49/7GRd6Qyh7pwFAO
DcUHal9tjaDVOBsCZ5cgLQ+gy4e2LqQK3JCyIgyD6xc/JuyI4bBO6nNijtTWS5la
0vYKmM0zVevTqXDRX1NTGloZRqHzCyjdVHLqp6+Op44fKSTZpoM=
=Bfuz
-----END PGP SIGNATURE-----

--saTAHnV464s+57Yq--
