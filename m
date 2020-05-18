Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47778C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 15:54:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 165C320758
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 15:54:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kCSqrZiB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 165C320758
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jai6G-0005Qk-5X
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 11:54:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52596)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jai4p-00031x-Dd; Mon, 18 May 2020 11:53:15 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:53827)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jai4n-000050-5c; Mon, 18 May 2020 11:53:15 -0400
Received: by mail-wm1-x342.google.com with SMTP id k12so20655wmj.3;
 Mon, 18 May 2020 08:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=WSFyr6f19aP4N4MMJJARifgNu7cVe5tnytMgFa4vhLY=;
 b=kCSqrZiBJYfTvK6U7vz3nNDXw8i72uTGkX8UjayRNSx1b87A6HZyN0RCp9RgEzIN0G
 qWNlCkhAfu32BYTwCLRdc01DpTLebfKGRZENxPGloToarBft+JLovARNHt3Zm5JpiOFb
 VAmXclSfNHTPsASzzd+5Vo/Ib/iqvhUsdfDPO8VIutjrO5t7FrU6hlXCXcT5h2jVueTR
 s/m9n5HsKERdFsQ7+K4XiY/S9K6T8aned4oF9+6DsGouHBcACygZhGM0HhzemufQ8c0m
 1SMjBI0ljkR3A+dajrtCahHCwr35VD8FFfX24g9to1COczOsGSx8MST9/AnK7B7azqah
 +gGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=WSFyr6f19aP4N4MMJJARifgNu7cVe5tnytMgFa4vhLY=;
 b=IyqvI/YZLqxQPn8Qh5cqL6AKWJ1tEd6ydygB8L0Ho6QmyGNh1EmTIhYLJ9ZdUDh1Uw
 Q7Sh9OsLZtEUnb9xOdqvcT3qyRwCd5OGWe+PYhB7KGRBNK3wSDoO+M0U0NE1KBiErS9e
 UFji4QXFnXXCoCB5v69ca3ws0neZQ3YZhIZ32Mc6gicsVLFg6Ar48AifxGRE3mlH4FNS
 POWZSreS94CsHT1nWbqUr3qR2YItc98a4NYfZVAJFQQ52b8DN9q7nJeBtCZthTFZMaFz
 U6Qv4BdhK7ZRzgHWJFeoLq+Pe395q5cDZuFyK42iM3uvGh8qbEWksY+YVSA0o+V1f/tp
 sYZg==
X-Gm-Message-State: AOAM532ONNXtLkJ53AomqufL97VllhP27sH7lrypSD/xfmqMGAbOTG4O
 ObCJBfxPRERQSaNPCum1ydXr8ZhoNko=
X-Google-Smtp-Source: ABdhPJwFmlOQ4JYI++JR9ixqC4zYUF4jca3lwFeihkNHUxT11OuH2+k/On4eJQV74FyKNuuQu/d9Dg==
X-Received: by 2002:a7b:cf15:: with SMTP id l21mr32568wmg.172.1589817191110;
 Mon, 18 May 2020 08:53:11 -0700 (PDT)
Received: from x1w.redhat.com (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id 7sm17647462wra.50.2020.05.18.08.53.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2020 08:53:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/7] exec: Let address_space_read/write_cached() propagate
 MemTxResult
Date: Mon, 18 May 2020 17:53:02 +0200
Message-Id: <20200518155308.15851-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200518155308.15851-1-f4bug@amsat.org>
References: <20200518155308.15851-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
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


