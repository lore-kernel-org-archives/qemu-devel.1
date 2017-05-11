Received: from eggs.gnu.org ([2001:4830:134:3::10]:56628)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d8uio-0005Mu-U0
	for qemu-devel@nongnu.org; Thu, 11 May 2017 16:30:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d8uil-0008Ht-0g
	for qemu-devel@nongnu.org; Thu, 11 May 2017 16:30:02 -0400
Date: Thu, 11 May 2017 16:29:55 -0400
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170511202955.GO24584@stefanha-x1.localdomain>
References: <20170419094356.19826-1-famz@redhat.com>
	<20170419094356.19826-13-famz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PtLnLSExlPr13a2X"
Content-Disposition: inline
In-Reply-To: <20170419094356.19826-13-famz@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 12/16] virtio-blk: Request
 BLK_PERM_AIO_CONTEXT_CHANGE for dataplane
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>


--PtLnLSExlPr13a2X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 19, 2017 at 05:43:52PM +0800, Fam Zheng wrote:
> blk_set_aio_context is audited by perm API, so follow the protocol and
> request for permission first.
>=20
> Previously the return code in error path was hardcoded as -EPERM, but
> returning 'r' is more meaningful here both for the new error and
> existing ones.
>=20
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  hw/block/dataplane/virtio-blk.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--PtLnLSExlPr13a2X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZFMnDAAoJEJykq7OBq3PID84H/iHzhxbGlzpEnmfQK7XYqOFB
0o3Et9X6XmRdnmVmzbYumO01UmMgXYixWhZyZsPWtm1b2d+MM+ljpQDMDPTLkDkk
6GKuKe3dWLTu/uF2J4IrlRPMHOQvRmbTW0D/q3xSjzsAuwR0ZBgBaY+plz4EwYFZ
EBT7tqGV7iqY/7dMCqLvlibxY/P03u2wGrHKaDW6Kklhto3Al3ttrIBptcuWeXxX
YoYdhpbBHYxIXwroHqfkLVQ1AiG7hq5HCN3NO05Ld47GSqp9N7Je02txMZi1tS1v
Ws7yIj4R9V56djkjjJdGl687C6jAUEuHr/XTjFibVIUu03SJpEK9CtDpla4lE3c=
=Aeeo
-----END PGP SIGNATURE-----

--PtLnLSExlPr13a2X--
