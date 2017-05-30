Received: from eggs.gnu.org ([2001:4830:134:3::10]:56514)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1dFgPh-0005H7-L7
	for qemu-devel@nongnu.org; Tue, 30 May 2017 08:38:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1dFgPe-0002Nq-H9
	for qemu-devel@nongnu.org; Tue, 30 May 2017 08:38:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33246)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1dFgPe-0002MB-BK
	for qemu-devel@nongnu.org; Tue, 30 May 2017 08:38:14 -0400
Date: Tue, 30 May 2017 08:38:08 -0400 (EDT)
From: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Message-ID: <2057521978.23705230.1496147888677.JavaMail.zimbra@redhat.com>
In-Reply-To: <20170530120919.8874-1-f4bug@amsat.org>
References: <149604983117.777.3318402617001973219@750cb16fd6f2>
	<20170530120919.8874-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] char: cast ARRAY_SIZE() as signed to
 silent warning on empty array
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org



----- Original Message -----
> chardev/char.c: In function 'chardev_name_foreach':
> chardev/char.c:546:19: error: comparison of unsigned expression < 0 is al=
ways
> false [-Werror=3Dtype-limits]
>      for (i =3D 0; i < ARRAY_SIZE(chardev_alias_table); i++) {
>                    ^
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  chardev/char.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/chardev/char.c b/chardev/char.c
> index 4e3808aefc..7aa0210765 100644
> --- a/chardev/char.c
> +++ b/chardev/char.c
> @@ -543,7 +543,7 @@ chardev_name_foreach(void (*fn)(const char *name, voi=
d
> *opaque), void *opaque)
> =20
>      object_class_foreach(chardev_class_foreach, TYPE_CHARDEV, false, &fe=
);
> =20
> -    for (i =3D 0; i < ARRAY_SIZE(chardev_alias_table); i++) {
> +    for (i =3D 0; i < (int)ARRAY_SIZE(chardev_alias_table); i++) {
>          fn(chardev_alias_table[i].alias, opaque);
>      }
>  }
> @@ -589,7 +589,7 @@ Chardev *qemu_chr_new_from_opts(QemuOpts *opts,
>          return NULL;
>      }
> =20
> -    for (i =3D 0; i < ARRAY_SIZE(chardev_alias_table); i++) {
> +    for (i =3D 0; i < (int)ARRAY_SIZE(chardev_alias_table); i++) {
>          if (g_strcmp0(chardev_alias_table[i].alias, name) =3D=3D 0) {
>              name =3D chardev_alias_table[i].typename;
>              break;
> --
> 2.11.0
>=20
>=20
