Received: from eggs.gnu.org ([2001:4830:134:3::10]:37384)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dotX8-0004F7-11
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 11:43:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dotX3-0000qy-Ed
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 11:43:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58352)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dotX3-0000qW-5q
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 11:43:25 -0400
From: David Hildenbrand <david@redhat.com>
Date: Mon,  4 Sep 2017 17:42:58 +0200
Message-Id: <20170904154316.4148-2-david@redhat.com>
In-Reply-To: <20170904154316.4148-1-david@redhat.com>
References: <20170904154316.4148-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v2 01/19] exec, dump, i386, ppc,
 s390x: don't include exec/cpu-all.h explicitly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, thuth@redhat.com, cohuck@redhat.com, david@redhat.com, borntraeger@de.ibm.com, Alexander Graf <agraf@suse.de>, Eduardo Habkost <ehabkost@redhat.com>

All but a handfull of filles include exec/cpu-all.h via cpu.h only.
As these files already include cpu.h, let's just drop the additional
include.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 dump.c                            | 1 -
 exec.c                            | 2 --
 target/i386/arch_dump.c           | 1 -
 target/i386/arch_memory_mapping.c | 1 -
 target/i386/svm_helper.c          | 1 -
 target/ppc/arch_dump.c            | 1 -
 target/s390x/arch_dump.c          | 1 -
 7 files changed, 8 deletions(-)

diff --git a/dump.c b/dump.c
index a79773d0f7..2ef6a678e8 100644
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
index d20c34ca83..d109de2014 100644
--- a/exec.c
+++ b/exec.c
@@ -23,7 +23,6 @@
 
 #include "qemu/cutils.h"
 #include "cpu.h"
-#include "exec/exec-all.h"
 #include "exec/target_page.h"
 #include "tcg.h"
 #include "hw/qdev-core.h"
@@ -56,7 +55,6 @@
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
index 8e9397aa58..beb7268e57 100644
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
