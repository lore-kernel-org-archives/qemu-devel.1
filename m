Received: from eggs.gnu.org ([2001:4830:134:3::10]:46479)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1fPmDj-0007QV-Nv
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 05:56:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1fPmDi-00016V-Tz
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 05:56:11 -0400
Received: from mail-pl0-x230.google.com ([2607:f8b0:400e:c01::230]:35514)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1fPmDi-000169-O8
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 05:56:10 -0400
Received: by mail-pl0-x230.google.com with SMTP id i5-v6so19391737plt.2
	for <qemu-devel@nongnu.org>; Mon, 04 Jun 2018 02:56:10 -0700 (PDT)
From: guangrong.xiao@gmail.com
Date: Mon,  4 Jun 2018 17:55:10 +0800
Message-Id: <20180604095520.8563-3-xiaoguangrong@tencent.com>
In-Reply-To: <20180604095520.8563-1-xiaoguangrong@tencent.com>
References: <20180604095520.8563-1-xiaoguangrong@tencent.com>
Subject: [Qemu-devel] [PATCH 02/12] migration: fix counting normal page for
 compression
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, dgilbert@redhat.com, peterx@redhat.com, jiang.biao2@zte.com.cn, wei.w.wang@intel.com, Xiao Guangrong <xiaoguangrong@tencent.com>

From: Xiao Guangrong <xiaoguangrong@tencent.com>

The compressed page is not normal page

Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
---
 migration/ram.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/migration/ram.c b/migration/ram.c
index 0caf32ab0a..dbf24d8c87 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1432,7 +1432,6 @@ static int compress_page_with_multi_thread(RAMState *rs, RAMBlock *block,
             qemu_cond_signal(&comp_param[idx].cond);
             qemu_mutex_unlock(&comp_param[idx].mutex);
             pages = 1;
-            ram_counters.normal++;
             ram_counters.transferred += bytes_xmit;
             break;
         }
-- 
2.14.4
