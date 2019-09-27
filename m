Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0547C4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 19:55:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7899E21A4A
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 19:55:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CJg7JnWI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7899E21A4A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDwKg-0002Sz-96
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 15:55:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46646)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iDw5q-0003PK-9M
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 15:39:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iDw5m-0006Tr-Mc
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 15:39:53 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:37121)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iDw5l-0006S0-OK
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 15:39:50 -0400
Received: by mail-pg1-x541.google.com with SMTP id c17so4018769pgg.4
 for <qemu-devel@nongnu.org>; Fri, 27 Sep 2019 12:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=qj0g/zRgOiSEpMHPGaPSUxN7m4nHw3kwz18pUXG2uUM=;
 b=CJg7JnWIhNVoShk6MsAe8LCPCoHm4beqWO3oG3HlQnt17f75trH+ZwCNpUEzCYrokK
 6iHTtRxdOqXkUJeRSYpooCPlOti9ME8YLxkOPXP5p3FqTzOmVgBH0sbUqPsOv3ceuvH8
 VsLV31AVHbcALvpHi1T4Oyqp+gEN0PB18dm+MWw+RLy1cTXQeL3yhMh0Ei+BeH+veMsu
 WFa/QghcENqWIluPrLQ89/jUtRR4fWvNGSk9YH5jlbGu7JxF7IirLNZEW48UXhhU0Vbw
 asj6XfAiuMO/xdagkTFznLWlvlIsnX/SmymG6BivSiO6JI1E/7fpvwPg/ggQ+ORMoKbd
 1IbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=qj0g/zRgOiSEpMHPGaPSUxN7m4nHw3kwz18pUXG2uUM=;
 b=SfZya3OgyeBIVYPWakGCWTMyLIaGXo3rlomOGk6MruDcp5fS6ivmxfiuanyDn7KMqG
 JsIqL9yJdtP0ONPda7yT+0cXB90dXX9bM1sPwgIYMooCKMu4eVHqeCQnjMQgwbDJPtg9
 rw17uPbr8jwesCn8RxRDYPdoRcdIhliSahuxWUqJK1tMgNa1vI7tAhkQfLOEnVEQ7ZET
 1ed9F9uqitJBuuWQ9oql7ZKVOd9fwNgmQ2UFs6GIkLtpKYj/Vl3xivXocz/DOIkaVFzx
 o7GzjhwTQx3KlnJxb8Rg7arMINRgIozir5MygRA9nnmgxN61QKUdUTxymww+Fgai8qZ3
 2Z5Q==
X-Gm-Message-State: APjAAAXqVl8fTmSrJEb4N75any1uSKdnlXSozsV6r6DlFTqAkaydLInr
 GdzS75Zb3+8KNiVsGvT4ep8R9w1MLQg=
X-Google-Smtp-Source: APXvYqxoHQr6aXDQE0XLdYjy5bmg5TGx98j6IWRBs0ofjmLu4KYoXlGCYroAw8oxr8m9cDFNkZKTZg==
X-Received: by 2002:a63:cf0a:: with SMTP id j10mr10818410pgg.388.1569613187487; 
 Fri, 27 Sep 2019 12:39:47 -0700 (PDT)
Received: from localhost.localdomain ([12.206.46.62])
 by smtp.gmail.com with ESMTPSA id 192sm3676403pfb.110.2019.09.27.12.39.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Sep 2019 12:39:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 10/18] target/s390x: Return exception from translate_pages
Date: Fri, 27 Sep 2019 12:39:17 -0700
Message-Id: <20190927193925.23567-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190927193925.23567-1-richard.henderson@linaro.org>
References: <20190927193925.23567-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
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
Cc: qemu-s390x@nongnu.org, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Do not raise the exception directly within translate_pages,
but pass it back so that caller may do so.

Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/mmu_helper.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/target/s390x/mmu_helper.c b/target/s390x/mmu_helper.c
index 8ea1c95549..98ac58574c 100644
--- a/target/s390x/mmu_helper.c
+++ b/target/s390x/mmu_helper.c
@@ -452,25 +452,22 @@ nodat:
  * the MEMOP interface.
  */
 static int translate_pages(S390CPU *cpu, vaddr addr, int nr_pages,
-                           target_ulong *pages, bool is_write)
+                           target_ulong *pages, bool is_write, uint64_t *tec)
 {
     uint64_t asc = cpu->env.psw.mask & PSW_MASK_ASC;
     CPUS390XState *env = &cpu->env;
     int ret, i, pflags;
 
     for (i = 0; i < nr_pages; i++) {
-        uint64_t tec;
-
-        ret = mmu_translate(env, addr, is_write, asc, &pages[i], &pflags, &tec);
+        ret = mmu_translate(env, addr, is_write, asc, &pages[i], &pflags, tec);
         if (ret) {
-            trigger_access_exception(env, ret, ILEN_AUTO, tec);
-            return -EFAULT;
+            return ret;
         }
         if (!address_space_access_valid(&address_space_memory, pages[i],
                                         TARGET_PAGE_SIZE, is_write,
                                         MEMTXATTRS_UNSPECIFIED)) {
-            trigger_access_exception(env, PGM_ADDRESSING, ILEN_AUTO, 0);
-            return -EFAULT;
+            *tec = 0; /* unused */
+            return PGM_ADDRESSING;
         }
         addr += TARGET_PAGE_SIZE;
     }
@@ -498,6 +495,7 @@ int s390_cpu_virt_mem_rw(S390CPU *cpu, vaddr laddr, uint8_t ar, void *hostbuf,
 {
     int currlen, nr_pages, i;
     target_ulong *pages;
+    uint64_t tec;
     int ret;
 
     if (kvm_enabled()) {
@@ -511,8 +509,10 @@ int s390_cpu_virt_mem_rw(S390CPU *cpu, vaddr laddr, uint8_t ar, void *hostbuf,
                + 1;
     pages = g_malloc(nr_pages * sizeof(*pages));
 
-    ret = translate_pages(cpu, laddr, nr_pages, pages, is_write);
-    if (ret == 0 && hostbuf != NULL) {
+    ret = translate_pages(cpu, laddr, nr_pages, pages, is_write, &tec);
+    if (ret) {
+        trigger_access_exception(&cpu->env, ret, ILEN_AUTO, tec);
+    } else if (hostbuf != NULL) {
         /* Copy data by stepping through the area page by page */
         for (i = 0; i < nr_pages; i++) {
             currlen = MIN(len, TARGET_PAGE_SIZE - (laddr % TARGET_PAGE_SIZE));
-- 
2.17.1


