Received: from eggs.gnu.org ([2001:4830:134:3::10]:52386)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1dBaBP-00010g-2T
	for qemu-devel@nongnu.org; Fri, 19 May 2017 01:10:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1dBaBO-0005iB-4s
	for qemu-devel@nongnu.org; Fri, 19 May 2017 01:10:35 -0400
Received: from mga04.intel.com ([192.55.52.120]:39329)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1dBaBN-0005ha-TE
	for qemu-devel@nongnu.org; Fri, 19 May 2017 01:10:34 -0400
From: Yang Zhong <yang.zhong@intel.com>
Date: Fri, 19 May 2017 13:09:41 +0800
Message-Id: <1495170583-30905-3-git-send-email-yang.zhong@intel.com>
In-Reply-To: <1495170583-30905-1-git-send-email-yang.zhong@intel.com>
References: <1495170583-30905-1-git-send-email-yang.zhong@intel.com>
Subject: [Qemu-devel] [PATCH v0 2/4] move cputlb.c
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

move cputlb.c to accel/tcg/

Signed-off-by: Yang Zhong <yang.zhong@intel.com>
---
 Makefile.target                | 2 +-
 accel/tcg/Makefile.objs        | 1 +
 cputlb.c => accel/tcg/cputlb.c | 0
 3 files changed, 2 insertions(+), 1 deletion(-)
 rename cputlb.c => accel/tcg/cputlb.c (100%)

diff --git a/Makefile.target b/Makefile.target
index ba893a8..3e19fe9 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -144,7 +144,7 @@ obj-y += qtest.o bootdevice.o
 obj-y += hw/
 obj-$(CONFIG_KVM) += kvm-all.o
 obj-y += accel/
-obj-y += memory.o cputlb.o
+obj-y += memory.o
 obj-y += memory_mapping.o
 obj-y += dump.o
 obj-y += migration/ram.o migration/savevm.o
diff --git a/accel/tcg/Makefile.objs b/accel/tcg/Makefile.objs
index 6e3211a..487570f 100644
--- a/accel/tcg/Makefile.objs
+++ b/accel/tcg/Makefile.objs
@@ -1 +1,2 @@
 obj-$(CONFIG_SOFTMMU) += tcg-all.o
+obj-$(CONFIG_SOFTMMU) += cputlb.o
diff --git a/cputlb.c b/accel/tcg/cputlb.c
similarity index 100%
rename from cputlb.c
rename to accel/tcg/cputlb.c
-- 
1.9.1
