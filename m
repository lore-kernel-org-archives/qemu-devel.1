Received: from eggs.gnu.org ([2001:4830:134:3::10]:37208)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1co9s1-0008Fj-IO
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 10:25:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1co9ry-0001cG-DC
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 10:25:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41934)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1co9ry-0001bc-4Q
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 10:25:42 -0400
References: <1489582656-31133-1-git-send-email-armbru@redhat.com>
	<1489582656-31133-3-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3a9be3bd-4634-8ce8-8d95-04b4efa645d0@redhat.com>
Date: Wed, 15 Mar 2017 09:25:38 -0500
MIME-Version: 1.0
In-Reply-To: <1489582656-31133-3-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="AQBVwLWDhAHCg2dWJhme1uRL1OnwWKDIC"
Subject: Re: [Qemu-devel] [PATCH v2 for-2.9 02/47] qapi: Make doc comments
 optional where we don't need them
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
--AQBVwLWDhAHCg2dWJhme1uRL1OnwWKDIC
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com
Message-ID: <3a9be3bd-4634-8ce8-8d95-04b4efa645d0@redhat.com>
Subject: Re: [PATCH v2 for-2.9 02/47] qapi: Make doc comments optional where
 we don't need them
References: <1489582656-31133-1-git-send-email-armbru@redhat.com>
 <1489582656-31133-3-git-send-email-armbru@redhat.com>
In-Reply-To: <1489582656-31133-3-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/15/2017 07:56 AM, Markus Armbruster wrote:
> Since we added the documentation generator in commit 3313b61, doc
> comments are mandatory.  That's a very good idea for a schema that
> needs to be documented, but has proven to be annoying for testing.
>=20
> Make doc comments optional again, but add a new directive
>=20
>     { 'pragma': { 'doc-required': true } }
>=20
> to let a QAPI schema require them.
>=20
> Add test cases for the new pragma directive.  While there, plug a
> minor hole in includ directive test coverage.

s/includ/include/

>=20
> Require documentation in the schemas we actually want documented:
> qapi-schema.json and qga/qapi-schema.json.
>=20
> We could probably make qapi2texi.py cope with incomplete
> documentation, but for now, simply make it refuse to run unless the
> schema has 'doc-required': true.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---

> +=3D=3D=3D Pragma directives =3D=3D=3D
> +
> +Usage: { 'pragma': DICT }
> +
> +The pragma directive lets you control optional generator behavior.
> +The dictionary's entries are pragma names and values.
> +
> +Pragma's scope is currently the complete schema.  Setting it to

You can do:

{ 'pragma': { 'doc-required': true } }
{ 'pragma': { 'whitelist': [...] } }

what you can't do is:

{ 'pragma': { 'doc-required': true } }
{ 'pragma': { 'doc-required': false } }

Maybe s/Setting it/Setting a given pragma name/

> +different values in parts of the schema doesn't work.
> +
> +Pragma 'doc-required' takes a boolean value.  If true, documentation
> +is required.  Default is false.
> +
> +

The new tests are nice; thanks.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--AQBVwLWDhAHCg2dWJhme1uRL1OnwWKDIC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYyU7iAAoJEKeha0olJ0Nq0xEH/21UzrFe+momMfr9n8W2BuZO
c1339UIxId2SjJCMI4/tCbjdXmTmJU/Cs00XJlcbJdbM7uChjdY2BCGvbcx3zj9+
mQ2/mLqL80iTLsCY/sSRFjLalBNELE5phVFgUNLpTpJLofP4ossT2jD7yJu9yiOY
gMeA01hb7g43wFSqStoknWF6bWPWIZ2xQtrkPZqR4A1ayLI0pKNHGw3TdtYaL7Nz
8t8UmlP2PXiczUQWUaLKvEDWB4UV49OAEr+GtcsCPIWvAa6RBjFzYM4WBqsIm38Y
yFOY+/QNtPB0UU/F/nHPqQNaJPcIvPYEApEr7/8X5HmDsDUgeHLl7nrcQRfEU3c=
=Pfpy
-----END PGP SIGNATURE-----

--AQBVwLWDhAHCg2dWJhme1uRL1OnwWKDIC--
