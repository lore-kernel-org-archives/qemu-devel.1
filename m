Received: from eggs.gnu.org ([2001:4830:134:3::10]:60056)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1ffowS-0004Ij-Fc
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 12:04:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1ffowO-0003Vm-Hx
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 12:04:40 -0400
Date: Wed, 18 Jul 2018 17:04:33 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180718160433.GQ21825@stefanha-x1.localdomain>
References: <20180712192603.11599-1-sw@weilnetz.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Y9o+fgG4MNl0mnzl"
Content-Disposition: inline
In-Reply-To: <20180712192603.11599-1-sw@weilnetz.de>
Subject: Re: [Qemu-devel] [PATCH] configure: Support pkg-config for zlib
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Weil <sw@weilnetz.de>
Cc: QEMU Developer <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>


--Y9o+fgG4MNl0mnzl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 12, 2018 at 09:26:03PM +0200, Stefan Weil wrote:
> This is needed for builds with the mingw64-* packages from Cygwin,
> but also works for Linux.
>=20
> Move the zlib test also more to the end because users should
> get information on the really important missing packages
> (which also require zlib) first.
>=20
> Signed-off-by: Stefan Weil <sw@weilnetz.de>
> ---
>  configure | 40 +++++++++++++++++++++++-----------------
>  1 file changed, 23 insertions(+), 17 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--Y9o+fgG4MNl0mnzl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbT2URAAoJEJykq7OBq3PIkCMIAJiDUGsZBBrvQL2fVs0W2HyD
TpIAAWPMXpbn5a6q03d3Mtx+12iJWIbVjks2mKTw/fzipC7kA/4qbzTGuG9osOz1
Oc/aYVh3O29UfWrOZD4DvneSOR87PmRGiJ9yCZq5hQwtUPCHerXIeAJwE7raCnYD
IC91mhltSaCScw9fc4SpiyhQo01Vw2XTc1HlI2zvK2l8FTer0jLXJd9OLddJ9/J4
hXGrAriM1x9oSAptvNxBExlsjDSkPG7O2yjzX2hETi66b5fafDRzQaHm3VixtfYA
o1WiddzaQWsCfdB7k5kJSEV/0oAiQDMpRxcAmGA3oGOYXsKh4jH2kboOXaeshrg=
=0xRw
-----END PGP SIGNATURE-----

--Y9o+fgG4MNl0mnzl--
