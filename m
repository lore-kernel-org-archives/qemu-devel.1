Received: from eggs.gnu.org ([2001:4830:134:3::10]:41918)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dLess-0001Vv-LD
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 20:13:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dLesp-00068p-HO
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 20:13:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41030)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dLesp-00068J-Ab
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 20:13:03 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1701180F6B
	for <qemu-devel@nongnu.org>; Fri, 16 Jun 2017 00:13:01 +0000 (UTC)
Date: Fri, 16 Jun 2017 08:12:58 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170616001258.GB21807@lemon.lan>
References: <20170608115643.18859-1-famz@redhat.com>
	<20170608115643.18859-19-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170608115643.18859-19-famz@redhat.com>
Subject: Re: [Qemu-devel] [PULL v3 18/23] block: introduce dirty_bitmap_mutex
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com

On Thu, 06/08 19:56, Fam Zheng wrote:
> From: Paolo Bonzini <pbonzini@redhat.com>
> 
> It protects only the list of dirty bitmaps; in the next patch we will
> also protect their content.
> 
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Message-Id: <20170605123908.18777-15-pbonzini@redhat.com>
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  block/dirty-bitmap.c      | 44 +++++++++++++++++++++++++++++++++++++++++++-
>  block/mirror.c            |  3 ++-
>  blockdev.c                | 44 +++++++-------------------------------------
>  include/block/block_int.h |  5 +++++
>  migration/block.c         |  6 ------
>  5 files changed, 57 insertions(+), 45 deletions(-)

Squashing in this hunk for v4 (and have my fingers crossed :)

diff --git a/block.c b/block.c
index XXXXXXX..XXXXXXX XXXXXX
--- a/block.c
+++ b/block.c
@@ -XXX,X +XXX,X @@ BlockDriverState *bdrv_new(void)
     }
     notifier_with_return_list_init(&bs->before_write_notifiers);
     qemu_co_mutex_init(&bs->reqs_lock);
+    qemu_mutex_init(&bs->dirty_bitmap_mutex);
     bs->refcnt = 1;
     bs->aio_context = qemu_get_aio_context();
