Received: from eggs.gnu.org ([2001:4830:134:3::10]:36654)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cijxV-0003HB-0n
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 10:45:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cijxR-0007VG-Va
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 10:45:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42512)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cijxR-0007Ux-PJ
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 10:44:57 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DF22D33C17C
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 15:44:57 +0000 (UTC)
References: <1488145424-14974-1-git-send-email-armbru@redhat.com>
	<1488145424-14974-20-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c4df7917-1081-9fce-7bec-28a1467e88e1@redhat.com>
Date: Tue, 28 Feb 2017 09:44:55 -0600
MIME-Version: 1.0
In-Reply-To: <1488145424-14974-20-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="R65PK9qN8T5FTw8PtvjXgTUeFQQdcsoil"
Subject: Re: [Qemu-devel] [PATCH v2 19/26] test-string-input-visitor: Tear
 down existing test automatically
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--R65PK9qN8T5FTw8PtvjXgTUeFQQdcsoil
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Message-ID: <c4df7917-1081-9fce-7bec-28a1467e88e1@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 19/26] test-string-input-visitor: Tear
 down existing test automatically
References: <1488145424-14974-1-git-send-email-armbru@redhat.com>
 <1488145424-14974-20-git-send-email-armbru@redhat.com>
In-Reply-To: <1488145424-14974-20-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/26/2017 03:43 PM, Markus Armbruster wrote:
> Call visitor_input_teardown() from visitor_input_test_init(), so you
> don't have to call it from the actial tests.

s/actial/actual/

>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  tests/test-string-input-visitor.c | 19 ++-----------------
>  1 file changed, 2 insertions(+), 17 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

I tested this one under valgrind to ensure no weird memory issues
cropped up, so you can also add:

Tested-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--R65PK9qN8T5FTw8PtvjXgTUeFQQdcsoil
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYtZr3AAoJEKeha0olJ0NqtBIIAKC8tcKCJ7QV1Mt5ZaD19ye4
RPAWcW7MzhwaqiW0DKAoCDYLf/TIcB15Rkb8aeB3HPcyZlbJ20xyX6ZQpBJzpY/e
wi1832QsYfJsyy+2POA8mFr9//3KMNLdGKTX/hGlIrTZNTLeEIdYWB+R6G6wTqeE
o8yN9p14H9HhhTlF7M+NvslrvIEL1Ngixn7Azq64wvFCRYK5pdnu5tErcaj4gePI
sLM0fjbOlhWC6Vq39E3dr9QrOhptVXDkaWpGpFyz+brhZXJgq5ibNfdvHfOAc38Y
1ULszyOzn+2ZDJaxOJl/QdaQSZs0Gj5d3e6o8vMyi9efXZvgcQF89hVVzxz4qsA=
=Uqo0
-----END PGP SIGNATURE-----

--R65PK9qN8T5FTw8PtvjXgTUeFQQdcsoil--
