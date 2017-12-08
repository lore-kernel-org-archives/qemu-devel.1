Received: from eggs.gnu.org ([2001:4830:134:3::10]:35855)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eNFf5-0007hf-7Y
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 05:13:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eNFf4-0006hL-7O
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 05:13:43 -0500
Date: Fri, 8 Dec 2017 10:13:33 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20171208101333.GE23880@stefanha-x1.localdomain>
References: <cover.1512589016.git.mark.kanda@oracle.com>
	<0a69463200d64d81dc27898ff92ecd10b126d968.1512589016.git.mark.kanda@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="r7U+bLA8boMOj+mD"
Content-Disposition: inline
In-Reply-To: <0a69463200d64d81dc27898ff92ecd10b126d968.1512589016.git.mark.kanda@oracle.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] virtio-blk: reject configs with
 logical block size > physical block size
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


--r7U+bLA8boMOj+mD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 06, 2017 at 01:54:01PM -0600, Mark Kanda wrote:
> virtio-blk logical block size should never be larger than physical block
> size because it doesn't make sense to have such configurations. QEMU does=
n't
> have a way to effectively express this condition; the best it can do is
> report the physical block exponent as 0 - indicating the logical block si=
ze
> equals the physical block size.
>=20
> This is identical to commit 3da023b5827543ee4c022986ea2ad9d1274410b2
> but applied to virtio-blk (instead of virtio-scsi).
>=20
> Signed-off-by: Mark Kanda <mark.kanda@oracle.com>
> Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> Reviewed-by: Ameya More <ameya.more@oracle.com>
> ---
>  hw/block/virtio-blk.c | 7 +++++++
>  1 file changed, 7 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--r7U+bLA8boMOj+mD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaKmXNAAoJEJykq7OBq3PI/40H/RT/Fng3Qk5U8LzC6suJunWW
IQBtFfkHdVM64IeY6YEieMO81P3xL4imyXAFfZW3BoxdXVGGs5R9yEMD5YWG8o3G
4mhiyYjaR1ohimSslupUGxGs7iGvCUe+Yw7kQK/Z7jInrASndU0EZFMu1dsfScWm
PPvz3aw1ihmJZepklmyKMxO9vwziNj1AcX8utkI2zl7/8AR0jFYc6xVPw7j+RW83
IMblxMOQt5U37AyLgglr3EFoyW4upnPvVzh0j6Mxq8coRQea8G9SoVGbeWgngm32
kFJYPp9x7qmDOXp8nb/hW0I7ECEi+JKIECYx1viGIR1b6FCTaObxjnOSag8ASGI=
=8cvX
-----END PGP SIGNATURE-----

--r7U+bLA8boMOj+mD--
