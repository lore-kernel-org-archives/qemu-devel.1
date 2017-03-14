Received: from eggs.gnu.org ([2001:4830:134:3::10]:60919)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnqIl-0005cd-LZ
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 13:32:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnqIh-00020X-M9
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 13:32:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35216)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cnqIh-00020D-DX
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 13:31:59 -0400
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
	<1489385927-6735-17-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b2d0adab-3200-c74a-4c1e-d4b5bbae7b6e@redhat.com>
Date: Tue, 14 Mar 2017 12:31:56 -0500
MIME-Version: 1.0
In-Reply-To: <1489385927-6735-17-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="tk4qKrl8QuoqKBO3Lgwb3RMtrSm9wK1xL"
Subject: Re: [Qemu-devel] [PATCH for-2.9 16/47] qapi2texi: Convert to
 QAPISchemaVisitor
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
--tk4qKrl8QuoqKBO3Lgwb3RMtrSm9wK1xL
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com
Message-ID: <b2d0adab-3200-c74a-4c1e-d4b5bbae7b6e@redhat.com>
Subject: Re: [PATCH for-2.9 16/47] qapi2texi: Convert to QAPISchemaVisitor
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
 <1489385927-6735-17-git-send-email-armbru@redhat.com>
In-Reply-To: <1489385927-6735-17-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/13/2017 01:18 AM, Markus Armbruster wrote:
> qapi2texi works with schema expression trees.  Such a tight coupling
> to schema language syntax is not a good idea.  Convert it to the visito=
r
> interface the other generators use.
>=20
> No change to generated documentation.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  scripts/qapi2texi.py | 228 ++++++++++++++++++++++++++-----------------=
--------
>  1 file changed, 118 insertions(+), 110 deletions(-)
>=20

> +    def visit_object_type(self, name, info, base, members, variants):
> +        doc =3D self.cur_doc
> +        if not variants:
> +            typ =3D 'Struct'
> +        elif variants._tag_name:        # TODO unclean member access
> +            typ =3D 'Flat Union'
> +        else:
> +            typ =3D 'Simple Union'

Do we even want to document this distinction to the end user?
Introspection managed to hide the difference by introducing the
appropriate generated wrapper types that demonstrate the additional {}
nesting in a way compatible with rewriting simple unions into flat
unions.  If we don't explain the difference here, we can get rid of the
unclean member access, but then again risk documentation that is not
clear whether {} nesting is needed.

I guess there's also the fact that for this patch, you intentionally
tried to make no difference to the generated docs (good); so any tweaks
to union output should be later patches anyways.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--tk4qKrl8QuoqKBO3Lgwb3RMtrSm9wK1xL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYyCkMAAoJEKeha0olJ0NqGAcH/A/XP4MT/DB4IRh6rUYSF8id
J89ok8EPLDEPD+pNrXP3vOd36kWUnQ1Q2utIZBptWmV89Ohqvo/YlZETm3UJRXr9
blmyWWvpzEJ3IDWrb0aBqcNgWCA/3xmWfoqvu3va6Y1TSscy6lQRSIklA5aRFll8
p7taK+wt5gts25VlCfM4OsKwIF5b8+BO86JlZVZxK7r93emqxu5c9F/kS/3MZXAq
QFVrW2Ubov6bl+/itn2mQbgTqlX6PSZy5eAUxaEwk/Ob2WCgBE8zoANMLw4ru1BH
niBuZgEZpnddHvZSf/TnUZB87rc1KIbLKiVEJwWWQi/nSo1ZEd5oid9TcfEBvkE=
=136U
-----END PGP SIGNATURE-----

--tk4qKrl8QuoqKBO3Lgwb3RMtrSm9wK1xL--
