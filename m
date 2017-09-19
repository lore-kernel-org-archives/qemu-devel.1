Received: from eggs.gnu.org ([2001:4830:134:3::10]:38969)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1duLdX-00068E-3D
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 12:44:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1duLdW-0002uu-2Y
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 12:44:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47300)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1duLdV-0002u6-QH
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 12:44:37 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Tue, 19 Sep 2017 18:43:10 +0200
Message-Id: <20170919164337.18555-12-cohuck@redhat.com>
In-Reply-To: <20170919164337.18555-1-cohuck@redhat.com>
References: <20170919164337.18555-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL v2 11/38] exec, dump, i386, ppc,
 s390x: don't include exec/cpu-all.h explicitly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, rth@twiddle.net, agraf@suse.de, thuth@redhat.com, borntraeger@de.ibm.com, david@redhat.com, Cornelia Huck <cohuck@redhat.com>

From: David Hildenbrand <david@redhat.com>

All but a handful of files include exec/cpu-all.h via cpu.h only.
As these files already include cpu.h, let's just drop the additional
include.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20170913132417.24384-2-david@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 dump.c                            | 1 -
 exec.c                            | 1 -
 target/i386/arch_dump.c           | 1 -
 target/i386/arch_memory_mapping.c | 1 -
 target/i386/svm_helper.c          | 1 -
 target/ppc/arch_dump.c            | 1 -
 target/s390x/arch_dump.c          | 1 -
 7 files changed, 7 deletions(-)

diff --git a/dump.c b/dump.c
index d2093e141b..7ebcf553b2 100644
--- a/dump.c
+++ b/dump.c
@@ -15,7 +15,6 @@
 #include "qemu/cutils.h"
 #include "elf.h"
 #include "cpu.h"
-#include "exec/cpu-all.h"
 #include "exec/hwaddr.h"
 #include "monitor/monitor.h"
 #include "sysemu/kvm.h"
diff --git a/exec.c b/exec.c
index d20c34ca83..a25a4c6018 100644
--- a/exec.c
+++ b/exec.c
@@ -56,7 +56,6 @@
 #endif
 
 #endif
-#include "exec/cpu-all.h"
 #include "qemu/rcu_queue.h"
 #include "qemu/main-loop.h"
 #include "translate-all.h"
diff --git a/target/i386/arch_dump.c b/target/i386/arch_dump.c
index e682904052..35b55fc200 100644
--- a/target/i386/arch_dump.c
+++ b/target/i386/arch_dump.c
@@ -13,7 +13,6 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "exec/cpu-all.h"
 #include "sysemu/dump.h"
 #include "elf.h"
 #include "sysemu/memory_mapping.h"
diff --git a/target/i386/arch_memory_mapping.c b/target/i386/arch_memory_mapping.c
index 647cff2829..271cb5e41b 100644
--- a/target/i386/arch_memory_mapping.c
+++ b/target/i386/arch_memory_mapping.c
@@ -13,7 +13,6 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "exec/cpu-all.h"
 #include "sysemu/memory_mapping.h"
 
 /* PAE Paging or IA-32e Paging */
diff --git a/target/i386/svm_helper.c b/target/i386/svm_helper.c
index 59e8b5091c..f479239875 100644
--- a/target/i386/svm_helper.c
+++ b/target/i386/svm_helper.c
@@ -19,7 +19,6 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "exec/cpu-all.h"
 #include "exec/helper-proto.h"
 #include "exec/exec-all.h"
 #include "exec/cpu_ldst.h"
diff --git a/target/ppc/arch_dump.c b/target/ppc/arch_dump.c
index 95b9ab6f29..351a65b22f 100644
--- a/target/ppc/arch_dump.c
+++ b/target/ppc/arch_dump.c
@@ -15,7 +15,6 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "elf.h"
-#include "exec/cpu-all.h"
 #include "sysemu/dump.h"
 #include "sysemu/kvm.h"
 
diff --git a/target/s390x/arch_dump.c b/target/s390x/arch_dump.c
index 9b0bf92698..6f61ff95af 100644
--- a/target/s390x/arch_dump.c
+++ b/target/s390x/arch_dump.c
@@ -15,7 +15,6 @@
 #include "cpu.h"
 #include "internal.h"
 #include "elf.h"
-#include "exec/cpu-all.h"
 #include "sysemu/dump.h"
 
 
-- 
2.13.5
