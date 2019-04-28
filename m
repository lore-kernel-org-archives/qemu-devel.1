Received: from eggs.gnu.org ([209.51.188.92]:54774)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hKZof-0001ad-C8
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 22:45:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hKZga-0000aY-Gr
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 22:37:01 -0400
References: <dd85fab0-52df-9c2d-e402-28d7ce9867f1@redhat.com>
	<20190426105301.GA20769@localhost.localdomain>
From: Eric Blake <eblake@redhat.com>
Message-ID: <eca8f98a-6f39-837a-6d55-606d881c44ed@redhat.com>
Date: Sat, 27 Apr 2019 21:36:54 -0500
MIME-Version: 1.0
In-Reply-To: <20190426105301.GA20769@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="fFn5zBvpKTXX1sH1VD7iw60JrU5yvgXZk"
Subject: Re: [Qemu-devel] Failing qemu-iotest 005 with raw
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: hch@lst.de, QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fFn5zBvpKTXX1sH1VD7iw60JrU5yvgXZk
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: hch@lst.de, QEMU Developers <qemu-devel@nongnu.org>,
 Qemu-block <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>
Message-ID: <eca8f98a-6f39-837a-6d55-606d881c44ed@redhat.com>
Subject: Re: [Qemu-devel] Failing qemu-iotest 005 with raw
References: <dd85fab0-52df-9c2d-e402-28d7ce9867f1@redhat.com>
 <20190426105301.GA20769@localhost.localdomain>
In-Reply-To: <20190426105301.GA20769@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 4/26/19 5:53 AM, Kevin Wolf wrote:

>>  creating large image
>> +qemu-img: TEST_DIR/t.IMGFMT: The image size is too large for file
>> format 'IMGFMT'
>>  Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D5368709120000
>> [...]
>>
>> Could this be fixed somehow, or should the test rather be skipped for
>> IMGFMT=3Draw?
>=20
> The test passes for me on XFS. Looks like the raw driver can handle
> large image files, but your host filesystem can't.
>=20
> We would have to check whether the host filesystem can support large
> files and skip the test if it can't. I'm not sure how to do that. But
> actually, this isn't testing anything interesting for raw, so just
> unconditionally disabling the test for raw could be reasonable enough.

iotest 220 in commit 3b94c343 can serve as such an example (it skips the
test on at least ext4, while passing on tmpfs which allows larger sparse
files).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--fFn5zBvpKTXX1sH1VD7iw60JrU5yvgXZk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlzFEcYACgkQp6FrSiUn
Q2rDRQf9FOPXF+jJARGgTgg0qI/7J69K+C4b8i0gzFWVkSyFUt/IhckK+uKxtH6/
XKl4uRHxRHJXgBtrkUvwJkxFPdv+dAUmi0lUrZjyQzKxuLh4GTnuHrrXy9nqhmTU
13qDX7RgSAR654uIbSDCRtHnk8EEPeIt5qyC8Yf1KfBAI/vc/KCnEYxKBPPb+7/b
IaqkXYZv3miruA33l0XJborI4tKBjb4e3L6GnNyi4+MxL3O+OjPJp+kOr18sZtlN
x7P8rqUMeK0L4H0GxstMeygp8doulIP7O8jFxMXeoitSFhllRpz32rLBzwOh9U7S
/t7fv2ZlUSEX+i5MGEICm9VBF1SP4g==
=E/SY
-----END PGP SIGNATURE-----

--fFn5zBvpKTXX1sH1VD7iw60JrU5yvgXZk--
