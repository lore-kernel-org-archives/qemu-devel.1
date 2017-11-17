Received: from eggs.gnu.org ([2001:4830:134:3::10]:54279)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eFjCX-0003fQ-3G
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 11:09:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eFjCW-000185-0s
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 11:09:09 -0500
References: <20171115180732.31753-1-mreitz@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <9b26c222-c842-d839-f172-0db9059f7c28@redhat.com>
Date: Fri, 17 Nov 2017 17:09:00 +0100
MIME-Version: 1.0
In-Reply-To: <20171115180732.31753-1-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="bvV5siqs6Qw7WwGqi3RBiLIgspWCESCd0"
Subject: Re: [Qemu-devel] [PATCH] iotests: Make 087 pass without AIO enabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bvV5siqs6Qw7WwGqi3RBiLIgspWCESCd0
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <9b26c222-c842-d839-f172-0db9059f7c28@redhat.com>
Subject: Re: [PATCH] iotests: Make 087 pass without AIO enabled
References: <20171115180732.31753-1-mreitz@redhat.com>
In-Reply-To: <20171115180732.31753-1-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-11-15 19:07, Max Reitz wrote:
> If AIO has not been enabled in the qemu build that is to be tested, we
> should skip the "aio=3Dnative without O_DIRECT" test instead of failing=
=2E
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
> Cleber wanted to fix this in July with his "build configuration query
> tool and conditional (qemu-io)test skip" series
> (https://lists.gnu.org/archive/html/qemu-block/2017-07/msg01303.html),
> but unfortunately there hasn't been any activity on that (as far as I
> can see), so let's just solve it the simple way.
> ---
>  tests/qemu-iotests/087 | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)

Applied to my block branch:

https://github.com/XanClic/qemu/commits/block

Max


--bvV5siqs6Qw7WwGqi3RBiLIgspWCESCd0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAloPCZ0SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AHM0H/iXvWj/WOVDBlACewppX8IxRXBeztS6o
nKTjw0QU/G8jMdVvJ9l5ilL7Az4PFkHzOYla0hs1vUlF29B2IjedQW0bpjUUlH5v
sU3MUMxrGi3F3BGBKfupEXHUJR+nqoT01ThSXXheDkdnStDo0O6BMH3fMBOJT9nU
OXAHHinkA5qrs9GMC7sy5uD4J/uMVthKf0CBiLMOcyve+yf2N6OIDzNNSqHIN50X
piGI9qcgDSzLV2XB9U6wJsbdjjpY8NqfzV7IO7wCTYIHoFDBVVsCH45TrjMxIWHl
kUefISeYshvoBnsCvCn+5JwUg0Pz03zjKRpHiD9A/V2zWHWmMFFfNyA=
=jm3n
-----END PGP SIGNATURE-----

--bvV5siqs6Qw7WwGqi3RBiLIgspWCESCd0--
