Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CEC6C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 18:40:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42D7320679
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 18:40:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JxG3+9NI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42D7320679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46306 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDufX-00069D-EJ
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 14:40:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45729)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jDtRj-0001Jn-RW
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:22:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jDtRa-0001Ui-23
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:22:35 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:42656)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jDtRZ-0001Kk-G1
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:22:25 -0400
Received: by mail-wr1-x444.google.com with SMTP id v11so22296092wrm.9
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 10:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=WLNIZj3cnPDj3s/Uqj/ZpGg7EFBhzF1GZpdh+YhYmoE=;
 b=JxG3+9NIzkVo+tUdoLhlqVkwUeRn+Tr64AqFMm49U73/x6WN9ZI16q3SGJ4iXL1K2T
 akMh9ikIu5ZhpkKNEmoG4kZ58h5Oq4y4+I8DpAKZoayw/UPd1b0XIBE2xezlaBg+BYHW
 ekvnlRWWwUzERNafTQVR2HhRtGNxTga3xF8Td2V9dzzERnBcKD3QZZ2ENc9DTfmyDMWb
 0MnsZDBj45ETE4jye/BOo7SC10put69wItDAhkcOkFV7G6uDPw6jh9PZA9LjlZFtDlf2
 nSGXAJvny43U6fl788WSs76x0pytOE76/vD5yWh0xzlxRj+SsNq8RpLHKlu1TT0VdlQg
 vBsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=WLNIZj3cnPDj3s/Uqj/ZpGg7EFBhzF1GZpdh+YhYmoE=;
 b=f+llmxBqshQcFeJ8UJNBSkh4OF3m9bylNGmGnvB9oL4Qj1UpbimecsPVR4DFFqrjjd
 MBP2znit84YiI94/DhnynO3uBKl6Zs9qFtBAwarwchp7HkXvBOjs8R2FHYYJf/rGlCaY
 rG1ZXu0NdYMh/fplI/h9LTwn29X8TXvlgj4pOw5i8Jb2L5hrYBIvqowYUcdEEi74y9Z5
 mJ5SRWEM2tBvkW14XNlkhr5UgGXd2XAhnOnrgmdwz//RhqnyAHkuUfpKyI2msorSGyok
 RHrJJhUzfjk15DrEaWT8/ZD9/n012cKyd5+rCVUIGkbZTU00ME2C3NcJ+LVfWOryHxae
 zZwg==
X-Gm-Message-State: ANhLgQ2YwXKNWVY11gFFRnEKHnU2+fEtgbWKaIi1QoULAo/obI2SXqKP
 aMSd0M6MS4dv6PHZrouCyId2zg==
X-Google-Smtp-Source: ADFU+vvbS8TDc72ukzwIOhmAVwuBR35OdFd0Sn4GMUPdKJtl0io6d8JSuJGdSoaJQQYbYDK2ISVIUA==
X-Received: by 2002:adf:f148:: with SMTP id y8mr400717wro.322.1584379343589;
 Mon, 16 Mar 2020 10:22:23 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id g127sm491853wmf.10.2020.03.16.10.22.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 10:22:13 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id AE64F1FF9D;
 Mon, 16 Mar 2020 17:21:56 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 14/28] gdbstub: extend GByteArray to read register helpers
Date: Mon, 16 Mar 2020 17:21:41 +0000
Message-Id: <20200316172155.971-15-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200316172155.971-1-alex.bennee@linaro.org>
References: <20200316172155.971-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Cornelia Huck <cohuck@redhat.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 David Hildenbrand <david@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Max Filippov <jcmvbkbc@gmail.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Marek Vasut <marex@denx.de>,
 "open list:PowerPC TCG CPUs" <qemu-ppc@nongnu.org>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "open list:S390 TCG CPUs" <qemu-s390x@nongnu.org>, qemu-arm@nongnu.org,
 Stafford Horne <shorne@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>, Damien Hedde <damien.hedde@greensocs.com>,
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Chris Wulff <crwulff@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Michael Walle <michael@walle.cc>, Palmer Dabbelt <palmer@dabbelt.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Instead of passing a pointer to memory now just extend the GByteArray
to all the read register helpers. They can then safely append their
data through the normal way. We don't bother with this abstraction for
write registers as we have already ensured the buffer being copied
from is the correct size.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Damien Hedde <damien.hedde@greensocs.com>

---
v4
  - fix mem_buf calculation for ppc_maybe_bswap_register
v5
  - introduce gdb_get_reg_ptr and use for ppc
---
 include/exec/gdbstub.h          | 59 +++++++++++++++++++++++----------
 include/hw/core/cpu.h           |  2 +-
 target/alpha/cpu.h              |  2 +-
 target/arm/cpu.h                |  4 +--
 target/cris/cpu.h               |  4 +--
 target/hppa/cpu.h               |  2 +-
 target/i386/cpu.h               |  2 +-
 target/lm32/cpu.h               |  2 +-
 target/m68k/cpu.h               |  2 +-
 target/microblaze/cpu.h         |  2 +-
 target/mips/internal.h          |  2 +-
 target/openrisc/cpu.h           |  2 +-
 target/ppc/cpu.h                |  4 +--
 target/riscv/cpu.h              |  2 +-
 target/s390x/internal.h         |  2 +-
 target/sh4/cpu.h                |  2 +-
 target/sparc/cpu.h              |  2 +-
 target/xtensa/cpu.h             |  2 +-
 gdbstub.c                       | 20 +++++------
 hw/core/cpu.c                   |  2 +-
 target/alpha/gdbstub.c          |  2 +-
 target/arm/gdbstub.c            |  2 +-
 target/arm/gdbstub64.c          |  2 +-
 target/arm/helper.c             | 19 +++++------
 target/cris/gdbstub.c           |  4 +--
 target/hppa/gdbstub.c           |  2 +-
 target/i386/gdbstub.c           |  2 +-
 target/lm32/gdbstub.c           |  2 +-
 target/m68k/gdbstub.c           |  2 +-
 target/m68k/helper.c            |  4 +--
 target/microblaze/gdbstub.c     |  2 +-
 target/mips/gdbstub.c           |  2 +-
 target/nios2/cpu.c              |  2 +-
 target/openrisc/gdbstub.c       |  2 +-
 target/ppc/gdbstub.c            | 48 +++++++++++++++------------
 target/ppc/translate_init.inc.c | 54 ++++++++++++++++--------------
 target/riscv/gdbstub.c          | 20 +++++------
 target/s390x/gdbstub.c          | 30 ++++++++---------
 target/sh4/gdbstub.c            |  2 +-
 target/sparc/gdbstub.c          |  2 +-
 target/xtensa/gdbstub.c         |  2 +-
 41 files changed, 179 insertions(+), 149 deletions(-)

diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
index 59e366ba3af..30b909ebd27 100644
--- a/include/exec/gdbstub.h
+++ b/include/exec/gdbstub.h
@@ -68,53 +68,76 @@ void gdb_signalled(CPUArchState *, int);
 void gdbserver_fork(CPUState *);
 #endif
 /* Get or set a register.  Returns the size of the register.  */
-typedef int (*gdb_reg_cb)(CPUArchState *env, uint8_t *buf, int reg);
+typedef int (*gdb_get_reg_cb)(CPUArchState *env, GByteArray *buf, int reg);
+typedef int (*gdb_set_reg_cb)(CPUArchState *env, uint8_t *buf, int reg);
 void gdb_register_coprocessor(CPUState *cpu,
-                              gdb_reg_cb get_reg, gdb_reg_cb set_reg,
+                              gdb_get_reg_cb get_reg, gdb_set_reg_cb set_reg,
                               int num_regs, const char *xml, int g_pos);
 
-/* The GDB remote protocol transfers values in target byte order.  This means
- * we can use the raw memory access routines to access the value buffer.
- * Conveniently, these also handle the case where the buffer is mis-aligned.
+/*
+ * The GDB remote protocol transfers values in target byte order. As
+ * the gdbstub may be batching up several register values we always
+ * append to the array.
  */
 
-static inline int gdb_get_reg8(uint8_t *mem_buf, uint8_t val)
+static inline int gdb_get_reg8(GByteArray *buf, uint8_t val)
 {
-    stb_p(mem_buf, val);
+    g_byte_array_append(buf, &val, 1);
     return 1;
 }
 
-static inline int gdb_get_reg16(uint8_t *mem_buf, uint16_t val)
+static inline int gdb_get_reg16(GByteArray *buf, uint16_t val)
 {
-    stw_p(mem_buf, val);
+    uint16_t to_word = tswap16(val);
+    g_byte_array_append(buf, (uint8_t *) &to_word, 2);
     return 2;
 }
 
-static inline int gdb_get_reg32(uint8_t *mem_buf, uint32_t val)
+static inline int gdb_get_reg32(GByteArray *buf, uint32_t val)
 {
-    stl_p(mem_buf, val);
+    uint32_t to_long = tswap32(val);
+    g_byte_array_append(buf, (uint8_t *) &to_long, 4);
     return 4;
 }
 
-static inline int gdb_get_reg64(uint8_t *mem_buf, uint64_t val)
+static inline int gdb_get_reg64(GByteArray *buf, uint64_t val)
 {
-    stq_p(mem_buf, val);
+    uint64_t to_quad = tswap64(val);
+    g_byte_array_append(buf, (uint8_t *) &to_quad, 8);
     return 8;
 }
 
-static inline int gdb_get_reg128(uint8_t *mem_buf, uint64_t val_hi,
+static inline int gdb_get_reg128(GByteArray *buf, uint64_t val_hi,
                                  uint64_t val_lo)
 {
+    uint64_t to_quad;
 #ifdef TARGET_WORDS_BIGENDIAN
-    stq_p(mem_buf, val_hi);
-    stq_p(mem_buf + 8, val_lo);
+    to_quad = tswap64(val_hi);
+    g_byte_array_append(buf, (uint8_t *) &to_quad, 8);
+    to_quad = tswap64(val_lo);
+    g_byte_array_append(buf, (uint8_t *) &to_quad, 8);
 #else
-    stq_p(mem_buf, val_lo);
-    stq_p(mem_buf + 8, val_hi);
+    to_quad = tswap64(val_lo);
+    g_byte_array_append(buf, (uint8_t *) &to_quad, 8);
+    to_quad = tswap64(val_hi);
+    g_byte_array_append(buf, (uint8_t *) &to_quad, 8);
 #endif
     return 16;
 }
 
+/**
+ * gdb_get_reg_ptr: get pointer to start of last element
+ * @len: length of element
+ *
+ * This is a helper function to extract the pointer to the last
+ * element for additional processing. Some front-ends do additional
+ * dynamic swapping of the elements based on CPU state.
+ */
+static inline uint8_t * gdb_get_reg_ptr(GByteArray *buf, int len)
+{
+    return buf->data + buf->len - len;
+}
+
 #if TARGET_LONG_BITS == 64
 #define gdb_get_regl(buf, val) gdb_get_reg64(buf, val)
 #define ldtul_p(addr) ldq_p(addr)
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 73e9a869a41..e1d6ee00b40 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -195,7 +195,7 @@ typedef struct CPUClass {
     hwaddr (*get_phys_page_attrs_debug)(CPUState *cpu, vaddr addr,
                                         MemTxAttrs *attrs);
     int (*asidx_from_attrs)(CPUState *cpu, MemTxAttrs attrs);
-    int (*gdb_read_register)(CPUState *cpu, uint8_t *buf, int reg);
+    int (*gdb_read_register)(CPUState *cpu, GByteArray *buf, int reg);
     int (*gdb_write_register)(CPUState *cpu, uint8_t *buf, int reg);
     bool (*debug_check_watchpoint)(CPUState *cpu, CPUWatchpoint *wp);
     void (*debug_excp_handler)(CPUState *cpu);
diff --git a/target/alpha/cpu.h b/target/alpha/cpu.h
index 3f782c0efe4..be29bdd5301 100644
--- a/target/alpha/cpu.h
+++ b/target/alpha/cpu.h
@@ -280,7 +280,7 @@ void alpha_cpu_do_interrupt(CPUState *cpu);
 bool alpha_cpu_exec_interrupt(CPUState *cpu, int int_req);
 void alpha_cpu_dump_state(CPUState *cs, FILE *f, int flags);
 hwaddr alpha_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
-int alpha_cpu_gdb_read_register(CPUState *cpu, uint8_t *buf, int reg);
+int alpha_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
 int alpha_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 void alpha_cpu_do_unaligned_access(CPUState *cpu, vaddr addr,
                                    MMUAccessType access_type,
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 4ffd991b6fc..4ab2cbfd417 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -968,7 +968,7 @@ bool arm_cpu_exec_interrupt(CPUState *cpu, int int_req);
 hwaddr arm_cpu_get_phys_page_attrs_debug(CPUState *cpu, vaddr addr,
                                          MemTxAttrs *attrs);
 
-int arm_cpu_gdb_read_register(CPUState *cpu, uint8_t *buf, int reg);
+int arm_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
 int arm_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 
 /* Dynamically generates for gdb stub an XML description of the sysregs from
@@ -988,7 +988,7 @@ int arm_cpu_write_elf32_note(WriteCoreDumpFunction f, CPUState *cs,
                              int cpuid, void *opaque);
 
 #ifdef TARGET_AARCH64
-int aarch64_cpu_gdb_read_register(CPUState *cpu, uint8_t *buf, int reg);
+int aarch64_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
 int aarch64_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 void aarch64_sve_narrow_vq(CPUARMState *env, unsigned vq);
 void aarch64_sve_change_el(CPUARMState *env, int old_el,
diff --git a/target/cris/cpu.h b/target/cris/cpu.h
index ca240bc7881..8f08d7628b2 100644
--- a/target/cris/cpu.h
+++ b/target/cris/cpu.h
@@ -195,8 +195,8 @@ void cris_cpu_dump_state(CPUState *cs, FILE *f, int flags);
 
 hwaddr cris_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
 
-int crisv10_cpu_gdb_read_register(CPUState *cpu, uint8_t *buf, int reg);
-int cris_cpu_gdb_read_register(CPUState *cpu, uint8_t *buf, int reg);
+int crisv10_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
+int cris_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
 int cris_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 
 /* you can call this signal handler from your SIGBUS and SIGSEGV
diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index 6713d04f111..801a4fb1bae 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -321,7 +321,7 @@ void cpu_hppa_change_prot_id(CPUHPPAState *env);
 
 int cpu_hppa_signal_handler(int host_signum, void *pinfo, void *puc);
 hwaddr hppa_cpu_get_phys_page_debug(CPUState *cs, vaddr addr);
-int hppa_cpu_gdb_read_register(CPUState *cpu, uint8_t *buf, int reg);
+int hppa_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
 int hppa_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 void hppa_cpu_do_interrupt(CPUState *cpu);
 bool hppa_cpu_exec_interrupt(CPUState *cpu, int int_req);
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 576f309bbfc..c2d89315b92 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1766,7 +1766,7 @@ void x86_cpu_dump_state(CPUState *cs, FILE *f, int flags);
 hwaddr x86_cpu_get_phys_page_attrs_debug(CPUState *cpu, vaddr addr,
                                          MemTxAttrs *attrs);
 
-int x86_cpu_gdb_read_register(CPUState *cpu, uint8_t *buf, int reg);
+int x86_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
 int x86_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 
 void x86_cpu_exec_enter(CPUState *cpu);
diff --git a/target/lm32/cpu.h b/target/lm32/cpu.h
index 064c6b1267e..01d408eb55d 100644
--- a/target/lm32/cpu.h
+++ b/target/lm32/cpu.h
@@ -202,7 +202,7 @@ void lm32_cpu_do_interrupt(CPUState *cpu);
 bool lm32_cpu_exec_interrupt(CPUState *cs, int int_req);
 void lm32_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
 hwaddr lm32_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
-int lm32_cpu_gdb_read_register(CPUState *cpu, uint8_t *buf, int reg);
+int lm32_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
 int lm32_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 
 typedef enum {
diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index 3de8e06dfec..521ac67cdd0 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -168,7 +168,7 @@ void m68k_cpu_do_interrupt(CPUState *cpu);
 bool m68k_cpu_exec_interrupt(CPUState *cpu, int int_req);
 void m68k_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
 hwaddr m68k_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
-int m68k_cpu_gdb_read_register(CPUState *cpu, uint8_t *buf, int reg);
+int m68k_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
 int m68k_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 
 void m68k_tcg_init(void);
diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index 32522f606bd..1a700a880c5 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -313,7 +313,7 @@ void mb_cpu_do_interrupt(CPUState *cs);
 bool mb_cpu_exec_interrupt(CPUState *cs, int int_req);
 void mb_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
 hwaddr mb_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
-int mb_cpu_gdb_read_register(CPUState *cpu, uint8_t *buf, int reg);
+int mb_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
 int mb_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 
 void mb_tcg_init(void);
diff --git a/target/mips/internal.h b/target/mips/internal.h
index df55f845baf..1bf274b3ef5 100644
--- a/target/mips/internal.h
+++ b/target/mips/internal.h
@@ -82,7 +82,7 @@ void mips_cpu_do_interrupt(CPUState *cpu);
 bool mips_cpu_exec_interrupt(CPUState *cpu, int int_req);
 void mips_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
 hwaddr mips_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
-int mips_cpu_gdb_read_register(CPUState *cpu, uint8_t *buf, int reg);
+int mips_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
 int mips_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 void mips_cpu_do_unaligned_access(CPUState *cpu, vaddr addr,
                                   MMUAccessType access_type,
diff --git a/target/openrisc/cpu.h b/target/openrisc/cpu.h
index 0ad02eab794..d9484b802f3 100644
--- a/target/openrisc/cpu.h
+++ b/target/openrisc/cpu.h
@@ -320,7 +320,7 @@ void openrisc_cpu_do_interrupt(CPUState *cpu);
 bool openrisc_cpu_exec_interrupt(CPUState *cpu, int int_req);
 void openrisc_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
 hwaddr openrisc_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
-int openrisc_cpu_gdb_read_register(CPUState *cpu, uint8_t *buf, int reg);
+int openrisc_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
 int openrisc_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 void openrisc_translate_init(void);
 bool openrisc_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index b283042515f..5fd081573ef 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1218,8 +1218,8 @@ bool ppc_cpu_exec_interrupt(CPUState *cpu, int int_req);
 void ppc_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
 void ppc_cpu_dump_statistics(CPUState *cpu, int flags);
 hwaddr ppc_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
-int ppc_cpu_gdb_read_register(CPUState *cpu, uint8_t *buf, int reg);
-int ppc_cpu_gdb_read_register_apple(CPUState *cpu, uint8_t *buf, int reg);
+int ppc_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
+int ppc_cpu_gdb_read_register_apple(CPUState *cpu, GByteArray *buf, int reg);
 int ppc_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 int ppc_cpu_gdb_write_register_apple(CPUState *cpu, uint8_t *buf, int reg);
 #ifndef CONFIG_USER_ONLY
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 3dcdf922272..31458c5b4a7 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -293,7 +293,7 @@ extern const char * const riscv_excp_names[];
 extern const char * const riscv_intr_names[];
 
 void riscv_cpu_do_interrupt(CPUState *cpu);
-int riscv_cpu_gdb_read_register(CPUState *cpu, uint8_t *buf, int reg);
+int riscv_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
 int riscv_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 bool riscv_cpu_exec_interrupt(CPUState *cs, int interrupt_request);
 bool riscv_cpu_fp_enabled(CPURISCVState *env);
diff --git a/target/s390x/internal.h b/target/s390x/internal.h
index d37816104dd..8c95c734dbe 100644
--- a/target/s390x/internal.h
+++ b/target/s390x/internal.h
@@ -292,7 +292,7 @@ uint16_t float128_dcmask(CPUS390XState *env, float128 f1);
 
 
 /* gdbstub.c */
-int s390_cpu_gdb_read_register(CPUState *cpu, uint8_t *buf, int reg);
+int s390_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
 int s390_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 void s390_cpu_gdb_init(CPUState *cs);
 
diff --git a/target/sh4/cpu.h b/target/sh4/cpu.h
index 452a596e671..dbe58c7888f 100644
--- a/target/sh4/cpu.h
+++ b/target/sh4/cpu.h
@@ -208,7 +208,7 @@ void superh_cpu_do_interrupt(CPUState *cpu);
 bool superh_cpu_exec_interrupt(CPUState *cpu, int int_req);
 void superh_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
 hwaddr superh_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
-int superh_cpu_gdb_read_register(CPUState *cpu, uint8_t *buf, int reg);
+int superh_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
 int superh_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 void superh_cpu_do_unaligned_access(CPUState *cpu, vaddr addr,
                                     MMUAccessType access_type,
diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index ae97c7d9f79..b9369398f24 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -571,7 +571,7 @@ extern const VMStateDescription vmstate_sparc_cpu;
 void sparc_cpu_do_interrupt(CPUState *cpu);
 void sparc_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
 hwaddr sparc_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
-int sparc_cpu_gdb_read_register(CPUState *cpu, uint8_t *buf, int reg);
+int sparc_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
 int sparc_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 void QEMU_NORETURN sparc_cpu_do_unaligned_access(CPUState *cpu, vaddr addr,
                                                  MMUAccessType access_type,
diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index 493f4fc80c5..c0d69fad96c 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -569,7 +569,7 @@ void xtensa_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
 hwaddr xtensa_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
 void xtensa_count_regs(const XtensaConfig *config,
                        unsigned *n_regs, unsigned *n_core_regs);
-int xtensa_cpu_gdb_read_register(CPUState *cpu, uint8_t *buf, int reg);
+int xtensa_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
 int xtensa_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 void xtensa_cpu_do_unaligned_access(CPUState *cpu, vaddr addr,
                                     MMUAccessType access_type,
diff --git a/gdbstub.c b/gdbstub.c
index db537a712cc..0bcfc47a7c5 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -319,8 +319,8 @@ static int gdb_signal_to_target (int sig)
 typedef struct GDBRegisterState {
     int base_reg;
     int num_regs;
-    gdb_reg_cb get_reg;
-    gdb_reg_cb set_reg;
+    gdb_get_reg_cb get_reg;
+    gdb_set_reg_cb set_reg;
     const char *xml;
     struct GDBRegisterState *next;
 } GDBRegisterState;
@@ -905,19 +905,19 @@ static const char *get_feature_xml(const char *p, const char **newp,
     return name ? xml_builtin[i][1] : NULL;
 }
 
-static int gdb_read_register(CPUState *cpu, uint8_t *mem_buf, int reg)
+static int gdb_read_register(CPUState *cpu, GByteArray *buf, int reg)
 {
     CPUClass *cc = CPU_GET_CLASS(cpu);
     CPUArchState *env = cpu->env_ptr;
     GDBRegisterState *r;
 
     if (reg < cc->gdb_num_core_regs) {
-        return cc->gdb_read_register(cpu, mem_buf, reg);
+        return cc->gdb_read_register(cpu, buf, reg);
     }
 
     for (r = cpu->gdb_regs; r; r = r->next) {
         if (r->base_reg <= reg && reg < r->base_reg + r->num_regs) {
-            return r->get_reg(env, mem_buf, reg - r->base_reg);
+            return r->get_reg(env, buf, reg - r->base_reg);
         }
     }
     return 0;
@@ -948,7 +948,7 @@ static int gdb_write_register(CPUState *cpu, uint8_t *mem_buf, int reg)
  */
 
 void gdb_register_coprocessor(CPUState *cpu,
-                              gdb_reg_cb get_reg, gdb_reg_cb set_reg,
+                              gdb_get_reg_cb get_reg, gdb_set_reg_cb set_reg,
                               int num_regs, const char *xml, int g_pos)
 {
     GDBRegisterState *s;
@@ -1739,7 +1739,7 @@ static void handle_get_reg(GdbCmdContext *gdb_ctx, void *user_ctx)
     }
 
     reg_size = gdb_read_register(gdbserver_state.g_cpu,
-                                 gdbserver_state.mem_buf->data,
+                                 gdbserver_state.mem_buf,
                                  gdb_ctx->params[0].val_ull);
     if (!reg_size) {
         put_packet("E14");
@@ -1832,14 +1832,14 @@ static void handle_read_all_regs(GdbCmdContext *gdb_ctx, void *user_ctx)
     target_ulong addr, len;
 
     cpu_synchronize_state(gdbserver_state.g_cpu);
+    g_byte_array_set_size(gdbserver_state.mem_buf, 0);
     len = 0;
     for (addr = 0; addr < gdbserver_state.g_cpu->gdb_num_g_regs; addr++) {
         len += gdb_read_register(gdbserver_state.g_cpu,
-                                 gdbserver_state.mem_buf->data + len,
+                                 gdbserver_state.mem_buf,
                                  addr);
     }
-    /* FIXME: This is after the fact sizing */
-    g_byte_array_set_size(gdbserver_state.mem_buf, len);
+    g_assert(len == gdbserver_state.mem_buf->len);
 
     memtohex(gdbserver_state.str_buf, gdbserver_state.mem_buf->data, len);
     put_strbuf();
diff --git a/hw/core/cpu.c b/hw/core/cpu.c
index fe65ca62ace..3b2363f0431 100644
--- a/hw/core/cpu.c
+++ b/hw/core/cpu.c
@@ -177,7 +177,7 @@ static int cpu_common_write_elf64_note(WriteCoreDumpFunction f,
 }
 
 
-static int cpu_common_gdb_read_register(CPUState *cpu, uint8_t *buf, int reg)
+static int cpu_common_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg)
 {
     return 0;
 }
diff --git a/target/alpha/gdbstub.c b/target/alpha/gdbstub.c
index 7f9cc092a9c..0cd76ddaa9e 100644
--- a/target/alpha/gdbstub.c
+++ b/target/alpha/gdbstub.c
@@ -21,7 +21,7 @@
 #include "cpu.h"
 #include "exec/gdbstub.h"
 
-int alpha_cpu_gdb_read_register(CPUState *cs, uint8_t *mem_buf, int n)
+int alpha_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 {
     AlphaCPU *cpu = ALPHA_CPU(cs);
     CPUAlphaState *env = &cpu->env;
diff --git a/target/arm/gdbstub.c b/target/arm/gdbstub.c
index 1239abd9842..4557775d245 100644
--- a/target/arm/gdbstub.c
+++ b/target/arm/gdbstub.c
@@ -32,7 +32,7 @@ typedef struct RegisterSysregXmlParam {
    We hack round this by giving the FPA regs zero size when talking to a
    newer gdb.  */
 
-int arm_cpu_gdb_read_register(CPUState *cs, uint8_t *mem_buf, int n)
+int arm_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 {
     ARMCPU *cpu = ARM_CPU(cs);
     CPUARMState *env = &cpu->env;
diff --git a/target/arm/gdbstub64.c b/target/arm/gdbstub64.c
index 665ebb3ef64..35d0b80c2de 100644
--- a/target/arm/gdbstub64.c
+++ b/target/arm/gdbstub64.c
@@ -20,7 +20,7 @@
 #include "cpu.h"
 #include "exec/gdbstub.h"
 
-int aarch64_cpu_gdb_read_register(CPUState *cs, uint8_t *mem_buf, int n)
+int aarch64_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 {
     ARMCPU *cpu = ARM_CPU(cs);
     CPUARMState *env = &cpu->env;
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 69104fb351d..c0e1ba17272 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -48,30 +48,27 @@ static bool get_phys_addr_lpae(CPUARMState *env, target_ulong address,
 
 static void switch_mode(CPUARMState *env, int mode);
 
-static int vfp_gdb_get_reg(CPUARMState *env, uint8_t *buf, int reg)
+static int vfp_gdb_get_reg(CPUARMState *env, GByteArray *buf, int reg)
 {
     ARMCPU *cpu = env_archcpu(env);
     int nregs = cpu_isar_feature(aa32_simd_r32, cpu) ? 32 : 16;
 
     /* VFP data registers are always little-endian.  */
     if (reg < nregs) {
-        stq_le_p(buf, *aa32_vfp_dreg(env, reg));
-        return 8;
+        return gdb_get_reg64(buf, *aa32_vfp_dreg(env, reg));
     }
     if (arm_feature(env, ARM_FEATURE_NEON)) {
         /* Aliases for Q regs.  */
         nregs += 16;
         if (reg < nregs) {
             uint64_t *q = aa32_vfp_qreg(env, reg - 32);
-            stq_le_p(buf, q[0]);
-            stq_le_p(buf + 8, q[1]);
-            return 16;
+            return gdb_get_reg128(buf, q[0], q[1]);
         }
     }
     switch (reg - nregs) {
-    case 0: stl_p(buf, env->vfp.xregs[ARM_VFP_FPSID]); return 4;
-    case 1: stl_p(buf, vfp_get_fpscr(env)); return 4;
-    case 2: stl_p(buf, env->vfp.xregs[ARM_VFP_FPEXC]); return 4;
+    case 0: return gdb_get_reg32(buf, env->vfp.xregs[ARM_VFP_FPSID]); break;
+    case 1: return gdb_get_reg32(buf, vfp_get_fpscr(env)); break;
+    case 2: return gdb_get_reg32(buf, env->vfp.xregs[ARM_VFP_FPEXC]); break;
     }
     return 0;
 }
@@ -102,7 +99,7 @@ static int vfp_gdb_set_reg(CPUARMState *env, uint8_t *buf, int reg)
     return 0;
 }
 
-static int aarch64_fpu_gdb_get_reg(CPUARMState *env, uint8_t *buf, int reg)
+static int aarch64_fpu_gdb_get_reg(CPUARMState *env, GByteArray *buf, int reg)
 {
     switch (reg) {
     case 0 ... 31:
@@ -205,7 +202,7 @@ static void write_raw_cp_reg(CPUARMState *env, const ARMCPRegInfo *ri,
     }
 }
 
-static int arm_gdb_get_sysreg(CPUARMState *env, uint8_t *buf, int reg)
+static int arm_gdb_get_sysreg(CPUARMState *env, GByteArray *buf, int reg)
 {
     ARMCPU *cpu = env_archcpu(env);
     const ARMCPRegInfo *ri;
diff --git a/target/cris/gdbstub.c b/target/cris/gdbstub.c
index a3d76d2e8c2..b01b2aa0811 100644
--- a/target/cris/gdbstub.c
+++ b/target/cris/gdbstub.c
@@ -21,7 +21,7 @@
 #include "cpu.h"
 #include "exec/gdbstub.h"
 
-int crisv10_cpu_gdb_read_register(CPUState *cs, uint8_t *mem_buf, int n)
+int crisv10_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 {
     CRISCPU *cpu = CRIS_CPU(cs);
     CPUCRISState *env = &cpu->env;
@@ -53,7 +53,7 @@ int crisv10_cpu_gdb_read_register(CPUState *cs, uint8_t *mem_buf, int n)
     return 0;
 }
 
-int cris_cpu_gdb_read_register(CPUState *cs, uint8_t *mem_buf, int n)
+int cris_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 {
     CRISCPU *cpu = CRIS_CPU(cs);
     CPUCRISState *env = &cpu->env;
diff --git a/target/hppa/gdbstub.c b/target/hppa/gdbstub.c
index 341888a9da0..a6428a2893f 100644
--- a/target/hppa/gdbstub.c
+++ b/target/hppa/gdbstub.c
@@ -21,7 +21,7 @@
 #include "cpu.h"
 #include "exec/gdbstub.h"
 
-int hppa_cpu_gdb_read_register(CPUState *cs, uint8_t *mem_buf, int n)
+int hppa_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 {
     HPPACPU *cpu = HPPA_CPU(cs);
     CPUHPPAState *env = &cpu->env;
diff --git a/target/i386/gdbstub.c b/target/i386/gdbstub.c
index e4d8cb66c00..f3d23b614ee 100644
--- a/target/i386/gdbstub.c
+++ b/target/i386/gdbstub.c
@@ -79,7 +79,7 @@ static const int gpr_map32[8] = { 0, 1, 2, 3, 4, 5, 6, 7 };
 #endif
 
 
-int x86_cpu_gdb_read_register(CPUState *cs, uint8_t *mem_buf, int n)
+int x86_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 {
     X86CPU *cpu = X86_CPU(cs);
     CPUX86State *env = &cpu->env;
diff --git a/target/lm32/gdbstub.c b/target/lm32/gdbstub.c
index 82ede436e12..b6fe12e1d61 100644
--- a/target/lm32/gdbstub.c
+++ b/target/lm32/gdbstub.c
@@ -22,7 +22,7 @@
 #include "exec/gdbstub.h"
 #include "hw/lm32/lm32_pic.h"
 
-int lm32_cpu_gdb_read_register(CPUState *cs, uint8_t *mem_buf, int n)
+int lm32_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 {
     LM32CPU *cpu = LM32_CPU(cs);
     CPULM32State *env = &cpu->env;
diff --git a/target/m68k/gdbstub.c b/target/m68k/gdbstub.c
index fdc96f57fff..eb2d030e148 100644
--- a/target/m68k/gdbstub.c
+++ b/target/m68k/gdbstub.c
@@ -21,7 +21,7 @@
 #include "cpu.h"
 #include "exec/gdbstub.h"
 
-int m68k_cpu_gdb_read_register(CPUState *cs, uint8_t *mem_buf, int n)
+int m68k_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 {
     M68kCPU *cpu = M68K_CPU(cs);
     CPUM68KState *env = &cpu->env;
diff --git a/target/m68k/helper.c b/target/m68k/helper.c
index c23b70f854d..014657c6372 100644
--- a/target/m68k/helper.c
+++ b/target/m68k/helper.c
@@ -68,7 +68,7 @@ void m68k_cpu_list(void)
     g_slist_free(list);
 }
 
-static int cf_fpu_gdb_get_reg(CPUM68KState *env, uint8_t *mem_buf, int n)
+static int cf_fpu_gdb_get_reg(CPUM68KState *env, GByteArray *mem_buf, int n)
 {
     if (n < 8) {
         float_status s;
@@ -105,7 +105,7 @@ static int cf_fpu_gdb_set_reg(CPUM68KState *env, uint8_t *mem_buf, int n)
     return 0;
 }
 
-static int m68k_fpu_gdb_get_reg(CPUM68KState *env, uint8_t *mem_buf, int n)
+static int m68k_fpu_gdb_get_reg(CPUM68KState *env, GByteArray *mem_buf, int n)
 {
     if (n < 8) {
         int len = gdb_get_reg16(mem_buf, env->fregs[n].l.upper);
diff --git a/target/microblaze/gdbstub.c b/target/microblaze/gdbstub.c
index 30677b6d1f4..f41ebf1f33b 100644
--- a/target/microblaze/gdbstub.c
+++ b/target/microblaze/gdbstub.c
@@ -21,7 +21,7 @@
 #include "cpu.h"
 #include "exec/gdbstub.h"
 
-int mb_cpu_gdb_read_register(CPUState *cs, uint8_t *mem_buf, int n)
+int mb_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 {
     MicroBlazeCPU *cpu = MICROBLAZE_CPU(cs);
     CPUMBState *env = &cpu->env;
diff --git a/target/mips/gdbstub.c b/target/mips/gdbstub.c
index bbb25449391..98f56e660d2 100644
--- a/target/mips/gdbstub.c
+++ b/target/mips/gdbstub.c
@@ -22,7 +22,7 @@
 #include "internal.h"
 #include "exec/gdbstub.h"
 
-int mips_cpu_gdb_read_register(CPUState *cs, uint8_t *mem_buf, int n)
+int mips_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 {
     MIPSCPU *cpu = MIPS_CPU(cs);
     CPUMIPSState *env = &cpu->env;
diff --git a/target/nios2/cpu.c b/target/nios2/cpu.c
index 1c0c855a6f0..1856b7fcc7a 100644
--- a/target/nios2/cpu.c
+++ b/target/nios2/cpu.c
@@ -124,7 +124,7 @@ static void nios2_cpu_disas_set_info(CPUState *cpu, disassemble_info *info)
 #endif
 }
 
-static int nios2_cpu_gdb_read_register(CPUState *cs, uint8_t *mem_buf, int n)
+static int nios2_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 {
     Nios2CPU *cpu = NIOS2_CPU(cs);
     CPUClass *cc = CPU_GET_CLASS(cs);
diff --git a/target/openrisc/gdbstub.c b/target/openrisc/gdbstub.c
index 0fcdb79668c..095bf76c12c 100644
--- a/target/openrisc/gdbstub.c
+++ b/target/openrisc/gdbstub.c
@@ -21,7 +21,7 @@
 #include "cpu.h"
 #include "exec/gdbstub.h"
 
-int openrisc_cpu_gdb_read_register(CPUState *cs, uint8_t *mem_buf, int n)
+int openrisc_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 {
     OpenRISCCPU *cpu = OPENRISC_CPU(cs);
     CPUOpenRISCState *env = &cpu->env;
diff --git a/target/ppc/gdbstub.c b/target/ppc/gdbstub.c
index 823759c92e7..eb362dd9aec 100644
--- a/target/ppc/gdbstub.c
+++ b/target/ppc/gdbstub.c
@@ -114,10 +114,11 @@ void ppc_maybe_bswap_register(CPUPPCState *env, uint8_t *mem_buf, int len)
  * the FP regs zero size when talking to a newer gdb.
  */
 
-int ppc_cpu_gdb_read_register(CPUState *cs, uint8_t *mem_buf, int n)
+int ppc_cpu_gdb_read_register(CPUState *cs, GByteArray *buf, int n)
 {
     PowerPCCPU *cpu = POWERPC_CPU(cs);
     CPUPPCState *env = &cpu->env;
+    uint8_t *mem_buf;
     int r = ppc_gdb_register_len(n);
 
     if (!r) {
@@ -126,17 +127,17 @@ int ppc_cpu_gdb_read_register(CPUState *cs, uint8_t *mem_buf, int n)
 
     if (n < 32) {
         /* gprs */
-        gdb_get_regl(mem_buf, env->gpr[n]);
+        gdb_get_regl(buf, env->gpr[n]);
     } else if (n < 64) {
         /* fprs */
-        stfq_p(mem_buf, *cpu_fpr_ptr(env, n - 32));
+        gdb_get_reg64(buf, *cpu_fpr_ptr(env, n - 32));
     } else {
         switch (n) {
         case 64:
-            gdb_get_regl(mem_buf, env->nip);
+            gdb_get_regl(buf, env->nip);
             break;
         case 65:
-            gdb_get_regl(mem_buf, env->msr);
+            gdb_get_regl(buf, env->msr);
             break;
         case 66:
             {
@@ -145,31 +146,33 @@ int ppc_cpu_gdb_read_register(CPUState *cs, uint8_t *mem_buf, int n)
                 for (i = 0; i < 8; i++) {
                     cr |= env->crf[i] << (32 - ((i + 1) * 4));
                 }
-                gdb_get_reg32(mem_buf, cr);
+                gdb_get_reg32(buf, cr);
                 break;
             }
         case 67:
-            gdb_get_regl(mem_buf, env->lr);
+            gdb_get_regl(buf, env->lr);
             break;
         case 68:
-            gdb_get_regl(mem_buf, env->ctr);
+            gdb_get_regl(buf, env->ctr);
             break;
         case 69:
-            gdb_get_reg32(mem_buf, env->xer);
+            gdb_get_reg32(buf, env->xer);
             break;
         case 70:
-            gdb_get_reg32(mem_buf, env->fpscr);
+            gdb_get_reg32(buf, env->fpscr);
             break;
         }
     }
+    mem_buf = buf->data + buf->len - r;
     ppc_maybe_bswap_register(env, mem_buf, r);
     return r;
 }
 
-int ppc_cpu_gdb_read_register_apple(CPUState *cs, uint8_t *mem_buf, int n)
+int ppc_cpu_gdb_read_register_apple(CPUState *cs, GByteArray *buf, int n)
 {
     PowerPCCPU *cpu = POWERPC_CPU(cs);
     CPUPPCState *env = &cpu->env;
+    uint8_t *mem_buf;
     int r = ppc_gdb_register_len_apple(n);
 
     if (!r) {
@@ -178,21 +181,21 @@ int ppc_cpu_gdb_read_register_apple(CPUState *cs, uint8_t *mem_buf, int n)
 
     if (n < 32) {
         /* gprs */
-        gdb_get_reg64(mem_buf, env->gpr[n]);
+        gdb_get_reg64(buf, env->gpr[n]);
     } else if (n < 64) {
         /* fprs */
-        stfq_p(mem_buf, *cpu_fpr_ptr(env, n - 32));
+        gdb_get_reg64(buf, *cpu_fpr_ptr(env, n - 32));
     } else if (n < 96) {
         /* Altivec */
-        stq_p(mem_buf, n - 64);
-        stq_p(mem_buf + 8, 0);
+        gdb_get_reg64(buf, n - 64);
+        gdb_get_reg64(buf, 0);
     } else {
         switch (n) {
         case 64 + 32:
-            gdb_get_reg64(mem_buf, env->nip);
+            gdb_get_reg64(buf, env->nip);
             break;
         case 65 + 32:
-            gdb_get_reg64(mem_buf, env->msr);
+            gdb_get_reg64(buf, env->msr);
             break;
         case 66 + 32:
             {
@@ -201,23 +204,24 @@ int ppc_cpu_gdb_read_register_apple(CPUState *cs, uint8_t *mem_buf, int n)
                 for (i = 0; i < 8; i++) {
                     cr |= env->crf[i] << (32 - ((i + 1) * 4));
                 }
-                gdb_get_reg32(mem_buf, cr);
+                gdb_get_reg32(buf, cr);
                 break;
             }
         case 67 + 32:
-            gdb_get_reg64(mem_buf, env->lr);
+            gdb_get_reg64(buf, env->lr);
             break;
         case 68 + 32:
-            gdb_get_reg64(mem_buf, env->ctr);
+            gdb_get_reg64(buf, env->ctr);
             break;
         case 69 + 32:
-            gdb_get_reg32(mem_buf, env->xer);
+            gdb_get_reg32(buf, env->xer);
             break;
         case 70 + 32:
-            gdb_get_reg64(mem_buf, env->fpscr);
+            gdb_get_reg64(buf, env->fpscr);
             break;
         }
     }
+    mem_buf = buf->data + buf->len - r;
     ppc_maybe_bswap_register(env, mem_buf, r);
     return r;
 }
diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.inc.c
index 53995f62eab..04ad54cff69 100644
--- a/target/ppc/translate_init.inc.c
+++ b/target/ppc/translate_init.inc.c
@@ -9857,7 +9857,7 @@ static int gdb_find_spr_idx(CPUPPCState *env, int n)
     return -1;
 }
 
-static int gdb_get_spr_reg(CPUPPCState *env, uint8_t *mem_buf, int n)
+static int gdb_get_spr_reg(CPUPPCState *env, GByteArray *buf, int n)
 {
     int reg;
     int len;
@@ -9868,8 +9868,8 @@ static int gdb_get_spr_reg(CPUPPCState *env, uint8_t *mem_buf, int n)
     }
 
     len = TARGET_LONG_SIZE;
-    stn_p(mem_buf, len, env->spr[reg]);
-    ppc_maybe_bswap_register(env, mem_buf, len);
+    gdb_get_regl(buf, env->spr[reg]);
+    ppc_maybe_bswap_register(env, gdb_get_reg_ptr(buf, len), len);
     return len;
 }
 
@@ -9891,15 +9891,18 @@ static int gdb_set_spr_reg(CPUPPCState *env, uint8_t *mem_buf, int n)
 }
 #endif
 
-static int gdb_get_float_reg(CPUPPCState *env, uint8_t *mem_buf, int n)
+static int gdb_get_float_reg(CPUPPCState *env, GByteArray *buf, int n)
 {
+    uint8_t *mem_buf;
     if (n < 32) {
-        stfq_p(mem_buf, *cpu_fpr_ptr(env, n));
+        gdb_get_reg64(buf, *cpu_fpr_ptr(env, n));
+        mem_buf = gdb_get_reg_ptr(buf, 8);
         ppc_maybe_bswap_register(env, mem_buf, 8);
         return 8;
     }
     if (n == 32) {
-        stl_p(mem_buf, env->fpscr);
+        gdb_get_reg32(buf, env->fpscr);
+        mem_buf = gdb_get_reg_ptr(buf, 4);
         ppc_maybe_bswap_register(env, mem_buf, 4);
         return 4;
     }
@@ -9921,28 +9924,31 @@ static int gdb_set_float_reg(CPUPPCState *env, uint8_t *mem_buf, int n)
     return 0;
 }
 
-static int gdb_get_avr_reg(CPUPPCState *env, uint8_t *mem_buf, int n)
+static int gdb_get_avr_reg(CPUPPCState *env, GByteArray *buf, int n)
 {
+    uint8_t *mem_buf;
+
     if (n < 32) {
         ppc_avr_t *avr = cpu_avr_ptr(env, n);
         if (!avr_need_swap(env)) {
-            stq_p(mem_buf, avr->u64[0]);
-            stq_p(mem_buf + 8, avr->u64[1]);
+            gdb_get_reg128(buf, avr->u64[0] , avr->u64[1]);
         } else {
-            stq_p(mem_buf, avr->u64[1]);
-            stq_p(mem_buf + 8, avr->u64[0]);
+            gdb_get_reg128(buf, avr->u64[1] , avr->u64[0]);
         }
+        mem_buf = gdb_get_reg_ptr(buf, 16);
         ppc_maybe_bswap_register(env, mem_buf, 8);
         ppc_maybe_bswap_register(env, mem_buf + 8, 8);
         return 16;
     }
     if (n == 32) {
-        stl_p(mem_buf, helper_mfvscr(env));
+        gdb_get_reg32(buf, helper_mfvscr(env));
+        mem_buf = gdb_get_reg_ptr(buf, 4);
         ppc_maybe_bswap_register(env, mem_buf, 4);
         return 4;
     }
     if (n == 33) {
-        stl_p(mem_buf, (uint32_t)env->spr[SPR_VRSAVE]);
+        gdb_get_reg32(buf, (uint32_t)env->spr[SPR_VRSAVE]);
+        mem_buf = gdb_get_reg_ptr(buf, 4);
         ppc_maybe_bswap_register(env, mem_buf, 4);
         return 4;
     }
@@ -9977,25 +9983,25 @@ static int gdb_set_avr_reg(CPUPPCState *env, uint8_t *mem_buf, int n)
     return 0;
 }
 
-static int gdb_get_spe_reg(CPUPPCState *env, uint8_t *mem_buf, int n)
+static int gdb_get_spe_reg(CPUPPCState *env, GByteArray *buf, int n)
 {
     if (n < 32) {
 #if defined(TARGET_PPC64)
-        stl_p(mem_buf, env->gpr[n] >> 32);
-        ppc_maybe_bswap_register(env, mem_buf, 4);
+        gdb_get_reg32(buf, env->gpr[n] >> 32);
+        ppc_maybe_bswap_register(env, gdb_get_reg_ptr(buf, 4), 4);
 #else
-        stl_p(mem_buf, env->gprh[n]);
+        gdb_get_reg32(buf, env->gprh[n]);
 #endif
         return 4;
     }
     if (n == 32) {
-        stq_p(mem_buf, env->spe_acc);
-        ppc_maybe_bswap_register(env, mem_buf, 8);
+        gdb_get_reg64(buf, env->spe_acc);
+        ppc_maybe_bswap_register(env, gdb_get_reg_ptr(buf, 8), 8);
         return 8;
     }
     if (n == 33) {
-        stl_p(mem_buf, env->spe_fscr);
-        ppc_maybe_bswap_register(env, mem_buf, 4);
+        gdb_get_reg32(buf, env->spe_fscr);
+        ppc_maybe_bswap_register(env, gdb_get_reg_ptr(buf, 4), 4);
         return 4;
     }
     return 0;
@@ -10030,11 +10036,11 @@ static int gdb_set_spe_reg(CPUPPCState *env, uint8_t *mem_buf, int n)
     return 0;
 }
 
-static int gdb_get_vsx_reg(CPUPPCState *env, uint8_t *mem_buf, int n)
+static int gdb_get_vsx_reg(CPUPPCState *env, GByteArray *buf, int n)
 {
     if (n < 32) {
-        stq_p(mem_buf, *cpu_vsrl_ptr(env, n));
-        ppc_maybe_bswap_register(env, mem_buf, 8);
+        gdb_get_reg64(buf, *cpu_vsrl_ptr(env, n));
+        ppc_maybe_bswap_register(env, gdb_get_reg_ptr(buf, 8), 8);
         return 8;
     }
     return 0;
diff --git a/target/riscv/gdbstub.c b/target/riscv/gdbstub.c
index 2f32750f2fb..eba12a86f2e 100644
--- a/target/riscv/gdbstub.c
+++ b/target/riscv/gdbstub.c
@@ -270,7 +270,7 @@ static int csr_register_map[] = {
     CSR_MHCOUNTEREN,
 };
 
-int riscv_cpu_gdb_read_register(CPUState *cs, uint8_t *mem_buf, int n)
+int riscv_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 {
     RISCVCPU *cpu = RISCV_CPU(cs);
     CPURISCVState *env = &cpu->env;
@@ -301,14 +301,14 @@ int riscv_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
     return 0;
 }
 
-static int riscv_gdb_get_fpu(CPURISCVState *env, uint8_t *mem_buf, int n)
+static int riscv_gdb_get_fpu(CPURISCVState *env, GByteArray *buf, int n)
 {
     if (n < 32) {
         if (env->misa & RVD) {
-            return gdb_get_reg64(mem_buf, env->fpr[n]);
+            return gdb_get_reg64(buf, env->fpr[n]);
         }
         if (env->misa & RVF) {
-            return gdb_get_reg32(mem_buf, env->fpr[n]);
+            return gdb_get_reg32(buf, env->fpr[n]);
         }
     /* there is hole between ft11 and fflags in fpu.xml */
     } else if (n < 36 && n > 32) {
@@ -322,7 +322,7 @@ static int riscv_gdb_get_fpu(CPURISCVState *env, uint8_t *mem_buf, int n)
         result = riscv_csrrw_debug(env, n - 33 + csr_register_map[8], &val,
                                    0, 0);
         if (result == 0) {
-            return gdb_get_regl(mem_buf, val);
+            return gdb_get_regl(buf, val);
         }
     }
     return 0;
@@ -351,7 +351,7 @@ static int riscv_gdb_set_fpu(CPURISCVState *env, uint8_t *mem_buf, int n)
     return 0;
 }
 
-static int riscv_gdb_get_csr(CPURISCVState *env, uint8_t *mem_buf, int n)
+static int riscv_gdb_get_csr(CPURISCVState *env, GByteArray *buf, int n)
 {
     if (n < ARRAY_SIZE(csr_register_map)) {
         target_ulong val = 0;
@@ -359,7 +359,7 @@ static int riscv_gdb_get_csr(CPURISCVState *env, uint8_t *mem_buf, int n)
 
         result = riscv_csrrw_debug(env, csr_register_map[n], &val, 0, 0);
         if (result == 0) {
-            return gdb_get_regl(mem_buf, val);
+            return gdb_get_regl(buf, val);
         }
     }
     return 0;
@@ -379,13 +379,13 @@ static int riscv_gdb_set_csr(CPURISCVState *env, uint8_t *mem_buf, int n)
     return 0;
 }
 
-static int riscv_gdb_get_virtual(CPURISCVState *cs, uint8_t *mem_buf, int n)
+static int riscv_gdb_get_virtual(CPURISCVState *cs, GByteArray *buf, int n)
 {
     if (n == 0) {
 #ifdef CONFIG_USER_ONLY
-        return gdb_get_regl(mem_buf, 0);
+        return gdb_get_regl(buf, 0);
 #else
-        return gdb_get_regl(mem_buf, cs->priv);
+        return gdb_get_regl(buf, cs->priv);
 #endif
     }
     return 0;
diff --git a/target/s390x/gdbstub.c b/target/s390x/gdbstub.c
index e24a49f4a91..d6fce5ff1e1 100644
--- a/target/s390x/gdbstub.c
+++ b/target/s390x/gdbstub.c
@@ -27,7 +27,7 @@
 #include "sysemu/hw_accel.h"
 #include "sysemu/tcg.h"
 
-int s390_cpu_gdb_read_register(CPUState *cs, uint8_t *mem_buf, int n)
+int s390_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 {
     S390CPU *cpu = S390_CPU(cs);
     CPUS390XState *env = &cpu->env;
@@ -82,11 +82,11 @@ int s390_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
 /* total number of registers in s390-acr.xml */
 #define S390_NUM_AC_REGS 16
 
-static int cpu_read_ac_reg(CPUS390XState *env, uint8_t *mem_buf, int n)
+static int cpu_read_ac_reg(CPUS390XState *env, GByteArray *buf, int n)
 {
     switch (n) {
     case S390_A0_REGNUM ... S390_A15_REGNUM:
-        return gdb_get_reg32(mem_buf, env->aregs[n]);
+        return gdb_get_reg32(buf, env->aregs[n]);
     default:
         return 0;
     }
@@ -111,13 +111,13 @@ static int cpu_write_ac_reg(CPUS390XState *env, uint8_t *mem_buf, int n)
 /* total number of registers in s390-fpr.xml */
 #define S390_NUM_FP_REGS 17
 
-static int cpu_read_fp_reg(CPUS390XState *env, uint8_t *mem_buf, int n)
+static int cpu_read_fp_reg(CPUS390XState *env, GByteArray *buf, int n)
 {
     switch (n) {
     case S390_FPC_REGNUM:
-        return gdb_get_reg32(mem_buf, env->fpc);
+        return gdb_get_reg32(buf, env->fpc);
     case S390_F0_REGNUM ... S390_F15_REGNUM:
-        return gdb_get_reg64(mem_buf, *get_freg(env, n - S390_F0_REGNUM));
+        return gdb_get_reg64(buf, *get_freg(env, n - S390_F0_REGNUM));
     default:
         return 0;
     }
@@ -145,17 +145,17 @@ static int cpu_write_fp_reg(CPUS390XState *env, uint8_t *mem_buf, int n)
 /* total number of registers in s390-vx.xml */
 #define S390_NUM_VREGS 32
 
-static int cpu_read_vreg(CPUS390XState *env, uint8_t *mem_buf, int n)
+static int cpu_read_vreg(CPUS390XState *env, GByteArray *buf, int n)
 {
     int ret;
 
     switch (n) {
     case S390_V0L_REGNUM ... S390_V15L_REGNUM:
-        ret = gdb_get_reg64(mem_buf, env->vregs[n][1]);
+        ret = gdb_get_reg64(buf, env->vregs[n][1]);
         break;
     case S390_V16_REGNUM ... S390_V31_REGNUM:
-        ret = gdb_get_reg64(mem_buf, env->vregs[n][0]);
-        ret += gdb_get_reg64(mem_buf + 8, env->vregs[n][1]);
+        ret = gdb_get_reg64(buf, env->vregs[n][0]);
+        ret += gdb_get_reg64(buf, env->vregs[n][1]);
         break;
     default:
         ret = 0;
@@ -186,11 +186,11 @@ static int cpu_write_vreg(CPUS390XState *env, uint8_t *mem_buf, int n)
 #define S390_NUM_C_REGS 16
 
 #ifndef CONFIG_USER_ONLY
-static int cpu_read_c_reg(CPUS390XState *env, uint8_t *mem_buf, int n)
+static int cpu_read_c_reg(CPUS390XState *env, GByteArray *buf, int n)
 {
     switch (n) {
     case S390_C0_REGNUM ... S390_C15_REGNUM:
-        return gdb_get_regl(mem_buf, env->cregs[n]);
+        return gdb_get_regl(buf, env->cregs[n]);
     default:
         return 0;
     }
@@ -223,7 +223,7 @@ static int cpu_write_c_reg(CPUS390XState *env, uint8_t *mem_buf, int n)
 /* total number of registers in s390-virt.xml */
 #define S390_NUM_VIRT_REGS 8
 
-static int cpu_read_virt_reg(CPUS390XState *env, uint8_t *mem_buf, int n)
+static int cpu_read_virt_reg(CPUS390XState *env, GByteArray *mem_buf, int n)
 {
     switch (n) {
     case S390_VIRT_CKC_REGNUM:
@@ -296,9 +296,9 @@ static int cpu_write_virt_reg(CPUS390XState *env, uint8_t *mem_buf, int n)
 /* total number of registers in s390-gs.xml */
 #define S390_NUM_GS_REGS 4
 
-static int cpu_read_gs_reg(CPUS390XState *env, uint8_t *mem_buf, int n)
+static int cpu_read_gs_reg(CPUS390XState *env, GByteArray *buf, int n)
 {
-    return gdb_get_regl(mem_buf, env->gscb[n]);
+    return gdb_get_regl(buf, env->gscb[n]);
 }
 
 static int cpu_write_gs_reg(CPUS390XState *env, uint8_t *mem_buf, int n)
diff --git a/target/sh4/gdbstub.c b/target/sh4/gdbstub.c
index 44c1679e9db..49fc4a0cc69 100644
--- a/target/sh4/gdbstub.c
+++ b/target/sh4/gdbstub.c
@@ -24,7 +24,7 @@
 /* Hint: Use "set architecture sh4" in GDB to see fpu registers */
 /* FIXME: We should use XML for this.  */
 
-int superh_cpu_gdb_read_register(CPUState *cs, uint8_t *mem_buf, int n)
+int superh_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 {
     SuperHCPU *cpu = SUPERH_CPU(cs);
     CPUSH4State *env = &cpu->env;
diff --git a/target/sparc/gdbstub.c b/target/sparc/gdbstub.c
index 8be742b5a3d..78dc8dcc980 100644
--- a/target/sparc/gdbstub.c
+++ b/target/sparc/gdbstub.c
@@ -27,7 +27,7 @@
 #define gdb_get_rega(buf, val) gdb_get_regl(buf, val)
 #endif
 
-int sparc_cpu_gdb_read_register(CPUState *cs, uint8_t *mem_buf, int n)
+int sparc_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 {
     SPARCCPU *cpu = SPARC_CPU(cs);
     CPUSPARCState *env = &cpu->env;
diff --git a/target/xtensa/gdbstub.c b/target/xtensa/gdbstub.c
index 54727881f38..0ee3feabe54 100644
--- a/target/xtensa/gdbstub.c
+++ b/target/xtensa/gdbstub.c
@@ -63,7 +63,7 @@ void xtensa_count_regs(const XtensaConfig *config,
     }
 }
 
-int xtensa_cpu_gdb_read_register(CPUState *cs, uint8_t *mem_buf, int n)
+int xtensa_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 {
     XtensaCPU *cpu = XTENSA_CPU(cs);
     CPUXtensaState *env = &cpu->env;
-- 
2.20.1


