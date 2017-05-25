Received: from eggs.gnu.org ([2001:4830:134:3::10]:45379)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dDx4o-0000Ly-0p
	for qemu-devel@nongnu.org; Thu, 25 May 2017 14:01:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dDx4n-0001zs-Ak
	for qemu-devel@nongnu.org; Thu, 25 May 2017 14:01:34 -0400
References: <20170525152628.37628-1-vsementsov@virtuozzo.com>
	<20170525152628.37628-8-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6c879ccc-5e73-726c-b87a-7da358d4c777@redhat.com>
Date: Thu, 25 May 2017 13:01:25 -0500
MIME-Version: 1.0
In-Reply-To: <20170525152628.37628-8-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="oBQs6HwcBKSwGT36W0oG70ud72I5xHkVm"
Subject: Re: [Qemu-devel] [PATCH 7/7] block: rename
 _get_allocated_file_size() to _get_fs_allocated_size()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--oBQs6HwcBKSwGT36W0oG70ud72I5xHkVm
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org
Message-ID: <6c879ccc-5e73-726c-b87a-7da358d4c777@redhat.com>
Subject: Re: [PATCH 7/7] block: rename _get_allocated_file_size() to
 _get_fs_allocated_size()
References: <20170525152628.37628-1-vsementsov@virtuozzo.com>
 <20170525152628.37628-8-vsementsov@virtuozzo.com>
In-Reply-To: <20170525152628.37628-8-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/25/2017 10:26 AM, Vladimir Sementsov-Ogievskiy wrote:
> To be in contrast with _get_format_allocated_size()
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block.c                   |  8 ++++----
>  block/file-posix.c        | 14 +++++---------
>  block/file-win32.c        |  8 +++-----
>  block/gluster.c           |  8 ++++----
>  block/nfs.c               |  8 ++++----
>  block/qapi.c              |  2 +-
>  block/sheepdog.c          |  8 ++++----
>  block/vmdk.c              |  8 ++++----
>  include/block/block.h     |  2 +-
>  include/block/block_int.h |  2 +-
>  10 files changed, 31 insertions(+), 37 deletions(-)

Bikeshedding: is 'protocol' a better name than 'fs'? Unfortunately, it's
longer.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--oBQs6HwcBKSwGT36W0oG70ud72I5xHkVm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZJxv1AAoJEKeha0olJ0NqL6QH+wdgHugXFl2M8UEE72V7VEOQ
IcLNLwzqiO8baSuAYIhpEfXZipSSd2aLdvNOOwYjP2zE+MVXNn3DjcKFhAxQVsQE
0WZyGNx2Br6hEz1w9DpoychWWmMGRl82io0wn2msfqp5vHozpQQ/5dPB/6h6PAwp
LTA/PPuC7t8+ugfo8Ht41JEiZvEEzCLwEZiCFekyCS8P24COdHk3kafd21VJQUcU
2d+K/wEdMCOB2PuS8P9HeuC26Amu2YnNY6/Jh76jlZs8vw2fqrmzQWoRQjtMa+p3
uOlIIaw0gorJKCbqejXWOK4LhaB9IMAzp+3rzCS7wniMLLZMQtpWfqTQD1ekSh4=
=BDIv
-----END PGP SIGNATURE-----

--oBQs6HwcBKSwGT36W0oG70ud72I5xHkVm--
