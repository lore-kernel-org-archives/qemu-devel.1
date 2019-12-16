Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B88D8C43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 11:34:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8520E206D3
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 11:34:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eM1NDcBw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8520E206D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igodk-00065i-2S
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 06:34:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51262)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1igoG0-000890-EM
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:09:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1igoFx-0000DF-Rd
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:09:44 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:51243)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1igoFt-0000A4-I0
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:09:41 -0500
Received: by mail-wm1-x329.google.com with SMTP id d73so6266309wmd.1
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 03:09:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=/CNrVYrs9Xb73quEvVQlotZn9+L6OMMxXMmjH1TgHyY=;
 b=eM1NDcBw9oJUjoVFac6Tj0t84Zx7Xxgb8vhlYl/VhVaiNv2nfHfUT1cXrNxBJj+Gd0
 oY33juOn90bnQSxPDldb8WXVYR9S0J6z6s5pNlNysHUF+nBhteVLNTtkB4e+WqbiTGhX
 rWGZTMNes40QbntG9+iF/zQUa9MPZB4IyUQDwlJVRdlEXhpcM7bfYYyI7hfSyyJ31gQD
 2xmPHckCm85yvdKCacZtwOzNKlsj0jDG1ylOc0NzAeZEowZSvliUcg1cJq8vi4WOh9k3
 CGd6/XRExq4mMHFY1VQXdGSrL2mnOrM3qS//9I/dtY1G0TtKXJOLULBYaof3pS0zXE8s
 itrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/CNrVYrs9Xb73quEvVQlotZn9+L6OMMxXMmjH1TgHyY=;
 b=GIq6jTyrdDISx3myhraffJm14lN9IELT4WXM7be4q3Bt6d5WiHF4PffygXMEj/IsTw
 B4fnjnyyWZTeu9MdDdEac/pWiXGRcheO1vobdS3hFEWNhoaob5L3NXNq3q72xI6VFvc3
 dK7KTbLN/G9db4RfVwZ1uAgBQdcPZR6iIybKM7QqMnPhD+x0gJPzWAzktfbizviUebkK
 GTF6fHX1BjvvTmQGrOpMCw6M2eVsalGXUGfd49RDkWHwnu8dictWHUDDT8VHvGTFQbvI
 xpsFssF8mESSCN4I8Dl2lHXMycIXjVVkzRtYJAaEuOBAT5arVvNmpRnkZGpwo/cYIij0
 K8jg==
X-Gm-Message-State: APjAAAWwB2nDaTIPkHf8Dd6s47SrY+ekwyNEEXB48QJFCVVXC9C0Jmw8
 mzm82820n4rJvH66vXQ50OlEx5wlQ6URSg==
X-Google-Smtp-Source: APXvYqyNKOMknb9FV1RJ72RVijfeqqYZSwsVQJ28MjPnjIAluO43Tx573pgtWSgimXBpODX2VYJt+A==
X-Received: by 2002:a7b:c4cc:: with SMTP id g12mr30628286wmk.68.1576494576144; 
 Mon, 16 Dec 2019 03:09:36 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id x10sm20976131wrp.58.2019.12.16.03.09.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2019 03:09:35 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 27/34] Memory: Enable writeback for given memory region
Date: Mon, 16 Dec 2019 11:08:57 +0000
Message-Id: <20191216110904.30815-28-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191216110904.30815-1-peter.maydell@linaro.org>
References: <20191216110904.30815-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::329
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

From: Beata Michalska <beata.michalska@linaro.org>

Add an option to trigger memory writeback to sync given memory region
with the corresponding backing store, case one is available.
This extends the support for persistent memory, allowing syncing on-demand.

Signed-off-by: Beata Michalska <beata.michalska@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20191121000843.24844-3-beata.michalska@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/exec/memory.h   |  6 ++++++
 include/exec/ram_addr.h |  8 ++++++++
 include/qemu/cutils.h   |  1 +
 exec.c                  | 36 ++++++++++++++++++++++++++++++++++++
 memory.c                | 12 ++++++++++++
 util/cutils.c           | 38 ++++++++++++++++++++++++++++++++++++++
 6 files changed, 101 insertions(+)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index e499dc215b3..27a84e0cc34 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -1265,6 +1265,12 @@ void *memory_region_get_ram_ptr(MemoryRegion *mr);
  */
 void memory_region_ram_resize(MemoryRegion *mr, ram_addr_t newsize,
                               Error **errp);
+/**
+ * memory_region_do_writeback: Trigger writeback for selected address range
+ * [addr, addr + size]
+ *
+ */
+void memory_region_do_writeback(MemoryRegion *mr, hwaddr addr, hwaddr size);
 
 /**
  * memory_region_set_log: Turn dirty logging on or off for a region.
diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
index bed0554f4d2..5adebb0bc7c 100644
--- a/include/exec/ram_addr.h
+++ b/include/exec/ram_addr.h
@@ -174,6 +174,14 @@ void qemu_ram_free(RAMBlock *block);
 
 int qemu_ram_resize(RAMBlock *block, ram_addr_t newsize, Error **errp);
 
+void qemu_ram_writeback(RAMBlock *block, ram_addr_t start, ram_addr_t length);
+
+/* Clear whole block of mem */
+static inline void qemu_ram_block_writeback(RAMBlock *block)
+{
+    qemu_ram_writeback(block, 0, block->used_length);
+}
+
 #define DIRTY_CLIENTS_ALL     ((1 << DIRTY_MEMORY_NUM) - 1)
 #define DIRTY_CLIENTS_NOCODE  (DIRTY_CLIENTS_ALL & ~(1 << DIRTY_MEMORY_CODE))
 
diff --git a/include/qemu/cutils.h b/include/qemu/cutils.h
index b54c847e0fe..eb59852dfdf 100644
--- a/include/qemu/cutils.h
+++ b/include/qemu/cutils.h
@@ -130,6 +130,7 @@ const char *qemu_strchrnul(const char *s, int c);
 #endif
 time_t mktimegm(struct tm *tm);
 int qemu_fdatasync(int fd);
+int qemu_msync(void *addr, size_t length, int fd);
 int fcntl_setfl(int fd, int flag);
 int qemu_parse_fd(const char *param);
 int qemu_strtoi(const char *nptr, const char **endptr, int base,
diff --git a/exec.c b/exec.c
index ffdb5185353..a34c3481840 100644
--- a/exec.c
+++ b/exec.c
@@ -65,6 +65,8 @@
 #include "exec/ram_addr.h"
 #include "exec/log.h"
 
+#include "qemu/pmem.h"
+
 #include "migration/vmstate.h"
 
 #include "qemu/range.h"
@@ -2156,6 +2158,40 @@ int qemu_ram_resize(RAMBlock *block, ram_addr_t newsize, Error **errp)
     return 0;
 }
 
+/*
+ * Trigger sync on the given ram block for range [start, start + length]
+ * with the backing store if one is available.
+ * Otherwise no-op.
+ * @Note: this is supposed to be a synchronous op.
+ */
+void qemu_ram_writeback(RAMBlock *block, ram_addr_t start, ram_addr_t length)
+{
+    void *addr = ramblock_ptr(block, start);
+
+    /* The requested range should fit in within the block range */
+    g_assert((start + length) <= block->used_length);
+
+#ifdef CONFIG_LIBPMEM
+    /* The lack of support for pmem should not block the sync */
+    if (ramblock_is_pmem(block)) {
+        pmem_persist(addr, length);
+        return;
+    }
+#endif
+    if (block->fd >= 0) {
+        /**
+         * Case there is no support for PMEM or the memory has not been
+         * specified as persistent (or is not one) - use the msync.
+         * Less optimal but still achieves the same goal
+         */
+        if (qemu_msync(addr, length, block->fd)) {
+            warn_report("%s: failed to sync memory range: start: "
+                    RAM_ADDR_FMT " length: " RAM_ADDR_FMT,
+                    __func__, start, length);
+        }
+    }
+}
+
 /* Called with ram_list.mutex held */
 static void dirty_memory_extend(ram_addr_t old_ram_size,
                                 ram_addr_t new_ram_size)
diff --git a/memory.c b/memory.c
index 06484c2bff2..0228cad38d0 100644
--- a/memory.c
+++ b/memory.c
@@ -2207,6 +2207,18 @@ void memory_region_ram_resize(MemoryRegion *mr, ram_addr_t newsize, Error **errp
     qemu_ram_resize(mr->ram_block, newsize, errp);
 }
 
+
+void memory_region_do_writeback(MemoryRegion *mr, hwaddr addr, hwaddr size)
+{
+    /*
+     * Might be extended case needed to cover
+     * different types of memory regions
+     */
+    if (mr->ram_block && mr->dirty_log_mask) {
+        qemu_ram_writeback(mr->ram_block, addr, size);
+    }
+}
+
 /*
  * Call proper memory listeners about the change on the newly
  * added/removed CoalescedMemoryRange.
diff --git a/util/cutils.c b/util/cutils.c
index 77acadc70ac..23801652303 100644
--- a/util/cutils.c
+++ b/util/cutils.c
@@ -164,6 +164,44 @@ int qemu_fdatasync(int fd)
 #endif
 }
 
+/**
+ * Sync changes made to the memory mapped file back to the backing
+ * storage. For POSIX compliant systems this will fallback
+ * to regular msync call. Otherwise it will trigger whole file sync
+ * (including the metadata case there is no support to skip that otherwise)
+ *
+ * @addr   - start of the memory area to be synced
+ * @length - length of the are to be synced
+ * @fd     - file descriptor for the file to be synced
+ *           (mandatory only for POSIX non-compliant systems)
+ */
+int qemu_msync(void *addr, size_t length, int fd)
+{
+#ifdef CONFIG_POSIX
+    size_t align_mask = ~(qemu_real_host_page_size - 1);
+
+    /**
+     * There are no strict reqs as per the length of mapping
+     * to be synced. Still the length needs to follow the address
+     * alignment changes. Additionally - round the size to the multiple
+     * of PAGE_SIZE
+     */
+    length += ((uintptr_t)addr & (qemu_real_host_page_size - 1));
+    length = (length + ~align_mask) & align_mask;
+
+    addr = (void *)((uintptr_t)addr & align_mask);
+
+    return msync(addr, length, MS_SYNC);
+#else /* CONFIG_POSIX */
+    /**
+     * Perform the sync based on the file descriptor
+     * The sync range will most probably be wider than the one
+     * requested - but it will still get the job done
+     */
+    return qemu_fdatasync(fd);
+#endif /* CONFIG_POSIX */
+}
+
 #ifndef _WIN32
 /* Sets a specific flag */
 int fcntl_setfl(int fd, int flag)
-- 
2.20.1


