Received: from eggs.gnu.org ([2001:4830:134:3::10]:36049)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dwPoS-0005Gr-Li
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 05:36:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dwPoP-00086N-Av
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 05:36:28 -0400
Date: Mon, 25 Sep 2017 10:36:22 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170925093622.GE14140@stefanha-x1.localdomain>
References: <20170922144353.4220-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170922144353.4220-1-vsementsov@virtuozzo.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] block/qcow2-bitmap: fix use
 of uninitialized pointer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: kwolf@redhat.com, mreitz@redhat.com, den@openvz.org, qemu-devel@nongnu.org, qemu-block@nongnu.org

On Fri, Sep 22, 2017 at 05:43:53PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> Without initialization to zero dirty_bitmap field may be not zero
> for a bitmap which should not be stored and
> qcow2_store_persistent_dirty_bitmaps will erroneously call
> store_bitmap for it which leads to SYGSEGV on bdrv_dirty_bitmap_name.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/qcow2-bitmap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
