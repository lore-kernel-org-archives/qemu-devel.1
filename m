Received: from eggs.gnu.org ([2001:4830:134:3::10]:41881)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cikCK-0007vi-Mj
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 11:00:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cikCJ-00051D-Ob
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 11:00:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54532)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cikCJ-0004zO-G2
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 11:00:19 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C87362E605F
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 16:00:15 +0000 (UTC)
References: <1488145424-14974-1-git-send-email-armbru@redhat.com>
	<1488145424-14974-23-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <24436027-2f2f-e233-f51d-f71164bd1e98@redhat.com>
Date: Tue, 28 Feb 2017 10:00:13 -0600
MIME-Version: 1.0
In-Reply-To: <1488145424-14974-23-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="wj4tnifjst128XP2NMG9T2b38qlfr7fbC"
Subject: Re: [Qemu-devel] [PATCH v2 22/26] test-qobject-input-visitor: Cover
 missing nested struct member
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
--wj4tnifjst128XP2NMG9T2b38qlfr7fbC
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Message-ID: <24436027-2f2f-e233-f51d-f71164bd1e98@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 22/26] test-qobject-input-visitor: Cover
 missing nested struct member
References: <1488145424-14974-1-git-send-email-armbru@redhat.com>
 <1488145424-14974-23-git-send-email-armbru@redhat.com>
In-Reply-To: <1488145424-14974-23-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/26/2017 03:43 PM, Markus Armbruster wrote:
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  tests/test-qobject-input-visitor.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/tests/test-qobject-input-visitor.c b/tests/test-qobject-in=
put-visitor.c
> index 10c15c4..6e04736 100644
> --- a/tests/test-qobject-input-visitor.c
> +++ b/tests/test-qobject-input-visitor.c
> @@ -894,7 +894,7 @@ static void test_visitor_in_fail_struct_missing(Tes=
tInputVisitorData *data,
>      char *str;
>      double dbl;
> =20
> -    v =3D visitor_input_test_init(data, "{}");
> +    v =3D visitor_input_test_init(data, "{ 'sub': [ {} ] }");
>      visit_start_struct(v, NULL, NULL, 0, &error_abort);
>      visit_start_struct(v, "struct", NULL, 0, &err);
>      error_free_or_abort(&err);
> @@ -920,6 +920,11 @@ static void test_visitor_in_fail_struct_missing(Te=
stInputVisitorData *data,
>      error_free_or_abort(&err);
>      visit_type_null(v, "null", &err);
>      error_free_or_abort(&err);
> +    visit_start_list(v, "sub", NULL, 0, &error_abort);
> +    visit_start_struct(v, NULL, NULL, 0, &error_abort);
> +    visit_type_int(v, "i64", &i64, &err);
> +    error_free_or_abort(&err);
> +    visit_end_struct(v, NULL);
>      visit_end_struct(v, NULL);

Missing a visit_end_list, no?

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--wj4tnifjst128XP2NMG9T2b38qlfr7fbC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYtZ6NAAoJEKeha0olJ0NqCk8H/A/JT5tr1riofyhTi0ISMf7J
QK/ngbPAwTFXdoKTjkLdHBh4VDQuFNTotAybnL4GZFOwyvmid+Bj+9h/I8Wdl/74
+9m9R9UX951oJs+AUxw2VQ1FwpLURN2Q8EgK9PxJhqNnifnAdAJvFqg4vXdN9iza
maCgj7vua/qrEic1BVdAgwunZLCn1FEIrabJyDGVl30BqvEffZkM5cgCXwz3mAgD
Hy4WEO8BzzjQlGhIh2g+hzEB5Osl4v6in/HlglD6AQnqk53mKJR3MPGcMvklenif
do3oGWsJ6GXgAXjLhZg+nFGUIRNJGuvhBGfNvf0YCU1P6BQPXJKQUG5bE5tiDLo=
=xZ0v
-----END PGP SIGNATURE-----

--wj4tnifjst128XP2NMG9T2b38qlfr7fbC--
