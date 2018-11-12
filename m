Received: from eggs.gnu.org ([2001:4830:134:3::10]:60458)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pkrempa@redhat.com>) id 1gM9vw-0006NH-AN
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 05:59:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pkrempa@redhat.com>) id 1gM9vr-000472-8z
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 05:59:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49236)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pkrempa@redhat.com>) id 1gM9vr-00044Z-13
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 05:59:03 -0500
Date: Mon, 12 Nov 2018 11:58:51 +0100
From: Peter Krempa <pkrempa@redhat.com>
Message-ID: <20181112105851.GQ26431@angien.pipo.sk>
References: <1542016830-19189-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dUqh8vgUBVXHzm9w"
Content-Disposition: inline
In-Reply-To: <1542016830-19189-1-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [libvirt] [PATCH] bt: Mark the bluetooth subsystem
 as deprecated
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, libvir-list@redhat.com, Andrzej Zaborowski <andrew.zaborowski@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, Andrzej Zaborowski <balrogg@gmail.com>


--dUqh8vgUBVXHzm9w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 12, 2018 at 11:00:30 +0100, Thomas Huth wrote:
> It has been unmaintained since years, and there were only trivial or
> tree-wide changes to the related files since many years, so the
> code is likely very bitrotten and broken. For example the following
> segfaults as soon as as you press a key:
>=20
>  qemu-system-x86_64 -usb -device usb-bt-dongle -bt hci -bt device:keyboard
>=20
> Since we are not aware of anybody using bluetooth with the current
> version of QEMU, let's mark the subsystem as deprecated, with a special
> request for the users to write to the qemu-devel mailing list in case
> they still use it (so we could revert the deprecation status in that
> case).
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  qemu-deprecated.texi | 7 +++++++
>  qemu-options.hx      | 4 ++++
>  vl.c                 | 4 ++++
>  3 files changed, 15 insertions(+)

libvirt never implemented any configuration option for bluetooth

--dUqh8vgUBVXHzm9w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEUn7DGLvflazX+2GwHGwCByjY1GoFAlvpXOgACgkQHGwCByjY
1Gqyeg/7BAPkCBkOEZZBd8dFol6crzWLiFPJJTBBWX+d27bHWEmPiRauUfelb3JW
oIQ0Geil4a28CZGvF8jT0gDpyZL2Ogr2r3Q/MkXQAHcdJgXUmAIKAI2l5hBbITos
lgpczXpCbMVnS8KtCfjWQzi7O5TLM3n2DrmqwzZQeZmozmZq99B7EM6VV89h/PDg
0AEbtf6g4ruqLc0ui13bjLQJhQTJL97VhUiLihkyAWYRXEHFwoob0DF+7XTX082P
LifrXtMjq0JyAKvrChycXtODSb+wLyfwB2JVRz+vSSrnL0aB808j1ry5rg/tDJTK
QuSFqQUanzoh6Xy1ALVLDmeh3oqJvMxKmwMcz5PyOa4gTSq8cNfjjx6ML+VPrytz
6ZF+1/JO2iUpQO2BSaF7Yp8BU9oPRSe362IG4438uGBQZmQOaidbV6dh+f1RYbeV
hqQ68E0AUCHkj0qx03L8BfS4bKsK2JEdYuODMwRNgpx+OuSVJOmwX2cmX49ftEAd
BPIEiHbF5rVjBeFk3i8FVrHV8vU3JmW8diqmDQNFYT2yS4iWyJEmd6erv8gcpLKu
tGYC+Iwx5sK4TbhQldj040YK1et4HbXCn0V4BdOew+T5kRz3Y2N2oOr6y7EqI93N
Z7m1sEPjFAblVuj3S2M0oS0IZ5AcpKFMu58jPkBes8oSX49mdaw=
=hlSi
-----END PGP SIGNATURE-----

--dUqh8vgUBVXHzm9w--
