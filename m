Received: from eggs.gnu.org ([2001:4830:134:3::10]:35283)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cnajc-00046b-3S
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 20:54:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cnaja-0007GL-Rf
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 20:54:44 -0400
Date: Tue, 14 Mar 2017 11:21:13 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170314002113.GA12564@umbus.fritz.box>
References: <20170313093104.1280-1-nikunj@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="envbJBWh7q8WU6mo"
Content-Disposition: inline
In-Reply-To: <20170313093104.1280-1-nikunj@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH fix for-2.9] target/ppc: fix cpu_ov setting
 for 32-bit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Cc: qemu-ppc@nongnu.org, mark.cave-ayland@ilande.co.uk, qemu-devel@nongnu.org, rth@twiddle.net


--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 13, 2017 at 03:01:04PM +0530, Nikunj A Dadhania wrote:
> A bug was introduced in following commit:
>=20
>     dc0ad84 target/ppc: update overflow flags for add/sub
>=20
> As for 32-bit ppc target extracting bit 63 for overflow is not correct.
> Made it dependent on TARGET_LOG_BITS. This had broken booting MacOS
> 9.2.1 image
>=20
> Reported-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>

Applied to ppc-for-2.9, thanks.

> ---
>  target/ppc/translate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index b6abc60..f40b5a1 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -818,7 +818,7 @@ static inline void gen_op_arith_compute_ov(DisasConte=
xt *ctx, TCGv arg0,
>          if (is_isa300(ctx)) {
>              tcg_gen_extract_tl(cpu_ov32, cpu_ov, 31, 1);
>          }
> -        tcg_gen_extract_tl(cpu_ov, cpu_ov, 63, 1);
> +        tcg_gen_extract_tl(cpu_ov, cpu_ov, TARGET_LONG_BITS - 1, 1);
>      }
>      tcg_gen_or_tl(cpu_so, cpu_so, cpu_ov);
>  }

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--envbJBWh7q8WU6mo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYxzd3AAoJEGw4ysog2bOSS3oQAJ702xbhzk89fs+lczJwkOkd
epP6E8gh8VvYJga6Cy61o5odLZiOnSjCbMCDPk8I8M3addP6xIgGyq4k3JKGzT0u
RCMSXxYhh9Tzp/lABBsN64TnuYaAEL636+rr/Ly/rmqKHa+ohuC5W0o2f4hdGDeQ
03l7cRHAiiSSuOpvaHgqkz1aR+gtMEuBuuORISTJ45fss65/UFzAqbrN4rGqWTpp
3clrKL13pxmN0CKVC5b7YcZaHgafgWvbpi9IRvKL+8X+t6y13tw2avMTdupbCiKy
IKokWp+uM2/0QI7wvBcgQ8LYgweuTsGcwX0cPTOcHG843IV07FyTg+vdaIZJsTjt
//3xAkGU27yQyF0MhDupD6xIKe+HhJnrV9QzIgwqxPuS9nh6rAURZH7k6z0XYgFi
OCTGM7MIknJgbYTQfJZk7KQXO75jD56w0G0cZPhKENeIRyoABASCljc5YDQjEaQV
yp9MRhVFDufWJdIiMKNYTTsb232/nxrQRAI2Ih408oC5PJY7tlwpuOPGsSbLzMbo
A500BiyU+pwX5aa9I3PRcl4AofRgCucZhkHecJuhQja+o6aCa+fI9W6NSrVlpVcg
O4vKKQtD3rzOe6cFXqg+M58CwLvtsUj+V1J2S+92UXZ9pLtm7ubYvxVyfnHcqyph
EQkeiyYc6XwBDbiVpAXi
=qRPU
-----END PGP SIGNATURE-----

--envbJBWh7q8WU6mo--
