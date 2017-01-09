Received: from eggs.gnu.org ([2001:4830:134:3::10]:50023)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cRFXy-00043W-Gj
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 04:50:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cRFXt-0001Ge-Dv
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 04:50:22 -0500
Date: Mon, 9 Jan 2017 13:21:47 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170109132147.GD30228@stefanha-x1.localdomain>
References: <20161129113334.605-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tEFtbjk+mNEviIIX"
Content-Disposition: inline
In-Reply-To: <20161129113334.605-1-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH for-2.9] block: get rid of
 bdrv_io_unplugged_begin/end
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org


--tEFtbjk+mNEviIIX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 29, 2016 at 12:33:34PM +0100, Paolo Bonzini wrote:
> bdrv_io_plug and bdrv_io_unplug are only called (via their
> BlockBackend equivalents) after starting asynchronous I/O.
> bdrv_drain is not going to be called while they are running,
> because---even if a coroutine runs for some reason---it will
> only drain in the next iteration of the event loop through
> bdrv_co_yield_to_drain.
>=20
> So this mechanism is unnecessary, get rid of it.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  block/io.c                | 41 ++---------------------------------------
>  include/block/block.h     |  2 --
>  include/block/block_int.h |  3 +--
>  3 files changed, 3 insertions(+), 43 deletions(-)

Thanks, applied to my block tree:
https://github.com/stefanha/qemu/commits/block

Stefan

--tEFtbjk+mNEviIIX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYc45qAAoJEJykq7OBq3PI1zgH/37Rd8zyXHdknfESvEx6IYRk
uNh0Zp/QLJTdOT0e66o1tb93yjqOXAartEVE9jV0p8pVj2hRuZLD0kyNweu2oJMS
azF0ylv2h3Mc1ETI5Uq0y2JAbM4L5n2XnFORhkBrVIBhnekrft5mD1JE9Wez3eue
WGSw5lFrOht4R2kdhBDAixzttcxbnIjzFWf7uMXfteUM5L9wcEJVe7NgSuM2FZ1v
EjBPFLSS7dISPHmVrtsyJqyPnKHxv03qISymHqE+v6OiuaEEA3UW0s26QbN+/ybY
leDTk2f8bmTFq/NpDxXzy9T8roCSnLnpo1/hHSF/yihxtgJ8GS6k8stTdzyVb1g=
=YaZO
-----END PGP SIGNATURE-----

--tEFtbjk+mNEviIIX--
