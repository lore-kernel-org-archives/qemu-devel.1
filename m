Received: from eggs.gnu.org ([2001:4830:134:3::10]:43124)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dz2o4-0001x6-I7
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 11:38:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dz2o3-00085C-FY
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 11:38:56 -0400
References: <20171002143919.207741-1-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <628fc0f2-55d2-5b9a-acf9-b38fdeb13b9f@redhat.com>
Date: Mon, 2 Oct 2017 10:38:39 -0500
MIME-Version: 1.0
In-Reply-To: <20171002143919.207741-1-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ApUGc2iVdRfVpRIukF2UagiSjqXrDT1FV"
Subject: Re: [Qemu-devel] [PATCH 0/5] backup improvements part 1
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, jcody@redhat.com, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org, jsnow@redhat.com
List-ID: <qemu-devel.nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ApUGc2iVdRfVpRIukF2UagiSjqXrDT1FV
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, jcody@redhat.com, mreitz@redhat.com,
 stefanha@redhat.com, den@openvz.org, jsnow@redhat.com
Message-ID: <628fc0f2-55d2-5b9a-acf9-b38fdeb13b9f@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/5] backup improvements part 1
References: <20171002143919.207741-1-vsementsov@virtuozzo.com>
In-Reply-To: <20171002143919.207741-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/02/2017 09:39 AM, Vladimir Sementsov-Ogievskiy wrote:
> Hi all. Here is a continuation of my "new backup architecture" series,
> The very first part, but it is meaningful itself.
>=20
> 01: was previously sent in other my series, but here is more correct
>     version, one mistake is fixed.
> 02: only rebased to new byte-based interfaces (by Eric), r-bs saved

Presumably, that means we need to tell patchew:

Based-on:
https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg06848.html
[PATCH v10 00/20] make dirty-bitmap byte-based

> 03: changed to use hbitmap_next_zero, also a comment added to
>     none-mode (Fam)
> 04: commit message rewritten. The patch was controversial, but I need
>     it for further backup enhancement, so, let's continue the
>     discussion.
> 05: rebased, logic is not changed, r-bs saved
>=20
>=20
> Vladimir Sementsov-Ogievskiy (5):
>   hbitmap: add next_zero function
>   backup: move from done_bitmap to copy_bitmap
>   backup: init copy_bitmap from sync_bitmap for incremental
>   backup: simplify non-dirty bits progress processing
>   backup: use copy_bitmap in incremental backup
>=20
>  include/block/dirty-bitmap.h |   1 +
>  include/qemu/hbitmap.h       |   8 +++
>  block/backup.c               | 117 ++++++++++++++++++++++++-----------=
--------
>  block/dirty-bitmap.c         |   5 ++
>  util/hbitmap.c               |  29 +++++++++++
>  5 files changed, 108 insertions(+), 52 deletions(-)
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--ApUGc2iVdRfVpRIukF2UagiSjqXrDT1FV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnSXX8ACgkQp6FrSiUn
Q2p86Qf/VDPt3C4h5c8luh0cgJzG/ijpoL4NXddIPHKrHFLAZs/ZTQAkW0RRYfNd
11HcXmuKfy9gqXqCk3EHMBydOMAqnTBuHn/Pt20m2KYfzKZ0yYaeHdK3kj4aKIyJ
W1p0Olu6CEIr0QCZn4zP5uBKBsdNx2J7BDEtZZYeXmdQREOKoV8tdcixmTW4f9hH
aEHMuBqM0EMgLWs1cu1lpYKfK1ZnZwDnnruPgn6IuHjgzL/uVh0m7ZFdxrWyXXYc
mf7YevEe5tG9baQ96r97YKq2TJLe9T8MwEfWBpyHc9280P+DhQLNiBV/F2L22n4j
xPtWuPpZ4mfr+etOAstz1yLLBV4pwg==
=AYJa
-----END PGP SIGNATURE-----

--ApUGc2iVdRfVpRIukF2UagiSjqXrDT1FV--
