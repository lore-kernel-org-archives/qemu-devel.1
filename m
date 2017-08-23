Received: from eggs.gnu.org ([2001:4830:134:3::10]:35261)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dkZVm-0000Jo-V8
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 13:32:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dkZVm-0007D5-3D
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 13:32:14 -0400
References: <f5ef1341-cfe2-6e20-3f98-b08ef2f7d373@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <39bf15aa-70e0-45ad-e368-fb489ee30a7c@redhat.com>
Date: Wed, 23 Aug 2017 19:31:56 +0200
MIME-Version: 1.0
In-Reply-To: <f5ef1341-cfe2-6e20-3f98-b08ef2f7d373@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="rq5RBUQlohqQWsJcD8hTwaOxPak3w7CqF"
Subject: Re: [Qemu-devel] Persistent bitmaps for non-qcow2 formats
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, Qemu-block <qemu-block@nongnu.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Manos Pitsidianakis <el13635@mail.ntua.gr>, Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rq5RBUQlohqQWsJcD8hTwaOxPak3w7CqF
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, Qemu-block <qemu-block@nongnu.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Manos Pitsidianakis <el13635@mail.ntua.gr>, Fam Zheng <famz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <39bf15aa-70e0-45ad-e368-fb489ee30a7c@redhat.com>
Subject: Re: Persistent bitmaps for non-qcow2 formats
References: <f5ef1341-cfe2-6e20-3f98-b08ef2f7d373@redhat.com>
In-Reply-To: <f5ef1341-cfe2-6e20-3f98-b08ef2f7d373@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-08-22 21:07, John Snow wrote:

[...]

> (3) Add either a new flag that turns qcow2's backing file into a full
> R/W backing file, or add a new extension to qcow2 entirely (bypassing
> the traditional backing file mechanism to avoid confusion for older
> tooling) that adds a new read-write backing file field.
>=20
> This RW backing file field will be used for all reads AND writes; the
> qcow2 in question becomes a metadata container on top of the BDS chain.=

> We can re-use Vladimir's bitmap persistence extension to save bitmaps i=
n
> a qcow2 shell.
>=20
> The qcow2 becomes effectively a metadata cache for a new (essentially)
> filter node that handles features such as bitmaps. This could also be
> used to provide allocation map data for RAW files and other goodies dow=
n
> the road.
>=20
> Hopefully this achieves our desire to not create new formats AND our
> desire to concentrate features (and debugging, testing, etc) into qcow2=
,
> while allowing users to "have bitmaps with raw files."
>=20
> Of course, in this scenario, users now have two files: a qcow2 wrapper
> and the actual raw file in question; but regardless of how we were goin=
g
> to solve this, a raw file necessitates an external file of some sort,
> else we give up the idea that it was a raw file.
>=20
>=20
> Sound good?

While I don't quite like the idea of R/W backing files, I guess "don't
quite like" is still rather good.

I like how this idea would allow us to use the existing code without
putting just arbitrary binary data into the qcow2 file; the data still
relates to the virtual disk represented by the qcow2 image.

So design-wise, I don't think I have any complaints.

As for Kevin, he's on PTO, though. ;-)

Max


--rq5RBUQlohqQWsJcD8hTwaOxPak3w7CqF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlmdvA0SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AoVUH/j+k8/P1uOSP2O7VYOQztvdi6LcJfkaF
8ikvJMHKhzucBl+Yr9E4vydwDP+Py5z7ZeDrRW0tj4nYGJM7302WS0jOyB/91jhZ
ZQn+thrffXkTB+Q3ZA3SgC9zrXx08nHjdOKy5jkUpVlH0kkWtRiKdu189gdl/llM
Zbi07MTpjOkxjqcb2embTNpb+OfDWTr9cR/LMq116mdKEekMJoaCQhJkXgDdmZks
41SoLc0qdp6slVQBBbd6XYbgGi8r8MZknJfbgv4x/sa648SUU7wbyreZo4dslUoq
Sl0Us++7oFomHQxZirHj62QezBYmtQ6h8ufdghypnxQ5LgIqJ8jt1k8=
=Y2Fu
-----END PGP SIGNATURE-----

--rq5RBUQlohqQWsJcD8hTwaOxPak3w7CqF--
