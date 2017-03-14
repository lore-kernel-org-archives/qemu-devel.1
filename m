Received: from eggs.gnu.org ([2001:4830:134:3::10]:44769)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cntWq-0005QL-0I
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 16:58:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cntWm-0005No-4N
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 16:58:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35532)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cntWl-0005NY-SU
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 16:58:44 -0400
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
	<1489385927-6735-38-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <bc3be621-32d3-3c3f-2c9e-28de700742e3@redhat.com>
Date: Tue, 14 Mar 2017 15:58:41 -0500
MIME-Version: 1.0
In-Reply-To: <1489385927-6735-38-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="eRf38igEJsCV2Pl7IdA5xluPuTH1Iv98x"
Subject: Re: [Qemu-devel] [PATCH for-2.9 37/47] qapi: Fix detection of bogus
 member documentation
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
--eRf38igEJsCV2Pl7IdA5xluPuTH1Iv98x
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com
Message-ID: <bc3be621-32d3-3c3f-2c9e-28de700742e3@redhat.com>
Subject: Re: [PATCH for-2.9 37/47] qapi: Fix detection of bogus member
 documentation
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
 <1489385927-6735-38-git-send-email-armbru@redhat.com>
In-Reply-To: <1489385927-6735-38-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/13/2017 01:18 AM, Markus Armbruster wrote:
> check_definition_doc() checks for member documentation without a
> matching member.  It laboriously second-guesses what members
> QAPISchema._def_exprs() will create.  That's a stupid game.
>=20
> Move the check into QAPISchema.check(), where the members are known.
> Delegate the actual checking to new QAPIDoc.check().
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  scripts/qapi.py                             | 38 ++++++++++-----------=
--------
>  tests/qapi-schema/doc-bad-union-member.err  |  1 +
>  tests/qapi-schema/doc-bad-union-member.exit |  2 +-
>  tests/qapi-schema/doc-bad-union-member.out  | 11 ---------
>  4 files changed, 15 insertions(+), 37 deletions(-)

Nice diffstat.


> +++ b/tests/qapi-schema/doc-bad-union-member.err
> @@ -0,0 +1 @@
> +tests/qapi-schema/doc-bad-union-member.json:3: The following documente=
d members are not in the declaration: a, b

Nice that you're able to report all problems within the doc, rather than
stopping at the first.  (Wish we could do the same about the overall
=2Ejson file, but that's harder, and out of scope for this series)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--eRf38igEJsCV2Pl7IdA5xluPuTH1Iv98x
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYyFmBAAoJEKeha0olJ0NqY28H/3BjrkYOh6Y4yLJ8XVPYME9X
3WGBlI8X2+s0fnEHHWT0/pA4grdTfqbQtr5Di1iS3QGIM4HkMqYKBjGT2uT4u0cl
wiIxtuvFX3/JE+TKvKaFax+wLkuwPzsOKiZO/5EQGroKhVj5aGBPS8UMNX+XOyGL
uXJrn7YC3IhKCtaZ55ZP7Zt06II1ESD95Ky2K8RTdc3nK7tmsDlgHx9HkccGS2f+
g3FjhSTwOOfb5IilUY8eXiO8ptGYf5m2/+rfBraCqiTR4inZY/5QuzoJOzFwWU7V
6Zb8MuhLoijJdB7PQ81Hv8AxQ3agysd1XpgvoRCWTIkkKjhItLvKqyLB5fbEjWg=
=ZU8j
-----END PGP SIGNATURE-----

--eRf38igEJsCV2Pl7IdA5xluPuTH1Iv98x--
