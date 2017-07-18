Received: from eggs.gnu.org ([2001:4830:134:3::10]:60264)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dXPHY-0000jU-7m
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 05:59:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dXPHV-0000LT-5E
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 05:59:08 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170718061005.29518-7-f4bug@amsat.org> ("Philippe
	=?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Tue,
	18 Jul 2017 03:09:42 -0300")
References: <20170718061005.29518-1-f4bug@amsat.org>
	<20170718061005.29518-7-f4bug@amsat.org>
Reply-To: quintela@redhat.com
Date: Tue, 18 Jul 2017 11:58:47 +0200
Message-ID: <87bmoiysko.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 06/29] migration/block: use QEMU_IS_ALIGNED
 macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: qemu-trivial@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>

Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrote:
> Applied using the Coccinelle semantic patch scripts/coccinelle/use_osdep.=
cocci
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  migration/block.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/migration/block.c b/migration/block.c
> index 9171f60028..498c72ad59 100644
> --- a/migration/block.c
> +++ b/migration/block.c
> @@ -933,7 +933,7 @@ static int block_load(QEMUFile *f, void *opaque, int =
version_id)
>                  ret =3D bdrv_get_info(blk_bs(blk), &bdi);
>                  if (ret =3D=3D 0 && bdi.cluster_size > 0 &&
>                      bdi.cluster_size <=3D BLOCK_SIZE &&
> -                    BLOCK_SIZE % bdi.cluster_size =3D=3D 0) {
> +                    QEMU_IS_ALIGNED(BLOCK_SIZE, bdi.cluster_size)) {
>                      cluster_size =3D bdi.cluster_size;
>                  } else {
>                      cluster_size =3D BLOCK_SIZE;

Reviewed-by: Juan Quintela <quintela@redhat.com>

Should I take this patch, or does it go through the block layer?  Your
call.

Later, Juan.
