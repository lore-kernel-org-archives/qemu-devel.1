Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DBA5C55179
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 03:31:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89E1120729
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 03:31:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aSLqLaHg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89E1120729
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kasTC-0006HB-De
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 22:31:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46792)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kasRO-0004N2-7U
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 22:29:30 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:41395)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kasRL-0006ts-T2
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 22:29:29 -0500
Received: by mail-pg1-x542.google.com with SMTP id g12so2876635pgm.8
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 19:29:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=lehQd8crxjGQBWeXDLJdclPmnGEfBOkk/AcImly9kNg=;
 b=aSLqLaHg+ymgeMLJJB1HpiICsI+QVhfqrE/p5FB1aUYwhM+uC/zIM6prxOhmqoW6dq
 xX8Jaz0C5wrauQ12jMeJaH/06snuOSvPCtOQUQL/YjJV7JrPTXuAmQzpCmwNlosprsAU
 OSShzEL9TGaxCef5XLboQ8CczW8xaceejjuveIktgRDhD9kAtQx+7yD7zS0/CRyUH6FY
 m6smvFkUiwS6v+XsYkl6Jeh+8t8c3wV41p6U6/BSQL/HRdgV0qJncM3J6BmZTWaC5xDn
 Q59nuunl8HRrDSAZpHGl8Wfv+QAPQVjnIBr6frdtWBD3K7dJOWCZNaU4x2hUc2hyIXNB
 iJSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=lehQd8crxjGQBWeXDLJdclPmnGEfBOkk/AcImly9kNg=;
 b=iPVAun2+ORDusHHpN4puzQjXMdf9fPcYze+NmVLeVyQEpEVt4/aRe5n+qNBdZHvqUp
 y7BknUszUyZw3bBOGCbjDzQdJwyw80Wm0aU6wO4SrdVtsFf4TUzsWvebAL4P3jdkvX6z
 h7QMLob0t19CInPvQJr86V3vT0zhKWMaQJ/0XQCkQyHkNdBM5A3UYwzleUNbQ0XJuXFE
 hPbrCmVZb1R9XUSJas6tGxeZ/CnpvbOeXL+DP4lgK84xKG9U4l/Mc2j/CjXt4/hxaXMH
 UC/nB66fwQ5Hi8UXtUvwffoirFUHcf9l3HmvyJv4Jg3MUBwcJcqUL78wy0SlIJYhOOd3
 vyAg==
X-Gm-Message-State: AOAM533jIDPl1D4Iyw0fa8TIgrjoU7v7Sh8xubak/TF5aRl3gtgBH/ZG
 naTox0RILAf70lObykU2l2wYnPzOdZtfiA==
X-Google-Smtp-Source: ABdhPJxH2K7kg4i1MIiX6ty02NQEFjhSbEWxp92q3vzQbmMfUGIFsKo92U2TCjiIaRFsJkPZ+LbwRA==
X-Received: by 2002:a63:b24e:: with SMTP id t14mr5164296pgo.224.1604633364350; 
 Thu, 05 Nov 2020 19:29:24 -0800 (PST)
Received: from localhost.localdomain (76-14-210-194.or.wavecable.com.
 [76.14.210.194])
 by smtp.gmail.com with ESMTPSA id i10sm40773pfd.60.2020.11.05.19.29.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2020 19:29:23 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 01/41] tcg: Enhance flush_icache_range with separate data
 pointer
Date: Thu,  5 Nov 2020 19:28:41 -0800
Message-Id: <20201106032921.600200-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201106032921.600200-1-richard.henderson@linaro.org>
References: <20201106032921.600200-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x542.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: j@getutm.app
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We are shortly going to have a split rw/rx jit buffer.  Depending
on the host, we need to flush the dcache at the rw data pointer and
flush the icache at the rx code pointer.

For now, the two passed pointers are identical, so there is no
effective change in behaviour.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target.h     |  9 +++++++--
 tcg/arm/tcg-target.h         |  8 ++++++--
 tcg/i386/tcg-target.h        |  3 ++-
 tcg/mips/tcg-target.h        |  8 ++++++--
 tcg/ppc/tcg-target.h         |  2 +-
 tcg/riscv/tcg-target.h       |  8 ++++++--
 tcg/s390/tcg-target.h        |  3 ++-
 tcg/sparc/tcg-target.h       |  8 +++++---
 tcg/tci/tcg-target.h         |  3 ++-
 softmmu/physmem.c            |  9 ++++++++-
 tcg/tcg.c                    |  6 ++++--
 tcg/aarch64/tcg-target.c.inc |  2 +-
 tcg/mips/tcg-target.c.inc    |  2 +-
 tcg/ppc/tcg-target.c.inc     | 21 +++++++++++----------
 tcg/sparc/tcg-target.c.inc   |  4 ++--
 15 files changed, 64 insertions(+), 32 deletions(-)

diff --git a/tcg/aarch64/tcg-target.h b/tcg/aarch64/tcg-target.h
index 663dd0b95e..d0a6a059b7 100644
--- a/tcg/aarch64/tcg-target.h
+++ b/tcg/aarch64/tcg-target.h
@@ -148,9 +148,14 @@ typedef enum {
 #define TCG_TARGET_DEFAULT_MO (0)
 #define TCG_TARGET_HAS_MEMORY_BSWAP     1
 
-static inline void flush_icache_range(uintptr_t start, uintptr_t stop)
+/* Flush the dcache at RW, and the icache at RX, as necessary. */
+static inline void flush_idcache_range(uintptr_t rx, uintptr_t rw, size_t len)
 {
-    __builtin___clear_cache((char *)start, (char *)stop);
+    /* TODO: Copy this from gcc to avoid 4 loops instead of 2. */
+    if (rw != rx) {
+        __builtin___clear_cache((char *)rw, (char *)(rw + len));
+    }
+    __builtin___clear_cache((char *)rx, (char *)(rx + len));
 }
 
 void tb_target_set_jmp_target(uintptr_t, uintptr_t, uintptr_t);
diff --git a/tcg/arm/tcg-target.h b/tcg/arm/tcg-target.h
index 17e771374d..fa88b24e43 100644
--- a/tcg/arm/tcg-target.h
+++ b/tcg/arm/tcg-target.h
@@ -134,9 +134,13 @@ enum {
 #define TCG_TARGET_DEFAULT_MO (0)
 #define TCG_TARGET_HAS_MEMORY_BSWAP     1
 
-static inline void flush_icache_range(uintptr_t start, uintptr_t stop)
+/* Flush the dcache at RW, and the icache at RX, as necessary. */
+static inline void flush_idcache_range(uintptr_t rx, uintptr_t rw, size_t len)
 {
-    __builtin___clear_cache((char *) start, (char *) stop);
+    if (rw != rx) {
+        __builtin___clear_cache((char *)rw, (char *)(rw + len));
+    }
+    __builtin___clear_cache((char *)rx, (char *)(rx + len));
 }
 
 /* not defined -- call should be eliminated at compile time */
diff --git a/tcg/i386/tcg-target.h b/tcg/i386/tcg-target.h
index abd4ac7fc0..8323e72639 100644
--- a/tcg/i386/tcg-target.h
+++ b/tcg/i386/tcg-target.h
@@ -206,7 +206,8 @@ extern bool have_avx2;
 #define TCG_TARGET_extract_i64_valid(ofs, len) \
     (((ofs) == 8 && (len) == 8) || ((ofs) + (len)) == 32)
 
-static inline void flush_icache_range(uintptr_t start, uintptr_t stop)
+/* Flush the dcache at RW, and the icache at RX, as necessary. */
+static inline void flush_idcache_range(uintptr_t rx, uintptr_t rw, size_t len)
 {
 }
 
diff --git a/tcg/mips/tcg-target.h b/tcg/mips/tcg-target.h
index c6b091d849..47b1226ee9 100644
--- a/tcg/mips/tcg-target.h
+++ b/tcg/mips/tcg-target.h
@@ -207,9 +207,13 @@ extern bool use_mips32r2_instructions;
 #define TCG_TARGET_DEFAULT_MO (0)
 #define TCG_TARGET_HAS_MEMORY_BSWAP     1
 
-static inline void flush_icache_range(uintptr_t start, uintptr_t stop)
+/* Flush the dcache at RW, and the icache at RX, as necessary. */
+static inline void flush_idcache_range(uintptr_t rx, uintptr_t rw, size_t len)
 {
-    cacheflush ((void *)start, stop-start, ICACHE);
+    if (rx != rw) {
+        cacheflush((void *)rw, len, DCACHE);
+    }
+    cacheflush((void *)rx, len, ICACHE);
 }
 
 void tb_target_set_jmp_target(uintptr_t, uintptr_t, uintptr_t);
diff --git a/tcg/ppc/tcg-target.h b/tcg/ppc/tcg-target.h
index be10363956..fbb6dc1b47 100644
--- a/tcg/ppc/tcg-target.h
+++ b/tcg/ppc/tcg-target.h
@@ -175,7 +175,7 @@ extern bool have_vsx;
 #define TCG_TARGET_HAS_bitsel_vec       have_vsx
 #define TCG_TARGET_HAS_cmpsel_vec       0
 
-void flush_icache_range(uintptr_t start, uintptr_t stop);
+void flush_idcache_range(uintptr_t rx, uintptr_t rw, size_t len);
 void tb_target_set_jmp_target(uintptr_t, uintptr_t, uintptr_t);
 
 #define TCG_TARGET_DEFAULT_MO (0)
diff --git a/tcg/riscv/tcg-target.h b/tcg/riscv/tcg-target.h
index 032439d806..0fa6ae358e 100644
--- a/tcg/riscv/tcg-target.h
+++ b/tcg/riscv/tcg-target.h
@@ -159,9 +159,13 @@ typedef enum {
 #define TCG_TARGET_HAS_mulsh_i64        1
 #endif
 
-static inline void flush_icache_range(uintptr_t start, uintptr_t stop)
+/* Flush the dcache at RW, and the icache at RX, as necessary. */
+static inline void flush_idcache_range(uintptr_t rx, uintptr_t rw, size_t len)
 {
-    __builtin___clear_cache((char *)start, (char *)stop);
+    if (rx != rw) {
+        __builtin___clear_cache((char *)rw, (char *)(rw + len));
+    }
+    __builtin___clear_cache((char *)rx, (char *)(rx + len));
 }
 
 /* not defined -- call should be eliminated at compile time */
diff --git a/tcg/s390/tcg-target.h b/tcg/s390/tcg-target.h
index 63c8797bd3..c3dc2e8938 100644
--- a/tcg/s390/tcg-target.h
+++ b/tcg/s390/tcg-target.h
@@ -145,7 +145,8 @@ enum {
     TCG_AREG0 = TCG_REG_R10,
 };
 
-static inline void flush_icache_range(uintptr_t start, uintptr_t stop)
+/* Flush the dcache at RW, and the icache at RX, as necessary. */
+static inline void flush_idcache_range(uintptr_t rx, uintptr_t rw, size_t len)
 {
 }
 
diff --git a/tcg/sparc/tcg-target.h b/tcg/sparc/tcg-target.h
index 633841ebf2..c27c40231e 100644
--- a/tcg/sparc/tcg-target.h
+++ b/tcg/sparc/tcg-target.h
@@ -168,10 +168,12 @@ extern bool use_vis3_instructions;
 #define TCG_TARGET_DEFAULT_MO (0)
 #define TCG_TARGET_HAS_MEMORY_BSWAP     1
 
-static inline void flush_icache_range(uintptr_t start, uintptr_t stop)
+/* Flush the dcache at RW, and the icache at RX, as necessary. */
+static inline void flush_idcache_range(uintptr_t rx, uintptr_t rw, size_t len)
 {
-    uintptr_t p;
-    for (p = start & -8; p < ((stop + 7) & -8); p += 8) {
+    /* No additional data flush to the RW virtual address required. */
+    uintptr_t p, end = (rx + len + 7) & -8;
+    for (p = rx & -8; p < end; p += 8) {
         __asm__ __volatile__("flush\t%0" : : "r" (p));
     }
 }
diff --git a/tcg/tci/tcg-target.h b/tcg/tci/tcg-target.h
index 8c1c1d265d..6460449719 100644
--- a/tcg/tci/tcg-target.h
+++ b/tcg/tci/tcg-target.h
@@ -191,7 +191,8 @@ void tci_disas(uint8_t opc);
 
 #define HAVE_TCG_QEMU_TB_EXEC
 
-static inline void flush_icache_range(uintptr_t start, uintptr_t stop)
+/* Flush the dcache at RW, and the icache at RX, as necessary. */
+static inline void flush_idcache_range(uintptr_t rx, uintptr_t rw, size_t len)
 {
 }
 
diff --git a/softmmu/physmem.c b/softmmu/physmem.c
index 0b31be2928..d1e2da5502 100644
--- a/softmmu/physmem.c
+++ b/softmmu/physmem.c
@@ -2946,7 +2946,14 @@ static inline MemTxResult address_space_write_rom_internal(AddressSpace *as,
                 invalidate_and_set_dirty(mr, addr1, l);
                 break;
             case FLUSH_CACHE:
-                flush_icache_range((uintptr_t)ram_ptr, (uintptr_t)ram_ptr + l);
+                /*
+                 * FIXME: This function is currently located in tcg/host/,
+                 * but we never come here when tcg is enabled; only for
+                 * real hardware acceleration.  This can actively fail
+                 * when TCI is configured, since that function is a nop.
+                 * We should move this to util/ or something.
+                 */
+                flush_idcache_range((uintptr_t)ram_ptr, (uintptr_t)ram_ptr, l);
                 break;
             }
         }
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 43c6cf8f52..d5a72c226f 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1077,7 +1077,8 @@ void tcg_prologue_init(TCGContext *s)
 #endif
 
     buf1 = s->code_ptr;
-    flush_icache_range((uintptr_t)buf0, (uintptr_t)buf1);
+    flush_idcache_range((uintptr_t)buf0, (uintptr_t)buf0,
+                        tcg_ptr_byte_diff(buf1, buf0));
 
     /* Deduct the prologue from the buffer.  */
     prologue_size = tcg_current_code_size(s);
@@ -4320,7 +4321,8 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb)
     }
 
     /* flush instruction cache */
-    flush_icache_range((uintptr_t)s->code_buf, (uintptr_t)s->code_ptr);
+    flush_idcache_range((uintptr_t)s->code_buf, (uintptr_t)s->code_buf,
+                        tcg_ptr_byte_diff(s->code_ptr, s->code_buf));
 
     return tcg_current_code_size(s);
 }
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index 26f71cb599..83af3108a4 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -1363,7 +1363,7 @@ void tb_target_set_jmp_target(uintptr_t tc_ptr, uintptr_t jmp_addr,
     }
     pair = (uint64_t)i2 << 32 | i1;
     qatomic_set((uint64_t *)jmp_addr, pair);
-    flush_icache_range(jmp_addr, jmp_addr + 8);
+    flush_idcache_range(jmp_addr, jmp_addr, 8);
 }
 
 static inline void tcg_out_goto_label(TCGContext *s, TCGLabel *l)
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index 41be574e89..c255ecb444 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -2660,7 +2660,7 @@ void tb_target_set_jmp_target(uintptr_t tc_ptr, uintptr_t jmp_addr,
                               uintptr_t addr)
 {
     qatomic_set((uint32_t *)jmp_addr, deposit32(OPC_J, 0, 26, addr >> 2));
-    flush_icache_range(jmp_addr, jmp_addr + 4);
+    flush_idcache_range(jmp_addr, jmp_addr, 4);
 }
 
 typedef struct {
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 18ee989f95..a848e98383 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -1753,12 +1753,12 @@ void tb_target_set_jmp_target(uintptr_t tc_ptr, uintptr_t jmp_addr,
         /* As per the enclosing if, this is ppc64.  Avoid the _Static_assert
            within qatomic_set that would fail to build a ppc32 host.  */
         qatomic_set__nocheck((uint64_t *)jmp_addr, pair);
-        flush_icache_range(jmp_addr, jmp_addr + 8);
+        flush_idcache_range(jmp_addr, jmp_addr, 8);
     } else {
         intptr_t diff = addr - jmp_addr;
         tcg_debug_assert(in_range_b(diff));
         qatomic_set((uint32_t *)jmp_addr, B | (diff & 0x3fffffc));
-        flush_icache_range(jmp_addr, jmp_addr + 4);
+        flush_idcache_range(jmp_addr, jmp_addr, 4);
     }
 }
 
@@ -3864,22 +3864,23 @@ void tcg_register_jit(void *buf, size_t buf_size)
 }
 #endif /* __ELF__ */
 
-void flush_icache_range(uintptr_t start, uintptr_t stop)
+/* Flush the dcache at RW, and the icache at RX, as necessary. */
+void flush_idcache_range(uintptr_t rx, uintptr_t rw, uintptr_t len)
 {
-    uintptr_t p, start1, stop1;
+    uintptr_t p, start, stop;
     size_t dsize = qemu_dcache_linesize;
     size_t isize = qemu_icache_linesize;
 
-    start1 = start & ~(dsize - 1);
-    stop1 = (stop + dsize - 1) & ~(dsize - 1);
-    for (p = start1; p < stop1; p += dsize) {
+    start = rw & ~(dsize - 1);
+    stop = (rw + len + dsize - 1) & ~(dsize - 1);
+    for (p = start; p < stop; p += dsize) {
         asm volatile ("dcbst 0,%0" : : "r"(p) : "memory");
     }
     asm volatile ("sync" : : : "memory");
 
-    start &= start & ~(isize - 1);
-    stop1 = (stop + isize - 1) & ~(isize - 1);
-    for (p = start1; p < stop1; p += isize) {
+    start = rx & ~(isize - 1);
+    stop = (rx + len + isize - 1) & ~(isize - 1);
+    for (p = start; p < stop; p += isize) {
         asm volatile ("icbi 0,%0" : : "r"(p) : "memory");
     }
     asm volatile ("sync" : : : "memory");
diff --git a/tcg/sparc/tcg-target.c.inc b/tcg/sparc/tcg-target.c.inc
index 6775bd30fc..6e2d755f6a 100644
--- a/tcg/sparc/tcg-target.c.inc
+++ b/tcg/sparc/tcg-target.c.inc
@@ -1836,7 +1836,7 @@ void tb_target_set_jmp_target(uintptr_t tc_ptr, uintptr_t jmp_addr,
     if (!USE_REG_TB) {
         qatomic_set((uint32_t *)jmp_addr,
 		    deposit32(CALL, 0, 30, br_disp >> 2));
-        flush_icache_range(jmp_addr, jmp_addr + 4);
+        flush_idcache_range(jmp_addr, jmp_addr, 4);
         return;
     }
 
@@ -1860,5 +1860,5 @@ void tb_target_set_jmp_target(uintptr_t tc_ptr, uintptr_t jmp_addr,
     }
 
     qatomic_set((uint64_t *)jmp_addr, deposit64(i2, 32, 32, i1));
-    flush_icache_range(jmp_addr, jmp_addr + 8);
+    flush_idcache_range(jmp_addr, jmp_addr, 8);
 }
-- 
2.25.1


