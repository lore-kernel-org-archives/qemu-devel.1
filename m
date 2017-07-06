Received: from eggs.gnu.org ([2001:4830:134:3::10]:59770)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dT3XV-0005nY-Mb
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 05:57:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dT3XV-0005Nr-1N
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 05:57:37 -0400
Date: Thu, 6 Jul 2017 10:57:33 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170706095733.GH30447@stefanha-x1.localdomain>
References: <20170702100646.20656-1-el13635@mail.ntua.gr>
	<20170702100646.20656-2-el13635@mail.ntua.gr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PW0Eas8rCkcu1VkF"
Content-Disposition: inline
In-Reply-To: <20170702100646.20656-2-el13635@mail.ntua.gr>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 1/2] block: add clock_type
 field to ThrottleGroup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>
Cc: qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block <qemu-block@nongnu.org>


--PW0Eas8rCkcu1VkF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 02, 2017 at 01:06:45PM +0300, Manos Pitsidianakis wrote:
> Clock type in throttling is currently inferred by the ThrottleTimer's
> clock type even though it is a per-ThrottleGroup property; it doesn't
> make sense to have different clock types in the same group. Moving this
> to a field in ThrottleGroup can simplify some of the throttle functions.
>=20
> Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
> ---
>  block/throttle-groups.c     | 20 ++++++++++----------
>  fsdev/qemu-fsdev-throttle.c |  2 +-
>  include/qemu/throttle.h     |  1 +
>  tests/test-throttle.c       |  4 ++--
>  util/throttle.c             |  4 +++-
>  5 files changed, 17 insertions(+), 14 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--PW0Eas8rCkcu1VkF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZXgmNAAoJEJykq7OBq3PIJx4H/i53OjF4ZQIdbdt1UG67ffaX
8eYlxLAqbD7AUqJ6la82rUD9ZfdDv9XYJ4QXBgzpzqQeG90kNjecKqSOAlWWaeSI
2Ulrt/7K+TDTVXzUd2dTV5H6K0keHQ+jtHK4gbgCjiQxTXik3lkA7SBfr1hkTp6b
jacy+V//cNv6Zlf/nR2LW2PaMEbaX9xIH7NAcEbRxuBt+XfKKaeRdDCzmRhv7DqU
d/tled1zCdSydCrtqWiLra93ehPxSPKP4kqtoe99TmsFDXxr2bvcNVHX8Yyp+8lY
NasPY193awLDUQv70iQOE0QXfyVfQFNyp4PB1lyE7sJTy2LCm+BpWyiJNL9f5bI=
=GvHp
-----END PGP SIGNATURE-----

--PW0Eas8rCkcu1VkF--
