Received: from eggs.gnu.org ([2001:4830:134:3::10]:43547)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eoQue-0002y5-VS
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 04:42:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eoQua-0007Jb-9J
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 04:42:09 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20180220222459.8461-2-eblake@redhat.com>
References: <20180220222459.8461-1-eblake@redhat.com>
	<20180220222459.8461-2-eblake@redhat.com>
Date: Wed, 21 Feb 2018 10:42:00 +0100
Message-ID: <w51woz6k7br.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 1/2] qcow2: Prefer byte-based calls into
 bs->file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, mreitz@redhat.com, Kevin Wolf <kwolf@redhat.com>

On Tue 20 Feb 2018 11:24:58 PM CET, Eric Blake wrote:
> diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
> index d46b69d7f34..3fefeb3dc50 100644
> --- a/block/qcow2-refcount.c
> +++ b/block/qcow2-refcount.c
> @@ -2310,8 +2310,8 @@ write_refblocks:
>          on_disk_refblock = (void *)((char *) *refcount_table +
>                                      refblock_index * s->cluster_size);
>
> -        ret = bdrv_write(bs->file, refblock_offset / BDRV_SECTOR_SIZE,
> -                         on_disk_refblock, s->cluster_sectors);
> +        ret = bdrv_pwrite(bs->file, refblock_offset,
> +                         on_disk_refblock, s->cluster_size);

It looks like the second line is not properly indented. I think you can
also move on_disk_refblock to the previous line.

Otherwise the patch looks good.

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
