Received: from eggs.gnu.org ([2001:4830:134:3::10]:44293)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dHxqR-000636-Kn
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 15:39:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dHxqQ-0002PN-EB
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 15:39:19 -0400
References: <20170511022036.32225-1-eblake@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1037fc82-c0f3-859b-0702-74bdd845720f@redhat.com>
Date: Mon, 5 Jun 2017 14:39:08 -0500
MIME-Version: 1.0
In-Reply-To: <20170511022036.32225-1-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="MV1kj0qlj1KKHjhHXLwRGVwF4BaTa58ui"
Subject: Re: [Qemu-devel] [PATCH v2 00/20] make bdrv_is_allocated[_above]
 byte-based
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MV1kj0qlj1KKHjhHXLwRGVwF4BaTa58ui
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com, qemu-block@nongnu.org
Message-ID: <1037fc82-c0f3-859b-0702-74bdd845720f@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 00/20] make bdrv_is_allocated[_above]
 byte-based
References: <20170511022036.32225-1-eblake@redhat.com>
In-Reply-To: <20170511022036.32225-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

ping

On 05/10/2017 09:20 PM, Eric Blake wrote:
> There are patches floating around to add NBD_CMD_BLOCK_STATUS,
> but NBD wants to report status on byte granularity (even if the
> reporting will probably be naturally aligned to sectors or even
> much higher levels).  I've therefore started the task of
> converting our block status code to report at a byte granularity
> rather than sectors.
>=20
> This is part one of that conversion: bdrv_is_allocated().
> Other parts still need a v2, but here's the link to their v1:
> tracking dirty bitmaps by bytes:
> https://lists.gnu.org/archive/html/qemu-devel/2017-04/msg02163.html
> replacing bdrv_get_block_status() with a byte based callback
> in all the drivers:
> https://lists.gnu.org/archive/html/qemu-devel/2017-04/msg02642.html
>=20
> Available as a tag at:
> git fetch git://repo.or.cz/qemu/ericb.git nbd-byte-allocated-v2
>=20
> Since v1:
> - Add R-b from John as appropriate
> - Couple of new patches for cleanups he noticed
> - Rebase to Max's block branch
>=20
> 001/20:[----] [--] 'blockjob: Track job ratelimits via bytes, not secto=
rs'
> 002/20:[----] [--] 'trace: Show blockjob actions via bytes, not sectors=
'
> 003/20:[----] [--] 'stream: Switch stream_populate() to byte-based'
> 004/20:[----] [--] 'stream: Switch stream_run() to byte-based'
> 005/20:[----] [--] 'commit: Switch commit_populate() to byte-based'
> 006/20:[----] [--] 'commit: Switch commit_run() to byte-based'
> 007/20:[----] [--] 'mirror: Switch MirrorBlockJob to byte-based'
> 008/20:[----] [--] 'mirror: Switch mirror_do_zero_or_discard() to byte-=
based'
> 009/20:[down] 'mirror: Update signature of mirror_clip_sectors()'
> 010/20:[0013] [FC] 'mirror: Switch mirror_cow_align() to byte-based'
> 011/20:[----] [-C] 'mirror: Switch mirror_do_read() to byte-based'
> 012/20:[0014] [FC] 'mirror: Switch mirror_iteration() to byte-based'
> 013/20:[----] [--] 'block: Drop unused bdrv_round_sectors_to_clusters()=
'
> 014/20:[----] [--] 'backup: Switch BackupBlockJob to byte-based'
> 015/20:[0008] [FC] 'backup: Switch block_backup.h to byte-based'
> 016/20:[----] [--] 'backup: Switch backup_do_cow() to byte-based'
> 017/20:[----] [--] 'backup: Switch backup_run() to byte-based'
> 018/20:[0039] [FC] 'block: Make bdrv_is_allocated() byte-based'
> 019/20:[down] 'block: Minimize raw use of bds->total_sectors'
> 020/20:[0026] [FC] 'block: Make bdrv_is_allocated_above() byte-based'
>=20
> Eric Blake (20):
>   blockjob: Track job ratelimits via bytes, not sectors
>   trace: Show blockjob actions via bytes, not sectors
>   stream: Switch stream_populate() to byte-based
>   stream: Switch stream_run() to byte-based
>   commit: Switch commit_populate() to byte-based
>   commit: Switch commit_run() to byte-based
>   mirror: Switch MirrorBlockJob to byte-based
>   mirror: Switch mirror_do_zero_or_discard() to byte-based
>   mirror: Update signature of mirror_clip_sectors()
>   mirror: Switch mirror_cow_align() to byte-based
>   mirror: Switch mirror_do_read() to byte-based
>   mirror: Switch mirror_iteration() to byte-based
>   block: Drop unused bdrv_round_sectors_to_clusters()
>   backup: Switch BackupBlockJob to byte-based
>   backup: Switch block_backup.h to byte-based
>   backup: Switch backup_do_cow() to byte-based
>   backup: Switch backup_run() to byte-based
>   block: Make bdrv_is_allocated() byte-based
>   block: Minimize raw use of bds->total_sectors
>   block: Make bdrv_is_allocated_above() byte-based
>=20
>  include/block/block.h        |  10 +-
>  include/block/block_backup.h |  11 +-
>  include/qemu/ratelimit.h     |   3 +-
>  block/backup.c               | 130 ++++++++-----------
>  block/commit.c               |  54 ++++----
>  block/io.c                   |  92 +++++++------
>  block/mirror.c               | 300 ++++++++++++++++++++++-------------=
--------
>  block/replication.c          |  29 +++--
>  block/stream.c               |  35 +++--
>  block/vvfat.c                |  34 +++--
>  migration/block.c            |   9 +-
>  qemu-img.c                   |  15 ++-
>  qemu-io-cmds.c               |  70 +++++-----
>  block/trace-events           |  14 +-
>  14 files changed, 396 insertions(+), 410 deletions(-)
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--MV1kj0qlj1KKHjhHXLwRGVwF4BaTa58ui
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZNbNcAAoJEKeha0olJ0NqqmUH/ircA4WKH6K3B9sRgnHTYWsd
4BjcRRPO6GSx5RIibCNUVh1ok7nOZNyEO2DAJBalc9MvoGxJwN1H/dDxdWVSfqtG
BgNvpDpyPyOj/RhCaEVHSP4wahK3u83v2HeksHUSobi56f/6VR7AX/oJUAPjosAO
RadA+HaAgOjX5jw/BeiNUJenU2EWV1QS9e8VZFM6GhURLKqRo/DuYE/WOzjsxdkh
h18RevjHAAUNVgTZbQpQZG9/LyUwc5uyle3lRwfElMURJs8LTV+oKuhqQE6sh20X
TjXLEEa8c244Lzdkj7Pyh4F7E9UoIcI2Q8qoFN2qw+r8ZdgBlfMJy/W37kKjQ3k=
=Yykt
-----END PGP SIGNATURE-----

--MV1kj0qlj1KKHjhHXLwRGVwF4BaTa58ui--
