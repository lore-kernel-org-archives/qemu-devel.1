Received: from eggs.gnu.org ([2001:4830:134:3::10]:52674)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dbB1I-0003yl-3n
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 15:33:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dbB1F-0006pD-0g
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 15:33:56 -0400
References: <20170728131452.15316-1-kwolf@redhat.com>
	<20170728131452.15316-8-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <26539064-bd7c-bb5f-c542-b69b8a7b5e36@redhat.com>
Date: Fri, 28 Jul 2017 14:33:48 -0500
MIME-Version: 1.0
In-Reply-To: <20170728131452.15316-8-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="dXoqvVa5ijD4c6fSFIIuUfJBTwmGXFNbu"
Subject: Re: [Qemu-devel] [PATCH for-2.10 7/7] qemu-iotests/059: Fix leaked
 image files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dXoqvVa5ijD4c6fSFIIuUfJBTwmGXFNbu
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org
Message-ID: <26539064-bd7c-bb5f-c542-b69b8a7b5e36@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10 7/7] qemu-iotests/059: Fix leaked
 image files
References: <20170728131452.15316-1-kwolf@redhat.com>
 <20170728131452.15316-8-kwolf@redhat.com>
In-Reply-To: <20170728131452.15316-8-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/28/2017 08:14 AM, Kevin Wolf wrote:
> qemu-iotests 059 left a whole lot of image files behind in the scratch
> directory because VMDK creates additional files for extents and cleanin=
g
> them up requires the original image intact (it parses qemu-img info
> output to find all extent files), but the image overwrote it many times=

> like it works for all other image formats.
>=20
> In addition, _use_sample_img overwrites the TEST_IMG variable, causing
> new images created afterwards to reuse the name of the sample file
> rather than the usual t.IMGFMT.
>=20
> This patch adds an intermediate _cleanup_test_img after each subtest
> that created an image file with additional extent files, and also after=

> each use of a sample image. _cleanup_test_img is also changed so that i=
t
> resets TEST_IMG after a sample image is cleaned up.
>=20
> Note that this test was failing before this commit and continues to do
> so after it. This failure was introduced in commit 9877860 ('block/vmdk=
:
> Report failures in vmdk_read_cid()') and needs to be dealt with
> separately.

> @@ -30,6 +30,7 @@ status=3D1	# failure is the default!
>  _cleanup()
>  {
>  	_cleanup_test_img
> +    rm -f "$TEST_IMG.qcow2"

Care to fix the TAB damage while you're in the neighborhood?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--dXoqvVa5ijD4c6fSFIIuUfJBTwmGXFNbu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAll7kZwACgkQp6FrSiUn
Q2qHvAf+KyYlbEU23+dkBti8b+sEGcB2o/uRT6gIyeveSHkmwND/WgjbjbBCUDVI
qhExmvXbZx6xKlW/QHqqVYXJKFd82ANoZt6oyb6xQcA930uVlZ5RRnhbDY8G+xEL
COzFIavuTa/L3ZdOfMd7ZvUttMLlaHprCM515ewTkFxbdM9R8elqPHcQZslpTTkr
veikwkz+vZ5j1G/A3NLVOLCM+4Jd6Qf1zy9VJc4ycgdIRB4B+osO4rF0tHWsYqXl
G5KJoH3oQ4tF/KoX6VcqzTyIpzhTBFq3NsilxYjvVLx/DzYBrRQ+pCDXKzXAtJA0
VJCfKG5hXdDuZQB/F0Z+dgoRN6VmlA==
=25/k
-----END PGP SIGNATURE-----

--dXoqvVa5ijD4c6fSFIIuUfJBTwmGXFNbu--
