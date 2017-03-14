Received: from eggs.gnu.org ([2001:4830:134:3::10]:34418)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cntAF-0008J8-7K
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 16:35:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cntAC-000775-45
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 16:35:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44192)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cntAB-000755-RR
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 16:35:24 -0400
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
	<1489385927-6735-32-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <bde5a409-92c8-b0b9-178a-a12ddb2ea479@redhat.com>
Date: Tue, 14 Mar 2017 15:35:21 -0500
MIME-Version: 1.0
In-Reply-To: <1489385927-6735-32-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="tFlsPe61IeHRtfDedWSbCgmopSpBNwdrC"
Subject: Re: [Qemu-devel] [PATCH for-2.9 31/47] qapi: Fix detection of doc /
 expression mismatch
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
--tFlsPe61IeHRtfDedWSbCgmopSpBNwdrC
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com
Message-ID: <bde5a409-92c8-b0b9-178a-a12ddb2ea479@redhat.com>
Subject: Re: [PATCH for-2.9 31/47] qapi: Fix detection of doc / expression
 mismatch
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
 <1489385927-6735-32-git-send-email-armbru@redhat.com>
In-Reply-To: <1489385927-6735-32-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/13/2017 01:18 AM, Markus Armbruster wrote:
> This fixes the errors uncovered by the previous commit.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---

> =20
>              expr =3D self.get_expr(False)
>              if 'include' in expr:
> +                self.reject_expr_doc()
>                  if len(expr) !=3D 1:

Do you also need to handle 'pragma' expressions added earlier in the seri=
es?

/me goes and experiments:

diff --git i/tests/qapi-schema/doc-bad-expr.json
w/tests/qapi-schema/doc-bad-expr.json
index 0caa0ae..6c1204d 100644
--- i/tests/qapi-schema/doc-bad-expr.json
+++ w/tests/qapi-schema/doc-bad-expr.json
@@ -4,4 +4,5 @@
 # @foo:
 ##
 { 'include': 'empty.json' }
+{ 'pragma': {} }
 { 'struct': 'foo', 'data': {} }

Oops - back to accepting the program.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--tFlsPe61IeHRtfDedWSbCgmopSpBNwdrC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYyFQJAAoJEKeha0olJ0Nqg3wIAIj/HS0Q8RVTAn95XgIHqrkB
DtYA/FI9kLU3R+2cbvfxrGECfW66JRuS0bErmJ7BAMl00aQ/g/N/sWt4aHqC0GUV
8Ouur2RkqBVvMJ+OTPYdaLO/6Llcy1O8TY5vUexGrbreN2A2c2nw+t67vKSXTDcM
ZEI9FbDTK6yO/OeIooldIhOUC2/0Ih3uTl16j85sKD85uaHG8XSFpdOCP+NqbzTC
DXFFuIjnBa93OCBPH/WJE1vwnD78gqw3suhNu2zQGCREEPYIPgKypRc+btjeYP9A
KfaCJaSveQE3FikQ2SLhviYHXgFASR0oDV09eLVBEbg5etNMBDYxBD1+GWP5buo=
=5OHg
-----END PGP SIGNATURE-----

--tFlsPe61IeHRtfDedWSbCgmopSpBNwdrC--
