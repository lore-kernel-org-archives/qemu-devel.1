Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38B77C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 18:32:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D559A20658
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 18:32:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XwqGmRQV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D559A20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8Ssn-0005Mv-P5
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 14:32:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60364)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1k8SrD-0003OK-7y
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 14:30:44 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:41111)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1k8Sr9-00023v-4r
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 14:30:42 -0400
Received: by mail-pg1-x543.google.com with SMTP id s15so11800539pgc.8
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2020 11:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=B3lNRoKiM1Zg8fDL9tJxGY/w8biXLQTK6gsaoKzpGqE=;
 b=XwqGmRQVIWONDidadVnaj+XBPv/SvgJ+bi4Bi3NKFW/3qxLn06pNMJ/AsuCJDBaBvd
 6k50+vJGVNNh0Z+rx13EUOtwUPze/pozYoKXNKryrkGOBX2UMfWK301G6O3gRs4FgXMR
 negGpnCIkUon3Vyh/+m8AKb0X7tH9H20ckrPbXcSegLkV/BVyaSUTyAfQ0ZuT4KwL2uY
 eAL8Zo3yelEYFcEU3Ef/aVWuDzxi3uDhgJA9smPynZA89JNr0yNU2GNly1DNefGBs6jm
 irsBVndHgvlb43AK39tvsVnejbSusk1QcbmnyEaEHLUlpUv9Fogq1gmOWP44lcR3Vp1l
 k/rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=B3lNRoKiM1Zg8fDL9tJxGY/w8biXLQTK6gsaoKzpGqE=;
 b=iNs5Av0c9XL+fNdVAilQhzP/xL3Uonuas7HQsKQRMCZsy2iqwJKycEj5T0wgLVBNR4
 jcW0/3BuO9iPA1dUAJru/VG5JxrhQd2RcwxuL3VIKuE4jHMzSEguCLlRYsGIrcUPRxGm
 XfvE3jtiXFWujSAqdcMdegNR1JRduKi0poezCQcRCmrY38RA+GrjaLYMEERm6z2aeUnz
 HY8YPTjQfK5jmTrIjrYjY8B/0bWCMmeBk/slTIQOYB5qFSJlm+tn7cDE3iIf2V3l9BBm
 xS0awCnSJQAEonTVdQ0aaYYjp/ofiN+lOHMVIeYc9Eo7mSv1x9mAaeavCtvupxggv+hz
 0npg==
X-Gm-Message-State: AOAM530AI/5NfrCutTdO97cuqZKuZ/QIK9ERmLp6VyInzmcDOk8cb7gm
 V4BRT5d0TlZHJDHQNXBFr1THI37OjVI7Pr4c
X-Google-Smtp-Source: ABdhPJwWYEQduqdDO+3OKrcjhj1AsA1hPxSmex+gnbrblkk/qMHsp+CawhYmHhtF+YHSKt0KXjTn4A==
X-Received: by 2002:a05:6a00:1343:: with SMTP id
 k3mr20787980pfu.91.1597861836643; 
 Wed, 19 Aug 2020 11:30:36 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 (c-73-47-162-176.hsd1.ma.comcast.net. [73.47.162.176])
 by smtp.gmail.com with ESMTPSA id p20sm220766pjg.44.2020.08.19.11.30.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2020 11:30:35 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 6/7] target: rename all *_cpu_exec_interrupt functions to
 *_cpu_exec_interrupt_locked
Date: Wed, 19 Aug 2020 14:28:55 -0400
Message-Id: <20200819182856.4893-7-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200819182856.4893-1-robert.foley@linaro.org>
References: <20200819182856.4893-1-robert.foley@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::543;
 envelope-from=robert.foley@linaro.org; helo=mail-pg1-x543.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sarah Harris <S.E.Harris@kent.ac.uk>, Cornelia Huck <cohuck@redhat.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 David Hildenbrand <david@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Thomas Huth <thuth@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Guan Xuetao <gxt@mprc.pku.edu.cn>, Eduardo Habkost <ehabkost@redhat.com>,
 Marek Vasut <marex@denx.de>, Yoshinori Sato <ysato@users.sourceforge.jp>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 "open list:PowerPC TCG CPUs" <qemu-ppc@nongnu.org>,
 Richard Henderson <rth@twiddle.net>, Artyom Tarasenko <atar4qemu@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>, robert.foley@linaro.org,
 "open list:S390 general arch..." <qemu-s390x@nongnu.org>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>,
 Michael Rolnik <mrolnik@gmail.com>, pbonzini@redhat.com,
 Stafford Horne <shorne@gmail.com>, alex.bennee@linaro.org,
 David Gibson <david@gibson.dropbear.id.au>,
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Chris Wulff <crwulff@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Michael Walle <michael@walle.cc>, Palmer Dabbelt <palmer@dabbelt.com>,
 peter.puhov@linaro.org, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The rename of all *_cpu_exec_interrupt functions to
*_cpu_exec_interrupt_locked is preparation for pushing the BQL lock
around these functions down into the per-arch implementation of
*_cpu_exec_interrupt.  In a later patch, which pushes down the lock,
we will add a new *_cpu_exec_interrupt function, which grabs the BQL
and calls to *_cpu_exec_interrupt_locked.

This patch is part of a series of transitions to move the
BQL down into the cpu_exec_interrupt per arch functions.  This set of
transitions is needed to maintain bisectability.

The purpose of this set of changes is to set the groundwork
so that an arch could move towards removing
the BQL from the cpu_handle_interrupt/exception paths.

This approach was suggested by Paolo Bonzini.
For reference, here are key posts in the discussion, explaining
the reasoning/benefits of this approach.
https://lists.gnu.org/archive/html/qemu-devel/2020-08/msg00784.html
https://lists.gnu.org/archive/html/qemu-devel/2020-08/msg01517.html
https://lists.gnu.org/archive/html/qemu-devel/2020-07/msg08731.html
https://lists.gnu.org/archive/html/qemu-devel/2020-08/msg00044.html

Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 target/alpha/cpu.c              | 2 +-
 target/alpha/cpu.h              | 2 +-
 target/alpha/helper.c           | 2 +-
 target/arm/cpu.c                | 4 ++--
 target/arm/cpu.h                | 2 +-
 target/arm/cpu64.c              | 2 +-
 target/arm/cpu_tcg.c            | 5 +++--
 target/avr/cpu.c                | 2 +-
 target/avr/cpu.h                | 2 +-
 target/avr/helper.c             | 2 +-
 target/cris/cpu.c               | 2 +-
 target/cris/cpu.h               | 2 +-
 target/cris/helper.c            | 2 +-
 target/hppa/cpu.c               | 2 +-
 target/hppa/cpu.h               | 2 +-
 target/hppa/int_helper.c        | 2 +-
 target/i386/cpu.c               | 2 +-
 target/i386/cpu.h               | 2 +-
 target/i386/seg_helper.c        | 2 +-
 target/lm32/cpu.c               | 2 +-
 target/lm32/cpu.h               | 2 +-
 target/lm32/helper.c            | 2 +-
 target/m68k/cpu.c               | 2 +-
 target/m68k/cpu.h               | 2 +-
 target/m68k/op_helper.c         | 2 +-
 target/microblaze/cpu.c         | 2 +-
 target/microblaze/cpu.h         | 2 +-
 target/microblaze/helper.c      | 2 +-
 target/mips/cpu.c               | 2 +-
 target/mips/helper.c            | 2 +-
 target/mips/internal.h          | 2 +-
 target/nios2/cpu.c              | 4 ++--
 target/openrisc/cpu.c           | 2 +-
 target/openrisc/cpu.h           | 2 +-
 target/openrisc/interrupt.c     | 2 +-
 target/ppc/cpu.h                | 2 +-
 target/ppc/excp_helper.c        | 2 +-
 target/ppc/translate_init.inc.c | 2 +-
 target/riscv/cpu.c              | 2 +-
 target/riscv/cpu.h              | 2 +-
 target/riscv/cpu_helper.c       | 2 +-
 target/rx/cpu.c                 | 2 +-
 target/rx/cpu.h                 | 2 +-
 target/rx/helper.c              | 2 +-
 target/s390x/cpu.c              | 2 +-
 target/s390x/excp_helper.c      | 2 +-
 target/s390x/internal.h         | 2 +-
 target/sh4/cpu.c                | 2 +-
 target/sh4/cpu.h                | 2 +-
 target/sh4/helper.c             | 2 +-
 target/sparc/cpu.c              | 4 ++--
 target/tilegx/cpu.c             | 5 +++--
 target/unicore32/cpu.c          | 2 +-
 target/unicore32/cpu.h          | 2 +-
 target/unicore32/helper.c       | 2 +-
 target/xtensa/cpu.c             | 2 +-
 target/xtensa/cpu.h             | 2 +-
 target/xtensa/exc_helper.c      | 2 +-
 58 files changed, 65 insertions(+), 63 deletions(-)

diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
index 09677c6c44..623ed42e13 100644
--- a/target/alpha/cpu.c
+++ b/target/alpha/cpu.c
@@ -218,7 +218,7 @@ static void alpha_cpu_class_init(ObjectClass *oc, void *data)
     cc->class_by_name = alpha_cpu_class_by_name;
     cc->has_work = alpha_cpu_has_work;
     cc->do_interrupt = alpha_cpu_do_interrupt;
-    cc->cpu_exec_interrupt = alpha_cpu_exec_interrupt;
+    cc->cpu_exec_interrupt = alpha_cpu_exec_interrupt_locked;
     cc->dump_state = alpha_cpu_dump_state;
     cc->set_pc = alpha_cpu_set_pc;
     cc->gdb_read_register = alpha_cpu_gdb_read_register;
diff --git a/target/alpha/cpu.h b/target/alpha/cpu.h
index be29bdd530..9ed82b5785 100644
--- a/target/alpha/cpu.h
+++ b/target/alpha/cpu.h
@@ -277,7 +277,7 @@ extern const VMStateDescription vmstate_alpha_cpu;
 #endif
 
 void alpha_cpu_do_interrupt(CPUState *cpu);
-bool alpha_cpu_exec_interrupt(CPUState *cpu, int int_req);
+bool alpha_cpu_exec_interrupt_locked(CPUState *cpu, int int_req);
 void alpha_cpu_dump_state(CPUState *cs, FILE *f, int flags);
 hwaddr alpha_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
 int alpha_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
diff --git a/target/alpha/helper.c b/target/alpha/helper.c
index e497dd269e..b5fa849f0f 100644
--- a/target/alpha/helper.c
+++ b/target/alpha/helper.c
@@ -414,7 +414,7 @@ void alpha_cpu_do_interrupt(CPUState *cs)
     qemu_mutex_unlock_iothread();
 }
 
-bool alpha_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
+bool alpha_cpu_exec_interrupt_locked(CPUState *cs, int interrupt_request)
 {
     AlphaCPU *cpu = ALPHA_CPU(cs);
     CPUAlphaState *env = &cpu->env;
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 12eda7611f..a294739b94 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -524,7 +524,7 @@ static inline bool arm_excp_unmasked(CPUState *cs, unsigned int excp_idx,
     return unmasked || pstate_unmasked;
 }
 
-bool arm_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
+bool arm_cpu_exec_interrupt_locked(CPUState *cs, int interrupt_request)
 {
     ARMCPUClass *acc = ARM_CPU_GET_CLASS(cs);
     CPUARMState *env = cs->env_ptr;
@@ -2217,7 +2217,7 @@ static void arm_cpu_class_init(ObjectClass *oc, void *data)
 
     cc->class_by_name = arm_cpu_class_by_name;
     cc->has_work = arm_cpu_has_work;
-    cc->cpu_exec_interrupt = arm_cpu_exec_interrupt;
+    cc->cpu_exec_interrupt = arm_cpu_exec_interrupt_locked;
     cc->dump_state = arm_cpu_dump_state;
     cc->set_pc = arm_cpu_set_pc;
     cc->synchronize_from_tb = arm_cpu_synchronize_from_tb;
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 57b8904dec..8f423fcd3b 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -995,7 +995,7 @@ void arm_cpu_do_interrupt(CPUState *cpu);
 void arm_cpu_do_interrupt_locked(CPUState *cpu);
 void arm_v7m_cpu_do_interrupt(CPUState *cpu);
 void arm_v7m_cpu_do_interrupt_locked(CPUState *cpu);
-bool arm_cpu_exec_interrupt(CPUState *cpu, int int_req);
+bool arm_cpu_exec_interrupt_locked(CPUState *cpu, int int_req);
 
 hwaddr arm_cpu_get_phys_page_attrs_debug(CPUState *cpu, vaddr addr,
                                          MemTxAttrs *attrs);
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index dd696183df..c6c2e6709c 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -782,7 +782,7 @@ static void aarch64_cpu_class_init(ObjectClass *oc, void *data)
 {
     CPUClass *cc = CPU_CLASS(oc);
 
-    cc->cpu_exec_interrupt = arm_cpu_exec_interrupt;
+    cc->cpu_exec_interrupt = arm_cpu_exec_interrupt_locked;
     cc->gdb_read_register = aarch64_cpu_gdb_read_register;
     cc->gdb_write_register = aarch64_cpu_gdb_write_register;
     cc->gdb_num_core_regs = 34;
diff --git a/target/arm/cpu_tcg.c b/target/arm/cpu_tcg.c
index df36cfda76..8376497139 100644
--- a/target/arm/cpu_tcg.c
+++ b/target/arm/cpu_tcg.c
@@ -15,7 +15,8 @@
 /* CPU models. These are not needed for the AArch64 linux-user build. */
 #if !defined(CONFIG_USER_ONLY) || !defined(TARGET_AARCH64)
 
-static bool arm_v7m_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
+static bool arm_v7m_cpu_exec_interrupt_locked(CPUState *cs,
+                                              int interrupt_request)
 {
     ARMCPUClass *acc = ARM_CPU_GET_CLASS(cs);
     ARMCPU *cpu = ARM_CPU(cs);
@@ -605,7 +606,7 @@ static void arm_v7m_class_init(ObjectClass *oc, void *data)
     acc->do_interrupt_locked = arm_v7m_cpu_do_interrupt_locked;
 #endif
 
-    cc->cpu_exec_interrupt = arm_v7m_cpu_exec_interrupt;
+    cc->cpu_exec_interrupt = arm_v7m_cpu_exec_interrupt_locked;
     cc->gdb_core_xml_file = "arm-m-profile.xml";
 }
 
diff --git a/target/avr/cpu.c b/target/avr/cpu.c
index 5d9c4ad5bf..5439b1bc50 100644
--- a/target/avr/cpu.c
+++ b/target/avr/cpu.c
@@ -198,7 +198,7 @@ static void avr_cpu_class_init(ObjectClass *oc, void *data)
 
     cc->has_work = avr_cpu_has_work;
     cc->do_interrupt = avr_cpu_do_interrupt;
-    cc->cpu_exec_interrupt = avr_cpu_exec_interrupt;
+    cc->cpu_exec_interrupt = avr_cpu_exec_interrupt_locked;
     cc->dump_state = avr_cpu_dump_state;
     cc->set_pc = avr_cpu_set_pc;
     cc->memory_rw_debug = avr_cpu_memory_rw_debug;
diff --git a/target/avr/cpu.h b/target/avr/cpu.h
index d148e8c75a..559cf56ff9 100644
--- a/target/avr/cpu.h
+++ b/target/avr/cpu.h
@@ -157,7 +157,7 @@ typedef struct AVRCPU {
 extern const struct VMStateDescription vms_avr_cpu;
 
 void avr_cpu_do_interrupt(CPUState *cpu);
-bool avr_cpu_exec_interrupt(CPUState *cpu, int int_req);
+bool avr_cpu_exec_interrupt_locked(CPUState *cpu, int int_req);
 hwaddr avr_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
 int avr_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
 int avr_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
diff --git a/target/avr/helper.c b/target/avr/helper.c
index 2c8c3af580..a5c72157a1 100644
--- a/target/avr/helper.c
+++ b/target/avr/helper.c
@@ -26,7 +26,7 @@
 
 static void avr_cpu_do_interrupt_locked(CPUState *cs);
 
-bool avr_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
+bool avr_cpu_exec_interrupt_locked(CPUState *cs, int interrupt_request)
 {
     bool ret = false;
     AVRCPU *cpu = AVR_CPU(cs);
diff --git a/target/cris/cpu.c b/target/cris/cpu.c
index c3d77c31e8..81acfb3d66 100644
--- a/target/cris/cpu.c
+++ b/target/cris/cpu.c
@@ -270,7 +270,7 @@ static void cris_cpu_class_init(ObjectClass *oc, void *data)
     cc->has_work = cris_cpu_has_work;
     cc->do_interrupt = cris_cpu_do_interrupt;
     ccc->do_interrupt_locked = cris_cpu_do_interrupt_locked;
-    cc->cpu_exec_interrupt = cris_cpu_exec_interrupt;
+    cc->cpu_exec_interrupt = cris_cpu_exec_interrupt_locked;
     cc->dump_state = cris_cpu_dump_state;
     cc->set_pc = cris_cpu_set_pc;
     cc->gdb_read_register = cris_cpu_gdb_read_register;
diff --git a/target/cris/cpu.h b/target/cris/cpu.h
index d8ee6b9400..a60fb9c1e7 100644
--- a/target/cris/cpu.h
+++ b/target/cris/cpu.h
@@ -190,7 +190,7 @@ extern const VMStateDescription vmstate_cris_cpu;
 void cris_cpu_do_interrupt(CPUState *cpu);
 void cris_cpu_do_interrupt_locked(CPUState *cpu);
 void crisv10_cpu_do_interrupt_locked(CPUState *cpu);
-bool cris_cpu_exec_interrupt(CPUState *cpu, int int_req);
+bool cris_cpu_exec_interrupt_locked(CPUState *cpu, int int_req);
 
 void cris_cpu_dump_state(CPUState *cs, FILE *f, int flags);
 
diff --git a/target/cris/helper.c b/target/cris/helper.c
index 0e053782ab..9dabc8af96 100644
--- a/target/cris/helper.c
+++ b/target/cris/helper.c
@@ -296,7 +296,7 @@ hwaddr cris_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
 }
 #endif
 
-bool cris_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
+bool cris_cpu_exec_interrupt_locked(CPUState *cs, int interrupt_request)
 {
     CRISCPUClass *ccc = CRIS_CPU_CLASS(cs);
     CRISCPU *cpu = CRIS_CPU(cs);
diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index 287055f96e..e800fba3f7 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -140,7 +140,7 @@ static void hppa_cpu_class_init(ObjectClass *oc, void *data)
     cc->class_by_name = hppa_cpu_class_by_name;
     cc->has_work = hppa_cpu_has_work;
     cc->do_interrupt = hppa_cpu_do_interrupt;
-    cc->cpu_exec_interrupt = hppa_cpu_exec_interrupt;
+    cc->cpu_exec_interrupt = hppa_cpu_exec_interrupt_locked;
     cc->dump_state = hppa_cpu_dump_state;
     cc->set_pc = hppa_cpu_set_pc;
     cc->synchronize_from_tb = hppa_cpu_synchronize_from_tb;
diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index 801a4fb1ba..6e32d5581a 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -324,7 +324,7 @@ hwaddr hppa_cpu_get_phys_page_debug(CPUState *cs, vaddr addr);
 int hppa_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
 int hppa_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 void hppa_cpu_do_interrupt(CPUState *cpu);
-bool hppa_cpu_exec_interrupt(CPUState *cpu, int int_req);
+bool hppa_cpu_exec_interrupt_locked(CPUState *cpu, int int_req);
 void hppa_cpu_dump_state(CPUState *cs, FILE *f, int);
 bool hppa_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                        MMUAccessType access_type, int mmu_idx,
diff --git a/target/hppa/int_helper.c b/target/hppa/int_helper.c
index 03cb521a96..82bdee5452 100644
--- a/target/hppa/int_helper.c
+++ b/target/hppa/int_helper.c
@@ -253,7 +253,7 @@ void hppa_cpu_do_interrupt(CPUState *cs)
     qemu_mutex_unlock_iothread();
 }
 
-bool hppa_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
+bool hppa_cpu_exec_interrupt_locked(CPUState *cs, int interrupt_request)
 {
 #ifndef CONFIG_USER_ONLY
     HPPACPU *cpu = HPPA_CPU(cs);
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 592aa0baf7..fa40513211 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -7298,7 +7298,7 @@ static void x86_cpu_common_class_init(ObjectClass *oc, void *data)
     cc->has_work = x86_cpu_has_work;
 #ifdef CONFIG_TCG
     cc->do_interrupt = x86_cpu_do_interrupt;
-    cc->cpu_exec_interrupt = x86_cpu_exec_interrupt;
+    cc->cpu_exec_interrupt = x86_cpu_exec_interrupt_locked;
 #endif
     cc->dump_state = x86_cpu_dump_state;
     cc->set_pc = x86_cpu_set_pc;
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index d784eeaf29..aa183005b2 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1771,7 +1771,7 @@ extern VMStateDescription vmstate_x86_cpu;
  * @cpu: vCPU the interrupt is to be handled by.
  */
 void x86_cpu_do_interrupt(CPUState *cpu);
-bool x86_cpu_exec_interrupt(CPUState *cpu, int int_req);
+bool x86_cpu_exec_interrupt_locked(CPUState *cpu, int int_req);
 int x86_cpu_pending_interrupt(CPUState *cs, int interrupt_request);
 
 int x86_cpu_write_elf64_note(WriteCoreDumpFunction f, CPUState *cpu,
diff --git a/target/i386/seg_helper.c b/target/i386/seg_helper.c
index 74484eb175..6485cceaae 100644
--- a/target/i386/seg_helper.c
+++ b/target/i386/seg_helper.c
@@ -1322,7 +1322,7 @@ void do_interrupt_x86_hardirq(CPUX86State *env, int intno, int is_hw)
     do_interrupt_all(env_archcpu(env), intno, 0, 0, 0, is_hw);
 }
 
-bool x86_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
+bool x86_cpu_exec_interrupt_locked(CPUState *cs, int interrupt_request)
 {
     X86CPU *cpu = X86_CPU(cs);
     CPUX86State *env = &cpu->env;
diff --git a/target/lm32/cpu.c b/target/lm32/cpu.c
index 9e7d8ca929..c7b95f9271 100644
--- a/target/lm32/cpu.c
+++ b/target/lm32/cpu.c
@@ -223,7 +223,7 @@ static void lm32_cpu_class_init(ObjectClass *oc, void *data)
     cc->class_by_name = lm32_cpu_class_by_name;
     cc->has_work = lm32_cpu_has_work;
     cc->do_interrupt = lm32_cpu_do_interrupt;
-    cc->cpu_exec_interrupt = lm32_cpu_exec_interrupt;
+    cc->cpu_exec_interrupt = lm32_cpu_exec_interrupt_locked;
     cc->dump_state = lm32_cpu_dump_state;
     cc->set_pc = lm32_cpu_set_pc;
     cc->gdb_read_register = lm32_cpu_gdb_read_register;
diff --git a/target/lm32/cpu.h b/target/lm32/cpu.h
index 01d408eb55..ee68a2563b 100644
--- a/target/lm32/cpu.h
+++ b/target/lm32/cpu.h
@@ -199,7 +199,7 @@ extern const VMStateDescription vmstate_lm32_cpu;
 #endif
 
 void lm32_cpu_do_interrupt(CPUState *cpu);
-bool lm32_cpu_exec_interrupt(CPUState *cs, int int_req);
+bool lm32_cpu_exec_interrupt_locked(CPUState *cs, int int_req);
 void lm32_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
 hwaddr lm32_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
 int lm32_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
diff --git a/target/lm32/helper.c b/target/lm32/helper.c
index 6184e212cf..6c37e6a898 100644
--- a/target/lm32/helper.c
+++ b/target/lm32/helper.c
@@ -205,7 +205,7 @@ void lm32_cpu_do_interrupt(CPUState *cs)
     qemu_mutex_unlock_iothread();
 }
 
-bool lm32_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
+bool lm32_cpu_exec_interrupt_locked(CPUState *cs, int interrupt_request)
 {
     LM32CPU *cpu = LM32_CPU(cs);
     CPULM32State *env = &cpu->env;
diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index f2585154f5..1a75e6d968 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -278,7 +278,7 @@ static void m68k_cpu_class_init(ObjectClass *c, void *data)
     cc->class_by_name = m68k_cpu_class_by_name;
     cc->has_work = m68k_cpu_has_work;
     cc->do_interrupt = m68k_cpu_do_interrupt;
-    cc->cpu_exec_interrupt = m68k_cpu_exec_interrupt;
+    cc->cpu_exec_interrupt = m68k_cpu_exec_interrupt_locked;
     cc->dump_state = m68k_cpu_dump_state;
     cc->set_pc = m68k_cpu_set_pc;
     cc->gdb_read_register = m68k_cpu_gdb_read_register;
diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index 521ac67cdd..6114a94585 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -165,7 +165,7 @@ struct M68kCPU {
 
 
 void m68k_cpu_do_interrupt(CPUState *cpu);
-bool m68k_cpu_exec_interrupt(CPUState *cpu, int int_req);
+bool m68k_cpu_exec_interrupt_locked(CPUState *cpu, int int_req);
 void m68k_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
 hwaddr m68k_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
 int m68k_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
diff --git a/target/m68k/op_helper.c b/target/m68k/op_helper.c
index 3f0c99124a..2f71e5994d 100644
--- a/target/m68k/op_helper.c
+++ b/target/m68k/op_helper.c
@@ -511,7 +511,7 @@ void m68k_cpu_do_interrupt(CPUState *cs)
     qemu_mutex_unlock_iothread();
 }
 
-bool m68k_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
+bool m68k_cpu_exec_interrupt_locked(CPUState *cs, int interrupt_request)
 {
     M68kCPU *cpu = M68K_CPU(cs);
     CPUM68KState *env = &cpu->env;
diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index ce70f7d281..23e1367f83 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -317,7 +317,7 @@ static void mb_cpu_class_init(ObjectClass *oc, void *data)
     cc->class_by_name = mb_cpu_class_by_name;
     cc->has_work = mb_cpu_has_work;
     cc->do_interrupt = mb_cpu_do_interrupt;
-    cc->cpu_exec_interrupt = mb_cpu_exec_interrupt;
+    cc->cpu_exec_interrupt = mb_cpu_exec_interrupt_locked;
     cc->dump_state = mb_cpu_dump_state;
     cc->set_pc = mb_cpu_set_pc;
     cc->gdb_read_register = mb_cpu_gdb_read_register;
diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index a31134b65c..e0b665624c 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -316,7 +316,7 @@ struct MicroBlazeCPU {
 
 
 void mb_cpu_do_interrupt(CPUState *cs);
-bool mb_cpu_exec_interrupt(CPUState *cs, int int_req);
+bool mb_cpu_exec_interrupt_locked(CPUState *cs, int int_req);
 void mb_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
 hwaddr mb_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
 int mb_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
diff --git a/target/microblaze/helper.c b/target/microblaze/helper.c
index f241587b40..582e607d88 100644
--- a/target/microblaze/helper.c
+++ b/target/microblaze/helper.c
@@ -294,7 +294,7 @@ void mb_cpu_do_interrupt(CPUState *cs)
     qemu_mutex_unlock_iothread();
 }
 
-bool mb_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
+bool mb_cpu_exec_interrupt_locked(CPUState *cs, int interrupt_request)
 {
     MicroBlazeCPU *cpu = MICROBLAZE_CPU(cs);
     CPUMBState *env = &cpu->env;
diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index ec9dde5100..520aefe669 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -197,7 +197,7 @@ static void mips_cpu_class_init(ObjectClass *c, void *data)
     cc->class_by_name = mips_cpu_class_by_name;
     cc->has_work_with_iothread_lock = mips_cpu_has_work;
     cc->do_interrupt = mips_cpu_do_interrupt;
-    cc->cpu_exec_interrupt = mips_cpu_exec_interrupt;
+    cc->cpu_exec_interrupt = mips_cpu_exec_interrupt_locked;
     cc->dump_state = mips_cpu_dump_state;
     cc->set_pc = mips_cpu_set_pc;
     cc->synchronize_from_tb = mips_cpu_synchronize_from_tb;
diff --git a/target/mips/helper.c b/target/mips/helper.c
index 3941392b95..c546788bea 100644
--- a/target/mips/helper.c
+++ b/target/mips/helper.c
@@ -1405,7 +1405,7 @@ void mips_cpu_do_interrupt(CPUState *cs)
     qemu_mutex_unlock_iothread();
 }
 
-bool mips_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
+bool mips_cpu_exec_interrupt_locked(CPUState *cs, int interrupt_request)
 {
     if (interrupt_request & CPU_INTERRUPT_HARD) {
         MIPSCPU *cpu = MIPS_CPU(cs);
diff --git a/target/mips/internal.h b/target/mips/internal.h
index 7f159a9230..24069f6f70 100644
--- a/target/mips/internal.h
+++ b/target/mips/internal.h
@@ -81,7 +81,7 @@ enum CPUMIPSMSADataFormat {
 };
 
 void mips_cpu_do_interrupt(CPUState *cpu);
-bool mips_cpu_exec_interrupt(CPUState *cpu, int int_req);
+bool mips_cpu_exec_interrupt_locked(CPUState *cpu, int int_req);
 void mips_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
 hwaddr mips_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
 int mips_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
diff --git a/target/nios2/cpu.c b/target/nios2/cpu.c
index 7116b3f230..d2617ed28a 100644
--- a/target/nios2/cpu.c
+++ b/target/nios2/cpu.c
@@ -98,7 +98,7 @@ static void nios2_cpu_realizefn(DeviceState *dev, Error **errp)
     ncc->parent_realize(dev, errp);
 }
 
-static bool nios2_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
+static bool nios2_cpu_exec_interrupt_locked(CPUState *cs, int interrupt_request)
 {
     Nios2CPU *cpu = NIOS2_CPU(cs);
     CPUNios2State *env = &cpu->env;
@@ -193,7 +193,7 @@ static void nios2_cpu_class_init(ObjectClass *oc, void *data)
     cc->class_by_name = nios2_cpu_class_by_name;
     cc->has_work = nios2_cpu_has_work;
     cc->do_interrupt = nios2_cpu_do_interrupt;
-    cc->cpu_exec_interrupt = nios2_cpu_exec_interrupt;
+    cc->cpu_exec_interrupt = nios2_cpu_exec_interrupt_locked;
     cc->dump_state = nios2_cpu_dump_state;
     cc->set_pc = nios2_cpu_set_pc;
     cc->disas_set_info = nios2_cpu_disas_set_info;
diff --git a/target/openrisc/cpu.c b/target/openrisc/cpu.c
index fd2da39124..d44b76aaa7 100644
--- a/target/openrisc/cpu.c
+++ b/target/openrisc/cpu.c
@@ -155,7 +155,7 @@ static void openrisc_cpu_class_init(ObjectClass *oc, void *data)
     cc->class_by_name = openrisc_cpu_class_by_name;
     cc->has_work = openrisc_cpu_has_work;
     cc->do_interrupt = openrisc_cpu_do_interrupt;
-    cc->cpu_exec_interrupt = openrisc_cpu_exec_interrupt;
+    cc->cpu_exec_interrupt = openrisc_cpu_exec_interrupt_locked;
     cc->dump_state = openrisc_cpu_dump_state;
     cc->set_pc = openrisc_cpu_set_pc;
     cc->gdb_read_register = openrisc_cpu_gdb_read_register;
diff --git a/target/openrisc/cpu.h b/target/openrisc/cpu.h
index f37a52e153..5cb5e0fa95 100644
--- a/target/openrisc/cpu.h
+++ b/target/openrisc/cpu.h
@@ -317,7 +317,7 @@ typedef struct OpenRISCCPU {
 
 void cpu_openrisc_list(void);
 void openrisc_cpu_do_interrupt(CPUState *cpu);
-bool openrisc_cpu_exec_interrupt(CPUState *cpu, int int_req);
+bool openrisc_cpu_exec_interrupt_locked(CPUState *cpu, int int_req);
 void openrisc_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
 hwaddr openrisc_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
 int openrisc_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
diff --git a/target/openrisc/interrupt.c b/target/openrisc/interrupt.c
index a5ca3ece78..fcfe447e96 100644
--- a/target/openrisc/interrupt.c
+++ b/target/openrisc/interrupt.c
@@ -108,7 +108,7 @@ void openrisc_cpu_do_interrupt(CPUState *cs)
     qemu_mutex_unlock_iothread();
 }
 
-bool openrisc_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
+bool openrisc_cpu_exec_interrupt_locked(CPUState *cs, int interrupt_request)
 {
     OpenRISCCPU *cpu = OPENRISC_CPU(cs);
     CPUOpenRISCState *env = &cpu->env;
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 2569d43e59..75e8a61f8c 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1233,7 +1233,7 @@ struct PPCVirtualHypervisorClass {
 
 void ppc_cpu_do_interrupt(CPUState *cpu);
 void ppc_cpu_do_interrupt_locked(CPUState *cpu);
-bool ppc_cpu_exec_interrupt(CPUState *cpu, int int_req);
+bool ppc_cpu_exec_interrupt_locked(CPUState *cpu, int int_req);
 void ppc_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
 void ppc_cpu_dump_statistics(CPUState *cpu, int flags);
 hwaddr ppc_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 2cb1aaa296..51b36aff06 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -1052,7 +1052,7 @@ void ppc_cpu_do_fwnmi_machine_check(CPUState *cs, target_ulong vector)
 }
 #endif /* !CONFIG_USER_ONLY */
 
-bool ppc_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
+bool ppc_cpu_exec_interrupt_locked(CPUState *cs, int interrupt_request)
 {
     PowerPCCPU *cpu = POWERPC_CPU(cs);
     CPUPPCState *env = &cpu->env;
diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.inc.c
index 27ae7fa195..5037299efa 100644
--- a/target/ppc/translate_init.inc.c
+++ b/target/ppc/translate_init.inc.c
@@ -10886,7 +10886,7 @@ static void ppc_cpu_class_init(ObjectClass *oc, void *data)
     cc->parse_features = ppc_cpu_parse_featurestr;
     cc->has_work_with_iothread_lock = ppc_cpu_has_work;
     cc->do_interrupt = ppc_cpu_do_interrupt;
-    cc->cpu_exec_interrupt = ppc_cpu_exec_interrupt;
+    cc->cpu_exec_interrupt = ppc_cpu_exec_interrupt_locked;
     cc->dump_state = ppc_cpu_dump_state;
     cc->dump_statistics = ppc_cpu_dump_statistics;
     cc->set_pc = ppc_cpu_set_pc;
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 832171c360..5d1332b8c9 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -538,7 +538,7 @@ static void riscv_cpu_class_init(ObjectClass *c, void *data)
     cc->class_by_name = riscv_cpu_class_by_name;
     cc->has_work_with_iothread_lock = riscv_cpu_has_work;
     cc->do_interrupt = riscv_cpu_do_interrupt;
-    cc->cpu_exec_interrupt = riscv_cpu_exec_interrupt;
+    cc->cpu_exec_interrupt = riscv_cpu_exec_interrupt_locked;
     cc->dump_state = riscv_cpu_dump_state;
     cc->set_pc = riscv_cpu_set_pc;
     cc->synchronize_from_tb = riscv_cpu_synchronize_from_tb;
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index a804a5d0ba..6090420ce2 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -315,7 +315,7 @@ extern const char * const riscv_intr_names[];
 void riscv_cpu_do_interrupt(CPUState *cpu);
 int riscv_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
 int riscv_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
-bool riscv_cpu_exec_interrupt(CPUState *cs, int interrupt_request);
+bool riscv_cpu_exec_interrupt_locked(CPUState *cs, int interrupt_request);
 bool riscv_cpu_fp_enabled(CPURISCVState *env);
 bool riscv_cpu_virt_enabled(CPURISCVState *env);
 void riscv_cpu_set_virt_enabled(CPURISCVState *env, bool enable);
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 2c8ee8ca2b..9feac5966b 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -78,7 +78,7 @@ static int riscv_cpu_local_irq_pending(CPURISCVState *env)
 }
 #endif
 
-bool riscv_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
+bool riscv_cpu_exec_interrupt_locked(CPUState *cs, int interrupt_request)
 {
 #if !defined(CONFIG_USER_ONLY)
     if (interrupt_request & CPU_INTERRUPT_HARD) {
diff --git a/target/rx/cpu.c b/target/rx/cpu.c
index 219e05397b..c0ffc3ab2c 100644
--- a/target/rx/cpu.c
+++ b/target/rx/cpu.c
@@ -186,7 +186,7 @@ static void rx_cpu_class_init(ObjectClass *klass, void *data)
     cc->class_by_name = rx_cpu_class_by_name;
     cc->has_work = rx_cpu_has_work;
     cc->do_interrupt = rx_cpu_do_interrupt;
-    cc->cpu_exec_interrupt = rx_cpu_exec_interrupt;
+    cc->cpu_exec_interrupt = rx_cpu_exec_interrupt_locked;
     cc->dump_state = rx_cpu_dump_state;
     cc->set_pc = rx_cpu_set_pc;
     cc->synchronize_from_tb = rx_cpu_synchronize_from_tb;
diff --git a/target/rx/cpu.h b/target/rx/cpu.h
index ec085d0386..e08e5a4b85 100644
--- a/target/rx/cpu.h
+++ b/target/rx/cpu.h
@@ -127,7 +127,7 @@ typedef RXCPU ArchCPU;
 const char *rx_crname(uint8_t cr);
 void rx_cpu_do_interrupt(CPUState *cpu);
 void rx_cpu_do_interrupt_locked(CPUState *cpu);
-bool rx_cpu_exec_interrupt(CPUState *cpu, int int_req);
+bool rx_cpu_exec_interrupt_locked(CPUState *cpu, int int_req);
 void rx_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
 int rx_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
 int rx_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
diff --git a/target/rx/helper.c b/target/rx/helper.c
index 8c0512b62a..0d479264bb 100644
--- a/target/rx/helper.c
+++ b/target/rx/helper.c
@@ -126,7 +126,7 @@ void rx_cpu_do_interrupt(CPUState *cs)
     qemu_mutex_unlock_iothread();
 }
 
-bool rx_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
+bool rx_cpu_exec_interrupt_locked(CPUState *cs, int interrupt_request)
 {
     RXCPU *cpu = RXCPU(cs);
     CPURXState *env = &cpu->env;
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 4d0d323cf9..445b654f7f 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -505,7 +505,7 @@ static void s390_cpu_class_init(ObjectClass *oc, void *data)
     cc->get_crash_info = s390_cpu_get_crash_info;
     cc->write_elf64_note = s390_cpu_write_elf64_note;
 #ifdef CONFIG_TCG
-    cc->cpu_exec_interrupt = s390_cpu_exec_interrupt;
+    cc->cpu_exec_interrupt = s390_cpu_exec_interrupt_locked;
     cc->debug_excp_handler = s390x_cpu_debug_excp_handler;
     cc->do_unaligned_access = s390x_cpu_do_unaligned_access;
 #endif
diff --git a/target/s390x/excp_helper.c b/target/s390x/excp_helper.c
index a020db1725..118d21bd06 100644
--- a/target/s390x/excp_helper.c
+++ b/target/s390x/excp_helper.c
@@ -543,7 +543,7 @@ try_deliver:
     }
 }
 
-bool s390_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
+bool s390_cpu_exec_interrupt_locked(CPUState *cs, int interrupt_request)
 {
     if (interrupt_request & CPU_INTERRUPT_HARD) {
         S390CPU *cpu = S390_CPU(cs);
diff --git a/target/s390x/internal.h b/target/s390x/internal.h
index b4660ad255..cc71b3e194 100644
--- a/target/s390x/internal.h
+++ b/target/s390x/internal.h
@@ -270,7 +270,7 @@ ObjectClass *s390_cpu_class_by_name(const char *name);
 void s390x_cpu_debug_excp_handler(CPUState *cs);
 void s390_cpu_do_interrupt(CPUState *cpu);
 void s390_cpu_do_interrupt_locked(CPUState *cpu);
-bool s390_cpu_exec_interrupt(CPUState *cpu, int int_req);
+bool s390_cpu_exec_interrupt_locked(CPUState *cpu, int int_req);
 bool s390_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                        MMUAccessType access_type, int mmu_idx,
                        bool probe, uintptr_t retaddr);
diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
index 18f3448183..f64ef0e84a 100644
--- a/target/sh4/cpu.c
+++ b/target/sh4/cpu.c
@@ -219,7 +219,7 @@ static void superh_cpu_class_init(ObjectClass *oc, void *data)
     cc->class_by_name = superh_cpu_class_by_name;
     cc->has_work = superh_cpu_has_work;
     cc->do_interrupt = superh_cpu_do_interrupt;
-    cc->cpu_exec_interrupt = superh_cpu_exec_interrupt;
+    cc->cpu_exec_interrupt = superh_cpu_exec_interrupt_locked;
     cc->dump_state = superh_cpu_dump_state;
     cc->set_pc = superh_cpu_set_pc;
     cc->synchronize_from_tb = superh_cpu_synchronize_from_tb;
diff --git a/target/sh4/cpu.h b/target/sh4/cpu.h
index dbe58c7888..c1d3400575 100644
--- a/target/sh4/cpu.h
+++ b/target/sh4/cpu.h
@@ -205,7 +205,7 @@ struct SuperHCPU {
 
 
 void superh_cpu_do_interrupt(CPUState *cpu);
-bool superh_cpu_exec_interrupt(CPUState *cpu, int int_req);
+bool superh_cpu_exec_interrupt_locked(CPUState *cpu, int int_req);
 void superh_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
 hwaddr superh_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
 int superh_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
diff --git a/target/sh4/helper.c b/target/sh4/helper.c
index 471650b622..176f9edb63 100644
--- a/target/sh4/helper.c
+++ b/target/sh4/helper.c
@@ -789,7 +789,7 @@ void superh_cpu_do_interrupt(CPUState *cs)
     qemu_mutex_unlock_iothread();
 }
 
-bool superh_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
+bool superh_cpu_exec_interrupt_locked(CPUState *cs, int interrupt_request)
 {
     if (interrupt_request & CPU_INTERRUPT_HARD) {
         SuperHCPU *cpu = SUPERH_CPU(cs);
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index 1c26bbd59b..e2b9de6672 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -77,7 +77,7 @@ static void sparc_cpu_reset(DeviceState *dev)
     env->cache_control = 0;
 }
 
-static bool sparc_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
+static bool sparc_cpu_exec_interrupt_locked(CPUState *cs, int interrupt_request)
 {
     if (interrupt_request & CPU_INTERRUPT_HARD) {
         SPARCCPU *cpu = SPARC_CPU(cs);
@@ -864,7 +864,7 @@ static void sparc_cpu_class_init(ObjectClass *oc, void *data)
     cc->parse_features = sparc_cpu_parse_features;
     cc->has_work_with_iothread_lock = sparc_cpu_has_work;
     cc->do_interrupt = sparc_cpu_do_interrupt;
-    cc->cpu_exec_interrupt = sparc_cpu_exec_interrupt;
+    cc->cpu_exec_interrupt = sparc_cpu_exec_interrupt_locked;
     cc->dump_state = sparc_cpu_dump_state;
 #if !defined(TARGET_SPARC64) && !defined(CONFIG_USER_ONLY)
     cc->memory_rw_debug = sparc_cpu_memory_rw_debug;
diff --git a/target/tilegx/cpu.c b/target/tilegx/cpu.c
index a450dc63a3..082607e111 100644
--- a/target/tilegx/cpu.c
+++ b/target/tilegx/cpu.c
@@ -132,7 +132,8 @@ static void tilegx_cpu_do_interrupt(CPUState *cs)
     qemu_mutex_unlock_iothread();
 }
 
-static bool tilegx_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
+static bool tilegx_cpu_exec_interrupt_locked(CPUState *cs,
+                                             int interrupt_request)
 {
     if (interrupt_request & CPU_INTERRUPT_HARD) {
         tilegx_cpu_do_interrupt_locked(cs);
@@ -155,7 +156,7 @@ static void tilegx_cpu_class_init(ObjectClass *oc, void *data)
     cc->class_by_name = tilegx_cpu_class_by_name;
     cc->has_work = tilegx_cpu_has_work;
     cc->do_interrupt = tilegx_cpu_do_interrupt;
-    cc->cpu_exec_interrupt = tilegx_cpu_exec_interrupt;
+    cc->cpu_exec_interrupt = tilegx_cpu_exec_interrupt_locked;
     cc->dump_state = tilegx_cpu_dump_state;
     cc->set_pc = tilegx_cpu_set_pc;
     cc->tlb_fill = tilegx_cpu_tlb_fill;
diff --git a/target/unicore32/cpu.c b/target/unicore32/cpu.c
index 06bf4b4b63..4e952e6801 100644
--- a/target/unicore32/cpu.c
+++ b/target/unicore32/cpu.c
@@ -132,7 +132,7 @@ static void uc32_cpu_class_init(ObjectClass *oc, void *data)
     cc->class_by_name = uc32_cpu_class_by_name;
     cc->has_work = uc32_cpu_has_work;
     cc->do_interrupt = uc32_cpu_do_interrupt;
-    cc->cpu_exec_interrupt = uc32_cpu_exec_interrupt;
+    cc->cpu_exec_interrupt = uc32_cpu_exec_interrupt_locked;
     cc->dump_state = uc32_cpu_dump_state;
     cc->set_pc = uc32_cpu_set_pc;
     cc->tlb_fill = uc32_cpu_tlb_fill;
diff --git a/target/unicore32/cpu.h b/target/unicore32/cpu.h
index 9453b5d7b3..1e5c557696 100644
--- a/target/unicore32/cpu.h
+++ b/target/unicore32/cpu.h
@@ -77,7 +77,7 @@ struct UniCore32CPU {
 
 void uc32_cpu_do_interrupt(CPUState *cpu);
 void uc32_cpu_do_interrupt_locked(CPUState *cpu);
-bool uc32_cpu_exec_interrupt(CPUState *cpu, int int_req);
+bool uc32_cpu_exec_interrupt_locked(CPUState *cpu, int int_req);
 void uc32_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
 hwaddr uc32_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
 
diff --git a/target/unicore32/helper.c b/target/unicore32/helper.c
index f024b83bc8..f09803eb1d 100644
--- a/target/unicore32/helper.c
+++ b/target/unicore32/helper.c
@@ -167,7 +167,7 @@ void helper_cp1_putc(target_ulong regval)
 }
 #endif /* !CONFIG_USER_ONLY */
 
-bool uc32_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
+bool uc32_cpu_exec_interrupt_locked(CPUState *cs, int interrupt_request)
 {
     if (interrupt_request & CPU_INTERRUPT_HARD) {
         UniCore32CPU *cpu = UNICORE32_CPU(cs);
diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index 0f96483563..3ab1d74044 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -191,7 +191,7 @@ static void xtensa_cpu_class_init(ObjectClass *oc, void *data)
     cc->class_by_name = xtensa_cpu_class_by_name;
     cc->has_work_with_iothread_lock = xtensa_cpu_has_work;
     cc->do_interrupt = xtensa_cpu_do_interrupt;
-    cc->cpu_exec_interrupt = xtensa_cpu_exec_interrupt;
+    cc->cpu_exec_interrupt = xtensa_cpu_exec_interrupt_locked;
     cc->dump_state = xtensa_cpu_dump_state;
     cc->set_pc = xtensa_cpu_set_pc;
     cc->gdb_read_register = xtensa_cpu_gdb_read_register;
diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index 32749378bf..be12e5ef63 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -564,7 +564,7 @@ bool xtensa_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                          MMUAccessType access_type, int mmu_idx,
                          bool probe, uintptr_t retaddr);
 void xtensa_cpu_do_interrupt(CPUState *cpu);
-bool xtensa_cpu_exec_interrupt(CPUState *cpu, int interrupt_request);
+bool xtensa_cpu_exec_interrupt_locked(CPUState *cpu, int interrupt_request);
 void xtensa_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr, vaddr addr,
                                       unsigned size, MMUAccessType access_type,
                                       int mmu_idx, MemTxAttrs attrs,
diff --git a/target/xtensa/exc_helper.c b/target/xtensa/exc_helper.c
index 822ed7aad8..14362ee86e 100644
--- a/target/xtensa/exc_helper.c
+++ b/target/xtensa/exc_helper.c
@@ -266,7 +266,7 @@ void xtensa_cpu_do_interrupt(CPUState *cs)
     qemu_mutex_unlock_iothread();
 }
 
-bool xtensa_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
+bool xtensa_cpu_exec_interrupt_locked(CPUState *cs, int interrupt_request)
 {
     if (interrupt_request & CPU_INTERRUPT_HARD) {
         cs->exception_index = EXC_IRQ;
-- 
2.17.1


