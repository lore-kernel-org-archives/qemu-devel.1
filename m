Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27595C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 09:16:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5F212074D
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 09:16:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GyvLRqJv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5F212074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6VpZ-0002Cg-GS
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 05:16:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42468)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k6VmS-0004sP-A6
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 05:13:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48452
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k6VmK-0002nY-N4
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 05:13:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597396415;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0a0pdxj8URCPTrQRCRURzIJ/7kye+CS6zcsdxJWquRA=;
 b=GyvLRqJv+h5oTlihoUKI4VPcGKICCUjAvE2TASmQaKQWHEYnvhF6hADMWHJbrzuhp8J6hr
 i+ZilJC+Zzc10thOq5sUmQf4ppjs88+uULX1qSw0zGY6zmHe7VcbpHn86/IO9vPXI1t9nz
 N9hnRUmYkhkhLQDWX9EUoUfjKsw+Hzo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-433-kitPRI8qN8Cxm1EPNswCIQ-1; Fri, 14 Aug 2020 05:13:33 -0400
X-MC-Unique: kitPRI8qN8Cxm1EPNswCIQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1FB651015DBC
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2020 09:13:32 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E0A8360C04
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2020 09:13:31 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 006/150] meson: rename .inc.h files to .h.inc
Date: Fri, 14 Aug 2020 05:11:02 -0400
Message-Id: <20200814091326.16173-7-pbonzini@redhat.com>
In-Reply-To: <20200814091326.16173-1-pbonzini@redhat.com>
References: <20200814091326.16173-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/14 05:13:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Make it consistent with '.c.inc' and '.rst.inc'.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/exec/cpu-all.h                               | 10 +++++-----
 include/exec/memory.h                                | 12 ++++++------
 .../exec/{memory_ldst.inc.h => memory_ldst.h.inc}    |  0
 ...ry_ldst_cached.inc.h => memory_ldst_cached.h.inc} |  0
 ...memory_ldst_phys.inc.h => memory_ldst_phys.h.inc} |  0
 target/s390x/cpu_features.c                          |  2 +-
 target/s390x/cpu_features_def.h                      |  2 +-
 ...cpu_features_def.inc.h => cpu_features_def.h.inc} |  0
 8 files changed, 13 insertions(+), 13 deletions(-)
 rename include/exec/{memory_ldst.inc.h => memory_ldst.h.inc} (100%)
 rename include/exec/{memory_ldst_cached.inc.h => memory_ldst_cached.h.inc} (100%)
 rename include/exec/{memory_ldst_phys.inc.h => memory_ldst_phys.h.inc} (100%)
 rename target/s390x/{cpu_features_def.inc.h => cpu_features_def.h.inc} (100%)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index fc403d456b..f6439c4705 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -189,13 +189,13 @@ extern unsigned long reserved_va;
 #define ARG1         as
 #define ARG1_DECL    AddressSpace *as
 #define TARGET_ENDIANNESS
-#include "exec/memory_ldst.inc.h"
+#include "exec/memory_ldst.h.inc"
 
 #define SUFFIX       _cached_slow
 #define ARG1         cache
 #define ARG1_DECL    MemoryRegionCache *cache
 #define TARGET_ENDIANNESS
-#include "exec/memory_ldst.inc.h"
+#include "exec/memory_ldst.h.inc"
 
 static inline void stl_phys_notdirty(AddressSpace *as, hwaddr addr, uint32_t val)
 {
@@ -207,17 +207,17 @@ static inline void stl_phys_notdirty(AddressSpace *as, hwaddr addr, uint32_t val
 #define ARG1         as
 #define ARG1_DECL    AddressSpace *as
 #define TARGET_ENDIANNESS
-#include "exec/memory_ldst_phys.inc.h"
+#include "exec/memory_ldst_phys.h.inc"
 
 /* Inline fast path for direct RAM access.  */
 #define ENDIANNESS
-#include "exec/memory_ldst_cached.inc.h"
+#include "exec/memory_ldst_cached.h.inc"
 
 #define SUFFIX       _cached
 #define ARG1         cache
 #define ARG1_DECL    MemoryRegionCache *cache
 #define TARGET_ENDIANNESS
-#include "exec/memory_ldst_phys.inc.h"
+#include "exec/memory_ldst_phys.h.inc"
 #endif
 
 /* page related stuff */
diff --git a/include/exec/memory.h b/include/exec/memory.h
index 307e527835..0cfe987ab4 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -2133,12 +2133,12 @@ MemTxResult address_space_write_rom(AddressSpace *as, hwaddr addr,
 #define SUFFIX
 #define ARG1         as
 #define ARG1_DECL    AddressSpace *as
-#include "exec/memory_ldst.inc.h"
+#include "exec/memory_ldst.h.inc"
 
 #define SUFFIX
 #define ARG1         as
 #define ARG1_DECL    AddressSpace *as
-#include "exec/memory_ldst_phys.inc.h"
+#include "exec/memory_ldst_phys.h.inc"
 
 struct MemoryRegionCache {
     void *ptr;
@@ -2179,7 +2179,7 @@ struct MemoryRegionCache {
 #define SUFFIX       _cached_slow
 #define ARG1         cache
 #define ARG1_DECL    MemoryRegionCache *cache
-#include "exec/memory_ldst.inc.h"
+#include "exec/memory_ldst.h.inc"
 
 /* Inline fast path for direct RAM access.  */
 static inline uint8_t address_space_ldub_cached(MemoryRegionCache *cache,
@@ -2205,15 +2205,15 @@ static inline void address_space_stb_cached(MemoryRegionCache *cache,
 }
 
 #define ENDIANNESS   _le
-#include "exec/memory_ldst_cached.inc.h"
+#include "exec/memory_ldst_cached.h.inc"
 
 #define ENDIANNESS   _be
-#include "exec/memory_ldst_cached.inc.h"
+#include "exec/memory_ldst_cached.h.inc"
 
 #define SUFFIX       _cached
 #define ARG1         cache
 #define ARG1_DECL    MemoryRegionCache *cache
-#include "exec/memory_ldst_phys.inc.h"
+#include "exec/memory_ldst_phys.h.inc"
 
 /* address_space_cache_init: prepare for repeated access to a physical
  * memory region
diff --git a/include/exec/memory_ldst.inc.h b/include/exec/memory_ldst.h.inc
similarity index 100%
rename from include/exec/memory_ldst.inc.h
rename to include/exec/memory_ldst.h.inc
diff --git a/include/exec/memory_ldst_cached.inc.h b/include/exec/memory_ldst_cached.h.inc
similarity index 100%
rename from include/exec/memory_ldst_cached.inc.h
rename to include/exec/memory_ldst_cached.h.inc
diff --git a/include/exec/memory_ldst_phys.inc.h b/include/exec/memory_ldst_phys.h.inc
similarity index 100%
rename from include/exec/memory_ldst_phys.inc.h
rename to include/exec/memory_ldst_phys.h.inc
diff --git a/target/s390x/cpu_features.c b/target/s390x/cpu_features.c
index 9f817e3cfa..31ea8df246 100644
--- a/target/s390x/cpu_features.c
+++ b/target/s390x/cpu_features.c
@@ -23,7 +23,7 @@
         .desc = _DESC,                             \
     },
 static const S390FeatDef s390_features[S390_FEAT_MAX] = {
-    #include "cpu_features_def.inc.h"
+    #include "cpu_features_def.h.inc"
 };
 #undef DEF_FEAT
 
diff --git a/target/s390x/cpu_features_def.h b/target/s390x/cpu_features_def.h
index 412d356feb..87df31848e 100644
--- a/target/s390x/cpu_features_def.h
+++ b/target/s390x/cpu_features_def.h
@@ -17,7 +17,7 @@
 
 #define DEF_FEAT(_FEAT, ...) S390_FEAT_##_FEAT,
 typedef enum {
-    #include "cpu_features_def.inc.h"
+    #include "cpu_features_def.h.inc"
     S390_FEAT_MAX,
 } S390Feat;
 #undef DEF_FEAT
diff --git a/target/s390x/cpu_features_def.inc.h b/target/s390x/cpu_features_def.h.inc
similarity index 100%
rename from target/s390x/cpu_features_def.inc.h
rename to target/s390x/cpu_features_def.h.inc
-- 
2.26.2



