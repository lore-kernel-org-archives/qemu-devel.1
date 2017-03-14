Received: from eggs.gnu.org ([2001:4830:134:3::10]:57181)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnoqK-0005yh-C6
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 11:58:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnoqG-0004Or-F0
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 11:58:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55770)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cnoqG-0004Oa-5i
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 11:58:32 -0400
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
	<1489385927-6735-10-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7c64dd61-f62c-caaf-66ae-1c5c53ae5c26@redhat.com>
Date: Tue, 14 Mar 2017 10:58:29 -0500
MIME-Version: 1.0
In-Reply-To: <1489385927-6735-10-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="iLSKATNpk8Gp3NQVLEsRHNAPk7NRknGkb"
Subject: Re: [Qemu-devel] [PATCH for-2.9 09/47] qapi: Fix to reject empty
 union base gracefully
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
--iLSKATNpk8Gp3NQVLEsRHNAPk7NRknGkb
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com
Message-ID: <7c64dd61-f62c-caaf-66ae-1c5c53ae5c26@redhat.com>
Subject: Re: [PATCH for-2.9 09/47] qapi: Fix to reject empty union base
 gracefully
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
 <1489385927-6735-10-git-send-email-armbru@redhat.com>
In-Reply-To: <1489385927-6735-10-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/13/2017 01:18 AM, Markus Armbruster wrote:
> Common Python pitfall: 'assert base_members' fires on [] in addition
> to None.  Correct to 'assert base_members is not None'.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  scripts/qapi.py                        |  2 +-
>  tests/qapi-schema/union-base-empty.err | 11 +----------
>  2 files changed, 2 insertions(+), 11 deletions(-)
>=20

> +++ b/tests/qapi-schema/union-base-empty.err
> @@ -1,10 +1 @@
> -Traceback (most recent call last):
> -  File "tests/qapi-schema/test-qapi.py", line 56, in <module>
> -    schema =3D QAPISchema(sys.argv[1])
> -  File "scripts/qapi.py", line 1483, in __init__
> -    self.exprs =3D check_exprs(parser.exprs)
> -  File "scripts/qapi.py", line 917, in check_exprs
> -    check_union(expr, info)
> -  File "scripts/qapi.py", line 734, in check_union
> -    assert base_members
> -AssertionError
> +tests/qapi-schema/union-base-empty.json:5: Discriminator 'type' is not=
 a member of base struct 'Empty'

Much nicer message.
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--iLSKATNpk8Gp3NQVLEsRHNAPk7NRknGkb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYyBMlAAoJEKeha0olJ0NqRpwH/A1GdexHacK1VVkGKpw/Euqa
0PEe/tKvsC2uPxHSo6FykrdCWeBSs2/3rLp8ECWQon/cQ0H5KP6yC5eqc3MzZ+Iu
pnnf/w7riha1KpELdtXjXqPx9bXBcIvCrjhcS4haEz4mwdQKJHZdFfFYar4dGLMM
5rf3i+I6XnTpP9wyaMIrcNX6EphkwOWGZMXLBJYloHMIX/q64fTDfmRD7hYQ9WAc
Vr/VvCspkNpZnzHNsc8hFZSYAFc8p3yKr5ZpilJZXIfe7TgqRLBhSvlXjGK5mEgy
CdXWtT3SmeWPQenhwvGLtoBI5QyP4DNYwdwIHUjRGviiiQ7xwCW/CK1zQwwVaBU=
=LkHO
-----END PGP SIGNATURE-----

--iLSKATNpk8Gp3NQVLEsRHNAPk7NRknGkb--
