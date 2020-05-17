Return-Path: <SRS0=EQsI=67=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 598B9C433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2020 16:51:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EE6F20674
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2020 16:51:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GUU/i3Mp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EE6F20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaMVr-0000i1-AX
	for qemu-devel@archiver.kernel.org; Sun, 17 May 2020 12:51:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56614)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jaMSg-0004wa-5H
 for qemu-devel@nongnu.org; Sun, 17 May 2020 12:48:26 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:36601)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jaMSf-0005Hd-Af
 for qemu-devel@nongnu.org; Sun, 17 May 2020 12:48:25 -0400
Received: by mail-wm1-x343.google.com with SMTP id u188so7703574wmu.1
 for <qemu-devel@nongnu.org>; Sun, 17 May 2020 09:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wqvkP7hBd0qvNzQ7dvdtdyC9QFe/20kKIVV38CfyUS4=;
 b=GUU/i3Mp0NWrChcbFFDe/PDkfkxcgGbQb5B+W53oeu3/vmys/pHnrH5uRIwgfqy3X4
 04GL4EaXi9pyhjVoUPtfQiubL56+vCNjWP8u0gmm4cMPNVEkJhf3W+B8l44h5uCrcjMu
 RpaazYUKtGFpJ8FT8jGrST5MyjyoX7MEYyCbbG+aciuTJiUpUkeHhaJx9jGDBxB4toT0
 foG0aaqbQ1eZuPs8lwYiElD7P8Nvt59WD+B4tIW/PSP8kzRV/7EXaMh+W2ZDuxypwiOi
 mHCihTcuu3Q5DWaR0cByur6bjVjMJKSLEZ07VnLy+M80rgBzLLq5bqusYCv3KTZaoUdS
 XVpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=wqvkP7hBd0qvNzQ7dvdtdyC9QFe/20kKIVV38CfyUS4=;
 b=sRPz5sVAGP89/fHNHFiy9qNFJRjQngJJMOyztpBJxP+HfASqyzm8yLURIfBiW7BLxb
 UsqBI5YrpbscJrpNef8cnhnFp9CYVcRmeDCVObphNN3FOAnt8QVB1cmHxxWCK0A9T+8j
 f4D2Qm/45VdwGEfo6UitEr+rSyCsq3E+RmOXbNa2NeQnT9C4S+RSKkn54EzfQsm8h9aw
 FraSLkULK0ybVez6UJuUq+kgASl2HzbSyDhVvgIXSMHFiDEDkAfvg7y8/T81Pw/I08PS
 SzPiAMGbKT07iOtMiniRZJ6zcF4juJpyI8J3wm63uWbojjIcNlpL625/q9WaBr1rXdu5
 1huA==
X-Gm-Message-State: AOAM531N0Kuvbh43eMLXgUg0Gby1o++RkwSNay+4acr+OB8oNz+S96Jy
 VnZqUX5eJVxyha4mZiwvMclr2OIPar4=
X-Google-Smtp-Source: ABdhPJxWosc3icSYP0MMsyhiM9KF79iNmK3MPK6OUJEADu7/Fa0JayRae0o0BkBLfSpsxwVGtUqWJg==
X-Received: by 2002:a1c:a557:: with SMTP id o84mr15379723wme.165.1589734103631; 
 Sun, 17 May 2020 09:48:23 -0700 (PDT)
Received: from localhost.localdomain (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id o15sm10430850wrw.65.2020.05.17.09.48.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 May 2020 09:48:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 2/2] exec/memory: Emit warning when MemTxResult is ignored
Date: Sun, 17 May 2020 18:48:17 +0200
Message-Id: <20200517164817.5371-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200517164817.5371-1-f4bug@amsat.org>
References: <20200517164817.5371-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
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

When a function from the memory subsystem return a MemTxResult
to indicate that the transaction failed, this return value
must not be ignored by the caller. Mark all these functions
with the QEMU_WARN_UNUSED_RESULT attribute, to prevent users
to ignore possible failed transactions.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
RFC because it doesn't build. But before going thru each caller,
let's talk on the list if this change makes sense.
---
 include/exec/memory.h | 39 +++++++++++++++++++++++++--------------
 1 file changed, 25 insertions(+), 14 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 5e8c009169..95668d1628 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -161,12 +161,14 @@ struct MemoryRegionOps {
                                    hwaddr addr,
                                    uint64_t *data,
                                    unsigned size,
-                                   MemTxAttrs attrs);
+                                   MemTxAttrs attrs)
+                                   QEMU_WARN_UNUSED_RESULT;
     MemTxResult (*write_with_attrs)(void *opaque,
                                     hwaddr addr,
                                     uint64_t data,
                                     unsigned size,
-                                    MemTxAttrs attrs);
+                                    MemTxAttrs attrs)
+                                    QEMU_WARN_UNUSED_RESULT;
 
     enum device_endian endianness;
     /* Guest-visible constraints: */
@@ -1989,7 +1991,8 @@ MemTxResult memory_region_dispatch_read(MemoryRegion *mr,
                                         hwaddr addr,
                                         uint64_t *pval,
                                         MemOp op,
-                                        MemTxAttrs attrs);
+                                        MemTxAttrs attrs)
+                                        QEMU_WARN_UNUSED_RESULT;
 /**
  * memory_region_dispatch_write: perform a write directly to the specified
  * MemoryRegion.
@@ -2004,7 +2007,8 @@ MemTxResult memory_region_dispatch_write(MemoryRegion *mr,
                                          hwaddr addr,
                                          uint64_t data,
                                          MemOp op,
-                                         MemTxAttrs attrs);
+                                         MemTxAttrs attrs)
+                                         QEMU_WARN_UNUSED_RESULT;
 
 /**
  * address_space_init: initializes an address space
@@ -2053,7 +2057,8 @@ void address_space_remove_listeners(AddressSpace *as);
  */
 MemTxResult address_space_rw(AddressSpace *as, hwaddr addr,
                              MemTxAttrs attrs, void *buf,
-                             hwaddr len, bool is_write);
+                             hwaddr len, bool is_write)
+                             QEMU_WARN_UNUSED_RESULT;
 
 /**
  * address_space_write: write to address space.
@@ -2070,7 +2075,8 @@ MemTxResult address_space_rw(AddressSpace *as, hwaddr addr,
  */
 MemTxResult address_space_write(AddressSpace *as, hwaddr addr,
                                 MemTxAttrs attrs,
-                                const void *buf, hwaddr len);
+                                const void *buf, hwaddr len)
+                                QEMU_WARN_UNUSED_RESULT;
 
 /**
  * address_space_write_rom: write to address space, including ROM.
@@ -2096,7 +2102,8 @@ MemTxResult address_space_write(AddressSpace *as, hwaddr addr,
  */
 MemTxResult address_space_write_rom(AddressSpace *as, hwaddr addr,
                                     MemTxAttrs attrs,
-                                    const void *buf, hwaddr len);
+                                    const void *buf, hwaddr len)
+                                    QEMU_WARN_UNUSED_RESULT;
 
 /* address_space_ld*: load from an address space
  * address_space_st*: store to an address space
@@ -2334,20 +2341,24 @@ void address_space_unmap(AddressSpace *as, void *buffer, hwaddr len,
 
 /* Internal functions, part of the implementation of address_space_read.  */
 MemTxResult address_space_read_full(AddressSpace *as, hwaddr addr,
-                                    MemTxAttrs attrs, void *buf, hwaddr len);
+                                    MemTxAttrs attrs, void *buf, hwaddr len)
+                                    QEMU_WARN_UNUSED_RESULT;
 MemTxResult flatview_read_continue(FlatView *fv, hwaddr addr,
                                    MemTxAttrs attrs, void *buf,
                                    hwaddr len, hwaddr addr1, hwaddr l,
-                                   MemoryRegion *mr);
+                                   MemoryRegion *mr)
+                                   QEMU_WARN_UNUSED_RESULT;
 void *qemu_map_ram_ptr(RAMBlock *ram_block, ram_addr_t addr);
 
 /* Internal functions, part of the implementation of address_space_read_cached
  * and address_space_write_cached.  */
 MemTxResult address_space_read_cached_slow(MemoryRegionCache *cache,
-                                           hwaddr addr, void *buf, hwaddr len);
+                                           hwaddr addr, void *buf, hwaddr len)
+                                           QEMU_WARN_UNUSED_RESULT;
 MemTxResult address_space_write_cached_slow(MemoryRegionCache *cache,
                                             hwaddr addr, const void *buf,
-                                            hwaddr len);
+                                            hwaddr len)
+                                            QEMU_WARN_UNUSED_RESULT;
 
 static inline bool memory_access_is_direct(MemoryRegion *mr, bool is_write)
 {
@@ -2373,7 +2384,7 @@ static inline bool memory_access_is_direct(MemoryRegion *mr, bool is_write)
  * @buf: buffer with the data transferred
  * @len: length of the data transferred
  */
-static inline __attribute__((__always_inline__))
+static inline __attribute__((__always_inline__)) QEMU_WARN_UNUSED_RESULT
 MemTxResult address_space_read(AddressSpace *as, hwaddr addr,
                                MemTxAttrs attrs, void *buf,
                                hwaddr len)
@@ -2412,7 +2423,7 @@ MemTxResult address_space_read(AddressSpace *as, hwaddr addr,
  * @buf: buffer with the data transferred
  * @len: length of the data transferred
  */
-static inline MemTxResult
+static inline MemTxResult QEMU_WARN_UNUSED_RESULT
 address_space_read_cached(MemoryRegionCache *cache, hwaddr addr,
                           void *buf, hwaddr len)
 {
@@ -2433,7 +2444,7 @@ address_space_read_cached(MemoryRegionCache *cache, hwaddr addr,
  * @buf: buffer with the data transferred
  * @len: length of the data transferred
  */
-static inline MemTxResult
+static inline MemTxResult QEMU_WARN_UNUSED_RESULT
 address_space_write_cached(MemoryRegionCache *cache, hwaddr addr,
                            const void *buf, hwaddr len)
 {
-- 
2.21.3


