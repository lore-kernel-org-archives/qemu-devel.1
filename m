Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82F9BC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 20:34:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C2F620720
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 20:34:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KZSpiFue"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C2F620720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43648 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjTuE-0003Im-ES
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 16:34:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56048)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjTAO-0001rS-BF
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:47:12 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:20514
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjTAM-0001Pq-5e
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:47:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591904829;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CqSVqjnl4aUpOYRqUchj6CeSEWEGszyemmeLF9cKaks=;
 b=KZSpiFue4OZ7gIJHxlQwB2KIjgf2ZMuIe1oDQxUleJWtWK1MAsztNyB1lVoQLS43nD6i15
 LlIt4SDfaUTzIAzgE/JN1BS4M2uC19XMGU69jqMyQBkWMpLJcgY8MGF5tQouogHBTIodJI
 uIhGkmk9yZepJ+TcHqewzZZWPaJfW5k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-447-_u2DCYnkM8iXmsLkWI6ZNw-1; Thu, 11 Jun 2020 15:46:58 -0400
X-MC-Unique: _u2DCYnkM8iXmsLkWI6ZNw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 49F84461;
 Thu, 11 Jun 2020 19:46:57 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 03FF760CC0;
 Thu, 11 Jun 2020 19:46:56 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 087/115] i386: hvf: Move HVFState definition into hvf
Date: Thu, 11 Jun 2020 15:44:21 -0400
Message-Id: <20200611194449.31468-88-pbonzini@redhat.com>
In-Reply-To: <20200611194449.31468-1-pbonzini@redhat.com>
References: <20200611194449.31468-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 03:29:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Roman Bolshakov <r.bolshakov@yadro.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Roman Bolshakov <r.bolshakov@yadro.com>

"sysemu/hvf.h" is intended for inclusion in generic code. However it
also contains several hvf definitions and declarations, including
HVFState that are used only inside "hvf.c". "hvf-i386.h" would be more
appropriate place to define HVFState as it's only included by "hvf.c"
and "x86_task.c".

Signed-off-by: Roman Bolshakov <r.bolshakov@yadro.com>
Message-Id: <20200528193758.51454-2-r.bolshakov@yadro.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/sysemu/hvf.h       | 37 -------------------------------------
 target/i386/hvf/hvf-i386.h | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+), 37 deletions(-)

diff --git a/include/sysemu/hvf.h b/include/sysemu/hvf.h
index fe95743124..644bdfc722 100644
--- a/include/sysemu/hvf.h
+++ b/include/sysemu/hvf.h
@@ -15,8 +15,6 @@
 
 #include "cpu.h"
 #include "qemu/bitops.h"
-#include "exec/memory.h"
-#include "sysemu/accel.h"
 
 #ifdef CONFIG_HVF
 #include <Hypervisor/hv.h>
@@ -32,41 +30,6 @@ extern bool hvf_allowed;
 #define hvf_get_supported_cpuid(func, idx, reg) 0
 #endif /* !CONFIG_HVF */
 
-/* hvf_slot flags */
-#define HVF_SLOT_LOG (1 << 0)
-
-typedef struct hvf_slot {
-    uint64_t start;
-    uint64_t size;
-    uint8_t *mem;
-    int slot_id;
-    uint32_t flags;
-    MemoryRegion *region;
-} hvf_slot;
-
-typedef struct hvf_vcpu_caps {
-    uint64_t vmx_cap_pinbased;
-    uint64_t vmx_cap_procbased;
-    uint64_t vmx_cap_procbased2;
-    uint64_t vmx_cap_entry;
-    uint64_t vmx_cap_exit;
-    uint64_t vmx_cap_preemption_timer;
-} hvf_vcpu_caps;
-
-typedef struct HVFState {
-    AccelState parent;
-    hvf_slot slots[32];
-    int num_slots;
-
-    hvf_vcpu_caps *hvf_caps;
-} HVFState;
-extern HVFState *hvf_state;
-
-void hvf_set_phys_mem(MemoryRegionSection *, bool);
-void hvf_handle_io(CPUArchState *, uint16_t, void *,
-                  int, int, int);
-hvf_slot *hvf_find_overlap_slot(uint64_t, uint64_t);
-
 /* Disable HVF if |disable| is 1, otherwise, enable it iff it is supported by
  * the host CPU. Use hvf_enabled() after this to get the result. */
 void hvf_disable(int disable);
diff --git a/target/i386/hvf/hvf-i386.h b/target/i386/hvf/hvf-i386.h
index fbe4a350c5..ef20c73eca 100644
--- a/target/i386/hvf/hvf-i386.h
+++ b/target/i386/hvf/hvf-i386.h
@@ -16,6 +16,7 @@
 #ifndef HVF_I386_H
 #define HVF_I386_H
 
+#include "sysemu/accel.h"
 #include "sysemu/hvf.h"
 #include "cpu.h"
 #include "x86.h"
@@ -35,6 +36,40 @@ struct hvf_state {
     uint64_t mem_quota;
 };
 
+/* hvf_slot flags */
+#define HVF_SLOT_LOG (1 << 0)
+
+typedef struct hvf_slot {
+    uint64_t start;
+    uint64_t size;
+    uint8_t *mem;
+    int slot_id;
+    uint32_t flags;
+    MemoryRegion *region;
+} hvf_slot;
+
+typedef struct hvf_vcpu_caps {
+    uint64_t vmx_cap_pinbased;
+    uint64_t vmx_cap_procbased;
+    uint64_t vmx_cap_procbased2;
+    uint64_t vmx_cap_entry;
+    uint64_t vmx_cap_exit;
+    uint64_t vmx_cap_preemption_timer;
+} hvf_vcpu_caps;
+
+typedef struct HVFState {
+    AccelState parent;
+    hvf_slot slots[32];
+    int num_slots;
+
+    hvf_vcpu_caps *hvf_caps;
+} HVFState;
+extern HVFState *hvf_state;
+
+void hvf_set_phys_mem(MemoryRegionSection *, bool);
+void hvf_handle_io(CPUArchState *, uint16_t, void *, int, int, int);
+hvf_slot *hvf_find_overlap_slot(uint64_t, uint64_t);
+
 #ifdef NEED_CPU_H
 /* Functions exported to host specific mode */
 
-- 
2.26.2



