Received: from eggs.gnu.org ([2001:4830:134:3::10]:57374)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fpEtx-0002xC-CR
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 11:37:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fpEtw-0000ZL-Iz
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 11:37:01 -0400
References: <20180809114417.28718-1-marcandre.lureau@redhat.com>
	<20180809114417.28718-3-marcandre.lureau@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <a7f2ed18-2e31-00a3-e68f-7b21c18361ee@redhat.com>
Date: Mon, 13 Aug 2018 17:36:54 +0200
MIME-Version: 1.0
In-Reply-To: <20180809114417.28718-3-marcandre.lureau@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ZcBMgiUV0vl4Zvyc36Jy0fc9Z41AyI67I"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 2/4] tests: fix bdrv-drain leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: Hannes Reinecke <hare@suse.com>, Fam Zheng <famz@redhat.com>, qemu-block@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ZcBMgiUV0vl4Zvyc36Jy0fc9Z41AyI67I
From: Max Reitz <mreitz@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: Hannes Reinecke <hare@suse.com>, Fam Zheng <famz@redhat.com>,
 qemu-block@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a7f2ed18-2e31-00a3-e68f-7b21c18361ee@redhat.com>
Subject: Re: [Qemu-block] [PATCH 2/4] tests: fix bdrv-drain leak
References: <20180809114417.28718-1-marcandre.lureau@redhat.com>
 <20180809114417.28718-3-marcandre.lureau@redhat.com>
In-Reply-To: <20180809114417.28718-3-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-08-09 13:44, Marc-Andr=C3=A9 Lureau wrote:
> Spotted by ASAN:
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D5378=3D=3DERROR: LeakSanitizer: detected memory leaks
>=20
> Direct leak of 65536 byte(s) in 1 object(s) allocated from:
>     #0 0x7f788f83bc48 in malloc (/lib64/libasan.so.5+0xeec48)
>     #1 0x7f788c9923c5 in g_malloc (/lib64/libglib-2.0.so.0+0x523c5)
>     #2 0x5622a1fe37bc in coroutine_trampoline /home/elmarco/src/qq/util=
/coroutine-ucontext.c:116
>     #3 0x7f788a15d75f in __correctly_grouped_prefixwc (/lib64/libc.so.6=
+0x4c75f)
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  tests/test-bdrv-drain.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/tests/test-bdrv-drain.c b/tests/test-bdrv-drain.c
> index 17bb8508ae..abc8bbe6f0 100644
> --- a/tests/test-bdrv-drain.c
> +++ b/tests/test-bdrv-drain.c
> @@ -948,6 +948,7 @@ static void coroutine_fn test_co_delete_by_drain(vo=
id *opaque)
>      }
> =20
>      dbdd->done =3D true;
> +    g_free(buffer);
>  }
> =20
>  /**
>=20

Thanks, added a note of the commit that broke it to the commit message
and applied to my block branch:

https://git.xanclic.moe/XanClic/qemu/commits/branch/block

Max


--ZcBMgiUV0vl4Zvyc36Jy0fc9Z41AyI67I
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAltxpZYACgkQ9AfbAGHV
z0A6bwf/eowY3vYDCKgxKnuB9SKe78eeHYGZ/OZxML5hhZicg5dqVqg/gnWyQJ/Z
NBdVQ5SgAvUEoY6VFDhCSc1HqoLxJQprBkCiOqNPkGybRgtCgfMlBK1lBrftup/r
5pNWYdkWu/gwd0sWDyS0LqE8x9Y2dHCjLuw0wcEPji9zMqmPBfL0S9eRbP0+NDyk
LhPwcluyu18kIG/z8UBepqDZO23c4zUH2ixtfHcy0NiW7KzhFrcjpRlimpBVTs8r
Sk+wPKyTpIJ5B4s73dzlDRnViITs/QyBgpThxp051kIN8I25mJj6xTBhPFI21RU7
dZO+YrusBx/zQXcbTuaNqMPbFaSaBQ==
=sXCE
-----END PGP SIGNATURE-----

--ZcBMgiUV0vl4Zvyc36Jy0fc9Z41AyI67I--
