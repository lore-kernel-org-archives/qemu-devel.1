Return-Path: <SRS0=giGJ=6X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D19BFC28CBC
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2020 13:16:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EECF21775
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2020 13:16:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jDO/4+L2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EECF21775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jXPKl-0000xl-N5
	for qemu-devel@archiver.kernel.org; Sat, 09 May 2020 09:16:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44722)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jXPEg-0004of-Ll; Sat, 09 May 2020 09:09:46 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:41148)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jXPEe-0005wd-OU; Sat, 09 May 2020 09:09:46 -0400
Received: by mail-wr1-x444.google.com with SMTP id g13so5122573wrb.8;
 Sat, 09 May 2020 06:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=KCkyANn4FcnR5rJJUijQsegjOxElV+OnO2NwpohvbPI=;
 b=jDO/4+L2um5973o9LQ8Qntt5S4jpI0mKVBqOSsR7qXSd31oCrA+GubxLPSBjbUzagt
 brWe5+I2jWCoTMNYziZLAzTr67zfdJw1N4+ldwUBMcV5A9TGOROXaNpeZaOin+wWTS82
 4ygZbZRY8BLXpBHl58G9nUmjP5z/pXU739KrGWirFUUIXjnHvMinNPwhW4zFpqthMIj3
 P/pPsAzXLN1fecuVYB0ndnfvz2gh3M29QXtOy0JN9d8MyDaOum1Tp43u9m/ze+8pxlBY
 vzh16q4jHKyaJnUZJ1Gd7vux4WW+ZcQvulz7CCLnTrvcZASrX3Zn1tGhtMbfiqOocppP
 TQIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=KCkyANn4FcnR5rJJUijQsegjOxElV+OnO2NwpohvbPI=;
 b=jzTAGQKxFgkWGZQjS8wiSwqvYIEinR/4TiTg5HjbkPFzaatqO1Ie6l0hi65S39GEuQ
 i3pguF3zkmgAIe78XyaiVbutjJaEQb1M9rV0emxdF0znUiyvufUXwAEfunqhVvuqo6V3
 nS13bH+xlE7YpTig4n/kj+EjOI4KCcimyI77At/jsFDSZmp+0Az2rItyQPAxgyQTGEAR
 1iiFI6kQSXB98Zj2PVuqRHBvbzIe0SO2Fcs8dJvVHpzD2eZx7wjkU1x0sdaRIcun+Gnh
 M8wcrlQvgF0nXR+uBsYi6zqCs9QN/8WYbfJrmtIqlk0kGB+vT2TMzx3L7OkQVIn/RJUg
 A7Wg==
X-Gm-Message-State: AGi0PubO6GCgE7TQbwfMjY6Iu+DWHV2vftw5XtJZ94GmiKKQzLwaBa3i
 +z2lPJz6CYD0nfRsVI7pgoKehM4RWfg=
X-Google-Smtp-Source: APiQypKTCzVWz4OtBkfMURyuhxOjXVPsQ8QTteSNFY+TQN3SepDpNDqC9FUtqNgzwnqJEPuvgZkE4Q==
X-Received: by 2002:a5d:6082:: with SMTP id w2mr8284190wrt.163.1589029781390; 
 Sat, 09 May 2020 06:09:41 -0700 (PDT)
Received: from localhost.localdomain (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id m65sm1411410wmm.17.2020.05.09.06.09.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 May 2020 06:09:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 09/11] target/cpu: Restrict handlers using hwaddr type to
 system-mode
Date: Sat,  9 May 2020 15:09:08 +0200
Message-Id: <20200509130910.26335-10-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200509130910.26335-1-f4bug@amsat.org>
References: <20200509130910.26335-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Chris Wulff <crwulff@gmail.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 David Hildenbrand <david@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Max Filippov <jcmvbkbc@gmail.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Marek Vasut <marex@denx.de>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>, qemu-ppc@nongnu.org,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org, Stafford Horne <shorne@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>, qemu-riscv@nongnu.org,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Cornelia Huck <cohuck@redhat.com>, Roman Bolshakov <r.bolshakov@yadro.com>,
 Laurent Vivier <laurent@vivier.eu>, Palmer Dabbelt <palmer@dabbelt.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Restrict the following handlers to system-mode:
- do_unaligned_access
- do_transaction_failed
- get_phys_page_debug
- get_phys_page_attrs_debug

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/core/cpu.h           |  8 +++++---
 target/alpha/cpu.h              |  4 +++-
 target/arm/cpu.h                |  6 +++---
 target/arm/internals.h          |  4 ++++
 target/cris/cpu.h               |  2 ++
 target/hppa/cpu.h               |  2 +-
 target/i386/cpu.h               |  2 ++
 target/m68k/cpu.h               |  7 ++++++-
 target/microblaze/cpu.h         |  5 ++++-
 target/mips/internal.h          |  2 +-
 target/nios2/cpu.h              |  5 ++++-
 target/openrisc/cpu.h           |  3 ++-
 target/ppc/cpu.h                |  2 +-
 target/riscv/cpu.h              | 20 ++++++++++----------
 target/sh4/cpu.h                |  2 +-
 target/sparc/cpu.h              |  2 ++
 target/xtensa/cpu.h             | 12 +++++++-----
 target/hppa/cpu.c               |  4 +++-
 target/ppc/translate_init.inc.c |  2 +-
 19 files changed, 62 insertions(+), 32 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 5bf94d28cf..ed09d056d1 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -167,6 +167,7 @@ typedef struct CPUClass {
     int reset_dump_flags;
     bool (*has_work)(CPUState *cpu);
     void (*do_interrupt)(CPUState *cpu);
+#ifndef CONFIG_USER_ONLY
     void (*do_unaligned_access)(CPUState *cpu, vaddr addr,
                                 MMUAccessType access_type,
                                 int mmu_idx, uintptr_t retaddr);
@@ -174,6 +175,10 @@ typedef struct CPUClass {
                                   unsigned size, MMUAccessType access_type,
                                   int mmu_idx, MemTxAttrs attrs,
                                   MemTxResult response, uintptr_t retaddr);
+    hwaddr (*get_phys_page_debug)(CPUState *cpu, vaddr addr);
+    hwaddr (*get_phys_page_attrs_debug)(CPUState *cpu, vaddr addr,
+                                        MemTxAttrs *attrs);
+#endif /* CONFIG_USER_ONLY */
     bool (*virtio_is_big_endian)(CPUState *cpu);
     int (*memory_rw_debug)(CPUState *cpu, vaddr addr,
                            uint8_t *buf, int len, bool is_write);
@@ -189,9 +194,6 @@ typedef struct CPUClass {
     bool (*tlb_fill)(CPUState *cpu, vaddr address, int size,
                      MMUAccessType access_type, int mmu_idx,
                      bool probe, uintptr_t retaddr);
-    hwaddr (*get_phys_page_debug)(CPUState *cpu, vaddr addr);
-    hwaddr (*get_phys_page_attrs_debug)(CPUState *cpu, vaddr addr,
-                                        MemTxAttrs *attrs);
     int (*asidx_from_attrs)(CPUState *cpu, MemTxAttrs attrs);
     int (*gdb_read_register)(CPUState *cpu, GByteArray *buf, int reg);
     int (*gdb_write_register)(CPUState *cpu, uint8_t *buf, int reg);
diff --git a/target/alpha/cpu.h b/target/alpha/cpu.h
index be29bdd530..b12021803e 100644
--- a/target/alpha/cpu.h
+++ b/target/alpha/cpu.h
@@ -279,12 +279,14 @@ extern const VMStateDescription vmstate_alpha_cpu;
 void alpha_cpu_do_interrupt(CPUState *cpu);
 bool alpha_cpu_exec_interrupt(CPUState *cpu, int int_req);
 void alpha_cpu_dump_state(CPUState *cs, FILE *f, int flags);
-hwaddr alpha_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
 int alpha_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
 int alpha_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
+#ifndef CONFIG_USER_ONLY
+hwaddr alpha_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
 void alpha_cpu_do_unaligned_access(CPUState *cpu, vaddr addr,
                                    MMUAccessType access_type,
                                    int mmu_idx, uintptr_t retaddr);
+#endif
 
 #define cpu_list alpha_cpu_list
 #define cpu_signal_handler cpu_alpha_signal_handler
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 8608da6b6f..d333036bb4 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -966,15 +966,15 @@ uint64_t arm_cpu_mp_affinity(int idx, uint8_t clustersz);
 
 #ifndef CONFIG_USER_ONLY
 extern const VMStateDescription vmstate_arm_cpu;
+
+hwaddr arm_cpu_get_phys_page_attrs_debug(CPUState *cpu, vaddr addr,
+                                         MemTxAttrs *attrs);
 #endif
 
 void arm_cpu_do_interrupt(CPUState *cpu);
 void arm_v7m_cpu_do_interrupt(CPUState *cpu);
 bool arm_cpu_exec_interrupt(CPUState *cpu, int int_req);
 
-hwaddr arm_cpu_get_phys_page_attrs_debug(CPUState *cpu, vaddr addr,
-                                         MemTxAttrs *attrs);
-
 int arm_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
 int arm_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 
diff --git a/target/arm/internals.h b/target/arm/internals.h
index e633aff36e..c0a2a5df71 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -812,6 +812,8 @@ ARMMMUIdx arm_v7m_mmu_idx_for_secstate(CPUARMState *env, bool secstate);
  * tables */
 bool arm_s1_regime_using_lpae_format(CPUARMState *env, ARMMMUIdx mmu_idx);
 
+#ifndef CONFIG_USER_ONLY
+
 /* Raise a data fault alignment exception for the specified virtual address */
 void arm_cpu_do_unaligned_access(CPUState *cs, vaddr vaddr,
                                  MMUAccessType access_type,
@@ -827,6 +829,8 @@ void arm_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
                                    int mmu_idx, MemTxAttrs attrs,
                                    MemTxResult response, uintptr_t retaddr);
 
+#endif /* !CONFIG_USER_ONLY */
+
 /* Call any registered EL change hooks */
 static inline void arm_call_pre_el_change_hook(ARMCPU *cpu)
 {
diff --git a/target/cris/cpu.h b/target/cris/cpu.h
index 8f08d7628b..e9c858ada7 100644
--- a/target/cris/cpu.h
+++ b/target/cris/cpu.h
@@ -193,7 +193,9 @@ bool cris_cpu_exec_interrupt(CPUState *cpu, int int_req);
 
 void cris_cpu_dump_state(CPUState *cs, FILE *f, int flags);
 
+#ifndef CONFIG_USER_ONLY
 hwaddr cris_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
+#endif
 
 int crisv10_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
 int cris_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index 801a4fb1ba..7848425f6a 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -320,7 +320,6 @@ void cpu_hppa_change_prot_id(CPUHPPAState *env);
 #define cpu_signal_handler cpu_hppa_signal_handler
 
 int cpu_hppa_signal_handler(int host_signum, void *pinfo, void *puc);
-hwaddr hppa_cpu_get_phys_page_debug(CPUState *cs, vaddr addr);
 int hppa_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
 int hppa_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 void hppa_cpu_do_interrupt(CPUState *cpu);
@@ -330,6 +329,7 @@ bool hppa_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                        MMUAccessType access_type, int mmu_idx,
                        bool probe, uintptr_t retaddr);
 #ifndef CONFIG_USER_ONLY
+hwaddr hppa_cpu_get_phys_page_debug(CPUState *cs, vaddr addr);
 int hppa_get_physical_address(CPUHPPAState *env, vaddr addr, int mmu_idx,
                               int type, hwaddr *pphys, int *pprot);
 extern const MemoryRegionOps hppa_io_eir_ops;
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index e818fc712a..00e0cc0828 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1767,8 +1767,10 @@ void x86_cpu_get_memory_mapping(CPUState *cpu, MemoryMappingList *list,
 
 void x86_cpu_dump_state(CPUState *cs, FILE *f, int flags);
 
+#ifndef CONFIG_USER_ONLY
 hwaddr x86_cpu_get_phys_page_attrs_debug(CPUState *cpu, vaddr addr,
                                          MemTxAttrs *attrs);
+#endif
 
 int x86_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
 int x86_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index 521ac67cdd..efc940e7ec 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -167,10 +167,13 @@ struct M68kCPU {
 void m68k_cpu_do_interrupt(CPUState *cpu);
 bool m68k_cpu_exec_interrupt(CPUState *cpu, int int_req);
 void m68k_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
-hwaddr m68k_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
 int m68k_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
 int m68k_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 
+#ifndef CONFIG_USER_ONLY
+hwaddr m68k_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
+#endif
+
 void m68k_tcg_init(void);
 void m68k_cpu_init_gdb(M68kCPU *cpu);
 /*
@@ -529,10 +532,12 @@ static inline int cpu_mmu_index (CPUM68KState *env, bool ifetch)
 bool m68k_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                        MMUAccessType access_type, int mmu_idx,
                        bool probe, uintptr_t retaddr);
+#ifndef CONFIG_USER_ONLY
 void m68k_cpu_transaction_failed(CPUState *cs, hwaddr physaddr, vaddr addr,
                                  unsigned size, MMUAccessType access_type,
                                  int mmu_idx, MemTxAttrs attrs,
                                  MemTxResult response, uintptr_t retaddr);
+#endif
 
 typedef CPUM68KState CPUArchState;
 typedef M68kCPU ArchCPU;
diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index a31134b65c..eb57f04d3f 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -318,10 +318,13 @@ struct MicroBlazeCPU {
 void mb_cpu_do_interrupt(CPUState *cs);
 bool mb_cpu_exec_interrupt(CPUState *cs, int int_req);
 void mb_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
-hwaddr mb_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
 int mb_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
 int mb_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 
+#ifndef CONFIG_USER_ONLY
+hwaddr mb_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
+#endif
+
 void mb_tcg_init(void);
 /* you can call this signal handler from your SIGBUS and SIGSEGV
    signal handlers to inform the virtual CPU of exceptions. non zero
diff --git a/target/mips/internal.h b/target/mips/internal.h
index 1bf274b3ef..c38666c6f5 100644
--- a/target/mips/internal.h
+++ b/target/mips/internal.h
@@ -81,7 +81,6 @@ enum CPUMIPSMSADataFormat {
 void mips_cpu_do_interrupt(CPUState *cpu);
 bool mips_cpu_exec_interrupt(CPUState *cpu, int int_req);
 void mips_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
-hwaddr mips_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
 int mips_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
 int mips_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 void mips_cpu_do_unaligned_access(CPUState *cpu, vaddr addr,
@@ -150,6 +149,7 @@ void mips_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
                                     MemTxResult response, uintptr_t retaddr);
 hwaddr cpu_mips_translate_address(CPUMIPSState *env, target_ulong address,
                                   int rw);
+hwaddr mips_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
 #endif
 
 #define cpu_signal_handler cpu_mips_signal_handler
diff --git a/target/nios2/cpu.h b/target/nios2/cpu.h
index 4dddf9c3a1..0703295133 100644
--- a/target/nios2/cpu.h
+++ b/target/nios2/cpu.h
@@ -199,11 +199,14 @@ void nios2_cpu_do_interrupt(CPUState *cs);
 int cpu_nios2_signal_handler(int host_signum, void *pinfo, void *puc);
 void dump_mmu(CPUNios2State *env);
 void nios2_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
-hwaddr nios2_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
 void nios2_cpu_do_unaligned_access(CPUState *cpu, vaddr addr,
                                    MMUAccessType access_type,
                                    int mmu_idx, uintptr_t retaddr);
 
+#ifndef CONFIG_USER_ONLY
+hwaddr nios2_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
+#endif
+
 qemu_irq *nios2_cpu_pic_init(Nios2CPU *cpu);
 void nios2_check_interrupts(CPUNios2State *env);
 
diff --git a/target/openrisc/cpu.h b/target/openrisc/cpu.h
index f37a52e153..60de8ed787 100644
--- a/target/openrisc/cpu.h
+++ b/target/openrisc/cpu.h
@@ -319,7 +319,6 @@ void cpu_openrisc_list(void);
 void openrisc_cpu_do_interrupt(CPUState *cpu);
 bool openrisc_cpu_exec_interrupt(CPUState *cpu, int int_req);
 void openrisc_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
-hwaddr openrisc_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
 int openrisc_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
 int openrisc_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 void openrisc_translate_init(void);
@@ -335,6 +334,8 @@ int print_insn_or1k(bfd_vma addr, disassemble_info *info);
 #ifndef CONFIG_USER_ONLY
 extern const VMStateDescription vmstate_openrisc_cpu;
 
+hwaddr openrisc_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
+
 /* hw/openrisc_pic.c */
 void cpu_openrisc_pic_init(OpenRISCCPU *cpu);
 
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 73920a9cac..f7b27aefed 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1209,12 +1209,12 @@ void ppc_cpu_do_interrupt(CPUState *cpu);
 bool ppc_cpu_exec_interrupt(CPUState *cpu, int int_req);
 void ppc_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
 void ppc_cpu_dump_statistics(CPUState *cpu, int flags);
-hwaddr ppc_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
 int ppc_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
 int ppc_cpu_gdb_read_register_apple(CPUState *cpu, GByteArray *buf, int reg);
 int ppc_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 int ppc_cpu_gdb_write_register_apple(CPUState *cpu, uint8_t *buf, int reg);
 #ifndef CONFIG_USER_ONLY
+hwaddr ppc_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
 void ppc_gdb_gen_spr_xml(PowerPCCPU *cpu);
 const char *ppc_gdb_get_dynamic_xml(CPUState *cs, const char *xml_name);
 #endif
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index d0e7f5b9c5..69edee6484 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -303,18 +303,9 @@ void riscv_cpu_set_virt_enabled(CPURISCVState *env, bool enable);
 bool riscv_cpu_force_hs_excep_enabled(CPURISCVState *env);
 void riscv_cpu_set_force_hs_excep(CPURISCVState *env, bool enable);
 int riscv_cpu_mmu_index(CPURISCVState *env, bool ifetch);
-hwaddr riscv_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
-void  riscv_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
-                                    MMUAccessType access_type, int mmu_idx,
-                                    uintptr_t retaddr);
 bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                         MMUAccessType access_type, int mmu_idx,
                         bool probe, uintptr_t retaddr);
-void riscv_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
-                                     vaddr addr, unsigned size,
-                                     MMUAccessType access_type,
-                                     int mmu_idx, MemTxAttrs attrs,
-                                     MemTxResult response, uintptr_t retaddr);
 char *riscv_isa_string(RISCVCPU *cpu);
 void riscv_cpu_list(void);
 
@@ -323,12 +314,21 @@ void riscv_cpu_list(void);
 #define cpu_mmu_index riscv_cpu_mmu_index
 
 #ifndef CONFIG_USER_ONLY
+hwaddr riscv_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
+void  riscv_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
+                                    MMUAccessType access_type, int mmu_idx,
+                                    uintptr_t retaddr);
+void riscv_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
+                                     vaddr addr, unsigned size,
+                                     MMUAccessType access_type,
+                                     int mmu_idx, MemTxAttrs attrs,
+                                     MemTxResult response, uintptr_t retaddr);
 void riscv_cpu_swap_hypervisor_regs(CPURISCVState *env);
 int riscv_cpu_claim_interrupts(RISCVCPU *cpu, uint32_t interrupts);
 uint32_t riscv_cpu_update_mip(RISCVCPU *cpu, uint32_t mask, uint32_t value);
 #define BOOL_TO_MASK(x) (-!!(x)) /* helper for riscv_cpu_update_mip value */
 void riscv_cpu_set_rdtime_fn(CPURISCVState *env, uint64_t (*fn)(void));
-#endif
+#endif /* !CONFIG_USER_ONLY */
 void riscv_cpu_set_mode(CPURISCVState *env, target_ulong newpriv);
 
 void riscv_translate_init(void);
diff --git a/target/sh4/cpu.h b/target/sh4/cpu.h
index dbe58c7888..40d92413b8 100644
--- a/target/sh4/cpu.h
+++ b/target/sh4/cpu.h
@@ -207,7 +207,6 @@ struct SuperHCPU {
 void superh_cpu_do_interrupt(CPUState *cpu);
 bool superh_cpu_exec_interrupt(CPUState *cpu, int int_req);
 void superh_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
-hwaddr superh_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
 int superh_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
 int superh_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 void superh_cpu_do_unaligned_access(CPUState *cpu, vaddr addr,
@@ -223,6 +222,7 @@ bool superh_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
 
 void sh4_cpu_list(void);
 #if !defined(CONFIG_USER_ONLY)
+hwaddr superh_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
 void cpu_sh4_invalidate_tlb(CPUSH4State *s);
 uint32_t cpu_sh4_read_mmaped_itlb_addr(CPUSH4State *s,
                                        hwaddr addr);
diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index b9369398f2..31887a811a 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -570,7 +570,9 @@ extern const VMStateDescription vmstate_sparc_cpu;
 
 void sparc_cpu_do_interrupt(CPUState *cpu);
 void sparc_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
+#ifndef CONFIG_USER_ONLY
 hwaddr sparc_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
+#endif
 int sparc_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
 int sparc_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 void QEMU_NORETURN sparc_cpu_do_unaligned_access(CPUState *cpu, vaddr addr,
diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index 7a46dccbe1..47fe57df87 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -564,19 +564,21 @@ bool xtensa_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                          bool probe, uintptr_t retaddr);
 void xtensa_cpu_do_interrupt(CPUState *cpu);
 bool xtensa_cpu_exec_interrupt(CPUState *cpu, int interrupt_request);
-void xtensa_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr, vaddr addr,
-                                      unsigned size, MMUAccessType access_type,
-                                      int mmu_idx, MemTxAttrs attrs,
-                                      MemTxResult response, uintptr_t retaddr);
 void xtensa_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
-hwaddr xtensa_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
 void xtensa_count_regs(const XtensaConfig *config,
                        unsigned *n_regs, unsigned *n_core_regs);
 int xtensa_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
 int xtensa_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
+#ifndef CONFIG_USER_ONLY
+hwaddr xtensa_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
+void xtensa_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr, vaddr addr,
+                                      unsigned size, MMUAccessType access_type,
+                                      int mmu_idx, MemTxAttrs attrs,
+                                      MemTxResult response, uintptr_t retaddr);
 void xtensa_cpu_do_unaligned_access(CPUState *cpu, vaddr addr,
                                     MMUAccessType access_type,
                                     int mmu_idx, uintptr_t retaddr);
+#endif /* !CONFIG_USER_ONLY */
 
 #define cpu_signal_handler cpu_xtensa_signal_handler
 #define cpu_list xtensa_cpu_list
diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index 71b6aca45d..6d33288d2a 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -70,6 +70,7 @@ static void hppa_cpu_disas_set_info(CPUState *cs, disassemble_info *info)
     info->print_insn = print_insn_hppa;
 }
 
+#ifndef CONFIG_USER_ONLY
 static void hppa_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
                                          MMUAccessType access_type,
                                          int mmu_idx, uintptr_t retaddr)
@@ -86,6 +87,7 @@ static void hppa_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
 
     cpu_loop_exit_restore(cs, retaddr);
 }
+#endif /* !CONFIG_USER_ONLY */
 
 static void hppa_cpu_realizefn(DeviceState *dev, Error **errp)
 {
@@ -150,8 +152,8 @@ static void hppa_cpu_class_init(ObjectClass *oc, void *data)
 #ifndef CONFIG_USER_ONLY
     cc->get_phys_page_debug = hppa_cpu_get_phys_page_debug;
     dc->vmsd = &vmstate_hppa_cpu;
-#endif
     cc->do_unaligned_access = hppa_cpu_do_unaligned_access;
+#endif
     cc->disas_set_info = hppa_cpu_disas_set_info;
     cc->tcg_initialize = hppa_translate_init;
 
diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.inc.c
index 4ea0cc501b..8c428e2009 100644
--- a/target/ppc/translate_init.inc.c
+++ b/target/ppc/translate_init.inc.c
@@ -10892,8 +10892,8 @@ static void ppc_cpu_class_init(ObjectClass *oc, void *data)
     cc->set_pc = ppc_cpu_set_pc;
     cc->gdb_read_register = ppc_cpu_gdb_read_register;
     cc->gdb_write_register = ppc_cpu_gdb_write_register;
-    cc->do_unaligned_access = ppc_cpu_do_unaligned_access;
 #ifndef CONFIG_USER_ONLY
+    cc->do_unaligned_access = ppc_cpu_do_unaligned_access;
     cc->get_phys_page_debug = ppc_cpu_get_phys_page_debug;
     cc->vmsd = &vmstate_ppc_cpu;
 #endif
-- 
2.21.3


