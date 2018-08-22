Received: from eggs.gnu.org ([2001:4830:134:3::10]:41236)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fsQH0-0005BE-Ea
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 06:21:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fsQGs-0005DH-L6
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 06:21:57 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39536 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fsQGq-0005AJ-Js
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 06:21:50 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20180821081029.26121-4-xiaoguangrong@tencent.com> (guangrong
	xiao's message of "Tue, 21 Aug 2018 16:10:22 +0800")
References: <20180821081029.26121-1-xiaoguangrong@tencent.com>
	<20180821081029.26121-4-xiaoguangrong@tencent.com>
Reply-To: quintela@redhat.com
Date: Wed, 22 Aug 2018 12:21:37 +0200
Message-ID: <87in424s7i.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v4 03/10] migration: introduce
 save_zero_page_to_file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: guangrong.xiao@gmail.com
Cc: pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com, kvm@vger.kernel.org, Xiao Guangrong <xiaoguangrong@tencent.com>, qemu-devel@nongnu.org, peterx@redhat.com, dgilbert@redhat.com, wei.w.wang@intel.com, jiang.biao2@zte.com.cn

guangrong.xiao@gmail.com wrote:
> From: Xiao Guangrong <xiaoguangrong@tencent.com>
>
> It will be used by the compression threads
>
> Reviewed-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

> Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
> ---
>  migration/ram.c | 40 ++++++++++++++++++++++++++++++----------
>  1 file changed, 30 insertions(+), 10 deletions(-)
>
> diff --git a/migration/ram.c b/migration/ram.c
> index d631b9a6fe..49ace30614 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -1667,27 +1667,47 @@ static void migration_bitmap_sync(RAMState *rs)
>  /**
>   * save_zero_page: send the zero page to the stream

Fixed by hand, should be save_zero_page_to_file
