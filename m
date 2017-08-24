Received: from eggs.gnu.org ([2001:4830:134:3::10]:48236)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dkzTk-0002zg-Pb
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 17:15:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dkzTk-0006Nj-0t
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 17:15:52 -0400
Date: Fri, 25 Aug 2017 00:15:06 +0300
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Message-ID: <20170824211506.iygynkpevxemsyg2@postretch>
References: <20170822101535.4695-1-el13635@mail.ntua.gr>
	<20170822101535.4695-7-el13635@mail.ntua.gr>
	<20170824184308.GD4368@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3wrz5555edjlccey"
Content-Disposition: inline
In-Reply-To: <20170824184308.GD4368@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [PATCH v7 6/6] qemu-iotests: add 184 for throttle
 filter driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block <qemu-block@nongnu.org>


--3wrz5555edjlccey
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 24, 2017 at 07:43:08PM +0100, Stefan Hajnoczi wrote:
>On Tue, Aug 22, 2017 at 01:15:35PM +0300, Manos Pitsidianakis wrote:
>> +_supported_fmt qcow2
>
>What makes this test qcow2-specific?  With additional filtering for
>IMGFMT it should be possible to run this on any image format.

I think none of the available filters hide all of the image details in=20
query-block and company. _filter_imgfmt hides the image extensions but=20
not the image specific fields (eg virtual-size, actual-size and=20
format-specific). Perhaps a new filter that hides everything but=20
"format" and "filename" in the "image" subdict can be introduced later.

--3wrz5555edjlccey
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEvy2VxhCrsoeMN1aIc2J8L2kN9xAFAlmfQdoACgkQc2J8L2kN
9xB0Ag//eDjhB1KlH9oxCgrGzexvBxObMGUsGKBpQD2QBcTvKASL1qwl7A+xi9/J
qwnfBJ8g5o3i4EKLp+ej4CvmLwkDkCUbK6x38BT4YId8H7M2KFMZlA4GSyM4kWNT
M1ueAInI+6z/K7/MFkorqhwuD2736P5UyRlc1ilALBzfmSyXoAYG9j/aPHt+84+5
X67HLFFD5cENXFfBJOrb+VtxqMsN19PQnqHYY3rcJvzux70GCb3EfQyNxqAwH5AJ
tWrVieS3AILwknnt+vY/ZODTynhUTlQwq11a3uVTdxMgkRCnLrEa+a9qx1R5L+qr
pnMLMXpq2mNlp0xy7+85c2T26qR7o6kvnKvTOf9TldJs77nTiJYiHpLtlFBTA7Zq
3adpIRIecp1u1tbupa+eZKZHeBLx7OD8GzpZoiY4k8R9yaQRwVsR8uDC3qd7IcUY
FjorCGofAk6obc265cHE+3eeprYDJaFGHKfPzrTgO++0X+1HFcbXUwOP8y+a+2qT
tDa/ZlVaxSsMCbTxig45wGfUaJDSSv9SblPeM7wZSDI3cNKerqgYfE6ApLdKJWg4
XB7jjd3+cqcW9x8YcjhmKFNnfYfKjn/cuOYm5qvNIeC6H8giXdNvL+M+mCELu7j3
WmN8vwPBEmsjOb+OOHEXuCze24o0rr7kE9biuYiouKVY/iEJY9A=
=nSfZ
-----END PGP SIGNATURE-----

--3wrz5555edjlccey--
