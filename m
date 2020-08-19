Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EF54C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 18:35:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE7F420658
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 18:35:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mje8cQOB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE7F420658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8SwC-0003ZJ-6J
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 14:35:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60490)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1k8SrO-0003aD-Gt
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 14:30:54 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:41887)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1k8SrG-00026b-9P
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 14:30:54 -0400
Received: by mail-pl1-x642.google.com with SMTP id f10so11223101plj.8
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2020 11:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=ff4mIfDu39mHigYNeBCaNt9Xys/4t/ibl10DTuVsP1M=;
 b=Mje8cQOBo2EoE2YYFPgZVXkpYtNv6XYre8NHb5hXZFxSTnzeQPps/TLMoHClIkMDbb
 2MNF0yjxpc8S8kOfHnHlzrWb/67k9MPrtFKWeuH/n7xXUFprHsw7E1zUtqVmFrnikKuM
 fdeIArkRpqTLa6TgnG/FzhrwQWKichRyh2e+5SBetc/4Z1PKMC4yeLC20hzpeKC4cGHS
 BUkwaCS2+laLggkoa5G42u/cmULxylSq9BgGCMYa28PpUaalbjXWw1VbfDdRdOOLiyZf
 mWCK0+DEuSZrqUhRnWqH3cvuP/NUKftT8TiusWy0imXME1GwAhk8D7uYlXNkQ8HywOLu
 4p8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=ff4mIfDu39mHigYNeBCaNt9Xys/4t/ibl10DTuVsP1M=;
 b=oss2v0Z4N1rrmgue7hntEPudCawscpZ2DPWYApRfROR/HrvALpO0BOI6pah7nH8zCK
 VD1/shZIH5aj+Ow4Qb+NH5sdFiO02SZpO7JjJzN/dcEGHuMmzyAry8tDsBoulFDbmHKK
 b+gkdrsvSGccg/EGIZ9IvGsxunDN+JL+zJHYupa2MPbE2Xkv0OEtds4MVOjTqbwS/865
 /0NB1N8ySGYaU9Bp/jbZoEPpTTnJnyhznuheU/TvtJJjOJPngO8UU4N9YkDmyA2g7nkM
 3TOlMVS3ixUzN0r9lqpttrpiUP5cjeLhFzW3GI4tDbxOOw+WL+wi6zc5KLKJJoGBtSoB
 CktQ==
X-Gm-Message-State: AOAM532UCwYVz0pD5q9e1524cQ/wTI4H4m/UlRPekraXMt4BYw3zKBvw
 495bXL99vKAtIt/IbZSKgqsIGM/KpX6E8OAu
X-Google-Smtp-Source: ABdhPJxtv74Cw6FYOGVJF4yjaGuOWqUwU7QOUxGG9C9R/t6JRFBs6kBQlpWiutlpu3vBRbWqaZ/lsg==
X-Received: by 2002:a17:90a:46c2:: with SMTP id
 x2mr5083866pjg.184.1597861842496; 
 Wed, 19 Aug 2020 11:30:42 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 (c-73-47-162-176.hsd1.ma.comcast.net. [73.47.162.176])
 by smtp.gmail.com with ESMTPSA id p20sm220766pjg.44.2020.08.19.11.30.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2020 11:30:41 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 7/7] target: Push BQL on ->cpu_exec_interrupt down into
 per-arch implementation
Date: Wed, 19 Aug 2020 14:28:56 -0400
Message-Id: <20200819182856.4893-8-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200819182856.4893-1-robert.foley@linaro.org>
References: <20200819182856.4893-1-robert.foley@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=robert.foley@linaro.org; helo=mail-pl1-x642.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 "open list:S390 TCG CPUs" <qemu-s390x@nongnu.org>,
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

Push the BQL on ->cpu_exec_interrupt down into per-arch implementation.
The first step is to remove the BQL from cpu_handle_interrupt, which
currently calls ->cpu_exec_interrupt.  We then added the *_cpu_exec_interrupt
functions, which get the BQL and then call to *_cpu_exec_interrupt_locked.
We also pointed the per-arch ->cpu_exec_interrupt at the new
*cpu_exec_interrupt.

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
 accel/tcg/cpu-exec.c            |  2 --
 target/alpha/cpu.c              |  2 +-
 target/alpha/cpu.h              |  2 +-
 target/alpha/helper.c           | 11 ++++++++++-
 target/arm/cpu.c                | 13 +++++++++++--
 target/arm/cpu.h                |  2 +-
 target/arm/cpu64.c              |  2 +-
 target/arm/cpu_tcg.c            | 11 ++++++++++-
 target/avr/cpu.c                |  2 +-
 target/avr/cpu.h                |  2 +-
 target/avr/helper.c             | 11 ++++++++++-
 target/cris/cpu.c               |  2 +-
 target/cris/cpu.h               |  2 +-
 target/cris/helper.c            | 11 ++++++++++-
 target/hppa/cpu.c               |  2 +-
 target/hppa/cpu.h               |  2 +-
 target/hppa/int_helper.c        | 11 ++++++++++-
 target/i386/cpu.c               |  2 +-
 target/i386/cpu.h               |  2 +-
 target/i386/seg_helper.c        | 11 ++++++++++-
 target/lm32/cpu.c               |  2 +-
 target/lm32/cpu.h               |  2 +-
 target/lm32/helper.c            | 11 ++++++++++-
 target/m68k/cpu.c               |  2 +-
 target/m68k/cpu.h               |  2 +-
 target/m68k/op_helper.c         | 11 ++++++++++-
 target/microblaze/cpu.c         |  2 +-
 target/microblaze/cpu.h         |  2 +-
 target/microblaze/helper.c      | 11 ++++++++++-
 target/mips/cpu.c               |  2 +-
 target/mips/helper.c            | 11 ++++++++++-
 target/mips/internal.h          |  2 +-
 target/nios2/cpu.c              | 11 ++++++++++-
 target/openrisc/cpu.c           |  2 +-
 target/openrisc/cpu.h           |  2 +-
 target/openrisc/interrupt.c     | 12 +++++++++++-
 target/ppc/cpu.h                |  2 +-
 target/ppc/excp_helper.c        | 11 ++++++++++-
 target/ppc/translate_init.inc.c |  2 +-
 target/riscv/cpu.c              |  2 +-
 target/riscv/cpu.h              |  2 +-
 target/riscv/cpu_helper.c       | 11 ++++++++++-
 target/rx/cpu.c                 |  2 +-
 target/rx/cpu.h                 |  2 +-
 target/rx/helper.c              | 11 ++++++++++-
 target/s390x/cpu.c              |  2 +-
 target/s390x/excp_helper.c      | 11 ++++++++++-
 target/s390x/internal.h         |  2 +-
 target/sh4/cpu.c                |  2 +-
 target/sh4/cpu.h                |  2 +-
 target/sh4/helper.c             | 12 +++++++++++-
 target/sparc/cpu.c              | 11 ++++++++++-
 target/tilegx/cpu.c             | 11 ++++++++++-
 target/unicore32/cpu.c          |  2 +-
 target/unicore32/cpu.h          |  2 +-
 target/unicore32/helper.c       | 11 ++++++++++-
 target/xtensa/cpu.c             |  2 +-
 target/xtensa/cpu.h             |  2 +-
 target/xtensa/exc_helper.c      | 12 +++++++++++-
 59 files changed, 260 insertions(+), 61 deletions(-)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 499a8bdc5e..c4e54baa6f 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -599,7 +599,6 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
            True when it is, and we should restart on a new TB,
            and via longjmp via cpu_loop_exit.  */
         else {
-            qemu_mutex_lock_iothread();
             if (cc->cpu_exec_interrupt(cpu, interrupt_request)) {
                 replay_interrupt();
                 /*
@@ -614,7 +613,6 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
             /* The target hook may have updated the 'cpu->interrupt_request';
              * reload the 'interrupt_request' value */
             interrupt_request = cpu_interrupt_request(cpu);
-            qemu_mutex_unlock_iothread();
         }
         if (interrupt_request & CPU_INTERRUPT_EXITTB) {
             cpu_reset_interrupt(cpu, CPU_INTERRUPT_EXITTB);
diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
index 623ed42e13..09677c6c44 100644
--- a/target/alpha/cpu.c
+++ b/target/alpha/cpu.c
@@ -218,7 +218,7 @@ static void alpha_cpu_class_init(ObjectClass *oc, void *data)
     cc->class_by_name = alpha_cpu_class_by_name;
     cc->has_work = alpha_cpu_has_work;
     cc->do_interrupt = alpha_cpu_do_interrupt;
-    cc->cpu_exec_interrupt = alpha_cpu_exec_interrupt_locked;
+    cc->cpu_exec_interrupt = alpha_cpu_exec_interrupt;
     cc->dump_state = alpha_cpu_dump_state;
     cc->set_pc = alpha_cpu_set_pc;
     cc->gdb_read_register = alpha_cpu_gdb_read_register;
diff --git a/target/alpha/cpu.h b/target/alpha/cpu.h
index 9ed82b5785..be29bdd530 100644
--- a/target/alpha/cpu.h
+++ b/target/alpha/cpu.h
@@ -277,7 +277,7 @@ extern const VMStateDescription vmstate_alpha_cpu;
 #endif
 
 void alpha_cpu_do_interrupt(CPUState *cpu);
-bool alpha_cpu_exec_interrupt_locked(CPUState *cpu, int int_req);
+bool alpha_cpu_exec_interrupt(CPUState *cpu, int int_req);
 void alpha_cpu_dump_state(CPUState *cs, FILE *f, int flags);
 hwaddr alpha_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
 int alpha_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
diff --git a/target/alpha/helper.c b/target/alpha/helper.c
index b5fa849f0f..3980b05318 100644
--- a/target/alpha/helper.c
+++ b/target/alpha/helper.c
@@ -414,7 +414,7 @@ void alpha_cpu_do_interrupt(CPUState *cs)
     qemu_mutex_unlock_iothread();
 }
 
-bool alpha_cpu_exec_interrupt_locked(CPUState *cs, int interrupt_request)
+static bool alpha_cpu_exec_interrupt_locked(CPUState *cs, int interrupt_request)
 {
     AlphaCPU *cpu = ALPHA_CPU(cs);
     CPUAlphaState *env = &cpu->env;
@@ -458,6 +458,15 @@ bool alpha_cpu_exec_interrupt_locked(CPUState *cs, int interrupt_request)
     return false;
 }
 
+bool alpha_cpu_exec_interrupt(CPUState *cs, int int_req)
+{
+    bool status;
+    qemu_mutex_lock_iothread();
+    status = alpha_cpu_exec_interrupt_locked(cs, int_req);
+    qemu_mutex_unlock_iothread();
+    return status;
+}
+
 void alpha_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 {
     static const char linux_reg_names[31][4] = {
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index a294739b94..b82e83ad36 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -524,7 +524,7 @@ static inline bool arm_excp_unmasked(CPUState *cs, unsigned int excp_idx,
     return unmasked || pstate_unmasked;
 }
 
-bool arm_cpu_exec_interrupt_locked(CPUState *cs, int interrupt_request)
+static bool arm_cpu_exec_interrupt_locked(CPUState *cs, int interrupt_request)
 {
     ARMCPUClass *acc = ARM_CPU_GET_CLASS(cs);
     CPUARMState *env = cs->env_ptr;
@@ -577,6 +577,15 @@ bool arm_cpu_exec_interrupt_locked(CPUState *cs, int interrupt_request)
     return true;
 }
 
+bool arm_cpu_exec_interrupt(CPUState *cs, int int_req)
+{
+    bool status;
+    qemu_mutex_lock_iothread();
+    status = arm_cpu_exec_interrupt_locked(cs, int_req);
+    qemu_mutex_unlock_iothread();
+    return status;
+}
+
 void arm_cpu_update_virq(ARMCPU *cpu)
 {
     /*
@@ -2217,7 +2226,7 @@ static void arm_cpu_class_init(ObjectClass *oc, void *data)
 
     cc->class_by_name = arm_cpu_class_by_name;
     cc->has_work = arm_cpu_has_work;
-    cc->cpu_exec_interrupt = arm_cpu_exec_interrupt_locked;
+    cc->cpu_exec_interrupt = arm_cpu_exec_interrupt;
     cc->dump_state = arm_cpu_dump_state;
     cc->set_pc = arm_cpu_set_pc;
     cc->synchronize_from_tb = arm_cpu_synchronize_from_tb;
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 8f423fcd3b..57b8904dec 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -995,7 +995,7 @@ void arm_cpu_do_interrupt(CPUState *cpu);
 void arm_cpu_do_interrupt_locked(CPUState *cpu);
 void arm_v7m_cpu_do_interrupt(CPUState *cpu);
 void arm_v7m_cpu_do_interrupt_locked(CPUState *cpu);
-bool arm_cpu_exec_interrupt_locked(CPUState *cpu, int int_req);
+bool arm_cpu_exec_interrupt(CPUState *cpu, int int_req);
 
 hwaddr arm_cpu_get_phys_page_attrs_debug(CPUState *cpu, vaddr addr,
                                          MemTxAttrs *attrs);
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index c6c2e6709c..dd696183df 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -782,7 +782,7 @@ static void aarch64_cpu_class_init(ObjectClass *oc, void *data)
 {
     CPUClass *cc = CPU_CLASS(oc);
 
-    cc->cpu_exec_interrupt = arm_cpu_exec_interrupt_locked;
+    cc->cpu_exec_interrupt = arm_cpu_exec_interrupt;
     cc->gdb_read_register = aarch64_cpu_gdb_read_register;
     cc->gdb_write_register = aarch64_cpu_gdb_write_register;
     cc->gdb_num_core_regs = 34;
diff --git a/target/arm/cpu_tcg.c b/target/arm/cpu_tcg.c
index 8376497139..f090c989f2 100644
--- a/target/arm/cpu_tcg.c
+++ b/target/arm/cpu_tcg.c
@@ -40,6 +40,15 @@ static bool arm_v7m_cpu_exec_interrupt_locked(CPUState *cs,
     return ret;
 }
 
+static bool arm_v7m_cpu_exec_interrupt(CPUState *cs, int int_req)
+{
+    bool status;
+    qemu_mutex_lock_iothread();
+    status = arm_v7m_cpu_exec_interrupt_locked(cs, int_req);
+    qemu_mutex_unlock_iothread();
+    return status;
+}
+
 static void arm926_initfn(Object *obj)
 {
     ARMCPU *cpu = ARM_CPU(obj);
@@ -606,7 +615,7 @@ static void arm_v7m_class_init(ObjectClass *oc, void *data)
     acc->do_interrupt_locked = arm_v7m_cpu_do_interrupt_locked;
 #endif
 
-    cc->cpu_exec_interrupt = arm_v7m_cpu_exec_interrupt_locked;
+    cc->cpu_exec_interrupt = arm_v7m_cpu_exec_interrupt;
     cc->gdb_core_xml_file = "arm-m-profile.xml";
 }
 
diff --git a/target/avr/cpu.c b/target/avr/cpu.c
index 5439b1bc50..5d9c4ad5bf 100644
--- a/target/avr/cpu.c
+++ b/target/avr/cpu.c
@@ -198,7 +198,7 @@ static void avr_cpu_class_init(ObjectClass *oc, void *data)
 
     cc->has_work = avr_cpu_has_work;
     cc->do_interrupt = avr_cpu_do_interrupt;
-    cc->cpu_exec_interrupt = avr_cpu_exec_interrupt_locked;
+    cc->cpu_exec_interrupt = avr_cpu_exec_interrupt;
     cc->dump_state = avr_cpu_dump_state;
     cc->set_pc = avr_cpu_set_pc;
     cc->memory_rw_debug = avr_cpu_memory_rw_debug;
diff --git a/target/avr/cpu.h b/target/avr/cpu.h
index 559cf56ff9..d148e8c75a 100644
--- a/target/avr/cpu.h
+++ b/target/avr/cpu.h
@@ -157,7 +157,7 @@ typedef struct AVRCPU {
 extern const struct VMStateDescription vms_avr_cpu;
 
 void avr_cpu_do_interrupt(CPUState *cpu);
-bool avr_cpu_exec_interrupt_locked(CPUState *cpu, int int_req);
+bool avr_cpu_exec_interrupt(CPUState *cpu, int int_req);
 hwaddr avr_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
 int avr_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
 int avr_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
diff --git a/target/avr/helper.c b/target/avr/helper.c
index a5c72157a1..042bfe30d8 100644
--- a/target/avr/helper.c
+++ b/target/avr/helper.c
@@ -26,7 +26,7 @@
 
 static void avr_cpu_do_interrupt_locked(CPUState *cs);
 
-bool avr_cpu_exec_interrupt_locked(CPUState *cs, int interrupt_request)
+static bool avr_cpu_exec_interrupt_locked(CPUState *cs, int interrupt_request)
 {
     bool ret = false;
     AVRCPU *cpu = AVR_CPU(cs);
@@ -57,6 +57,15 @@ bool avr_cpu_exec_interrupt_locked(CPUState *cs, int interrupt_request)
     return ret;
 }
 
+bool avr_cpu_exec_interrupt(CPUState *cs, int int_req)
+{
+    bool status;
+    qemu_mutex_lock_iothread();
+    status = avr_cpu_exec_interrupt_locked(cs, int_req);
+    qemu_mutex_unlock_iothread();
+    return status;
+}
+
 static void avr_cpu_do_interrupt_locked(CPUState *cs)
 {
     AVRCPU *cpu = AVR_CPU(cs);
diff --git a/target/cris/cpu.c b/target/cris/cpu.c
index 81acfb3d66..c3d77c31e8 100644
--- a/target/cris/cpu.c
+++ b/target/cris/cpu.c
@@ -270,7 +270,7 @@ static void cris_cpu_class_init(ObjectClass *oc, void *data)
     cc->has_work = cris_cpu_has_work;
     cc->do_interrupt = cris_cpu_do_interrupt;
     ccc->do_interrupt_locked = cris_cpu_do_interrupt_locked;
-    cc->cpu_exec_interrupt = cris_cpu_exec_interrupt_locked;
+    cc->cpu_exec_interrupt = cris_cpu_exec_interrupt;
     cc->dump_state = cris_cpu_dump_state;
     cc->set_pc = cris_cpu_set_pc;
     cc->gdb_read_register = cris_cpu_gdb_read_register;
diff --git a/target/cris/cpu.h b/target/cris/cpu.h
index a60fb9c1e7..d8ee6b9400 100644
--- a/target/cris/cpu.h
+++ b/target/cris/cpu.h
@@ -190,7 +190,7 @@ extern const VMStateDescription vmstate_cris_cpu;
 void cris_cpu_do_interrupt(CPUState *cpu);
 void cris_cpu_do_interrupt_locked(CPUState *cpu);
 void crisv10_cpu_do_interrupt_locked(CPUState *cpu);
-bool cris_cpu_exec_interrupt_locked(CPUState *cpu, int int_req);
+bool cris_cpu_exec_interrupt(CPUState *cpu, int int_req);
 
 void cris_cpu_dump_state(CPUState *cs, FILE *f, int flags);
 
diff --git a/target/cris/helper.c b/target/cris/helper.c
index 9dabc8af96..7848313886 100644
--- a/target/cris/helper.c
+++ b/target/cris/helper.c
@@ -296,7 +296,7 @@ hwaddr cris_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
 }
 #endif
 
-bool cris_cpu_exec_interrupt_locked(CPUState *cs, int interrupt_request)
+static bool cris_cpu_exec_interrupt_locked(CPUState *cs, int interrupt_request)
 {
     CRISCPUClass *ccc = CRIS_CPU_CLASS(cs);
     CRISCPU *cpu = CRIS_CPU(cs);
@@ -326,3 +326,12 @@ bool cris_cpu_exec_interrupt_locked(CPUState *cs, int interrupt_request)
 
     return ret;
 }
+
+bool cris_cpu_exec_interrupt(CPUState *cs, int int_req)
+{
+    bool status;
+    qemu_mutex_lock_iothread();
+    status = cris_cpu_exec_interrupt_locked(cs, int_req);
+    qemu_mutex_unlock_iothread();
+    return status;
+}
diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index e800fba3f7..287055f96e 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -140,7 +140,7 @@ static void hppa_cpu_class_init(ObjectClass *oc, void *data)
     cc->class_by_name = hppa_cpu_class_by_name;
     cc->has_work = hppa_cpu_has_work;
     cc->do_interrupt = hppa_cpu_do_interrupt;
-    cc->cpu_exec_interrupt = hppa_cpu_exec_interrupt_locked;
+    cc->cpu_exec_interrupt = hppa_cpu_exec_interrupt;
     cc->dump_state = hppa_cpu_dump_state;
     cc->set_pc = hppa_cpu_set_pc;
     cc->synchronize_from_tb = hppa_cpu_synchronize_from_tb;
diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index 6e32d5581a..801a4fb1ba 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -324,7 +324,7 @@ hwaddr hppa_cpu_get_phys_page_debug(CPUState *cs, vaddr addr);
 int hppa_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
 int hppa_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 void hppa_cpu_do_interrupt(CPUState *cpu);
-bool hppa_cpu_exec_interrupt_locked(CPUState *cpu, int int_req);
+bool hppa_cpu_exec_interrupt(CPUState *cpu, int int_req);
 void hppa_cpu_dump_state(CPUState *cs, FILE *f, int);
 bool hppa_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                        MMUAccessType access_type, int mmu_idx,
diff --git a/target/hppa/int_helper.c b/target/hppa/int_helper.c
index 82bdee5452..9239d050e9 100644
--- a/target/hppa/int_helper.c
+++ b/target/hppa/int_helper.c
@@ -253,7 +253,7 @@ void hppa_cpu_do_interrupt(CPUState *cs)
     qemu_mutex_unlock_iothread();
 }
 
-bool hppa_cpu_exec_interrupt_locked(CPUState *cs, int interrupt_request)
+static bool hppa_cpu_exec_interrupt_locked(CPUState *cs, int interrupt_request)
 {
 #ifndef CONFIG_USER_ONLY
     HPPACPU *cpu = HPPA_CPU(cs);
@@ -268,3 +268,12 @@ bool hppa_cpu_exec_interrupt_locked(CPUState *cs, int interrupt_request)
 #endif
     return false;
 }
+
+bool hppa_cpu_exec_interrupt(CPUState *cs, int int_req)
+{
+    bool status;
+    qemu_mutex_lock_iothread();
+    status = hppa_cpu_exec_interrupt_locked(cs, int_req);
+    qemu_mutex_unlock_iothread();
+    return status;
+}
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index fa40513211..592aa0baf7 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -7298,7 +7298,7 @@ static void x86_cpu_common_class_init(ObjectClass *oc, void *data)
     cc->has_work = x86_cpu_has_work;
 #ifdef CONFIG_TCG
     cc->do_interrupt = x86_cpu_do_interrupt;
-    cc->cpu_exec_interrupt = x86_cpu_exec_interrupt_locked;
+    cc->cpu_exec_interrupt = x86_cpu_exec_interrupt;
 #endif
     cc->dump_state = x86_cpu_dump_state;
     cc->set_pc = x86_cpu_set_pc;
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index aa183005b2..d784eeaf29 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1771,7 +1771,7 @@ extern VMStateDescription vmstate_x86_cpu;
  * @cpu: vCPU the interrupt is to be handled by.
  */
 void x86_cpu_do_interrupt(CPUState *cpu);
-bool x86_cpu_exec_interrupt_locked(CPUState *cpu, int int_req);
+bool x86_cpu_exec_interrupt(CPUState *cpu, int int_req);
 int x86_cpu_pending_interrupt(CPUState *cs, int interrupt_request);
 
 int x86_cpu_write_elf64_note(WriteCoreDumpFunction f, CPUState *cpu,
diff --git a/target/i386/seg_helper.c b/target/i386/seg_helper.c
index 6485cceaae..9ab714a79e 100644
--- a/target/i386/seg_helper.c
+++ b/target/i386/seg_helper.c
@@ -1322,7 +1322,7 @@ void do_interrupt_x86_hardirq(CPUX86State *env, int intno, int is_hw)
     do_interrupt_all(env_archcpu(env), intno, 0, 0, 0, is_hw);
 }
 
-bool x86_cpu_exec_interrupt_locked(CPUState *cs, int interrupt_request)
+static bool x86_cpu_exec_interrupt_locked(CPUState *cs, int interrupt_request)
 {
     X86CPU *cpu = X86_CPU(cs);
     CPUX86State *env = &cpu->env;
@@ -1387,6 +1387,15 @@ bool x86_cpu_exec_interrupt_locked(CPUState *cs, int interrupt_request)
     return true;
 }
 
+bool x86_cpu_exec_interrupt(CPUState *cs, int int_req)
+{
+    bool status;
+    qemu_mutex_lock_iothread();
+    status = x86_cpu_exec_interrupt_locked(cs, int_req);
+    qemu_mutex_unlock_iothread();
+    return status;
+}
+
 void helper_lldt(CPUX86State *env, int selector)
 {
     SegmentCache *dt;
diff --git a/target/lm32/cpu.c b/target/lm32/cpu.c
index c7b95f9271..9e7d8ca929 100644
--- a/target/lm32/cpu.c
+++ b/target/lm32/cpu.c
@@ -223,7 +223,7 @@ static void lm32_cpu_class_init(ObjectClass *oc, void *data)
     cc->class_by_name = lm32_cpu_class_by_name;
     cc->has_work = lm32_cpu_has_work;
     cc->do_interrupt = lm32_cpu_do_interrupt;
-    cc->cpu_exec_interrupt = lm32_cpu_exec_interrupt_locked;
+    cc->cpu_exec_interrupt = lm32_cpu_exec_interrupt;
     cc->dump_state = lm32_cpu_dump_state;
     cc->set_pc = lm32_cpu_set_pc;
     cc->gdb_read_register = lm32_cpu_gdb_read_register;
diff --git a/target/lm32/cpu.h b/target/lm32/cpu.h
index ee68a2563b..01d408eb55 100644
--- a/target/lm32/cpu.h
+++ b/target/lm32/cpu.h
@@ -199,7 +199,7 @@ extern const VMStateDescription vmstate_lm32_cpu;
 #endif
 
 void lm32_cpu_do_interrupt(CPUState *cpu);
-bool lm32_cpu_exec_interrupt_locked(CPUState *cs, int int_req);
+bool lm32_cpu_exec_interrupt(CPUState *cs, int int_req);
 void lm32_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
 hwaddr lm32_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
 int lm32_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
diff --git a/target/lm32/helper.c b/target/lm32/helper.c
index 6c37e6a898..bc7dd7e09e 100644
--- a/target/lm32/helper.c
+++ b/target/lm32/helper.c
@@ -205,7 +205,7 @@ void lm32_cpu_do_interrupt(CPUState *cs)
     qemu_mutex_unlock_iothread();
 }
 
-bool lm32_cpu_exec_interrupt_locked(CPUState *cs, int interrupt_request)
+static bool lm32_cpu_exec_interrupt_locked(CPUState *cs, int interrupt_request)
 {
     LM32CPU *cpu = LM32_CPU(cs);
     CPULM32State *env = &cpu->env;
@@ -218,6 +218,15 @@ bool lm32_cpu_exec_interrupt_locked(CPUState *cs, int interrupt_request)
     return false;
 }
 
+bool lm32_cpu_exec_interrupt(CPUState *cs, int int_req)
+{
+    bool status;
+    qemu_mutex_lock_iothread();
+    status = lm32_cpu_exec_interrupt_locked(cs, int_req);
+    qemu_mutex_unlock_iothread();
+    return status;
+}
+
 /* Some soc ignores the MSB on the address bus. Thus creating a shadow memory
  * area. As a general rule, 0x00000000-0x7fffffff is cached, whereas
  * 0x80000000-0xffffffff is not cached and used to access IO devices. */
diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index 1a75e6d968..f2585154f5 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -278,7 +278,7 @@ static void m68k_cpu_class_init(ObjectClass *c, void *data)
     cc->class_by_name = m68k_cpu_class_by_name;
     cc->has_work = m68k_cpu_has_work;
     cc->do_interrupt = m68k_cpu_do_interrupt;
-    cc->cpu_exec_interrupt = m68k_cpu_exec_interrupt_locked;
+    cc->cpu_exec_interrupt = m68k_cpu_exec_interrupt;
     cc->dump_state = m68k_cpu_dump_state;
     cc->set_pc = m68k_cpu_set_pc;
     cc->gdb_read_register = m68k_cpu_gdb_read_register;
diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index 6114a94585..521ac67cdd 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -165,7 +165,7 @@ struct M68kCPU {
 
 
 void m68k_cpu_do_interrupt(CPUState *cpu);
-bool m68k_cpu_exec_interrupt_locked(CPUState *cpu, int int_req);
+bool m68k_cpu_exec_interrupt(CPUState *cpu, int int_req);
 void m68k_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
 hwaddr m68k_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
 int m68k_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
diff --git a/target/m68k/op_helper.c b/target/m68k/op_helper.c
index 2f71e5994d..da1f67e9c5 100644
--- a/target/m68k/op_helper.c
+++ b/target/m68k/op_helper.c
@@ -511,7 +511,7 @@ void m68k_cpu_do_interrupt(CPUState *cs)
     qemu_mutex_unlock_iothread();
 }
 
-bool m68k_cpu_exec_interrupt_locked(CPUState *cs, int interrupt_request)
+static bool m68k_cpu_exec_interrupt_locked(CPUState *cs, int interrupt_request)
 {
     M68kCPU *cpu = M68K_CPU(cs);
     CPUM68KState *env = &cpu->env;
@@ -531,6 +531,15 @@ bool m68k_cpu_exec_interrupt_locked(CPUState *cs, int interrupt_request)
     return false;
 }
 
+bool m68k_cpu_exec_interrupt(CPUState *cs, int int_req)
+{
+    bool status;
+    qemu_mutex_lock_iothread();
+    status = m68k_cpu_exec_interrupt_locked(cs, int_req);
+    qemu_mutex_unlock_iothread();
+    return status;
+}
+
 static void raise_exception_ra(CPUM68KState *env, int tt, uintptr_t raddr)
 {
     CPUState *cs = env_cpu(env);
diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index 23e1367f83..ce70f7d281 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -317,7 +317,7 @@ static void mb_cpu_class_init(ObjectClass *oc, void *data)
     cc->class_by_name = mb_cpu_class_by_name;
     cc->has_work = mb_cpu_has_work;
     cc->do_interrupt = mb_cpu_do_interrupt;
-    cc->cpu_exec_interrupt = mb_cpu_exec_interrupt_locked;
+    cc->cpu_exec_interrupt = mb_cpu_exec_interrupt;
     cc->dump_state = mb_cpu_dump_state;
     cc->set_pc = mb_cpu_set_pc;
     cc->gdb_read_register = mb_cpu_gdb_read_register;
diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index e0b665624c..a31134b65c 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -316,7 +316,7 @@ struct MicroBlazeCPU {
 
 
 void mb_cpu_do_interrupt(CPUState *cs);
-bool mb_cpu_exec_interrupt_locked(CPUState *cs, int int_req);
+bool mb_cpu_exec_interrupt(CPUState *cs, int int_req);
 void mb_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
 hwaddr mb_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
 int mb_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
diff --git a/target/microblaze/helper.c b/target/microblaze/helper.c
index 582e607d88..023ac6d4a5 100644
--- a/target/microblaze/helper.c
+++ b/target/microblaze/helper.c
@@ -294,7 +294,7 @@ void mb_cpu_do_interrupt(CPUState *cs)
     qemu_mutex_unlock_iothread();
 }
 
-bool mb_cpu_exec_interrupt_locked(CPUState *cs, int interrupt_request)
+static bool mb_cpu_exec_interrupt_locked(CPUState *cs, int interrupt_request)
 {
     MicroBlazeCPU *cpu = MICROBLAZE_CPU(cs);
     CPUMBState *env = &cpu->env;
@@ -309,3 +309,12 @@ bool mb_cpu_exec_interrupt_locked(CPUState *cs, int interrupt_request)
     }
     return false;
 }
+
+bool mb_cpu_exec_interrupt(CPUState *cs, int int_req)
+{
+    bool status;
+    qemu_mutex_lock_iothread();
+    status = mb_cpu_exec_interrupt_locked(cs, int_req);
+    qemu_mutex_unlock_iothread();
+    return status;
+}
diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index 520aefe669..ec9dde5100 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -197,7 +197,7 @@ static void mips_cpu_class_init(ObjectClass *c, void *data)
     cc->class_by_name = mips_cpu_class_by_name;
     cc->has_work_with_iothread_lock = mips_cpu_has_work;
     cc->do_interrupt = mips_cpu_do_interrupt;
-    cc->cpu_exec_interrupt = mips_cpu_exec_interrupt_locked;
+    cc->cpu_exec_interrupt = mips_cpu_exec_interrupt;
     cc->dump_state = mips_cpu_dump_state;
     cc->set_pc = mips_cpu_set_pc;
     cc->synchronize_from_tb = mips_cpu_synchronize_from_tb;
diff --git a/target/mips/helper.c b/target/mips/helper.c
index c546788bea..ba8b06537d 100644
--- a/target/mips/helper.c
+++ b/target/mips/helper.c
@@ -1405,7 +1405,7 @@ void mips_cpu_do_interrupt(CPUState *cs)
     qemu_mutex_unlock_iothread();
 }
 
-bool mips_cpu_exec_interrupt_locked(CPUState *cs, int interrupt_request)
+static bool mips_cpu_exec_interrupt_locked(CPUState *cs, int interrupt_request)
 {
     if (interrupt_request & CPU_INTERRUPT_HARD) {
         MIPSCPU *cpu = MIPS_CPU(cs);
@@ -1423,6 +1423,15 @@ bool mips_cpu_exec_interrupt_locked(CPUState *cs, int interrupt_request)
     return false;
 }
 
+bool mips_cpu_exec_interrupt(CPUState *cs, int int_req)
+{
+    bool status;
+    qemu_mutex_lock_iothread();
+    status = mips_cpu_exec_interrupt_locked(cs, int_req);
+    qemu_mutex_unlock_iothread();
+    return status;
+}
+
 #if !defined(CONFIG_USER_ONLY)
 void r4k_invalidate_tlb(CPUMIPSState *env, int idx, int use_extra)
 {
diff --git a/target/mips/internal.h b/target/mips/internal.h
index 24069f6f70..7f159a9230 100644
--- a/target/mips/internal.h
+++ b/target/mips/internal.h
@@ -81,7 +81,7 @@ enum CPUMIPSMSADataFormat {
 };
 
 void mips_cpu_do_interrupt(CPUState *cpu);
-bool mips_cpu_exec_interrupt_locked(CPUState *cpu, int int_req);
+bool mips_cpu_exec_interrupt(CPUState *cpu, int int_req);
 void mips_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
 hwaddr mips_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
 int mips_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
diff --git a/target/nios2/cpu.c b/target/nios2/cpu.c
index d2617ed28a..4ec0a161cb 100644
--- a/target/nios2/cpu.c
+++ b/target/nios2/cpu.c
@@ -112,6 +112,15 @@ static bool nios2_cpu_exec_interrupt_locked(CPUState *cs, int interrupt_request)
     return false;
 }
 
+static bool nios2_cpu_exec_interrupt(CPUState *cs, int int_req)
+{
+    bool status;
+    qemu_mutex_lock_iothread();
+    status = nios2_cpu_exec_interrupt_locked(cs, int_req);
+    qemu_mutex_unlock_iothread();
+    return status;
+}
+
 
 static void nios2_cpu_disas_set_info(CPUState *cpu, disassemble_info *info)
 {
@@ -193,7 +202,7 @@ static void nios2_cpu_class_init(ObjectClass *oc, void *data)
     cc->class_by_name = nios2_cpu_class_by_name;
     cc->has_work = nios2_cpu_has_work;
     cc->do_interrupt = nios2_cpu_do_interrupt;
-    cc->cpu_exec_interrupt = nios2_cpu_exec_interrupt_locked;
+    cc->cpu_exec_interrupt = nios2_cpu_exec_interrupt;
     cc->dump_state = nios2_cpu_dump_state;
     cc->set_pc = nios2_cpu_set_pc;
     cc->disas_set_info = nios2_cpu_disas_set_info;
diff --git a/target/openrisc/cpu.c b/target/openrisc/cpu.c
index d44b76aaa7..fd2da39124 100644
--- a/target/openrisc/cpu.c
+++ b/target/openrisc/cpu.c
@@ -155,7 +155,7 @@ static void openrisc_cpu_class_init(ObjectClass *oc, void *data)
     cc->class_by_name = openrisc_cpu_class_by_name;
     cc->has_work = openrisc_cpu_has_work;
     cc->do_interrupt = openrisc_cpu_do_interrupt;
-    cc->cpu_exec_interrupt = openrisc_cpu_exec_interrupt_locked;
+    cc->cpu_exec_interrupt = openrisc_cpu_exec_interrupt;
     cc->dump_state = openrisc_cpu_dump_state;
     cc->set_pc = openrisc_cpu_set_pc;
     cc->gdb_read_register = openrisc_cpu_gdb_read_register;
diff --git a/target/openrisc/cpu.h b/target/openrisc/cpu.h
index 5cb5e0fa95..f37a52e153 100644
--- a/target/openrisc/cpu.h
+++ b/target/openrisc/cpu.h
@@ -317,7 +317,7 @@ typedef struct OpenRISCCPU {
 
 void cpu_openrisc_list(void);
 void openrisc_cpu_do_interrupt(CPUState *cpu);
-bool openrisc_cpu_exec_interrupt_locked(CPUState *cpu, int int_req);
+bool openrisc_cpu_exec_interrupt(CPUState *cpu, int int_req);
 void openrisc_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
 hwaddr openrisc_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
 int openrisc_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
diff --git a/target/openrisc/interrupt.c b/target/openrisc/interrupt.c
index fcfe447e96..fb98ede373 100644
--- a/target/openrisc/interrupt.c
+++ b/target/openrisc/interrupt.c
@@ -108,7 +108,8 @@ void openrisc_cpu_do_interrupt(CPUState *cs)
     qemu_mutex_unlock_iothread();
 }
 
-bool openrisc_cpu_exec_interrupt_locked(CPUState *cs, int interrupt_request)
+static bool openrisc_cpu_exec_interrupt_locked(CPUState *cs,
+                                               int interrupt_request)
 {
     OpenRISCCPU *cpu = OPENRISC_CPU(cs);
     CPUOpenRISCState *env = &cpu->env;
@@ -127,3 +128,12 @@ bool openrisc_cpu_exec_interrupt_locked(CPUState *cs, int interrupt_request)
     }
     return false;
 }
+
+bool openrisc_cpu_exec_interrupt(CPUState *cs, int int_req)
+{
+    bool status;
+    qemu_mutex_lock_iothread();
+    status = openrisc_cpu_exec_interrupt_locked(cs, int_req);
+    qemu_mutex_unlock_iothread();
+    return status;
+}
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 75e8a61f8c..2569d43e59 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1233,7 +1233,7 @@ struct PPCVirtualHypervisorClass {
 
 void ppc_cpu_do_interrupt(CPUState *cpu);
 void ppc_cpu_do_interrupt_locked(CPUState *cpu);
-bool ppc_cpu_exec_interrupt_locked(CPUState *cpu, int int_req);
+bool ppc_cpu_exec_interrupt(CPUState *cpu, int int_req);
 void ppc_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
 void ppc_cpu_dump_statistics(CPUState *cpu, int flags);
 hwaddr ppc_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 51b36aff06..79ad9dbf49 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -1052,7 +1052,7 @@ void ppc_cpu_do_fwnmi_machine_check(CPUState *cs, target_ulong vector)
 }
 #endif /* !CONFIG_USER_ONLY */
 
-bool ppc_cpu_exec_interrupt_locked(CPUState *cs, int interrupt_request)
+static bool ppc_cpu_exec_interrupt_locked(CPUState *cs, int interrupt_request)
 {
     PowerPCCPU *cpu = POWERPC_CPU(cs);
     CPUPPCState *env = &cpu->env;
@@ -1435,3 +1435,12 @@ void ppc_cpu_do_interrupt(CPUState *cs)
     ppc_cpu_do_interrupt_locked(cs);
     qemu_mutex_unlock_iothread();
 }
+
+bool ppc_cpu_exec_interrupt(CPUState *cs, int int_req)
+{
+    bool status;
+    qemu_mutex_lock_iothread();
+    status = ppc_cpu_exec_interrupt_locked(cs, int_req);
+    qemu_mutex_unlock_iothread();
+    return status;
+}
diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.inc.c
index 5037299efa..27ae7fa195 100644
--- a/target/ppc/translate_init.inc.c
+++ b/target/ppc/translate_init.inc.c
@@ -10886,7 +10886,7 @@ static void ppc_cpu_class_init(ObjectClass *oc, void *data)
     cc->parse_features = ppc_cpu_parse_featurestr;
     cc->has_work_with_iothread_lock = ppc_cpu_has_work;
     cc->do_interrupt = ppc_cpu_do_interrupt;
-    cc->cpu_exec_interrupt = ppc_cpu_exec_interrupt_locked;
+    cc->cpu_exec_interrupt = ppc_cpu_exec_interrupt;
     cc->dump_state = ppc_cpu_dump_state;
     cc->dump_statistics = ppc_cpu_dump_statistics;
     cc->set_pc = ppc_cpu_set_pc;
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 5d1332b8c9..832171c360 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -538,7 +538,7 @@ static void riscv_cpu_class_init(ObjectClass *c, void *data)
     cc->class_by_name = riscv_cpu_class_by_name;
     cc->has_work_with_iothread_lock = riscv_cpu_has_work;
     cc->do_interrupt = riscv_cpu_do_interrupt;
-    cc->cpu_exec_interrupt = riscv_cpu_exec_interrupt_locked;
+    cc->cpu_exec_interrupt = riscv_cpu_exec_interrupt;
     cc->dump_state = riscv_cpu_dump_state;
     cc->set_pc = riscv_cpu_set_pc;
     cc->synchronize_from_tb = riscv_cpu_synchronize_from_tb;
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 6090420ce2..a804a5d0ba 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -315,7 +315,7 @@ extern const char * const riscv_intr_names[];
 void riscv_cpu_do_interrupt(CPUState *cpu);
 int riscv_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
 int riscv_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
-bool riscv_cpu_exec_interrupt_locked(CPUState *cs, int interrupt_request);
+bool riscv_cpu_exec_interrupt(CPUState *cs, int interrupt_request);
 bool riscv_cpu_fp_enabled(CPURISCVState *env);
 bool riscv_cpu_virt_enabled(CPURISCVState *env);
 void riscv_cpu_set_virt_enabled(CPURISCVState *env, bool enable);
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 9feac5966b..6012b02c5b 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -78,7 +78,7 @@ static int riscv_cpu_local_irq_pending(CPURISCVState *env)
 }
 #endif
 
-bool riscv_cpu_exec_interrupt_locked(CPUState *cs, int interrupt_request)
+static bool riscv_cpu_exec_interrupt_locked(CPUState *cs, int interrupt_request)
 {
 #if !defined(CONFIG_USER_ONLY)
     if (interrupt_request & CPU_INTERRUPT_HARD) {
@@ -95,6 +95,15 @@ bool riscv_cpu_exec_interrupt_locked(CPUState *cs, int interrupt_request)
     return false;
 }
 
+bool riscv_cpu_exec_interrupt(CPUState *cs, int int_req)
+{
+    bool status;
+    qemu_mutex_lock_iothread();
+    status = riscv_cpu_exec_interrupt_locked(cs, int_req);
+    qemu_mutex_unlock_iothread();
+    return status;
+}
+
 #if !defined(CONFIG_USER_ONLY)
 
 /* Return true is floating point support is currently enabled */
diff --git a/target/rx/cpu.c b/target/rx/cpu.c
index c0ffc3ab2c..219e05397b 100644
--- a/target/rx/cpu.c
+++ b/target/rx/cpu.c
@@ -186,7 +186,7 @@ static void rx_cpu_class_init(ObjectClass *klass, void *data)
     cc->class_by_name = rx_cpu_class_by_name;
     cc->has_work = rx_cpu_has_work;
     cc->do_interrupt = rx_cpu_do_interrupt;
-    cc->cpu_exec_interrupt = rx_cpu_exec_interrupt_locked;
+    cc->cpu_exec_interrupt = rx_cpu_exec_interrupt;
     cc->dump_state = rx_cpu_dump_state;
     cc->set_pc = rx_cpu_set_pc;
     cc->synchronize_from_tb = rx_cpu_synchronize_from_tb;
diff --git a/target/rx/cpu.h b/target/rx/cpu.h
index e08e5a4b85..ec085d0386 100644
--- a/target/rx/cpu.h
+++ b/target/rx/cpu.h
@@ -127,7 +127,7 @@ typedef RXCPU ArchCPU;
 const char *rx_crname(uint8_t cr);
 void rx_cpu_do_interrupt(CPUState *cpu);
 void rx_cpu_do_interrupt_locked(CPUState *cpu);
-bool rx_cpu_exec_interrupt_locked(CPUState *cpu, int int_req);
+bool rx_cpu_exec_interrupt(CPUState *cpu, int int_req);
 void rx_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
 int rx_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
 int rx_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
diff --git a/target/rx/helper.c b/target/rx/helper.c
index 0d479264bb..ffceac0e3d 100644
--- a/target/rx/helper.c
+++ b/target/rx/helper.c
@@ -126,7 +126,7 @@ void rx_cpu_do_interrupt(CPUState *cs)
     qemu_mutex_unlock_iothread();
 }
 
-bool rx_cpu_exec_interrupt_locked(CPUState *cs, int interrupt_request)
+static bool rx_cpu_exec_interrupt_locked(CPUState *cs, int interrupt_request)
 {
     RXCPU *cpu = RXCPU(cs);
     CPURXState *env = &cpu->env;
@@ -150,6 +150,15 @@ bool rx_cpu_exec_interrupt_locked(CPUState *cs, int interrupt_request)
     return false;
 }
 
+bool rx_cpu_exec_interrupt(CPUState *cs, int int_req)
+{
+    bool status;
+    qemu_mutex_lock_iothread();
+    status = rx_cpu_exec_interrupt_locked(cs, int_req);
+    qemu_mutex_unlock_iothread();
+    return status;
+}
+
 hwaddr rx_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
 {
     return addr;
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 445b654f7f..4d0d323cf9 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -505,7 +505,7 @@ static void s390_cpu_class_init(ObjectClass *oc, void *data)
     cc->get_crash_info = s390_cpu_get_crash_info;
     cc->write_elf64_note = s390_cpu_write_elf64_note;
 #ifdef CONFIG_TCG
-    cc->cpu_exec_interrupt = s390_cpu_exec_interrupt_locked;
+    cc->cpu_exec_interrupt = s390_cpu_exec_interrupt;
     cc->debug_excp_handler = s390x_cpu_debug_excp_handler;
     cc->do_unaligned_access = s390x_cpu_do_unaligned_access;
 #endif
diff --git a/target/s390x/excp_helper.c b/target/s390x/excp_helper.c
index 118d21bd06..bcc2469c72 100644
--- a/target/s390x/excp_helper.c
+++ b/target/s390x/excp_helper.c
@@ -543,7 +543,7 @@ try_deliver:
     }
 }
 
-bool s390_cpu_exec_interrupt_locked(CPUState *cs, int interrupt_request)
+static bool s390_cpu_exec_interrupt_locked(CPUState *cs, int interrupt_request)
 {
     if (interrupt_request & CPU_INTERRUPT_HARD) {
         S390CPU *cpu = S390_CPU(cs);
@@ -567,6 +567,15 @@ bool s390_cpu_exec_interrupt_locked(CPUState *cs, int interrupt_request)
     return false;
 }
 
+bool s390_cpu_exec_interrupt(CPUState *cs, int int_req)
+{
+    bool status;
+    qemu_mutex_lock_iothread();
+    status = s390_cpu_exec_interrupt_locked(cs, int_req);
+    qemu_mutex_unlock_iothread();
+    return status;
+}
+
 void s390x_cpu_debug_excp_handler(CPUState *cs)
 {
     S390CPU *cpu = S390_CPU(cs);
diff --git a/target/s390x/internal.h b/target/s390x/internal.h
index cc71b3e194..b4660ad255 100644
--- a/target/s390x/internal.h
+++ b/target/s390x/internal.h
@@ -270,7 +270,7 @@ ObjectClass *s390_cpu_class_by_name(const char *name);
 void s390x_cpu_debug_excp_handler(CPUState *cs);
 void s390_cpu_do_interrupt(CPUState *cpu);
 void s390_cpu_do_interrupt_locked(CPUState *cpu);
-bool s390_cpu_exec_interrupt_locked(CPUState *cpu, int int_req);
+bool s390_cpu_exec_interrupt(CPUState *cpu, int int_req);
 bool s390_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                        MMUAccessType access_type, int mmu_idx,
                        bool probe, uintptr_t retaddr);
diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
index f64ef0e84a..18f3448183 100644
--- a/target/sh4/cpu.c
+++ b/target/sh4/cpu.c
@@ -219,7 +219,7 @@ static void superh_cpu_class_init(ObjectClass *oc, void *data)
     cc->class_by_name = superh_cpu_class_by_name;
     cc->has_work = superh_cpu_has_work;
     cc->do_interrupt = superh_cpu_do_interrupt;
-    cc->cpu_exec_interrupt = superh_cpu_exec_interrupt_locked;
+    cc->cpu_exec_interrupt = superh_cpu_exec_interrupt;
     cc->dump_state = superh_cpu_dump_state;
     cc->set_pc = superh_cpu_set_pc;
     cc->synchronize_from_tb = superh_cpu_synchronize_from_tb;
diff --git a/target/sh4/cpu.h b/target/sh4/cpu.h
index c1d3400575..dbe58c7888 100644
--- a/target/sh4/cpu.h
+++ b/target/sh4/cpu.h
@@ -205,7 +205,7 @@ struct SuperHCPU {
 
 
 void superh_cpu_do_interrupt(CPUState *cpu);
-bool superh_cpu_exec_interrupt_locked(CPUState *cpu, int int_req);
+bool superh_cpu_exec_interrupt(CPUState *cpu, int int_req);
 void superh_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
 hwaddr superh_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
 int superh_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
diff --git a/target/sh4/helper.c b/target/sh4/helper.c
index 176f9edb63..7a5de5f0d6 100644
--- a/target/sh4/helper.c
+++ b/target/sh4/helper.c
@@ -789,7 +789,8 @@ void superh_cpu_do_interrupt(CPUState *cs)
     qemu_mutex_unlock_iothread();
 }
 
-bool superh_cpu_exec_interrupt_locked(CPUState *cs, int interrupt_request)
+static bool superh_cpu_exec_interrupt_locked(CPUState *cs,
+                                             int interrupt_request)
 {
     if (interrupt_request & CPU_INTERRUPT_HARD) {
         SuperHCPU *cpu = SUPERH_CPU(cs);
@@ -806,6 +807,15 @@ bool superh_cpu_exec_interrupt_locked(CPUState *cs, int interrupt_request)
     return false;
 }
 
+bool superh_cpu_exec_interrupt(CPUState *cs, int int_req)
+{
+    bool status;
+    qemu_mutex_lock_iothread();
+    status = superh_cpu_exec_interrupt_locked(cs, int_req);
+    qemu_mutex_unlock_iothread();
+    return status;
+}
+
 bool superh_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                          MMUAccessType access_type, int mmu_idx,
                          bool probe, uintptr_t retaddr)
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index e2b9de6672..1d2c7aa584 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -97,6 +97,15 @@ static bool sparc_cpu_exec_interrupt_locked(CPUState *cs, int interrupt_request)
     return false;
 }
 
+static bool sparc_cpu_exec_interrupt(CPUState *cs, int int_req)
+{
+    bool status;
+    qemu_mutex_lock_iothread();
+    status = sparc_cpu_exec_interrupt_locked(cs, int_req);
+    qemu_mutex_unlock_iothread();
+    return status;
+}
+
 static void cpu_sparc_disas_set_info(CPUState *cpu, disassemble_info *info)
 {
     info->print_insn = print_insn_sparc;
@@ -864,7 +873,7 @@ static void sparc_cpu_class_init(ObjectClass *oc, void *data)
     cc->parse_features = sparc_cpu_parse_features;
     cc->has_work_with_iothread_lock = sparc_cpu_has_work;
     cc->do_interrupt = sparc_cpu_do_interrupt;
-    cc->cpu_exec_interrupt = sparc_cpu_exec_interrupt_locked;
+    cc->cpu_exec_interrupt = sparc_cpu_exec_interrupt;
     cc->dump_state = sparc_cpu_dump_state;
 #if !defined(TARGET_SPARC64) && !defined(CONFIG_USER_ONLY)
     cc->memory_rw_debug = sparc_cpu_memory_rw_debug;
diff --git a/target/tilegx/cpu.c b/target/tilegx/cpu.c
index 082607e111..e9af4148e5 100644
--- a/target/tilegx/cpu.c
+++ b/target/tilegx/cpu.c
@@ -142,6 +142,15 @@ static bool tilegx_cpu_exec_interrupt_locked(CPUState *cs,
     return false;
 }
 
+static bool tilegx_cpu_exec_interrupt(CPUState *cs, int int_req)
+{
+    bool status;
+    qemu_mutex_lock_iothread();
+    status = tilegx_cpu_exec_interrupt_locked(cs, int_req);
+    qemu_mutex_unlock_iothread();
+    return status;
+}
+
 static void tilegx_cpu_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
@@ -156,7 +165,7 @@ static void tilegx_cpu_class_init(ObjectClass *oc, void *data)
     cc->class_by_name = tilegx_cpu_class_by_name;
     cc->has_work = tilegx_cpu_has_work;
     cc->do_interrupt = tilegx_cpu_do_interrupt;
-    cc->cpu_exec_interrupt = tilegx_cpu_exec_interrupt_locked;
+    cc->cpu_exec_interrupt = tilegx_cpu_exec_interrupt;
     cc->dump_state = tilegx_cpu_dump_state;
     cc->set_pc = tilegx_cpu_set_pc;
     cc->tlb_fill = tilegx_cpu_tlb_fill;
diff --git a/target/unicore32/cpu.c b/target/unicore32/cpu.c
index 4e952e6801..06bf4b4b63 100644
--- a/target/unicore32/cpu.c
+++ b/target/unicore32/cpu.c
@@ -132,7 +132,7 @@ static void uc32_cpu_class_init(ObjectClass *oc, void *data)
     cc->class_by_name = uc32_cpu_class_by_name;
     cc->has_work = uc32_cpu_has_work;
     cc->do_interrupt = uc32_cpu_do_interrupt;
-    cc->cpu_exec_interrupt = uc32_cpu_exec_interrupt_locked;
+    cc->cpu_exec_interrupt = uc32_cpu_exec_interrupt;
     cc->dump_state = uc32_cpu_dump_state;
     cc->set_pc = uc32_cpu_set_pc;
     cc->tlb_fill = uc32_cpu_tlb_fill;
diff --git a/target/unicore32/cpu.h b/target/unicore32/cpu.h
index 1e5c557696..9453b5d7b3 100644
--- a/target/unicore32/cpu.h
+++ b/target/unicore32/cpu.h
@@ -77,7 +77,7 @@ struct UniCore32CPU {
 
 void uc32_cpu_do_interrupt(CPUState *cpu);
 void uc32_cpu_do_interrupt_locked(CPUState *cpu);
-bool uc32_cpu_exec_interrupt_locked(CPUState *cpu, int int_req);
+bool uc32_cpu_exec_interrupt(CPUState *cpu, int int_req);
 void uc32_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
 hwaddr uc32_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
 
diff --git a/target/unicore32/helper.c b/target/unicore32/helper.c
index f09803eb1d..75d7f6b4af 100644
--- a/target/unicore32/helper.c
+++ b/target/unicore32/helper.c
@@ -167,7 +167,7 @@ void helper_cp1_putc(target_ulong regval)
 }
 #endif /* !CONFIG_USER_ONLY */
 
-bool uc32_cpu_exec_interrupt_locked(CPUState *cs, int interrupt_request)
+static bool uc32_cpu_exec_interrupt_locked(CPUState *cs, int interrupt_request)
 {
     if (interrupt_request & CPU_INTERRUPT_HARD) {
         UniCore32CPU *cpu = UNICORE32_CPU(cs);
@@ -181,3 +181,12 @@ bool uc32_cpu_exec_interrupt_locked(CPUState *cs, int interrupt_request)
     }
     return false;
 }
+
+bool uc32_cpu_exec_interrupt(CPUState *cs, int int_req)
+{
+    bool status;
+    qemu_mutex_lock_iothread();
+    status = uc32_cpu_exec_interrupt_locked(cs, int_req);
+    qemu_mutex_unlock_iothread();
+    return status;
+}
diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index 3ab1d74044..0f96483563 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -191,7 +191,7 @@ static void xtensa_cpu_class_init(ObjectClass *oc, void *data)
     cc->class_by_name = xtensa_cpu_class_by_name;
     cc->has_work_with_iothread_lock = xtensa_cpu_has_work;
     cc->do_interrupt = xtensa_cpu_do_interrupt;
-    cc->cpu_exec_interrupt = xtensa_cpu_exec_interrupt_locked;
+    cc->cpu_exec_interrupt = xtensa_cpu_exec_interrupt;
     cc->dump_state = xtensa_cpu_dump_state;
     cc->set_pc = xtensa_cpu_set_pc;
     cc->gdb_read_register = xtensa_cpu_gdb_read_register;
diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index be12e5ef63..32749378bf 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -564,7 +564,7 @@ bool xtensa_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                          MMUAccessType access_type, int mmu_idx,
                          bool probe, uintptr_t retaddr);
 void xtensa_cpu_do_interrupt(CPUState *cpu);
-bool xtensa_cpu_exec_interrupt_locked(CPUState *cpu, int interrupt_request);
+bool xtensa_cpu_exec_interrupt(CPUState *cpu, int interrupt_request);
 void xtensa_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr, vaddr addr,
                                       unsigned size, MMUAccessType access_type,
                                       int mmu_idx, MemTxAttrs attrs,
diff --git a/target/xtensa/exc_helper.c b/target/xtensa/exc_helper.c
index 14362ee86e..eb2d03048f 100644
--- a/target/xtensa/exc_helper.c
+++ b/target/xtensa/exc_helper.c
@@ -266,7 +266,8 @@ void xtensa_cpu_do_interrupt(CPUState *cs)
     qemu_mutex_unlock_iothread();
 }
 
-bool xtensa_cpu_exec_interrupt_locked(CPUState *cs, int interrupt_request)
+static bool xtensa_cpu_exec_interrupt_locked(CPUState *cs,
+                                             int interrupt_request)
 {
     if (interrupt_request & CPU_INTERRUPT_HARD) {
         cs->exception_index = EXC_IRQ;
@@ -275,3 +276,12 @@ bool xtensa_cpu_exec_interrupt_locked(CPUState *cs, int interrupt_request)
     }
     return false;
 }
+
+bool xtensa_cpu_exec_interrupt(CPUState *cs, int int_req)
+{
+    bool status;
+    qemu_mutex_lock_iothread();
+    status = xtensa_cpu_exec_interrupt_locked(cs, int_req);
+    qemu_mutex_unlock_iothread();
+    return status;
+}
-- 
2.17.1


