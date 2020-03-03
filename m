Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 439B5C3F2CD
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 10:06:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E64EA20873
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 10:06:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nIs1NFh3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E64EA20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j94RK-0005Kc-5O
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 05:06:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51623)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j94QU-0004IN-F6
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 05:05:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j94QQ-0004Q6-3m
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 05:05:22 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:51515)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j94QP-0004PW-Q9
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 05:05:18 -0500
Received: by mail-wm1-x343.google.com with SMTP id a132so2399391wme.1
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2020 02:05:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=PbCLdVLTZ0u03HkxX8ujZ8LhLRlUovzKqITmjuVBLsk=;
 b=nIs1NFh3Sfsh9qdfGe5CL1EcxetInFIKg/KstRrucRqsNBUBjU1ERxaC2R/6SrixbC
 oqr1vTFKYDzSsn9oZVME2Jc3n+BiycabbOFvthiIZCa6KUV/bSMLgxzELj+LaxM8TMFm
 Fa1JBz6W/nH8pv3SiJcSwJTwt34VKt7FIKkp6vkeL2M3e2LP89sf9fGdyFW/sGw01QmY
 1IaHnZq5xAMOPs4eBAxQbUErzSEMxUpu7+rD8rj1pxFSTiEjNj9BIWNTU9zBt2XtxbSs
 pKXKhKBeF1vU3oJIO260i9IPHxes4pX+FBoZob3X7EwtlUW/wIWyS7XI/iIzwbYWGKD7
 c8Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=PbCLdVLTZ0u03HkxX8ujZ8LhLRlUovzKqITmjuVBLsk=;
 b=lcdVGCJPYqAyB9hupzeOYEwz+b/mkgrQkGdoCCo1CQOWAIEVK+SNuZGkpNAMfcR/nb
 7iNY0LdHW4JhRoSGto4zINz8WBjFwl/wo9ppuI+90uqcO/8Xfc/emTGl/i3EuaFMEOCR
 G1mDlgdY7BRTORde9SrJlzXE0dIpr0Y5l6ElyJOgSX93Lt8nOQKAmM6exPz2XDiWTFCa
 dhCKOVsilZCkMWQ9aggNsLg0+2+O8k4hz/rR60pbFXst4+IDTKHj6J3K3whsZln2k00Z
 FT+7Xyjmspu+TOcNFpPswwCoWIAK88KHhi6ODJ3qjoKDOeqV1ndgEtO32tOO88cjF1Kt
 Ux7A==
X-Gm-Message-State: ANhLgQ0Ik6qO3vdMiUWmFImzeCWoPSjhGbWd1QvOeAafxs0AOW28XMWW
 1oXTFuUTFIytrUW2RWfPGOOhSWEPpfEO2w==
X-Google-Smtp-Source: ADFU+vscF3KjeihmbdjBGK2ho1AUoPF7G7F2NIblqSMnMqlqPey4ZPZkvt7wK2NgL4rZxEvq2GAgHg==
X-Received: by 2002:a1c:f21a:: with SMTP id s26mr3538175wmc.39.1583229915552; 
 Tue, 03 Mar 2020 02:05:15 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id b10sm3106337wmh.48.2020.03.03.02.05.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Mar 2020 02:05:14 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] cpu: Use DeviceClass reset instead of a special CPUClass reset
Date: Tue,  3 Mar 2020 10:05:11 +0000
Message-Id: <20200303100511.5498-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: Chris Wulff <crwulff@gmail.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 David Hildenbrand <david@redhat.com>, Anthony Green <green@moxielogic.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Max Filippov <jcmvbkbc@gmail.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Marek Vasut <marex@denx.de>,
 qemu-ppc@nongnu.org, Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Richard Henderson <rth@twiddle.net>, Artyom Tarasenko <atar4qemu@gmail.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-s390x@nongnu.org,
 qemu-arm@nongnu.org, Stafford Horne <shorne@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>, qemu-riscv@nongnu.org,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Cornelia Huck <cohuck@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Michael Walle <michael@walle.cc>, Palmer Dabbelt <palmer@dabbelt.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The CPUClass has a 'reset' method.  This is a legacy from when
TYPE_CPU used not to inherit from TYPE_DEVICE.  We don't need it any
more, as we can simply use the TYPE_DEVICE reset.  The 'cpu_reset()'
function is kept as the API which most places use to reset a CPU; it
is now a wrapper which calls device_cold_reset() and then the
tracepoint function.

This change should not cause CPU objects to be reset more often
than they are at the moment, because:
 * nobody is directly calling device_cold_reset() or
   qdev_reset_all() on CPU objects
 * no CPU object is on a qbus, so they will not be reset either
   by somebody calling qbus_reset_all()/bus_cold_reset(), or
   by the main "reset sysbus and everything in the qbus tree"
   reset that most devices are reset by

Note that this does not change the need for each machine or whatever
to use qemu_register_reset() to arrange to call cpu_reset() -- that
is necessary because CPU objects are not on any qbus, so they don't
get reset when the qbus tree rooted at the sysbus bus is reset, and
this isn't being changed here.

All the changes to the files under target/ were made using the
included Coccinelle script, except:

(1) the deletion of the now-inaccurate and not terribly useful
"CPUClass::reset" comments was done with a perl one-liner afterwards:
  perl -n -i -e '/ CPUClass::reset/ or print' target/*/*.c

(2) this bit of the s390 change was done by hand, because the
Coccinelle script is not sophisticated enough to handle the
parent_reset call being inside another function:

| @@ -96,8 +96,9 @@ static void s390_cpu_reset(CPUState *s, cpu_reset_type type)
|     S390CPU *cpu = S390_CPU(s);
|     S390CPUClass *scc = S390_CPU_GET_CLASS(cpu);
|     CPUS390XState *env = &cpu->env;
|+    DeviceState *dev = DEVICE(s);
|
|-    scc->parent_reset(s);
|+    scc->parent_reset(dev);
|     cpu->env.sigp_order = 0;
|     s390_cpu_set_state(S390_CPU_STATE_STOPPED, cpu);

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Testing was by 'make check' and 'make check-acceptance'.

I need this patch as a preliminary to some arm stuff I'm
doing, but I think it makes sense as a cleanup in its own
right so I'm sending it out early for review. If it's not
yet in master before I get round to finishing the stuff
that depends on it I'll resend it as part of that series.
---
 include/hw/core/cpu.h              |  6 ----
 target/alpha/cpu-qom.h             |  2 +-
 target/arm/cpu-qom.h               |  2 +-
 target/cris/cpu-qom.h              |  2 +-
 target/hppa/cpu-qom.h              |  2 +-
 target/i386/cpu-qom.h              |  2 +-
 target/lm32/cpu-qom.h              |  2 +-
 target/m68k/cpu-qom.h              |  2 +-
 target/microblaze/cpu-qom.h        |  2 +-
 target/mips/cpu-qom.h              |  2 +-
 target/moxie/cpu.h                 |  2 +-
 target/nios2/cpu.h                 |  2 +-
 target/openrisc/cpu.h              |  2 +-
 target/ppc/cpu-qom.h               |  2 +-
 target/riscv/cpu.h                 |  2 +-
 target/s390x/cpu-qom.h             |  2 +-
 target/sh4/cpu-qom.h               |  2 +-
 target/sparc/cpu-qom.h             |  2 +-
 target/tilegx/cpu.h                |  2 +-
 target/tricore/cpu-qom.h           |  2 +-
 target/xtensa/cpu-qom.h            |  2 +-
 hw/core/cpu.c                      | 19 +++---------
 target/arm/cpu.c                   |  8 ++---
 target/cris/cpu.c                  |  8 ++---
 target/i386/cpu.c                  |  8 ++---
 target/lm32/cpu.c                  |  8 ++---
 target/m68k/cpu.c                  |  8 ++---
 target/microblaze/cpu.c            |  8 ++---
 target/mips/cpu.c                  |  8 ++---
 target/moxie/cpu.c                 |  7 +++--
 target/nios2/cpu.c                 |  8 ++---
 target/openrisc/cpu.c              |  8 ++---
 target/ppc/translate_init.inc.c    |  8 ++---
 target/riscv/cpu.c                 |  7 +++--
 target/s390x/cpu.c                 |  8 +++--
 target/sh4/cpu.c                   |  8 ++---
 target/sparc/cpu.c                 |  8 ++---
 target/tilegx/cpu.c                |  7 +++--
 target/tricore/cpu.c               |  7 +++--
 target/xtensa/cpu.c                |  8 ++---
 scripts/coccinelle/cpu-reset.cocci | 47 ++++++++++++++++++++++++++++++
 41 files changed, 144 insertions(+), 108 deletions(-)
 create mode 100644 scripts/coccinelle/cpu-reset.cocci

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 73e9a869a41..88ee543722d 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -79,7 +79,6 @@ struct TranslationBlock;
  * @class_by_name: Callback to map -cpu command line model name to an
  * instantiatable CPU type.
  * @parse_features: Callback to parse command line arguments.
- * @reset: Callback to reset the #CPUState to its initial state.
  * @reset_dump_flags: #CPUDumpFlags to use for reset logging.
  * @has_work: Callback for checking if there is work to do.
  * @do_interrupt: Callback for interrupt handling.
@@ -165,7 +164,6 @@ typedef struct CPUClass {
     ObjectClass *(*class_by_name)(const char *cpu_model);
     void (*parse_features)(const char *typename, char *str, Error **errp);
 
-    void (*reset)(CPUState *cpu);
     int reset_dump_flags;
     bool (*has_work)(CPUState *cpu);
     void (*do_interrupt)(CPUState *cpu);
@@ -1135,10 +1133,6 @@ void cpu_exec_unrealizefn(CPUState *cpu);
  */
 bool target_words_bigendian(void);
 
-void cpu_class_set_parent_reset(CPUClass *cc,
-                                void (*child_reset)(CPUState *cpu),
-                                void (**parent_reset)(CPUState *cpu));
-
 #ifdef NEED_CPU_H
 
 #ifdef CONFIG_SOFTMMU
diff --git a/target/alpha/cpu-qom.h b/target/alpha/cpu-qom.h
index 6f0a0adb9ef..08832fa7672 100644
--- a/target/alpha/cpu-qom.h
+++ b/target/alpha/cpu-qom.h
@@ -44,7 +44,7 @@ typedef struct AlphaCPUClass {
     /*< public >*/
 
     DeviceRealize parent_realize;
-    void (*parent_reset)(CPUState *cpu);
+    DeviceReset parent_reset;
 } AlphaCPUClass;
 
 typedef struct AlphaCPU AlphaCPU;
diff --git a/target/arm/cpu-qom.h b/target/arm/cpu-qom.h
index 3a9d31ea9df..d95568bf052 100644
--- a/target/arm/cpu-qom.h
+++ b/target/arm/cpu-qom.h
@@ -51,7 +51,7 @@ typedef struct ARMCPUClass {
 
     const ARMCPUInfo *info;
     DeviceRealize parent_realize;
-    void (*parent_reset)(CPUState *cpu);
+    DeviceReset parent_reset;
 } ARMCPUClass;
 
 typedef struct ARMCPU ARMCPU;
diff --git a/target/cris/cpu-qom.h b/target/cris/cpu-qom.h
index 308c1f95bdf..f1de6041dcb 100644
--- a/target/cris/cpu-qom.h
+++ b/target/cris/cpu-qom.h
@@ -45,7 +45,7 @@ typedef struct CRISCPUClass {
     /*< public >*/
 
     DeviceRealize parent_realize;
-    void (*parent_reset)(CPUState *cpu);
+    DeviceReset parent_reset;
 
     uint32_t vr;
 } CRISCPUClass;
diff --git a/target/hppa/cpu-qom.h b/target/hppa/cpu-qom.h
index 6367dc47939..b1f60454953 100644
--- a/target/hppa/cpu-qom.h
+++ b/target/hppa/cpu-qom.h
@@ -44,7 +44,7 @@ typedef struct HPPACPUClass {
     /*< public >*/
 
     DeviceRealize parent_realize;
-    void (*parent_reset)(CPUState *cpu);
+    DeviceReset parent_reset;
 } HPPACPUClass;
 
 typedef struct HPPACPU HPPACPU;
diff --git a/target/i386/cpu-qom.h b/target/i386/cpu-qom.h
index 0efab2fc670..3e96f8d668e 100644
--- a/target/i386/cpu-qom.h
+++ b/target/i386/cpu-qom.h
@@ -71,7 +71,7 @@ typedef struct X86CPUClass {
 
     DeviceRealize parent_realize;
     DeviceUnrealize parent_unrealize;
-    void (*parent_reset)(CPUState *cpu);
+    DeviceReset parent_reset;
 } X86CPUClass;
 
 typedef struct X86CPU X86CPU;
diff --git a/target/lm32/cpu-qom.h b/target/lm32/cpu-qom.h
index dc9ac9ac9f7..bdedb3759ac 100644
--- a/target/lm32/cpu-qom.h
+++ b/target/lm32/cpu-qom.h
@@ -44,7 +44,7 @@ typedef struct LM32CPUClass {
     /*< public >*/
 
     DeviceRealize parent_realize;
-    void (*parent_reset)(CPUState *cpu);
+    DeviceReset parent_reset;
 } LM32CPUClass;
 
 typedef struct LM32CPU LM32CPU;
diff --git a/target/m68k/cpu-qom.h b/target/m68k/cpu-qom.h
index b56da8a2137..88b11b60f13 100644
--- a/target/m68k/cpu-qom.h
+++ b/target/m68k/cpu-qom.h
@@ -44,7 +44,7 @@ typedef struct M68kCPUClass {
     /*< public >*/
 
     DeviceRealize parent_realize;
-    void (*parent_reset)(CPUState *cpu);
+    DeviceReset parent_reset;
 } M68kCPUClass;
 
 typedef struct M68kCPU M68kCPU;
diff --git a/target/microblaze/cpu-qom.h b/target/microblaze/cpu-qom.h
index 49b07cc697b..053ba44ee8c 100644
--- a/target/microblaze/cpu-qom.h
+++ b/target/microblaze/cpu-qom.h
@@ -44,7 +44,7 @@ typedef struct MicroBlazeCPUClass {
     /*< public >*/
 
     DeviceRealize parent_realize;
-    void (*parent_reset)(CPUState *cpu);
+    DeviceReset parent_reset;
 } MicroBlazeCPUClass;
 
 typedef struct MicroBlazeCPU MicroBlazeCPU;
diff --git a/target/mips/cpu-qom.h b/target/mips/cpu-qom.h
index a430c0fe4bb..9d0df6c034b 100644
--- a/target/mips/cpu-qom.h
+++ b/target/mips/cpu-qom.h
@@ -48,7 +48,7 @@ typedef struct MIPSCPUClass {
     /*< public >*/
 
     DeviceRealize parent_realize;
-    void (*parent_reset)(CPUState *cpu);
+    DeviceReset parent_reset;
     const struct mips_def_t *cpu_def;
 } MIPSCPUClass;
 
diff --git a/target/moxie/cpu.h b/target/moxie/cpu.h
index 01dca548e5d..455553b794a 100644
--- a/target/moxie/cpu.h
+++ b/target/moxie/cpu.h
@@ -69,7 +69,7 @@ typedef struct MoxieCPUClass {
     /*< public >*/
 
     DeviceRealize parent_realize;
-    void (*parent_reset)(CPUState *cpu);
+    DeviceReset parent_reset;
 } MoxieCPUClass;
 
 /**
diff --git a/target/nios2/cpu.h b/target/nios2/cpu.h
index 78f633f9703..4dddf9c3a10 100644
--- a/target/nios2/cpu.h
+++ b/target/nios2/cpu.h
@@ -50,7 +50,7 @@ typedef struct Nios2CPUClass {
     /*< public >*/
 
     DeviceRealize parent_realize;
-    void (*parent_reset)(CPUState *cpu);
+    DeviceReset parent_reset;
 } Nios2CPUClass;
 
 #define TARGET_HAS_ICE 1
diff --git a/target/openrisc/cpu.h b/target/openrisc/cpu.h
index 0ad02eab794..e7fb06445eb 100644
--- a/target/openrisc/cpu.h
+++ b/target/openrisc/cpu.h
@@ -48,7 +48,7 @@ typedef struct OpenRISCCPUClass {
     /*< public >*/
 
     DeviceRealize parent_realize;
-    void (*parent_reset)(CPUState *cpu);
+    DeviceReset parent_reset;
 } OpenRISCCPUClass;
 
 #define TARGET_INSN_START_EXTRA_WORDS 1
diff --git a/target/ppc/cpu-qom.h b/target/ppc/cpu-qom.h
index e499575dc87..b5281317611 100644
--- a/target/ppc/cpu-qom.h
+++ b/target/ppc/cpu-qom.h
@@ -166,7 +166,7 @@ typedef struct PowerPCCPUClass {
 
     DeviceRealize parent_realize;
     DeviceUnrealize parent_unrealize;
-    void (*parent_reset)(CPUState *cpu);
+    DeviceReset parent_reset;
     void (*parent_parse_features)(const char *type, char *str, Error **errp);
 
     uint32_t pvr;
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index de0a8d893a3..10aabead499 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -185,7 +185,7 @@ typedef struct RISCVCPUClass {
     CPUClass parent_class;
     /*< public >*/
     DeviceRealize parent_realize;
-    void (*parent_reset)(CPUState *cpu);
+    DeviceReset parent_reset;
 } RISCVCPUClass;
 
 /**
diff --git a/target/s390x/cpu-qom.h b/target/s390x/cpu-qom.h
index dbe5346ec90..1630818c280 100644
--- a/target/s390x/cpu-qom.h
+++ b/target/s390x/cpu-qom.h
@@ -61,7 +61,7 @@ typedef struct S390CPUClass {
     const char *desc;
 
     DeviceRealize parent_realize;
-    void (*parent_reset)(CPUState *cpu);
+    DeviceReset parent_reset;
     void (*load_normal)(CPUState *cpu);
     void (*reset)(CPUState *cpu, cpu_reset_type type);
 } S390CPUClass;
diff --git a/target/sh4/cpu-qom.h b/target/sh4/cpu-qom.h
index 0c56d055bad..72a63f3fd3f 100644
--- a/target/sh4/cpu-qom.h
+++ b/target/sh4/cpu-qom.h
@@ -51,7 +51,7 @@ typedef struct SuperHCPUClass {
     /*< public >*/
 
     DeviceRealize parent_realize;
-    void (*parent_reset)(CPUState *cpu);
+    DeviceReset parent_reset;
 
     uint32_t pvr;
     uint32_t prr;
diff --git a/target/sparc/cpu-qom.h b/target/sparc/cpu-qom.h
index 7442e2768e8..8b4d33c21e5 100644
--- a/target/sparc/cpu-qom.h
+++ b/target/sparc/cpu-qom.h
@@ -49,7 +49,7 @@ typedef struct SPARCCPUClass {
     /*< public >*/
 
     DeviceRealize parent_realize;
-    void (*parent_reset)(CPUState *cpu);
+    DeviceReset parent_reset;
     sparc_def_t *cpu_def;
 } SPARCCPUClass;
 
diff --git a/target/tilegx/cpu.h b/target/tilegx/cpu.h
index 9cbec247d23..193b6bbccba 100644
--- a/target/tilegx/cpu.h
+++ b/target/tilegx/cpu.h
@@ -118,7 +118,7 @@ typedef struct TileGXCPUClass {
     /*< public >*/
 
     DeviceRealize parent_realize;
-    void (*parent_reset)(CPUState *cpu);
+    DeviceReset parent_reset;
 } TileGXCPUClass;
 
 /**
diff --git a/target/tricore/cpu-qom.h b/target/tricore/cpu-qom.h
index 7c1e130b4ed..cd819e6f240 100644
--- a/target/tricore/cpu-qom.h
+++ b/target/tricore/cpu-qom.h
@@ -36,7 +36,7 @@ typedef struct TriCoreCPUClass {
     /*< public >*/
 
     DeviceRealize parent_realize;
-    void (*parent_reset)(CPUState *cpu);
+    DeviceReset parent_reset;
 } TriCoreCPUClass;
 
 typedef struct TriCoreCPU TriCoreCPU;
diff --git a/target/xtensa/cpu-qom.h b/target/xtensa/cpu-qom.h
index 9ac54241bd6..3ea93ce1f93 100644
--- a/target/xtensa/cpu-qom.h
+++ b/target/xtensa/cpu-qom.h
@@ -56,7 +56,7 @@ typedef struct XtensaCPUClass {
     /*< public >*/
 
     DeviceRealize parent_realize;
-    void (*parent_reset)(CPUState *cpu);
+    DeviceReset parent_reset;
 
     const XtensaConfig *config;
 } XtensaCPUClass;
diff --git a/hw/core/cpu.c b/hw/core/cpu.c
index fe65ca62ace..b889878f3cc 100644
--- a/hw/core/cpu.c
+++ b/hw/core/cpu.c
@@ -239,27 +239,16 @@ void cpu_dump_statistics(CPUState *cpu, int flags)
     }
 }
 
-void cpu_class_set_parent_reset(CPUClass *cc,
-                                void (*child_reset)(CPUState *cpu),
-                                void (**parent_reset)(CPUState *cpu))
-{
-    *parent_reset = cc->reset;
-    cc->reset = child_reset;
-}
-
 void cpu_reset(CPUState *cpu)
 {
-    CPUClass *klass = CPU_GET_CLASS(cpu);
-
-    if (klass->reset != NULL) {
-        (*klass->reset)(cpu);
-    }
+    device_cold_reset(DEVICE(cpu));
 
     trace_guest_cpu_reset(cpu);
 }
 
-static void cpu_common_reset(CPUState *cpu)
+static void cpu_common_reset(DeviceState *dev)
 {
+    CPUState *cpu = CPU(dev);
     CPUClass *cc = CPU_GET_CLASS(cpu);
 
     if (qemu_loglevel_mask(CPU_LOG_RESET)) {
@@ -419,7 +408,6 @@ static void cpu_class_init(ObjectClass *klass, void *data)
     CPUClass *k = CPU_CLASS(klass);
 
     k->parse_features = cpu_common_parse_features;
-    k->reset = cpu_common_reset;
     k->get_arch_id = cpu_common_get_arch_id;
     k->has_work = cpu_common_has_work;
     k->get_paging_enabled = cpu_common_get_paging_enabled;
@@ -440,6 +428,7 @@ static void cpu_class_init(ObjectClass *klass, void *data)
     set_bit(DEVICE_CATEGORY_CPU, dc->categories);
     dc->realize = cpu_common_realizefn;
     dc->unrealize = cpu_common_unrealizefn;
+    dc->reset = cpu_common_reset;
     device_class_set_props(dc, cpu_common_props);
     /*
      * Reason: CPUs still need special care by board code: wiring up
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index e6016e33cec..56cd3d725b1 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -155,14 +155,14 @@ static void cp_reg_check_reset(gpointer key, gpointer value,  gpointer opaque)
     assert(oldvalue == newvalue);
 }
 
-/* CPUClass::reset() */
-static void arm_cpu_reset(CPUState *s)
+static void arm_cpu_reset(DeviceState *dev)
 {
+    CPUState *s = CPU(dev);
     ARMCPU *cpu = ARM_CPU(s);
     ARMCPUClass *acc = ARM_CPU_GET_CLASS(cpu);
     CPUARMState *env = &cpu->env;
 
-    acc->parent_reset(s);
+    acc->parent_reset(dev);
 
     memset(env, 0, offsetof(CPUARMState, end_reset_fields));
 
@@ -2804,7 +2804,7 @@ static void arm_cpu_class_init(ObjectClass *oc, void *data)
                                     &acc->parent_realize);
 
     device_class_set_props(dc, arm_cpu_properties);
-    cpu_class_set_parent_reset(cc, arm_cpu_reset, &acc->parent_reset);
+    device_class_set_parent_reset(dc, arm_cpu_reset, &acc->parent_reset);
 
     cc->class_by_name = arm_cpu_class_by_name;
     cc->has_work = arm_cpu_has_work;
diff --git a/target/cris/cpu.c b/target/cris/cpu.c
index 17c6712e298..cff6b9eabf6 100644
--- a/target/cris/cpu.c
+++ b/target/cris/cpu.c
@@ -40,15 +40,15 @@ static bool cris_cpu_has_work(CPUState *cs)
     return cs->interrupt_request & (CPU_INTERRUPT_HARD | CPU_INTERRUPT_NMI);
 }
 
-/* CPUClass::reset() */
-static void cris_cpu_reset(CPUState *s)
+static void cris_cpu_reset(DeviceState *dev)
 {
+    CPUState *s = CPU(dev);
     CRISCPU *cpu = CRIS_CPU(s);
     CRISCPUClass *ccc = CRIS_CPU_GET_CLASS(cpu);
     CPUCRISState *env = &cpu->env;
     uint32_t vr;
 
-    ccc->parent_reset(s);
+    ccc->parent_reset(dev);
 
     vr = env->pregs[PR_VR];
     memset(env, 0, offsetof(CPUCRISState, end_reset_fields));
@@ -264,7 +264,7 @@ static void cris_cpu_class_init(ObjectClass *oc, void *data)
     device_class_set_parent_realize(dc, cris_cpu_realizefn,
                                     &ccc->parent_realize);
 
-    cpu_class_set_parent_reset(cc, cris_cpu_reset, &ccc->parent_reset);
+    device_class_set_parent_reset(dc, cris_cpu_reset, &ccc->parent_reset);
 
     cc->class_by_name = cris_cpu_class_by_name;
     cc->has_work = cris_cpu_has_work;
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 92fafa26591..d18bf983237 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5855,9 +5855,9 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
     }
 }
 
-/* CPUClass::reset() */
-static void x86_cpu_reset(CPUState *s)
+static void x86_cpu_reset(DeviceState *dev)
 {
+    CPUState *s = CPU(dev);
     X86CPU *cpu = X86_CPU(s);
     X86CPUClass *xcc = X86_CPU_GET_CLASS(cpu);
     CPUX86State *env = &cpu->env;
@@ -5865,7 +5865,7 @@ static void x86_cpu_reset(CPUState *s)
     uint64_t xcr0;
     int i;
 
-    xcc->parent_reset(s);
+    xcc->parent_reset(dev);
 
     memset(env, 0, offsetof(CPUX86State, end_reset_fields));
 
@@ -7169,7 +7169,7 @@ static void x86_cpu_common_class_init(ObjectClass *oc, void *data)
                                       &xcc->parent_unrealize);
     device_class_set_props(dc, x86_cpu_properties);
 
-    cpu_class_set_parent_reset(cc, x86_cpu_reset, &xcc->parent_reset);
+    device_class_set_parent_reset(dc, x86_cpu_reset, &xcc->parent_reset);
     cc->reset_dump_flags = CPU_DUMP_FPU | CPU_DUMP_CCOP;
 
     cc->class_by_name = x86_cpu_class_by_name;
diff --git a/target/lm32/cpu.c b/target/lm32/cpu.c
index 687bf35e658..c50ad5fa15a 100644
--- a/target/lm32/cpu.c
+++ b/target/lm32/cpu.c
@@ -99,14 +99,14 @@ static bool lm32_cpu_has_work(CPUState *cs)
     return cs->interrupt_request & CPU_INTERRUPT_HARD;
 }
 
-/* CPUClass::reset() */
-static void lm32_cpu_reset(CPUState *s)
+static void lm32_cpu_reset(DeviceState *dev)
 {
+    CPUState *s = CPU(dev);
     LM32CPU *cpu = LM32_CPU(s);
     LM32CPUClass *lcc = LM32_CPU_GET_CLASS(cpu);
     CPULM32State *env = &cpu->env;
 
-    lcc->parent_reset(s);
+    lcc->parent_reset(dev);
 
     /* reset cpu state */
     memset(env, 0, offsetof(CPULM32State, end_reset_fields));
@@ -218,7 +218,7 @@ static void lm32_cpu_class_init(ObjectClass *oc, void *data)
 
     device_class_set_parent_realize(dc, lm32_cpu_realizefn,
                                     &lcc->parent_realize);
-    cpu_class_set_parent_reset(cc, lm32_cpu_reset, &lcc->parent_reset);
+    device_class_set_parent_reset(dc, lm32_cpu_reset, &lcc->parent_reset);
 
     cc->class_by_name = lm32_cpu_class_by_name;
     cc->has_work = lm32_cpu_has_work;
diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index f0653cda2ff..9445fcd6df5 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -41,16 +41,16 @@ static void m68k_set_feature(CPUM68KState *env, int feature)
     env->features |= (1u << feature);
 }
 
-/* CPUClass::reset() */
-static void m68k_cpu_reset(CPUState *s)
+static void m68k_cpu_reset(DeviceState *dev)
 {
+    CPUState *s = CPU(dev);
     M68kCPU *cpu = M68K_CPU(s);
     M68kCPUClass *mcc = M68K_CPU_GET_CLASS(cpu);
     CPUM68KState *env = &cpu->env;
     floatx80 nan = floatx80_default_nan(NULL);
     int i;
 
-    mcc->parent_reset(s);
+    mcc->parent_reset(dev);
 
     memset(env, 0, offsetof(CPUM68KState, end_reset_fields));
 #ifdef CONFIG_SOFTMMU
@@ -273,7 +273,7 @@ static void m68k_cpu_class_init(ObjectClass *c, void *data)
 
     device_class_set_parent_realize(dc, m68k_cpu_realizefn,
                                     &mcc->parent_realize);
-    cpu_class_set_parent_reset(cc, m68k_cpu_reset, &mcc->parent_reset);
+    device_class_set_parent_reset(dc, m68k_cpu_reset, &mcc->parent_reset);
 
     cc->class_by_name = m68k_cpu_class_by_name;
     cc->has_work = m68k_cpu_has_work;
diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index 8c90110e525..a2c2f271dfa 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -102,14 +102,14 @@ static void microblaze_cpu_set_irq(void *opaque, int irq, int level)
 }
 #endif
 
-/* CPUClass::reset() */
-static void mb_cpu_reset(CPUState *s)
+static void mb_cpu_reset(DeviceState *dev)
 {
+    CPUState *s = CPU(dev);
     MicroBlazeCPU *cpu = MICROBLAZE_CPU(s);
     MicroBlazeCPUClass *mcc = MICROBLAZE_CPU_GET_CLASS(cpu);
     CPUMBState *env = &cpu->env;
 
-    mcc->parent_reset(s);
+    mcc->parent_reset(dev);
 
     memset(env, 0, offsetof(CPUMBState, end_reset_fields));
     env->res_addr = RES_ADDR_NONE;
@@ -292,7 +292,7 @@ static void mb_cpu_class_init(ObjectClass *oc, void *data)
 
     device_class_set_parent_realize(dc, mb_cpu_realizefn,
                                     &mcc->parent_realize);
-    cpu_class_set_parent_reset(cc, mb_cpu_reset, &mcc->parent_reset);
+    device_class_set_parent_reset(dc, mb_cpu_reset, &mcc->parent_reset);
 
     cc->class_by_name = mb_cpu_class_by_name;
     cc->has_work = mb_cpu_has_work;
diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index 6cd6b9650ba..e86cd065483 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -96,14 +96,14 @@ static bool mips_cpu_has_work(CPUState *cs)
     return has_work;
 }
 
-/* CPUClass::reset() */
-static void mips_cpu_reset(CPUState *s)
+static void mips_cpu_reset(DeviceState *dev)
 {
+    CPUState *s = CPU(dev);
     MIPSCPU *cpu = MIPS_CPU(s);
     MIPSCPUClass *mcc = MIPS_CPU_GET_CLASS(cpu);
     CPUMIPSState *env = &cpu->env;
 
-    mcc->parent_reset(s);
+    mcc->parent_reset(dev);
 
     memset(env, 0, offsetof(CPUMIPSState, end_reset_fields));
 
@@ -189,7 +189,7 @@ static void mips_cpu_class_init(ObjectClass *c, void *data)
 
     device_class_set_parent_realize(dc, mips_cpu_realizefn,
                                     &mcc->parent_realize);
-    cpu_class_set_parent_reset(cc, mips_cpu_reset, &mcc->parent_reset);
+    device_class_set_parent_reset(dc, mips_cpu_reset, &mcc->parent_reset);
 
     cc->class_by_name = mips_cpu_class_by_name;
     cc->has_work = mips_cpu_has_work;
diff --git a/target/moxie/cpu.c b/target/moxie/cpu.c
index cf47bc709b5..6e0443ccb73 100644
--- a/target/moxie/cpu.c
+++ b/target/moxie/cpu.c
@@ -35,13 +35,14 @@ static bool moxie_cpu_has_work(CPUState *cs)
     return cs->interrupt_request & CPU_INTERRUPT_HARD;
 }
 
-static void moxie_cpu_reset(CPUState *s)
+static void moxie_cpu_reset(DeviceState *dev)
 {
+    CPUState *s = CPU(dev);
     MoxieCPU *cpu = MOXIE_CPU(s);
     MoxieCPUClass *mcc = MOXIE_CPU_GET_CLASS(cpu);
     CPUMoxieState *env = &cpu->env;
 
-    mcc->parent_reset(s);
+    mcc->parent_reset(dev);
 
     memset(env, 0, offsetof(CPUMoxieState, end_reset_fields));
     env->pc = 0x1000;
@@ -101,7 +102,7 @@ static void moxie_cpu_class_init(ObjectClass *oc, void *data)
 
     device_class_set_parent_realize(dc, moxie_cpu_realizefn,
                                     &mcc->parent_realize);
-    cpu_class_set_parent_reset(cc, moxie_cpu_reset, &mcc->parent_reset);
+    device_class_set_parent_reset(dc, moxie_cpu_reset, &mcc->parent_reset);
 
     cc->class_by_name = moxie_cpu_class_by_name;
 
diff --git a/target/nios2/cpu.c b/target/nios2/cpu.c
index 1c0c855a6f0..0a4075949e5 100644
--- a/target/nios2/cpu.c
+++ b/target/nios2/cpu.c
@@ -39,9 +39,9 @@ static bool nios2_cpu_has_work(CPUState *cs)
     return cs->interrupt_request & (CPU_INTERRUPT_HARD | CPU_INTERRUPT_NMI);
 }
 
-/* CPUClass::reset() */
-static void nios2_cpu_reset(CPUState *cs)
+static void nios2_cpu_reset(DeviceState *dev)
 {
+    CPUState *cs = CPU(dev);
     Nios2CPU *cpu = NIOS2_CPU(cs);
     Nios2CPUClass *ncc = NIOS2_CPU_GET_CLASS(cpu);
     CPUNios2State *env = &cpu->env;
@@ -51,7 +51,7 @@ static void nios2_cpu_reset(CPUState *cs)
         log_cpu_state(cs, 0);
     }
 
-    ncc->parent_reset(cs);
+    ncc->parent_reset(dev);
 
     memset(env->regs, 0, sizeof(uint32_t) * NUM_CORE_REGS);
     env->regs[R_PC] = cpu->reset_addr;
@@ -188,7 +188,7 @@ static void nios2_cpu_class_init(ObjectClass *oc, void *data)
     device_class_set_parent_realize(dc, nios2_cpu_realizefn,
                                     &ncc->parent_realize);
     device_class_set_props(dc, nios2_properties);
-    cpu_class_set_parent_reset(cc, nios2_cpu_reset, &ncc->parent_reset);
+    device_class_set_parent_reset(dc, nios2_cpu_reset, &ncc->parent_reset);
 
     cc->class_by_name = nios2_cpu_class_by_name;
     cc->has_work = nios2_cpu_has_work;
diff --git a/target/openrisc/cpu.c b/target/openrisc/cpu.c
index 5cd04dafab6..5528c0918f4 100644
--- a/target/openrisc/cpu.c
+++ b/target/openrisc/cpu.c
@@ -41,13 +41,13 @@ static void openrisc_disas_set_info(CPUState *cpu, disassemble_info *info)
     info->print_insn = print_insn_or1k;
 }
 
-/* CPUClass::reset() */
-static void openrisc_cpu_reset(CPUState *s)
+static void openrisc_cpu_reset(DeviceState *dev)
 {
+    CPUState *s = CPU(dev);
     OpenRISCCPU *cpu = OPENRISC_CPU(s);
     OpenRISCCPUClass *occ = OPENRISC_CPU_GET_CLASS(cpu);
 
-    occ->parent_reset(s);
+    occ->parent_reset(dev);
 
     memset(&cpu->env, 0, offsetof(CPUOpenRISCState, end_reset_fields));
 
@@ -150,7 +150,7 @@ static void openrisc_cpu_class_init(ObjectClass *oc, void *data)
 
     device_class_set_parent_realize(dc, openrisc_cpu_realizefn,
                                     &occ->parent_realize);
-    cpu_class_set_parent_reset(cc, openrisc_cpu_reset, &occ->parent_reset);
+    device_class_set_parent_reset(dc, openrisc_cpu_reset, &occ->parent_reset);
 
     cc->class_by_name = openrisc_cpu_class_by_name;
     cc->has_work = openrisc_cpu_has_work;
diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.inc.c
index 53995f62eab..7e9780e875c 100644
--- a/target/ppc/translate_init.inc.c
+++ b/target/ppc/translate_init.inc.c
@@ -10669,16 +10669,16 @@ static bool ppc_cpu_has_work(CPUState *cs)
     return msr_ee && (cs->interrupt_request & CPU_INTERRUPT_HARD);
 }
 
-/* CPUClass::reset() */
-static void ppc_cpu_reset(CPUState *s)
+static void ppc_cpu_reset(DeviceState *dev)
 {
+    CPUState *s = CPU(dev);
     PowerPCCPU *cpu = POWERPC_CPU(s);
     PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
     CPUPPCState *env = &cpu->env;
     target_ulong msr;
     int i;
 
-    pcc->parent_reset(s);
+    pcc->parent_reset(dev);
 
     msr = (target_ulong)0;
     msr |= (target_ulong)MSR_HVB;
@@ -10885,7 +10885,7 @@ static void ppc_cpu_class_init(ObjectClass *oc, void *data)
     pcc->interrupts_big_endian = ppc_cpu_interrupts_big_endian_always;
     device_class_set_props(dc, ppc_cpu_properties);
 
-    cpu_class_set_parent_reset(cc, ppc_cpu_reset, &pcc->parent_reset);
+    device_class_set_parent_reset(dc, ppc_cpu_reset, &pcc->parent_reset);
 
     cc->class_by_name = ppc_cpu_class_by_name;
     pcc->parent_parse_features = cc->parse_features;
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 8c86ebc1093..e2ccd820736 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -286,13 +286,14 @@ void restore_state_to_opc(CPURISCVState *env, TranslationBlock *tb,
     env->pc = data[0];
 }
 
-static void riscv_cpu_reset(CPUState *cs)
+static void riscv_cpu_reset(DeviceState *dev)
 {
+    CPUState *cs = CPU(dev);
     RISCVCPU *cpu = RISCV_CPU(cs);
     RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(cpu);
     CPURISCVState *env = &cpu->env;
 
-    mcc->parent_reset(cs);
+    mcc->parent_reset(dev);
 #ifndef CONFIG_USER_ONLY
     env->priv = PRV_M;
     env->mstatus &= ~(MSTATUS_MIE | MSTATUS_MPRV);
@@ -462,7 +463,7 @@ static void riscv_cpu_class_init(ObjectClass *c, void *data)
     device_class_set_parent_realize(dc, riscv_cpu_realize,
                                     &mcc->parent_realize);
 
-    cpu_class_set_parent_reset(cc, riscv_cpu_reset, &mcc->parent_reset);
+    device_class_set_parent_reset(dc, riscv_cpu_reset, &mcc->parent_reset);
 
     cc->class_by_name = riscv_cpu_class_by_name;
     cc->has_work = riscv_cpu_has_work;
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 3dd396e8703..427a46e3e1b 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -96,8 +96,9 @@ static void s390_cpu_reset(CPUState *s, cpu_reset_type type)
     S390CPU *cpu = S390_CPU(s);
     S390CPUClass *scc = S390_CPU_GET_CLASS(cpu);
     CPUS390XState *env = &cpu->env;
+    DeviceState *dev = DEVICE(s);
 
-    scc->parent_reset(s);
+    scc->parent_reset(dev);
     cpu->env.sigp_order = 0;
     s390_cpu_set_state(S390_CPU_STATE_STOPPED, cpu);
 
@@ -450,8 +451,9 @@ static Property s390x_cpu_properties[] = {
     DEFINE_PROP_END_OF_LIST()
 };
 
-static void s390_cpu_reset_full(CPUState *s)
+static void s390_cpu_reset_full(DeviceState *dev)
 {
+    CPUState *s = CPU(dev);
     return s390_cpu_reset(s, S390_CPU_RESET_CLEAR);
 }
 
@@ -466,7 +468,7 @@ static void s390_cpu_class_init(ObjectClass *oc, void *data)
     device_class_set_props(dc, s390x_cpu_properties);
     dc->user_creatable = true;
 
-    cpu_class_set_parent_reset(cc, s390_cpu_reset_full, &scc->parent_reset);
+    device_class_set_parent_reset(dc, s390_cpu_reset_full, &scc->parent_reset);
 #if !defined(CONFIG_USER_ONLY)
     scc->load_normal = s390_cpu_load_normal;
 #endif
diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
index 70c8d8170ff..3c68021c565 100644
--- a/target/sh4/cpu.c
+++ b/target/sh4/cpu.c
@@ -47,14 +47,14 @@ static bool superh_cpu_has_work(CPUState *cs)
     return cs->interrupt_request & CPU_INTERRUPT_HARD;
 }
 
-/* CPUClass::reset() */
-static void superh_cpu_reset(CPUState *s)
+static void superh_cpu_reset(DeviceState *dev)
 {
+    CPUState *s = CPU(dev);
     SuperHCPU *cpu = SUPERH_CPU(s);
     SuperHCPUClass *scc = SUPERH_CPU_GET_CLASS(cpu);
     CPUSH4State *env = &cpu->env;
 
-    scc->parent_reset(s);
+    scc->parent_reset(dev);
 
     memset(env, 0, offsetof(CPUSH4State, end_reset_fields));
 
@@ -214,7 +214,7 @@ static void superh_cpu_class_init(ObjectClass *oc, void *data)
     device_class_set_parent_realize(dc, superh_cpu_realizefn,
                                     &scc->parent_realize);
 
-    cpu_class_set_parent_reset(cc, superh_cpu_reset, &scc->parent_reset);
+    device_class_set_parent_reset(dc, superh_cpu_reset, &scc->parent_reset);
 
     cc->class_by_name = superh_cpu_class_by_name;
     cc->has_work = superh_cpu_has_work;
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index eeaecbd8d69..3f05aba9d66 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -28,14 +28,14 @@
 
 //#define DEBUG_FEATURES
 
-/* CPUClass::reset() */
-static void sparc_cpu_reset(CPUState *s)
+static void sparc_cpu_reset(DeviceState *dev)
 {
+    CPUState *s = CPU(dev);
     SPARCCPU *cpu = SPARC_CPU(s);
     SPARCCPUClass *scc = SPARC_CPU_GET_CLASS(cpu);
     CPUSPARCState *env = &cpu->env;
 
-    scc->parent_reset(s);
+    scc->parent_reset(dev);
 
     memset(env, 0, offsetof(CPUSPARCState, end_reset_fields));
     env->cwp = 0;
@@ -859,7 +859,7 @@ static void sparc_cpu_class_init(ObjectClass *oc, void *data)
                                     &scc->parent_realize);
     device_class_set_props(dc, sparc_cpu_properties);
 
-    cpu_class_set_parent_reset(cc, sparc_cpu_reset, &scc->parent_reset);
+    device_class_set_parent_reset(dc, sparc_cpu_reset, &scc->parent_reset);
 
     cc->class_by_name = sparc_cpu_class_by_name;
     cc->parse_features = sparc_cpu_parse_features;
diff --git a/target/tilegx/cpu.c b/target/tilegx/cpu.c
index cd422a0467a..1fee87c094b 100644
--- a/target/tilegx/cpu.c
+++ b/target/tilegx/cpu.c
@@ -68,13 +68,14 @@ static bool tilegx_cpu_has_work(CPUState *cs)
     return true;
 }
 
-static void tilegx_cpu_reset(CPUState *s)
+static void tilegx_cpu_reset(DeviceState *dev)
 {
+    CPUState *s = CPU(dev);
     TileGXCPU *cpu = TILEGX_CPU(s);
     TileGXCPUClass *tcc = TILEGX_CPU_GET_CLASS(cpu);
     CPUTLGState *env = &cpu->env;
 
-    tcc->parent_reset(s);
+    tcc->parent_reset(dev);
 
     memset(env, 0, offsetof(CPUTLGState, end_reset_fields));
 }
@@ -142,7 +143,7 @@ static void tilegx_cpu_class_init(ObjectClass *oc, void *data)
     device_class_set_parent_realize(dc, tilegx_cpu_realizefn,
                                     &tcc->parent_realize);
 
-    cpu_class_set_parent_reset(cc, tilegx_cpu_reset, &tcc->parent_reset);
+    device_class_set_parent_reset(dc, tilegx_cpu_reset, &tcc->parent_reset);
 
     cc->class_by_name = tilegx_cpu_class_by_name;
     cc->has_work = tilegx_cpu_has_work;
diff --git a/target/tricore/cpu.c b/target/tricore/cpu.c
index 85bc9f03a1e..743b404a95a 100644
--- a/target/tricore/cpu.c
+++ b/target/tricore/cpu.c
@@ -53,13 +53,14 @@ static void tricore_cpu_synchronize_from_tb(CPUState *cs,
     env->PC = tb->pc;
 }
 
-static void tricore_cpu_reset(CPUState *s)
+static void tricore_cpu_reset(DeviceState *dev)
 {
+    CPUState *s = CPU(dev);
     TriCoreCPU *cpu = TRICORE_CPU(s);
     TriCoreCPUClass *tcc = TRICORE_CPU_GET_CLASS(cpu);
     CPUTriCoreState *env = &cpu->env;
 
-    tcc->parent_reset(s);
+    tcc->parent_reset(dev);
 
     cpu_state_reset(env);
 }
@@ -153,7 +154,7 @@ static void tricore_cpu_class_init(ObjectClass *c, void *data)
     device_class_set_parent_realize(dc, tricore_cpu_realizefn,
                                     &mcc->parent_realize);
 
-    cpu_class_set_parent_reset(cc, tricore_cpu_reset, &mcc->parent_reset);
+    device_class_set_parent_reset(dc, tricore_cpu_reset, &mcc->parent_reset);
     cc->class_by_name = tricore_cpu_class_by_name;
     cc->has_work = tricore_cpu_has_work;
 
diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index 4856aee8eca..82c2ee0679f 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -67,14 +67,14 @@ bool xtensa_abi_call0(void)
 }
 #endif
 
-/* CPUClass::reset() */
-static void xtensa_cpu_reset(CPUState *s)
+static void xtensa_cpu_reset(DeviceState *dev)
 {
+    CPUState *s = CPU(dev);
     XtensaCPU *cpu = XTENSA_CPU(s);
     XtensaCPUClass *xcc = XTENSA_CPU_GET_CLASS(cpu);
     CPUXtensaState *env = &cpu->env;
 
-    xcc->parent_reset(s);
+    xcc->parent_reset(dev);
 
     env->exception_taken = 0;
     env->pc = env->config->exception_vector[EXC_RESET0 + env->static_vectors];
@@ -184,7 +184,7 @@ static void xtensa_cpu_class_init(ObjectClass *oc, void *data)
     device_class_set_parent_realize(dc, xtensa_cpu_realizefn,
                                     &xcc->parent_realize);
 
-    cpu_class_set_parent_reset(cc, xtensa_cpu_reset, &xcc->parent_reset);
+    device_class_set_parent_reset(dc, xtensa_cpu_reset, &xcc->parent_reset);
 
     cc->class_by_name = xtensa_cpu_class_by_name;
     cc->has_work = xtensa_cpu_has_work;
diff --git a/scripts/coccinelle/cpu-reset.cocci b/scripts/coccinelle/cpu-reset.cocci
new file mode 100644
index 00000000000..396a724e514
--- /dev/null
+++ b/scripts/coccinelle/cpu-reset.cocci
@@ -0,0 +1,47 @@
+// Convert targets using the old CPUState reset to DeviceState reset
+//
+// Copyright Linaro Ltd 2020
+// This work is licensed under the terms of the GNU GPLv2 or later.
+//
+// spatch --macro-file scripts/cocci-macro-file.h \
+//        --sp-file scripts/coccinelle/cpu-reset.cocci \
+//        --keep-comments --smpl-spacing --in-place --include-headers --dir target
+//
+// For simplicity we assume some things about the code we're modifying
+// that happen to be true for all our targets:
+//  * all cpu_class_set_parent_reset() callsites have a 'DeviceClass *dc' local
+//  * the parent reset field in the target CPU class is 'parent_reset'
+//  * no reset function already has a 'dev' local
+
+@@
+identifier cpu, x;
+typedef CPUState;
+@@
+struct x {
+...
+- void (*parent_reset)(CPUState *cpu);
++ DeviceReset parent_reset;
+...
+};
+@ rule1 @
+identifier resetfn;
+expression resetfield;
+identifier cc;
+@@
+- cpu_class_set_parent_reset(cc, resetfn, resetfield)
++ device_class_set_parent_reset(dc, resetfn, resetfield)
+@@
+identifier rule1.resetfn;
+identifier cpu, cc;
+typedef CPUState, DeviceState;
+@@
+-resetfn(CPUState *cpu)
+-{
++resetfn(DeviceState *dev)
++{
++    CPUState *cpu = CPU(dev);
+<...
+-    cc->parent_reset(cpu);
++    cc->parent_reset(dev);
+...>
+}
-- 
2.20.1


