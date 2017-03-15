Received: from eggs.gnu.org ([2001:4830:134:3::10]:50848)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1coAQl-0000H9-Mr
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 11:01:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1coAQg-0002Zu-6q
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 11:01:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60958)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1coAQf-0002Yv-Tc
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 11:01:34 -0400
References: <1489582656-31133-1-git-send-email-armbru@redhat.com>
	<1489582656-31133-32-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <dd8a4c15-1cc9-5326-27e9-462f05410e10@redhat.com>
Date: Wed, 15 Mar 2017 10:01:30 -0500
MIME-Version: 1.0
In-Reply-To: <1489582656-31133-32-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="SW8WxA2IvQmplWf4MBe0QoNE6SxNwSEhk"
Subject: Re: [Qemu-devel] [PATCH v2 for-2.9 31/47] qapi: Fix detection of
 doc / expression mismatch
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
--SW8WxA2IvQmplWf4MBe0QoNE6SxNwSEhk
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com
Message-ID: <dd8a4c15-1cc9-5326-27e9-462f05410e10@redhat.com>
Subject: Re: [PATCH v2 for-2.9 31/47] qapi: Fix detection of doc / expression
 mismatch
References: <1489582656-31133-1-git-send-email-armbru@redhat.com>
 <1489582656-31133-32-git-send-email-armbru@redhat.com>
In-Reply-To: <1489582656-31133-32-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/15/2017 07:57 AM, Markus Armbruster wrote:
> This fixes the errors uncovered by the previous commit.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---

>  def check_freeform_doc(doc):
> -    if doc.symbol:
> -        raise QAPISemError(doc.info,
> -                           "Documention for '%s' is not followed"
> -                           " by the definition" % doc.symbol)

> +++ b/tests/qapi-schema/doc-missing-expr.err
> @@ -1 +1 @@
> -tests/qapi-schema/doc-missing-expr.json:3: Documention for 'bar' is no=
t followed by the definition
> +tests/qapi-schema/doc-missing-expr.json:3: Documentation for 'bar' is =
not followed by the definition

I didn't even catch that you were also fixing the typo, on my last round
of reviews :)

R-b stands.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--SW8WxA2IvQmplWf4MBe0QoNE6SxNwSEhk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYyVdKAAoJEKeha0olJ0NqLUEH/15SiaFe2s97BgTKNMd8Scjb
YxKBWRqTWnaGqlwliOYrqaDOM2eqGooFEPukGXAYaSyA90nhsYp9MxdOzl5Cmx23
W2GkxegFA1vXKo1YDmEQigdIS3O9xXXiixBgUmxZ7j/c9H85ctbiZ4O8v0G4lOjw
CSjj4gy+PczN6/2JY3CRUwR8tY9StVUm6ZN7VjDlUfbMPKKBc7FKZ+84PBFIclKI
TZQzKsfUKlCgj++0pXItWDNCRHnEBREmMpytCOlKpQoSRbD69EAc0HJ2aNLriB6s
mJqDJwpxIP/01zFJQVpgn/M78QOKyBJIULETwthowhiKNps53ZbedehCDDJlUH0=
=UFmH
-----END PGP SIGNATURE-----

--SW8WxA2IvQmplWf4MBe0QoNE6SxNwSEhk--
