Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54A07C04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 20:05:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06C9F217F4
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 20:05:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r7rcIN8g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06C9F217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49311 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hPBlk-0005Q5-8o
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 16:05:24 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33865)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hPBhk-0002SE-KD
	for qemu-devel@nongnu.org; Fri, 10 May 2019 16:01:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hPBhi-0002V6-1m
	for qemu-devel@nongnu.org; Fri, 10 May 2019 16:01:16 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:35262)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hPBhd-0002OD-Sh
	for qemu-devel@nongnu.org; Fri, 10 May 2019 16:01:11 -0400
Received: by mail-wm1-x32e.google.com with SMTP id q15so4593544wmj.0
	for <qemu-devel@nongnu.org>; Fri, 10 May 2019 13:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=2jRFCM+GPqo8vu/j1Bzu3XKh2Bvye2YGkMc6M6eXRGI=;
	b=r7rcIN8gz/AAQGBl6XwVxMMRHzeRto+c+l5pUscHfJYSwn5TAmru/biwi0N7WgPKR9
	HJDNVART7BjP7o4G4BezRN4vy+Fr+8is3tWe5Y+Chpu8++2AejceiCQwhFAWB5VYNNpM
	tfc9u5fowCi2CWNaK4c09jPuO+rpSTTMKZbedUeKU+GB88Lfbq3a50WuaLkTVA5wYQei
	iuhVNj/Sx1Bge3pl2hAkmL+1sha2sH/Xph60yoNX3UbClBcgmi6cCwCveFekVtN/H5Hk
	AeRxw51HWeUiu+KJViCgOhd6Bcssizfmh3gHeZ1nTj8yAVRjRPzOjxDCyeLI32ZgNqz0
	pCcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=2jRFCM+GPqo8vu/j1Bzu3XKh2Bvye2YGkMc6M6eXRGI=;
	b=RF8O4EtM8b17cHe8nqnkSXxQeW1EDy5RZtDDsdbqJseuL10RLhqcHH8V/hTwlpw/gi
	gIswdHFTKUQw4+dd2unM70NEBO9MZaRR91OWvhHJ3tG00+X9b3nOYvWWdCzd8A/9XTlM
	D9C4+wZe6l3NPFx/PqtgxUWwThM98yGRYzt025F88S1jLTxzkHOpfP0sX/+xqX5pbD/0
	S2D/8nkBSi6Rluow6Ht8NTQWWak+qnOckVoCN5W9fUVvsGqNUZe8u7eA6H8cDNz2Eq+X
	ETatroB7bIIUtY0DYhm1+Jt81eV33eFevkO4THL8SB020Dy3PxwJmwadtHXd/gPuU1hx
	ylWw==
X-Gm-Message-State: APjAAAVv2204dfjR1f9/XiXSDaOgulcwmYdZoihL/JwEvXEgnpWBeZ3S
	A+Inl2YTYzyoidT/kTu2omyuDg==
X-Google-Smtp-Source: APXvYqy9nuUdRgYXfPBZ4QMLPiY863ken8C5KeelZTwWlV5gEpPDv9FvTP7kN1ZqQeR6F4cpfqrk7g==
X-Received: by 2002:a1c:9e04:: with SMTP id h4mr8671879wme.135.1557518464549; 
	Fri, 10 May 2019 13:01:04 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	s13sm3139414wrw.17.2019.05.10.13.01.02
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 10 May 2019 13:01:03 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 047DA1FF8F;
	Fri, 10 May 2019 21:01:02 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Fri, 10 May 2019 21:00:58 +0100
Message-Id: <20190510200101.31096-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190510200101.31096-1-alex.bennee@linaro.org>
References: <20190510200101.31096-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::32e
Subject: [Qemu-devel] [PULL 2/5] cputlb: Move TLB_RECHECK handling into
 load/store_helper
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

Having this in io_readx/io_writex meant that we forgot to
re-compute index after tlb_fill.  It also means we can use
the normal aligned memory load path.  It also fixes a bug
in that we had cached a use of index across a tlb_fill.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 12f21865ee7..9c04eb1687c 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -856,9 +856,8 @@ static inline ram_addr_t qemu_ram_addr_from_host_nofail(void *ptr)
 }
 
 static uint64_t io_readx(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
-                         int mmu_idx,
-                         target_ulong addr, uintptr_t retaddr,
-                         bool recheck, MMUAccessType access_type, int size)
+                         int mmu_idx, target_ulong addr, uintptr_t retaddr,
+                         MMUAccessType access_type, int size)
 {
     CPUState *cpu = ENV_GET_CPU(env);
     hwaddr mr_offset;
@@ -868,30 +867,6 @@ static uint64_t io_readx(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
     bool locked = false;
     MemTxResult r;
 
-    if (recheck) {
-        /*
-         * This is a TLB_RECHECK access, where the MMU protection
-         * covers a smaller range than a target page, and we must
-         * repeat the MMU check here. This tlb_fill() call might
-         * longjump out if this access should cause a guest exception.
-         */
-        CPUTLBEntry *entry;
-        target_ulong tlb_addr;
-
-        tlb_fill(cpu, addr, size, access_type, mmu_idx, retaddr);
-
-        entry = tlb_entry(env, mmu_idx, addr);
-        tlb_addr = (access_type == MMU_DATA_LOAD ?
-                    entry->addr_read : entry->addr_code);
-        if (!(tlb_addr & ~(TARGET_PAGE_MASK | TLB_RECHECK))) {
-            /* RAM access */
-            uintptr_t haddr = addr + entry->addend;
-
-            return ldn_p((void *)haddr, size);
-        }
-        /* Fall through for handling IO accesses */
-    }
-
     section = iotlb_to_section(cpu, iotlbentry->addr, iotlbentry->attrs);
     mr = section->mr;
     mr_offset = (iotlbentry->addr & TARGET_PAGE_MASK) + addr;
@@ -925,9 +900,8 @@ static uint64_t io_readx(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
 }
 
 static void io_writex(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
-                      int mmu_idx,
-                      uint64_t val, target_ulong addr,
-                      uintptr_t retaddr, bool recheck, int size)
+                      int mmu_idx, uint64_t val, target_ulong addr,
+                      uintptr_t retaddr, int size)
 {
     CPUState *cpu = ENV_GET_CPU(env);
     hwaddr mr_offset;
@@ -936,30 +910,6 @@ static void io_writex(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
     bool locked = false;
     MemTxResult r;
 
-    if (recheck) {
-        /*
-         * This is a TLB_RECHECK access, where the MMU protection
-         * covers a smaller range than a target page, and we must
-         * repeat the MMU check here. This tlb_fill() call might
-         * longjump out if this access should cause a guest exception.
-         */
-        CPUTLBEntry *entry;
-        target_ulong tlb_addr;
-
-        tlb_fill(cpu, addr, size, MMU_DATA_STORE, mmu_idx, retaddr);
-
-        entry = tlb_entry(env, mmu_idx, addr);
-        tlb_addr = tlb_addr_write(entry);
-        if (!(tlb_addr & ~(TARGET_PAGE_MASK | TLB_RECHECK))) {
-            /* RAM access */
-            uintptr_t haddr = addr + entry->addend;
-
-            stn_p((void *)haddr, size, val);
-            return;
-        }
-        /* Fall through for handling IO accesses */
-    }
-
     section = iotlb_to_section(cpu, iotlbentry->addr, iotlbentry->attrs);
     mr = section->mr;
     mr_offset = (iotlbentry->addr & TARGET_PAGE_MASK) + addr;
@@ -1218,14 +1168,15 @@ static uint64_t load_helper(CPUArchState *env, target_ulong addr,
     target_ulong tlb_addr = code_read ? entry->addr_code : entry->addr_read;
     const size_t tlb_off = code_read ?
         offsetof(CPUTLBEntry, addr_code) : offsetof(CPUTLBEntry, addr_read);
+    const MMUAccessType access_type =
+        code_read ? MMU_INST_FETCH : MMU_DATA_LOAD;
     unsigned a_bits = get_alignment_bits(get_memop(oi));
     void *haddr;
     uint64_t res;
 
     /* Handle CPU specific unaligned behaviour */
     if (addr & ((1 << a_bits) - 1)) {
-        cpu_unaligned_access(ENV_GET_CPU(env), addr,
-                             code_read ? MMU_INST_FETCH : MMU_DATA_LOAD,
+        cpu_unaligned_access(ENV_GET_CPU(env), addr, access_type,
                              mmu_idx, retaddr);
     }
 
@@ -1234,8 +1185,7 @@ static uint64_t load_helper(CPUArchState *env, target_ulong addr,
         if (!victim_tlb_hit(env, mmu_idx, index, tlb_off,
                             addr & TARGET_PAGE_MASK)) {
             tlb_fill(ENV_GET_CPU(env), addr, size,
-                     code_read ? MMU_INST_FETCH : MMU_DATA_LOAD,
-                     mmu_idx, retaddr);
+                     access_type, mmu_idx, retaddr);
             index = tlb_index(env, mmu_idx, addr);
             entry = tlb_entry(env, mmu_idx, addr);
         }
@@ -1244,17 +1194,33 @@ static uint64_t load_helper(CPUArchState *env, target_ulong addr,
 
     /* Handle an IO access.  */
     if (unlikely(tlb_addr & ~TARGET_PAGE_MASK)) {
-        CPUIOTLBEntry *iotlbentry = &env->iotlb[mmu_idx][index];
-        uint64_t tmp;
-
         if ((addr & (size - 1)) != 0) {
             goto do_unaligned_access;
         }
 
-        tmp = io_readx(env, iotlbentry, mmu_idx, addr, retaddr,
-                       tlb_addr & TLB_RECHECK,
-                       code_read ? MMU_INST_FETCH : MMU_DATA_LOAD, size);
-        return handle_bswap(tmp, size, big_endian);
+        if (tlb_addr & TLB_RECHECK) {
+            /*
+             * This is a TLB_RECHECK access, where the MMU protection
+             * covers a smaller range than a target page, and we must
+             * repeat the MMU check here. This tlb_fill() call might
+             * longjump out if this access should cause a guest exception.
+             */
+            tlb_fill(ENV_GET_CPU(env), addr, size,
+                     access_type, mmu_idx, retaddr);
+            index = tlb_index(env, mmu_idx, addr);
+            entry = tlb_entry(env, mmu_idx, addr);
+
+            tlb_addr = code_read ? entry->addr_code : entry->addr_read;
+            tlb_addr &= ~TLB_RECHECK;
+            if (!(tlb_addr & ~TARGET_PAGE_MASK)) {
+                /* RAM access */
+                goto do_aligned_access;
+            }
+        }
+
+        res = io_readx(env, &env->iotlb[mmu_idx][index], mmu_idx, addr,
+                       retaddr, access_type, size);
+        return handle_bswap(res, size, big_endian);
     }
 
     /* Handle slow unaligned access (it spans two pages or IO).  */
@@ -1281,8 +1247,8 @@ static uint64_t load_helper(CPUArchState *env, target_ulong addr,
         return res & MAKE_64BIT_MASK(0, size * 8);
     }
 
+ do_aligned_access:
     haddr = (void *)((uintptr_t)addr + entry->addend);
-
     switch (size) {
     case 1:
         res = ldub_p(haddr);
@@ -1446,15 +1412,33 @@ static void store_helper(CPUArchState *env, target_ulong addr, uint64_t val,
 
     /* Handle an IO access.  */
     if (unlikely(tlb_addr & ~TARGET_PAGE_MASK)) {
-        CPUIOTLBEntry *iotlbentry = &env->iotlb[mmu_idx][index];
-
         if ((addr & (size - 1)) != 0) {
             goto do_unaligned_access;
         }
 
-        io_writex(env, iotlbentry, mmu_idx,
+        if (tlb_addr & TLB_RECHECK) {
+            /*
+             * This is a TLB_RECHECK access, where the MMU protection
+             * covers a smaller range than a target page, and we must
+             * repeat the MMU check here. This tlb_fill() call might
+             * longjump out if this access should cause a guest exception.
+             */
+            tlb_fill(ENV_GET_CPU(env), addr, size, MMU_DATA_STORE,
+                     mmu_idx, retaddr);
+            index = tlb_index(env, mmu_idx, addr);
+            entry = tlb_entry(env, mmu_idx, addr);
+
+            tlb_addr = tlb_addr_write(entry);
+            tlb_addr &= ~TLB_RECHECK;
+            if (!(tlb_addr & ~TARGET_PAGE_MASK)) {
+                /* RAM access */
+                goto do_aligned_access;
+            }
+        }
+
+        io_writex(env, &env->iotlb[mmu_idx][index], mmu_idx,
                   handle_bswap(val, size, big_endian),
-                  addr, retaddr, tlb_addr & TLB_RECHECK, size);
+                  addr, retaddr, size);
         return;
     }
 
@@ -1502,8 +1486,8 @@ static void store_helper(CPUArchState *env, target_ulong addr, uint64_t val,
         return;
     }
 
+ do_aligned_access:
     haddr = (void *)((uintptr_t)addr + entry->addend);
-
     switch (size) {
     case 1:
         stb_p(haddr, val);
-- 
2.20.1


