Received: from eggs.gnu.org ([2001:4830:134:3::10]:54658)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dZiTB-0003pz-B4
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 14:52:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dZiTA-0002Ox-Fl
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 14:52:41 -0400
References: <20170724182751.18261-1-f4bug@amsat.org>
	<20170724182751.18261-9-f4bug@amsat.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ce86e2e7-1d11-c115-c4f1-b4b6a4180972@redhat.com>
Date: Mon, 24 Jul 2017 13:52:23 -0500
MIME-Version: 1.0
In-Reply-To: <20170724182751.18261-9-f4bug@amsat.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="vaOkS4dOu0JjMtvf25vQHg40CVgccpfwU"
Subject: Re: [Qemu-devel] [PATCH for 2.10 08/35] qcow2: fix null pointer
 dereference
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vaOkS4dOu0JjMtvf25vQHg40CVgccpfwU
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, qemu-block@nongnu.org
Message-ID: <ce86e2e7-1d11-c115-c4f1-b4b6a4180972@redhat.com>
Subject: Re: [PATCH for 2.10 08/35] qcow2: fix null pointer dereference
References: <20170724182751.18261-1-f4bug@amsat.org>
 <20170724182751.18261-9-f4bug@amsat.org>
In-Reply-To: <20170724182751.18261-9-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/24/2017 01:27 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> It seems this assert() was somehow misplaced.
>=20
> block/qcow2-refcount.c:2193:42: warning: Array access (from variable 'o=
n_disk_reftable') results in a null pointer dereference
>         on_disk_reftable[refblock_index] =3D refblock_offset;
>         ~~~~~~~~~~~~~~~~                 ^
>=20
> Reported-by: Clang Static Analyzer
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  block/qcow2-refcount.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

>=20
> diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
> index c9b0dcb4f3..168fc32e7b 100644
> --- a/block/qcow2-refcount.c
> +++ b/block/qcow2-refcount.c
> @@ -2189,6 +2189,8 @@ write_refblocks:
>               * this will leak that range, but we can easily fix that b=
y running
>               * a leak-fixing check after this rebuild operation */
>              reftable_offset =3D -1;
> +        } else {
> +            assert(on_disk_reftable);
>          }
>          on_disk_reftable[refblock_index] =3D refblock_offset;
> =20
> @@ -2258,8 +2260,6 @@ write_refblocks:
>          goto write_refblocks;
>      }
> =20
> -    assert(on_disk_reftable);
> -
>      for (refblock_index =3D 0; refblock_index < reftable_size; refbloc=
k_index++) {
>          cpu_to_be64s(&on_disk_reftable[refblock_index]);
>      }
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--vaOkS4dOu0JjMtvf25vQHg40CVgccpfwU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAll2QecACgkQp6FrSiUn
Q2o56AgAm1hF8wJ6EKxP9LJLULiC7A1EpUybycWA1zEf5YmaTKaGLXydrM7BNU0w
+m0OrqHU/kHZV8gYFWPze8wBdmxVcktJsm89BEkUVqJ/5sAhM/JVaquXqfUOjWes
ZqJMMBoWshIAACdwSYgul9SuMxbkvzLyIMf9qZpXy/V78nSTZwJS9StSwWai5ZXE
B/2b7OWVzPOPh8XlS9W9nxs7FPQ1fg1Hdw57U9Emzg1zQwnabNUXl1bxpBP1h8Sc
W44GeL9hh2gynCODos/ImD+vQ/Y2vKsIWG4icF+EQjcrE1tM++avA4vaGwtJZLSx
5FLJgCMXz55DYeidk78x15K2Mp4KOg==
=26Ff
-----END PGP SIGNATURE-----

--vaOkS4dOu0JjMtvf25vQHg40CVgccpfwU--
