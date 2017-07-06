Received: from eggs.gnu.org ([2001:4830:134:3::10]:53377)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dT3HT-00054Q-Nc
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 05:41:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dT3HO-00053x-Ti
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 05:41:03 -0400
Date: Thu, 6 Jul 2017 10:40:54 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170706094054.GD30447@stefanha-x1.localdomain>
References: <20170629184320.7151-1-el13635@mail.ntua.gr>
	<20170629184320.7151-3-el13635@mail.ntua.gr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="at6+YcpfzWZg/htY"
Content-Disposition: inline
In-Reply-To: <20170629184320.7151-3-el13635@mail.ntua.gr>
Subject: Re: [Qemu-devel] [PATCH v2 2/3] block: use defaults of bdrv_*
 callbacks in raw
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>
Cc: qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>


--at6+YcpfzWZg/htY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 29, 2017 at 09:43:19PM +0300, Manos Pitsidianakis wrote:
> Now that passing the call to bs->file is the default for some bdrv_*
> callbacks, remove the duplicate implementations in block/raw-format.c
>=20
> Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
> ---
>  block/raw-format.c | 32 +-------------------------------
>  1 file changed, 1 insertion(+), 31 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--at6+YcpfzWZg/htY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZXgWmAAoJEJykq7OBq3PIGrkIAI+1N+e63tkTEisuZvcO99Jx
VNeDDXDpV5zRLfawoFQ24H9XDtnR2LX0cEV+oUJVYp6P/GJRuGX4M6mE270wk45Y
LRIBdUGxJASSjxPNj+WsLnMwdZIGED5k/tfA/bDx+OY1tjfuADy1Osst6ExvrltJ
NQ95zO4ZK2PHG/9lY5RAcW3Mc2CrlgSKT7SEktkMPP0ZRA4ngdXe7K2Y99zodYwQ
Ym5eS+Ezf9aAlnop7/eAXPXRo9KCeVYkILtfLH1gIh7zEpw28FROLK+5yZiTg27N
gT5Tsz22pZGmJqQgcdQ3HhWd63V7xM7uhxclDs5Vq7SOE3RR/3n5480AnQ+Cn2I=
=Y4Au
-----END PGP SIGNATURE-----

--at6+YcpfzWZg/htY--
