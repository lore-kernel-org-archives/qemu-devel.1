Received: from eggs.gnu.org ([2001:4830:134:3::10]:51736)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ehKbU-0002xL-1J
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 14:34:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ehKaQ-0006xO-0p
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 14:32:59 -0500
References: <cover.1516978645.git.berto@igalia.com>
	<4bd645eb4a81eb2009fab318dfca6d47e657655c.1516978645.git.berto@igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <8b5794fe-51ca-d05c-4f2a-d2ca29676a51@redhat.com>
Date: Thu, 1 Feb 2018 20:29:33 +0100
MIME-Version: 1.0
In-Reply-To: <4bd645eb4a81eb2009fab318dfca6d47e657655c.1516978645.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="jEQ3nau8mJn8XcNY1noluQCgFbcdmaEg0"
Subject: Re: [Qemu-devel] [PATCH v3 28/39] qcow2: Read refcount before L2
 table in expand_zero_clusters_in_l1()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jEQ3nau8mJn8XcNY1noluQCgFbcdmaEg0
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 "Denis V . Lunev" <den@openvz.org>
Message-ID: <8b5794fe-51ca-d05c-4f2a-d2ca29676a51@redhat.com>
Subject: Re: [PATCH v3 28/39] qcow2: Read refcount before L2 table in
 expand_zero_clusters_in_l1()
References: <cover.1516978645.git.berto@igalia.com>
 <4bd645eb4a81eb2009fab318dfca6d47e657655c.1516978645.git.berto@igalia.com>
In-Reply-To: <4bd645eb4a81eb2009fab318dfca6d47e657655c.1516978645.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-01-26 15:59, Alberto Garcia wrote:
> At the moment it doesn't really make a difference whether we call
> qcow2_get_refcount() before of after reading the L2 table, but if we
> want to support L2 slices we'll need to read the refcount first.
>=20
> This patch simply changes the order of those two operations to prepare
> for that. The patch with the actual semantic changes will be easier to
> read because of this.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/qcow2-cluster.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--jEQ3nau8mJn8XcNY1noluQCgFbcdmaEg0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlpzap0SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AO/UH/0C3ZLItlSyDPLVAlqappGdJ62k+mJpY
g8U1zeDv3lKczAZL4ZLNY67k9MQBt2nInXwuWYO073gl8TtySHUl2B6WmG6Px71w
3P4Us2Ek6ojm3KTT/cexZm+OMinRymDsEa9lUGFSFpS1/3Jv0uknKAwPoEvXXZJB
DFSMWblb13X65B5DjX4cpTXS5npFX+QsNh/NS/zrTxQXv1Mv6EAr6gyAAEy6tc/H
mupRwlBSbbv2hVkoVsKK73oTm0jIHifkhIHScUVtFlNeVBhC05rCaYZpXPPvJveR
3p1vj7pCnx5pMiYDJswn0TAGLMBTLvuOhyxwWeKZUCf50MrXhIXcxP0=
=cFMi
-----END PGP SIGNATURE-----

--jEQ3nau8mJn8XcNY1noluQCgFbcdmaEg0--
