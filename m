Received: from eggs.gnu.org ([2001:4830:134:3::10]:58354)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dAZHR-0008GS-AN
	for qemu-devel@nongnu.org; Tue, 16 May 2017 06:00:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dAZHQ-00048C-En
	for qemu-devel@nongnu.org; Tue, 16 May 2017 06:00:37 -0400
References: <20170516094533.6160-1-vsementsov@virtuozzo.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f2465a29-a1d2-24de-b765-fe1106640144@redhat.com>
Date: Tue, 16 May 2017 12:00:21 +0200
MIME-Version: 1.0
In-Reply-To: <20170516094533.6160-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/5] nbd: error path refactoring
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, den@openvz.org



On 16/05/2017 11:45, Vladimir Sementsov-Ogievskiy wrote:
> Hi all. There are several patches, as preparation for v2 of my
> NBD BLOCK_STATUS series.
> 
> patch 0001 was sent earlier and unchanged here.

Thanks, applied.  I suppose that if we can remove
nbd_negotiate_read/write/drop it's also easy to change from LOG to
error_report_err in nbd/server.c.

Paolo

> Vladimir Sementsov-Ogievskiy (5):
>   nbd: strict nbd_wr_syncv
>   nbd: read_sync and friends: return 0 on success
>   nbd: add errp parameter to nbd_wr_syncv()
>   nbd: add errp to read_sync, write_sync and drop_sync
>   nbd/client.c: use errp instead of LOG
> 
>  block/nbd-client.c  |  11 +++--
>  include/block/nbd.h |   8 ++--
>  nbd/client.c        | 121 ++++++++++++++++++++++++----------------------------
>  nbd/common.c        |  23 +++++-----
>  nbd/nbd-internal.h  |  40 ++++++++++++++---
>  nbd/server.c        |  92 ++++++++++++++++-----------------------
>  qemu-nbd.c          |   3 +-
>  7 files changed, 153 insertions(+), 145 deletions(-)
> 
