Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB64AC04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 06:14:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9196B208C3
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 06:14:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o+3m03ix"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9196B208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48715 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOcK1-000833-Ni
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 02:14:25 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44885)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOc92-00061i-Q6
	for qemu-devel@nongnu.org; Thu, 09 May 2019 02:03:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOc91-00077G-MH
	for qemu-devel@nongnu.org; Thu, 09 May 2019 02:03:04 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:38102)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hOc91-00076p-GP
	for qemu-devel@nongnu.org; Thu, 09 May 2019 02:03:03 -0400
Received: by mail-pf1-x442.google.com with SMTP id 10so723256pfo.5
	for <qemu-devel@nongnu.org>; Wed, 08 May 2019 23:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=vY/1YWeEiK60/Q+L95+DZT+hkMZr8zCGLmiutwycPpc=;
	b=o+3m03ixkbB8mIanAIrhVRs+VAyQr4NdM0g1yiyIBKgtXaS3AxZ4Viz2GRMIbD+lT/
	wAP1yJj/YD0DB+M77jVPpbsRbwh7OMWBrfcQRDGGkCRC95uSzaf0kmnwSzKXxYa/+9IV
	UBotNJmhAYTl1ePWmlRA4bpVtzNDzbM8bLse640uo0TOI7evkhCnQUC45IBKfRV8FSRA
	ZCnvOn9Tq1uMrql5IkTwcLEQB8GKiCIQj0Nk0rI8NNgdVR8vNoLvWLiORLQTPtPV4G3B
	nNySL9aWvlfjSA8ZxMfh9jICI3YKWnI0uQ9LzEfC0Sn9RrWGVJztwTnIZ/VZz/FBDN0M
	8lTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=vY/1YWeEiK60/Q+L95+DZT+hkMZr8zCGLmiutwycPpc=;
	b=qrrbaIkI9il1rmpgUINtF6PeiMTxVV2sIyQV5aQr3a6WspjjNtJGaGoZDPbVVM/uAh
	o7cvaZWQ2wx9PvepqZohS/fWw8WiUGVsrZn/gIUTYk57yXwjglcjLxQ0XK/HqtTnJ++B
	Hnc1zOwhTb6p0p1VOhqRonEDZli5yBsR2Pok2TzHROtHVZJqlrytA0pdt6CfuAWT2fhx
	BMHIXAmYnr/RRguXeYhEm2M7Z6WC7wM25r/1bg13e38GWhP81XtiQaxywkd2XJOm6+1I
	4PraXQGMTAYng4g1qzTUiFrGd2H29NZ6rFEpwGR0ykuDovYlpGvzBMwZJjO87Ow9PeJc
	gN3Q==
X-Gm-Message-State: APjAAAWbcnFU0s9CI9MT5utdeb4KAhiP1Kj9a+8gfMtZUC/AWF7QnJ5Q
	dEZDzw1s34yJFJrzfhFDQpb1wslgmr8=
X-Google-Smtp-Source: APXvYqx0nXm0YdJ7HxJOXau2slAGoIMXqUxO45dSYveyCsRgsh5WS15IpGKZsbWJIr7buCQr726aNg==
X-Received: by 2002:a62:56d9:: with SMTP id h86mr2635124pfj.195.1557381782299; 
	Wed, 08 May 2019 23:03:02 -0700 (PDT)
Received: from localhost.localdomain (97-113-27-95.tukw.qwest.net.
	[97.113.27.95])
	by smtp.gmail.com with ESMTPSA id n7sm1496109pff.45.2019.05.08.23.03.00
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 08 May 2019 23:03:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed,  8 May 2019 23:02:30 -0700
Message-Id: <20190509060246.4031-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190509060246.4031-1-richard.henderson@linaro.org>
References: <20190509060246.4031-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: [Qemu-devel] [PATCH v2 11/27] target/mips: Tidy control flow in
 mips_cpu_handle_mmu_fault
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since the only non-negative TLBRET_* value is TLBRET_MATCH,
the subsequent test for ret < 0 is useless.  Use early return
to allow subsequent blocks to be unindented.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/mips/helper.c | 54 ++++++++++++++++++++------------------------
 1 file changed, 24 insertions(+), 30 deletions(-)

diff --git a/target/mips/helper.c b/target/mips/helper.c
index cc7be7703a..86e622efb8 100644
--- a/target/mips/helper.c
+++ b/target/mips/helper.c
@@ -915,41 +915,35 @@ int mips_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size, int rw,
         tlb_set_page(cs, address & TARGET_PAGE_MASK,
                      physical & TARGET_PAGE_MASK, prot | PAGE_EXEC,
                      mmu_idx, TARGET_PAGE_SIZE);
-        ret = 0;
-    } else if (ret < 0)
-#endif
-    {
-#if !defined(CONFIG_USER_ONLY)
+        return 0;
+    }
 #if !defined(TARGET_MIPS64)
-        if ((ret == TLBRET_NOMATCH) && (env->tlb->nb_tlb > 1)) {
-            /*
-             * Memory reads during hardware page table walking are performed
-             * as if they were kernel-mode load instructions.
-             */
-            int mode = (env->hflags & MIPS_HFLAG_KSU);
-            bool ret_walker;
-            env->hflags &= ~MIPS_HFLAG_KSU;
-            ret_walker = page_table_walk_refill(env, address, rw, mmu_idx);
-            env->hflags |= mode;
-            if (ret_walker) {
-                ret = get_physical_address(env, &physical, &prot,
-                                           address, rw, access_type, mmu_idx);
-                if (ret == TLBRET_MATCH) {
-                    tlb_set_page(cs, address & TARGET_PAGE_MASK,
-                            physical & TARGET_PAGE_MASK, prot | PAGE_EXEC,
-                            mmu_idx, TARGET_PAGE_SIZE);
-                    ret = 0;
-                    return ret;
-                }
+    if ((ret == TLBRET_NOMATCH) && (env->tlb->nb_tlb > 1)) {
+        /*
+         * Memory reads during hardware page table walking are performed
+         * as if they were kernel-mode load instructions.
+         */
+        int mode = (env->hflags & MIPS_HFLAG_KSU);
+        bool ret_walker;
+        env->hflags &= ~MIPS_HFLAG_KSU;
+        ret_walker = page_table_walk_refill(env, address, rw, mmu_idx);
+        env->hflags |= mode;
+        if (ret_walker) {
+            ret = get_physical_address(env, &physical, &prot,
+                                       address, rw, access_type, mmu_idx);
+            if (ret == TLBRET_MATCH) {
+                tlb_set_page(cs, address & TARGET_PAGE_MASK,
+                             physical & TARGET_PAGE_MASK, prot | PAGE_EXEC,
+                             mmu_idx, TARGET_PAGE_SIZE);
+                return 0;
             }
         }
-#endif
-#endif
-        raise_mmu_exception(env, address, rw, ret);
-        ret = 1;
     }
+#endif
+#endif
 
-    return ret;
+    raise_mmu_exception(env, address, rw, ret);
+    return 1;
 }
 
 #if !defined(CONFIG_USER_ONLY)
-- 
2.17.1


