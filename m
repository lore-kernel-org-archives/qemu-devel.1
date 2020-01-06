Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8CAFC33C9E
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 18:32:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85D6A2072E
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 18:32:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ir10aGHi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85D6A2072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioXBO-00036F-1Z
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 13:32:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45119)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <danielhb413@gmail.com>) id 1ioX3q-0001el-Nh
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 13:25:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <danielhb413@gmail.com>) id 1ioX3p-0003nI-87
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 13:25:06 -0500
Received: from mail-qv1-xf43.google.com ([2607:f8b0:4864:20::f43]:33219)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <danielhb413@gmail.com>)
 id 1ioX3p-0003n4-3a; Mon, 06 Jan 2020 13:25:05 -0500
Received: by mail-qv1-xf43.google.com with SMTP id z3so19445708qvn.0;
 Mon, 06 Jan 2020 10:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=eY6GwOKUsSxbSiC0sEZUPgTqkPSXyaF2//XptsTcqg0=;
 b=Ir10aGHisUato561BZTbYR+T9sXZkJZa09fi7GWiq733xHdB0qdupgf6KGp2/jlp72
 9liT2tk+YwLFfMuybNo72GaPvgAK70rwojOb2rBHSiLquEVIYZ404wx8/NWW9Kj0qMR1
 DkyB9UexOsa5+H11jhW4kYgvjimYr2O9EYdfEQp2bM3W08jAJgnF21yC3x/SEqTARsi7
 3Xor9+ML05wbwttIZSIZ6OIdKpEnX7HFyFSBcTDx+plwF4R4apt8Jg+hVXUEt5zQVhq9
 LGYTVvXLm8YRjrCa1ksHW9676g+sv59z+e1W/3g9YjAKVd6nwkoAcB0JCMRAkyeaAy3i
 exeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=eY6GwOKUsSxbSiC0sEZUPgTqkPSXyaF2//XptsTcqg0=;
 b=nV9P8rFlBwJ0JUrVPa4mfcKB+RnysB5oon7rRGKRL+5ggkboCqFCZJVwmnj/yaMjnV
 wCjjaZJymlOZaDUc9Qeagf5qhDg1Yk+eB1jULDw4n29ZEgaT1ugqB/qCKp82PqjnbvYd
 gHMdHjFlXXd1l5gbaW+/XwOhCFDnCOT5VXxpidQkY31St5ZBWY4Me2O0meVSBpJULSXo
 eOkrJ9RipyiQmBL0bbO4QtYRyoydNZo/SU8CopQ+rhsaatQKzIb/kPW98wXzmiQjr033
 QWAYXS76+6lbq8uLPtdBVwLQb7UyjyEf+Z4tlW6kusC3v0Pw9Y87i/n5aENTkYdKOUFP
 q7YQ==
X-Gm-Message-State: APjAAAW4xq10+H7O0mlandP7wwrjiozRI5q8vhY41fCz4Dsj+ztpKnUT
 oeoLpSZNOErDYLwPEMlJCGGjXsXo
X-Google-Smtp-Source: APXvYqy1QFUQeLXKMDt2TJuYG88b704qBzioKoASnhKiJguwt1zbK+ohgbdq9BwNC8spt6Uq6hNRDw==
X-Received: by 2002:a0c:c542:: with SMTP id y2mr6110998qvi.225.1578335104537; 
 Mon, 06 Jan 2020 10:25:04 -0800 (PST)
Received: from rekt.ibmuc.com ([2804:431:c7c6:655b:9e1c:e865:3705:e1df])
 by smtp.gmail.com with ESMTPSA id b81sm21026522qkc.135.2020.01.06.10.25.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2020 10:25:04 -0800 (PST)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 07/59] unicore32/softmmu.c: remove 'do_fault' label in
 get_phys_addr_ucv2()
Date: Mon,  6 Jan 2020 15:23:33 -0300
Message-Id: <20200106182425.20312-8-danielhb413@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200106182425.20312-1-danielhb413@gmail.com>
References: <20200106182425.20312-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::f43
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
Cc: qemu-trivial@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 Guan Xuetao <gxt@mprc.pku.edu.cn>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

'do_fault' is a label that executes 'return code'. The 'code'
variable is an integer that is set to zero, then in all instances
it is set to another value right before 'do_fault'.

We can get rid of both the label and the variable to make
the code a bit cleaner.

CC: Guan Xuetao <gxt@mprc.pku.edu.cn>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 target/unicore32/softmmu.c | 23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/target/unicore32/softmmu.c b/target/unicore32/softmmu.c
index cbdaa500b7..3373400cba 100644
--- a/target/unicore32/softmmu.c
+++ b/target/unicore32/softmmu.c
@@ -125,7 +125,6 @@ static int get_phys_addr_ucv2(CPUUniCore32State *env, uint32_t address,
         target_ulong *page_size)
 {
     CPUState *cs = env_cpu(env);
-    int code;
     uint32_t table;
     uint32_t desc;
     uint32_t phys_addr;
@@ -135,13 +134,11 @@ static int get_phys_addr_ucv2(CPUUniCore32State *env, uint32_t address,
     table = env->cp0.c2_base & 0xfffff000;
     table |= (address >> 20) & 0xffc;
     desc = ldl_phys(cs->as, table);
-    code = 0;
     switch (PAGETABLE_TYPE(desc)) {
     case 3:
         /* Superpage  */
         if (!(desc & UC32_PAGETABLE_EXIST)) {
-            code = 0x0b; /* superpage miss */
-            goto do_fault;
+            return 0x0b; /* superpage miss */
         }
         phys_addr = (desc & 0xffc00000) | (address & 0x003fffff);
         *page_size = SUPERPAGE_SIZE;
@@ -152,8 +149,7 @@ static int get_phys_addr_ucv2(CPUUniCore32State *env, uint32_t address,
             DPRINTF("PGD address %x, desc %x\n", table, desc);
         }
         if (!(desc & UC32_PAGETABLE_EXIST)) {
-            code = 0x05; /* second pagetable miss */
-            goto do_fault;
+            return 0x05; /* second pagetable miss */
         }
         table = (desc & 0xfffff000) | ((address >> 10) & 0xffc);
         desc = ldl_phys(cs->as, table);
@@ -162,8 +158,7 @@ static int get_phys_addr_ucv2(CPUUniCore32State *env, uint32_t address,
             DPRINTF("PTE address %x, desc %x\n", table, desc);
         }
         if (!(desc & UC32_PAGETABLE_EXIST)) {
-            code = 0x08; /* page miss */
-            goto do_fault;
+            return 0x08; /* page miss */
         }
         switch (PAGETABLE_TYPE(desc)) {
         case 0:
@@ -185,8 +180,7 @@ static int get_phys_addr_ucv2(CPUUniCore32State *env, uint32_t address,
         *prot |= PAGE_READ;
     } else {
         if (is_user && (access_type == 0)) {
-            code = 0x11; /* access unreadable area */
-            goto do_fault;
+            return 0x11; /* access unreadable area */
         }
     }
 
@@ -194,8 +188,7 @@ static int get_phys_addr_ucv2(CPUUniCore32State *env, uint32_t address,
         *prot |= PAGE_WRITE;
     } else {
         if (is_user && (access_type == 1)) {
-            code = 0x12; /* access unwritable area */
-            goto do_fault;
+            return 0x12; /* access unwritable area */
         }
     }
 
@@ -203,13 +196,11 @@ static int get_phys_addr_ucv2(CPUUniCore32State *env, uint32_t address,
         *prot |= PAGE_EXEC;
     } else {
         if (is_user && (access_type == 2)) {
-            code = 0x13; /* access unexecutable area */
-            goto do_fault;
+            return 0x13; /* access unexecutable area */
         }
     }
 
-do_fault:
-    return code;
+    return 0;
 }
 
 bool uc32_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
-- 
2.24.1


