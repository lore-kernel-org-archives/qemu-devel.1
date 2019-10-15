Return-Path: <SRS0=6OCO=YI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FB67ECE588
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 17:05:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E2E320872
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 17:05:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MrbNyQOK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E2E320872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKQFu-0005fi-9L
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 13:05:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42526)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iKPn0-0008D7-2p
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 12:35:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iKPmy-0000FL-IW
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 12:35:13 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:43984)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iKPmy-0000En-D0
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 12:35:12 -0400
Received: by mail-pg1-x541.google.com with SMTP id i32so12452809pgl.10
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2019 09:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=nG2MQUfKXLXTBAN0GTjwypjxy4v62hiX+t+7N4V/tlY=;
 b=MrbNyQOKu0lRjuiepV3ZsvSOZGjrtd509OrA78NZwrwagWfY44Q93qQx22mlumQChc
 ygPKc1ayqwLOJeb6j1N8MKiBPs6uyw6d2Gt7BgZddiGRv9NK0jZGut6x8qmKBj9GzOGd
 s1AyVKVKkq+OvpDGO2AcQEu0Y3djUISPshXeRv2CE2ECn2FMDZ4dR5fPLNx4JGKHylVI
 Mui1PANaVM112wNdj28XwE9oHVhbbTYv+9tNQRkm0IVdD8bNA7GhrdzHNF8euB7y7Sa6
 w6qskEMoadlUN6PXLcYELh0Jm2ZRbnyA6QCEXUwhjCBz6ajpGuPxTTIAQF/zTxWawXsl
 yutg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=nG2MQUfKXLXTBAN0GTjwypjxy4v62hiX+t+7N4V/tlY=;
 b=raizETIkRbmyzcS8nYg9/3iSd/tiWUW1bn2mUJvECN5C1w23oIJyLcuc8RfRD3OGn3
 b8/CPo9LSuw30Qb92976uoNMrd20mLst2CdZgloQBfpwOmt64NH3ShOWyf0avasAKwmA
 nzzeSSz2UX0oo32btFIw/ABr1z7PWZNjyhgUJWuiVq2jcFXa7i5xqeol6ysjbaRO4m1a
 rEodTyfspmfg/78puJJLswhE0fXY48/UfyGOkX37r/ozse6XBYTHDfv2NorF4l5P/cTC
 olvkRF4ckWJXFMk+TEJP7gM1/cR7ljY10XWZscJJ7RdgGlvBNSfxP1JWaPd/OGHPA7pj
 2R6Q==
X-Gm-Message-State: APjAAAU8z1w8s+rVEHvjxBdztgxoMgZrXXt+dIpw0pJBLW0DtQ+AndRw
 l8SiTYpvGA7Pw0I9xc9Pf/djALnWnuE=
X-Google-Smtp-Source: APXvYqzLlth/hZYOqANGKo7z1xa9prQJnxBb81m4tcTqlPl6wTTHcknhwUEi89cDnnbS3RlYiaYC5w==
X-Received: by 2002:a65:5345:: with SMTP id w5mr31566979pgr.213.1571157310835; 
 Tue, 15 Oct 2019 09:35:10 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id m22sm22011593pgj.29.2019.10.15.09.35.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2019 09:35:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 1/3] tcg: Introduce target-specific page data for user-only
Date: Tue, 15 Oct 2019 09:35:05 -0700
Message-Id: <20191015163507.12153-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191015163507.12153-1-richard.henderson@linaro.org>
References: <20191015163507.12153-1-richard.henderson@linaro.org>
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
Cc: elver@google.com, icb@rice.edu, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

At the same time, remember MAP_SHARED as PAGE_SHARED.  When mapping
new pages, make sure that old target-specific page data is removed.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu-all.h    | 10 ++++++++--
 accel/tcg/translate-all.c | 28 ++++++++++++++++++++++++++++
 linux-user/mmap.c         |  8 +++++++-
 linux-user/syscall.c      |  4 ++--
 4 files changed, 45 insertions(+), 5 deletions(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index d23ced1d12..034773e319 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -243,10 +243,14 @@ extern intptr_t qemu_host_page_mask;
 #define PAGE_WRITE_ORG 0x0010
 /* Invalidate the TLB entry immediately, helpful for s390x
  * Low-Address-Protection. Used with PAGE_WRITE in tlb_set_page_with_attrs() */
-#define PAGE_WRITE_INV 0x0040
+#define PAGE_WRITE_INV 0x0020
+/* Page is mapped shared.  */
+#define PAGE_SHARED    0x0040
+/* For use with page_set_flags: page is being replaced; target_data cleared. */
+#define PAGE_RESET     0x0080
 #if defined(CONFIG_BSD) && defined(CONFIG_USER_ONLY)
 /* FIXME: Code that sets/uses this is broken and needs to go away.  */
-#define PAGE_RESERVED  0x0020
+#define PAGE_RESERVED  0x0100
 #endif
 /* Target-specific bits that will be used via page_get_flags().  */
 #define PAGE_TARGET_1  0x0080
@@ -261,6 +265,8 @@ int walk_memory_regions(void *, walk_memory_regions_fn);
 int page_get_flags(target_ulong address);
 void page_set_flags(target_ulong start, target_ulong end, int flags);
 int page_check_range(target_ulong start, target_ulong len, int flags);
+void *page_get_target_data(target_ulong address);
+void *page_alloc_target_data(target_ulong address, size_t size);
 #endif
 
 CPUArchState *cpu_copy(CPUArchState *env);
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 66d4bc4341..dbf08b55e2 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -110,6 +110,7 @@ typedef struct PageDesc {
     unsigned int code_write_count;
 #else
     unsigned long flags;
+    void *target_data;
 #endif
 #ifndef CONFIG_USER_ONLY
     QemuSpin lock;
@@ -2513,6 +2514,7 @@ int page_get_flags(target_ulong address)
 void page_set_flags(target_ulong start, target_ulong end, int flags)
 {
     target_ulong addr, len;
+    bool reset_target_data;
 
     /* This function should never be called with addresses outside the
        guest address space.  If this assert fires, it probably indicates
@@ -2529,6 +2531,8 @@ void page_set_flags(target_ulong start, target_ulong end, int flags)
     if (flags & PAGE_WRITE) {
         flags |= PAGE_WRITE_ORG;
     }
+    reset_target_data = !(flags & PAGE_VALID) || (flags & PAGE_RESET);
+    flags &= ~PAGE_RESET;
 
     for (addr = start, len = end - start;
          len != 0;
@@ -2542,10 +2546,34 @@ void page_set_flags(target_ulong start, target_ulong end, int flags)
             p->first_tb) {
             tb_invalidate_phys_page(addr, 0);
         }
+        if (reset_target_data && p->target_data) {
+            g_free(p->target_data);
+            p->target_data = NULL;
+        }
         p->flags = flags;
     }
 }
 
+void *page_get_target_data(target_ulong address)
+{
+    PageDesc *p = page_find(address >> TARGET_PAGE_BITS);
+    return p ? p->target_data : NULL;
+}
+
+void *page_alloc_target_data(target_ulong address, size_t size)
+{
+    PageDesc *p = page_find(address >> TARGET_PAGE_BITS);
+    void *ret = NULL;
+
+    if (p) {
+        ret = p->target_data;
+        if (!ret && (p->flags & PAGE_VALID)) {
+            p->target_data = ret = g_malloc0(size);
+        }
+    }
+    return ret;
+}
+
 int page_check_range(target_ulong start, target_ulong len, int flags)
 {
     PageDesc *p;
diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index c1bed290f6..75e0355ff7 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -626,6 +626,10 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
         }
     }
  the_end1:
+    if ((flags & MAP_TYPE) == MAP_SHARED) {
+        page_flags |= PAGE_SHARED;
+    }
+    page_flags |= PAGE_RESET;
     page_set_flags(start, start + len, page_flags);
  the_end:
 #ifdef DEBUG_MMAP
@@ -818,9 +822,11 @@ abi_long target_mremap(abi_ulong old_addr, abi_ulong old_size,
         new_addr = -1;
     } else {
         new_addr = h2g(host_addr);
+        /* FIXME: Move page flags (and target_data?) for each page.  */
         prot = page_get_flags(old_addr);
         page_set_flags(old_addr, old_addr + old_size, 0);
-        page_set_flags(new_addr, new_addr + new_size, prot | PAGE_VALID);
+        page_set_flags(new_addr, new_addr + new_size,
+                       prot | PAGE_VALID | PAGE_RESET);
     }
     tb_invalidate_phys_range(new_addr, new_addr + new_size);
     mmap_unlock();
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index e2af3c1494..52f50eca4b 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -4061,8 +4061,8 @@ static inline abi_ulong do_shmat(CPUArchState *cpu_env,
     raddr=h2g((unsigned long)host_raddr);
 
     page_set_flags(raddr, raddr + shm_info.shm_segsz,
-                   PAGE_VALID | PAGE_READ |
-                   ((shmflg & SHM_RDONLY)? 0 : PAGE_WRITE));
+                   PAGE_VALID | PAGE_SHARED | PAGE_RESET | PAGE_READ |
+                   (shmflg & SHM_RDONLY ? 0 : PAGE_WRITE));
 
     for (i = 0; i < N_SHM_REGIONS; i++) {
         if (!shm_regions[i].in_use) {
-- 
2.17.1


