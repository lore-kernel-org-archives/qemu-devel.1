Received: from eggs.gnu.org ([2001:4830:134:3::10]:40885)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eKoUd-0007xj-BU
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:48:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eKoUc-0008Kt-JK
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:48:51 -0500
Date: Fri, 1 Dec 2017 10:06:57 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20171201100657.GF23501@stefanha-x1.localdomain>
References: <20171129155942.5646-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="iBwuxWUsK/REspAd"
Content-Disposition: inline
In-Reply-To: <20171129155942.5646-1-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.12] iotests: Make 200 run on tmpfs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org


--iBwuxWUsK/REspAd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2017 at 04:59:42PM +0100, Max Reitz wrote:
> 200 currently fails on tmpfs because it sets cache=3Dnone.  However,
> without that (and aio=3Dnative), the test still works now and it fails
> before Jeff's series (on fc7dbc119e0852a70dc9fa68bb41a318e49e4cd6).  So
> we can probably remove it safely.
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  tests/qemu-iotests/200 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/tests/qemu-iotests/200 b/tests/qemu-iotests/200
> index d8787ddb46..0e814c9b6c 100755
> --- a/tests/qemu-iotests/200
> +++ b/tests/qemu-iotests/200
> @@ -60,7 +60,7 @@ qemu_comm_method=3D"qmp"
>  _launch_qemu -device pci-bridge,id=3Dbridge1,chassis_nr=3D1,bus=3Dpci.0 \
>               -object iothread,id=3Diothread0 \
>               -device virtio-scsi-pci,bus=3Dbridge1,addr=3D0x1f,id=3Dscsi=
0,iothread=3Diothread0 \
> -             -drive file=3D"${TEST_IMG}",media=3Ddisk,if=3Dnone,cache=3D=
none,id=3Ddrive_sysdisk,aio=3Dnative,format=3D$IMGFMT \
> +             -drive file=3D"${TEST_IMG}",media=3Ddisk,if=3Dnone,id=3Ddri=
ve_sysdisk,format=3D$IMGFMT \
>               -device scsi-hd,drive=3Ddrive_sysdisk,bus=3Dscsi0.0,id=3Dsy=
sdisk,bootindex=3D0

Please use $CACHEMODE so that ./check -nocache works.

--iBwuxWUsK/REspAd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaISnBAAoJEJykq7OBq3PIVi4H/3BURcwS4xY0TqlGZ1ud8/h6
DxJ6opCVu055ovRWPgAsrf4pizV8ZKVLrVSqIhBDbbOZBZoALToGMfllrtcAp81f
XiYW0oS6w2lDQL4HQDsuukbmrG5WNAQFpW1jHo1Ijo66KcRVKcrAh71hnPVmMYBf
6fy7S3PG3Pi5Da0BysGv+kYjgr5lrMpYYRKC4Uocvr6/d6jPAyfZgbUhGOCTF+3r
6ER5qBceYXt5i0S2IwvKwn2vV3kzSbcLa8+4WPpp2Ct2pPf3ZaYxrIkHn7bguO4w
m8Wo78nEK5UzW5UNh+9xgj8Tri+++/HftTZqNpgzm7/mMQgC2Xr6TJ1Bh/UVFCc=
=ggQ3
-----END PGP SIGNATURE-----

--iBwuxWUsK/REspAd--
