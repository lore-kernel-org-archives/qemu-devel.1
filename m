Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE99C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 09:58:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C36920872
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 09:58:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TIUC3Oap"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C36920872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7cua-0001RG-Du
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 05:58:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50807)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <beata.michalska@linaro.org>) id 1i7ct2-0008PV-6z
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 05:56:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <beata.michalska@linaro.org>) id 1i7ct0-0002YZ-LS
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 05:56:36 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:44193)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <beata.michalska@linaro.org>)
 id 1i7ct0-0002Xu-El
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 05:56:34 -0400
Received: by mail-wr1-x444.google.com with SMTP id k6so6705762wrn.11
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 02:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=RoTSf3FoUt1H5Iax7flIjVdUuQGEjtJhhUG2AX/tyZA=;
 b=TIUC3OapXpTIMyBTSXw88+5YYYiuOjpw1waPasSA4fHt+r/TNJVMo/TuA2CdVgkGWK
 vheZBRtKoBDwua/BvD0AXMts6HZn5fs+U0+yFUegR1CqEPuZO41/LC6830ZXnD9mjedF
 MoTa7yhdTLSGRS9lTlop/AE9gqJ1g2zO1otBYUj1iM/kkqioQBEGN6MJaj8aPkJ5turp
 r/OMIwJ+te7+zrDX2/9yArr6p9ah+olPSIgLCl/UL1Z1c2Tly+WOYgGKzubHW6V1Cswy
 6/979aoGNH/eQzQdCO65TmZnNVc9GOymVLZU++aUhbSLwSTgj0EOl8lblSF6DyewzLP1
 /cXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=RoTSf3FoUt1H5Iax7flIjVdUuQGEjtJhhUG2AX/tyZA=;
 b=Rp8vyTlNhF8cbF/fKtCLWAc8mw3ZxBnka31RkJGbDucAULZh8e1Ycus9JufiLSo4k6
 WAWqvXFxKiK/EYWB3+x02rSlTg/Ei2aTwejfKgLT33J1aJYR05hKiixhFNvfEid1uvwb
 zCQ2pd2q0SeF1Lk/VPS39UdhfV4mfz+p786BMLW2Mrew/jmP0pl3lYXCBN4ny0d4/4UG
 VCVBzRxDKdAfpcIHyQh+BmhfRUqBsW8CmdYRSvNUyICd0R0rwX+O5dLp+SrS39fnEMKx
 tCyUKqRNLmpdeUKLavwU363MgUpclzf6lovIBIhnozgDrcxkL5Rs1gTOdJ8Vk9+k7HHW
 lNPA==
X-Gm-Message-State: APjAAAV1ao5IShZGn5WMw3mjInzax4gV/LLEkRaDa4CDazdO2ABGsxM8
 8FujVDf3LWQmZ59wxlxx8Qg24L9UnjPGJQ==
X-Google-Smtp-Source: APXvYqxgl61O7oVO/OotBN0CpMCtL2QHMBFHRdRDVtFlrcquprLroTVuH8pD9V6Qky9cqAemRAuC8A==
X-Received: by 2002:adf:dd0b:: with SMTP id a11mr26928177wrm.42.1568109393331; 
 Tue, 10 Sep 2019 02:56:33 -0700 (PDT)
Received: from moi-XPS-13-9350.arm.com
 (host86-144-13-57.range86-144.btcentralplus.com. [86.144.13.57])
 by smtp.gmail.com with ESMTPSA id e30sm32403540wra.48.2019.09.10.02.56.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2019 02:56:32 -0700 (PDT)
From: Beata Michalska <beata.michalska@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue, 10 Sep 2019 11:56:08 +0200
Message-Id: <20190910095610.4546-3-beata.michalska@linaro.org>
In-Reply-To: <20190910095610.4546-1-beata.michalska@linaro.org>
References: <20190910095610.4546-1-beata.michalska@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: [Qemu-devel] [PATCH 2/4] Memory: Enable writeback for given memory
 region
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
Cc: peter.maydell@linaro.org, Beata Michalska <beata.michalska@linaro.org>,
 quintela@redhat.com, richard.henderson@linaro.org, dgilbert@redhat.com,
 shameerali.kolothum.thodi@huawei.com, eric.auger@redhat.com,
 qemu-arm@nongnu.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add an option to trigger memory writeback to sync given memory region
with the corresponding backing store, case one is available.
This extends the support for persistent memory, allowing syncing on-demand.

Also, adding verification for msync support on host.

Signed-off-by: Beata Michalska <beata.michalska@linaro.org>
---
 configure               | 24 ++++++++++++++++++++++++
 exec.c                  | 38 ++++++++++++++++++++++++++++++++++++++
 include/exec/memory.h   |  6 ++++++
 include/exec/ram_addr.h |  6 ++++++
 memory.c                | 12 ++++++++++++
 5 files changed, 86 insertions(+)

diff --git a/configure b/configure
index 95134c0180..bdb7dc47e9 100755
--- a/configure
+++ b/configure
@@ -5081,6 +5081,26 @@ if compile_prog "" "" ; then
     fdatasync=yes
 fi
 
+##########################################
+# verify support for msyc
+
+msync=no
+cat > $TMPC << EOF
+#include <unistd.h>
+#include <sys/mman.h>
+int main(void) {
+#if defined(_POSIX_MAPPED_FILES) && _POSIX_MAPPED_FILES > 0 \
+&& defined(_POSIX_SYNCHRONIZED_IO) && _POSIX_SYNCHRONIZED_IO > 0
+return msync(NULL,0, MS_SYNC);
+#else
+#error Not supported
+#endif
+}
+EOF
+if compile_prog "" "" ; then
+    msync=yes
+fi
+
 ##########################################
 # check if we have madvise
 
@@ -6413,6 +6433,7 @@ echo "fdt support       $fdt"
 echo "membarrier        $membarrier"
 echo "preadv support    $preadv"
 echo "fdatasync         $fdatasync"
+echo "msync             $msync"
 echo "madvise           $madvise"
 echo "posix_madvise     $posix_madvise"
 echo "posix_memalign    $posix_memalign"
@@ -6952,6 +6973,9 @@ fi
 if test "$fdatasync" = "yes" ; then
   echo "CONFIG_FDATASYNC=y" >> $config_host_mak
 fi
+if test "$msync" = "yes" ; then
+    echo "CONFIG_MSYNC=y" >> $config_host_mak
+fi
 if test "$madvise" = "yes" ; then
   echo "CONFIG_MADVISE=y" >> $config_host_mak
 fi
diff --git a/exec.c b/exec.c
index 235d6bc883..5ed6908368 100644
--- a/exec.c
+++ b/exec.c
@@ -65,6 +65,8 @@
 #include "exec/ram_addr.h"
 #include "exec/log.h"
 
+#include "qemu/pmem.h"
+
 #include "migration/vmstate.h"
 
 #include "qemu/range.h"
@@ -2182,6 +2184,42 @@ int qemu_ram_resize(RAMBlock *block, ram_addr_t newsize, Error **errp)
     return 0;
 }
 
+/*
+ * Trigger sync on the given ram block for range [start, start + length]
+ * with the backing store if available.
+ * @Note: this is supposed to be a SYNC op.
+ */
+void qemu_ram_writeback(RAMBlock *block, ram_addr_t start, ram_addr_t length)
+{
+    void *addr = ramblock_ptr(block, start);
+
+    /*
+     * The requested range might spread up to the very end of the block
+     */
+    if ((start + length) > block->used_length) {
+        error_report("%s: sync range outside the block boundires: "
+                     "start: " RAM_ADDR_FMT " length: " RAM_ADDR_FMT
+                     " block length: " RAM_ADDR_FMT " Narrowing down ..." ,
+                     __func__, start, length, block->used_length);
+        length = block->used_length - start;
+    }
+
+#ifdef CONFIG_LIBPMEM
+    /* The lack of support for pmem should not block the sync */
+    if (ramblock_is_pmem(block)) {
+        pmem_persist(addr, length);
+    } else
+#endif
+    if (block->fd >= 0) {
+#ifdef CONFIG_MSYNC
+        msync((void *)((uintptr_t)addr & qemu_host_page_mask),
+               HOST_PAGE_ALIGN(length), MS_SYNC);
+#else
+        qemu_fdatasync(block->fd);
+#endif
+    }
+}
+
 /* Called with ram_list.mutex held */
 static void dirty_memory_extend(ram_addr_t old_ram_size,
                                 ram_addr_t new_ram_size)
diff --git a/include/exec/memory.h b/include/exec/memory.h
index 2dd810259d..ff0d7937cf 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -1242,6 +1242,12 @@ void *memory_region_get_ram_ptr(MemoryRegion *mr);
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
index a327a80cfe..d4bce81a03 100644
--- a/include/exec/ram_addr.h
+++ b/include/exec/ram_addr.h
@@ -180,6 +180,12 @@ void qemu_ram_free(RAMBlock *block);
 
 int qemu_ram_resize(RAMBlock *block, ram_addr_t newsize, Error **errp);
 
+void qemu_ram_writeback(RAMBlock *block, ram_addr_t start, ram_addr_t length);
+
+/* Clear whole block of mem */
+#define qemu_ram_block_writeback(rb)    \
+    qemu_ram_writeback(rb, 0, rb->used_length)
+
 #define DIRTY_CLIENTS_ALL     ((1 << DIRTY_MEMORY_NUM) - 1)
 #define DIRTY_CLIENTS_NOCODE  (DIRTY_CLIENTS_ALL & ~(1 << DIRTY_MEMORY_CODE))
 
diff --git a/memory.c b/memory.c
index 61a254c3f9..436eb64737 100644
--- a/memory.c
+++ b/memory.c
@@ -2228,6 +2228,18 @@ void memory_region_ram_resize(MemoryRegion *mr, ram_addr_t newsize, Error **errp
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
-- 
2.17.1


