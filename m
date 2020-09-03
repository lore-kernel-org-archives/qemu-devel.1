Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4D2EC433E9
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 13:36:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AEC020716
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 13:36:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AEC020716
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDpPI-0005N4-Fw
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 09:36:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48064)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FelixCui-oc@zhaoxin.com>)
 id 1kDmDB-00086o-EH
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 06:11:22 -0400
Received: from [203.148.12.82] (port=35769 helo=ZXSHCAS2.zhaoxin.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <FelixCui-oc@zhaoxin.com>)
 id 1kDmD8-0006D0-SV
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 06:11:21 -0400
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXSHCAS2.zhaoxin.com
 (10.28.252.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 3 Sep 2020
 17:49:51 +0800
Received: from localhost.localdomain (124.64.16.12) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 3 Sep 2020
 17:49:49 +0800
From: FelixCuioc <FelixCui-oc@zhaoxin.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, 
 Eduardo Habkost <ehabkost@redhat.com>
Subject: [PATCH 1/1] Skip flatview_simplify() for specific cpu vendor
Date: Thu, 3 Sep 2020 05:49:35 -0400
Message-ID: <20200903094935.2361-2-FelixCui-oc@zhaoxin.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200903094935.2361-1-FelixCui-oc@zhaoxin.com>
References: <20200903094935.2361-1-FelixCui-oc@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [124.64.16.12]
X-ClientProxiedBy: ZXSHCAS1.zhaoxin.com (10.28.252.161) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 203.148.12.82 (failed)
Received-SPF: pass client-ip=203.148.12.82;
 envelope-from=FelixCui-oc@zhaoxin.com; helo=ZXSHCAS2.zhaoxin.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 05:49:52
X-ACL-Warn: Detected OS   = Windows 7 or 8 [fuzzy]
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, RDNS_NONE=0.793,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 03 Sep 2020 09:34:31 -0400
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
Cc: TonyWWang-oc@zhaoxin.com, RockCui-oc@zhaoxin.com, qemu-devel@nongnu.org,
 CobeChen-oc@zhaoxin.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Flatview_simplify() will merge many address ranges
into one range.When a part of the big range needs
to be changed,this will cause some innocent mappings
to be unmapped.So we want to skip flatview_simplify().

Signed-off-by: FelixCuioc <FelixCui-oc@zhaoxin.com>
---
 softmmu/memory.c  | 16 +++++++++++++++-
 target/i386/cpu.c |  8 ++++++++
 target/i386/cpu.h |  3 +++
 3 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/softmmu/memory.c b/softmmu/memory.c
index 70b93104e8..348e9db622 100644
--- a/softmmu/memory.c
+++ b/softmmu/memory.c
@@ -699,6 +699,18 @@ static MemoryRegion *memory_region_get_flatview_root(MemoryRegion *mr)
     return NULL;
 }
 
+static bool skip_simplify(void)
+{
+    char vendor[CPUID_VENDOR_SZ + 1] = { 0 };
+    host_get_vendor(vendor);
+    if (!strncmp(vendor, CPUID_VENDOR_VIA, strlen(CPUID_VENDOR_VIA))
+        || !strncmp(vendor, CPUID_VENDOR_ZHAOXIN,
+                    strlen(CPUID_VENDOR_ZHAOXIN))) {
+        return true;
+    }
+    return false;
+}
+
 /* Render a memory topology into a list of disjoint absolute ranges. */
 static FlatView *generate_memory_topology(MemoryRegion *mr)
 {
@@ -712,7 +724,9 @@ static FlatView *generate_memory_topology(MemoryRegion *mr)
                              addrrange_make(int128_zero(), int128_2_64()),
                              false, false);
     }
-    flatview_simplify(view);
+    if (!skip_simplify()) {
+        flatview_simplify(view);
+    }
 
     view->dispatch = address_space_dispatch_new(view);
     for (i = 0; i < view->nr; i++) {
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 49d8958528..08508c8580 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1664,6 +1664,14 @@ void host_cpuid(uint32_t function, uint32_t count,
         *edx = vec[3];
 }
 
+void host_get_vendor(char *vendor)
+{
+    uint32_t eax, ebx, ecx, edx;
+
+    host_cpuid(0x0, 0, &eax, &ebx, &ecx, &edx);
+    x86_cpu_vendor_words2str(vendor, ebx, edx, ecx);
+}
+
 void host_vendor_fms(char *vendor, int *family, int *model, int *stepping)
 {
     uint32_t eax, ebx, ecx, edx;
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index d3097be6a5..14c8b4c09f 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -832,6 +832,8 @@ typedef uint64_t FeatureWordArray[FEATURE_WORDS];
 
 #define CPUID_VENDOR_VIA   "CentaurHauls"
 
+#define CPUID_VENDOR_ZHAOXIN   "  Shanghai  "
+
 #define CPUID_VENDOR_HYGON    "HygonGenuine"
 
 #define IS_INTEL_CPU(env) ((env)->cpuid_vendor1 == CPUID_VENDOR_INTEL_1 && \
@@ -1917,6 +1919,7 @@ void cpu_clear_apic_feature(CPUX86State *env);
 void host_cpuid(uint32_t function, uint32_t count,
                 uint32_t *eax, uint32_t *ebx, uint32_t *ecx, uint32_t *edx);
 void host_vendor_fms(char *vendor, int *family, int *model, int *stepping);
+void host_get_vendor(char *vendor);
 
 /* helper.c */
 bool x86_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
-- 
2.17.1


