Received: from eggs.gnu.org ([2001:4830:134:3::10]:49578)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fbHbF-0000gK-C9
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 23:40:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fbHbB-0008MO-3u
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 23:40:01 -0400
Received: from ozlabs.org ([203.11.71.1]:42897)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1fbHbA-0008Hd-ND
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 23:39:57 -0400
Date: Fri, 6 Jul 2018 13:39:42 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180706033942.GN3450@umbus.fritz.box>
References: <20180705182001.16537-1-mdavidsaver@gmail.com>
	<20180705182001.16537-4-mdavidsaver@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0kRkyLZR5zsR9u2P"
Content-Disposition: inline
In-Reply-To: <20180705182001.16537-4-mdavidsaver@gmail.com>
Subject: Re: [Qemu-devel] [PATCH 03/14] timer: ds1338 persist 12-hour mode
 selection
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Davidsaver <mdavidsaver@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, Antoine Mathys <barsamin@gmail.com>, qemu-devel@nongnu.org


--0kRkyLZR5zsR9u2P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 05, 2018 at 11:19:50AM -0700, Michael Davidsaver wrote:
11;rgb:ffff/ffff/ffff> Need to save HOUR[HOUR12] bit to keep
> track of guest selection of 12-hour mode.
> Write through current time registers to
> achieve this.  Will be overwritten
> by the next read/latch.
>=20
> This was only being done in two of three
> arms of this conditional block.
>=20
> Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>

This looks dubious to me, or at least the explanation of it does.  The
other branch of the conditional is covering different registers in the
device, which are part of the RTC component, rather than the NVRAM
area.  I wouldn't necessarily expect them to persist data as a rule
the way the rest of the block does, even if this specific bit does
need to be preserved.

> ---
>  hw/timer/ds1338.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/hw/timer/ds1338.c b/hw/timer/ds1338.c
> index 7298c5af43..b56db5852e 100644
> --- a/hw/timer/ds1338.c
> +++ b/hw/timer/ds1338.c
> @@ -220,10 +220,8 @@ static int ds1338_send(I2CSlave *i2c, uint8_t data)
>             value unchanged. */
>          data =3D (data & ~CTRL_OSF) | (data & s->nvram[s->ptr] & CTRL_OS=
F);
> =20
> -        s->nvram[s->ptr] =3D data;
> -    } else {
> -        s->nvram[s->ptr] =3D data;
>      }
> +    s->nvram[s->ptr] =3D data;
>      inc_regptr(s);
>      return 0;
>  }

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--0kRkyLZR5zsR9u2P
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAls+5HsACgkQbDjKyiDZ
s5LjxhAA2rOmlPHnmVh3GT+GF14Ajx5hxvElb2W0NwFbLgAqxSThRFBHQyxjLcIW
Ld+QdD7eC+chkrs5r9k1qcU9MgSPAxMqM4piGrsOMSWGoF+7Tu9uqw+7fQqnVdar
SNv5fz4Knq/ZMiQm0gM6jbvL5aeInYyZAONlzFOmXkwXMJeB6AnR92Gf9gUCgQvr
870Ya0698RWGrtH5gX0jmy8cqP3/nLlamnKOe85kNe7QY+xCCx+Zx/ctvnWaeZxZ
nisz+wsjmFP8WD/Nlds37CbsxOOFScnUE/wmNCkpGB02m5U3bvQHVe3VutwJLwvu
jgyfvG0QuWniPpp9M6wyQ6JtXDDfpsYlQKwfvoK74Zd6TBCtr5r/4oc4/Gvghvsu
G3tf5dE/bkAReb18BbwUJTYipfwdUi0IP534zieQk5T0jBy70dhlv6gk7jaDHZTs
jZ2XbOdSWe5SDXEtHYyZkE0M0H6Skn2WxPSMvXadrkGciRYm49nFk9gLRaxTanZ/
vPyKi1UvFIRHZtfYFffbsJ5L+9yl9dxyHdzfOxmenXAnO/VlreqEdw8tm9on2l3O
K0coYFjNgl5G4gy6W0ZV6wk1n3QjmBtGIiR5uPo3xdrV6m8qCm61isJHMxITsxik
VVil+rbK2F5LrviOGF3XszVEpmY+qCe14J8QaGlikk/9nVTzgoE=
=DDjF
-----END PGP SIGNATURE-----

--0kRkyLZR5zsR9u2P--
