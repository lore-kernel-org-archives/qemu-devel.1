Received: from eggs.gnu.org ([2001:4830:134:3::10]:56289)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d8uh4-0004c4-Rp
	for qemu-devel@nongnu.org; Thu, 11 May 2017 16:28:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d8uh0-0006dS-Um
	for qemu-devel@nongnu.org; Thu, 11 May 2017 16:28:14 -0400
Date: Thu, 11 May 2017 16:28:06 -0400
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170511202806.GN24584@stefanha-x1.localdomain>
References: <20170419094356.19826-1-famz@redhat.com>
	<20170419094356.19826-12-famz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nb8zVy0QMK3AA1xu"
Content-Disposition: inline
In-Reply-To: <20170419094356.19826-12-famz@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 11/16] virtio-scsi: Request
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


--nb8zVy0QMK3AA1xu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 19, 2017 at 05:43:51PM +0800, Fam Zheng wrote:
> blk_set_aio_context is audited by perm API, so follow the protocol and
> request for permission first.
>=20
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  hw/scsi/virtio-scsi.c | 4 ++++
>  1 file changed, 4 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--nb8zVy0QMK3AA1xu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZFMlWAAoJEJykq7OBq3PIvPwIAKh0sJgeIb+OWhrokaT02HHs
fjm6jaEceBlPdBMmyvcs33qft9nd+ZHjizMZJ8okVbGBX5MaSay2yuN04Gb9bODP
VZLC3DHa32sg+TTcxtijg1MNBczMVc/L8dyljZ6XNTd1mtf1jcelt3VcyZYRXFH0
NEqn0cABwjrp+EhS0ioX/A8I8I+OjUWiAgrlajhmGyxaMV6SkIlhYU4OrN1j4ty4
7wHDrnncos5hhDQDZtd7RcaLC8FAJqUdMh1di4im+kCvfkauDdVtoa4nz1P8+eTP
EltyIDeaors2fnSM1hS/inH3pdWnNlS3rVr3KQTywuqwZ6gjpKxfzbO11uzy4FI=
=srGB
-----END PGP SIGNATURE-----

--nb8zVy0QMK3AA1xu--
