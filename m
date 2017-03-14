Received: from eggs.gnu.org ([2001:4830:134:3::10]:45491)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnse7-0006Qw-49
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 16:02:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnse2-0000Gu-9f
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 16:02:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49998)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cnse2-0000GK-0n
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 16:02:10 -0400
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
	<1489385927-6735-31-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4b7ca3de-44c7-6500-2d3b-b3229943b290@redhat.com>
Date: Tue, 14 Mar 2017 15:02:07 -0500
MIME-Version: 1.0
In-Reply-To: <1489385927-6735-31-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="1A3EIbH4cnPnt7B6oklmdqLb3GBXgiuNg"
Subject: Re: [Qemu-devel] [PATCH for-2.9 30/47] tests/qapi-schema: Improve
 doc / expression mismatch coverage
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
--1A3EIbH4cnPnt7B6oklmdqLb3GBXgiuNg
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com
Message-ID: <4b7ca3de-44c7-6500-2d3b-b3229943b290@redhat.com>
Subject: Re: [PATCH for-2.9 30/47] tests/qapi-schema: Improve doc / expression
 mismatch coverage
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
 <1489385927-6735-31-git-send-email-armbru@redhat.com>
In-Reply-To: <1489385927-6735-31-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/13/2017 01:18 AM, Markus Armbruster wrote:
> New test doc-bad-expr.json shows we fail to reject a misplaced
> expression comment.
>=20
> New test doc-no-symbol.json shows a bad error message.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---

> +++ b/tests/qapi-schema/doc-no-symbol.err
> @@ -0,0 +1 @@
> +tests/qapi-schema/doc-no-symbol.json:4: Definition of 'foo' follows do=
cumentation for 'None'

Yep, that's python implementation leaking through.

> +++ b/tests/qapi-schema/doc-no-symbol.json
> @@ -0,0 +1,7 @@
> +# Documentation for expression lacks symbol
> +# BUG: Error message claims it has symbol 'None'

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--1A3EIbH4cnPnt7B6oklmdqLb3GBXgiuNg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYyEw/AAoJEKeha0olJ0Nqnf0IAKdjJQp8bpzIJ9b7fCcBXjOA
OJE5kT+BpItlpbuiAuR4eaLvFX+33US5cuAD02CeQLsV/goq+zIJCDsRrpaeRxCl
s+GwTAlFJlxL88OwNk3DfiEeVZPyaJFw8kE4hSzZ055bo4qd95mUhXeJtRYkOuIA
BGlcBXrqlL6UVGZ4PLfYSlQ+z+Pypae9Dah2PNUucWEUm/sWVfJbc8Vx6MZhKc4p
l6MZ2rJ9VFVByoOQn3UFOmKxZGP+7L1Q3vdtD8kP8HcYYh+BXq7mCBYdObQp3ZjE
igucSS6GKuisU2IAtReIkldNhnUZht244iqrJ8HBD92cW7MBzm+wICfXPlqZw+4=
=n6wc
-----END PGP SIGNATURE-----

--1A3EIbH4cnPnt7B6oklmdqLb3GBXgiuNg--
