Received: from eggs.gnu.org ([2001:4830:134:3::10]:34831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cZ2tK-0007DP-Tk
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 16:56:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cZ2tK-0008Hz-8A
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 16:56:38 -0500
References: <cover.1485878688.git.berto@igalia.com>
	<c988ccf62ad4000775d3b322744ea0f5900daaa7.1485878688.git.berto@igalia.com>
	<9d413d87-33ac-7c41-2944-ec9974cd1e44@redhat.com>
	<w51k299lgoj.fsf@maestria.local.igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <1cd63da2-1cab-6404-9f20-c63d68b6f6a3@redhat.com>
Date: Wed, 1 Feb 2017 22:56:29 +0100
MIME-Version: 1.0
In-Reply-To: <w51k299lgoj.fsf@maestria.local.igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="xNh4p5ctdGI3WLR0oVR87tBakefwR4mB1"
Subject: Re: [Qemu-devel] [PATCH 2/2] iov: assert that qiov->size doesn't
 exceed INT_MAX
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xNh4p5ctdGI3WLR0oVR87tBakefwR4mB1
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <1cd63da2-1cab-6404-9f20-c63d68b6f6a3@redhat.com>
Subject: Re: [PATCH 2/2] iov: assert that qiov->size doesn't exceed INT_MAX
References: <cover.1485878688.git.berto@igalia.com>
 <c988ccf62ad4000775d3b322744ea0f5900daaa7.1485878688.git.berto@igalia.com>
 <9d413d87-33ac-7c41-2944-ec9974cd1e44@redhat.com>
 <w51k299lgoj.fsf@maestria.local.igalia.com>
In-Reply-To: <w51k299lgoj.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 01.02.2017 22:55, Alberto Garcia wrote:
> On Wed 01 Feb 2017 10:51:01 PM CET, Max Reitz <mreitz@redhat.com> wrote=
:
>=20
>> The assertion probably makes sense even for them, considering that
>> size_t does not have a constant size. But I'm not entirely sold that
>> the I/O vector creation is actually the place where the assertions
>> belong.
>=20
> I was actually just reading virtio_blk_handle_request() and I see that
> the I/O vector is initialized before the check for the maximum request
> size that returns VIRTIO_BLK_S_IOERR.
>=20
> So you're probably right and it's safer not to add that assertion.

So... Apply patch 1 and hope we do everything right in the future? :-)

Max


--xNh4p5ctdGI3WLR0oVR87tBakefwR4mB1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAliSWY0SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9ArA0IAMFymfFpwYIIjuqKeKoKy1SyvR161gDc
j9Ls4Z8iB/GepLxtxNPVgvcbvu40Lj67Y12sd7nuhs0YDnOBPxKpa6TCY8gTgAgd
InFSju9caFRY+O/kOc5JlzhtMR6RMByXMV9RiAc9FejHnW4x+8dmWr6Yn/AXzClY
qDCuzB0F2VcHP3RCLJf1BnvtDJQUopbzhI93ztZC6L4zJKb4eRqva6HBnDA5q0ry
ij2MTjhUduVemxCQz5iTs6wihEH4XV21Ch67YlO96/ogXvvgZR2cQxOw1z/tlgVm
EVJdKqLE5DlWwgJXD8TuMkDMXvLZoynAW9y1m6JgIi5eLF54PW4XB0c=
=a54W
-----END PGP SIGNATURE-----

--xNh4p5ctdGI3WLR0oVR87tBakefwR4mB1--
