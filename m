Received: from eggs.gnu.org ([2001:4830:134:3::10]:60099)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cjrjW-0006nu-KZ
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 13:15:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cjrjS-0000lP-Ip
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 13:15:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51034)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cjrjS-0000kh-D2
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 13:15:10 -0500
References: <148856422757.9841.6298006998523421948.stgit@bahia.lan>
From: Eric Blake <eblake@redhat.com>
Message-ID: <cc7aa908-4f7c-20d9-9cfe-982ab83a26b3@redhat.com>
Date: Fri, 3 Mar 2017 12:15:08 -0600
MIME-Version: 1.0
In-Reply-To: <148856422757.9841.6298006998523421948.stgit@bahia.lan>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="DjNslXs5RGGDgoCXKlkS1nJR9mrQL5bc1"
Subject: Re: [Qemu-devel] [PATCH] 9pfs: fail local_statfs() earlier
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DjNslXs5RGGDgoCXKlkS1nJR9mrQL5bc1
From: Eric Blake <eblake@redhat.com>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <cc7aa908-4f7c-20d9-9cfe-982ab83a26b3@redhat.com>
Subject: Re: [PATCH] 9pfs: fail local_statfs() earlier
References: <148856422757.9841.6298006998523421948.stgit@bahia.lan>
In-Reply-To: <148856422757.9841.6298006998523421948.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/03/2017 12:03 PM, Greg Kurz wrote:
> If we cannot open the given path, we can return right away instead of
> passing -1 to fstatfs() and close(). This will make Coverity happy.
>=20
> (Coverity issue CID1371729)
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  hw/9pfs/9p-local.c |    3 +++
>  1 file changed, 3 insertions(+)

No difference in end-user observable behavior, but arguably nicer (and
always more efficient to avoid unneeded syscalls).

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--DjNslXs5RGGDgoCXKlkS1nJR9mrQL5bc1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYubKsAAoJEKeha0olJ0NqsykH/0QvaoxO7Hts3UF0aRXvCAQu
vp5cbCCOwFchWt7w0iQ7+AZLZVQ+XN0p+iwMpfHMAkID+X8E8joe6KVx8StVDdhl
IOoyKqFa2o92IoYQKRS10ZVNjwjfCfITw5VUItVW1qIEgzIbJjfY0NeDT2BkLLEe
oEcoC+JRQ1jXAdgfyp5jB6DCN8jissA7ZQ7g4DmNcY8YTyUdqOg3VdKzxd8T+Ink
QIyj95ePBqiFgsnW+emNCBefsV/UUrkVNo4vo/oBgwvo2RYQyhMTHapm2QJ+tLU8
Px9UjnwieLxMuYvjIYQfCBwYa6/GD5ns89P2+EbBliYNqZ9tOthk2C9JZI8uOvc=
=J6kH
-----END PGP SIGNATURE-----

--DjNslXs5RGGDgoCXKlkS1nJR9mrQL5bc1--
