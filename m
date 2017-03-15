Received: from eggs.gnu.org ([2001:4830:134:3::10]:51623)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnwtQ-0005Ex-39
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 20:34:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnwtM-0004fg-Vv
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 20:34:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44120)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cnwtM-0004ef-Ph
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 20:34:16 -0400
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
	<1489385927-6735-41-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4e4521b3-aff9-94fa-297f-96d69169c631@redhat.com>
Date: Tue, 14 Mar 2017 19:34:14 -0500
MIME-Version: 1.0
In-Reply-To: <1489385927-6735-41-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="9shRHtJ82Vx78JE7Gc4NBha0TvJMAXcL1"
Subject: Re: [Qemu-devel] [PATCH for-2.9 40/47] qapi: Simplify what gets
 stored in enum_types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9shRHtJ82Vx78JE7Gc4NBha0TvJMAXcL1
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com
Message-ID: <4e4521b3-aff9-94fa-297f-96d69169c631@redhat.com>
Subject: Re: [PATCH for-2.9 40/47] qapi: Simplify what gets stored in
 enum_types
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
 <1489385927-6735-41-git-send-email-armbru@redhat.com>
In-Reply-To: <1489385927-6735-41-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/13/2017 01:18 AM, Markus Armbruster wrote:
> Don't invent a new dictionary structure just for enum_types, simply
> store the defining expression, like we do for struct_types and
> union_types.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  scripts/qapi.py | 29 +++++++++++++++--------------
>  1 file changed, 15 insertions(+), 14 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--9shRHtJ82Vx78JE7Gc4NBha0TvJMAXcL1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYyIwGAAoJEKeha0olJ0Nq1rgH/3MHhhJSc+rkK6lW4BjGYDGB
NHb6fGLfPM3/kqNMsNoUOdyt1ahUjTKolQUKxDOT+H7Wr8064JW6rTOgjh+bvslW
/FWHtbVJIuCIMAlgzznmt0SYgauygkpZZ4J6me+2hb7qIv9Rop5yHOVa+Gg2dJT9
Y07IPnf7AN8qYXOQv0K8taBsPjDDwKlXSF8UbqZ6Umvc+zKEtvkz14bEsfgjbX3T
hnMIbyJs0eUodLqK9NuQRySG7FXecYkvGUc7cQS6QzcdKFCuDIOHwVabPfubbFUG
k2pddMslbFMBvo3I/9UeJUBJHx5xUhfahi5y3L+N8hgo4ez5T5MTE7nS0hcq6i0=
=vZca
-----END PGP SIGNATURE-----

--9shRHtJ82Vx78JE7Gc4NBha0TvJMAXcL1--
