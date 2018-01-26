Received: from eggs.gnu.org ([2001:4830:134:3::10]:43991)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ef9qw-0005KU-Dw
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 14:39:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ef9qv-00015V-FL
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 14:39:58 -0500
References: <cover.1516978645.git.berto@igalia.com>
	<0c07738db12f556285f8db01d68c5d6b4304bde9.1516978645.git.berto@igalia.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c0cb3f08-f464-639c-3ddd-1fb780294af4@redhat.com>
Date: Fri, 26 Jan 2018 13:39:50 -0600
MIME-Version: 1.0
In-Reply-To: <0c07738db12f556285f8db01d68c5d6b4304bde9.1516978645.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Yoz9wk4tJVhdYvPtf5a9nEIWhnhu1Pr3n"
Subject: Re: [Qemu-devel] [PATCH v3 27/39] qcow2: Update
 qcow2_update_snapshot_refcount() to support L2 slices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Yoz9wk4tJVhdYvPtf5a9nEIWhnhu1Pr3n
From: Eric Blake <eblake@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 "Denis V . Lunev" <den@openvz.org>
Message-ID: <c0cb3f08-f464-639c-3ddd-1fb780294af4@redhat.com>
Subject: Re: [PATCH v3 27/39] qcow2: Update qcow2_update_snapshot_refcount()
 to support L2 slices
References: <cover.1516978645.git.berto@igalia.com>
 <0c07738db12f556285f8db01d68c5d6b4304bde9.1516978645.git.berto@igalia.com>
In-Reply-To: <0c07738db12f556285f8db01d68c5d6b4304bde9.1516978645.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/26/2018 08:59 AM, Alberto Garcia wrote:
> qcow2_update_snapshot_refcount() increases the refcount of all
> clusters of a given snapshot. In order to do that it needs to load all
> its L2 tables and iterate over their entries. Since we'll be loading
> L2 slices instead of full tables we need to add an extra loop that
> iterates over all slices of each L2 table.
>=20
> This function doesn't need any additional changes so apart from that
> this patch simply updates the variable name from l2_table to l2_slice.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/qcow2-refcount.c | 31 +++++++++++++++++--------------
>  1 file changed, 17 insertions(+), 14 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--Yoz9wk4tJVhdYvPtf5a9nEIWhnhu1Pr3n
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlprhAYACgkQp6FrSiUn
Q2rsVwf+LhrTxKEHycLiSg3MW/cTec22LCMHIU0GVmyYYlRp1c/dkgTQgMYeZbrd
RC8391u3bTtBSG4+s3dpORKwKW1sKmf8eh5nVPGSeyTn/7Qw2v8OmLi3l2v9px1I
CtKRANgJfGziKnE+ljXvZwdTFNBSE5JG+7bcdHyFHiKMNHnpzyhHqyyO1Q+9SlDH
7E3njTUBMWoIKpgEUZW2byWzGzOnC81rzC0IqvqtxWQNLOwCzwz783lQTIJsDqks
Z8ocP+4bFTgA0UekZ/btSgLpfQyeKXUquexfBKQlbeKlPhdziK+cLhJT7KLQT2ZX
yozSZPL8ndPlHnlVX5ge2lhMpubohQ==
=sInu
-----END PGP SIGNATURE-----

--Yoz9wk4tJVhdYvPtf5a9nEIWhnhu1Pr3n--
