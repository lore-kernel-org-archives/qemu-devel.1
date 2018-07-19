Received: from eggs.gnu.org ([2001:4830:134:3::10]:34952)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1fg7qX-00023o-KI
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 08:15:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1fg7qW-0005Nx-OX
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 08:15:49 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c]:41514)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1fg7qW-0005Nj-IJ
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 08:15:48 -0400
Received: by mail-pg1-x52c.google.com with SMTP id z8-v6so3578706pgu.8
	for <qemu-devel@nongnu.org>; Thu, 19 Jul 2018 05:15:48 -0700 (PDT)
From: guangrong.xiao@gmail.com
Date: Thu, 19 Jul 2018 20:15:14 +0800
Message-Id: <20180719121520.30026-3-xiaoguangrong@tencent.com>
In-Reply-To: <20180719121520.30026-1-xiaoguangrong@tencent.com>
References: <20180719121520.30026-1-xiaoguangrong@tencent.com>
Subject: [Qemu-devel] [PATCH v2 2/8] migration: fix counting normal page for
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
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, dgilbert@redhat.com, peterx@redhat.com, wei.w.wang@intel.com, jiang.biao2@zte.com.cn, eblake@redhat.com, Xiao Guangrong <xiaoguangrong@tencent.com>

From: Xiao Guangrong <xiaoguangrong@tencent.com>

The compressed page is not normal page

Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
---
 migration/ram.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/migration/ram.c b/migration/ram.c
index 0ad234c692..1b016e048d 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1903,7 +1903,6 @@ retry:
             qemu_cond_signal(&comp_param[idx].cond);
             qemu_mutex_unlock(&comp_param[idx].mutex);
             pages = 1;
-            ram_counters.normal++;
             ram_counters.transferred += bytes_xmit;
             break;
         }
-- 
2.14.4
