Received: from eggs.gnu.org ([2001:4830:134:3::10]:48460)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cEOIa-0006WE-5L
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 17:33:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cEOIZ-0008Jp-8Y
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 17:33:20 -0500
References: <20161202192223.15153-1-eblake@redhat.com>
	<20161202192223.15153-6-eblake@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <fadfa5df-3b0a-3fed-7361-ede760150e46@redhat.com>
Date: Tue, 6 Dec 2016 23:33:10 +0100
MIME-Version: 1.0
In-Reply-To: <20161202192223.15153-6-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="c06E74iRCG76Nm9kVOV8KgW6sjKfDRtdU"
Subject: Re: [Qemu-devel] [PATCH v3 5/5] tests: Add coverage for recent
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--c06E74iRCG76Nm9kVOV8KgW6sjKfDRtdU
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org
Message-ID: <fadfa5df-3b0a-3fed-7361-ede760150e46@redhat.com>
Subject: Re: [PATCH v3 5/5] tests: Add coverage for recent block geometry
 fixes
References: <20161202192223.15153-1-eblake@redhat.com>
 <20161202192223.15153-6-eblake@redhat.com>
In-Reply-To: <20161202192223.15153-6-eblake@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 02.12.2016 20:22, Eric Blake wrote:
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
> Signed-off-by: Eric Blake <eblake@redhat.com>
>=20
> ---
> v3: make comments tied more to test at hand, rather than the
> particular hardware that led to the earlier patches being tested
> v2: new patch
> ---
>  tests/qemu-iotests/173     | 115 +++++++++++++++++++++++++++++++++++++=
++++++++
>  tests/qemu-iotests/173.out |  49 +++++++++++++++++++
>  tests/qemu-iotests/group   |   1 +
>  3 files changed, 165 insertions(+)
>  create mode 100755 tests/qemu-iotests/173
>  create mode 100644 tests/qemu-iotests/173.out

Reviewed-by: Max Reitz <mreitz@redhat.com>


--c06E74iRCG76Nm9kVOV8KgW6sjKfDRtdU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlhHPKYSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AvgkH/RLQCO87+Qc9VrTMfX22pZ3Dr7h5hOs7
dtdA8mWyrhoArK1IfBi4T3vFmzpMrLZ/hxNAvBFRslNpD80NkfIwXMFvrHz+2V+Z
5mB5odWCQJGzQa85KjLNwortsmWblMhosXYLMhuClegB0rLlnhioTB4LHmSdmSXK
pldVovIruo9t5d/uu+8qb3rXSFWzm/CxULIJhssh0SsZTV/E6zlObymYET9Sd/A3
33AXf1jnu62Z/1Jx32TS5+cU0HoigWwd5CjQo9LdKYUNa1F5aTEzeLbWsSwMy1WP
wxp/uWQu5HO26XRDe0uRGATtfZce70M/HalZektHkRSksCLyfp4Rak8=
=z66l
-----END PGP SIGNATURE-----

--c06E74iRCG76Nm9kVOV8KgW6sjKfDRtdU--
