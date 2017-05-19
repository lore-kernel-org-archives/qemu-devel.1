Received: from eggs.gnu.org ([2001:4830:134:3::10]:52408)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1dBaBS-00013D-5r
	for qemu-devel@nongnu.org; Fri, 19 May 2017 01:10:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1dBaBR-0005ic-91
	for qemu-devel@nongnu.org; Fri, 19 May 2017 01:10:38 -0400
Received: from mga04.intel.com ([192.55.52.120]:39329)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1dBaBR-0005ha-0b
	for qemu-devel@nongnu.org; Fri, 19 May 2017 01:10:37 -0400
From: Yang Zhong <yang.zhong@intel.com>
Date: Fri, 19 May 2017 13:09:43 +0800
Message-Id: <1495170583-30905-5-git-send-email-yang.zhong@intel.com>
In-Reply-To: <1495170583-30905-1-git-send-email-yang.zhong@intel.com>
References: <1495170583-30905-1-git-send-email-yang.zhong@intel.com>
Subject: [Qemu-devel] [PATCH v0 4/4] move cpu-exec-common.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eblake@redhat.com
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, anthony.xu@intel.com, Yang Zhong <yang.zhong@intel.com>

move cpu-exec-common.c to accel/tcg

Signed-off-by: Yang Zhong <yang.zhong@intel.com>
---
 Makefile.target                                  | 1 -
 accel/tcg/Makefile.objs                          | 2 +-
 cpu-exec-common.c => accel/tcg/cpu-exec-common.c | 0
 3 files changed, 1 insertion(+), 2 deletions(-)
 rename cpu-exec-common.c => accel/tcg/cpu-exec-common.c (100%)

diff --git a/Makefile.target b/Makefile.target
index 709d07a..b083a76 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -91,7 +91,6 @@ all: $(PROGS) stap
 obj-y = exec.o translate-all.o
 obj-y += accel/
 obj-y += translate-common.o
-obj-y += cpu-exec-common.o
 obj-y += tcg/tcg.o tcg/tcg-op.o tcg/optimize.o
 obj-$(CONFIG_TCG_INTERPRETER) += tci.o
 obj-y += tcg/tcg-common.o
diff --git a/accel/tcg/Makefile.objs b/accel/tcg/Makefile.objs
index 6b75a31..940379b 100644
--- a/accel/tcg/Makefile.objs
+++ b/accel/tcg/Makefile.objs
@@ -1,3 +1,3 @@
 obj-$(CONFIG_SOFTMMU) += tcg-all.o
 obj-$(CONFIG_SOFTMMU) += cputlb.o
-obj-y += cpu-exec.o
+obj-y += cpu-exec.o cpu-exec-common.o
diff --git a/cpu-exec-common.c b/accel/tcg/cpu-exec-common.c
similarity index 100%
rename from cpu-exec-common.c
rename to accel/tcg/cpu-exec-common.c
-- 
1.9.1
