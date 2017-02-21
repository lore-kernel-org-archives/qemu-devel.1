Received: from eggs.gnu.org ([2001:4830:134:3::10]:45048)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cgByk-0004iG-7d
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 10:03:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cgByg-0001O6-BB
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 10:03:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54674)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cgByg-0001Nj-5Z
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 10:03:42 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4E9002E604C
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 15:03:42 +0000 (UTC)
References: <1487363905-9480-1-git-send-email-armbru@redhat.com>
	<1487363905-9480-7-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5472db9a-9382-cae6-5021-d16afaff688a@redhat.com>
Date: Tue, 21 Feb 2017 09:03:40 -0600
MIME-Version: 1.0
In-Reply-To: <1487363905-9480-7-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="3odkiFO1hkQBsaPigSuKx67aw0s8QiaIq"
Subject: Re: [Qemu-devel] [PATCH 06/14] test-qmp-event: Simplify and tighten
 event_test_emit()
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
--3odkiFO1hkQBsaPigSuKx67aw0s8QiaIq
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Message-ID: <5472db9a-9382-cae6-5021-d16afaff688a@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 06/14] test-qmp-event: Simplify and tighten
 event_test_emit()
References: <1487363905-9480-1-git-send-email-armbru@redhat.com>
 <1487363905-9480-7-git-send-email-armbru@redhat.com>
In-Reply-To: <1487363905-9480-7-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/17/2017 02:38 PM, Markus Armbruster wrote:
> Use qdict_get_qdict() and qdict_get_try_int() to simplify.
>=20
> While there, add a sanity check for seconds.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  tests/test-qmp-event.c | 14 ++++----------
>  1 file changed, 4 insertions(+), 10 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--3odkiFO1hkQBsaPigSuKx67aw0s8QiaIq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYrFbMAAoJEKeha0olJ0Nq3aMIAJsq9mRYhRDQPx/5JCnIhnDm
psxj8az5LzUiPwyllAmd9ugIbgXmkjsXp1lZF7JcToHMZWDYxTmpMTQKzNV0m9Fo
F6T5X6GwiWL1zNO9opXZf1i3emj9A7rC5yXVZg1ER4Uwz3ZyvPq/rUCUbTISpuPP
Ol0ks2pYD7Boy+UCzLvPa8BDxiYjbNI89JBVNbBlY11keKkZFRLoQev9Cp8zT2zi
/4IfQF/JMK+Obw5FIOctjaZ3yL+XfJz8HxltmVZ0a1f+AHvBZl5b4mvb5zUCuQu2
M2NPQ6Pl97IYZdvf44K8dgyvlogGabYTnDi/Ft9rEmQXKeAQRGJ6pCi4ksmV6xM=
=ZaK8
-----END PGP SIGNATURE-----

--3odkiFO1hkQBsaPigSuKx67aw0s8QiaIq--
