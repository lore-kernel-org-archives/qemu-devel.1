Received: from eggs.gnu.org ([2001:4830:134:3::10]:33670)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dug64-00060L-Gd
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 10:35:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dug60-0004xZ-L2
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 10:35:28 -0400
Date: Wed, 20 Sep 2017 17:35:12 +0300
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Message-ID: <20170920143512.cfup2svar5uf4vdw@postretch>
References: <20170920114310.13080-1-el13635@mail.ntua.gr>
	<20170920114310.13080-2-el13635@mail.ntua.gr>
	<20170920122421.GD4730@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yectdcsawkfkpogx"
Content-Disposition: inline
In-Reply-To: <20170920122421.GD4730@localhost.localdomain>
Subject: Re: [Qemu-devel] [PATCH 1/2] block/block-backend.c: add
 blk_check_byte_request call to blk_pread/blk_pwrite
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-block <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>


--yectdcsawkfkpogx
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline

On Wed, Sep 20, 2017 at 02:24:21PM +0200, Kevin Wolf wrote:
>Am 20.09.2017 um 13:43 hat Manos Pitsidianakis geschrieben:
>> blk_check_byte_request() is called from the blk_co_pwritev/blk_co_preadv to
>> check if the request offset and request bytes parameters are valid for the
>> given Blockbackend. Let's do that in blk_pread/blk_pwrite too.
>>
>> Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
>
>I don't think this is necessary, blk_pread/pwrite() are only wrappers
>around blk_co_preadv/pwritev(), so we're already checking the
>parameters.
>
>Kevin


Alright, this can be dropped then. Thanks!

--yectdcsawkfkpogx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEvy2VxhCrsoeMN1aIc2J8L2kN9xAFAlnCfKAACgkQc2J8L2kN
9xAQZA//XfkseAseMMeD/qDwJ7ASpdgaLYr5TQp5CgDugpwiO3DKNqoWf3xtmKHS
9IRqLYwiKENECh4CK4quoaIOydUuEh7QkJhU/WhdHFbc0cwHk6a1B+20ReY4NIqS
Uz4baayJMA0f3X4pfQHyqLjqNeHxa7fmOj1uSYX477D9JdtXz3mDU0YhvX2ExL+K
9dTtl4gVsLPKKNTswCbO2atd4V3lQTDwoljzEpTkWEvJXtK1cy8gqLyeF6Ya7QeK
dq4yiZHWtwNHtSPM+hEw/xqwvqLvrEkLVFbfa049TXJQNdoXoJk7XdqLuJBD+JzK
RuElIOilu88jPfhMTTW3MWhEl7U+sgQCUtBOFrWOV9JPLiYRKo2YGISYNhHHA5Ab
tMr5dTwVtSFkEl8hl31xCE0Dfj0VklQFqax47h0XLbtc8W7yxKzEQciYsWke59By
C8wgs9mS/eWURODGezoU8Ve63oI3jelRYB0c5hgxpbadJIbKjWHzZDsWwsWozsad
eU4r9bilUwSEnqKP0RBQCawRI5Jlv94YhGGgvop1qEbWXmfrY9QMnp2vdJbWmmZm
i7gMptwwmacA/SHB0LzLH3itK6ZyUZeQj7UYQuxfJyMy3kdZTvjik2rLd7sgoo+K
CFBipiJy+cXVOxmtSY1AHI29xWYHQG2Ez33pgZjjwegA4Vz0rZM=
=LZ+H
-----END PGP SIGNATURE-----

--yectdcsawkfkpogx--
