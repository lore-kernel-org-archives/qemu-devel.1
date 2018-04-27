Received: from eggs.gnu.org ([2001:4830:134:3::10]:35869)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fC3wj-0008R6-8N
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 10:02:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fC3we-000513-Lj
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 10:01:57 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20180426134305.642080-4-eblake@redhat.com>
References: <20180426134305.642080-1-eblake@redhat.com>
	<20180426134305.642080-4-eblake@redhat.com>
Date: Fri, 27 Apr 2018 16:01:51 +0200
Message-ID: <w5136zgbve8.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 3/3] block: Removed unused
 sector-based blocking I/O
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On Thu 26 Apr 2018 03:43:05 PM CEST, Eric Blake wrote:
> We are gradually moving away from sector-based interfaces, towards
> byte-based.  Now that all callers of blocking I/O have been converted
> to use our preferred byte-based bdrv_p{read,write}(), we can
> delete the unused bdrv_{read,write}().
>
> Signed-off-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

> -static int bdrv_rw_co(BdrvChild *child, int64_t sector_num, uint8_t *buf,
> -                      int nb_sectors, bool is_write, BdrvRequestFlags flags)
> -{
> -    QEMUIOVector qiov;
> -    struct iovec iov = {
> -        .iov_base = (void *)buf,
> -        .iov_len = nb_sectors * BDRV_SECTOR_SIZE,
> -    };
> -
> -    if (nb_sectors < 0 || nb_sectors > BDRV_REQUEST_MAX_SECTORS) {
> -        return -EINVAL;
> -    }

Do we have a check for BDRV_REQUEST_MAX_BYTES in the byte-based API?

Berto
