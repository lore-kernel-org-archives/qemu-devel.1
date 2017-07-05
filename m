Received: from eggs.gnu.org ([2001:4830:134:3::10]:33397)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1dShVi-0002WP-Jb
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 06:26:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1dShVh-0004Yi-IX
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 06:26:18 -0400
Date: Wed, 5 Jul 2017 06:26:05 -0400 (EDT)
From: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Message-ID: <1272552299.46884872.1499250365562.JavaMail.zimbra@redhat.com>
In-Reply-To: <20170705102231.20711-1-stefanha@redhat.com>
References: <20170705102231.20711-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/2] block: make .bdrv_create() a
 coroutine_fn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org



----- Original Message -----
> The BlockDriver->bdrv_create() function is always called from coroutine
> context.  These patches rename it and clean up qcow2 code that is current=
ly
> calling CoMutex functions outside coroutine_fn.
>=20
> Stefan Hajnoczi (2):
>   block: rename .bdrv_create() to .bdrv_co_create()
>   qcow2: make qcow2_co_create2() a coroutine_fn
>=20

I came to the same changes with my series, so
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

>  include/block/block_int.h |  3 ++-
>  block.c                   |  4 ++--
>  block/crypto.c            |  8 ++++----
>  block/file-posix.c        | 15 ++++++++-------
>  block/file-win32.c        |  3 ++-
>  block/gluster.c           | 12 ++++++------
>  block/iscsi.c             |  7 ++++---
>  block/nfs.c               |  5 +++--
>  block/parallels.c         |  6 ++++--
>  block/qcow.c              |  5 +++--
>  block/qcow2.c             | 22 ++++++++++++----------
>  block/qed.c               |  6 ++++--
>  block/raw-format.c        |  5 +++--
>  block/rbd.c               |  6 ++++--
>  block/sheepdog.c          | 10 +++++-----
>  block/ssh.c               |  5 +++--
>  block/vdi.c               |  5 +++--
>  block/vhdx.c              |  5 +++--
>  block/vmdk.c              |  5 +++--
>  block/vpc.c               |  5 +++--
>  20 files changed, 81 insertions(+), 61 deletions(-)
>=20
> --
> 2.9.4
>=20
>=20
