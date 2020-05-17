Return-Path: <SRS0=EQsI=67=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2D83C433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2020 16:50:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69A6B20674
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2020 16:50:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UT1o6FLe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69A6B20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaMUZ-0007LQ-HP
	for qemu-devel@archiver.kernel.org; Sun, 17 May 2020 12:50:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56608)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jaMSe-0004sM-Av
 for qemu-devel@nongnu.org; Sun, 17 May 2020 12:48:24 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:40497)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jaMSd-0005HW-JS
 for qemu-devel@nongnu.org; Sun, 17 May 2020 12:48:24 -0400
Received: by mail-wr1-x442.google.com with SMTP id e16so9018700wra.7
 for <qemu-devel@nongnu.org>; Sun, 17 May 2020 09:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=WSFyr6f19aP4N4MMJJARifgNu7cVe5tnytMgFa4vhLY=;
 b=UT1o6FLei9qlcG76bYpsBJuPrt6ali5KqjJzqRDXUmn2WjfJUbgxClrFtWHj91XEUy
 pD3pzoITte0xz6pcRZvgZtiJF9O7zukGAJ2itL7KjS6bxb11vMFa5a8LASMP6UZ6E5s/
 2tp+ZMjVGDv0DZjuRhXsGxZXgNI/evWk7e4xI75DxB5J+tAtAHyNb+finXFqhY/4v2Im
 wciozO51Qq7MddEsllHWyqs0BDm4NjRyxI3EfDkQ2VZDWIhVFL0UXmLK4bxsbSarjkvc
 q6Si3KPqirSDlPtgewlX00f1+IifBbCquOWGyEKYudnpSAK/KtJBKLQjQBox826cFWTC
 9dXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=WSFyr6f19aP4N4MMJJARifgNu7cVe5tnytMgFa4vhLY=;
 b=BPXlhY23n9mMCELwteQqlNEA2cOUsyyKJ/BJu7qhDye+3y5+EdDPfY6DftGiJzxvsk
 IRBLXeaxvVRZ5NKfkruSwWpmKu+auMRrD7M6MAA+d5ocug6SGNGDUKrZVPZW6Vc4obgH
 TZezxGT7gGYR0vYgxfLKC0fiwN5hgoufa8MDZGnsyCJeuVjcqhPrMpfc+lPNZ7rJHd65
 6rqROxLIHQAWScRoimPV3DoKPFO3nMU3fsdK9CD1m/lKag0NgU4S041D2mr3bdeUuXlu
 Vv+Rr3so28ZwwuqgoJsTA6fd4WgoTRMudmfMoFP+5Vjn3qWhOgePm+6q12I+T3ZSrfVX
 m6yw==
X-Gm-Message-State: AOAM531tpXygJzfFydkC7T0sqGSnUz70bYSxmux/OYhnKrzY2ZREm7sl
 MFfRRYy/dw+q9sWgc2g+gqDv0xXR+Rg=
X-Google-Smtp-Source: ABdhPJyGFdANutwPQmAOLxx0Sir10l0caiJki0HJzOE9hOPo2ido+3IF0P8oN/ICDp5i16KYx4dy8w==
X-Received: by 2002:adf:b30f:: with SMTP id j15mr16175825wrd.394.1589734101902; 
 Sun, 17 May 2020 09:48:21 -0700 (PDT)
Received: from localhost.localdomain (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id o15sm10430850wrw.65.2020.05.17.09.48.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 May 2020 09:48:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] exec/memory: Let address_space_read/write_cached()
 propagate MemTxResult
Date: Sun, 17 May 2020 18:48:16 +0200
Message-Id: <20200517164817.5371-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200517164817.5371-1-f4bug@amsat.org>
References: <20200517164817.5371-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Li Zhijian <lizhijian@cn.fujitsu.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Peter Xu <peterx@redhat.com>, Tony Nguyen <tony.nguyen@bt.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Both address_space_read_cached_slow() and
address_space_write_cached_slow() return a MemTxResult type.
Do not discard it, return it to the caller.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/exec/memory.h | 19 +++++++++++--------
 exec.c                | 16 ++++++++--------
 2 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index e000bd2f97..5e8c009169 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -2343,10 +2343,11 @@ void *qemu_map_ram_ptr(RAMBlock *ram_block, ram_addr_t addr);
 
 /* Internal functions, part of the implementation of address_space_read_cached
  * and address_space_write_cached.  */
-void address_space_read_cached_slow(MemoryRegionCache *cache,
-                                    hwaddr addr, void *buf, hwaddr len);
-void address_space_write_cached_slow(MemoryRegionCache *cache,
-                                     hwaddr addr, const void *buf, hwaddr len);
+MemTxResult address_space_read_cached_slow(MemoryRegionCache *cache,
+                                           hwaddr addr, void *buf, hwaddr len);
+MemTxResult address_space_write_cached_slow(MemoryRegionCache *cache,
+                                            hwaddr addr, const void *buf,
+                                            hwaddr len);
 
 static inline bool memory_access_is_direct(MemoryRegion *mr, bool is_write)
 {
@@ -2411,15 +2412,16 @@ MemTxResult address_space_read(AddressSpace *as, hwaddr addr,
  * @buf: buffer with the data transferred
  * @len: length of the data transferred
  */
-static inline void
+static inline MemTxResult
 address_space_read_cached(MemoryRegionCache *cache, hwaddr addr,
                           void *buf, hwaddr len)
 {
     assert(addr < cache->len && len <= cache->len - addr);
     if (likely(cache->ptr)) {
         memcpy(buf, cache->ptr + addr, len);
+        return MEMTX_OK;
     } else {
-        address_space_read_cached_slow(cache, addr, buf, len);
+        return address_space_read_cached_slow(cache, addr, buf, len);
     }
 }
 
@@ -2431,15 +2433,16 @@ address_space_read_cached(MemoryRegionCache *cache, hwaddr addr,
  * @buf: buffer with the data transferred
  * @len: length of the data transferred
  */
-static inline void
+static inline MemTxResult
 address_space_write_cached(MemoryRegionCache *cache, hwaddr addr,
                            const void *buf, hwaddr len)
 {
     assert(addr < cache->len && len <= cache->len - addr);
     if (likely(cache->ptr)) {
         memcpy(cache->ptr + addr, buf, len);
+        return MEMTX_OK;
     } else {
-        address_space_write_cached_slow(cache, addr, buf, len);
+        return address_space_write_cached_slow(cache, addr, buf, len);
     }
 }
 
diff --git a/exec.c b/exec.c
index 5162f0d12f..877b51cc5c 100644
--- a/exec.c
+++ b/exec.c
@@ -3716,7 +3716,7 @@ static inline MemoryRegion *address_space_translate_cached(
 /* Called from RCU critical section. address_space_read_cached uses this
  * out of line function when the target is an MMIO or IOMMU region.
  */
-void
+MemTxResult
 address_space_read_cached_slow(MemoryRegionCache *cache, hwaddr addr,
                                    void *buf, hwaddr len)
 {
@@ -3726,15 +3726,15 @@ address_space_read_cached_slow(MemoryRegionCache *cache, hwaddr addr,
     l = len;
     mr = address_space_translate_cached(cache, addr, &addr1, &l, false,
                                         MEMTXATTRS_UNSPECIFIED);
-    flatview_read_continue(cache->fv,
-                           addr, MEMTXATTRS_UNSPECIFIED, buf, len,
-                           addr1, l, mr);
+    return flatview_read_continue(cache->fv,
+                                  addr, MEMTXATTRS_UNSPECIFIED, buf, len,
+                                  addr1, l, mr);
 }
 
 /* Called from RCU critical section. address_space_write_cached uses this
  * out of line function when the target is an MMIO or IOMMU region.
  */
-void
+MemTxResult
 address_space_write_cached_slow(MemoryRegionCache *cache, hwaddr addr,
                                     const void *buf, hwaddr len)
 {
@@ -3744,9 +3744,9 @@ address_space_write_cached_slow(MemoryRegionCache *cache, hwaddr addr,
     l = len;
     mr = address_space_translate_cached(cache, addr, &addr1, &l, true,
                                         MEMTXATTRS_UNSPECIFIED);
-    flatview_write_continue(cache->fv,
-                            addr, MEMTXATTRS_UNSPECIFIED, buf, len,
-                            addr1, l, mr);
+    return flatview_write_continue(cache->fv,
+                                   addr, MEMTXATTRS_UNSPECIFIED, buf, len,
+                                   addr1, l, mr);
 }
 
 #define ARG1_DECL                MemoryRegionCache *cache
-- 
2.21.3


