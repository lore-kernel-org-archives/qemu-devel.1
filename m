Received: from eggs.gnu.org ([2001:4830:134:3::10]:35739)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eNFev-0007Yk-NV
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 05:13:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eNFeu-0006Vs-RI
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 05:13:33 -0500
Date: Fri, 8 Dec 2017 10:13:25 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20171208101325.GD23880@stefanha-x1.localdomain>
References: <cover.1512589016.git.mark.kanda@oracle.com>
	<e7b259772e3e075ae4b08778a27139b9db8d3bf9.1512589016.git.mark.kanda@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8w3uRX/HFJGApMzv"
Content-Disposition: inline
In-Reply-To: <e7b259772e3e075ae4b08778a27139b9db8d3bf9.1512589016.git.mark.kanda@oracle.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] virtio-blk: make queue size
 configurable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Kanda <mark.kanda@oracle.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, martin.petersen@oracle.com, konrad.wilk@oracle.com, ameya.more@oracle.com, stefanha@redhat.com, karl.heubaum@oracle.com


--8w3uRX/HFJGApMzv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 06, 2017 at 01:54:00PM -0600, Mark Kanda wrote:
> Depending on the configuration, it can be beneficial to adjust the virtio=
-blk
> queue size to something other than the current default of 128. Add a new
> property to make the queue size configurable.
>=20
> Signed-off-by: Mark Kanda <mark.kanda@oracle.com>
> Reviewed-by: Karl Heubaum <karl.heubaum@oracle.com>
> Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
> Reviewed-by: Ameya More <ameya.more@oracle.com>
> ---
>  hw/block/virtio-blk.c          | 7 ++++++-
>  include/hw/virtio/virtio-blk.h | 1 +
>  2 files changed, 7 insertions(+), 1 deletion(-)

Please see commit 9b02e1618cf26aa52cf786f215d757506dda14f8 ("virtio-net:
enable configurable tx queue size") for additional considerations.
QEMU's virtio implementation hardcodes the maximum queue size at 1024
and this limit must be checked.

--8w3uRX/HFJGApMzv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaKmXFAAoJEJykq7OBq3PIU14IAIC1DWVGOUJNAHioumnYcbJj
UcJc0p8CqBPog/+P4u6d992GVhpXME3TYLJW1TRR0ix2VJ1xtNXW7w98PKzI5abZ
kQbVlC4NMH6QMpTOAuUDHyEBYvExX7iXhX5eugyAe+fE35HBpqi8O0KOVuUu0PAt
fYZ7mGzFiUwM9ICW3vNF2356aqZMNiHBinTsz6Oi6vLdwMsn2Pf7Sutghl6yLvh0
LE9J30uv5xIfJX7Rt6anAmU4YsjOjJ3vMR/swyycHVBOAjpPuAZhcpYf7RpQx/2q
Rgthc0zKHnGLXlZsp9j0oIIt1IZLOCl4zVHnPBR2cmv7C7Zx93c40XjYmnvSbPs=
=5/+p
-----END PGP SIGNATURE-----

--8w3uRX/HFJGApMzv--
