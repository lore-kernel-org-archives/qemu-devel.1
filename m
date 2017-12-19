Received: from eggs.gnu.org ([2001:4830:134:3::10]:46632)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eR9o0-0007rD-BW
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 23:47:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eR9nz-0002Jn-FK
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 23:47:04 -0500
Date: Tue, 19 Dec 2017 15:46:55 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171219044655.GJ4786@umbus.fritz.box>
References: <20171209084338.29395-1-clg@kaod.org>
	<20171209084338.29395-2-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ZG+WKzXzVby2T9Ro"
Content-Disposition: inline
In-Reply-To: <20171209084338.29395-2-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v2 01/19] dma-helpers: add a return value
 to store helpers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Greg Kurz <groug@kaod.org>


--ZG+WKzXzVby2T9Ro
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 09, 2017 at 09:43:20AM +0100, C=E9dric Le Goater wrote:
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Hrm.  I know I (indirectly) suggested this, but now that I see it, I'm
thinking adding return values here but not on the read side (which
would be awkward since they return the read values) seems like not a
great idea.

So I'm ok with just open coding the dma_memory_write()s after all.

> ---
>  include/sysemu/dma.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/include/sysemu/dma.h b/include/sysemu/dma.h
> index c228c6651360..74a9558af39c 100644
> --- a/include/sysemu/dma.h
> +++ b/include/sysemu/dma.h
> @@ -153,12 +153,12 @@ static inline void dma_memory_unmap(AddressSpace *a=
s,
>          dma_memory_read(as, addr, &val, (_bits) / 8);                   \
>          return _end##_bits##_to_cpu(val);                               \
>      }                                                                   \
> -    static inline void st##_sname##_##_end##_dma(AddressSpace *as,      \
> +    static inline int st##_sname##_##_end##_dma(AddressSpace *as,      \
>                                                   dma_addr_t addr,       \
>                                                   uint##_bits##_t val)   \
>      {                                                                   \
>          val =3D cpu_to_##_end##_bits(val);                              =
  \
> -        dma_memory_write(as, addr, &val, (_bits) / 8);                  \
> +        return dma_memory_write(as, addr, &val, (_bits) / 8);           \
>      }
> =20
>  static inline uint8_t ldub_dma(AddressSpace *as, dma_addr_t addr)

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ZG+WKzXzVby2T9Ro
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlo4mb8ACgkQbDjKyiDZ
s5LvmxAAvkIhyEa9Ue8UNTwyQlRQBNAq8WefMNgiqz1npKxpNBUtOdWt/BEiAPGV
7OJcaEYHk2aORPLteHwZpRwJGMkDOIR5PjNxu5met8uNFcYFFadlE0Y2eVqbdSdV
KImWxEEpzhBn/+f050+kn9Juy/v6L5ah1Sd8Bd722tawhEPPcXynNTT7pLRvyff6
rguryFnScu/WjbsJi9P2bmLNji8OHsNi0n6YJtCv8ZYCdbqx280LdeR7mreKtbeq
IV+SI5fk5zy/tH/8UbTA8W65x8IBhG/r0lEESIec3pT9dMr9MMSVlOaUnh2isBEW
SO7qScmXPt9WFNDtuRY9xnnEl46FoaMb8iuHF8bOAltxyCOBHF+owpp0nKKcVv2g
CALbopsqNahVZsSUJU+Ii9S8tSX90d9z4hqWPO6AFTXXVhgBRQz9TehwmJwH0iR/
k+yyysd6xwydE+TPKyZegBIWltaZMUhJc3atnRida7cGSCLk3LCMlgbO0agWgLcs
V3yfZqz3kPPBUTHaukWWQZgonL/5/H8ruXu1fYXnIWblzBndat//qhUirLHrUd9W
16QirM9vlGUzpFzVwWfph41RyRG3JwEtZOGcutpbN71h05JpoArPNXXH6OobSzaO
a1THTcgY7D1qbI+ZIsqSw5bXe0xkz4dOP7FthPeVU6WrUlmsy/c=
=lM08
-----END PGP SIGNATURE-----

--ZG+WKzXzVby2T9Ro--
