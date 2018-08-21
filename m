Received: from eggs.gnu.org ([2001:4830:134:3::10]:47088)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1fs1kg-0003sA-Ed
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 04:10:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1fs1kd-0004WI-IM
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 04:10:58 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530]:39857)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1fs1kd-0004Rg-0G
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 04:10:55 -0400
Received: by mail-pg1-x530.google.com with SMTP id a11-v6so8100029pgw.6
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 01:10:50 -0700 (PDT)
From: guangrong.xiao@gmail.com
Date: Tue, 21 Aug 2018 16:10:21 +0800
Message-Id: <20180821081029.26121-3-xiaoguangrong@tencent.com>
In-Reply-To: <20180821081029.26121-1-xiaoguangrong@tencent.com>
References: <20180821081029.26121-1-xiaoguangrong@tencent.com>
Subject: [Qemu-devel] [PATCH v4 02/10] migration: fix counting normal page
 for compression
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

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
---
 migration/ram.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/migration/ram.c b/migration/ram.c
index ae9e83c2b6..d631b9a6fe 100644
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
