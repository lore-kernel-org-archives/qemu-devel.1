Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF783C04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 22:38:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 774DE21744
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 22:38:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jly0vXlb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 774DE21744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33589 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOrg1-00012m-Lh
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 18:38:09 -0400
Received: from eggs.gnu.org ([209.51.188.92]:32967)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOrV4-0007gz-12
	for qemu-devel@nongnu.org; Thu, 09 May 2019 18:26:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOrV3-0005Tn-1W
	for qemu-devel@nongnu.org; Thu, 09 May 2019 18:26:50 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:44541)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hOrV2-0005Tc-SF
	for qemu-devel@nongnu.org; Thu, 09 May 2019 18:26:48 -0400
Received: by mail-pg1-x542.google.com with SMTP id z16so1911988pgv.11
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 15:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=ZTH91pjxahUuQtOu1GsBhTY4d5CvJ+Jx8ktGJV35Xwc=;
	b=jly0vXlbBuquNpT6dXPh+FN3uq0/7K1FJmQH0+R8quBHx1OTzckS1blXc4YX/vcxPF
	fF0TUDOiBZcNFZaG6LMQVAVDghzFMnUSv9nsiGm0JdOGuNp2llFzl3WkhST2DgEoohaF
	s8umaHYI0UPob0NwUkyKe+CM0cOwKGg82UZ/AA8zkNr2oJ+lCd0CdhN9ObN8FopS0oR8
	SmRAVh1uXHGWEPD2PAL7k1t5PSJXJbml/SZFvBAYYIjUcEHWtNj8P6c+dcwaHxdJqORD
	5WZ/t8BtrggpdSO00JlAr9ZKOk7EN/SpwoaiYV7HzWHK5UwuUvDbbp8a7l4fxlZ+q3UJ
	OkEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=ZTH91pjxahUuQtOu1GsBhTY4d5CvJ+Jx8ktGJV35Xwc=;
	b=WHBvc6odtoPlRAIwa5nNzrT4/XI7yvNgG24Ip4DaiF40bK9Ji9ut5DDnCMkV3fjP/Z
	uQDPimKlJiTO+Z+ZgCSRFBs+Eni662pIwQfk9F0on9VKPgSuy2bM7HvwdX3XsTFchyo8
	nD/Qj/q8fBlReqjzle5otLe3FmcVRMpEDeg10mQYVWvQu4CslQmZBm5opMfbdxpS8oFJ
	8X3gN8ZMQpG6OXpZctGjvLMVF0UbUOELXff1J2V9ftCCa00miq6EPQQx5a7X68rDrEfK
	tw/mtGCFbf+DtrUICOkrKb2xRM6PMmx+P9q3OrRV3bgYnQkO5jiCPB+jKJIMl2YJM8ls
	ZoGw==
X-Gm-Message-State: APjAAAVB7y/ippPwaUpqiXq4TWgBCh9Db4002fou9XYGOHBWVL+SF8LB
	j4IPP76jrZrFCFSTL/0IOQmMpRprkMw=
X-Google-Smtp-Source: APXvYqz8Ke3Ojh1/ycgD+ObrBfDug46QZes2y0yiknL7pPUlmP//ENsH+qZbusfJ7h1vtqQDcfwNTg==
X-Received: by 2002:a62:3381:: with SMTP id z123mr9242587pfz.42.1557440807632; 
	Thu, 09 May 2019 15:26:47 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231])
	by smtp.gmail.com with ESMTPSA id m2sm4490521pfi.24.2019.05.09.15.26.46
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 09 May 2019 15:26:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu,  9 May 2019 15:26:15 -0700
Message-Id: <20190509222631.14271-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190509222631.14271-1-richard.henderson@linaro.org>
References: <20190509222631.14271-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::542
Subject: [Qemu-devel] [PATCH v3 11/27] target/mips: Tidy control flow in
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


