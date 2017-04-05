Received: from eggs.gnu.org ([2001:4830:134:3::10]:55652)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cvqa9-0005MV-U4
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 15:27:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cvqa5-0003Ee-Vd
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 15:27:05 -0400
References: <cover.1491416061.git.jcody@redhat.com>
	<6c82b83fae72a5b5909993f0cf65a90f12efb669.1491416061.git.jcody@redhat.com>
	<4a5f39ab-50ad-6071-130a-fe77493221ec@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a0d3bd42-682c-fe21-eeaa-28e189386e57@redhat.com>
Date: Wed, 5 Apr 2017 14:26:53 -0500
MIME-Version: 1.0
In-Reply-To: <4a5f39ab-50ad-6071-130a-fe77493221ec@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Uhue2XggQhMllNNodKBuCoF3nWdm5bJtN"
Subject: Re: [Qemu-devel] [PATCH for-2.10 3/9] block: honor
 BDRV_O_ALLOW_RDWR when clearing bs->read_only
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, stefanha@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Uhue2XggQhMllNNodKBuCoF3nWdm5bJtN
From: Eric Blake <eblake@redhat.com>
To: John Snow <jsnow@redhat.com>, Jeff Cody <jcody@redhat.com>,
 qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, stefanha@redhat.com
Message-ID: <a0d3bd42-682c-fe21-eeaa-28e189386e57@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10 3/9] block: honor BDRV_O_ALLOW_RDWR
 when clearing bs->read_only
References: <cover.1491416061.git.jcody@redhat.com>
 <6c82b83fae72a5b5909993f0cf65a90f12efb669.1491416061.git.jcody@redhat.com>
 <4a5f39ab-50ad-6071-130a-fe77493221ec@redhat.com>
In-Reply-To: <4a5f39ab-50ad-6071-130a-fe77493221ec@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/05/2017 02:20 PM, John Snow wrote:

> Conceptually straightforward.
>=20
> looks like this might change behavior for... RBD and vvfat, right?
> RBD is the subject of this series so we'll just assume that was broken
> and stupid.
>=20
> What's vvfat's story? It always set the read-only property to false
> regardless of what you asked for?

vvfat is even stupider than that - it has its own independent property
'rw' that determines whether to allow write operations, separate from
the inherited BDS readonly property.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--Uhue2XggQhMllNNodKBuCoF3nWdm5bJtN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY5UT9AAoJEKeha0olJ0NqQ3QH/RhdgTDRXQOYA3l1NmM7sRBr
0PTZZsh+env7hF0eNz6zYdE52o4XdC5n78qcmtFlyUn1tltwXDn9nzaMT15TsD6h
ALIIYWPf0plxnuVVGjX17xcj0bWLykcVw/cljIK1jsEvx27AcgO0EYg3onWBzUzO
adoBlhMfSDOyDnF9qQ+QmeSOuJ1guZxdtUlhbhRDptg3+UGoP4TA/aAxLaTbnO6d
Leb80bCuqJZh5r2b8g6bYj1egIKByOSonO0hZy3zNZQbhuRtIYrTvtR83Y0QBuCU
NaM3Lt7+hKxN3G4kopTCDWpbFIU2yP25PyGZx7NROeRZf1xnguPd/d6BbziQnzw=
=+Wob
-----END PGP SIGNATURE-----

--Uhue2XggQhMllNNodKBuCoF3nWdm5bJtN--
