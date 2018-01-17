Received: from eggs.gnu.org ([2001:4830:134:3::10]:46051)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ebqdX-0005CC-L6
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 11:32:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ebqdW-0004WC-Oo
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 11:32:27 -0500
References: <cover.1513342045.git.berto@igalia.com>
	<6e65a6dad8d2b486224d814b160a10d6dede7bfe.1513342045.git.berto@igalia.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3c337f81-a14a-9f37-b7e0-beb86b1d0cf0@redhat.com>
Date: Wed, 17 Jan 2018 10:31:50 -0600
MIME-Version: 1.0
In-Reply-To: <6e65a6dad8d2b486224d814b160a10d6dede7bfe.1513342045.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="sxaHTGflvMa2VqVZqWFHwNZf3Z21d0efb"
Subject: Re: [Qemu-devel] [PATCH v2 27/32] qcow2: Rename l2_table in
 qcow2_alloc_compressed_cluster_offset()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "Denis V . Lunev" <den@openvz.org>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--sxaHTGflvMa2VqVZqWFHwNZf3Z21d0efb
From: Eric Blake <eblake@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "Denis V . Lunev" <den@openvz.org>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Message-ID: <3c337f81-a14a-9f37-b7e0-beb86b1d0cf0@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 27/32] qcow2: Rename l2_table in
 qcow2_alloc_compressed_cluster_offset()
References: <cover.1513342045.git.berto@igalia.com>
 <6e65a6dad8d2b486224d814b160a10d6dede7bfe.1513342045.git.berto@igalia.com>
In-Reply-To: <6e65a6dad8d2b486224d814b160a10d6dede7bfe.1513342045.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/15/2017 06:53 AM, Alberto Garcia wrote:
> This function doesn't need any changes to support L2 slices, but since
> it's now dealing with slices intead of full tables, the l2_table

s/intead/instead/

> variable is renamed for clarity.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/qcow2-cluster.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--sxaHTGflvMa2VqVZqWFHwNZf3Z21d0efb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpfenYACgkQp6FrSiUn
Q2ro1wgAngY3x1FVnyVSiHOl83EnPj6GMVRKU7FQheRSHjx/8lRSKgXuSiuTGtqt
UX0VYu9X6BjBL95ommIvd18kkSNhuaDZZeBJZgjxJf2vRs4qeo7QM7nDSIfNk2Hj
xdqxF9qR8B5Y8+jj0nmtt5azBBnr1WrysOygxRB52nFtHFXB3unVFMMBkGWJu6Bh
aFfCnzymTn2kANP2GR56JBBkEexKhnGtNF/GsPIVACoXSZxXNNjO/WCeRa3xHx3v
YeJBCpzsY6fpw95doIdSveSujtuCLgd5RokkF2UDPNeXIylWPX62ktGJlWfXJq11
LyKo4MO+KT0dfDaEhPtIQ0HaY76uog==
=G0EL
-----END PGP SIGNATURE-----

--sxaHTGflvMa2VqVZqWFHwNZf3Z21d0efb--
