Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1A8BC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 18:35:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 398DE20658
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 18:35:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gx6iCGxp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 398DE20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8Svv-00030M-59
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 14:35:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60320)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1k8SrA-0003M4-Rk
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 14:30:40 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:52837)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1k8Sr2-0001yz-0H
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 14:30:40 -0400
Received: by mail-pj1-x1043.google.com with SMTP id kr4so1497708pjb.2
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2020 11:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=/lh6DcqLk8tYuQOAaHAbdH6hrmCHOijr801Ci4Vz+6Q=;
 b=gx6iCGxpmjzmbVuTgWqDwfkkDMgT93wYkkeV+eX9asPIcMeSSMADFsi78jRKwpQ1Ms
 QbYGIXNUklkXBri79+mNTsHWo4rJSIly61HLEiyfJrhBQfhpm+ULbu77ojqUO2C/q1DW
 HoWiHBchRk3Jsxu8reCPHJcg77YNv5dX3XPkxTigNmxyN+RixwAQAdawx8AJbvrCybxN
 JtLUxhl3yk/9C+caVXavFTmGjZcanwfub3vE6w3Chb9euzMXNGDlHEtOHlUYlJ/O062F
 JXAcf+FgYKoiIRX1vvzOpTIY6zST47MItHYnRtuxS1JRXWsjsG+SEl1KMcFYux92wh3e
 d7Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=/lh6DcqLk8tYuQOAaHAbdH6hrmCHOijr801Ci4Vz+6Q=;
 b=SMX1WHD9XyLFN82ZkRl4IcE0QqGNyl85mqMjH3NHiy/Dc+Za88i1ptlKFv8n1PkH1p
 nxPmQoLok8XpUN2gwEVfn6K1xHfBRGQwTGTRpApErJhM70ZI1gd9TNmZScq8rBHF15yv
 WFK/RjR3EayZ4+sbk1onFOGyEbVVAPnFueiWCiu7TxdPKP5mXuK1niQLuGNuaVNdlozc
 W+SD2+pcdz7Cq6t1ldGmZW8/s+MqQTsTum0Qv4G3z30GiJa389VAV8L1CruL1vOTaCNT
 67uj4AU+lfq9mH9VCj82HWw+fzZXhJ5Ph/dVMV/MFEMSgI2zUv/MqlFUV6QWoH2Sh4iv
 FQ7g==
X-Gm-Message-State: AOAM532WZaneKdoLqlesOmBp3CeWD6n2aInKXmjEevSf6dacZ4KVpmKf
 G7X3+I2vllCLLtazTgcVMKJ5qkQzc4uMQo/P
X-Google-Smtp-Source: ABdhPJw0AokGI/CH+UsparjD5g1PjVPpg2Q3MGgqM4AgUpQGwgihUNrjWCewEKxKTChfYt/BH7+lYw==
X-Received: by 2002:a17:90a:fe91:: with SMTP id
 co17mr5092937pjb.103.1597861828773; 
 Wed, 19 Aug 2020 11:30:28 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 (c-73-47-162-176.hsd1.ma.comcast.net. [73.47.162.176])
 by smtp.gmail.com with ESMTPSA id p20sm220766pjg.44.2020.08.19.11.30.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2020 11:30:27 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 4/7] target: Push BQL on ->do_interrupt down into per-arch
 implementation
Date: Wed, 19 Aug 2020 14:28:53 -0400
Message-Id: <20200819182856.4893-5-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200819182856.4893-1-robert.foley@linaro.org>
References: <20200819182856.4893-1-robert.foley@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1043;
 envelope-from=robert.foley@linaro.org; helo=mail-pj1-x1043.google.com
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

As part of pushing the BQL down into the per-arch implementation,
the first change is to remove the holding of BQL from
cpu_handle_exception.  Next, we made changes per-arch to
re-add a new *_do_interrupt function, which gets the BQL and then
calls to *_do_interrupt_locked.  We also pointed the per-arch
->do_interrupt at the new *_do_interrupt.

This patch is part of a series of transitions to move the
BQL down into the do_interrupt per arch functions.  This set of
transitions is needed to maintain bisectability.

It is worth mentioning that arm and cris are slightly different.
In a prior patch for these arches, we added a new CPUClass method
 ->do_interrupt_locked.  The only difference for arm and cris
is that their new *_do_interrupt functions will be able to
utilize this new ->do_interrupt_locked method.

avr is another exception.  avr, arm and cris all had a similar
case where their *_cpu_exec_interrupt was calling to
the CPUClass ->do_interrupt.  This causes an issue when we push
the lock down since ->do_interrupt will try to acquire the BQL, but
the calling context already has it.  To solve this for arm and
cris, we added a new CPUCLass method as explained above.  Moreover,
it was actually required for these arches since they have more than
one possible value of ->do_interrupt.  In the case of avr,
there is only one possible value of ->do_interrupt, so for that reason
we changed the avr_cpu_exec_interrupt to call directly to
avr_cpu_do_interrupt_locked rather than call cc->do_interrupt.

The purpose of this set of changes is to set the groundwork
so that an arch could move towards removing
the BQL from the cpu_handle_interrupt/exception paths.

This approach was suggested by Paolo Bonzini.
For reference, here are key posts in the discussion, explaining
the reasoning/benefits of this approach.

https://lists.gnu.org/archive/html/qemu-devel/2020-08/msg01517.html
https://lists.gnu.org/archive/html/qemu-devel/2020-08/msg00784.html
https://lists.gnu.org/archive/html/qemu-devel/2020-07/msg08731.html
https://lists.gnu.org/archive/html/qemu-devel/2020-08/msg00044.html

Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 accel/tcg/cpu-exec.c            |  2 --
 target/alpha/cpu.c              |  2 +-
 target/alpha/cpu.h              |  2 +-
 target/alpha/helper.c           |  9 ++++++++-
 target/arm/cpu.c                |  2 +-
 target/arm/cpu.h                |  2 ++
 target/arm/cpu_tcg.c            |  2 +-
 target/arm/helper.c             |  8 ++++++++
 target/avr/cpu.c                |  2 +-
 target/avr/cpu.h                |  2 +-
 target/avr/helper.c             | 16 ++++++++++++----
 target/cris/cpu.c               |  7 +------
 target/cris/cpu.h               |  1 +
 target/cris/helper.c            |  8 ++++++++
 target/hppa/cpu.c               |  2 +-
 target/hppa/cpu.h               |  2 +-
 target/hppa/int_helper.c        |  9 ++++++++-
 target/i386/cpu.c               |  2 +-
 target/i386/cpu.h               |  2 +-
 target/i386/seg_helper.c        |  9 ++++++++-
 target/lm32/cpu.c               |  2 +-
 target/lm32/cpu.h               |  2 +-
 target/lm32/helper.c            |  9 ++++++++-
 target/m68k/cpu.c               |  2 +-
 target/m68k/cpu.h               |  2 +-
 target/m68k/op_helper.c         | 11 +++++++++--
 target/microblaze/cpu.c         |  2 +-
 target/microblaze/cpu.h         |  2 +-
 target/microblaze/helper.c      | 11 +++++++++--
 target/mips/cpu.c               |  2 +-
 target/mips/helper.c            |  9 ++++++++-
 target/mips/internal.h          |  2 +-
 target/nios2/cpu.c              |  2 +-
 target/nios2/cpu.h              |  1 +
 target/nios2/helper.c           |  9 +++++++++
 target/openrisc/cpu.c           |  2 +-
 target/openrisc/cpu.h           |  2 +-
 target/openrisc/interrupt.c     |  9 ++++++++-
 target/ppc/cpu.h                |  1 +
 target/ppc/excp_helper.c        |  7 +++++++
 target/ppc/translate_init.inc.c |  2 +-
 target/riscv/cpu.c              |  2 +-
 target/riscv/cpu.h              |  2 +-
 target/riscv/cpu_helper.c       | 11 ++++++++++-
 target/rx/cpu.c                 |  2 +-
 target/rx/cpu.h                 |  1 +
 target/rx/helper.c              |  7 +++++++
 target/s390x/cpu.c              |  2 +-
 target/s390x/excp_helper.c      |  7 +++++++
 target/s390x/internal.h         |  1 +
 target/sh4/cpu.c                |  2 +-
 target/sh4/cpu.h                |  2 +-
 target/sh4/helper.c             | 11 +++++++++--
 target/sparc/cpu.c              |  2 +-
 target/sparc/cpu.h              |  1 +
 target/sparc/int32_helper.c     |  7 +++++++
 target/sparc/int64_helper.c     |  7 +++++++
 target/tilegx/cpu.c             |  9 ++++++++-
 target/unicore32/cpu.c          |  2 +-
 target/unicore32/cpu.h          |  1 +
 target/unicore32/softmmu.c      |  7 +++++++
 target/xtensa/cpu.c             |  2 +-
 target/xtensa/cpu.h             |  2 +-
 target/xtensa/exc_helper.c      | 11 +++++++++--
 64 files changed, 223 insertions(+), 60 deletions(-)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 80d0e649b2..e661635f06 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -517,9 +517,7 @@ static inline bool cpu_handle_exception(CPUState *cpu, int *ret)
 #else
         if (replay_exception()) {
             CPUClass *cc = CPU_GET_CLASS(cpu);
-            qemu_mutex_lock_iothread();
             cc->do_interrupt(cpu);
-            qemu_mutex_unlock_iothread();
             cpu->exception_index = -1;
 
             if (unlikely(cpu->singlestep_enabled)) {
diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
index cb1074e0f9..09677c6c44 100644
--- a/target/alpha/cpu.c
+++ b/target/alpha/cpu.c
@@ -217,7 +217,7 @@ static void alpha_cpu_class_init(ObjectClass *oc, void *data)
 
     cc->class_by_name = alpha_cpu_class_by_name;
     cc->has_work = alpha_cpu_has_work;
-    cc->do_interrupt = alpha_cpu_do_interrupt_locked;
+    cc->do_interrupt = alpha_cpu_do_interrupt;
     cc->cpu_exec_interrupt = alpha_cpu_exec_interrupt;
     cc->dump_state = alpha_cpu_dump_state;
     cc->set_pc = alpha_cpu_set_pc;
diff --git a/target/alpha/cpu.h b/target/alpha/cpu.h
index 4c6753df34..be29bdd530 100644
--- a/target/alpha/cpu.h
+++ b/target/alpha/cpu.h
@@ -276,7 +276,7 @@ struct AlphaCPU {
 extern const VMStateDescription vmstate_alpha_cpu;
 #endif
 
-void alpha_cpu_do_interrupt_locked(CPUState *cpu);
+void alpha_cpu_do_interrupt(CPUState *cpu);
 bool alpha_cpu_exec_interrupt(CPUState *cpu, int int_req);
 void alpha_cpu_dump_state(CPUState *cs, FILE *f, int flags);
 hwaddr alpha_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
diff --git a/target/alpha/helper.c b/target/alpha/helper.c
index ff9a2a7765..e497dd269e 100644
--- a/target/alpha/helper.c
+++ b/target/alpha/helper.c
@@ -295,7 +295,7 @@ bool alpha_cpu_tlb_fill(CPUState *cs, vaddr addr, int size,
 }
 #endif /* USER_ONLY */
 
-void alpha_cpu_do_interrupt_locked(CPUState *cs)
+static void alpha_cpu_do_interrupt_locked(CPUState *cs)
 {
     AlphaCPU *cpu = ALPHA_CPU(cs);
     CPUAlphaState *env = &cpu->env;
@@ -407,6 +407,13 @@ void alpha_cpu_do_interrupt_locked(CPUState *cs)
 #endif /* !USER_ONLY */
 }
 
+void alpha_cpu_do_interrupt(CPUState *cs)
+{
+    qemu_mutex_lock_iothread();
+    alpha_cpu_do_interrupt_locked(cs);
+    qemu_mutex_unlock_iothread();
+}
+
 bool alpha_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 {
     AlphaCPU *cpu = ALPHA_CPU(cs);
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index d15b459399..12eda7611f 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2224,7 +2224,7 @@ static void arm_cpu_class_init(ObjectClass *oc, void *data)
     cc->gdb_read_register = arm_cpu_gdb_read_register;
     cc->gdb_write_register = arm_cpu_gdb_write_register;
 #ifndef CONFIG_USER_ONLY
-    cc->do_interrupt = arm_cpu_do_interrupt_locked;
+    cc->do_interrupt = arm_cpu_do_interrupt;
     acc->do_interrupt_locked = arm_cpu_do_interrupt_locked;
     cc->get_phys_page_attrs_debug = arm_cpu_get_phys_page_attrs_debug;
     cc->asidx_from_attrs = arm_asidx_from_attrs;
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 1f522964b5..57b8904dec 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -991,7 +991,9 @@ uint64_t arm_cpu_mp_affinity(int idx, uint8_t clustersz);
 extern const VMStateDescription vmstate_arm_cpu;
 #endif
 
+void arm_cpu_do_interrupt(CPUState *cpu);
 void arm_cpu_do_interrupt_locked(CPUState *cpu);
+void arm_v7m_cpu_do_interrupt(CPUState *cpu);
 void arm_v7m_cpu_do_interrupt_locked(CPUState *cpu);
 bool arm_cpu_exec_interrupt(CPUState *cpu, int int_req);
 
diff --git a/target/arm/cpu_tcg.c b/target/arm/cpu_tcg.c
index caf0d54c2c..df36cfda76 100644
--- a/target/arm/cpu_tcg.c
+++ b/target/arm/cpu_tcg.c
@@ -601,7 +601,7 @@ static void arm_v7m_class_init(ObjectClass *oc, void *data)
 
     acc->info = data;
 #ifndef CONFIG_USER_ONLY
-    cc->do_interrupt = arm_v7m_cpu_do_interrupt_locked;
+    cc->do_interrupt = arm_cpu_do_interrupt;
     acc->do_interrupt_locked = arm_v7m_cpu_do_interrupt_locked;
 #endif
 
diff --git a/target/arm/helper.c b/target/arm/helper.c
index e07924daf5..f0ab750088 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -9840,6 +9840,14 @@ static void handle_semihosting(CPUState *cs)
 }
 #endif
 
+void arm_cpu_do_interrupt(CPUState *cs)
+{
+    ARMCPUClass *acc = ARM_CPU_GET_CLASS(cs);
+    qemu_mutex_lock_iothread();
+    acc->do_interrupt_locked(cs);
+    qemu_mutex_unlock_iothread();
+}
+
 /* Handle a CPU exception for A and R profile CPUs.
  * Do any appropriate logging, handle PSCI calls, and then hand off
  * to the AArch64-entry or AArch32-entry function depending on the
diff --git a/target/avr/cpu.c b/target/avr/cpu.c
index d856069230..5d9c4ad5bf 100644
--- a/target/avr/cpu.c
+++ b/target/avr/cpu.c
@@ -197,7 +197,7 @@ static void avr_cpu_class_init(ObjectClass *oc, void *data)
     cc->class_by_name = avr_cpu_class_by_name;
 
     cc->has_work = avr_cpu_has_work;
-    cc->do_interrupt = avr_cpu_do_interrupt_locked;
+    cc->do_interrupt = avr_cpu_do_interrupt;
     cc->cpu_exec_interrupt = avr_cpu_exec_interrupt;
     cc->dump_state = avr_cpu_dump_state;
     cc->set_pc = avr_cpu_set_pc;
diff --git a/target/avr/cpu.h b/target/avr/cpu.h
index 66a26f08ef..d148e8c75a 100644
--- a/target/avr/cpu.h
+++ b/target/avr/cpu.h
@@ -156,7 +156,7 @@ typedef struct AVRCPU {
 
 extern const struct VMStateDescription vms_avr_cpu;
 
-void avr_cpu_do_interrupt_locked(CPUState *cpu);
+void avr_cpu_do_interrupt(CPUState *cpu);
 bool avr_cpu_exec_interrupt(CPUState *cpu, int int_req);
 hwaddr avr_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
 int avr_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
diff --git a/target/avr/helper.c b/target/avr/helper.c
index 096bc35945..2c8c3af580 100644
--- a/target/avr/helper.c
+++ b/target/avr/helper.c
@@ -24,17 +24,18 @@
 #include "exec/address-spaces.h"
 #include "exec/helper-proto.h"
 
+static void avr_cpu_do_interrupt_locked(CPUState *cs);
+
 bool avr_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 {
     bool ret = false;
-    CPUClass *cc = CPU_GET_CLASS(cs);
     AVRCPU *cpu = AVR_CPU(cs);
     CPUAVRState *env = &cpu->env;
 
     if (interrupt_request & CPU_INTERRUPT_RESET) {
         if (cpu_interrupts_enabled(env)) {
             cs->exception_index = EXCP_RESET;
-            cc->do_interrupt(cs);
+            avr_cpu_do_interrupt_locked(cs);
 
             cs->interrupt_request &= ~CPU_INTERRUPT_RESET;
 
@@ -45,7 +46,7 @@ bool avr_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
         if (cpu_interrupts_enabled(env) && env->intsrc != 0) {
             int index = ctz32(env->intsrc);
             cs->exception_index = EXCP_INT(index);
-            cc->do_interrupt(cs);
+            avr_cpu_do_interrupt_locked(cs);
 
             env->intsrc &= env->intsrc - 1; /* clear the interrupt */
             cs->interrupt_request &= ~CPU_INTERRUPT_HARD;
@@ -56,7 +57,7 @@ bool avr_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
     return ret;
 }
 
-void avr_cpu_do_interrupt_locked(CPUState *cs)
+static void avr_cpu_do_interrupt_locked(CPUState *cs)
 {
     AVRCPU *cpu = AVR_CPU(cs);
     CPUAVRState *env = &cpu->env;
@@ -89,6 +90,13 @@ void avr_cpu_do_interrupt_locked(CPUState *cs)
     cs->exception_index = -1;
 }
 
+void avr_cpu_do_interrupt(CPUState *cs)
+{
+    qemu_mutex_lock_iothread();
+    avr_cpu_do_interrupt_locked(cs);
+    qemu_mutex_unlock_iothread();
+}
+
 int avr_cpu_memory_rw_debug(CPUState *cs, vaddr addr, uint8_t *buf,
                             int len, bool is_write)
 {
diff --git a/target/cris/cpu.c b/target/cris/cpu.c
index 948eeb6260..c3d77c31e8 100644
--- a/target/cris/cpu.c
+++ b/target/cris/cpu.c
@@ -199,7 +199,6 @@ static void crisv8_cpu_class_init(ObjectClass *oc, void *data)
     CRISCPUClass *ccc = CRIS_CPU_CLASS(oc);
 
     ccc->vr = 8;
-    cc->do_interrupt = crisv10_cpu_do_interrupt_locked;
     ccc->do_interrupt_locked = crisv10_cpu_do_interrupt_locked;
     cc->gdb_read_register = crisv10_cpu_gdb_read_register;
     cc->tcg_initialize = cris_initialize_crisv10_tcg;
@@ -211,7 +210,6 @@ static void crisv9_cpu_class_init(ObjectClass *oc, void *data)
     CRISCPUClass *ccc = CRIS_CPU_CLASS(oc);
 
     ccc->vr = 9;
-    cc->do_interrupt = crisv10_cpu_do_interrupt_locked;
     ccc->do_interrupt_locked = crisv10_cpu_do_interrupt_locked;
     cc->gdb_read_register = crisv10_cpu_gdb_read_register;
     cc->tcg_initialize = cris_initialize_crisv10_tcg;
@@ -223,7 +221,6 @@ static void crisv10_cpu_class_init(ObjectClass *oc, void *data)
     CRISCPUClass *ccc = CRIS_CPU_CLASS(oc);
 
     ccc->vr = 10;
-    cc->do_interrupt = crisv10_cpu_do_interrupt_locked;
     ccc->do_interrupt_locked = crisv10_cpu_do_interrupt_locked;
     cc->gdb_read_register = crisv10_cpu_gdb_read_register;
     cc->tcg_initialize = cris_initialize_crisv10_tcg;
@@ -235,7 +232,6 @@ static void crisv11_cpu_class_init(ObjectClass *oc, void *data)
     CRISCPUClass *ccc = CRIS_CPU_CLASS(oc);
 
     ccc->vr = 11;
-    cc->do_interrupt = crisv10_cpu_do_interrupt_locked;
     ccc->do_interrupt_locked = crisv10_cpu_do_interrupt_locked;
     cc->gdb_read_register = crisv10_cpu_gdb_read_register;
     cc->tcg_initialize = cris_initialize_crisv10_tcg;
@@ -247,7 +243,6 @@ static void crisv17_cpu_class_init(ObjectClass *oc, void *data)
     CRISCPUClass *ccc = CRIS_CPU_CLASS(oc);
 
     ccc->vr = 17;
-    cc->do_interrupt = crisv10_cpu_do_interrupt_locked;
     ccc->do_interrupt_locked = crisv10_cpu_do_interrupt_locked;
     cc->gdb_read_register = crisv10_cpu_gdb_read_register;
     cc->tcg_initialize = cris_initialize_crisv10_tcg;
@@ -273,7 +268,7 @@ static void cris_cpu_class_init(ObjectClass *oc, void *data)
 
     cc->class_by_name = cris_cpu_class_by_name;
     cc->has_work = cris_cpu_has_work;
-    cc->do_interrupt = cris_cpu_do_interrupt_locked;
+    cc->do_interrupt = cris_cpu_do_interrupt;
     ccc->do_interrupt_locked = cris_cpu_do_interrupt_locked;
     cc->cpu_exec_interrupt = cris_cpu_exec_interrupt;
     cc->dump_state = cris_cpu_dump_state;
diff --git a/target/cris/cpu.h b/target/cris/cpu.h
index 597ccd6451..d8ee6b9400 100644
--- a/target/cris/cpu.h
+++ b/target/cris/cpu.h
@@ -187,6 +187,7 @@ struct CRISCPU {
 extern const VMStateDescription vmstate_cris_cpu;
 #endif
 
+void cris_cpu_do_interrupt(CPUState *cpu);
 void cris_cpu_do_interrupt_locked(CPUState *cpu);
 void crisv10_cpu_do_interrupt_locked(CPUState *cpu);
 bool cris_cpu_exec_interrupt(CPUState *cpu, int int_req);
diff --git a/target/cris/helper.c b/target/cris/helper.c
index 3b7ee74813..0e053782ab 100644
--- a/target/cris/helper.c
+++ b/target/cris/helper.c
@@ -38,6 +38,14 @@
 #define D_LOG(...) do { } while (0)
 #endif
 
+void cris_cpu_do_interrupt(CPUState *cs)
+{
+    CRISCPUClass *acc = CRIS_CPU_GET_CLASS(cs);
+    qemu_mutex_lock_iothread();
+    acc->do_interrupt_locked(cs);
+    qemu_mutex_unlock_iothread();
+}
+
 #if defined(CONFIG_USER_ONLY)
 
 void cris_cpu_do_interrupt_locked(CPUState *cs)
diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index 7241ffbd7f..287055f96e 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -139,7 +139,7 @@ static void hppa_cpu_class_init(ObjectClass *oc, void *data)
 
     cc->class_by_name = hppa_cpu_class_by_name;
     cc->has_work = hppa_cpu_has_work;
-    cc->do_interrupt = hppa_cpu_do_interrupt_locked;
+    cc->do_interrupt = hppa_cpu_do_interrupt;
     cc->cpu_exec_interrupt = hppa_cpu_exec_interrupt;
     cc->dump_state = hppa_cpu_dump_state;
     cc->set_pc = hppa_cpu_set_pc;
diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index 7fc7682ca8..801a4fb1ba 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -323,7 +323,7 @@ int cpu_hppa_signal_handler(int host_signum, void *pinfo, void *puc);
 hwaddr hppa_cpu_get_phys_page_debug(CPUState *cs, vaddr addr);
 int hppa_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
 int hppa_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
-void hppa_cpu_do_interrupt_locked(CPUState *cpu);
+void hppa_cpu_do_interrupt(CPUState *cpu);
 bool hppa_cpu_exec_interrupt(CPUState *cpu, int int_req);
 void hppa_cpu_dump_state(CPUState *cs, FILE *f, int);
 bool hppa_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
diff --git a/target/hppa/int_helper.c b/target/hppa/int_helper.c
index 31fce959d6..03cb521a96 100644
--- a/target/hppa/int_helper.c
+++ b/target/hppa/int_helper.c
@@ -90,7 +90,7 @@ void HELPER(write_eiem)(CPUHPPAState *env, target_ureg val)
 }
 #endif /* !CONFIG_USER_ONLY */
 
-void hppa_cpu_do_interrupt_locked(CPUState *cs)
+static void hppa_cpu_do_interrupt_locked(CPUState *cs)
 {
     HPPACPU *cpu = HPPA_CPU(cs);
     CPUHPPAState *env = &cpu->env;
@@ -246,6 +246,13 @@ void hppa_cpu_do_interrupt_locked(CPUState *cs)
     cs->exception_index = -1;
 }
 
+void hppa_cpu_do_interrupt(CPUState *cs)
+{
+    qemu_mutex_lock_iothread();
+    hppa_cpu_do_interrupt_locked(cs);
+    qemu_mutex_unlock_iothread();
+}
+
 bool hppa_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 {
 #ifndef CONFIG_USER_ONLY
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index fdb8ae11b6..592aa0baf7 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -7297,7 +7297,7 @@ static void x86_cpu_common_class_init(ObjectClass *oc, void *data)
     cc->parse_features = x86_cpu_parse_featurestr;
     cc->has_work = x86_cpu_has_work;
 #ifdef CONFIG_TCG
-    cc->do_interrupt = x86_cpu_do_interrupt_locked;
+    cc->do_interrupt = x86_cpu_do_interrupt;
     cc->cpu_exec_interrupt = x86_cpu_exec_interrupt;
 #endif
     cc->dump_state = x86_cpu_dump_state;
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 8d4dac129b..d784eeaf29 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1770,7 +1770,7 @@ extern VMStateDescription vmstate_x86_cpu;
  * x86_cpu_do_interrupt:
  * @cpu: vCPU the interrupt is to be handled by.
  */
-void x86_cpu_do_interrupt_locked(CPUState *cpu);
+void x86_cpu_do_interrupt(CPUState *cpu);
 bool x86_cpu_exec_interrupt(CPUState *cpu, int int_req);
 int x86_cpu_pending_interrupt(CPUState *cs, int interrupt_request);
 
diff --git a/target/i386/seg_helper.c b/target/i386/seg_helper.c
index 0d8464abec..74484eb175 100644
--- a/target/i386/seg_helper.c
+++ b/target/i386/seg_helper.c
@@ -1280,7 +1280,7 @@ static void do_interrupt_all(X86CPU *cpu, int intno, int is_int,
 #endif
 }
 
-void x86_cpu_do_interrupt_locked(CPUState *cs)
+static void x86_cpu_do_interrupt_locked(CPUState *cs)
 {
     X86CPU *cpu = X86_CPU(cs);
     CPUX86State *env = &cpu->env;
@@ -1310,6 +1310,13 @@ void x86_cpu_do_interrupt_locked(CPUState *cs)
 #endif
 }
 
+void x86_cpu_do_interrupt(CPUState *cs)
+{
+    qemu_mutex_lock_iothread();
+    x86_cpu_do_interrupt_locked(cs);
+    qemu_mutex_unlock_iothread();
+}
+
 void do_interrupt_x86_hardirq(CPUX86State *env, int intno, int is_hw)
 {
     do_interrupt_all(env_archcpu(env), intno, 0, 0, 0, is_hw);
diff --git a/target/lm32/cpu.c b/target/lm32/cpu.c
index 93da742520..9e7d8ca929 100644
--- a/target/lm32/cpu.c
+++ b/target/lm32/cpu.c
@@ -222,7 +222,7 @@ static void lm32_cpu_class_init(ObjectClass *oc, void *data)
 
     cc->class_by_name = lm32_cpu_class_by_name;
     cc->has_work = lm32_cpu_has_work;
-    cc->do_interrupt = lm32_cpu_do_interrupt_locked;
+    cc->do_interrupt = lm32_cpu_do_interrupt;
     cc->cpu_exec_interrupt = lm32_cpu_exec_interrupt;
     cc->dump_state = lm32_cpu_dump_state;
     cc->set_pc = lm32_cpu_set_pc;
diff --git a/target/lm32/cpu.h b/target/lm32/cpu.h
index cd96a2905e..01d408eb55 100644
--- a/target/lm32/cpu.h
+++ b/target/lm32/cpu.h
@@ -198,7 +198,7 @@ struct LM32CPU {
 extern const VMStateDescription vmstate_lm32_cpu;
 #endif
 
-void lm32_cpu_do_interrupt_locked(CPUState *cpu);
+void lm32_cpu_do_interrupt(CPUState *cpu);
 bool lm32_cpu_exec_interrupt(CPUState *cs, int int_req);
 void lm32_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
 hwaddr lm32_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
diff --git a/target/lm32/helper.c b/target/lm32/helper.c
index 8599a59df2..6184e212cf 100644
--- a/target/lm32/helper.c
+++ b/target/lm32/helper.c
@@ -148,7 +148,7 @@ void lm32_debug_excp_handler(CPUState *cs)
     }
 }
 
-void lm32_cpu_do_interrupt_locked(CPUState *cs)
+static void lm32_cpu_do_interrupt_locked(CPUState *cs)
 {
     LM32CPU *cpu = LM32_CPU(cs);
     CPULM32State *env = &cpu->env;
@@ -198,6 +198,13 @@ void lm32_cpu_do_interrupt_locked(CPUState *cs)
     }
 }
 
+void lm32_cpu_do_interrupt(CPUState *cs)
+{
+    qemu_mutex_lock_iothread();
+    lm32_cpu_do_interrupt_locked(cs);
+    qemu_mutex_unlock_iothread();
+}
+
 bool lm32_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 {
     LM32CPU *cpu = LM32_CPU(cs);
diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index 6ac0dd87a6..f2585154f5 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -277,7 +277,7 @@ static void m68k_cpu_class_init(ObjectClass *c, void *data)
 
     cc->class_by_name = m68k_cpu_class_by_name;
     cc->has_work = m68k_cpu_has_work;
-    cc->do_interrupt = m68k_cpu_do_interrupt_locked;
+    cc->do_interrupt = m68k_cpu_do_interrupt;
     cc->cpu_exec_interrupt = m68k_cpu_exec_interrupt;
     cc->dump_state = m68k_cpu_dump_state;
     cc->set_pc = m68k_cpu_set_pc;
diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index 1afbe94570..521ac67cdd 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -164,7 +164,7 @@ struct M68kCPU {
 };
 
 
-void m68k_cpu_do_interrupt_locked(CPUState *cpu);
+void m68k_cpu_do_interrupt(CPUState *cpu);
 bool m68k_cpu_exec_interrupt(CPUState *cpu, int int_req);
 void m68k_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
 hwaddr m68k_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
diff --git a/target/m68k/op_helper.c b/target/m68k/op_helper.c
index 8fd6481883..3f0c99124a 100644
--- a/target/m68k/op_helper.c
+++ b/target/m68k/op_helper.c
@@ -25,7 +25,7 @@
 
 #if defined(CONFIG_USER_ONLY)
 
-void m68k_cpu_do_interrupt_locked(CPUState *cs)
+static void m68k_cpu_do_interrupt_locked(CPUState *cs)
 {
     cs->exception_index = -1;
 }
@@ -443,7 +443,7 @@ static void do_interrupt_all(CPUM68KState *env, int is_hw)
     cf_interrupt_all(env, is_hw);
 }
 
-void m68k_cpu_do_interrupt_locked(CPUState *cs)
+static void m68k_cpu_do_interrupt_locked(CPUState *cs)
 {
     M68kCPU *cpu = M68K_CPU(cs);
     CPUM68KState *env = &cpu->env;
@@ -504,6 +504,13 @@ void m68k_cpu_transaction_failed(CPUState *cs, hwaddr physaddr, vaddr addr,
 }
 #endif
 
+void m68k_cpu_do_interrupt(CPUState *cs)
+{
+    qemu_mutex_lock_iothread();
+    m68k_cpu_do_interrupt_locked(cs);
+    qemu_mutex_unlock_iothread();
+}
+
 bool m68k_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 {
     M68kCPU *cpu = M68K_CPU(cs);
diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index b19e386bcf..ce70f7d281 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -316,7 +316,7 @@ static void mb_cpu_class_init(ObjectClass *oc, void *data)
 
     cc->class_by_name = mb_cpu_class_by_name;
     cc->has_work = mb_cpu_has_work;
-    cc->do_interrupt = mb_cpu_do_interrupt_locked;
+    cc->do_interrupt = mb_cpu_do_interrupt;
     cc->cpu_exec_interrupt = mb_cpu_exec_interrupt;
     cc->dump_state = mb_cpu_dump_state;
     cc->set_pc = mb_cpu_set_pc;
diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index 7617565a0c..a31134b65c 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -315,7 +315,7 @@ struct MicroBlazeCPU {
 };
 
 
-void mb_cpu_do_interrupt_locked(CPUState *cs);
+void mb_cpu_do_interrupt(CPUState *cs);
 bool mb_cpu_exec_interrupt(CPUState *cs, int int_req);
 void mb_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
 hwaddr mb_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
diff --git a/target/microblaze/helper.c b/target/microblaze/helper.c
index 263cdf59be..f241587b40 100644
--- a/target/microblaze/helper.c
+++ b/target/microblaze/helper.c
@@ -28,7 +28,7 @@
 
 #if defined(CONFIG_USER_ONLY)
 
-void mb_cpu_do_interrupt_locked(CPUState *cs)
+static void mb_cpu_do_interrupt_locked(CPUState *cs)
 {
     MicroBlazeCPU *cpu = MICROBLAZE_CPU(cs);
     CPUMBState *env = &cpu->env;
@@ -108,7 +108,7 @@ bool mb_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     cpu_loop_exit_restore(cs, retaddr);
 }
 
-void mb_cpu_do_interrupt_locked(CPUState *cs)
+static void mb_cpu_do_interrupt_locked(CPUState *cs)
 {
     MicroBlazeCPU *cpu = MICROBLAZE_CPU(cs);
     CPUMBState *env = &cpu->env;
@@ -287,6 +287,13 @@ hwaddr mb_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
 }
 #endif
 
+void mb_cpu_do_interrupt(CPUState *cs)
+{
+    qemu_mutex_lock_iothread();
+    mb_cpu_do_interrupt_locked(cs);
+    qemu_mutex_unlock_iothread();
+}
+
 bool mb_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 {
     MicroBlazeCPU *cpu = MICROBLAZE_CPU(cs);
diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index c616a0ef5a..ec9dde5100 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -196,7 +196,7 @@ static void mips_cpu_class_init(ObjectClass *c, void *data)
 
     cc->class_by_name = mips_cpu_class_by_name;
     cc->has_work_with_iothread_lock = mips_cpu_has_work;
-    cc->do_interrupt = mips_cpu_do_interrupt_locked;
+    cc->do_interrupt = mips_cpu_do_interrupt;
     cc->cpu_exec_interrupt = mips_cpu_exec_interrupt;
     cc->dump_state = mips_cpu_dump_state;
     cc->set_pc = mips_cpu_set_pc;
diff --git a/target/mips/helper.c b/target/mips/helper.c
index a85c4057d0..3941392b95 100644
--- a/target/mips/helper.c
+++ b/target/mips/helper.c
@@ -1083,7 +1083,7 @@ static inline void set_badinstr_registers(CPUMIPSState *env)
 }
 #endif
 
-void mips_cpu_do_interrupt_locked(CPUState *cs)
+static void mips_cpu_do_interrupt_locked(CPUState *cs)
 {
 #if !defined(CONFIG_USER_ONLY)
     MIPSCPU *cpu = MIPS_CPU(cs);
@@ -1398,6 +1398,13 @@ void mips_cpu_do_interrupt_locked(CPUState *cs)
     cs->exception_index = EXCP_NONE;
 }
 
+void mips_cpu_do_interrupt(CPUState *cs)
+{
+    qemu_mutex_lock_iothread();
+    mips_cpu_do_interrupt_locked(cs);
+    qemu_mutex_unlock_iothread();
+}
+
 bool mips_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 {
     if (interrupt_request & CPU_INTERRUPT_HARD) {
diff --git a/target/mips/internal.h b/target/mips/internal.h
index fb0181c095..7f159a9230 100644
--- a/target/mips/internal.h
+++ b/target/mips/internal.h
@@ -80,7 +80,7 @@ enum CPUMIPSMSADataFormat {
     DF_DOUBLE
 };
 
-void mips_cpu_do_interrupt_locked(CPUState *cpu);
+void mips_cpu_do_interrupt(CPUState *cpu);
 bool mips_cpu_exec_interrupt(CPUState *cpu, int int_req);
 void mips_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
 hwaddr mips_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
diff --git a/target/nios2/cpu.c b/target/nios2/cpu.c
index cc813181a4..7116b3f230 100644
--- a/target/nios2/cpu.c
+++ b/target/nios2/cpu.c
@@ -192,7 +192,7 @@ static void nios2_cpu_class_init(ObjectClass *oc, void *data)
 
     cc->class_by_name = nios2_cpu_class_by_name;
     cc->has_work = nios2_cpu_has_work;
-    cc->do_interrupt = nios2_cpu_do_interrupt_locked;
+    cc->do_interrupt = nios2_cpu_do_interrupt;
     cc->cpu_exec_interrupt = nios2_cpu_exec_interrupt;
     cc->dump_state = nios2_cpu_dump_state;
     cc->set_pc = nios2_cpu_set_pc;
diff --git a/target/nios2/cpu.h b/target/nios2/cpu.h
index dcf1715092..6fa60b1399 100644
--- a/target/nios2/cpu.h
+++ b/target/nios2/cpu.h
@@ -195,6 +195,7 @@ typedef struct Nios2CPU {
 
 
 void nios2_tcg_init(void);
+void nios2_cpu_do_interrupt(CPUState *cs);
 void nios2_cpu_do_interrupt_locked(CPUState *cs);
 int cpu_nios2_signal_handler(int host_signum, void *pinfo, void *puc);
 void dump_mmu(CPUNios2State *env);
diff --git a/target/nios2/helper.c b/target/nios2/helper.c
index 25c6c6d4d8..c81aa073f4 100644
--- a/target/nios2/helper.c
+++ b/target/nios2/helper.c
@@ -312,3 +312,12 @@ bool nios2_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     cpu_loop_exit_restore(cs, retaddr);
 }
 #endif /* !CONFIG_USER_ONLY */
+
+void nios2_cpu_do_interrupt(CPUState *cs)
+{
+    qemu_mutex_lock_iothread();
+    nios2_cpu_do_interrupt_locked(cs);
+    qemu_mutex_unlock_iothread();
+}
+
+
diff --git a/target/openrisc/cpu.c b/target/openrisc/cpu.c
index e428946dc2..fd2da39124 100644
--- a/target/openrisc/cpu.c
+++ b/target/openrisc/cpu.c
@@ -154,7 +154,7 @@ static void openrisc_cpu_class_init(ObjectClass *oc, void *data)
 
     cc->class_by_name = openrisc_cpu_class_by_name;
     cc->has_work = openrisc_cpu_has_work;
-    cc->do_interrupt = openrisc_cpu_do_interrupt_locked;
+    cc->do_interrupt = openrisc_cpu_do_interrupt;
     cc->cpu_exec_interrupt = openrisc_cpu_exec_interrupt;
     cc->dump_state = openrisc_cpu_dump_state;
     cc->set_pc = openrisc_cpu_set_pc;
diff --git a/target/openrisc/cpu.h b/target/openrisc/cpu.h
index e77f075cd9..f37a52e153 100644
--- a/target/openrisc/cpu.h
+++ b/target/openrisc/cpu.h
@@ -316,7 +316,7 @@ typedef struct OpenRISCCPU {
 
 
 void cpu_openrisc_list(void);
-void openrisc_cpu_do_interrupt_locked(CPUState *cpu);
+void openrisc_cpu_do_interrupt(CPUState *cpu);
 bool openrisc_cpu_exec_interrupt(CPUState *cpu, int int_req);
 void openrisc_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
 hwaddr openrisc_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
diff --git a/target/openrisc/interrupt.c b/target/openrisc/interrupt.c
index f95289444f..a5ca3ece78 100644
--- a/target/openrisc/interrupt.c
+++ b/target/openrisc/interrupt.c
@@ -26,7 +26,7 @@
 #include "hw/loader.h"
 #endif
 
-void openrisc_cpu_do_interrupt_locked(CPUState *cs)
+static void openrisc_cpu_do_interrupt_locked(CPUState *cs)
 {
 #ifndef CONFIG_USER_ONLY
     OpenRISCCPU *cpu = OPENRISC_CPU(cs);
@@ -101,6 +101,13 @@ void openrisc_cpu_do_interrupt_locked(CPUState *cs)
     cs->exception_index = -1;
 }
 
+void openrisc_cpu_do_interrupt(CPUState *cs)
+{
+    qemu_mutex_lock_iothread();
+    openrisc_cpu_do_interrupt_locked(cs);
+    qemu_mutex_unlock_iothread();
+}
+
 bool openrisc_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 {
     OpenRISCCPU *cpu = OPENRISC_CPU(cs);
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index ed297acdb4..2569d43e59 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1231,6 +1231,7 @@ struct PPCVirtualHypervisorClass {
                      TYPE_PPC_VIRTUAL_HYPERVISOR)
 #endif /* CONFIG_USER_ONLY */
 
+void ppc_cpu_do_interrupt(CPUState *cpu);
 void ppc_cpu_do_interrupt_locked(CPUState *cpu);
 bool ppc_cpu_exec_interrupt(CPUState *cpu, int int_req);
 void ppc_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index fe9b122fd0..2cb1aaa296 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -1428,3 +1428,10 @@ void ppc_cpu_do_unaligned_access(CPUState *cs, vaddr vaddr,
     env->error_code = insn & 0x03FF0000;
     cpu_loop_exit(cs);
 }
+
+void ppc_cpu_do_interrupt(CPUState *cs)
+{
+    qemu_mutex_lock_iothread();
+    ppc_cpu_do_interrupt_locked(cs);
+    qemu_mutex_unlock_iothread();
+}
diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.inc.c
index 653b04aef6..27ae7fa195 100644
--- a/target/ppc/translate_init.inc.c
+++ b/target/ppc/translate_init.inc.c
@@ -10885,7 +10885,7 @@ static void ppc_cpu_class_init(ObjectClass *oc, void *data)
     pcc->parent_parse_features = cc->parse_features;
     cc->parse_features = ppc_cpu_parse_featurestr;
     cc->has_work_with_iothread_lock = ppc_cpu_has_work;
-    cc->do_interrupt = ppc_cpu_do_interrupt_locked;
+    cc->do_interrupt = ppc_cpu_do_interrupt;
     cc->cpu_exec_interrupt = ppc_cpu_exec_interrupt;
     cc->dump_state = ppc_cpu_dump_state;
     cc->dump_statistics = ppc_cpu_dump_statistics;
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 833e6d4f1e..832171c360 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -537,7 +537,7 @@ static void riscv_cpu_class_init(ObjectClass *c, void *data)
 
     cc->class_by_name = riscv_cpu_class_by_name;
     cc->has_work_with_iothread_lock = riscv_cpu_has_work;
-    cc->do_interrupt = riscv_cpu_do_interrupt_locked;
+    cc->do_interrupt = riscv_cpu_do_interrupt;
     cc->cpu_exec_interrupt = riscv_cpu_exec_interrupt;
     cc->dump_state = riscv_cpu_dump_state;
     cc->set_pc = riscv_cpu_set_pc;
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 372005b79c..a804a5d0ba 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -312,7 +312,7 @@ extern const char * const riscv_fpr_regnames[];
 extern const char * const riscv_excp_names[];
 extern const char * const riscv_intr_names[];
 
-void riscv_cpu_do_interrupt_locked(CPUState *cpu);
+void riscv_cpu_do_interrupt(CPUState *cpu);
 int riscv_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
 int riscv_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 bool riscv_cpu_exec_interrupt(CPUState *cs, int interrupt_request);
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 477cf66b66..2c8ee8ca2b 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -25,6 +25,8 @@
 #include "tcg/tcg-op.h"
 #include "trace.h"
 
+static void riscv_cpu_do_interrupt_locked(CPUState *cs);
+
 int riscv_cpu_mmu_index(CPURISCVState *env, bool ifetch)
 {
 #ifdef CONFIG_USER_ONLY
@@ -814,13 +816,20 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
 #endif
 }
 
+void riscv_cpu_do_interrupt(CPUState *cs)
+{
+    qemu_mutex_lock_iothread();
+    riscv_cpu_do_interrupt_locked(cs);
+    qemu_mutex_unlock_iothread();
+}
+
 /*
  * Handle Traps
  *
  * Adapted from Spike's processor_t::take_trap.
  *
  */
-void riscv_cpu_do_interrupt_locked(CPUState *cs)
+static void riscv_cpu_do_interrupt_locked(CPUState *cs)
 {
 #if !defined(CONFIG_USER_ONLY)
 
diff --git a/target/rx/cpu.c b/target/rx/cpu.c
index 51e10da7cc..219e05397b 100644
--- a/target/rx/cpu.c
+++ b/target/rx/cpu.c
@@ -185,7 +185,7 @@ static void rx_cpu_class_init(ObjectClass *klass, void *data)
 
     cc->class_by_name = rx_cpu_class_by_name;
     cc->has_work = rx_cpu_has_work;
-    cc->do_interrupt = rx_cpu_do_interrupt_locked;
+    cc->do_interrupt = rx_cpu_do_interrupt;
     cc->cpu_exec_interrupt = rx_cpu_exec_interrupt;
     cc->dump_state = rx_cpu_dump_state;
     cc->set_pc = rx_cpu_set_pc;
diff --git a/target/rx/cpu.h b/target/rx/cpu.h
index d188e7d43f..ec085d0386 100644
--- a/target/rx/cpu.h
+++ b/target/rx/cpu.h
@@ -125,6 +125,7 @@ typedef RXCPU ArchCPU;
 #define CPU_RESOLVING_TYPE TYPE_RX_CPU
 
 const char *rx_crname(uint8_t cr);
+void rx_cpu_do_interrupt(CPUState *cpu);
 void rx_cpu_do_interrupt_locked(CPUState *cpu);
 bool rx_cpu_exec_interrupt(CPUState *cpu, int int_req);
 void rx_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
diff --git a/target/rx/helper.c b/target/rx/helper.c
index 332f89435a..8c0512b62a 100644
--- a/target/rx/helper.c
+++ b/target/rx/helper.c
@@ -119,6 +119,13 @@ void rx_cpu_do_interrupt_locked(CPUState *cs)
     env->regs[0] = env->isp;
 }
 
+void rx_cpu_do_interrupt(CPUState *cs)
+{
+    qemu_mutex_lock_iothread();
+    rx_cpu_do_interrupt_locked(cs);
+    qemu_mutex_unlock_iothread();
+}
+
 bool rx_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 {
     RXCPU *cpu = RXCPU(cs);
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index eb23d64f36..4d0d323cf9 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -493,7 +493,7 @@ static void s390_cpu_class_init(ObjectClass *oc, void *data)
     cc->class_by_name = s390_cpu_class_by_name,
     cc->has_work_with_iothread_lock = s390_cpu_has_work;
 #ifdef CONFIG_TCG
-    cc->do_interrupt = s390_cpu_do_interrupt_locked;
+    cc->do_interrupt = s390_cpu_do_interrupt;
 #endif
     cc->dump_state = s390_cpu_dump_state;
     cc->set_pc = s390_cpu_set_pc;
diff --git a/target/s390x/excp_helper.c b/target/s390x/excp_helper.c
index a663127f17..a020db1725 100644
--- a/target/s390x/excp_helper.c
+++ b/target/s390x/excp_helper.c
@@ -611,3 +611,10 @@ void s390x_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
 }
 
 #endif /* CONFIG_USER_ONLY */
+
+void s390_cpu_do_interrupt(CPUState *cs)
+{
+    qemu_mutex_lock_iothread();
+    s390_cpu_do_interrupt_locked(cs);
+    qemu_mutex_unlock_iothread();
+}
diff --git a/target/s390x/internal.h b/target/s390x/internal.h
index 6ab0fb481a..b4660ad255 100644
--- a/target/s390x/internal.h
+++ b/target/s390x/internal.h
@@ -268,6 +268,7 @@ ObjectClass *s390_cpu_class_by_name(const char *name);
 
 /* excp_helper.c */
 void s390x_cpu_debug_excp_handler(CPUState *cs);
+void s390_cpu_do_interrupt(CPUState *cpu);
 void s390_cpu_do_interrupt_locked(CPUState *cpu);
 bool s390_cpu_exec_interrupt(CPUState *cpu, int int_req);
 bool s390_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
index 5e5921a220..18f3448183 100644
--- a/target/sh4/cpu.c
+++ b/target/sh4/cpu.c
@@ -218,7 +218,7 @@ static void superh_cpu_class_init(ObjectClass *oc, void *data)
 
     cc->class_by_name = superh_cpu_class_by_name;
     cc->has_work = superh_cpu_has_work;
-    cc->do_interrupt = superh_cpu_do_interrupt_locked;
+    cc->do_interrupt = superh_cpu_do_interrupt;
     cc->cpu_exec_interrupt = superh_cpu_exec_interrupt;
     cc->dump_state = superh_cpu_dump_state;
     cc->set_pc = superh_cpu_set_pc;
diff --git a/target/sh4/cpu.h b/target/sh4/cpu.h
index 2ae3dd132b..dbe58c7888 100644
--- a/target/sh4/cpu.h
+++ b/target/sh4/cpu.h
@@ -204,7 +204,7 @@ struct SuperHCPU {
 };
 
 
-void superh_cpu_do_interrupt_locked(CPUState *cpu);
+void superh_cpu_do_interrupt(CPUState *cpu);
 bool superh_cpu_exec_interrupt(CPUState *cpu, int int_req);
 void superh_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
 hwaddr superh_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
diff --git a/target/sh4/helper.c b/target/sh4/helper.c
index 2d61f65d50..471650b622 100644
--- a/target/sh4/helper.c
+++ b/target/sh4/helper.c
@@ -45,7 +45,7 @@
 
 #if defined(CONFIG_USER_ONLY)
 
-void superh_cpu_do_interrupt_locked(CPUState *cs)
+static void superh_cpu_do_interrupt_locked(CPUState *cs)
 {
     cs->exception_index = -1;
 }
@@ -58,7 +58,7 @@ int cpu_sh4_is_cached(CPUSH4State *env, target_ulong addr)
 
 #else /* !CONFIG_USER_ONLY */
 
-void superh_cpu_do_interrupt_locked(CPUState *cs)
+static void superh_cpu_do_interrupt_locked(CPUState *cs)
 {
     SuperHCPU *cpu = SUPERH_CPU(cs);
     CPUSH4State *env = &cpu->env;
@@ -782,6 +782,13 @@ int cpu_sh4_is_cached(CPUSH4State * env, target_ulong addr)
 
 #endif
 
+void superh_cpu_do_interrupt(CPUState *cs)
+{
+    qemu_mutex_lock_iothread();
+    superh_cpu_do_interrupt_locked(cs);
+    qemu_mutex_unlock_iothread();
+}
+
 bool superh_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 {
     if (interrupt_request & CPU_INTERRUPT_HARD) {
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index 4c8842adcf..1c26bbd59b 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -863,7 +863,7 @@ static void sparc_cpu_class_init(ObjectClass *oc, void *data)
     cc->class_by_name = sparc_cpu_class_by_name;
     cc->parse_features = sparc_cpu_parse_features;
     cc->has_work_with_iothread_lock = sparc_cpu_has_work;
-    cc->do_interrupt = sparc_cpu_do_interrupt_locked;
+    cc->do_interrupt = sparc_cpu_do_interrupt;
     cc->cpu_exec_interrupt = sparc_cpu_exec_interrupt;
     cc->dump_state = sparc_cpu_dump_state;
 #if !defined(TARGET_SPARC64) && !defined(CONFIG_USER_ONLY)
diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index 3563e65d73..ec8684ec93 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -568,6 +568,7 @@ struct SPARCCPU {
 extern const VMStateDescription vmstate_sparc_cpu;
 #endif
 
+void sparc_cpu_do_interrupt(CPUState *cpu);
 void sparc_cpu_do_interrupt_locked(CPUState *cpu);
 void sparc_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
 hwaddr sparc_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
diff --git a/target/sparc/int32_helper.c b/target/sparc/int32_helper.c
index 90f4aa4a78..7a1f15b06c 100644
--- a/target/sparc/int32_helper.c
+++ b/target/sparc/int32_helper.c
@@ -138,6 +138,13 @@ void sparc_cpu_do_interrupt_locked(CPUState *cs)
 #endif
 }
 
+void sparc_cpu_do_interrupt(CPUState *cs)
+{
+    qemu_mutex_lock_iothread();
+    sparc_cpu_do_interrupt_locked(cs);
+    qemu_mutex_unlock_iothread();
+}
+
 #if !defined(CONFIG_USER_ONLY)
 static void leon3_cache_control_int(CPUSPARCState *env)
 {
diff --git a/target/sparc/int64_helper.c b/target/sparc/int64_helper.c
index b81b4abaa8..aa3d9aa585 100644
--- a/target/sparc/int64_helper.c
+++ b/target/sparc/int64_helper.c
@@ -198,6 +198,13 @@ void sparc_cpu_do_interrupt_locked(CPUState *cs)
     cs->exception_index = -1;
 }
 
+void sparc_cpu_do_interrupt(CPUState *cs)
+{
+    qemu_mutex_lock_iothread();
+    sparc_cpu_do_interrupt_locked(cs);
+    qemu_mutex_unlock_iothread();
+}
+
 trap_state *cpu_tsptr(CPUSPARCState* env)
 {
     return &env->ts[env->tl & MAXTL_MASK];
diff --git a/target/tilegx/cpu.c b/target/tilegx/cpu.c
index a2ff335977..a450dc63a3 100644
--- a/target/tilegx/cpu.c
+++ b/target/tilegx/cpu.c
@@ -125,6 +125,13 @@ static bool tilegx_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     cpu_loop_exit_restore(cs, retaddr);
 }
 
+static void tilegx_cpu_do_interrupt(CPUState *cs)
+{
+    qemu_mutex_lock_iothread();
+    tilegx_cpu_do_interrupt_locked(cs);
+    qemu_mutex_unlock_iothread();
+}
+
 static bool tilegx_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 {
     if (interrupt_request & CPU_INTERRUPT_HARD) {
@@ -147,7 +154,7 @@ static void tilegx_cpu_class_init(ObjectClass *oc, void *data)
 
     cc->class_by_name = tilegx_cpu_class_by_name;
     cc->has_work = tilegx_cpu_has_work;
-    cc->do_interrupt = tilegx_cpu_do_interrupt_locked;
+    cc->do_interrupt = tilegx_cpu_do_interrupt;
     cc->cpu_exec_interrupt = tilegx_cpu_exec_interrupt;
     cc->dump_state = tilegx_cpu_dump_state;
     cc->set_pc = tilegx_cpu_set_pc;
diff --git a/target/unicore32/cpu.c b/target/unicore32/cpu.c
index a96077d666..06bf4b4b63 100644
--- a/target/unicore32/cpu.c
+++ b/target/unicore32/cpu.c
@@ -131,7 +131,7 @@ static void uc32_cpu_class_init(ObjectClass *oc, void *data)
 
     cc->class_by_name = uc32_cpu_class_by_name;
     cc->has_work = uc32_cpu_has_work;
-    cc->do_interrupt = uc32_cpu_do_interrupt_locked;
+    cc->do_interrupt = uc32_cpu_do_interrupt;
     cc->cpu_exec_interrupt = uc32_cpu_exec_interrupt;
     cc->dump_state = uc32_cpu_dump_state;
     cc->set_pc = uc32_cpu_set_pc;
diff --git a/target/unicore32/cpu.h b/target/unicore32/cpu.h
index d948392ff3..9453b5d7b3 100644
--- a/target/unicore32/cpu.h
+++ b/target/unicore32/cpu.h
@@ -75,6 +75,7 @@ struct UniCore32CPU {
 };
 
 
+void uc32_cpu_do_interrupt(CPUState *cpu);
 void uc32_cpu_do_interrupt_locked(CPUState *cpu);
 bool uc32_cpu_exec_interrupt(CPUState *cpu, int int_req);
 void uc32_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
diff --git a/target/unicore32/softmmu.c b/target/unicore32/softmmu.c
index a12526a8ca..7fb28f3c12 100644
--- a/target/unicore32/softmmu.c
+++ b/target/unicore32/softmmu.c
@@ -120,6 +120,13 @@ void uc32_cpu_do_interrupt_locked(CPUState *cs)
     cpu_interrupt_request_or(cs, CPU_INTERRUPT_EXITTB);
 }
 
+void uc32_cpu_do_interrupt(CPUState *cs)
+{
+    qemu_mutex_lock_iothread();
+    uc32_cpu_do_interrupt_locked(cs);
+    qemu_mutex_unlock_iothread();
+}
+
 static int get_phys_addr_ucv2(CPUUniCore32State *env, uint32_t address,
         int access_type, int is_user, uint32_t *phys_ptr, int *prot,
         target_ulong *page_size)
diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index 7962bc66a8..0f96483563 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -190,7 +190,7 @@ static void xtensa_cpu_class_init(ObjectClass *oc, void *data)
 
     cc->class_by_name = xtensa_cpu_class_by_name;
     cc->has_work_with_iothread_lock = xtensa_cpu_has_work;
-    cc->do_interrupt = xtensa_cpu_do_interrupt_locked;
+    cc->do_interrupt = xtensa_cpu_do_interrupt;
     cc->cpu_exec_interrupt = xtensa_cpu_exec_interrupt;
     cc->dump_state = xtensa_cpu_dump_state;
     cc->set_pc = xtensa_cpu_set_pc;
diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index c02f531b64..32749378bf 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -563,7 +563,7 @@ struct XtensaCPU {
 bool xtensa_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                          MMUAccessType access_type, int mmu_idx,
                          bool probe, uintptr_t retaddr);
-void xtensa_cpu_do_interrupt_locked(CPUState *cpu);
+void xtensa_cpu_do_interrupt(CPUState *cpu);
 bool xtensa_cpu_exec_interrupt(CPUState *cpu, int interrupt_request);
 void xtensa_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr, vaddr addr,
                                       unsigned size, MMUAccessType access_type,
diff --git a/target/xtensa/exc_helper.c b/target/xtensa/exc_helper.c
index 10d4762f36..822ed7aad8 100644
--- a/target/xtensa/exc_helper.c
+++ b/target/xtensa/exc_helper.c
@@ -195,7 +195,7 @@ static void handle_interrupt(CPUXtensaState *env)
 }
 
 /* Called from cpu_handle_interrupt with BQL held */
-void xtensa_cpu_do_interrupt_locked(CPUState *cs)
+static void xtensa_cpu_do_interrupt_locked(CPUState *cs)
 {
     XtensaCPU *cpu = XTENSA_CPU(cs);
     CPUXtensaState *env = &cpu->env;
@@ -254,11 +254,18 @@ void xtensa_cpu_do_interrupt_locked(CPUState *cs)
     check_interrupts(env);
 }
 #else
-void xtensa_cpu_do_interrupt_locked(CPUState *cs)
+static void xtensa_cpu_do_interrupt_locked(CPUState *cs)
 {
 }
 #endif
 
+void xtensa_cpu_do_interrupt(CPUState *cs)
+{
+    qemu_mutex_lock_iothread();
+    xtensa_cpu_do_interrupt_locked(cs);
+    qemu_mutex_unlock_iothread();
+}
+
 bool xtensa_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 {
     if (interrupt_request & CPU_INTERRUPT_HARD) {
-- 
2.17.1


