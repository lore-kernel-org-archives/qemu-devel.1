Received: from eggs.gnu.org ([2001:4830:134:3::10]:37505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnVjx-0005ha-Gi
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 15:34:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnVjt-0008Dg-HE
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 15:34:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46992)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cnVjt-0008DF-87
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 15:34:41 -0400
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
	<1489385927-6735-2-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <459261c3-cbe8-59a9-7894-942645d826bd@redhat.com>
Date: Mon, 13 Mar 2017 14:34:38 -0500
MIME-Version: 1.0
In-Reply-To: <1489385927-6735-2-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="rcHI0wJ14Ck9hg5JdSBH92XN7cQukKkTK"
Subject: Re: [Qemu-devel] [PATCH for-2.9 01/47] qapi: Factor
 QAPISchemaParser._include() out of .__init__()
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
--rcHI0wJ14Ck9hg5JdSBH92XN7cQukKkTK
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com
Message-ID: <459261c3-cbe8-59a9-7894-942645d826bd@redhat.com>
Subject: Re: [PATCH for-2.9 01/47] qapi: Factor QAPISchemaParser._include()
 out of .__init__()
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
 <1489385927-6735-2-git-send-email-armbru@redhat.com>
In-Reply-To: <1489385927-6735-2-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/13/2017 01:18 AM, Markus Armbruster wrote:
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  scripts/qapi.py | 45 +++++++++++++++++++++++----------------------
>  1 file changed, 23 insertions(+), 22 deletions(-)
>=20

>=20
> +++ b/scripts/qapi.py
> @@ -268,34 +268,15 @@ class QAPISchemaParser(object):
>                  continue
> =20
>              expr =3D self.get_expr(False)
> -            if isinstance(expr, dict) and "include" in expr:
> +            if 'include' in expr:

What happens when expr is not a dict?
/me goes and reads get_expr()...
aha - get_expr() can only return a dict at the top level, and we are
only checking for includes at the top level (it can return non-dict when
nested, but this part of __init__ is not nested).

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--rcHI0wJ14Ck9hg5JdSBH92XN7cQukKkTK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYxvROAAoJEKeha0olJ0Nq66kIAJZnB3iBSKGmREVKau1LqmfH
tq57q8j2Rbatmx4WBTWhgY3wGuGKrESBqv4rGEVaEODCODSDmWk0Wm//i7XdCnXx
UiUCGCkXvfDmaqhi5menQ//jG0QEwVg8zQyPgynrIUMWUpEVYhyadKKaYXZ5hyBS
W8STW3Ty+HLhJ34eqXk19L1XUNlosje7mRCKKQ6wZcQQ9lCiMBw3lxo6QpNgIb4l
PwUVjj8KLDax0WCqha5lM7h6h9o7DqP0lXzNMjtDUl/WZs2zm+bazXers7873G1Q
Rb7jL+RjiCw9pYiuFvF4UNavVkE5lmuB7UVLybUIfuiA39X0hr54Xgp2O8Ss06U=
=HrxJ
-----END PGP SIGNATURE-----

--rcHI0wJ14Ck9hg5JdSBH92XN7cQukKkTK--
