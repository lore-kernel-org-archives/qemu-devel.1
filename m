Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2153C43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 17:03:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CD9E2075E
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 17:03:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HtdWiDwL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CD9E2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50286 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLWAd-0002hE-Or
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 13:03:55 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39237)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hLW2A-0004C1-W4
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 12:55:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hLVzn-0000mD-Nu
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 12:52:46 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:39103)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hLVzn-0000ku-DX
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 12:52:43 -0400
Received: by mail-wm1-x344.google.com with SMTP id n25so4588801wmk.4
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 09:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=I2WWTWSrfKtkbYm70GW7LAsIG/jwfqxPsVSlM/O0Py4=;
	b=HtdWiDwLZ9gwqvtKhpmcmy7gSs26zs2QloFOlRexUaLuvwM3hM1CO4USOQ17z0uCHX
	9GW75I35/3nwkxVzDsWmtFI45RCxBWSuKDcMQRGWnzLBREshRPHXcVKTeP8lYmE7lTFN
	veR/h6iC/E+JsziT5dmmWAfu0VjG5s42Lx/pIvHUnzTCvvOT8aM4otD58G7Kk9IJLN5u
	kJ7HEu2cxvvm9yGRWwyVct6TYxbL7LUjlteEGT2FQH5T5K+SQh6jG6GgcPIjatUEkxsr
	QZTK+ISJmlJ8sPh0aw2/gBN86J8hYiTLU8k6ZRYxnlDaQbSD0OPe69xirtucZU0aaO/+
	7ZlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=I2WWTWSrfKtkbYm70GW7LAsIG/jwfqxPsVSlM/O0Py4=;
	b=novuQP4GKgmXsZiu9QrWWnphx2AYM3rwDilpSRunkncA+t7mMsB/vEbYdNrpECqSXJ
	j41nK2WoPEKSpx2+4T6E5YP/AqZg2+Aslq2nougicxZJ4/eza1AAFVw//8D8U0isaPDO
	YK6jx4RHrEJXb9q0LpheNjn39MjTwKyF/Upxn5A+NHMr/35f/9LwlWejz3cc33Lq2De3
	1I6skhsB0m1t17s4vActNhhVZM5y53I/hoQfGLIdZB/pEz9BViJvByI/6o1q+/RDs5M6
	HZol6oT5sJY2IpoIUa7Pteto5qd1p4geCP/8ALpCE7PUNXu4SovB0Xp8y5qAYWlnrWc6
	BCkw==
X-Gm-Message-State: APjAAAUqYqAYF8iOOnhXlEZ45a06M2+Lf4vrqqzJOJ9aCvAlWoSpNkk6
	jJMeNZmujQ8mXq6Utid3U+F7zg==
X-Google-Smtp-Source: APXvYqwMFKSk0AGTxeYIoMymdrCyEg7sLoGkLPWz8UKDPsHcaM09TkTEHf5rDHnLOerixFoptuubow==
X-Received: by 2002:a1c:f205:: with SMTP id s5mr3595935wmc.131.1556643162304; 
	Tue, 30 Apr 2019 09:52:42 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	b10sm5179808wrh.59.2019.04.30.09.52.36
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 30 Apr 2019 09:52:37 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id EC3D21FF99;
	Tue, 30 Apr 2019 17:52:34 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue, 30 Apr 2019 17:52:28 +0100
Message-Id: <20190430165234.32272-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190430165234.32272-1-alex.bennee@linaro.org>
References: <20190430165234.32272-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: [Qemu-devel] [PATCH v5 09/15] accel/tcg: remove softmmu_template.h
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	qemu-arm@nongnu.org, mark.cave-ayland@ilande.co.uk, cota@braap.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190430165228.XZwCOiVS0wCMFJ3TUO9HG-JXCkCuJjY0TIvVbB9dH4k@z>

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 accel/tcg/softmmu_template.h | 454 -----------------------------------
 1 file changed, 454 deletions(-)
 delete mode 100644 accel/tcg/softmmu_template.h

diff --git a/accel/tcg/softmmu_template.h b/accel/tcg/softmmu_template.h
deleted file mode 100644
index e970a8b378..0000000000
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


