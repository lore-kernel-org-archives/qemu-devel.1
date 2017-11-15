Received: from eggs.gnu.org ([2001:4830:134:3::10]:59726)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eF4K5-0001Uh-3k
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 15:30:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eF4K4-0000Kk-2L
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 15:30:13 -0500
References: <20171114184127.24238-1-mreitz@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <1423c6ac-8320-d797-6dc0-ac111486911d@redhat.com>
Date: Wed, 15 Nov 2017 21:30:03 +0100
MIME-Version: 1.0
In-Reply-To: <20171114184127.24238-1-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="SjR6mWRsums8edGwwewVWJamD5dxv74mx"
Subject: Re: [Qemu-devel] [PATCH for-2.11] qcow2: Fix overly broad madvise()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SjR6mWRsums8edGwwewVWJamD5dxv74mx
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Alberto Garcia <berto@igalia.com>
Message-ID: <1423c6ac-8320-d797-6dc0-ac111486911d@redhat.com>
Subject: Re: [PATCH for-2.11] qcow2: Fix overly broad madvise()
References: <20171114184127.24238-1-mreitz@redhat.com>
In-Reply-To: <20171114184127.24238-1-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-11-14 19:41, Max Reitz wrote:
> @mem_size and @offset are both size_t, thus subtracting them from one
> another will just return a big size_t if mem_size < offset -- even more=

> obvious here because the result is stored in another size_t.
>=20
> Checking that result to be positive is therefore not sufficient to
> excluse the case that offset > mem_size.  Thus, we currently sometimes
> issue an madvise() over a very large address range.
>=20
> This is triggered by iotest 163, but with -m64, this does not result in=

> tangible problems.  But with -m32, this test produces three segfaults,
> all of which are fixed by this patch.
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  block/qcow2-cache.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Fixed the typo and applied to my block branch:

https://github.com/XanClic/qemu/commits/block

Max


--SjR6mWRsums8edGwwewVWJamD5dxv74mx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAloMo8sSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9ALyUH/RiDs/sillk8S9cjwaJ0szWB7m8ouDj8
jU3Ud1e2969HprlPy8Im7+2NlUkhJvmcqg9Zpx75fpqJdo9HG6x+Z7MWYmL7M0lK
eyOkd7zZ33c/wfrPSrLMGLniUtt318bA6BftOAWzeSWdtNFFrTJsQ7KlwJZRDW5C
vOhpnwwhWgXClbm3Wa8LbVbaWwUM+TVrBel1hrJ/0ZlevH3pkDt6VRD15p/Y6hf3
GovRoPH0YwqAGxo6nHD9ZgpVgsO5NPaA4tYKzkTgiNKGvAOm2KKc8JCD2RyPDdRH
IifItcEngYqEz/Li4v261dbZscLPW8xASN3tJYmECVZVeezuohXx35M=
=aSaA
-----END PGP SIGNATURE-----

--SjR6mWRsums8edGwwewVWJamD5dxv74mx--
