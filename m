Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 524E5C5B578
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 01:40:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AD29206A2
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 01:40:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="djeXwqZE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AD29206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hi7mB-0002XR-Cd
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 21:40:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46993)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hi3xE-0000N7-AF
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 17:35:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hi3xC-0002CR-Bh
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 17:35:16 -0400
Received: from mail-wr1-f44.google.com ([209.85.221.44]:39806)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hi3xB-0001ud-Vk
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 17:35:14 -0400
Received: by mail-wr1-f44.google.com with SMTP id x4so15381532wrt.6
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2019 14:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=xrdtLDaUXsZEoNM0lxPRwqv5cfPxmVrBimeKTadrMYw=;
 b=djeXwqZEQVv8z9nIyOZo04/p+tStRMiTYhs1Yclq/nqPQNFbky0dukE2VILEWn+vog
 5hKPhInK5Jd8k/NTnSQyJIVBq4u+v0wFnwwKXQPzshUVS8xjzkkTsMEB6M08q8HRRvfn
 8aGC3dNuIwp+J95jjM5cWBZnQ/7+MO7vK0SIJdDiU5guKbvJO9tTxJH3I9OhjdYO6MGe
 7AUkJSz6Wn+JDUhuscqCOasGAPyYULdAe8DlCcq5HEmgL8dj4RciWZL4NEMbHOLWUsAP
 NUShKVGCdjui+muUlAgyP71RW30CxzI4Okpix21ZKT9e6dPeLt31E+8lUl5DKusIIVRA
 SEFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=xrdtLDaUXsZEoNM0lxPRwqv5cfPxmVrBimeKTadrMYw=;
 b=M43AYaqgQadmQDeQvawhKp42M3J6G59P1r0a7dzp9J+qJCM0t6JNkKDu863wdIMp7Y
 oaINYorWfeOCYO7IGy5uh52Uq6essTp+xB1Wv0Wj2/2LB3UDcim0kSoLrNDhW3BTaWyt
 z9X9Q+Gq0rwB/TgFNAjNHI/azu8j9Ka3p4uxrG3u3QmQlZN+BNy/J7YJnqT/3OPQLPaw
 1/xsOKfgaR7ZAmNHacqJp9CFBLT2w4CfE2A7p/6ECTbuINWMkcepqm2JI21yGv9Xre9H
 ofCDSAw2uccXs2RCIc09zaNTy5OxoW7kymYc/aIxGhk4z+B91Fk4OM6XD5hiU073yvvF
 K7mA==
X-Gm-Message-State: APjAAAWJd2XOutprC1Ji5CZyIfYKilhF8VGeARDWdGv50/KWyv+9DCUP
 QdB/mdv58wywGhA4Z5X7y+mpUOjjr1sZCA==
X-Google-Smtp-Source: APXvYqyQtivOVjwgWQWt0iPRN1tzAVHEk54hlL1Y6uFuMP0PKQ8ZQOZmvWlLZrQKS2YisNF9ICXqnA==
X-Received: by 2002:adf:d4c1:: with SMTP id w1mr13032251wrk.229.1561999228119; 
 Mon, 01 Jul 2019 09:40:28 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id o6sm26573508wra.27.2019.07.01.09.40.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 01 Jul 2019 09:40:27 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon,  1 Jul 2019 17:39:35 +0100
Message-Id: <20190701163943.22313-39-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190701163943.22313-1-peter.maydell@linaro.org>
References: <20190701163943.22313-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.44
Subject: [Qemu-devel] [PULL 38/46] target/arm: Declare get_phys_addr()
 function publicly
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

From: Philippe Mathieu-Daudé <philmd@redhat.com>

In the next commit we will split the TLB related routines of
this file, and this function will also be called in the new
file. Declare it in the "internals.h" header.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20190701132516.26392-12-philmd@redhat.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/internals.h | 16 ++++++++++++++++
 target/arm/helper.c    | 21 +++++----------------
 2 files changed, 21 insertions(+), 16 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 5a02f458f39..ff5ab0328e8 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -985,4 +985,20 @@ static inline int exception_target_el(CPUARMState *env)
     return target_el;
 }
 
+#ifndef CONFIG_USER_ONLY
+
+/* Cacheability and shareability attributes for a memory access */
+typedef struct ARMCacheAttrs {
+    unsigned int attrs:8; /* as in the MAIR register encoding */
+    unsigned int shareability:2; /* as in the SH field of the VMSAv8-64 PTEs */
+} ARMCacheAttrs;
+
+bool get_phys_addr(CPUARMState *env, target_ulong address,
+                   MMUAccessType access_type, ARMMMUIdx mmu_idx,
+                   hwaddr *phys_ptr, MemTxAttrs *attrs, int *prot,
+                   target_ulong *page_size,
+                   ARMMMUFaultInfo *fi, ARMCacheAttrs *cacheattrs);
+
+#endif /* !CONFIG_USER_ONLY */
+
 #endif
diff --git a/target/arm/helper.c b/target/arm/helper.c
index a87fda91914..063f4778e0a 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -33,17 +33,6 @@
 #define ARM_CPU_FREQ 1000000000 /* FIXME: 1 GHz, should be configurable */
 
 #ifndef CONFIG_USER_ONLY
-/* Cacheability and shareability attributes for a memory access */
-typedef struct ARMCacheAttrs {
-    unsigned int attrs:8; /* as in the MAIR register encoding */
-    unsigned int shareability:2; /* as in the SH field of the VMSAv8-64 PTEs */
-} ARMCacheAttrs;
-
-static bool get_phys_addr(CPUARMState *env, target_ulong address,
-                          MMUAccessType access_type, ARMMMUIdx mmu_idx,
-                          hwaddr *phys_ptr, MemTxAttrs *attrs, int *prot,
-                          target_ulong *page_size,
-                          ARMMMUFaultInfo *fi, ARMCacheAttrs *cacheattrs);
 
 static bool get_phys_addr_lpae(CPUARMState *env, target_ulong address,
                                MMUAccessType access_type, ARMMMUIdx mmu_idx,
@@ -12639,11 +12628,11 @@ static ARMCacheAttrs combine_cacheattrs(ARMCacheAttrs s1, ARMCacheAttrs s2)
  * @fi: set to fault info if the translation fails
  * @cacheattrs: (if non-NULL) set to the cacheability/shareability attributes
  */
-static bool get_phys_addr(CPUARMState *env, target_ulong address,
-                          MMUAccessType access_type, ARMMMUIdx mmu_idx,
-                          hwaddr *phys_ptr, MemTxAttrs *attrs, int *prot,
-                          target_ulong *page_size,
-                          ARMMMUFaultInfo *fi, ARMCacheAttrs *cacheattrs)
+bool get_phys_addr(CPUARMState *env, target_ulong address,
+                   MMUAccessType access_type, ARMMMUIdx mmu_idx,
+                   hwaddr *phys_ptr, MemTxAttrs *attrs, int *prot,
+                   target_ulong *page_size,
+                   ARMMMUFaultInfo *fi, ARMCacheAttrs *cacheattrs)
 {
     if (mmu_idx == ARMMMUIdx_S12NSE0 || mmu_idx == ARMMMUIdx_S12NSE1) {
         /* Call ourselves recursively to do the stage 1 and then stage 2
-- 
2.20.1


