Received: from eggs.gnu.org ([2001:4830:134:3::10]:53747)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eOM8e-0002P5-7x
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 06:20:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eOM8c-0003a3-LQ
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 06:20:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42208)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eOM8c-0003ZP-F4
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 06:20:46 -0500
Date: Mon, 11 Dec 2017 11:20:43 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171211112043.GH13593@stefanha-x1.localdomain>
References: <151274317380.5376.485467933490492379.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qM81t570OJUP5TU/"
Content-Disposition: inline
In-Reply-To: <151274317380.5376.485467933490492379.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH] tests: virtio-9p: fix ISR dependence
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org


--qM81t570OJUP5TU/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 08, 2017 at 03:26:13PM +0100, Greg Kurz wrote:
> Like other virtio tests, use the used ring APIs instead of assuming ISR
> being set means the request has completed.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  tests/virtio-9p-test.c |   30 +++++++++++-------------------
>  1 file changed, 11 insertions(+), 19 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--qM81t570OJUP5TU/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaLmoLAAoJEJykq7OBq3PIc+MH/jOkxsWhxs6YIS2wZEvDlvtH
SQbBqNlQ0RiOyPv6JrIMF1dw+YRM4JL4CcULmgFucQzXDuw/Qek6DPs3Y9hH46Tq
RPf0cUzc2ptswhwZu//oVcXGdKwu9E4ZDOXomd2Kzs8bqVKysPdcJa2hsz/ECnk5
bCjqGfpO7AmXsoM3X5apvEBrq3BrF2Eazcp3SeMGuavg/KWGvoDMDLK9MaYCEmWS
y3C655CJRmuvL1xdmOSR5xT0iuHk1r+j/H663NEZ7Q6igUpX4590DW7iCOlPEWhu
kCWnQv1AcI1Oib9qApwCQTNTnn71wcvmFeblshrdQPktiUPI3qUJBSj+twrS5xw=
=yUAD
-----END PGP SIGNATURE-----

--qM81t570OJUP5TU/--
