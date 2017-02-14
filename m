Received: from eggs.gnu.org ([2001:4830:134:3::10]:38945)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cdm3n-0002Ls-Uv
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 17:59:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cdm3j-000378-2x
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 17:58:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56256)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cdm3i-00036q-QH
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 17:58:55 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C9F757E9FD
	for <qemu-devel@nongnu.org>; Tue, 14 Feb 2017 22:58:54 +0000 (UTC)
References: <1487067971-10443-1-git-send-email-armbru@redhat.com>
	<1487067971-10443-13-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <23df2b0c-a93d-a655-553f-53916f897a0b@redhat.com>
Date: Tue, 14 Feb 2017 16:58:52 -0600
MIME-Version: 1.0
In-Reply-To: <1487067971-10443-13-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="fa38SgO9vRAJ8Bp9cCKX85bMpgh0GDai1"
Subject: Re: [Qemu-devel] [PATCH 12/24] tests/test-cutils: Cover
 qemu_strtosz() with trailing crap
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
--fa38SgO9vRAJ8Bp9cCKX85bMpgh0GDai1
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Message-ID: <23df2b0c-a93d-a655-553f-53916f897a0b@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 12/24] tests/test-cutils: Cover
 qemu_strtosz() with trailing crap
References: <1487067971-10443-1-git-send-email-armbru@redhat.com>
 <1487067971-10443-13-git-send-email-armbru@redhat.com>
In-Reply-To: <1487067971-10443-13-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/14/2017 04:25 AM, Markus Armbruster wrote:
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  tests/test-cutils.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

> diff --git a/tests/test-cutils.c b/tests/test-cutils.c
> index 3dcd4c1..ec65d27 100644
> --- a/tests/test-cutils.c
> +++ b/tests/test-cutils.c
> @@ -1463,6 +1463,23 @@ static void test_qemu_strtosz_invalid(void)
>      g_assert(endptr =3D=3D str);
>  }
> =20
> +static void test_qemu_strtosz_trailing(void)
> +{
> +    const char *str;
> +    char *endptr =3D NULL;
> +    int64_t res;
> +
> +    str =3D "123xxx";
> +    res =3D qemu_strtosz(str, &endptr);
> +    g_assert_cmpint(res, =3D=3D, 123 * M_BYTE);
> +    g_assert(endptr =3D=3D str + 3);
> +
> +    str =3D "1kiB";

Personally, I think this one would be useful to support, but agree that
right now it should be handled as trailing garbage.

> +    res =3D qemu_strtosz(str, &endptr);
> +    g_assert_cmpint(res, =3D=3D, 1024);
> +    g_assert(endptr =3D=3D str + 2);
> +}
> +


--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--fa38SgO9vRAJ8Bp9cCKX85bMpgh0GDai1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYo4usAAoJEKeha0olJ0Nqae4H/A7+OF2P2ork6ozUPLzAoDnW
9mGPUlsCWd8HaCbo2MK/BJNzGC1N5TxhDR/5ljRAKBZNnJU0cEaauGd2Jx2KcOsS
2+dOoKqo8kCTGrsz7T+2kq9V95ff0NV6q9MNGfrd02LruuRGeBvYt5c1FmiQyDmE
7KSddWAlTi51mmd5l/bK9pvnMI6h6YYGXE4kdCbV5ZHswSdxpocEXUHXtHO6Acj3
qInabnbze3gnSMn64eHmYEonCl3tmLYDsV1n4j4VQ22+kQNl7iSGa7o+hwfziQvk
ukvDmRE6h0jN/DYqLoay496brwQI2XBNOsyc9iJV/7rIBia/htSWe78NO9Wf1vQ=
=fhJI
-----END PGP SIGNATURE-----

--fa38SgO9vRAJ8Bp9cCKX85bMpgh0GDai1--
