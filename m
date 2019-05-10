Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 535E0C04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 15:40:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B1CE2175B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 15:40:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="joA0AKXM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B1CE2175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45252 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP7dA-0001TN-3L
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 11:40:16 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56141)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hP7Ja-0007ZR-UZ
	for qemu-devel@nongnu.org; Fri, 10 May 2019 11:20:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hP7JZ-0008TR-UA
	for qemu-devel@nongnu.org; Fri, 10 May 2019 11:20:02 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:33570)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hP7JZ-0008T0-OK
	for qemu-devel@nongnu.org; Fri, 10 May 2019 11:20:01 -0400
Received: by mail-pl1-x642.google.com with SMTP id y3so2996738plp.0
	for <qemu-devel@nongnu.org>; Fri, 10 May 2019 08:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=ZTH91pjxahUuQtOu1GsBhTY4d5CvJ+Jx8ktGJV35Xwc=;
	b=joA0AKXMyY3BQHcLx+GIcFgwz5GAZXfeA6hScCTEGYm+l8g/J3oJ/9zSx4nkGZhpNP
	VMwK5+W80PXW/S5ibRy8IsqlAhRkXqiIJpdg62esSFrhEh4A2i3WnT8dmSg7XXxd1+bD
	RzRYknUv8/4TW/bJ0Mc84KniF17SsHKY0BuE0OI54cEkYrrMQo7bRrAOtG8xbv6kEzjW
	VrLTDb9VS2l17s3Gm+P35XC6xLzDAswPgLTxkEat1EgWdltbEHr2RVAUehQKHjkPUq61
	gng319gUdWUGrPkGtLaMN0a/Oef/AxSGXZ3cx/KrUPNssnnCkS5dnmITL77q18WiNH3P
	HXAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=ZTH91pjxahUuQtOu1GsBhTY4d5CvJ+Jx8ktGJV35Xwc=;
	b=Zp9D8pGgkoXZJaRp/y7lixzK58AT8C5j8/uiCo6PaZ4Po7qu02XIJD1K6vPO+zPPe6
	wHFDTv3svmuexvvpyiGbMqlDLlMXUnaAkYPrxzHF38oYmQ6Z9gXQoUJfDnDACReoJJR8
	Ox5uIo0iKA4rp9Q1FPA2haraCjV5ApJ3grzRvlH6s0KMJB+/Y5r2AjXqxA4u1C+7ViIb
	759MT0THBLYtINmrYOTXLXhtwcGxsz34Tc3dPrphSvPnvLEDhLKIOvUlyyMlCumi2p2N
	8uMhi7EXop8qC5AcUdQeorjEEjaw3ECBwv04PhROFDTybpmO8JFVNy7RV75A1n6RGp0W
	7E5A==
X-Gm-Message-State: APjAAAVzjGNUTYs4zETs19e0BvWvo4R7QBj8k1qFe3+bd09MAaPM2N0a
	lnTNftYVyS1Pm+0L4cbYHhgZ+6SikZU=
X-Google-Smtp-Source: APXvYqxcmPKsQZu2RE9oM1IBIoXwq7JfTPjP+7/Bcbro2GhiTPUQ2IkF8fohSU5y/kf8uGNLFaADfw==
X-Received: by 2002:a17:902:7883:: with SMTP id
	q3mr13718857pll.60.1557501600552; 
	Fri, 10 May 2019 08:20:00 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231])
	by smtp.gmail.com with ESMTPSA id 19sm5920517pgz.24.2019.05.10.08.19.59
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 10 May 2019 08:19:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 10 May 2019 08:19:28 -0700
Message-Id: <20190510151944.22981-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190510151944.22981-1-richard.henderson@linaro.org>
References: <20190510151944.22981-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::642
Subject: [Qemu-devel] [PULL 11/27] target/mips: Tidy control flow in
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since the only non-negative TLBRET_* value is TLBRET_MATCH,
the subsequent test for ret < 0 is useless.  Use early return
to allow subsequent blocks to be unindented.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
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


