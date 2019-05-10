Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D02CDC04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 20:05:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 698CC217F4
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 20:05:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZLv3M2cA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 698CC217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49343 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hPBly-0005ff-KH
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 16:05:38 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33911)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hPBhp-0002W3-P5
	for qemu-devel@nongnu.org; Fri, 10 May 2019 16:01:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hPBhi-0002VI-2C
	for qemu-devel@nongnu.org; Fri, 10 May 2019 16:01:18 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:38059)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hPBhd-0002Po-Sg
	for qemu-devel@nongnu.org; Fri, 10 May 2019 16:01:11 -0400
Received: by mail-wm1-x332.google.com with SMTP id f2so8598602wmj.3
	for <qemu-devel@nongnu.org>; Fri, 10 May 2019 13:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=eKgvAaykMdYlV+CFih2bS4g/EVzTgF73re99mr2LDvw=;
	b=ZLv3M2cA+rjgzl9qJzGESFR8h1bylh2Ym+OTQ6ti/6zCG4Rp7aFJiaiI5c7wiCR1dv
	9YJlLkb12SVcO4zzJP9cpsMRzbjNE4ibSg/KW8H+/SpsrGTONaXIX/c0sPzyN4nujHar
	tDV+Fkyv7Y3Vs6nPEM+2VVSY6V3sOvGkaC/Binxy/KnaEvKpuBovW+eTO6RH0P02RMtq
	KDQbfHGaEIIfqYscP+wSn7Y1yRhOAAF/+p8noJfdAthr955G+OnLWnRYiFN6gObvTWHS
	JiVylYWahF0DTeCON5rnX8hz8DrzIhk4/JasgSAPBN1nl8UwdVyUrWq3AXpAZltMgILF
	DS0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=eKgvAaykMdYlV+CFih2bS4g/EVzTgF73re99mr2LDvw=;
	b=NSUveD9OB3m+8cWCDaQu5KTpgKvD5FczuIIWeh99XrC9vttZUKeYvSP1dQFEuO335J
	ddeg3IJCxkkbbIE/uRX8F/oFVM4ZeHQ9rfmPnZsx3DcdiipBN7bnXo9BfmfYpqDvGdVh
	omK6Xajf5H4W3LFlVbtOOyiI0gPEr2oyN4tEhDDVTQH+vwejdUYCBLXS4g5Xsows0Utt
	wb43FemAOFlcnJgXt2IsQBPJvSI+b5e7dEWSNo+KHiLM7VhSWQEotMdrILpH7FC+d4Mf
	WgTP7cQD5ggVdpgZn1X/wL6nYJBLTJ1svEv4DTDjGZ043350UIU796nm2CGzzKXYWWts
	FCiA==
X-Gm-Message-State: APjAAAUTKac2iu5v/kyUHeV2h/0hoPG0vtf6PRpOPGRweSAMojsAMRn/
	mn8Bq59GJ7zmcjmrma/IHGq+6PXG8oc=
X-Google-Smtp-Source: APXvYqwVgZG55hVCXM9VqcU6ow1CjCRHD0Ru0myMxUckYaTxGeuFWj8pflRsArCyCtpi8aEvUDsbrw==
X-Received: by 2002:a1c:a684:: with SMTP id p126mr3456363wme.101.1557518466423;
	Fri, 10 May 2019 13:01:06 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	i25sm3523248wmb.46.2019.05.10.13.01.02
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 10 May 2019 13:01:03 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id E23861FF8C;
	Fri, 10 May 2019 21:01:01 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Fri, 10 May 2019 21:00:57 +0100
Message-Id: <20190510200101.31096-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190510200101.31096-1-alex.bennee@linaro.org>
References: <20190510200101.31096-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::332
Subject: [Qemu-devel] [PULL 1/5] accel/tcg: demacro cputlb
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
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Instead of expanding a series of macros to generate the load/store
helpers we move stuff into common functions and rely on the compiler
to eliminate the dead code for each variant.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index f2f618217d6..12f21865ee7 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1168,26 +1168,421 @@ static void *atomic_mmu_lookup(CPUArchState *env, target_ulong addr,
 }
 
 #ifdef TARGET_WORDS_BIGENDIAN
-# define TGT_BE(X)  (X)
-# define TGT_LE(X)  BSWAP(X)
+#define NEED_BE_BSWAP 0
+#define NEED_LE_BSWAP 1
 #else
-# define TGT_BE(X)  BSWAP(X)
-# define TGT_LE(X)  (X)
+#define NEED_BE_BSWAP 1
+#define NEED_LE_BSWAP 0
 #endif
 
-#define MMUSUFFIX _mmu
+/*
+ * Byte Swap Helper
+ *
+ * This should all dead code away depending on the build host and
+ * access type.
+ */
 
-#define DATA_SIZE 1
-#include "softmmu_template.h"
+static inline uint64_t handle_bswap(uint64_t val, int size, bool big_endian)
+{
+    if ((big_endian && NEED_BE_BSWAP) || (!big_endian && NEED_LE_BSWAP)) {
+        switch (size) {
+        case 1: return val;
+        case 2: return bswap16(val);
+        case 4: return bswap32(val);
+        case 8: return bswap64(val);
+        default:
+            g_assert_not_reached();
+        }
+    } else {
+        return val;
+    }
+}
 
-#define DATA_SIZE 2
-#include "softmmu_template.h"
+/*
+ * Load Helpers
+ *
+ * We support two different access types. SOFTMMU_CODE_ACCESS is
+ * specifically for reading instructions from system memory. It is
+ * called by the translation loop and in some helpers where the code
+ * is disassembled. It shouldn't be called directly by guest code.
+ */
 
-#define DATA_SIZE 4
-#include "softmmu_template.h"
+static uint64_t load_helper(CPUArchState *env, target_ulong addr,
+                            TCGMemOpIdx oi, uintptr_t retaddr,
+                            size_t size, bool big_endian,
+                            bool code_read)
+{
+    uintptr_t mmu_idx = get_mmuidx(oi);
+    uintptr_t index = tlb_index(env, mmu_idx, addr);
+    CPUTLBEntry *entry = tlb_entry(env, mmu_idx, addr);
+    target_ulong tlb_addr = code_read ? entry->addr_code : entry->addr_read;
+    const size_t tlb_off = code_read ?
+        offsetof(CPUTLBEntry, addr_code) : offsetof(CPUTLBEntry, addr_read);
+    unsigned a_bits = get_alignment_bits(get_memop(oi));
+    void *haddr;
+    uint64_t res;
+
+    /* Handle CPU specific unaligned behaviour */
+    if (addr & ((1 << a_bits) - 1)) {
+        cpu_unaligned_access(ENV_GET_CPU(env), addr,
+                             code_read ? MMU_INST_FETCH : MMU_DATA_LOAD,
+                             mmu_idx, retaddr);
+    }
 
-#define DATA_SIZE 8
-#include "softmmu_template.h"
+    /* If the TLB entry is for a different page, reload and try again.  */
+    if (!tlb_hit(tlb_addr, addr)) {
+        if (!victim_tlb_hit(env, mmu_idx, index, tlb_off,
+                            addr & TARGET_PAGE_MASK)) {
+            tlb_fill(ENV_GET_CPU(env), addr, size,
+                     code_read ? MMU_INST_FETCH : MMU_DATA_LOAD,
+                     mmu_idx, retaddr);
+            index = tlb_index(env, mmu_idx, addr);
+            entry = tlb_entry(env, mmu_idx, addr);
+        }
+        tlb_addr = code_read ? entry->addr_code : entry->addr_read;
+    }
+
+    /* Handle an IO access.  */
+    if (unlikely(tlb_addr & ~TARGET_PAGE_MASK)) {
+        CPUIOTLBEntry *iotlbentry = &env->iotlb[mmu_idx][index];
+        uint64_t tmp;
+
+        if ((addr & (size - 1)) != 0) {
+            goto do_unaligned_access;
+        }
+
+        tmp = io_readx(env, iotlbentry, mmu_idx, addr, retaddr,
+                       tlb_addr & TLB_RECHECK,
+                       code_read ? MMU_INST_FETCH : MMU_DATA_LOAD, size);
+        return handle_bswap(tmp, size, big_endian);
+    }
+
+    /* Handle slow unaligned access (it spans two pages or IO).  */
+    if (size > 1
+        && unlikely((addr & ~TARGET_PAGE_MASK) + size - 1
+                    >= TARGET_PAGE_SIZE)) {
+        target_ulong addr1, addr2;
+        tcg_target_ulong r1, r2;
+        unsigned shift;
+    do_unaligned_access:
+        addr1 = addr & ~(size - 1);
+        addr2 = addr1 + size;
+        r1 = load_helper(env, addr1, oi, retaddr, size, big_endian, code_read);
+        r2 = load_helper(env, addr2, oi, retaddr, size, big_endian, code_read);
+        shift = (addr & (size - 1)) * 8;
+
+        if (big_endian) {
+            /* Big-endian combine.  */
+            res = (r1 << shift) | (r2 >> ((size * 8) - shift));
+        } else {
+            /* Little-endian combine.  */
+            res = (r1 >> shift) | (r2 << ((size * 8) - shift));
+        }
+        return res & MAKE_64BIT_MASK(0, size * 8);
+    }
+
+    haddr = (void *)((uintptr_t)addr + entry->addend);
+
+    switch (size) {
+    case 1:
+        res = ldub_p(haddr);
+        break;
+    case 2:
+        if (big_endian) {
+            res = lduw_be_p(haddr);
+        } else {
+            res = lduw_le_p(haddr);
+        }
+        break;
+    case 4:
+        if (big_endian) {
+            res = (uint32_t)ldl_be_p(haddr);
+        } else {
+            res = (uint32_t)ldl_le_p(haddr);
+        }
+        break;
+    case 8:
+        if (big_endian) {
+            res = ldq_be_p(haddr);
+        } else {
+            res = ldq_le_p(haddr);
+        }
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    return res;
+}
+
+/*
+ * For the benefit of TCG generated code, we want to avoid the
+ * complication of ABI-specific return type promotion and always
+ * return a value extended to the register size of the host. This is
+ * tcg_target_long, except in the case of a 32-bit host and 64-bit
+ * data, and for that we always have uint64_t.
+ *
+ * We don't bother with this widened value for SOFTMMU_CODE_ACCESS.
+ */
+
+tcg_target_ulong __attribute__((flatten))
+helper_ret_ldub_mmu(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
+                    uintptr_t retaddr)
+{
+    return load_helper(env, addr, oi, retaddr, 1, false, false);
+}
+
+tcg_target_ulong __attribute__((flatten))
+helper_le_lduw_mmu(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
+                   uintptr_t retaddr)
+{
+    return load_helper(env, addr, oi, retaddr, 2, false, false);
+}
+
+tcg_target_ulong __attribute__((flatten))
+helper_be_lduw_mmu(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
+                   uintptr_t retaddr)
+{
+    return load_helper(env, addr, oi, retaddr, 2, true, false);
+}
+
+tcg_target_ulong __attribute__((flatten))
+helper_le_ldul_mmu(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
+                   uintptr_t retaddr)
+{
+    return load_helper(env, addr, oi, retaddr, 4, false, false);
+}
+
+tcg_target_ulong __attribute__((flatten))
+helper_be_ldul_mmu(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
+                   uintptr_t retaddr)
+{
+    return load_helper(env, addr, oi, retaddr, 4, true, false);
+}
+
+uint64_t __attribute__((flatten))
+helper_le_ldq_mmu(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
+                  uintptr_t retaddr)
+{
+    return load_helper(env, addr, oi, retaddr, 8, false, false);
+}
+
+uint64_t __attribute__((flatten))
+helper_be_ldq_mmu(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
+                  uintptr_t retaddr)
+{
+    return load_helper(env, addr, oi, retaddr, 8, true, false);
+}
+
+/*
+ * Provide signed versions of the load routines as well.  We can of course
+ * avoid this for 64-bit data, or for 32-bit data on 32-bit host.
+ */
+
+
+tcg_target_ulong helper_ret_ldsb_mmu(CPUArchState *env, target_ulong addr,
+                                     TCGMemOpIdx oi, uintptr_t retaddr)
+{
+    return (int8_t)helper_ret_ldub_mmu(env, addr, oi, retaddr);
+}
+
+tcg_target_ulong helper_le_ldsw_mmu(CPUArchState *env, target_ulong addr,
+                                    TCGMemOpIdx oi, uintptr_t retaddr)
+{
+    return (int16_t)helper_le_lduw_mmu(env, addr, oi, retaddr);
+}
+
+tcg_target_ulong helper_be_ldsw_mmu(CPUArchState *env, target_ulong addr,
+                                    TCGMemOpIdx oi, uintptr_t retaddr)
+{
+    return (int16_t)helper_be_lduw_mmu(env, addr, oi, retaddr);
+}
+
+tcg_target_ulong helper_le_ldsl_mmu(CPUArchState *env, target_ulong addr,
+                                    TCGMemOpIdx oi, uintptr_t retaddr)
+{
+    return (int32_t)helper_le_ldul_mmu(env, addr, oi, retaddr);
+}
+
+tcg_target_ulong helper_be_ldsl_mmu(CPUArchState *env, target_ulong addr,
+                                    TCGMemOpIdx oi, uintptr_t retaddr)
+{
+    return (int32_t)helper_be_ldul_mmu(env, addr, oi, retaddr);
+}
+
+/*
+ * Store Helpers
+ */
+
+static void store_helper(CPUArchState *env, target_ulong addr, uint64_t val,
+                         TCGMemOpIdx oi, uintptr_t retaddr, size_t size,
+                         bool big_endian)
+{
+    uintptr_t mmu_idx = get_mmuidx(oi);
+    uintptr_t index = tlb_index(env, mmu_idx, addr);
+    CPUTLBEntry *entry = tlb_entry(env, mmu_idx, addr);
+    target_ulong tlb_addr = tlb_addr_write(entry);
+    const size_t tlb_off = offsetof(CPUTLBEntry, addr_write);
+    unsigned a_bits = get_alignment_bits(get_memop(oi));
+    void *haddr;
+
+    /* Handle CPU specific unaligned behaviour */
+    if (addr & ((1 << a_bits) - 1)) {
+        cpu_unaligned_access(ENV_GET_CPU(env), addr, MMU_DATA_STORE,
+                             mmu_idx, retaddr);
+    }
+
+    /* If the TLB entry is for a different page, reload and try again.  */
+    if (!tlb_hit(tlb_addr, addr)) {
+        if (!victim_tlb_hit(env, mmu_idx, index, tlb_off,
+            addr & TARGET_PAGE_MASK)) {
+            tlb_fill(ENV_GET_CPU(env), addr, size, MMU_DATA_STORE,
+                     mmu_idx, retaddr);
+            index = tlb_index(env, mmu_idx, addr);
+            entry = tlb_entry(env, mmu_idx, addr);
+        }
+        tlb_addr = tlb_addr_write(entry) & ~TLB_INVALID_MASK;
+    }
+
+    /* Handle an IO access.  */
+    if (unlikely(tlb_addr & ~TARGET_PAGE_MASK)) {
+        CPUIOTLBEntry *iotlbentry = &env->iotlb[mmu_idx][index];
+
+        if ((addr & (size - 1)) != 0) {
+            goto do_unaligned_access;
+        }
+
+        io_writex(env, iotlbentry, mmu_idx,
+                  handle_bswap(val, size, big_endian),
+                  addr, retaddr, tlb_addr & TLB_RECHECK, size);
+        return;
+    }
+
+    /* Handle slow unaligned access (it spans two pages or IO).  */
+    if (size > 1
+        && unlikely((addr & ~TARGET_PAGE_MASK) + size - 1
+                     >= TARGET_PAGE_SIZE)) {
+        int i;
+        uintptr_t index2;
+        CPUTLBEntry *entry2;
+        target_ulong page2, tlb_addr2;
+    do_unaligned_access:
+        /*
+         * Ensure the second page is in the TLB.  Note that the first page
+         * is already guaranteed to be filled, and that the second page
+         * cannot evict the first.
+         */
+        page2 = (addr + size) & TARGET_PAGE_MASK;
+        index2 = tlb_index(env, mmu_idx, page2);
+        entry2 = tlb_entry(env, mmu_idx, page2);
+        tlb_addr2 = tlb_addr_write(entry2);
+        if (!tlb_hit_page(tlb_addr2, page2)
+            && !victim_tlb_hit(env, mmu_idx, index2, tlb_off,
+                               page2 & TARGET_PAGE_MASK)) {
+            tlb_fill(ENV_GET_CPU(env), page2, size, MMU_DATA_STORE,
+                     mmu_idx, retaddr);
+        }
+
+        /*
+         * XXX: not efficient, but simple.
+         * This loop must go in the forward direction to avoid issues
+         * with self-modifying code in Windows 64-bit.
+         */
+        for (i = 0; i < size; ++i) {
+            uint8_t val8;
+            if (big_endian) {
+                /* Big-endian extract.  */
+                val8 = val >> (((size - 1) * 8) - (i * 8));
+            } else {
+                /* Little-endian extract.  */
+                val8 = val >> (i * 8);
+            }
+            store_helper(env, addr + i, val8, oi, retaddr, 1, big_endian);
+        }
+        return;
+    }
+
+    haddr = (void *)((uintptr_t)addr + entry->addend);
+
+    switch (size) {
+    case 1:
+        stb_p(haddr, val);
+        break;
+    case 2:
+        if (big_endian) {
+            stw_be_p(haddr, val);
+        } else {
+            stw_le_p(haddr, val);
+        }
+        break;
+    case 4:
+        if (big_endian) {
+            stl_be_p(haddr, val);
+        } else {
+            stl_le_p(haddr, val);
+        }
+        break;
+    case 8:
+        if (big_endian) {
+            stq_be_p(haddr, val);
+        } else {
+            stq_le_p(haddr, val);
+        }
+        break;
+    default:
+        g_assert_not_reached();
+        break;
+    }
+}
+
+void __attribute__((flatten))
+helper_ret_stb_mmu(CPUArchState *env, target_ulong addr, uint8_t val,
+                   TCGMemOpIdx oi, uintptr_t retaddr)
+{
+    store_helper(env, addr, val, oi, retaddr, 1, false);
+}
+
+void __attribute__((flatten))
+helper_le_stw_mmu(CPUArchState *env, target_ulong addr, uint16_t val,
+                  TCGMemOpIdx oi, uintptr_t retaddr)
+{
+    store_helper(env, addr, val, oi, retaddr, 2, false);
+}
+
+void __attribute__((flatten))
+helper_be_stw_mmu(CPUArchState *env, target_ulong addr, uint16_t val,
+                  TCGMemOpIdx oi, uintptr_t retaddr)
+{
+    store_helper(env, addr, val, oi, retaddr, 2, true);
+}
+
+void __attribute__((flatten))
+helper_le_stl_mmu(CPUArchState *env, target_ulong addr, uint32_t val,
+                  TCGMemOpIdx oi, uintptr_t retaddr)
+{
+    store_helper(env, addr, val, oi, retaddr, 4, false);
+}
+
+void __attribute__((flatten))
+helper_be_stl_mmu(CPUArchState *env, target_ulong addr, uint32_t val,
+                  TCGMemOpIdx oi, uintptr_t retaddr)
+{
+    store_helper(env, addr, val, oi, retaddr, 4, true);
+}
+
+void __attribute__((flatten))
+helper_le_stq_mmu(CPUArchState *env, target_ulong addr, uint64_t val,
+                  TCGMemOpIdx oi, uintptr_t retaddr)
+{
+    store_helper(env, addr, val, oi, retaddr, 8, false);
+}
+
+void __attribute__((flatten))
+helper_be_stq_mmu(CPUArchState *env, target_ulong addr, uint64_t val,
+                  TCGMemOpIdx oi, uintptr_t retaddr)
+{
+    store_helper(env, addr, val, oi, retaddr, 8, true);
+}
 
 /* First set of helpers allows passing in of OI and RETADDR.  This makes
    them callable from other helpers.  */
@@ -1248,20 +1643,51 @@ static void *atomic_mmu_lookup(CPUArchState *env, target_ulong addr,
 
 /* Code access functions.  */
 
-#undef MMUSUFFIX
-#define MMUSUFFIX _cmmu
-#undef GETPC
-#define GETPC() ((uintptr_t)0)
-#define SOFTMMU_CODE_ACCESS
+uint8_t __attribute__((flatten))
+helper_ret_ldb_cmmu(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
+                    uintptr_t retaddr)
+{
+    return load_helper(env, addr, oi, retaddr, 1, false, true);
+}
 
-#define DATA_SIZE 1
-#include "softmmu_template.h"
+uint16_t __attribute__((flatten))
+helper_le_ldw_cmmu(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
+                   uintptr_t retaddr)
+{
+    return load_helper(env, addr, oi, retaddr, 2, false, true);
+}
 
-#define DATA_SIZE 2
-#include "softmmu_template.h"
+uint16_t __attribute__((flatten))
+helper_be_ldw_cmmu(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
+                   uintptr_t retaddr)
+{
+    return load_helper(env, addr, oi, retaddr, 2, true, true);
+}
 
-#define DATA_SIZE 4
-#include "softmmu_template.h"
+uint32_t __attribute__((flatten))
+helper_le_ldl_cmmu(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
+                   uintptr_t retaddr)
+{
+    return load_helper(env, addr, oi, retaddr, 4, false, true);
+}
 
-#define DATA_SIZE 8
-#include "softmmu_template.h"
+uint32_t __attribute__((flatten))
+helper_be_ldl_cmmu(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
+                   uintptr_t retaddr)
+{
+    return load_helper(env, addr, oi, retaddr, 4, true, true);
+}
+
+uint64_t __attribute__((flatten))
+helper_le_ldq_cmmu(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
+                   uintptr_t retaddr)
+{
+    return load_helper(env, addr, oi, retaddr, 8, false, true);
+}
+
+uint64_t __attribute__((flatten))
+helper_be_ldq_cmmu(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
+                   uintptr_t retaddr)
+{
+    return load_helper(env, addr, oi, retaddr, 8, true, true);
+}
diff --git a/accel/tcg/softmmu_template.h b/accel/tcg/softmmu_template.h
deleted file mode 100644
index e970a8b378e..00000000000
--- a/accel/tcg/softmmu_template.h
+++ /dev/null
@@ -1,454 +0,0 @@
-/*
- *  Software MMU support
- *
- * Generate helpers used by TCG for qemu_ld/st ops and code load
- * functions.
- *
- * Included from target op helpers and exec.c.
- *
- *  Copyright (c) 2003 Fabrice Bellard
- *
- * This library is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; either
- * version 2.1 of the License, or (at your option) any later version.
- *
- * This library is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Lesser General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, see <http://www.gnu.org/licenses/>.
- */
-#if DATA_SIZE == 8
-#define SUFFIX q
-#define LSUFFIX q
-#define SDATA_TYPE  int64_t
-#define DATA_TYPE  uint64_t
-#elif DATA_SIZE == 4
-#define SUFFIX l
-#define LSUFFIX l
-#define SDATA_TYPE  int32_t
-#define DATA_TYPE  uint32_t
-#elif DATA_SIZE == 2
-#define SUFFIX w
-#define LSUFFIX uw
-#define SDATA_TYPE  int16_t
-#define DATA_TYPE  uint16_t
-#elif DATA_SIZE == 1
-#define SUFFIX b
-#define LSUFFIX ub
-#define SDATA_TYPE  int8_t
-#define DATA_TYPE  uint8_t
-#else
-#error unsupported data size
-#endif
-
-
-/* For the benefit of TCG generated code, we want to avoid the complication
-   of ABI-specific return type promotion and always return a value extended
-   to the register size of the host.  This is tcg_target_long, except in the
-   case of a 32-bit host and 64-bit data, and for that we always have
-   uint64_t.  Don't bother with this widened value for SOFTMMU_CODE_ACCESS.  */
-#if defined(SOFTMMU_CODE_ACCESS) || DATA_SIZE == 8
-# define WORD_TYPE  DATA_TYPE
-# define USUFFIX    SUFFIX
-#else
-# define WORD_TYPE  tcg_target_ulong
-# define USUFFIX    glue(u, SUFFIX)
-# define SSUFFIX    glue(s, SUFFIX)
-#endif
-
-#ifdef SOFTMMU_CODE_ACCESS
-#define READ_ACCESS_TYPE MMU_INST_FETCH
-#define ADDR_READ addr_code
-#else
-#define READ_ACCESS_TYPE MMU_DATA_LOAD
-#define ADDR_READ addr_read
-#endif
-
-#if DATA_SIZE == 8
-# define BSWAP(X)  bswap64(X)
-#elif DATA_SIZE == 4
-# define BSWAP(X)  bswap32(X)
-#elif DATA_SIZE == 2
-# define BSWAP(X)  bswap16(X)
-#else
-# define BSWAP(X)  (X)
-#endif
-
-#if DATA_SIZE == 1
-# define helper_le_ld_name  glue(glue(helper_ret_ld, USUFFIX), MMUSUFFIX)
-# define helper_be_ld_name  helper_le_ld_name
-# define helper_le_lds_name glue(glue(helper_ret_ld, SSUFFIX), MMUSUFFIX)
-# define helper_be_lds_name helper_le_lds_name
-# define helper_le_st_name  glue(glue(helper_ret_st, SUFFIX), MMUSUFFIX)
-# define helper_be_st_name  helper_le_st_name
-#else
-# define helper_le_ld_name  glue(glue(helper_le_ld, USUFFIX), MMUSUFFIX)
-# define helper_be_ld_name  glue(glue(helper_be_ld, USUFFIX), MMUSUFFIX)
-# define helper_le_lds_name glue(glue(helper_le_ld, SSUFFIX), MMUSUFFIX)
-# define helper_be_lds_name glue(glue(helper_be_ld, SSUFFIX), MMUSUFFIX)
-# define helper_le_st_name  glue(glue(helper_le_st, SUFFIX), MMUSUFFIX)
-# define helper_be_st_name  glue(glue(helper_be_st, SUFFIX), MMUSUFFIX)
-#endif
-
-#ifndef SOFTMMU_CODE_ACCESS
-static inline DATA_TYPE glue(io_read, SUFFIX)(CPUArchState *env,
-                                              size_t mmu_idx, size_t index,
-                                              target_ulong addr,
-                                              uintptr_t retaddr,
-                                              bool recheck,
-                                              MMUAccessType access_type)
-{
-    CPUIOTLBEntry *iotlbentry = &env->iotlb[mmu_idx][index];
-    return io_readx(env, iotlbentry, mmu_idx, addr, retaddr, recheck,
-                    access_type, DATA_SIZE);
-}
-#endif
-
-WORD_TYPE helper_le_ld_name(CPUArchState *env, target_ulong addr,
-                            TCGMemOpIdx oi, uintptr_t retaddr)
-{
-    uintptr_t mmu_idx = get_mmuidx(oi);
-    uintptr_t index = tlb_index(env, mmu_idx, addr);
-    CPUTLBEntry *entry = tlb_entry(env, mmu_idx, addr);
-    target_ulong tlb_addr = entry->ADDR_READ;
-    unsigned a_bits = get_alignment_bits(get_memop(oi));
-    uintptr_t haddr;
-    DATA_TYPE res;
-
-    if (addr & ((1 << a_bits) - 1)) {
-        cpu_unaligned_access(ENV_GET_CPU(env), addr, READ_ACCESS_TYPE,
-                             mmu_idx, retaddr);
-    }
-
-    /* If the TLB entry is for a different page, reload and try again.  */
-    if (!tlb_hit(tlb_addr, addr)) {
-        if (!VICTIM_TLB_HIT(ADDR_READ, addr)) {
-            tlb_fill(ENV_GET_CPU(env), addr, DATA_SIZE, READ_ACCESS_TYPE,
-                     mmu_idx, retaddr);
-            index = tlb_index(env, mmu_idx, addr);
-            entry = tlb_entry(env, mmu_idx, addr);
-        }
-        tlb_addr = entry->ADDR_READ;
-    }
-
-    /* Handle an IO access.  */
-    if (unlikely(tlb_addr & ~TARGET_PAGE_MASK)) {
-        if ((addr & (DATA_SIZE - 1)) != 0) {
-            goto do_unaligned_access;
-        }
-
-        /* ??? Note that the io helpers always read data in the target
-           byte ordering.  We should push the LE/BE request down into io.  */
-        res = glue(io_read, SUFFIX)(env, mmu_idx, index, addr, retaddr,
-                                    tlb_addr & TLB_RECHECK,
-                                    READ_ACCESS_TYPE);
-        res = TGT_LE(res);
-        return res;
-    }
-
-    /* Handle slow unaligned access (it spans two pages or IO).  */
-    if (DATA_SIZE > 1
-        && unlikely((addr & ~TARGET_PAGE_MASK) + DATA_SIZE - 1
-                    >= TARGET_PAGE_SIZE)) {
-        target_ulong addr1, addr2;
-        DATA_TYPE res1, res2;
-        unsigned shift;
-    do_unaligned_access:
-        addr1 = addr & ~(DATA_SIZE - 1);
-        addr2 = addr1 + DATA_SIZE;
-        res1 = helper_le_ld_name(env, addr1, oi, retaddr);
-        res2 = helper_le_ld_name(env, addr2, oi, retaddr);
-        shift = (addr & (DATA_SIZE - 1)) * 8;
-
-        /* Little-endian combine.  */
-        res = (res1 >> shift) | (res2 << ((DATA_SIZE * 8) - shift));
-        return res;
-    }
-
-    haddr = addr + entry->addend;
-#if DATA_SIZE == 1
-    res = glue(glue(ld, LSUFFIX), _p)((uint8_t *)haddr);
-#else
-    res = glue(glue(ld, LSUFFIX), _le_p)((uint8_t *)haddr);
-#endif
-    return res;
-}
-
-#if DATA_SIZE > 1
-WORD_TYPE helper_be_ld_name(CPUArchState *env, target_ulong addr,
-                            TCGMemOpIdx oi, uintptr_t retaddr)
-{
-    uintptr_t mmu_idx = get_mmuidx(oi);
-    uintptr_t index = tlb_index(env, mmu_idx, addr);
-    CPUTLBEntry *entry = tlb_entry(env, mmu_idx, addr);
-    target_ulong tlb_addr = entry->ADDR_READ;
-    unsigned a_bits = get_alignment_bits(get_memop(oi));
-    uintptr_t haddr;
-    DATA_TYPE res;
-
-    if (addr & ((1 << a_bits) - 1)) {
-        cpu_unaligned_access(ENV_GET_CPU(env), addr, READ_ACCESS_TYPE,
-                             mmu_idx, retaddr);
-    }
-
-    /* If the TLB entry is for a different page, reload and try again.  */
-    if (!tlb_hit(tlb_addr, addr)) {
-        if (!VICTIM_TLB_HIT(ADDR_READ, addr)) {
-            tlb_fill(ENV_GET_CPU(env), addr, DATA_SIZE, READ_ACCESS_TYPE,
-                     mmu_idx, retaddr);
-            index = tlb_index(env, mmu_idx, addr);
-            entry = tlb_entry(env, mmu_idx, addr);
-        }
-        tlb_addr = entry->ADDR_READ;
-    }
-
-    /* Handle an IO access.  */
-    if (unlikely(tlb_addr & ~TARGET_PAGE_MASK)) {
-        if ((addr & (DATA_SIZE - 1)) != 0) {
-            goto do_unaligned_access;
-        }
-
-        /* ??? Note that the io helpers always read data in the target
-           byte ordering.  We should push the LE/BE request down into io.  */
-        res = glue(io_read, SUFFIX)(env, mmu_idx, index, addr, retaddr,
-                                    tlb_addr & TLB_RECHECK,
-                                    READ_ACCESS_TYPE);
-        res = TGT_BE(res);
-        return res;
-    }
-
-    /* Handle slow unaligned access (it spans two pages or IO).  */
-    if (DATA_SIZE > 1
-        && unlikely((addr & ~TARGET_PAGE_MASK) + DATA_SIZE - 1
-                    >= TARGET_PAGE_SIZE)) {
-        target_ulong addr1, addr2;
-        DATA_TYPE res1, res2;
-        unsigned shift;
-    do_unaligned_access:
-        addr1 = addr & ~(DATA_SIZE - 1);
-        addr2 = addr1 + DATA_SIZE;
-        res1 = helper_be_ld_name(env, addr1, oi, retaddr);
-        res2 = helper_be_ld_name(env, addr2, oi, retaddr);
-        shift = (addr & (DATA_SIZE - 1)) * 8;
-
-        /* Big-endian combine.  */
-        res = (res1 << shift) | (res2 >> ((DATA_SIZE * 8) - shift));
-        return res;
-    }
-
-    haddr = addr + entry->addend;
-    res = glue(glue(ld, LSUFFIX), _be_p)((uint8_t *)haddr);
-    return res;
-}
-#endif /* DATA_SIZE > 1 */
-
-#ifndef SOFTMMU_CODE_ACCESS
-
-/* Provide signed versions of the load routines as well.  We can of course
-   avoid this for 64-bit data, or for 32-bit data on 32-bit host.  */
-#if DATA_SIZE * 8 < TCG_TARGET_REG_BITS
-WORD_TYPE helper_le_lds_name(CPUArchState *env, target_ulong addr,
-                             TCGMemOpIdx oi, uintptr_t retaddr)
-{
-    return (SDATA_TYPE)helper_le_ld_name(env, addr, oi, retaddr);
-}
-
-# if DATA_SIZE > 1
-WORD_TYPE helper_be_lds_name(CPUArchState *env, target_ulong addr,
-                             TCGMemOpIdx oi, uintptr_t retaddr)
-{
-    return (SDATA_TYPE)helper_be_ld_name(env, addr, oi, retaddr);
-}
-# endif
-#endif
-
-static inline void glue(io_write, SUFFIX)(CPUArchState *env,
-                                          size_t mmu_idx, size_t index,
-                                          DATA_TYPE val,
-                                          target_ulong addr,
-                                          uintptr_t retaddr,
-                                          bool recheck)
-{
-    CPUIOTLBEntry *iotlbentry = &env->iotlb[mmu_idx][index];
-    return io_writex(env, iotlbentry, mmu_idx, val, addr, retaddr,
-                     recheck, DATA_SIZE);
-}
-
-void helper_le_st_name(CPUArchState *env, target_ulong addr, DATA_TYPE val,
-                       TCGMemOpIdx oi, uintptr_t retaddr)
-{
-    uintptr_t mmu_idx = get_mmuidx(oi);
-    uintptr_t index = tlb_index(env, mmu_idx, addr);
-    CPUTLBEntry *entry = tlb_entry(env, mmu_idx, addr);
-    target_ulong tlb_addr = tlb_addr_write(entry);
-    unsigned a_bits = get_alignment_bits(get_memop(oi));
-    uintptr_t haddr;
-
-    if (addr & ((1 << a_bits) - 1)) {
-        cpu_unaligned_access(ENV_GET_CPU(env), addr, MMU_DATA_STORE,
-                             mmu_idx, retaddr);
-    }
-
-    /* If the TLB entry is for a different page, reload and try again.  */
-    if (!tlb_hit(tlb_addr, addr)) {
-        if (!VICTIM_TLB_HIT(addr_write, addr)) {
-            tlb_fill(ENV_GET_CPU(env), addr, DATA_SIZE, MMU_DATA_STORE,
-                     mmu_idx, retaddr);
-            index = tlb_index(env, mmu_idx, addr);
-            entry = tlb_entry(env, mmu_idx, addr);
-        }
-        tlb_addr = tlb_addr_write(entry) & ~TLB_INVALID_MASK;
-    }
-
-    /* Handle an IO access.  */
-    if (unlikely(tlb_addr & ~TARGET_PAGE_MASK)) {
-        if ((addr & (DATA_SIZE - 1)) != 0) {
-            goto do_unaligned_access;
-        }
-
-        /* ??? Note that the io helpers always read data in the target
-           byte ordering.  We should push the LE/BE request down into io.  */
-        val = TGT_LE(val);
-        glue(io_write, SUFFIX)(env, mmu_idx, index, val, addr,
-                               retaddr, tlb_addr & TLB_RECHECK);
-        return;
-    }
-
-    /* Handle slow unaligned access (it spans two pages or IO).  */
-    if (DATA_SIZE > 1
-        && unlikely((addr & ~TARGET_PAGE_MASK) + DATA_SIZE - 1
-                     >= TARGET_PAGE_SIZE)) {
-        int i;
-        target_ulong page2;
-        CPUTLBEntry *entry2;
-    do_unaligned_access:
-        /* Ensure the second page is in the TLB.  Note that the first page
-           is already guaranteed to be filled, and that the second page
-           cannot evict the first.  */
-        page2 = (addr + DATA_SIZE) & TARGET_PAGE_MASK;
-        entry2 = tlb_entry(env, mmu_idx, page2);
-        if (!tlb_hit_page(tlb_addr_write(entry2), page2)
-            && !VICTIM_TLB_HIT(addr_write, page2)) {
-            tlb_fill(ENV_GET_CPU(env), page2, DATA_SIZE, MMU_DATA_STORE,
-                     mmu_idx, retaddr);
-        }
-
-        /* XXX: not efficient, but simple.  */
-        /* This loop must go in the forward direction to avoid issues
-           with self-modifying code in Windows 64-bit.  */
-        for (i = 0; i < DATA_SIZE; ++i) {
-            /* Little-endian extract.  */
-            uint8_t val8 = val >> (i * 8);
-            glue(helper_ret_stb, MMUSUFFIX)(env, addr + i, val8,
-                                            oi, retaddr);
-        }
-        return;
-    }
-
-    haddr = addr + entry->addend;
-#if DATA_SIZE == 1
-    glue(glue(st, SUFFIX), _p)((uint8_t *)haddr, val);
-#else
-    glue(glue(st, SUFFIX), _le_p)((uint8_t *)haddr, val);
-#endif
-}
-
-#if DATA_SIZE > 1
-void helper_be_st_name(CPUArchState *env, target_ulong addr, DATA_TYPE val,
-                       TCGMemOpIdx oi, uintptr_t retaddr)
-{
-    uintptr_t mmu_idx = get_mmuidx(oi);
-    uintptr_t index = tlb_index(env, mmu_idx, addr);
-    CPUTLBEntry *entry = tlb_entry(env, mmu_idx, addr);
-    target_ulong tlb_addr = tlb_addr_write(entry);
-    unsigned a_bits = get_alignment_bits(get_memop(oi));
-    uintptr_t haddr;
-
-    if (addr & ((1 << a_bits) - 1)) {
-        cpu_unaligned_access(ENV_GET_CPU(env), addr, MMU_DATA_STORE,
-                             mmu_idx, retaddr);
-    }
-
-    /* If the TLB entry is for a different page, reload and try again.  */
-    if (!tlb_hit(tlb_addr, addr)) {
-        if (!VICTIM_TLB_HIT(addr_write, addr)) {
-            tlb_fill(ENV_GET_CPU(env), addr, DATA_SIZE, MMU_DATA_STORE,
-                     mmu_idx, retaddr);
-            index = tlb_index(env, mmu_idx, addr);
-            entry = tlb_entry(env, mmu_idx, addr);
-        }
-        tlb_addr = tlb_addr_write(entry) & ~TLB_INVALID_MASK;
-    }
-
-    /* Handle an IO access.  */
-    if (unlikely(tlb_addr & ~TARGET_PAGE_MASK)) {
-        if ((addr & (DATA_SIZE - 1)) != 0) {
-            goto do_unaligned_access;
-        }
-
-        /* ??? Note that the io helpers always read data in the target
-           byte ordering.  We should push the LE/BE request down into io.  */
-        val = TGT_BE(val);
-        glue(io_write, SUFFIX)(env, mmu_idx, index, val, addr, retaddr,
-                               tlb_addr & TLB_RECHECK);
-        return;
-    }
-
-    /* Handle slow unaligned access (it spans two pages or IO).  */
-    if (DATA_SIZE > 1
-        && unlikely((addr & ~TARGET_PAGE_MASK) + DATA_SIZE - 1
-                     >= TARGET_PAGE_SIZE)) {
-        int i;
-        target_ulong page2;
-        CPUTLBEntry *entry2;
-    do_unaligned_access:
-        /* Ensure the second page is in the TLB.  Note that the first page
-           is already guaranteed to be filled, and that the second page
-           cannot evict the first.  */
-        page2 = (addr + DATA_SIZE) & TARGET_PAGE_MASK;
-        entry2 = tlb_entry(env, mmu_idx, page2);
-        if (!tlb_hit_page(tlb_addr_write(entry2), page2)
-            && !VICTIM_TLB_HIT(addr_write, page2)) {
-            tlb_fill(ENV_GET_CPU(env), page2, DATA_SIZE, MMU_DATA_STORE,
-                     mmu_idx, retaddr);
-        }
-
-        /* XXX: not efficient, but simple */
-        /* This loop must go in the forward direction to avoid issues
-           with self-modifying code.  */
-        for (i = 0; i < DATA_SIZE; ++i) {
-            /* Big-endian extract.  */
-            uint8_t val8 = val >> (((DATA_SIZE - 1) * 8) - (i * 8));
-            glue(helper_ret_stb, MMUSUFFIX)(env, addr + i, val8,
-                                            oi, retaddr);
-        }
-        return;
-    }
-
-    haddr = addr + entry->addend;
-    glue(glue(st, SUFFIX), _be_p)((uint8_t *)haddr, val);
-}
-#endif /* DATA_SIZE > 1 */
-#endif /* !defined(SOFTMMU_CODE_ACCESS) */
-
-#undef READ_ACCESS_TYPE
-#undef DATA_TYPE
-#undef SUFFIX
-#undef LSUFFIX
-#undef DATA_SIZE
-#undef ADDR_READ
-#undef WORD_TYPE
-#undef SDATA_TYPE
-#undef USUFFIX
-#undef SSUFFIX
-#undef BSWAP
-#undef helper_le_ld_name
-#undef helper_be_ld_name
-#undef helper_le_lds_name
-#undef helper_be_lds_name
-#undef helper_le_st_name
-#undef helper_be_st_name
-- 
2.20.1


