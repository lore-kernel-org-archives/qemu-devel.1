Received: from eggs.gnu.org ([209.51.188.92]:44457)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ggtyF-00083K-E6
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 11:11:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ggtyE-0001yZ-Nn
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 11:11:15 -0500
Date: Tue, 8 Jan 2019 16:11:02 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190108161102.GH32358@stefanha-x1.localdomain>
References: <20190105084243.9524-1-npes87184@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YrlhzR9YrZtruaFS"
Content-Disposition: inline
In-Reply-To: <20190105084243.9524-1-npes87184@gmail.com>
Subject: Re: [Qemu-devel] [PATCH] qemu-iotests: add test case for dmg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kwolf@redhat.com
Cc: qemu-devel@nongnu.org, yuchenlin <npes87184@gmail.com>, mreitz@redhat.com, qemu-block@nongnu.org


--YrlhzR9YrZtruaFS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 05, 2019 at 04:42:43PM +0800, yuchenlin wrote:
> Recently, some bugs in dmg file have been fixed. To prevent reading dmg
> is broken someday in the future, add a simple test which ensures the
> conversion from dmg to raw should not hang or face any I/O error.
>=20
> Signed-off-by: yuchenlin <npes87184@gmail.com>
> ---
>  tests/qemu-iotests/236                        |  53 ++++++++++++++++++
>  tests/qemu-iotests/236.out                    |   4 ++
>  tests/qemu-iotests/check                      |   7 +++
>  tests/qemu-iotests/group                      |   1 +
>  .../sample_images/simple-dmg.dmg.bz2          | Bin 0 -> 3479 bytes
>  5 files changed, 65 insertions(+)
>  create mode 100755 tests/qemu-iotests/236
>  create mode 100644 tests/qemu-iotests/236.out
>  create mode 100644 tests/qemu-iotests/sample_images/simple-dmg.dmg.bz2

Kevin: The prerequisite .dmg fixes are already in qemu.git/master.
Please review and take this through your tree, thanks!

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--YrlhzR9YrZtruaFS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcNMuWAAoJEJykq7OBq3PIqeEIAMgEGiYxrG1brWcxT+50en7v
l1qjuRKlnm6Ki/MIMwpxBxfItScsK9UZqLJXs/GSVfwa6ypgVoebUZNSMYVIWoc1
Jolz1TBpdskhU+ioha7utHF+GuveHdFJY3jAufMWXjdTx8VWl00aMoZfbGHB7zff
TXGdcb4MHVV3amH0X4G5Q7QfxvMmI6jnt+/Zdouu63FZ8txCBBZif7MLlM8YOlY/
YTafzxECrMpK8f6NUfV39urMecWZSMb/Qs1TQAQ6TwtwKiq4tc3ip2crt8r22/pb
8TDcH4Z+/K3Ycj00fm3I0b+yHRw1DpulzesgAAbwu7W7B+KqClSE8z5KKvO+0mk=
=s9hg
-----END PGP SIGNATURE-----

--YrlhzR9YrZtruaFS--
