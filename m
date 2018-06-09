Received: from eggs.gnu.org ([2001:4830:134:3::10]:60586)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fRf2e-0003y7-Qz
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 10:40:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fRf2b-0004cS-P2
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 10:40:32 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:47092)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fRf2b-0004cF-FL
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 10:40:29 -0400
Received: by mail-qt0-x242.google.com with SMTP id h5-v6so16307606qtm.13
	for <qemu-devel@nongnu.org>; Sat, 09 Jun 2018 07:40:29 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1528530764-21376-1-git-send-email-dimastep@yandex-team.ru>
	<1528530764-21376-3-git-send-email-dimastep@yandex-team.ru>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <6880e2ba-f44f-4612-4450-406bed44a791@amsat.org>
Date: Sat, 9 Jun 2018 11:40:22 -0300
MIME-Version: 1.0
In-Reply-To: <1528530764-21376-3-git-send-email-dimastep@yandex-team.ru>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="1loXJ6SkxWD0ZxMspnysZxRX2OVXIwuo9"
Subject: Re: [Qemu-devel] [PATCH v1 2/3] qcow2: fix the uninitialized
 bitmap_table variable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dima Stepanov <dimastep@yandex-team.ru>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, wrfsh@yandex-team.ru

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1loXJ6SkxWD0ZxMspnysZxRX2OVXIwuo9
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: Dima Stepanov <dimastep@yandex-team.ru>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, wrfsh@yandex-team.ru
Message-ID: <6880e2ba-f44f-4612-4450-406bed44a791@amsat.org>
Subject: Re: [Qemu-devel] [PATCH v1 2/3] qcow2: fix the uninitialized
 bitmap_table variable
References: <1528530764-21376-1-git-send-email-dimastep@yandex-team.ru>
 <1528530764-21376-3-git-send-email-dimastep@yandex-team.ru>
In-Reply-To: <1528530764-21376-3-git-send-email-dimastep@yandex-team.ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Dima,

On 06/09/2018 04:52 AM, Dima Stepanov wrote:
> The free_bitmap_clusters() routine is using the bitmap_table_load() cal=
l
> to initialize the local bitmap_table variable. bitmap_table_load()
> doesn't initialize variable to NULL in case of error. As a result a
> following assert will be hit:
>   assert(bitmap_table =3D=3D NULL);
>=20
> Remove this assert, since the next instruction is return from routine.

Paolo suggested a different fix, see:

https://patchwork.kernel.org/patch/9860017/

>=20
> Signed-off-by: Dima Stepanov <dimastep@yandex-team.ru>
> ---
>  block/qcow2-bitmap.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
> index 60d5290..69485aa 100644
> --- a/block/qcow2-bitmap.c
> +++ b/block/qcow2-bitmap.c
> @@ -254,7 +254,6 @@ static int free_bitmap_clusters(BlockDriverState *b=
s, Qcow2BitmapTable *tb)
> =20
>      ret =3D bitmap_table_load(bs, tb, &bitmap_table);
>      if (ret < 0) {
> -        assert(bitmap_table =3D=3D NULL);
>          return ret;
>      }
> =20
>=20


--1loXJ6SkxWD0ZxMspnysZxRX2OVXIwuo9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+qvnXhKRciHc/Wuy4+MsLN6twN4FAlsb5tYACgkQ4+MsLN6t
wN6hpBAAkMjwsbrpzVJyNtSTLvKC7F1hYszuoCKKEvND0k9pegJCEc0v4nKeb8o+
NBNi8kQYSC0j/48VnNRnLICYQuYpo8HafSD1BqIvAhy0SzHJOOUk4RaX5yHOdpRE
tNqnHDoy3eXvTKT3CNLjcpIlWJ2bWdOssQ/je8az8qIfLKUS5xXGODqmN94WzFWt
cZOFrkvpy6umKDJC+iAvpLg12AnTPIuj72ZSf5gqUYXmgqctcTBYFDCCIogKvFA4
s6dRQIGxkm4mu6JgJVAbSRe+FKmcjcGYQee3r6uEl3jZzrJ7bY/3bE53ypPW1nB/
beNvzfr0TIwkgUtmqXWR1GpqDVv4gECLWp9aODDvLu+L/hxZZzIdp0K+2D/aC7Zd
t3BVVgpY9ZjSu1fHDHAKdhzOjuTExzoTCQQvr7ZkHMC2WrmgRMG8y8MTDlsQqD4t
YXPK5f8WylGmJcFuHtibkMftD/FEco3xxxe/9cF6WS0D32tMJK8rn4CYgRTkmKZt
bcudOvD/VRBjkiaL2nFzw4KwI/BTjdocbm7t8AF3B9tL2Oqfdg43Ok0+Aae3v3EH
FWhLa8IsrpQ0LIMZvtlYx1m8/FlwX4rO1UBmIpaFsopUdqeuWpfL48PciUild/RZ
FFRJ4h6Vx73BEsjAVXQvOGDANL0tpOzKP2SvT3GRou80BCs9ryo=
=ZgBF
-----END PGP SIGNATURE-----

--1loXJ6SkxWD0ZxMspnysZxRX2OVXIwuo9--
