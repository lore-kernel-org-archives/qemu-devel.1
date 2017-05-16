Received: from eggs.gnu.org ([2001:4830:134:3::10]:56176)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dAcMH-0007rk-T7
	for qemu-devel@nongnu.org; Tue, 16 May 2017 09:17:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dAcME-0004Cj-Pc
	for qemu-devel@nongnu.org; Tue, 16 May 2017 09:17:49 -0400
Date: Tue, 16 May 2017 15:17:16 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170516131716.GC4438@noname.redhat.com>
References: <20170515203114.9477-1-hpoussin@reactos.org>
	<20170515203114.9477-2-hpoussin@reactos.org>
	<77e136d2-34f0-87db-914c-84d3990269b9@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="f2QGlHpHGjS2mn6Y"
Content-Disposition: inline
In-Reply-To: <77e136d2-34f0-87db-914c-84d3990269b9@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 01/13] vvfat: fix qemu-img map
 and qemu-img convert
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>, qemu-devel@nongnu.org, qemu-stable <qemu-stable@nongnu.org>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>


--f2QGlHpHGjS2mn6Y
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 15.05.2017 um 22:42 hat Eric Blake geschrieben:
> On 05/15/2017 03:31 PM, Herv=E9 Poussineau wrote:
> > - bs->total_sectors is the number of sectors of the whole disk
> > - s->sector_count is the number of sectors of the FAT partition

I wonder if we should rename s->sector_count into something like
s->part_sectors that makes this difference clearer.

> > This fixes the following assert in qemu-img map:
> > qemu-img.c:2641: get_block_status: Assertion `nb_sectors' failed.
> >=20
> > This also fixes an infinite loop in qemu-img convert.
> >=20
> > Fixes: 4480e0f924a42e1db8b8cfcac4d0634dd1bb27a0
>=20
> Wow - broken since 1.2? Not many vvfat users, are there.

Probably vvfat and bdrv_get_block_status() aren't used much together.
When I use vvfat, it's simple read/write from a guest usually and no
complicated operations like block jobs that would look at the block
status.

> Herv=E9, you might want to work out with Kevin whether to take
> co-maintainership over vvfat, in addition to your other areas.

I don't mind either way. If Herv=E9 is planning to spend more on time on
vvfat, it could make sense.

Kevin

--f2QGlHpHGjS2mn6Y
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJZGvvcAAoJEH8JsnLIjy/W71UQAMhOzr0zqqqEN7M3mDsMPQ0t
1ums4zr6+9CuKLIOJOUQVltuiis6lnR91eBRdNcZnMsy04Ba8lAk/NmV8c0pHu6E
Eu57rvF8L0gsMQlJlAueTmbByEGSs9i8ZXsDZfahOktDkg2bjrmPacQsbIp1dDao
Acoa7A2y/XBorEaY0qgZA0f/uJyb1gRbtT4KerrmRn3Tbo/94Zc2W1A6pT8kO1nK
Qni6v+IwG/+VHWSkN9Hu+B29CGT07Sijk0TaGnIgeh6HXFDrpYsKVZYa5cFMMOww
eVHGaSe38Z5F0hqoSEGqmbVScH8oSZ9r86jj+fbzhUxoNJk0a+ZjCYma7ae5n3VN
i38ru/+21C5z9jx5sVnwO4RBwMwkpIjkcdFJrr3k8jSs1YTCCVAy78LKWTT2z05Q
IplT0YBzbCiLCsuKjpq6EZE7twX+pDrJnxzNaSDGakq3oDbw83dNhVkLVmZt10nx
nibbh29+fgbSbcPIBEwHZVhCCCk0clUaBE4VyA9fB1+KTswjFy90e1STAx1zOfGU
wAai/Q9Lv/zqJDRjtNW07JtMdMrK6SyTEpJPDkX2jItFbfR/Fy1Va7wDhvkWY6e5
5ywlrDeNlX26KWRXH35Sad28nK1MkCY+09cZhJSm5tVjjVDOImi5rE1BRQK6KdJd
fYOdi+GBA/i7LvHFO+Oq
=RebR
-----END PGP SIGNATURE-----

--f2QGlHpHGjS2mn6Y--
