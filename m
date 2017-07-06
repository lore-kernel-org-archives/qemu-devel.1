Received: from eggs.gnu.org ([2001:4830:134:3::10]:53162)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dT4mO-0003KV-B1
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 07:17:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dT4mN-0004TS-Em
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 07:17:04 -0400
Date: Thu, 6 Jul 2017 13:16:54 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170706111654.GD5975@noname.redhat.com>
References: <20170705210842.960-1-eblake@redhat.com>
	<20170705210842.960-12-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170705210842.960-12-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 11/21] mirror: Switch mirror_cow_align()
 to byte-based
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, jsnow@redhat.com, jcody@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

Am 05.07.2017 um 23:08 hat Eric Blake geschrieben:
> We are gradually converting to byte-based interfaces, as they are
> easier to reason about than sector-based.  Convert another internal
> function (no semantic change), and add mirror_clip_bytes() as a
> counterpart to mirror_clip_sectors().  Some of the conversion is
> a bit tricky, requiring temporaries to convert between units; it
> will be cleared up in a following patch.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: John Snow <jsnow@redhat.com>
> Reviewed-by: Jeff Cody <jcody@redhat.com>

> -    if (align_nb_sectors > max_sectors) {
> -        align_nb_sectors = max_sectors;
> +    if (align_bytes > max_bytes) {
> +        align_bytes = max_bytes;
>          if (need_cow) {
> -            align_nb_sectors = QEMU_ALIGN_DOWN(align_nb_sectors,
> -                                               s->target_cluster_size >>
> -                                               BDRV_SECTOR_BITS);
> +            align_bytes = QEMU_ALIGN_DOWN(align_bytes,
> +                                          s->target_cluster_size);

This would fit in a single line, if you have to respin for some reason.

Reviewed-by: Kevin Wolf <kwolf@redhat.com>
