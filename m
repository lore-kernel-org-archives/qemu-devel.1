Received: from eggs.gnu.org ([2001:4830:134:3::10]:52703)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cdjRd-0001j1-GO
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 15:11:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cdjRY-0008Cu-KV
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 15:11:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52266)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cdjRY-0008Cd-BN
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 15:11:20 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 90472624B9
	for <qemu-devel@nongnu.org>; Tue, 14 Feb 2017 20:11:20 +0000 (UTC)
References: <1487067971-10443-1-git-send-email-armbru@redhat.com>
	<1487067971-10443-4-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e69a2b9a-2e81-a4f0-11ce-1eaecf68e469@redhat.com>
Date: Tue, 14 Feb 2017 14:11:18 -0600
MIME-Version: 1.0
In-Reply-To: <1487067971-10443-4-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="To3IppL8VscXGaTFJ9AVB7QIdSdgb2SXQ"
Subject: Re: [Qemu-devel] [PATCH 03/24] tests/test-cutils: Add missing
 qemu_strtol()... endptr checks
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
--To3IppL8VscXGaTFJ9AVB7QIdSdgb2SXQ
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Message-ID: <e69a2b9a-2e81-a4f0-11ce-1eaecf68e469@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 03/24] tests/test-cutils: Add missing
 qemu_strtol()... endptr checks
References: <1487067971-10443-1-git-send-email-armbru@redhat.com>
 <1487067971-10443-4-git-send-email-armbru@redhat.com>
In-Reply-To: <1487067971-10443-4-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/14/2017 04:25 AM, Markus Armbruster wrote:
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  tests/test-cutils.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>=20
> diff --git a/tests/test-cutils.c b/tests/test-cutils.c
> index 20b0f59..71681dc 100644
> --- a/tests/test-cutils.c
> +++ b/tests/test-cutils.c
> @@ -262,6 +262,7 @@ static void test_qemu_strtol_empty(void)
>      err =3D qemu_strtol(str, &endptr, 0, &res);
> =20
>      g_assert_cmpint(err, =3D=3D, -EINVAL);
> +    g_assert(endptr =3D=3D str);
>  }

In other words, enforce more of our contract that even on errors, endptr
is set to a documented value.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--To3IppL8VscXGaTFJ9AVB7QIdSdgb2SXQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYo2RmAAoJEKeha0olJ0NqPGIIAIICEp391DHENA4FVH4wXHjA
sJVHUIdsb07YogxRYvkn1504Aly/B5kUmS/C6j7i7vIiLGP+86UcrzjSD7xYy7kN
BE83MwkKWvOOhVn1YKIsqxkdkWlKGbLT/3NpjNYcfeDNdQZfqZQxyzimOH9Dc9EG
atadsmpQLhzrEJOB4h1tiVbRhrdvllYAfFWK0lUJGyVO8rc1XwGk04+R/4WBS7D8
+CWRFLTkCfihIW1DrBpfa2IRFfnSJZyImjcqUi0OLBpuIIbtdg/C3gQqJN5b4bYz
DAPe385k72nwveV79CJQ+5BHaW5prF9agRQLgbtzrlh/+Lzw89zsWJrp19QpcS0=
=ax3s
-----END PGP SIGNATURE-----

--To3IppL8VscXGaTFJ9AVB7QIdSdgb2SXQ--
