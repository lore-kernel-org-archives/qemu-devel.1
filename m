Received: from eggs.gnu.org ([2001:4830:134:3::10]:58864)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dJLN8-0007at-6K
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 10:58:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dJLN4-00060r-DD
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 10:58:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42238)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dJLN4-0005zS-3e
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 10:58:42 -0400
References: <20170609133337.31183-1-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <650896fb-d42b-3ce7-8660-4c1275a5e360@redhat.com>
Date: Fri, 9 Jun 2017 09:58:37 -0500
MIME-Version: 1.0
In-Reply-To: <20170609133337.31183-1-marcandre.lureau@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="5EMn9u6hqm2txJAmB2FdrL3OukWpPXt09"
Subject: Re: [Qemu-devel] [PATCH] tests: check-qom-proplist: fix leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com, armbru@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5EMn9u6hqm2txJAmB2FdrL3OukWpPXt09
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com, armbru@redhat.com
Message-ID: <650896fb-d42b-3ce7-8660-4c1275a5e360@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] tests: check-qom-proplist: fix leak
References: <20170609133337.31183-1-marcandre.lureau@redhat.com>
In-Reply-To: <20170609133337.31183-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/09/2017 08:33 AM, Marc-Andr=C3=A9 Lureau wrote:
> user_creatable_add_opts() returns a reference (the other reference is
> for the root parent/child link).
>=20
> Leak introduced in commit a1af255f065cc.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  tests/check-qom-proplist.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/tests/check-qom-proplist.c b/tests/check-qom-proplist.c
> index 8e432e9ab6..a3cd7ab29f 100644
> --- a/tests/check-qom-proplist.c
> +++ b/tests/check-qom-proplist.c
> @@ -428,6 +428,8 @@ static void test_dummy_createcmdl(void)
>      g_assert(err =3D=3D NULL);
>      error_free(err);
> =20
> +    object_unref(OBJECT(dobj));

This should be spelled QDECREF(dobj);

(Hmm - maybe scripts/coccinelle/qobject.cocci should be taught this
cleanup pattern...)

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--5EMn9u6hqm2txJAmB2FdrL3OukWpPXt09
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZOredAAoJEKeha0olJ0NqyM0H/j8dwq00ixws6QZwghT8tsy7
dHACKrvEPX9m3cKrSI/u/Pt6c7xKBiKS069HyF3sV1IS5mgEnuNqupz1r+7E+ZRx
GjwFnbmjF2dWZ5GCle/Zt0xSYXebbDKTRAGaqMpukmdFw67JWJo20rtD1chF8WjS
cFmY+WwyjbNiqgDls3hd2dN5lDvge+sBbMo4iKWVPvPsCU1PylCeMpF0r7S2A3U2
zmRWNkfBqCqrDObII7O7r7EEndp9k1w/v8zI3y3GjcX3mUnXNR8e3aU+SppPYzL6
2KAogHSwCJUmXC/GETkP19IAD8HJlWmCpmAeWzhQD/YoBBhbhw52MBSHYS1FnGw=
=5Q/J
-----END PGP SIGNATURE-----

--5EMn9u6hqm2txJAmB2FdrL3OukWpPXt09--
