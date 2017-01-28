Received: from eggs.gnu.org ([2001:4830:134:3::10]:44829)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cXa66-00047X-VD
	for qemu-devel@nongnu.org; Sat, 28 Jan 2017 15:59:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cXa62-0005fH-9z
	for qemu-devel@nongnu.org; Sat, 28 Jan 2017 15:59:47 -0500
References: <20161220191523.5779-1-eblake@redhat.com>
	<20161220191523.5779-8-eblake@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <14e0551d-9757-91af-767e-05b224bec2b2@redhat.com>
Date: Sat, 28 Jan 2017 21:59:29 +0100
MIME-Version: 1.0
In-Reply-To: <20161220191523.5779-8-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="a7c2Of8oIajIOci4tJbmPFfo3N921SaNK"
Subject: Re: [Qemu-devel] [PATCH v4 7/7] tests: Add coverage for recent
 block geometry fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--a7c2Of8oIajIOci4tJbmPFfo3N921SaNK
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>
Message-ID: <14e0551d-9757-91af-767e-05b224bec2b2@redhat.com>
Subject: Re: [PATCH v4 7/7] tests: Add coverage for recent block geometry
 fixes
References: <20161220191523.5779-1-eblake@redhat.com>
 <20161220191523.5779-8-eblake@redhat.com>
In-Reply-To: <20161220191523.5779-8-eblake@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 20.12.2016 20:15, Eric Blake wrote:
> Use blkdebug's new geometry constraints to emulate setups that
> have caused recent regression fixes: write zeroes asserting
> when running through a loopback block device with max-transfer
> smaller than cluster size, and discard rounding away portions
> of requests not aligned to preferred boundaries.  Also, add
> coverage that the block layer is honoring max transfer limits.
>=20
> For now, a single iotest performs all actions, with the idea
> that we can add future blkdebug constraint test cases in the
> same file; but it can be split into multiple iotests if we find
> reason to run one portion of the test in more setups than what
> are possible in the other.
>=20
> For reference, the final portion of the test (checking whether
> discard passes as much as possible to the lowest layers of the
> stack) works as follows:
>=20
> qemu-io: discard 30M at 80000001, passed to blkdebug
>   blkdebug: discard 511 bytes at 80000001, -ENOTSUP (smaller than
> blkdebug's 512 align)
>   blkdebug: discard 14371328 bytes at 80000512, passed to qcow2
>     qcow2: discard 739840 bytes at 80000512, -ENOTSUP (smaller than
> qcow2's 1M align)
>     qcow2: discard 13M bytes at 77M, succeeds
>   blkdebug: discard 15M bytes at 90M, passed to qcow2
>     qcow2: discard 15M bytes at 90M, succeeds
>   blkdebug: discard 1356800 bytes at 105M, passed to qcow2
>     qcow2: discard 1M at 105M, succeeds
>     qcow2: discard 308224 bytes at 106M, -ENOTSUP (smaller than qcow2's=

> 1M align)
>   blkdebug: discard 1 byte at 111457280, -ENOTSUP (smaller than
> blkdebug's 512 align)
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
>=20
> ---
> v4: clean up some comments, nicer backing file creation, more commit me=
ssage
> v3: make comments tied more to test at hand, rather than the
> particular hardware that led to the earlier patches being tested
> v2: new patch
> ---
>  tests/qemu-iotests/173     | 114 +++++++++++++++++++++++++++++++++++++=
++++++++
>  tests/qemu-iotests/173.out |  49 +++++++++++++++++++
>  tests/qemu-iotests/group   |   1 +
>  3 files changed, 164 insertions(+)
>  create mode 100755 tests/qemu-iotests/173
>  create mode 100644 tests/qemu-iotests/173.out

Reviewed-by: Max Reitz <mreitz@redhat.com>


--a7c2Of8oIajIOci4tJbmPFfo3N921SaNK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAliNBjISHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9ARCAH/R8oFDfd9R3yl3jyMaDFXwh00LyLFp96
VhXWaIxEf4bNXkOSxBJOpE0va8ibIa0o1oRdckwC56xr10bbtk8KzAkwgBOlYAxA
OImfSC8gl7W2glg/pig9RDrs3DJOXCaQ9x4ehE58fWDf5j03W/qB1IDy6zt8zHeh
9xPt4FXo7lgZL8dPinNxzuEpQTXFJIctw0uOrPM06JeV8amPHSHUQg1+DROh30E1
YlDEkCzbbNb2hPQiaLix7QK2ZTeuIZ+/DJDUVUDOdIyZQbaY+rb7AHdWgef118gJ
L2n1TrV2auSdLqqS7L6b7eLvUDzNV9VBIhC7OAgpTf++2wjRzFNFEm0=
=Nx1L
-----END PGP SIGNATURE-----

--a7c2Of8oIajIOci4tJbmPFfo3N921SaNK--
