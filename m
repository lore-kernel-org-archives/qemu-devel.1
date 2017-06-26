Received: from eggs.gnu.org ([2001:4830:134:3::10]:42712)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dPWSk-0005dE-6K
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 12:02:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dPWSj-0008Bw-FC
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 12:02:06 -0400
Date: Mon, 26 Jun 2017 19:01:18 +0300
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Message-ID: <20170626160118.ig22l4rkswq7lfhy@postretch>
References: <20170623124700.1389-1-el13635@mail.ntua.gr>
	<20170623124700.1389-4-el13635@mail.ntua.gr>
	<20170626143055.GC29664@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4umyjnjwf7cyhbgr"
Content-Disposition: inline
In-Reply-To: <20170626143055.GC29664@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH RFC v3 3/8] block: add
 throttle block filter driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block <qemu-block@nongnu.org>, Alberto Garcia <berto@igalia.com>


--4umyjnjwf7cyhbgr
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 26, 2017 at 03:30:55PM +0100, Stefan Hajnoczi wrote:
>> +static BlockDriver bdrv_throttle =3D {
>> +    .format_name                        =3D   "throttle",
>> +    .protocol_name                      =3D   "throttle",
>> +    .instance_size                      =3D   sizeof(ThrottleGroupMembe=
r),
>> +
>> +    .bdrv_file_open                     =3D   throttle_open,
>> +    .bdrv_close                         =3D   throttle_close,
>> +    .bdrv_co_flush                      =3D   throttle_co_flush,
>> +
>> +    .bdrv_child_perm                    =3D   bdrv_filter_default_perms,
>> +
>> +    .bdrv_getlength                     =3D   throttle_getlength,
>> +
>> +    .bdrv_co_preadv                     =3D   throttle_co_preadv,
>> +    .bdrv_co_pwritev                    =3D   throttle_co_pwritev,
>> +
>> +    .bdrv_co_pwrite_zeroes              =3D   throttle_co_pwrite_zeroes,
>> +    .bdrv_co_pdiscard                   =3D   throttle_co_pdiscard,
>> +
>> +    .bdrv_recurse_is_first_non_filter   =3D   bdrv_recurse_is_first_non=
_filter,
>> +
>> +    .bdrv_attach_aio_context            =3D   throttle_attach_aio_conte=
xt,
>> +    .bdrv_detach_aio_context            =3D   throttle_detach_aio_conte=
xt,
>> +
>> +    .bdrv_reopen_prepare                =3D   throttle_reopen_prepare,
>> +    .bdrv_reopen_commit                 =3D   throttle_reopen_commit,
>> +    .bdrv_reopen_abort                  =3D   throttle_reopen_abort,
>> +
>> +    .is_filter                          =3D   true,
>> +};
>
>Missing:
>bdrv_co_get_block_status()
>bdrv_truncate()
>bdrv_get_info()
>bdrv_probe_blocksizes()
>bdrv_probe_geometry()
>bdrv_media_changed()
>bdrv_eject()
>bdrv_lock_medium()
>bdrv_co_ioctl()
>
>See block/raw-format.c.
>
>I think most of these could be modified in block.c or block/io.c to
>automatically call bs->file's function if drv doesn't implement them.
>This way all block drivers would transparently pass them through by
>default and block/raw-format.c code could be eliminated.

Are these truly necessary? Because other filter drivers (ie quorum,=20
blkverify) don't implement them.

--4umyjnjwf7cyhbgr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEvy2VxhCrsoeMN1aIc2J8L2kN9xAFAllRL84ACgkQc2J8L2kN
9xB4cg//ZBHl/MXqFEYX8x+CT/5IHbtvz4LgBiGxUBLlV4k+m0hS1R2xNO75kO4H
eY1OfSJCkDX8NpvABNDPpdUkq9L7FA9pACevZG5QG9t6lZvOU74FqAdwkAJEaS5B
qttOLJKT7knQiAcUZSYq0+beoPbMxQmEBaIhX27LuCvJ3m3iTG6myAaGN1XyYgbC
GOKSItXoWtQLghINNDqVAcI1prNqUHmhkol3ZvIPLICbX0SmXU4cfo0iicUx8hqt
QugaAc/3dLCsV2MQRyj3cxP9TCza3+6mQShI4u+fBpXjAMHFRHcCJrVWYNsuLknA
s1Ovm/C7lLswbnWk4FsoWGoYw81vnMoscRM9+lJA/cp8koHFRYdYMeyFCsC0EImS
MokvRFzZD07pfdGoyGqs7R/vCqDv56+0Ha1uBWCrfQlNYEuiKbQWhms+83/5EowF
jE2QGyxGG2qvi4fw4iLUvaQRmruP1z+Szw48SV3/w66w2lnVu3WSJmaiL62ZD/kN
eqSvXMZoL1qzDUHFdNoycEOgJetzOzHqYlN+FmcE7u0xIo7WPkkIYFjEu8FCNToh
7p0tE4ElJIlsqdgLjOZpalQ25izqSXgdOPeit4PiVlSVp0iaUBJzKPhSy/ds0OYO
xd5LuJWq3appjf9UF2MhiM8P5pTdyYRb90TX52yULmkBTloBxPo=
=VNiD
-----END PGP SIGNATURE-----

--4umyjnjwf7cyhbgr--
