Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C609EC43331
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 08:37:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3EE720842
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 08:37:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3EE720842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i69k3-0006ef-SU
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 04:37:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50204)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhengxiang9@huawei.com>) id 1i69gO-0001zO-RS
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 04:33:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhengxiang9@huawei.com>) id 1i69gM-0005bU-SK
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 04:33:28 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:51330 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhengxiang9@huawei.com>)
 id 1i69gI-0005YD-Kb; Fri, 06 Sep 2019 04:33:22 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id AF3E2BC4DD8F5A5EE6DC;
 Fri,  6 Sep 2019 16:33:20 +0800 (CST)
Received: from HGHY1z004218071.china.huawei.com (10.177.29.32) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.439.0; Fri, 6 Sep 2019 16:33:11 +0800
From: Xiang Zheng <zhengxiang9@huawei.com>
To: <pbonzini@redhat.com>, <mst@redhat.com>, <imammedo@redhat.com>,
 <shannon.zhaosl@gmail.com>, <peter.maydell@linaro.org>, <lersek@redhat.com>,
 <james.morse@arm.com>, <gengdongjiu@huawei.com>, <mtosatti@redhat.com>,
 <rth@twiddle.net>, <ehabkost@redhat.com>, <jonathan.cameron@huawei.com>,
 <xuwei5@huawei.com>, <kvm@vger.kernel.org>, <qemu-devel@nongnu.org>,
 <qemu-arm@nongnu.org>, <linuxarm@huawei.com>
Date: Fri, 6 Sep 2019 16:31:50 +0800
Message-ID: <20190906083152.25716-5-zhengxiang9@huawei.com>
X-Mailer: git-send-email 2.15.1.windows.2
In-Reply-To: <20190906083152.25716-1-zhengxiang9@huawei.com>
References: <20190906083152.25716-1-zhengxiang9@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.29.32]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 45.249.212.35
Subject: [Qemu-devel] [PATCH v18 4/6] KVM: Move hwpoison page related
 functions into include/sysemu/kvm_int.h
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: wanghaibin.wang@huawei.com, zhengxiang9@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Dongjiu Geng <gengdongjiu@huawei.com>

kvm_hwpoison_page_add() and kvm_unpoison_all() will both be used by X86
and ARM platforms, so moving them into "include/sysemu/kvm_int.h" to
avoid duplicate code.

Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
Signed-off-by: Xiang Zheng <zhengxiang9@huawei.com>
---
 accel/kvm/kvm-all.c      | 33 +++++++++++++++++++++++++++++++++
 include/sysemu/kvm_int.h | 23 +++++++++++++++++++++++
 target/arm/kvm.c         |  3 +++
 target/i386/kvm.c        | 34 ----------------------------------
 4 files changed, 59 insertions(+), 34 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index b09bad0804..c6c052ba57 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -821,6 +821,39 @@ int kvm_vm_check_extension(KVMState *s, unsigned int extension)
     return ret;
 }
 
+typedef struct HWPoisonPage {
+    ram_addr_t ram_addr;
+    QLIST_ENTRY(HWPoisonPage) list;
+} HWPoisonPage;
+
+static QLIST_HEAD(, HWPoisonPage) hwpoison_page_list =
+    QLIST_HEAD_INITIALIZER(hwpoison_page_list);
+
+void kvm_unpoison_all(void *param)
+{
+    HWPoisonPage *page, *next_page;
+
+    QLIST_FOREACH_SAFE(page, &hwpoison_page_list, list, next_page) {
+        QLIST_REMOVE(page, list);
+        qemu_ram_remap(page->ram_addr, TARGET_PAGE_SIZE);
+        g_free(page);
+    }
+}
+
+void kvm_hwpoison_page_add(ram_addr_t ram_addr)
+{
+    HWPoisonPage *page;
+
+    QLIST_FOREACH(page, &hwpoison_page_list, list) {
+        if (page->ram_addr == ram_addr) {
+            return;
+        }
+    }
+    page = g_new(HWPoisonPage, 1);
+    page->ram_addr = ram_addr;
+    QLIST_INSERT_HEAD(&hwpoison_page_list, page, list);
+}
+
 static uint32_t adjust_ioeventfd_endianness(uint32_t val, uint32_t size)
 {
 #if defined(HOST_WORDS_BIGENDIAN) != defined(TARGET_WORDS_BIGENDIAN)
diff --git a/include/sysemu/kvm_int.h b/include/sysemu/kvm_int.h
index 72b2d1b3ae..3ad49f9a28 100644
--- a/include/sysemu/kvm_int.h
+++ b/include/sysemu/kvm_int.h
@@ -41,4 +41,27 @@ typedef struct KVMMemoryListener {
 void kvm_memory_listener_register(KVMState *s, KVMMemoryListener *kml,
                                   AddressSpace *as, int as_id);
 
+/**
+ * kvm_hwpoison_page_add:
+ *
+ * Parameters:
+ *  @ram_addr: the address in the RAM for the poisoned page
+ *
+ * Add a poisoned page to the list
+ *
+ * Return: None.
+ */
+void kvm_hwpoison_page_add(ram_addr_t ram_addr);
+
+/**
+ * kvm_unpoison_all:
+ *
+ * Parameters:
+ *  @param: some data may be passed to this function
+ *
+ * Free and remove all the poisoned pages in the list
+ *
+ * Return: None.
+ */
+void kvm_unpoison_all(void *param);
 #endif
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index b2eaa50b8d..3a110be7b8 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -20,6 +20,7 @@
 #include "sysemu/sysemu.h"
 #include "sysemu/kvm.h"
 #include "sysemu/kvm_int.h"
+#include "sysemu/reset.h"
 #include "kvm_arm.h"
 #include "cpu.h"
 #include "trace.h"
@@ -195,6 +196,8 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
 
     cap_has_mp_state = kvm_check_extension(s, KVM_CAP_MP_STATE);
 
+    qemu_register_reset(kvm_unpoison_all, NULL);
+
     return 0;
 }
 
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 8023c679ea..4f9f3682ee 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -476,40 +476,6 @@ uint32_t kvm_arch_get_supported_msr_feature(KVMState *s, uint32_t index)
     return msr_data.entries[0].data;
 }
 
-
-typedef struct HWPoisonPage {
-    ram_addr_t ram_addr;
-    QLIST_ENTRY(HWPoisonPage) list;
-} HWPoisonPage;
-
-static QLIST_HEAD(, HWPoisonPage) hwpoison_page_list =
-    QLIST_HEAD_INITIALIZER(hwpoison_page_list);
-
-static void kvm_unpoison_all(void *param)
-{
-    HWPoisonPage *page, *next_page;
-
-    QLIST_FOREACH_SAFE(page, &hwpoison_page_list, list, next_page) {
-        QLIST_REMOVE(page, list);
-        qemu_ram_remap(page->ram_addr, TARGET_PAGE_SIZE);
-        g_free(page);
-    }
-}
-
-static void kvm_hwpoison_page_add(ram_addr_t ram_addr)
-{
-    HWPoisonPage *page;
-
-    QLIST_FOREACH(page, &hwpoison_page_list, list) {
-        if (page->ram_addr == ram_addr) {
-            return;
-        }
-    }
-    page = g_new(HWPoisonPage, 1);
-    page->ram_addr = ram_addr;
-    QLIST_INSERT_HEAD(&hwpoison_page_list, page, list);
-}
-
 static int kvm_get_mce_cap_supported(KVMState *s, uint64_t *mce_cap,
                                      int *max_banks)
 {
-- 
2.19.1



