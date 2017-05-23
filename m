Received: from eggs.gnu.org ([2001:4830:134:3::10]:47849)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dDAvr-0006Or-Hr
	for qemu-devel@nongnu.org; Tue, 23 May 2017 10:37:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dDAvl-0001LJ-Mt
	for qemu-devel@nongnu.org; Tue, 23 May 2017 10:37:07 -0400
References: <cover.1495536228.git.berto@igalia.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <142326a3-eaa4-8333-9580-ae0063f8a876@redhat.com>
Date: Tue, 23 May 2017 09:36:52 -0500
MIME-Version: 1.0
In-Reply-To: <cover.1495536228.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="J6O2dp2sVXuclLum1PHca43Ug9hmRcsaD"
Subject: Re: [Qemu-devel] [PATCH 0/7] qcow2: Reduce the number of I/O ops
 when doing COW
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Denis V . Lunev" <den@openvz.org>, Anton Nefedov <anton.nefedov@virtuozzo.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--J6O2dp2sVXuclLum1PHca43Ug9hmRcsaD
From: Eric Blake <eblake@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 "Denis V . Lunev" <den@openvz.org>,
 Anton Nefedov <anton.nefedov@virtuozzo.com>
Message-ID: <142326a3-eaa4-8333-9580-ae0063f8a876@redhat.com>
Subject: Re: [PATCH 0/7] qcow2: Reduce the number of I/O ops when doing COW
References: <cover.1495536228.git.berto@igalia.com>
In-Reply-To: <cover.1495536228.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/23/2017 06:22 AM, Alberto Garcia wrote:
> Hi all,
>=20
> here's a patch series that rewrites the copy-on-write code in the
> qcow2 driver to reduce the number of I/O operations.

And it competes with Denis and Anton's patches:
https://lists.gnu.org/archive/html/qemu-devel/2017-05/msg04547.html

What plan of attack should we take on merging the best parts of these
two series?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--J6O2dp2sVXuclLum1PHca43Ug9hmRcsaD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZJEkEAAoJEKeha0olJ0NqsuYH/0ySFjiWu9CoXIUk/z7+9tTI
RvuJZxkCnErbry2gJ0QL+X9g5NSv8A2UL87kr3nofINpWXiiXSAOYz9Ys3SzHiLY
p+SpcvXfbYo2wqg7b+nZIVrMpGYGg7+/JXCcH/CetHrnX5tjI8Oy02tev1sg7D0C
d3CIUU6vRKeoxG8Vz6qz0w/gvnEkNiyRThH89VOvL9jZ2b6QFaQh4k36sWFoqKCn
4V6yS17EQ+8uWaSCJHJ7e52xz21pNpQcgdfF89nct+ZHvOuAVeoskQnaTSPFQ49b
d6WwpAQISI/QnnqlQ9M1mTZ1oiv7okb0OMJkT8fxVIsc0mWUIJFfm/lPYoG0ong=
=AK/W
-----END PGP SIGNATURE-----

--J6O2dp2sVXuclLum1PHca43Ug9hmRcsaD--
