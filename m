Received: from eggs.gnu.org ([2001:4830:134:3::10]:42125)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ebndK-0005NQ-L4
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 08:20:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ebndJ-0000vN-P4
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 08:20:02 -0500
References: <20171110203759.14018-1-mreitz@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <dedd720a-760d-f4f5-d4b0-4d3707cb0e32@redhat.com>
Date: Wed, 17 Jan 2018 14:19:25 +0100
MIME-Version: 1.0
In-Reply-To: <20171110203759.14018-1-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="KcFmNlN6EZ0Wl06hUj1sMwWlP68BXSTSP"
Subject: Re: [Qemu-devel] [PATCH for-2.12 0/1] qcow2: Repair unaligned
 preallocated zero clusters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, John Snow <jsnow@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KcFmNlN6EZ0Wl06hUj1sMwWlP68BXSTSP
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Alberto Garcia <berto@igalia.com>, John Snow <jsnow@redhat.com>
Message-ID: <dedd720a-760d-f4f5-d4b0-4d3707cb0e32@redhat.com>
Subject: Re: [PATCH for-2.12 0/1] qcow2: Repair unaligned preallocated zero
 clusters
References: <20171110203759.14018-1-mreitz@redhat.com>
In-Reply-To: <20171110203759.14018-1-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-11-10 21:37, Max Reitz wrote:
> This is a follow-up to patch 2 of my "qcow2: Unaligned zero cluster in
> handle_alloc()" series.  That patch adds a way to correctly deal with
> such clusters, this patch here adds a way to repair them.
>=20
> Naturally, this patch is therefore based on that series:
>=20
> Based-on: <20171110203111.7666-1-mreitz@redhat.com>
>=20
>=20
> Max Reitz (1):
>   qcow2: Repair unaligned preallocated zero clusters
>=20
>  block/qcow2-refcount.c     | 70 ++++++++++++++++++++++++++++++++++++++=
--------
>  tests/qemu-iotests/060     |  3 +-
>  tests/qemu-iotests/060.out |  9 ++++++
>  3 files changed, 69 insertions(+), 13 deletions(-)

Applied to my block branch.

Max


--KcFmNlN6EZ0Wl06hUj1sMwWlP68BXSTSP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlpfTV0SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AMiYIAMKtAQL39vEnGq66gTrQY376GiQeXIcN
2hVbNOY78cr8WpiGjkoAJyVKlUsxPRZGSOGJflBldlcjgj76iFOWPuq/FFlbGCXP
8YDvjW8TXnAMctPa/Y86Fz0Z4//u4KjbVLWJIyej+/WdPCDKoPHY/zefs9jUSn+W
Go4I3g62MKticTzHDiv7MM/DuHCDZfQsB4NcigdC+7tllk7YnA1Oyk7+q498OAsq
1zsAoKHycKb3mc8wG2gxtoswcAW89KzV0mLYtqPKJIjk3662orbjpTmsK/1w3G6j
LCJvbCRuzwZemdQN0LE678dh6NpupP/5tRv1BoJ9ym/G/pGTwDl6Cf4=
=ih3w
-----END PGP SIGNATURE-----

--KcFmNlN6EZ0Wl06hUj1sMwWlP68BXSTSP--
