Received: from eggs.gnu.org ([2001:4830:134:3::10]:37905)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dS0ZM-0005YQ-Rp
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 08:35:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dS0ZL-0004Vz-Om
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 08:35:12 -0400
References: <20170702150510.23276-1-mreitz@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <74687e2d-236b-f765-ad63-e0a6ae25fce6@redhat.com>
Date: Mon, 3 Jul 2017 14:35:01 +0200
MIME-Version: 1.0
In-Reply-To: <20170702150510.23276-1-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="rl42uAm2mMNQxWBmhTcPw5oeVcVrQV099"
Subject: Re: [Qemu-devel] [PATCH v5 0/2] iotests: Add test for colon handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rl42uAm2mMNQxWBmhTcPw5oeVcVrQV099
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>
Message-ID: <74687e2d-236b-f765-ad63-e0a6ae25fce6@redhat.com>
Subject: Re: [PATCH v5 0/2] iotests: Add test for colon handling
References: <20170702150510.23276-1-mreitz@redhat.com>
In-Reply-To: <20170702150510.23276-1-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-07-02 17:05, Max Reitz wrote:
> v3 of v3 of "iotests: Add test for colon handling"; thus, basically, v5=
=2E
>=20
> This adds an iotest for the original series "block: Fix backing paths
> for filenames with colons" and fixes common.config so it works if you
> have specified the qemu binaries through relative paths. As a bonus, it=

> makes symlinked binaries work for out-of-tree builds.
>=20
>=20
> v5: Don't try to resolve QEMU_VXHS_PROG if it is empty (which it may be=
)
>     [Eric]
>=20
>=20
> git-backport-diff against v4:
>=20
> Key:
> [----] : patches are identical
> [####] : number of functional differences between upstream/downstream p=
atch
> [down] : patch is downstream-only
> The flags [FC] indicate (F)unctional and (C)ontextual differences, resp=
ectively
>=20
> 001/2:[0007] [FC] 'iotests: Use absolute paths for executables'
> 002/2:[----] [--] 'iotests: Add test for colon handling'
>=20
>=20
> Max Reitz (2):
>   iotests: Use absolute paths for executables
>   iotests: Add test for colon handling
>=20
>  tests/qemu-iotests/126           | 105 +++++++++++++++++++++++++++++++=
++++++++
>  tests/qemu-iotests/126.out       |  23 +++++++++
>  tests/qemu-iotests/common.config |  11 ++++
>  tests/qemu-iotests/group         |   1 +
>  4 files changed, 140 insertions(+)
>  create mode 100755 tests/qemu-iotests/126
>  create mode 100644 tests/qemu-iotests/126.out

Applied to my block tree:

https://github.com/XanClic/qemu/commits/block

(Let's hope it stays there this time O:-))

Max


--rl42uAm2mMNQxWBmhTcPw5oeVcVrQV099
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZWjn1EhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQBEu
B/sHN048ds71Z86dBL/RXX78jB1X/mQ/V2icLXxKe1ZQLARvMJPPIYnOh8s1APri
QUWcn5XCdFFJBVhPlWDNdRs0Hx2BWhh/OTMhHdo8k+N6agkRIJws9E1cRAfjjEoG
gUaRfKNjRZkEG+ZUDzOsNq2ZOYTcyKOIG+ReQULynBzFOODgg/mo01EGBnc106E/
TaiHI12HmGy+MEuRPaBepYUtiW/3E6tXVLfyMH6dU8rza/6EE3Xepu0JlNPw385m
qJ0SBCFb3UMdSUtjrUIIN/dbhpnEKpL2q6vEoCJbNj0H0uRaaJioa2ydCSI1mTSn
4OqtGxKL2IbSjtnlX0ZA1zNY
=2Mw/
-----END PGP SIGNATURE-----

--rl42uAm2mMNQxWBmhTcPw5oeVcVrQV099--
