Received: from eggs.gnu.org ([2001:4830:134:3::10]:43605)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ciU6t-0004li-IT
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 17:49:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ciU6p-0002pi-Ai
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 17:49:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60922)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ciU6p-0002p0-4K
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 17:49:35 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 352D561B85
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 22:49:35 +0000 (UTC)
References: <1488145424-14974-1-git-send-email-armbru@redhat.com>
	<1488145424-14974-17-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5247fbd2-566b-7117-c836-be6f211387f5@redhat.com>
Date: Mon, 27 Feb 2017 16:49:33 -0600
MIME-Version: 1.0
In-Reply-To: <1488145424-14974-17-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Ci3tofal9bx62aTUUtCBQqWedQAuH0Dqg"
Subject: Re: [Qemu-devel] [PATCH v2 16/26] test-qobject-input-visitor: Use
 strict visitor
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
--Ci3tofal9bx62aTUUtCBQqWedQAuH0Dqg
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Message-ID: <5247fbd2-566b-7117-c836-be6f211387f5@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 16/26] test-qobject-input-visitor: Use
 strict visitor
References: <1488145424-14974-1-git-send-email-armbru@redhat.com>
 <1488145424-14974-17-git-send-email-armbru@redhat.com>
In-Reply-To: <1488145424-14974-17-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/26/2017 03:43 PM, Markus Armbruster wrote:
> The qobject input visitor comes in a strict and a non-strict variant.
> This test is the non-strict variant's last user.  Turns out it relies
> on non-strict only in test_visitor_in_null(), and just out of
> laziness.  We don't actually test the non-strict behavior.
>=20
> Clean up test_visitor_in_null(), and switch to the strict variant.
> The next commit will drop the non-strict variant.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  tests/test-qobject-input-visitor.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--Ci3tofal9bx62aTUUtCBQqWedQAuH0Dqg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYtKz9AAoJEKeha0olJ0Nq3IEIAIBhqG3Fw6R5H2qFpg+8FE1P
Y1y/PyPrTE4zAVAYtkNYyENr62zhPlKCKgGVziOlmERaFTx1Rg8+CGWdGCa3uz6V
bC+30EiI4yYNoZVQmqS43gzvaYA7Fmc1DiGGa2yaACj14SWwymXYhERdrz8MXGTj
8XNHfZfKDLm9zlRprQkHl3lnpVl8q/1nm2VR4l8tG4lQN5uG5WvBTdszEsIhiDKV
je3pQyh38FqlA67CmkmuopfRLE69ccF+yF5KAJKm7dC0GLjDxXyEqLlxbIWloXu7
GxHT2fDHgmlf+p9zm8B6hZqbh2WLEh8T2GhwjzzW+jfzy94OAF37sIY3WDJrI7I=
=eM+N
-----END PGP SIGNATURE-----

--Ci3tofal9bx62aTUUtCBQqWedQAuH0Dqg--
