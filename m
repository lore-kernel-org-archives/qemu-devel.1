Received: from eggs.gnu.org ([2001:4830:134:3::10]:55812)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dBhzJ-0007i0-GN
	for qemu-devel@nongnu.org; Fri, 19 May 2017 09:30:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dBhzI-0008TP-J1
	for qemu-devel@nongnu.org; Fri, 19 May 2017 09:30:37 -0400
References: <20170508171302.17805-1-eblake@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <2f66f2d1-ff51-8b41-8e7d-ef21297de97b@redhat.com>
Date: Fri, 19 May 2017 15:30:25 +0200
MIME-Version: 1.0
In-Reply-To: <20170508171302.17805-1-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="qAF0tM7RQCakc5RDMpomWDWXM26xu5ecG"
Subject: Re: [Qemu-devel] [PATCH] block: Tweak error message related to
 qemu-img convert
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qAF0tM7RQCakc5RDMpomWDWXM26xu5ecG
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <2f66f2d1-ff51-8b41-8e7d-ef21297de97b@redhat.com>
Subject: Re: [PATCH] block: Tweak error message related to qemu-img convert
References: <20170508171302.17805-1-eblake@redhat.com>
In-Reply-To: <20170508171302.17805-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-05-08 19:13, Eric Blake wrote:
> When converting a 1.1 image down to 0.10, qemu-iotests 060 forces
> a contrived failure where allocating a cluster used to replace a
> zero cluster reads unaligned data.  Since it is a zero cluster
> rather than a data cluster being converted, changing the error
> message to match our earlier change in 'qcow2: Make distinction
> bewteen zero cluster types obvious' is worthwhile.
>=20
> Suggested-by: Max Reitz <mreitz@redhat.com>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>=20
> There's one more instance of "Data cluster offset" in qcow2-cluster.c,
> but that one in handle_copied() is contained inside a
> cluster_type =3D=3D QCOW2_CLUSTER_NORMAL conditional.
>=20
>  block/qcow2-cluster.c      | 3 ++-
>  tests/qemu-iotests/060.out | 2 +-
>  2 files changed, 3 insertions(+), 2 deletions(-)

Assuming no objection means consent:

Thanks, fixed the commit title and applied to my block branch:

https://github.com/XanClic/qemu/commits/block

Max


--qAF0tM7RQCakc5RDMpomWDWXM26xu5ecG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZHvNxEhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQKuY
B/4h5UbyFQUEoUwu7Gs2nXskRH6y3RVCyTUSFxUt22Ps+ja2Wj0tA2yT9Vx+0HAp
3mjDuV0uVQkzLNhzg87Fejjvx1zDxsKA0o4drwWkS/mPeyAdHO/yCfUA4Ntk/0cR
yMkH06R5XrMtfwTSKhdKI2lAv8uqnlG2yNlW0t1fP8hu1tbEMxKJYluWYmtu/IqG
tIX8KDt5SeJF8rB5xw0IZMz37kAmQSG4Efv0byCHeeYWFTT8EsKlT9aWwUhH+gGX
aBEhaKw0eDOxJqtlNURd5TvGzAvBChE22l8tzBGM9kGHLrKVyhf4Ee6qhZpT85k1
iCAHh27ADA659a3zMlH3vEpX
=U5/e
-----END PGP SIGNATURE-----

--qAF0tM7RQCakc5RDMpomWDWXM26xu5ecG--
