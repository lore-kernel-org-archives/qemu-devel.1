Received: from eggs.gnu.org ([2001:4830:134:3::10]:34756)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cFEJo-000373-2e
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 01:06:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cFEJk-0002qM-R6
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 01:06:04 -0500
Received: from [59.151.112.132] (port=42593 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cFEJk-0002pw-Ft
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 01:06:00 -0500
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Date: Fri, 9 Dec 2016 14:04:54 +0800
Message-ID: <1481263496-8004-2-git-send-email-zhangchen.fnst@cn.fujitsu.com>
In-Reply-To: <1481263496-8004-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
References: <1481263496-8004-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH for-2.9 V3 1/3] Migration: Don't load vmdesc
 when xen is enabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu devel <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>, Eric Blake <eblake@redhat.com>
Cc: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, "eddie . dong" <eddie.dong@intel.com>, Bian Naimeng <biannm@cn.fujitsu.com>, Changlong Xie <xiecl.fnst@cn.fujitsu.com>

Xen doesn't need this.

Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
---
 migration/savevm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/migration/savevm.c b/migration/savevm.c
index 0363372..bec6c7e 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1973,6 +1973,10 @@ int qemu_loadvm_state(QEMUFile *f)
         ret = qemu_file_get_error(f);
     }
 
+    if (xen_enabled()) {
+        return ret;
+    }
+
     /*
      * Try to read in the VMDESC section as well, so that dumping tools that
      * intercept our migration stream have the chance to see it.
-- 
2.7.4
