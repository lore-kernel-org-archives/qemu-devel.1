Received: from eggs.gnu.org ([2001:4830:134:3::10]:59759)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dT3XU-0005nX-Li
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 05:57:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dT3XQ-0005IN-RG
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 05:57:36 -0400
Date: Thu, 6 Jul 2017 10:57:28 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170706095728.GG30447@stefanha-x1.localdomain>
References: <20170702100646.20656-1-el13635@mail.ntua.gr>
	<20170702100646.20656-3-el13635@mail.ntua.gr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="t4apE7yKrX2dGgJC"
Content-Disposition: inline
In-Reply-To: <20170702100646.20656-3-el13635@mail.ntua.gr>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 2/2] block: remove timer
 canceling in throttle_config()
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


--t4apE7yKrX2dGgJC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 02, 2017 at 01:06:46PM +0300, Manos Pitsidianakis wrote:
> throttle_config() cancels the timers of the calling BlockBackend. This
> doesn't make sense because other BlockBackends in the group remain
> untouched. There's no need to cancel the timers in the one specific
> BlockBackend so let's not do that. Throttled requests will run as
> scheduled and future requests will follow the new configuration. This
> also allows a throttle group's configuration to be changed even when it
> has no members.
>=20
> Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
> ---
>  block/throttle-groups.c     | 10 +---------
>  fsdev/qemu-fsdev-throttle.c |  2 +-
>  include/qemu/throttle.h     |  1 -
>  tests/test-throttle.c       |  4 ++--
>  util/throttle.c             | 14 --------------
>  5 files changed, 4 insertions(+), 27 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--t4apE7yKrX2dGgJC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZXgmIAAoJEJykq7OBq3PIkAAH/RVcqFuow8JHFA/RqNqB+BCc
Lxq7Fmp3s4KHc8UHgJT7bXnkzkiR/S+rS+VNEIDvJ/6NseVmqo5g9sboVMYlg+eQ
XXVgoxdD9nlXw8hPnWYzqpkdPHHu/qWd+Zdm3FaWHoBkkpuN8RnF1Dexxgc05eTw
36yMoq3RDKooTk/QjOiqJeXqlbj9b4j5LmTUN7afEiDcVUPn1hI6p27kfH0GBr23
NohAzmFFhDusvDG7S/GD+tkECmZWHZIa3dmbK9Dxj1uqsYfhJhBE4eDZ8rYW/PHp
dJ5ohM1VJdPheAbXmRrWBEV/tW3fm0FT6Q73mFBOmlc3h5dWZQfbPbfQiNZwtRM=
=UDKC
-----END PGP SIGNATURE-----

--t4apE7yKrX2dGgJC--
