Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D621C04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 21:04:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01AC120879
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 21:04:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hoyk/kO4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01AC120879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54130 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQebN-0003rW-9f
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 17:04:45 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38994)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1hQeV4-0007lR-RW
	for qemu-devel@nongnu.org; Tue, 14 May 2019 16:58:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1hQeIU-0007CE-NK
	for qemu-devel@nongnu.org; Tue, 14 May 2019 16:45:23 -0400
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143]:35270)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1hQeIT-00076T-Gm
	for qemu-devel@nongnu.org; Tue, 14 May 2019 16:45:14 -0400
Received: by mail-lf1-x143.google.com with SMTP id c17so261258lfi.2
	for <qemu-devel@nongnu.org>; Tue, 14 May 2019 13:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=IkhMNMK+Km3YXVzPE7/k37mvtEbVmKcfhC7w5xerFoU=;
	b=hoyk/kO4WdlEEGBdC2efMClje89uRLZpTuT557KXH54GCdPu0jGzwNwmDs1P03IdN8
	+UZgoTnAwRF7aD+CiGGwfZ76szH8iP/rn+jv2C2KzfF09aQLvxuy2pn+MHwGsq191PeE
	QQznMdwWEOrnjN2TLARcpGrSrlkC4Lwx+xXWVItBHrejzIex+i3AoTlPbolc8prD7dBa
	Pkt5NCgy9jSJVfqwvMLQoejB8eBKuZmp8JVmsv/CBJtm2mBLjhhmm+aG82f/XC60O9ei
	br9eH9ZmjNckWcZRbtnoDZMDu+QkGS3769z9EZfyT7IMnDvO1G8n5l48ACb2CLS942V0
	EZow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=IkhMNMK+Km3YXVzPE7/k37mvtEbVmKcfhC7w5xerFoU=;
	b=J2YBpBFTL/FK7MJbnNBLvj0kjLBfY4nNcG0ARxJK6D15+ziK3CGJ3MUBsPwb1IWapi
	I4DePkPvpL6iPWB0twJcXZCp08/oDD42opXoiPqXTn49CgRKP5vRxzHil+DDzU8O3uIY
	uizTMy7xhb7MSRlbAfW4VPv8rBcc2RmtHdjM/f9EDmVZ0ghnYtS3KJdpWsAyHCBfNVer
	egQwslZGITFFC1aDZeDcNCFMJ0lLb8dysmMCWcjbEXWBez95sYUn3lkezvlPREQLbJlC
	1DyIgVsqWRa5IxaKBQNs3wdVxct0d35JHZGvzx9IjvhHtfsuNocSdH3GYOwQiN28f3Rz
	0GrA==
X-Gm-Message-State: APjAAAUpc9/XWf9Squi6wduM4n1ZQuKKoXg8+5fSziEsrdoo71qhEAZt
	lOOD7CmcHRjjVk0wF/k1gOdXkSEPwao=
X-Google-Smtp-Source: APXvYqxAbZNtI8Dgjg5I3ZCG9bzZfY/9hlV+IrW+ZswQ6db8g6mXYUqyp3eKvzKf0wkbUkQm8ke3Ww==
X-Received: by 2002:ac2:510b:: with SMTP id q11mr16237325lfb.11.1557866710260; 
	Tue, 14 May 2019 13:45:10 -0700 (PDT)
Received: from octofox.cadence.com
	(jcmvbkbc-1-pt.tunnel.tserv24.sto1.ipv6.he.net. [2001:470:27:1fa::2])
	by smtp.gmail.com with ESMTPSA id 78sm4011lje.81.2019.05.14.13.45.07
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 14 May 2019 13:45:09 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
To: qemu-devel@nongnu.org
Date: Tue, 14 May 2019 13:44:39 -0700
Message-Id: <20190514204447.17486-2-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190514204447.17486-1-jcmvbkbc@gmail.com>
References: <20190514204447.17486-1-jcmvbkbc@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::143
Subject: [Qemu-devel] [PATCH 1/9] target/xtensa: get rid of centralized SR
 properties
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
Cc: Max Filippov <jcmvbkbc@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SR numbers are not unique: different Xtensa options may reuse SR number
for different purposes. Introduce generic rsr/wsr functions and xsr
template and use them instead of centralized SR access functions. Change
prototypes of specific rsr/wsr functions to match XtensaOpcodeOp and use
them instead of centralized SR access functions. Put xtensa option that
introduces SR into the second opcode description parameter and use it to
test for rsr/wsr/xsr opcode validity. Extract SR and UR names for the
xtensa_cpu_dump_state from libisa. Merge SRs and URs in the dump.
Register names of used SR/UR in init_libisa and use these names for TCG
globals referencing these SR/UR.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 target/xtensa/cpu.h       |    1 +
 target/xtensa/helper.c    |    1 +
 target/xtensa/translate.c | 2503 +++++++++++++++++++++++++++------------------
 3 files changed, 1492 insertions(+), 1013 deletions(-)

diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index 5d23e1345be5..539033fccb61 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -589,6 +589,7 @@ void xtensa_cpu_do_unaligned_access(CPUState *cpu, vaddr addr,
 #define XTENSA_DEFAULT_CPU_NOMMU_TYPE \
     XTENSA_CPU_TYPE_NAME(XTENSA_DEFAULT_CPU_NOMMU_MODEL)
 
+void xtensa_collect_sr_names(const XtensaConfig *config);
 void xtensa_translate_init(void);
 void **xtensa_get_regfile_by_name(const char *name);
 void xtensa_breakpoint_handler(CPUState *cs);
diff --git a/target/xtensa/helper.c b/target/xtensa/helper.c
index 5f37f378a311..ed0108a81209 100644
--- a/target/xtensa/helper.c
+++ b/target/xtensa/helper.c
@@ -141,6 +141,7 @@ static void init_libisa(XtensaConfig *config)
         }
 #endif
     }
+    xtensa_collect_sr_names(config);
 }
 
 static void xtensa_finalize_config(XtensaConfig *config)
diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index 301c8e31613c..100d6e126590 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -92,128 +92,40 @@ static GHashTable *xtensa_regfile_table;
 
 #include "exec/gen-icount.h"
 
-typedef struct XtensaReg {
-    const char *name;
-    uint64_t opt_bits;
-    enum {
-        SR_R = 1,
-        SR_W = 2,
-        SR_X = 4,
-        SR_RW = 3,
-        SR_RWX = 7,
-    } access;
-} XtensaReg;
-
-#define XTENSA_REG_ACCESS(regname, opt, acc) { \
-        .name = (regname), \
-        .opt_bits = XTENSA_OPTION_BIT(opt), \
-        .access = (acc), \
-    }
+static char *sr_name[256];
+static char *ur_name[256];
 
-#define XTENSA_REG(regname, opt) XTENSA_REG_ACCESS(regname, opt, SR_RWX)
+void xtensa_collect_sr_names(const XtensaConfig *config)
+{
+    xtensa_isa isa = config->isa;
+    int n = xtensa_isa_num_sysregs(isa);
+    int i;
 
-#define XTENSA_REG_BITS_ACCESS(regname, opt, acc) { \
-        .name = (regname), \
-        .opt_bits = (opt), \
-        .access = (acc), \
+    for (i = 0; i < n; ++i) {
+        int sr = xtensa_sysreg_number(isa, i);
+
+        if (sr >= 0 && sr < 256) {
+            const char *name = xtensa_sysreg_name(isa, i);
+            char **pname =
+                (xtensa_sysreg_is_user(isa, i) ? ur_name : sr_name) + sr;
+
+            if (*pname) {
+                if (strstr(*pname, name) == NULL) {
+                    char *new_name =
+                        malloc(strlen(*pname) + strlen(name) + 2);
+
+                    strcpy(new_name, *pname);
+                    strcat(new_name, "/");
+                    strcat(new_name, name);
+                    free(*pname);
+                    *pname = new_name;
+                }
+            } else {
+                *pname = strdup(name);
+            }
+        }
     }
-
-#define XTENSA_REG_BITS(regname, opt) \
-    XTENSA_REG_BITS_ACCESS(regname, opt, SR_RWX)
-
-static const XtensaReg sregnames[256] = {
-    [LBEG] = XTENSA_REG("LBEG", XTENSA_OPTION_LOOP),
-    [LEND] = XTENSA_REG("LEND", XTENSA_OPTION_LOOP),
-    [LCOUNT] = XTENSA_REG("LCOUNT", XTENSA_OPTION_LOOP),
-    [SAR] = XTENSA_REG_BITS("SAR", XTENSA_OPTION_ALL),
-    [BR] = XTENSA_REG("BR", XTENSA_OPTION_BOOLEAN),
-    [LITBASE] = XTENSA_REG("LITBASE", XTENSA_OPTION_EXTENDED_L32R),
-    [SCOMPARE1] = XTENSA_REG("SCOMPARE1", XTENSA_OPTION_CONDITIONAL_STORE),
-    [ACCLO] = XTENSA_REG("ACCLO", XTENSA_OPTION_MAC16),
-    [ACCHI] = XTENSA_REG("ACCHI", XTENSA_OPTION_MAC16),
-    [MR] = XTENSA_REG("MR0", XTENSA_OPTION_MAC16),
-    [MR + 1] = XTENSA_REG("MR1", XTENSA_OPTION_MAC16),
-    [MR + 2] = XTENSA_REG("MR2", XTENSA_OPTION_MAC16),
-    [MR + 3] = XTENSA_REG("MR3", XTENSA_OPTION_MAC16),
-    [PREFCTL] = XTENSA_REG_BITS("PREFCTL", XTENSA_OPTION_ALL),
-    [WINDOW_BASE] = XTENSA_REG("WINDOW_BASE", XTENSA_OPTION_WINDOWED_REGISTER),
-    [WINDOW_START] = XTENSA_REG("WINDOW_START",
-            XTENSA_OPTION_WINDOWED_REGISTER),
-    [PTEVADDR] = XTENSA_REG("PTEVADDR", XTENSA_OPTION_MMU),
-    [MMID] = XTENSA_REG_BITS("MMID", XTENSA_OPTION_ALL),
-    [RASID] = XTENSA_REG("RASID", XTENSA_OPTION_MMU),
-    [ITLBCFG] = XTENSA_REG("ITLBCFG", XTENSA_OPTION_MMU),
-    [DTLBCFG] = XTENSA_REG("DTLBCFG", XTENSA_OPTION_MMU),
-    [IBREAKENABLE] = XTENSA_REG("IBREAKENABLE", XTENSA_OPTION_DEBUG),
-    [MEMCTL] = XTENSA_REG_BITS("MEMCTL", XTENSA_OPTION_ALL),
-    [CACHEATTR] = XTENSA_REG("CACHEATTR", XTENSA_OPTION_CACHEATTR),
-    [ATOMCTL] = XTENSA_REG("ATOMCTL", XTENSA_OPTION_ATOMCTL),
-    [DDR] = XTENSA_REG("DDR", XTENSA_OPTION_DEBUG),
-    [IBREAKA] = XTENSA_REG("IBREAKA0", XTENSA_OPTION_DEBUG),
-    [IBREAKA + 1] = XTENSA_REG("IBREAKA1", XTENSA_OPTION_DEBUG),
-    [DBREAKA] = XTENSA_REG("DBREAKA0", XTENSA_OPTION_DEBUG),
-    [DBREAKA + 1] = XTENSA_REG("DBREAKA1", XTENSA_OPTION_DEBUG),
-    [DBREAKC] = XTENSA_REG("DBREAKC0", XTENSA_OPTION_DEBUG),
-    [DBREAKC + 1] = XTENSA_REG("DBREAKC1", XTENSA_OPTION_DEBUG),
-    [CONFIGID0] = XTENSA_REG_BITS_ACCESS("CONFIGID0", XTENSA_OPTION_ALL, SR_R),
-    [EPC1] = XTENSA_REG("EPC1", XTENSA_OPTION_EXCEPTION),
-    [EPC1 + 1] = XTENSA_REG("EPC2", XTENSA_OPTION_HIGH_PRIORITY_INTERRUPT),
-    [EPC1 + 2] = XTENSA_REG("EPC3", XTENSA_OPTION_HIGH_PRIORITY_INTERRUPT),
-    [EPC1 + 3] = XTENSA_REG("EPC4", XTENSA_OPTION_HIGH_PRIORITY_INTERRUPT),
-    [EPC1 + 4] = XTENSA_REG("EPC5", XTENSA_OPTION_HIGH_PRIORITY_INTERRUPT),
-    [EPC1 + 5] = XTENSA_REG("EPC6", XTENSA_OPTION_HIGH_PRIORITY_INTERRUPT),
-    [EPC1 + 6] = XTENSA_REG("EPC7", XTENSA_OPTION_HIGH_PRIORITY_INTERRUPT),
-    [DEPC] = XTENSA_REG("DEPC", XTENSA_OPTION_EXCEPTION),
-    [EPS2] = XTENSA_REG("EPS2", XTENSA_OPTION_HIGH_PRIORITY_INTERRUPT),
-    [EPS2 + 1] = XTENSA_REG("EPS3", XTENSA_OPTION_HIGH_PRIORITY_INTERRUPT),
-    [EPS2 + 2] = XTENSA_REG("EPS4", XTENSA_OPTION_HIGH_PRIORITY_INTERRUPT),
-    [EPS2 + 3] = XTENSA_REG("EPS5", XTENSA_OPTION_HIGH_PRIORITY_INTERRUPT),
-    [EPS2 + 4] = XTENSA_REG("EPS6", XTENSA_OPTION_HIGH_PRIORITY_INTERRUPT),
-    [EPS2 + 5] = XTENSA_REG("EPS7", XTENSA_OPTION_HIGH_PRIORITY_INTERRUPT),
-    [CONFIGID1] = XTENSA_REG_BITS_ACCESS("CONFIGID1", XTENSA_OPTION_ALL, SR_R),
-    [EXCSAVE1] = XTENSA_REG("EXCSAVE1", XTENSA_OPTION_EXCEPTION),
-    [EXCSAVE1 + 1] = XTENSA_REG("EXCSAVE2",
-            XTENSA_OPTION_HIGH_PRIORITY_INTERRUPT),
-    [EXCSAVE1 + 2] = XTENSA_REG("EXCSAVE3",
-            XTENSA_OPTION_HIGH_PRIORITY_INTERRUPT),
-    [EXCSAVE1 + 3] = XTENSA_REG("EXCSAVE4",
-            XTENSA_OPTION_HIGH_PRIORITY_INTERRUPT),
-    [EXCSAVE1 + 4] = XTENSA_REG("EXCSAVE5",
-            XTENSA_OPTION_HIGH_PRIORITY_INTERRUPT),
-    [EXCSAVE1 + 5] = XTENSA_REG("EXCSAVE6",
-            XTENSA_OPTION_HIGH_PRIORITY_INTERRUPT),
-    [EXCSAVE1 + 6] = XTENSA_REG("EXCSAVE7",
-            XTENSA_OPTION_HIGH_PRIORITY_INTERRUPT),
-    [CPENABLE] = XTENSA_REG("CPENABLE", XTENSA_OPTION_COPROCESSOR),
-    [INTSET] = XTENSA_REG_ACCESS("INTSET", XTENSA_OPTION_INTERRUPT, SR_RW),
-    [INTCLEAR] = XTENSA_REG_ACCESS("INTCLEAR", XTENSA_OPTION_INTERRUPT, SR_W),
-    [INTENABLE] = XTENSA_REG("INTENABLE", XTENSA_OPTION_INTERRUPT),
-    [PS] = XTENSA_REG_BITS("PS", XTENSA_OPTION_ALL),
-    [VECBASE] = XTENSA_REG("VECBASE", XTENSA_OPTION_RELOCATABLE_VECTOR),
-    [EXCCAUSE] = XTENSA_REG("EXCCAUSE", XTENSA_OPTION_EXCEPTION),
-    [DEBUGCAUSE] = XTENSA_REG_ACCESS("DEBUGCAUSE", XTENSA_OPTION_DEBUG, SR_R),
-    [CCOUNT] = XTENSA_REG("CCOUNT", XTENSA_OPTION_TIMER_INTERRUPT),
-    [PRID] = XTENSA_REG_ACCESS("PRID", XTENSA_OPTION_PROCESSOR_ID, SR_R),
-    [ICOUNT] = XTENSA_REG("ICOUNT", XTENSA_OPTION_DEBUG),
-    [ICOUNTLEVEL] = XTENSA_REG("ICOUNTLEVEL", XTENSA_OPTION_DEBUG),
-    [EXCVADDR] = XTENSA_REG("EXCVADDR", XTENSA_OPTION_EXCEPTION),
-    [CCOMPARE] = XTENSA_REG("CCOMPARE0", XTENSA_OPTION_TIMER_INTERRUPT),
-    [CCOMPARE + 1] = XTENSA_REG("CCOMPARE1",
-            XTENSA_OPTION_TIMER_INTERRUPT),
-    [CCOMPARE + 2] = XTENSA_REG("CCOMPARE2",
-            XTENSA_OPTION_TIMER_INTERRUPT),
-    [MISC] = XTENSA_REG("MISC0", XTENSA_OPTION_MISC_SR),
-    [MISC + 1] = XTENSA_REG("MISC1", XTENSA_OPTION_MISC_SR),
-    [MISC + 2] = XTENSA_REG("MISC2", XTENSA_OPTION_MISC_SR),
-    [MISC + 3] = XTENSA_REG("MISC3", XTENSA_OPTION_MISC_SR),
-};
-
-static const XtensaReg uregnames[256] = {
-    [EXPSTATE] = XTENSA_REG_BITS("EXPSTATE", XTENSA_OPTION_ALL),
-    [THREADPTR] = XTENSA_REG("THREADPTR", XTENSA_OPTION_THREAD_POINTER),
-    [FCR] = XTENSA_REG("FCR", XTENSA_OPTION_FP_COPROCESSOR),
-    [FSR] = XTENSA_REG("FSR", XTENSA_OPTION_FP_COPROCESSOR),
-};
+}
 
 void xtensa_translate_init(void)
 {
@@ -283,18 +195,20 @@ void xtensa_translate_init(void)
     }
 
     for (i = 0; i < 256; ++i) {
-        if (sregnames[i].name) {
+        if (sr_name[i]) {
             cpu_SR[i] = tcg_global_mem_new_i32(cpu_env,
-                    offsetof(CPUXtensaState, sregs[i]),
-                    sregnames[i].name);
+                                               offsetof(CPUXtensaState,
+                                                        sregs[i]),
+                                               sr_name[i]);
         }
     }
 
     for (i = 0; i < 256; ++i) {
-        if (uregnames[i].name) {
+        if (ur_name[i]) {
             cpu_UR[i] = tcg_global_mem_new_i32(cpu_env,
-                    offsetof(CPUXtensaState, uregs[i]),
-                    uregnames[i].name);
+                                               offsetof(CPUXtensaState,
+                                                        uregs[i]),
+                                               ur_name[i]);
         }
     }
 
@@ -536,313 +450,57 @@ static void gen_brcondi(DisasContext *dc, TCGCond cond,
     tcg_temp_free(tmp);
 }
 
-static bool check_sr(DisasContext *dc, uint32_t sr, unsigned access)
-{
-    if (!xtensa_option_bits_enabled(dc->config, sregnames[sr].opt_bits)) {
-        if (sregnames[sr].name) {
-            qemu_log_mask(LOG_GUEST_ERROR, "SR %s is not configured\n", sregnames[sr].name);
-        } else {
-            qemu_log_mask(LOG_UNIMP, "SR %d is not implemented\n", sr);
-        }
-        return false;
-    } else if (!(sregnames[sr].access & access)) {
-        static const char * const access_text[] = {
-            [SR_R] = "rsr",
-            [SR_W] = "wsr",
-            [SR_X] = "xsr",
-        };
-        assert(access < ARRAY_SIZE(access_text) && access_text[access]);
-        qemu_log_mask(LOG_GUEST_ERROR, "SR %s is not available for %s\n", sregnames[sr].name,
-                      access_text[access]);
-        return false;
-    }
-    return true;
-}
-
-#ifndef CONFIG_USER_ONLY
-static void gen_rsr_ccount(DisasContext *dc, TCGv_i32 d, uint32_t sr)
-{
-    if (tb_cflags(dc->base.tb) & CF_USE_ICOUNT) {
-        gen_io_start();
-    }
-    gen_helper_update_ccount(cpu_env);
-    tcg_gen_mov_i32(d, cpu_SR[sr]);
-    if (tb_cflags(dc->base.tb) & CF_USE_ICOUNT) {
-        gen_io_end();
-    }
-}
-
-static void gen_rsr_ptevaddr(DisasContext *dc, TCGv_i32 d, uint32_t sr)
-{
-    tcg_gen_shri_i32(d, cpu_SR[EXCVADDR], 10);
-    tcg_gen_or_i32(d, d, cpu_SR[sr]);
-    tcg_gen_andi_i32(d, d, 0xfffffffc);
-}
-#endif
-
-static void gen_rsr(DisasContext *dc, TCGv_i32 d, uint32_t sr)
-{
-    static void (* const rsr_handler[256])(DisasContext *dc,
-                                           TCGv_i32 d, uint32_t sr) = {
-#ifndef CONFIG_USER_ONLY
-        [CCOUNT] = gen_rsr_ccount,
-        [INTSET] = gen_rsr_ccount,
-        [PTEVADDR] = gen_rsr_ptevaddr,
-#endif
-    };
-
-    if (rsr_handler[sr]) {
-        rsr_handler[sr](dc, d, sr);
-    } else {
-        tcg_gen_mov_i32(d, cpu_SR[sr]);
-    }
-}
-
-static void gen_wsr_sar(DisasContext *dc, uint32_t sr, TCGv_i32 s)
-{
-    tcg_gen_andi_i32(cpu_SR[sr], s, 0x3f);
-    if (dc->sar_m32_5bit) {
-        tcg_gen_discard_i32(dc->sar_m32);
-    }
-    dc->sar_5bit = false;
-    dc->sar_m32_5bit = false;
-}
-
-static void gen_wsr_br(DisasContext *dc, uint32_t sr, TCGv_i32 s)
-{
-    tcg_gen_andi_i32(cpu_SR[sr], s, 0xffff);
-}
-
-static void gen_wsr_litbase(DisasContext *dc, uint32_t sr, TCGv_i32 s)
-{
-    tcg_gen_andi_i32(cpu_SR[sr], s, 0xfffff001);
-}
-
-static void gen_wsr_acchi(DisasContext *dc, uint32_t sr, TCGv_i32 s)
-{
-    tcg_gen_ext8s_i32(cpu_SR[sr], s);
-}
-
-#ifndef CONFIG_USER_ONLY
-static void gen_wsr_windowbase(DisasContext *dc, uint32_t sr, TCGv_i32 v)
-{
-    tcg_gen_mov_i32(cpu_windowbase_next, v);
-}
-
-static void gen_wsr_windowstart(DisasContext *dc, uint32_t sr, TCGv_i32 v)
-{
-    tcg_gen_andi_i32(cpu_SR[sr], v, (1 << dc->config->nareg / 4) - 1);
-}
-
-static void gen_wsr_ptevaddr(DisasContext *dc, uint32_t sr, TCGv_i32 v)
-{
-    tcg_gen_andi_i32(cpu_SR[sr], v, 0xffc00000);
-}
-
-static void gen_wsr_rasid(DisasContext *dc, uint32_t sr, TCGv_i32 v)
-{
-    gen_helper_wsr_rasid(cpu_env, v);
-}
-
-static void gen_wsr_tlbcfg(DisasContext *dc, uint32_t sr, TCGv_i32 v)
-{
-    tcg_gen_andi_i32(cpu_SR[sr], v, 0x01130000);
-}
-
-static void gen_wsr_ibreakenable(DisasContext *dc, uint32_t sr, TCGv_i32 v)
-{
-    gen_helper_wsr_ibreakenable(cpu_env, v);
-}
-
-static void gen_wsr_memctl(DisasContext *dc, uint32_t sr, TCGv_i32 v)
-{
-    gen_helper_wsr_memctl(cpu_env, v);
-}
-
-static void gen_wsr_atomctl(DisasContext *dc, uint32_t sr, TCGv_i32 v)
-{
-    tcg_gen_andi_i32(cpu_SR[sr], v, 0x3f);
-}
-
-static void gen_wsr_ibreaka(DisasContext *dc, uint32_t sr, TCGv_i32 v)
-{
-    unsigned id = sr - IBREAKA;
-    TCGv_i32 tmp = tcg_const_i32(id);
-
-    assert(id < dc->config->nibreak);
-    gen_helper_wsr_ibreaka(cpu_env, tmp, v);
-    tcg_temp_free(tmp);
-}
-
-static void gen_wsr_dbreaka(DisasContext *dc, uint32_t sr, TCGv_i32 v)
-{
-    unsigned id = sr - DBREAKA;
-    TCGv_i32 tmp = tcg_const_i32(id);
-
-    assert(id < dc->config->ndbreak);
-    gen_helper_wsr_dbreaka(cpu_env, tmp, v);
-    tcg_temp_free(tmp);
-}
-
-static void gen_wsr_dbreakc(DisasContext *dc, uint32_t sr, TCGv_i32 v)
-{
-    unsigned id = sr - DBREAKC;
-    TCGv_i32 tmp = tcg_const_i32(id);
-
-    assert(id < dc->config->ndbreak);
-    gen_helper_wsr_dbreakc(cpu_env, tmp, v);
-    tcg_temp_free(tmp);
-}
-
-static void gen_wsr_cpenable(DisasContext *dc, uint32_t sr, TCGv_i32 v)
-{
-    tcg_gen_andi_i32(cpu_SR[sr], v, 0xff);
-}
-
-static void gen_check_interrupts(DisasContext *dc)
-{
-    if (tb_cflags(dc->base.tb) & CF_USE_ICOUNT) {
-        gen_io_start();
-    }
-    gen_helper_check_interrupts(cpu_env);
-    if (tb_cflags(dc->base.tb) & CF_USE_ICOUNT) {
-        gen_io_end();
-    }
-}
-
-static void gen_wsr_intset(DisasContext *dc, uint32_t sr, TCGv_i32 v)
+static bool test_ill_sr(DisasContext *dc, const OpcodeArg arg[],
+                        const uint32_t par[])
 {
-    gen_helper_intset(cpu_env, v);
+    return !xtensa_option_enabled(dc->config, par[1]);
 }
 
-static void gen_wsr_intclear(DisasContext *dc, uint32_t sr, TCGv_i32 v)
+static bool test_ill_ccompare(DisasContext *dc, const OpcodeArg arg[],
+                              const uint32_t par[])
 {
-    gen_helper_intclear(cpu_env, v);
-}
+    unsigned n = par[0] - CCOMPARE;
 
-static void gen_wsr_intenable(DisasContext *dc, uint32_t sr, TCGv_i32 v)
-{
-    tcg_gen_mov_i32(cpu_SR[sr], v);
+    return test_ill_sr(dc, arg, par) || n >= dc->config->nccompare;
 }
 
-static void gen_wsr_ps(DisasContext *dc, uint32_t sr, TCGv_i32 v)
+static bool test_ill_dbreak(DisasContext *dc, const OpcodeArg arg[],
+                            const uint32_t par[])
 {
-    uint32_t mask = PS_WOE | PS_CALLINC | PS_OWB |
-        PS_UM | PS_EXCM | PS_INTLEVEL;
+    unsigned n = MAX_NDBREAK;
 
-    if (option_enabled(dc, XTENSA_OPTION_MMU)) {
-        mask |= PS_RING;
-    }
-    tcg_gen_andi_i32(cpu_SR[sr], v, mask);
-}
-
-static void gen_wsr_ccount(DisasContext *dc, uint32_t sr, TCGv_i32 v)
-{
-    if (tb_cflags(dc->base.tb) & CF_USE_ICOUNT) {
-        gen_io_start();
+    if (par[0] >= DBREAKA && par[0] < DBREAKA + MAX_NDBREAK) {
+        n = par[0] - DBREAKA;
     }
-    gen_helper_wsr_ccount(cpu_env, v);
-    if (tb_cflags(dc->base.tb) & CF_USE_ICOUNT) {
-        gen_io_end();
+    if (par[0] >= DBREAKC && par[0] < DBREAKC + MAX_NDBREAK) {
+        n = par[0] - DBREAKC;
     }
+    return test_ill_sr(dc, arg, par) || n >= dc->config->ndbreak;
 }
 
-static void gen_wsr_icount(DisasContext *dc, uint32_t sr, TCGv_i32 v)
+static bool test_ill_ibreak(DisasContext *dc, const OpcodeArg arg[],
+                            const uint32_t par[])
 {
-    if (dc->icount) {
-        tcg_gen_mov_i32(dc->next_icount, v);
-    } else {
-        tcg_gen_mov_i32(cpu_SR[sr], v);
-    }
-}
+    unsigned n = par[0] - IBREAKA;
 
-static void gen_wsr_icountlevel(DisasContext *dc, uint32_t sr, TCGv_i32 v)
-{
-    tcg_gen_andi_i32(cpu_SR[sr], v, 0xf);
+    return test_ill_sr(dc, arg, par) || n >= dc->config->nibreak;
 }
 
-static void gen_wsr_ccompare(DisasContext *dc, uint32_t sr, TCGv_i32 v)
+static bool test_ill_hpi(DisasContext *dc, const OpcodeArg arg[],
+                         const uint32_t par[])
 {
-    uint32_t id = sr - CCOMPARE;
-    TCGv_i32 tmp = tcg_const_i32(id);
+    unsigned n = MAX_NLEVEL + 1;
 
-    assert(id < dc->config->nccompare);
-    tcg_gen_mov_i32(cpu_SR[sr], v);
-    if (tb_cflags(dc->base.tb) & CF_USE_ICOUNT) {
-        gen_io_start();
-    }
-    gen_helper_update_ccompare(cpu_env, tmp);
-    tcg_temp_free(tmp);
-    if (tb_cflags(dc->base.tb) & CF_USE_ICOUNT) {
-        gen_io_end();
+    if (par[0] >= EXCSAVE1 && par[0] < EXCSAVE1 + MAX_NLEVEL) {
+        n = par[0] - EXCSAVE1 + 1;
     }
-}
-#else
-static void gen_check_interrupts(DisasContext *dc)
-{
-}
-#endif
-
-static void gen_wsr(DisasContext *dc, uint32_t sr, TCGv_i32 s)
-{
-    static void (* const wsr_handler[256])(DisasContext *dc,
-                                           uint32_t sr, TCGv_i32 v) = {
-        [SAR] = gen_wsr_sar,
-        [BR] = gen_wsr_br,
-        [LITBASE] = gen_wsr_litbase,
-        [ACCHI] = gen_wsr_acchi,
-#ifndef CONFIG_USER_ONLY
-        [WINDOW_BASE] = gen_wsr_windowbase,
-        [WINDOW_START] = gen_wsr_windowstart,
-        [PTEVADDR] = gen_wsr_ptevaddr,
-        [RASID] = gen_wsr_rasid,
-        [ITLBCFG] = gen_wsr_tlbcfg,
-        [DTLBCFG] = gen_wsr_tlbcfg,
-        [IBREAKENABLE] = gen_wsr_ibreakenable,
-        [MEMCTL] = gen_wsr_memctl,
-        [ATOMCTL] = gen_wsr_atomctl,
-        [IBREAKA] = gen_wsr_ibreaka,
-        [IBREAKA + 1] = gen_wsr_ibreaka,
-        [DBREAKA] = gen_wsr_dbreaka,
-        [DBREAKA + 1] = gen_wsr_dbreaka,
-        [DBREAKC] = gen_wsr_dbreakc,
-        [DBREAKC + 1] = gen_wsr_dbreakc,
-        [CPENABLE] = gen_wsr_cpenable,
-        [INTSET] = gen_wsr_intset,
-        [INTCLEAR] = gen_wsr_intclear,
-        [INTENABLE] = gen_wsr_intenable,
-        [PS] = gen_wsr_ps,
-        [CCOUNT] = gen_wsr_ccount,
-        [ICOUNT] = gen_wsr_icount,
-        [ICOUNTLEVEL] = gen_wsr_icountlevel,
-        [CCOMPARE] = gen_wsr_ccompare,
-        [CCOMPARE + 1] = gen_wsr_ccompare,
-        [CCOMPARE + 2] = gen_wsr_ccompare,
-#endif
-    };
-
-    if (wsr_handler[sr]) {
-        wsr_handler[sr](dc, sr, s);
-    } else {
-        tcg_gen_mov_i32(cpu_SR[sr], s);
+    if (par[0] >= EPC1 && par[0] < EPC1 + MAX_NLEVEL) {
+        n = par[0] - EPC1 + 1;
     }
-}
-
-static void gen_wur(uint32_t ur, TCGv_i32 s)
-{
-    switch (ur) {
-    case FCR:
-        gen_helper_wur_fcr(cpu_env, s);
-        break;
-
-    case FSR:
-        tcg_gen_andi_i32(cpu_UR[ur], s, 0xffffff80);
-        break;
-
-    default:
-        tcg_gen_mov_i32(cpu_UR[ur], s);
-        break;
+    if (par[0] >= EPS2 && par[0] < EPS2 + MAX_NLEVEL - 1) {
+        n = par[0] - EPS2 + 2;
     }
+    return test_ill_sr(dc, arg, par) || n > dc->config->nlevel;
 }
 
 static void gen_load_store_alignment(DisasContext *dc, int shift,
@@ -925,9 +583,17 @@ static int gen_postprocess(DisasContext *dc, int slot)
 {
     uint32_t op_flags = dc->op_flags;
 
+#ifndef CONFIG_USER_ONLY
     if (op_flags & XTENSA_OP_CHECK_INTERRUPTS) {
-        gen_check_interrupts(dc);
+        if (tb_cflags(dc->base.tb) & CF_USE_ICOUNT) {
+            gen_io_start();
+        }
+        gen_helper_check_interrupts(cpu_env);
+        if (tb_cflags(dc->base.tb) & CF_USE_ICOUNT) {
+            gen_io_end();
+        }
     }
+#endif
     if (op_flags & XTENSA_OP_SYNC_REGISTER_WINDOW) {
         gen_helper_sync_windowbase(cpu_env);
     }
@@ -1645,24 +1311,20 @@ void xtensa_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 {
     XtensaCPU *cpu = XTENSA_CPU(cs);
     CPUXtensaState *env = &cpu->env;
+    xtensa_isa isa = env->config->isa;
     int i, j;
 
     qemu_fprintf(f, "PC=%08x\n\n", env->pc);
 
-    for (i = j = 0; i < 256; ++i) {
-        if (xtensa_option_bits_enabled(env->config, sregnames[i].opt_bits)) {
-            qemu_fprintf(f, "%12s=%08x%c",
-                         sregnames[i].name, env->sregs[i],
-                         (j++ % 4) == 3 ? '\n' : ' ');
-        }
-    }
-
-    qemu_fprintf(f, (j % 4) == 0 ? "\n" : "\n\n");
+    for (i = j = 0; i < xtensa_isa_num_sysregs(isa); ++i) {
+        const uint32_t *reg =
+            xtensa_sysreg_is_user(isa, i) ? env->uregs : env->sregs;
+        int regno = xtensa_sysreg_number(isa, i);
 
-    for (i = j = 0; i < 256; ++i) {
-        if (xtensa_option_bits_enabled(env->config, uregnames[i].opt_bits)) {
-            qemu_fprintf(f, "%s=%08x%c",
-                         uregnames[i].name, env->uregs[i],
+        if (regno >= 0) {
+            qemu_fprintf(f, "%12s=%08x%c",
+                         xtensa_sysreg_name(isa, i),
+                         reg[regno],
                          (j++ % 4) == 3 ? '\n' : ' ');
         }
     }
@@ -2472,16 +2134,38 @@ static void translate_rsil(DisasContext *dc, const OpcodeArg arg[],
     tcg_gen_ori_i32(cpu_SR[PS], cpu_SR[PS], arg[1].imm);
 }
 
-static bool test_ill_rsr(DisasContext *dc, const OpcodeArg arg[],
-                         const uint32_t par[])
+static void translate_rsr(DisasContext *dc, const OpcodeArg arg[],
+                          const uint32_t par[])
 {
-    return !check_sr(dc, par[0], SR_R);
+    tcg_gen_mov_i32(arg[0].out, cpu_SR[par[0]]);
 }
 
-static void translate_rsr(DisasContext *dc, const OpcodeArg arg[],
-                          const uint32_t par[])
+static void translate_rsr_ccount(DisasContext *dc, const OpcodeArg arg[],
+                                 const uint32_t par[])
+{
+#ifndef CONFIG_USER_ONLY
+    if (tb_cflags(dc->base.tb) & CF_USE_ICOUNT) {
+        gen_io_start();
+    }
+    gen_helper_update_ccount(cpu_env);
+    tcg_gen_mov_i32(arg[0].out, cpu_SR[par[0]]);
+    if (tb_cflags(dc->base.tb) & CF_USE_ICOUNT) {
+        gen_io_end();
+    }
+#endif
+}
+
+static void translate_rsr_ptevaddr(DisasContext *dc, const OpcodeArg arg[],
+                                   const uint32_t par[])
 {
-    gen_rsr(dc, arg[0].out, par[0]);
+#ifndef CONFIG_USER_ONLY
+    TCGv_i32 tmp = tcg_temp_new_i32();
+
+    tcg_gen_shri_i32(tmp, cpu_SR[EXCVADDR], 10);
+    tcg_gen_or_i32(tmp, tmp, cpu_SR[PTEVADDR]);
+    tcg_gen_andi_i32(arg[0].out, tmp, 0xfffffffc);
+    tcg_temp_free(tmp);
+#endif
 }
 
 static void translate_rtlb(DisasContext *dc, const OpcodeArg arg[],
@@ -2503,11 +2187,7 @@ static void translate_rtlb(DisasContext *dc, const OpcodeArg arg[],
 static void translate_rur(DisasContext *dc, const OpcodeArg arg[],
                           const uint32_t par[])
 {
-    if (uregnames[par[0]].name) {
-        tcg_gen_mov_i32(arg[0].out, cpu_UR[par[0]]);
-    } else {
-        qemu_log_mask(LOG_UNIMP, "RUR %d not implemented\n", par[0]);
-    }
+    tcg_gen_mov_i32(arg[0].out, cpu_UR[par[0]]);
 }
 
 static void translate_setb_expstate(DisasContext *dc, const OpcodeArg arg[],
@@ -2778,52 +2458,288 @@ static void translate_wrmsk_expstate(DisasContext *dc, const OpcodeArg arg[],
     tcg_gen_and_i32(cpu_UR[EXPSTATE], arg[0].in, arg[1].in);
 }
 
-static bool test_ill_wsr(DisasContext *dc, const OpcodeArg arg[],
-                         const uint32_t par[])
+static void translate_wsr(DisasContext *dc, const OpcodeArg arg[],
+                          const uint32_t par[])
 {
-    return !check_sr(dc, par[0], SR_W);
+    tcg_gen_mov_i32(cpu_SR[par[0]], arg[0].in);
 }
 
-static void translate_wsr(DisasContext *dc, const OpcodeArg arg[],
-                          const uint32_t par[])
+static void translate_wsr_mask(DisasContext *dc, const OpcodeArg arg[],
+                               const uint32_t par[])
 {
-    gen_wsr(dc, par[0], arg[0].in);
+    tcg_gen_andi_i32(cpu_SR[par[0]], arg[0].in, par[2]);
 }
 
-static void translate_wur(DisasContext *dc, const OpcodeArg arg[],
-                          const uint32_t par[])
+static void translate_wsr_acchi(DisasContext *dc, const OpcodeArg arg[],
+                                const uint32_t par[])
 {
-    if (uregnames[par[0]].name) {
-        gen_wur(par[0], arg[0].in);
-    } else {
-        qemu_log_mask(LOG_UNIMP, "WUR %d not implemented\n", par[0]);
-    }
+    tcg_gen_ext8s_i32(cpu_SR[par[0]], arg[0].in);
 }
 
-static void translate_xor(DisasContext *dc, const OpcodeArg arg[],
-                          const uint32_t par[])
+static void translate_wsr_ccompare(DisasContext *dc, const OpcodeArg arg[],
+                                   const uint32_t par[])
 {
-    tcg_gen_xor_i32(arg[0].out, arg[1].in, arg[2].in);
+#ifndef CONFIG_USER_ONLY
+    uint32_t id = par[0] - CCOMPARE;
+    TCGv_i32 tmp = tcg_const_i32(id);
+
+    assert(id < dc->config->nccompare);
+    if (tb_cflags(dc->base.tb) & CF_USE_ICOUNT) {
+        gen_io_start();
+    }
+    tcg_gen_mov_i32(cpu_SR[par[0]], arg[0].in);
+    gen_helper_update_ccompare(cpu_env, tmp);
+    tcg_temp_free(tmp);
+    if (tb_cflags(dc->base.tb) & CF_USE_ICOUNT) {
+        gen_io_end();
+    }
+#endif
 }
 
-static bool test_ill_xsr(DisasContext *dc, const OpcodeArg arg[],
-                         const uint32_t par[])
+static void translate_wsr_ccount(DisasContext *dc, const OpcodeArg arg[],
+                                 const uint32_t par[])
 {
-    return !check_sr(dc, par[0], SR_X);
+#ifndef CONFIG_USER_ONLY
+    if (tb_cflags(dc->base.tb) & CF_USE_ICOUNT) {
+        gen_io_start();
+    }
+    gen_helper_wsr_ccount(cpu_env, arg[0].in);
+    if (tb_cflags(dc->base.tb) & CF_USE_ICOUNT) {
+        gen_io_end();
+    }
+#endif
 }
 
-static void translate_xsr(DisasContext *dc, const OpcodeArg arg[],
-                          const uint32_t par[])
+static void translate_wsr_dbreaka(DisasContext *dc, const OpcodeArg arg[],
+                                  const uint32_t par[])
 {
-    TCGv_i32 tmp = tcg_temp_new_i32();
+#ifndef CONFIG_USER_ONLY
+    unsigned id = par[0] - DBREAKA;
+    TCGv_i32 tmp = tcg_const_i32(id);
 
-    tcg_gen_mov_i32(tmp, arg[0].in);
-    gen_rsr(dc, arg[0].out, par[0]);
-    gen_wsr(dc, par[0], tmp);
+    assert(id < dc->config->ndbreak);
+    gen_helper_wsr_dbreaka(cpu_env, tmp, arg[0].in);
     tcg_temp_free(tmp);
+#endif
 }
 
-static const XtensaOpcodeOps core_ops[] = {
+static void translate_wsr_dbreakc(DisasContext *dc, const OpcodeArg arg[],
+                                  const uint32_t par[])
+{
+#ifndef CONFIG_USER_ONLY
+    unsigned id = par[0] - DBREAKC;
+    TCGv_i32 tmp = tcg_const_i32(id);
+
+    assert(id < dc->config->ndbreak);
+    gen_helper_wsr_dbreakc(cpu_env, tmp, arg[0].in);
+    tcg_temp_free(tmp);
+#endif
+}
+
+static void translate_wsr_ibreaka(DisasContext *dc, const OpcodeArg arg[],
+                                  const uint32_t par[])
+{
+#ifndef CONFIG_USER_ONLY
+    unsigned id = par[0] - IBREAKA;
+    TCGv_i32 tmp = tcg_const_i32(id);
+
+    assert(id < dc->config->nibreak);
+    gen_helper_wsr_ibreaka(cpu_env, tmp, arg[0].in);
+    tcg_temp_free(tmp);
+#endif
+}
+
+static void translate_wsr_ibreakenable(DisasContext *dc, const OpcodeArg arg[],
+                                       const uint32_t par[])
+{
+#ifndef CONFIG_USER_ONLY
+    gen_helper_wsr_ibreakenable(cpu_env, arg[0].in);
+#endif
+}
+
+static void translate_wsr_icount(DisasContext *dc, const OpcodeArg arg[],
+                                 const uint32_t par[])
+{
+#ifndef CONFIG_USER_ONLY
+    if (dc->icount) {
+        tcg_gen_mov_i32(dc->next_icount, arg[0].in);
+    } else {
+        tcg_gen_mov_i32(cpu_SR[par[0]], arg[0].in);
+    }
+#endif
+}
+
+static void translate_wsr_intclear(DisasContext *dc, const OpcodeArg arg[],
+                                   const uint32_t par[])
+{
+#ifndef CONFIG_USER_ONLY
+    gen_helper_intclear(cpu_env, arg[0].in);
+#endif
+}
+
+static void translate_wsr_intset(DisasContext *dc, const OpcodeArg arg[],
+                                 const uint32_t par[])
+{
+#ifndef CONFIG_USER_ONLY
+    gen_helper_intset(cpu_env, arg[0].in);
+#endif
+}
+
+static void translate_wsr_memctl(DisasContext *dc, const OpcodeArg arg[],
+                                 const uint32_t par[])
+{
+#ifndef CONFIG_USER_ONLY
+    gen_helper_wsr_memctl(cpu_env, arg[0].in);
+#endif
+}
+
+static void translate_wsr_ps(DisasContext *dc, const OpcodeArg arg[],
+                             const uint32_t par[])
+{
+#ifndef CONFIG_USER_ONLY
+    uint32_t mask = PS_WOE | PS_CALLINC | PS_OWB |
+        PS_UM | PS_EXCM | PS_INTLEVEL;
+
+    if (option_enabled(dc, XTENSA_OPTION_MMU)) {
+        mask |= PS_RING;
+    }
+    tcg_gen_andi_i32(cpu_SR[par[0]], arg[0].in, mask);
+#endif
+}
+
+static void translate_wsr_rasid(DisasContext *dc, const OpcodeArg arg[],
+                                const uint32_t par[])
+{
+#ifndef CONFIG_USER_ONLY
+    gen_helper_wsr_rasid(cpu_env, arg[0].in);
+#endif
+}
+
+static void translate_wsr_sar(DisasContext *dc, const OpcodeArg arg[],
+                              const uint32_t par[])
+{
+    tcg_gen_andi_i32(cpu_SR[par[0]], arg[0].in, 0x3f);
+    if (dc->sar_m32_5bit) {
+        tcg_gen_discard_i32(dc->sar_m32);
+    }
+    dc->sar_5bit = false;
+    dc->sar_m32_5bit = false;
+}
+
+static void translate_wsr_windowbase(DisasContext *dc, const OpcodeArg arg[],
+                                     const uint32_t par[])
+{
+#ifndef CONFIG_USER_ONLY
+    tcg_gen_mov_i32(cpu_windowbase_next, arg[0].in);
+#endif
+}
+
+static void translate_wsr_windowstart(DisasContext *dc, const OpcodeArg arg[],
+                                      const uint32_t par[])
+{
+#ifndef CONFIG_USER_ONLY
+    tcg_gen_andi_i32(cpu_SR[par[0]], arg[0].in,
+                     (1 << dc->config->nareg / 4) - 1);
+#endif
+}
+
+static void translate_wur(DisasContext *dc, const OpcodeArg arg[],
+                          const uint32_t par[])
+{
+    tcg_gen_mov_i32(cpu_UR[par[0]], arg[0].in);
+}
+
+static void translate_wur_fcr(DisasContext *dc, const OpcodeArg arg[],
+                              const uint32_t par[])
+{
+    gen_helper_wur_fcr(cpu_env, arg[0].in);
+}
+
+static void translate_wur_fsr(DisasContext *dc, const OpcodeArg arg[],
+                              const uint32_t par[])
+{
+    tcg_gen_andi_i32(cpu_UR[par[0]], arg[0].in, 0xffffff80);
+}
+
+static void translate_xor(DisasContext *dc, const OpcodeArg arg[],
+                          const uint32_t par[])
+{
+    tcg_gen_xor_i32(arg[0].out, arg[1].in, arg[2].in);
+}
+
+static void translate_xsr(DisasContext *dc, const OpcodeArg arg[],
+                          const uint32_t par[])
+{
+    TCGv_i32 tmp = tcg_temp_new_i32();
+
+    tcg_gen_mov_i32(tmp, arg[0].in);
+    tcg_gen_mov_i32(arg[0].out, cpu_SR[par[0]]);
+    tcg_gen_mov_i32(cpu_SR[par[0]], tmp);
+    tcg_temp_free(tmp);
+}
+
+static void translate_xsr_mask(DisasContext *dc, const OpcodeArg arg[],
+                               const uint32_t par[])
+{
+    TCGv_i32 tmp = tcg_temp_new_i32();
+
+    tcg_gen_mov_i32(tmp, arg[0].in);
+    tcg_gen_mov_i32(arg[0].out, cpu_SR[par[0]]);
+    tcg_gen_andi_i32(cpu_SR[par[0]], tmp, par[2]);
+    tcg_temp_free(tmp);
+}
+
+static void translate_xsr_ccount(DisasContext *dc, const OpcodeArg arg[],
+                                 const uint32_t par[])
+{
+#ifndef CONFIG_USER_ONLY
+    TCGv_i32 tmp = tcg_temp_new_i32();
+
+    if (tb_cflags(dc->base.tb) & CF_USE_ICOUNT) {
+        gen_io_start();
+    }
+
+    gen_helper_update_ccount(cpu_env);
+    tcg_gen_mov_i32(tmp, cpu_SR[par[0]]);
+    gen_helper_wsr_ccount(cpu_env, arg[0].in);
+    tcg_gen_mov_i32(arg[0].out, tmp);
+    tcg_temp_free(tmp);
+
+    if (tb_cflags(dc->base.tb) & CF_USE_ICOUNT) {
+        gen_io_end();
+    }
+#endif
+}
+
+#define gen_translate_xsr(name) \
+    static void translate_xsr_##name(DisasContext *dc, const OpcodeArg arg[], \
+                                     const uint32_t par[]) \
+{ \
+    TCGv_i32 tmp = tcg_temp_new_i32(); \
+ \
+    tcg_gen_mov_i32(tmp, cpu_SR[par[0]]); \
+    translate_wsr_##name(dc, arg, par); \
+    tcg_gen_mov_i32(arg[0].out, tmp); \
+    tcg_temp_free(tmp); \
+}
+
+gen_translate_xsr(acchi)
+gen_translate_xsr(ccompare)
+gen_translate_xsr(dbreaka)
+gen_translate_xsr(dbreakc)
+gen_translate_xsr(ibreaka)
+gen_translate_xsr(ibreakenable)
+gen_translate_xsr(icount)
+gen_translate_xsr(memctl)
+gen_translate_xsr(ps)
+gen_translate_xsr(rasid)
+gen_translate_xsr(sar)
+gen_translate_xsr(windowbase)
+gen_translate_xsr(windowstart)
+
+#undef gen_translate_xsr
+
+static const XtensaOpcodeOps core_ops[] = {
     {
         .name = "abs",
         .translate = translate_abs,
@@ -3766,450 +3682,653 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "rsr.176",
         .translate = translate_rsr,
-        .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){176},
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "rsr.208",
         .translate = translate_rsr,
-        .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){208},
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "rsr.acchi",
         .translate = translate_rsr,
-        .test_ill = test_ill_rsr,
-        .par = (const uint32_t[]){ACCHI},
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            ACCHI,
+            XTENSA_OPTION_MAC16,
+        },
     }, {
         .name = "rsr.acclo",
         .translate = translate_rsr,
-        .test_ill = test_ill_rsr,
-        .par = (const uint32_t[]){ACCLO},
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            ACCLO,
+            XTENSA_OPTION_MAC16,
+        },
     }, {
         .name = "rsr.atomctl",
         .translate = translate_rsr,
-        .test_ill = test_ill_rsr,
-        .par = (const uint32_t[]){ATOMCTL},
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            ATOMCTL,
+            XTENSA_OPTION_ATOMCTL,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "rsr.br",
         .translate = translate_rsr,
-        .test_ill = test_ill_rsr,
-        .par = (const uint32_t[]){BR},
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            BR,
+            XTENSA_OPTION_BOOLEAN,
+        },
     }, {
         .name = "rsr.cacheattr",
         .translate = translate_rsr,
-        .test_ill = test_ill_rsr,
-        .par = (const uint32_t[]){CACHEATTR},
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            CACHEATTR,
+            XTENSA_OPTION_CACHEATTR,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "rsr.ccompare0",
         .translate = translate_rsr,
-        .test_ill = test_ill_rsr,
-        .par = (const uint32_t[]){CCOMPARE},
+        .test_ill = test_ill_ccompare,
+        .par = (const uint32_t[]){
+            CCOMPARE,
+            XTENSA_OPTION_TIMER_INTERRUPT,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "rsr.ccompare1",
         .translate = translate_rsr,
-        .test_ill = test_ill_rsr,
-        .par = (const uint32_t[]){CCOMPARE + 1},
+        .test_ill = test_ill_ccompare,
+        .par = (const uint32_t[]){
+            CCOMPARE + 1,
+            XTENSA_OPTION_TIMER_INTERRUPT,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "rsr.ccompare2",
         .translate = translate_rsr,
-        .test_ill = test_ill_rsr,
-        .par = (const uint32_t[]){CCOMPARE + 2},
+        .test_ill = test_ill_ccompare,
+        .par = (const uint32_t[]){
+            CCOMPARE + 2,
+            XTENSA_OPTION_TIMER_INTERRUPT,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "rsr.ccount",
-        .translate = translate_rsr,
-        .test_ill = test_ill_rsr,
-        .par = (const uint32_t[]){CCOUNT},
+        .translate = translate_rsr_ccount,
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            CCOUNT,
+            XTENSA_OPTION_TIMER_INTERRUPT,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED | XTENSA_OP_EXIT_TB_0,
     }, {
         .name = "rsr.configid0",
         .translate = translate_rsr,
-        .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){CONFIGID0},
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "rsr.configid1",
         .translate = translate_rsr,
-        .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){CONFIGID1},
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "rsr.cpenable",
         .translate = translate_rsr,
-        .test_ill = test_ill_rsr,
-        .par = (const uint32_t[]){CPENABLE},
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            CPENABLE,
+            XTENSA_OPTION_COPROCESSOR,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "rsr.dbreaka0",
         .translate = translate_rsr,
-        .test_ill = test_ill_rsr,
-        .par = (const uint32_t[]){DBREAKA},
+        .test_ill = test_ill_dbreak,
+        .par = (const uint32_t[]){
+            DBREAKA,
+            XTENSA_OPTION_DEBUG,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "rsr.dbreaka1",
         .translate = translate_rsr,
-        .test_ill = test_ill_rsr,
-        .par = (const uint32_t[]){DBREAKA + 1},
+        .test_ill = test_ill_dbreak,
+        .par = (const uint32_t[]){
+            DBREAKA + 1,
+            XTENSA_OPTION_DEBUG,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "rsr.dbreakc0",
         .translate = translate_rsr,
-        .test_ill = test_ill_rsr,
-        .par = (const uint32_t[]){DBREAKC},
+        .test_ill = test_ill_dbreak,
+        .par = (const uint32_t[]){
+            DBREAKC,
+            XTENSA_OPTION_DEBUG,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "rsr.dbreakc1",
         .translate = translate_rsr,
-        .test_ill = test_ill_rsr,
-        .par = (const uint32_t[]){DBREAKC + 1},
+        .test_ill = test_ill_dbreak,
+        .par = (const uint32_t[]){
+            DBREAKC + 1,
+            XTENSA_OPTION_DEBUG,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "rsr.ddr",
         .translate = translate_rsr,
-        .test_ill = test_ill_rsr,
-        .par = (const uint32_t[]){DDR},
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            DDR,
+            XTENSA_OPTION_DEBUG,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "rsr.debugcause",
         .translate = translate_rsr,
-        .test_ill = test_ill_rsr,
-        .par = (const uint32_t[]){DEBUGCAUSE},
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            DEBUGCAUSE,
+            XTENSA_OPTION_DEBUG,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "rsr.depc",
         .translate = translate_rsr,
-        .test_ill = test_ill_rsr,
-        .par = (const uint32_t[]){DEPC},
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            DEPC,
+            XTENSA_OPTION_EXCEPTION,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "rsr.dtlbcfg",
         .translate = translate_rsr,
-        .test_ill = test_ill_rsr,
-        .par = (const uint32_t[]){DTLBCFG},
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            DTLBCFG,
+            XTENSA_OPTION_MMU,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "rsr.epc1",
         .translate = translate_rsr,
-        .test_ill = test_ill_rsr,
-        .par = (const uint32_t[]){EPC1},
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            EPC1,
+            XTENSA_OPTION_EXCEPTION,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "rsr.epc2",
         .translate = translate_rsr,
-        .test_ill = test_ill_rsr,
-        .par = (const uint32_t[]){EPC1 + 1},
+        .test_ill = test_ill_hpi,
+        .par = (const uint32_t[]){
+            EPC1 + 1,
+            XTENSA_OPTION_HIGH_PRIORITY_INTERRUPT,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "rsr.epc3",
         .translate = translate_rsr,
-        .test_ill = test_ill_rsr,
-        .par = (const uint32_t[]){EPC1 + 2},
+        .test_ill = test_ill_hpi,
+        .par = (const uint32_t[]){
+            EPC1 + 2,
+            XTENSA_OPTION_HIGH_PRIORITY_INTERRUPT,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "rsr.epc4",
         .translate = translate_rsr,
-        .test_ill = test_ill_rsr,
-        .par = (const uint32_t[]){EPC1 + 3},
+        .test_ill = test_ill_hpi,
+        .par = (const uint32_t[]){
+            EPC1 + 3,
+            XTENSA_OPTION_HIGH_PRIORITY_INTERRUPT,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "rsr.epc5",
         .translate = translate_rsr,
-        .test_ill = test_ill_rsr,
-        .par = (const uint32_t[]){EPC1 + 4},
+        .test_ill = test_ill_hpi,
+        .par = (const uint32_t[]){
+            EPC1 + 4,
+            XTENSA_OPTION_HIGH_PRIORITY_INTERRUPT,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "rsr.epc6",
         .translate = translate_rsr,
-        .test_ill = test_ill_rsr,
-        .par = (const uint32_t[]){EPC1 + 5},
+        .test_ill = test_ill_hpi,
+        .par = (const uint32_t[]){
+            EPC1 + 5,
+            XTENSA_OPTION_HIGH_PRIORITY_INTERRUPT,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "rsr.epc7",
         .translate = translate_rsr,
-        .test_ill = test_ill_rsr,
-        .par = (const uint32_t[]){EPC1 + 6},
+        .test_ill = test_ill_hpi,
+        .par = (const uint32_t[]){
+            EPC1 + 6,
+            XTENSA_OPTION_HIGH_PRIORITY_INTERRUPT,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "rsr.eps2",
         .translate = translate_rsr,
-        .test_ill = test_ill_rsr,
-        .par = (const uint32_t[]){EPS2},
+        .test_ill = test_ill_hpi,
+        .par = (const uint32_t[]){
+            EPS2,
+            XTENSA_OPTION_HIGH_PRIORITY_INTERRUPT,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "rsr.eps3",
         .translate = translate_rsr,
-        .test_ill = test_ill_rsr,
-        .par = (const uint32_t[]){EPS2 + 1},
+        .test_ill = test_ill_hpi,
+        .par = (const uint32_t[]){
+            EPS2 + 1,
+            XTENSA_OPTION_HIGH_PRIORITY_INTERRUPT,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "rsr.eps4",
         .translate = translate_rsr,
-        .test_ill = test_ill_rsr,
-        .par = (const uint32_t[]){EPS2 + 2},
+        .test_ill = test_ill_hpi,
+        .par = (const uint32_t[]){
+            EPS2 + 2,
+            XTENSA_OPTION_HIGH_PRIORITY_INTERRUPT,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "rsr.eps5",
         .translate = translate_rsr,
-        .test_ill = test_ill_rsr,
-        .par = (const uint32_t[]){EPS2 + 3},
+        .test_ill = test_ill_hpi,
+        .par = (const uint32_t[]){
+            EPS2 + 3,
+            XTENSA_OPTION_HIGH_PRIORITY_INTERRUPT,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "rsr.eps6",
         .translate = translate_rsr,
-        .test_ill = test_ill_rsr,
-        .par = (const uint32_t[]){EPS2 + 4},
+        .test_ill = test_ill_hpi,
+        .par = (const uint32_t[]){
+            EPS2 + 4,
+            XTENSA_OPTION_HIGH_PRIORITY_INTERRUPT,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "rsr.eps7",
         .translate = translate_rsr,
-        .test_ill = test_ill_rsr,
-        .par = (const uint32_t[]){EPS2 + 5},
+        .test_ill = test_ill_hpi,
+        .par = (const uint32_t[]){
+            EPS2 + 5,
+            XTENSA_OPTION_HIGH_PRIORITY_INTERRUPT,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "rsr.exccause",
         .translate = translate_rsr,
-        .test_ill = test_ill_rsr,
-        .par = (const uint32_t[]){EXCCAUSE},
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            EXCCAUSE,
+            XTENSA_OPTION_EXCEPTION,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "rsr.excsave1",
         .translate = translate_rsr,
-        .test_ill = test_ill_rsr,
-        .par = (const uint32_t[]){EXCSAVE1},
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            EXCSAVE1,
+            XTENSA_OPTION_EXCEPTION,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "rsr.excsave2",
         .translate = translate_rsr,
-        .test_ill = test_ill_rsr,
-        .par = (const uint32_t[]){EXCSAVE1 + 1},
+        .test_ill = test_ill_hpi,
+        .par = (const uint32_t[]){
+            EXCSAVE1 + 1,
+            XTENSA_OPTION_HIGH_PRIORITY_INTERRUPT,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "rsr.excsave3",
         .translate = translate_rsr,
-        .test_ill = test_ill_rsr,
-        .par = (const uint32_t[]){EXCSAVE1 + 2},
+        .test_ill = test_ill_hpi,
+        .par = (const uint32_t[]){
+            EXCSAVE1 + 2,
+            XTENSA_OPTION_HIGH_PRIORITY_INTERRUPT,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "rsr.excsave4",
         .translate = translate_rsr,
-        .test_ill = test_ill_rsr,
-        .par = (const uint32_t[]){EXCSAVE1 + 3},
+        .test_ill = test_ill_hpi,
+        .par = (const uint32_t[]){
+            EXCSAVE1 + 3,
+            XTENSA_OPTION_HIGH_PRIORITY_INTERRUPT,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "rsr.excsave5",
         .translate = translate_rsr,
-        .test_ill = test_ill_rsr,
-        .par = (const uint32_t[]){EXCSAVE1 + 4},
+        .test_ill = test_ill_hpi,
+        .par = (const uint32_t[]){
+            EXCSAVE1 + 4,
+            XTENSA_OPTION_HIGH_PRIORITY_INTERRUPT,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "rsr.excsave6",
         .translate = translate_rsr,
-        .test_ill = test_ill_rsr,
-        .par = (const uint32_t[]){EXCSAVE1 + 5},
+        .test_ill = test_ill_hpi,
+        .par = (const uint32_t[]){
+            EXCSAVE1 + 5,
+            XTENSA_OPTION_HIGH_PRIORITY_INTERRUPT,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "rsr.excsave7",
         .translate = translate_rsr,
-        .test_ill = test_ill_rsr,
-        .par = (const uint32_t[]){EXCSAVE1 + 6},
+        .test_ill = test_ill_hpi,
+        .par = (const uint32_t[]){
+            EXCSAVE1 + 6,
+            XTENSA_OPTION_HIGH_PRIORITY_INTERRUPT,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "rsr.excvaddr",
         .translate = translate_rsr,
-        .test_ill = test_ill_rsr,
-        .par = (const uint32_t[]){EXCVADDR},
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            EXCVADDR,
+            XTENSA_OPTION_EXCEPTION,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "rsr.ibreaka0",
         .translate = translate_rsr,
-        .test_ill = test_ill_rsr,
-        .par = (const uint32_t[]){IBREAKA},
+        .test_ill = test_ill_ibreak,
+        .par = (const uint32_t[]){
+            IBREAKA,
+            XTENSA_OPTION_DEBUG,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "rsr.ibreaka1",
         .translate = translate_rsr,
-        .test_ill = test_ill_rsr,
-        .par = (const uint32_t[]){IBREAKA + 1},
+        .test_ill = test_ill_ibreak,
+        .par = (const uint32_t[]){
+            IBREAKA + 1,
+            XTENSA_OPTION_DEBUG,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "rsr.ibreakenable",
         .translate = translate_rsr,
-        .test_ill = test_ill_rsr,
-        .par = (const uint32_t[]){IBREAKENABLE},
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            IBREAKENABLE,
+            XTENSA_OPTION_DEBUG,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "rsr.icount",
         .translate = translate_rsr,
-        .test_ill = test_ill_rsr,
-        .par = (const uint32_t[]){ICOUNT},
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            ICOUNT,
+            XTENSA_OPTION_DEBUG,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "rsr.icountlevel",
         .translate = translate_rsr,
-        .test_ill = test_ill_rsr,
-        .par = (const uint32_t[]){ICOUNTLEVEL},
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            ICOUNTLEVEL,
+            XTENSA_OPTION_DEBUG,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "rsr.intclear",
         .translate = translate_rsr,
-        .test_ill = test_ill_rsr,
-        .par = (const uint32_t[]){INTCLEAR},
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            INTCLEAR,
+            XTENSA_OPTION_INTERRUPT,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "rsr.intenable",
         .translate = translate_rsr,
-        .test_ill = test_ill_rsr,
-        .par = (const uint32_t[]){INTENABLE},
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            INTENABLE,
+            XTENSA_OPTION_INTERRUPT,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "rsr.interrupt",
-        .translate = translate_rsr,
-        .test_ill = test_ill_rsr,
-        .par = (const uint32_t[]){INTSET},
+        .translate = translate_rsr_ccount,
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            INTSET,
+            XTENSA_OPTION_INTERRUPT,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED | XTENSA_OP_EXIT_TB_0,
     }, {
         .name = "rsr.intset",
-        .translate = translate_rsr,
-        .test_ill = test_ill_rsr,
-        .par = (const uint32_t[]){INTSET},
+        .translate = translate_rsr_ccount,
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            INTSET,
+            XTENSA_OPTION_INTERRUPT,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED | XTENSA_OP_EXIT_TB_0,
     }, {
         .name = "rsr.itlbcfg",
         .translate = translate_rsr,
-        .test_ill = test_ill_rsr,
-        .par = (const uint32_t[]){ITLBCFG},
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            ITLBCFG,
+            XTENSA_OPTION_MMU,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "rsr.lbeg",
         .translate = translate_rsr,
-        .test_ill = test_ill_rsr,
-        .par = (const uint32_t[]){LBEG},
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            LBEG,
+            XTENSA_OPTION_LOOP,
+        },
     }, {
         .name = "rsr.lcount",
         .translate = translate_rsr,
-        .test_ill = test_ill_rsr,
-        .par = (const uint32_t[]){LCOUNT},
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            LCOUNT,
+            XTENSA_OPTION_LOOP,
+        },
     }, {
         .name = "rsr.lend",
         .translate = translate_rsr,
-        .test_ill = test_ill_rsr,
-        .par = (const uint32_t[]){LEND},
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            LEND,
+            XTENSA_OPTION_LOOP,
+        },
     }, {
         .name = "rsr.litbase",
         .translate = translate_rsr,
-        .test_ill = test_ill_rsr,
-        .par = (const uint32_t[]){LITBASE},
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            LITBASE,
+            XTENSA_OPTION_EXTENDED_L32R,
+        },
     }, {
         .name = "rsr.m0",
         .translate = translate_rsr,
-        .test_ill = test_ill_rsr,
-        .par = (const uint32_t[]){MR},
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            MR,
+            XTENSA_OPTION_MAC16,
+        },
     }, {
         .name = "rsr.m1",
         .translate = translate_rsr,
-        .test_ill = test_ill_rsr,
-        .par = (const uint32_t[]){MR + 1},
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            MR + 1,
+            XTENSA_OPTION_MAC16,
+        },
     }, {
         .name = "rsr.m2",
         .translate = translate_rsr,
-        .test_ill = test_ill_rsr,
-        .par = (const uint32_t[]){MR + 2},
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            MR + 2,
+            XTENSA_OPTION_MAC16,
+        },
     }, {
         .name = "rsr.m3",
         .translate = translate_rsr,
-        .test_ill = test_ill_rsr,
-        .par = (const uint32_t[]){MR + 3},
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            MR + 3,
+            XTENSA_OPTION_MAC16,
+        },
     }, {
         .name = "rsr.memctl",
         .translate = translate_rsr,
-        .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){MEMCTL},
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "rsr.misc0",
         .translate = translate_rsr,
-        .test_ill = test_ill_rsr,
-        .par = (const uint32_t[]){MISC},
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            MISC,
+            XTENSA_OPTION_MISC_SR,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "rsr.misc1",
         .translate = translate_rsr,
-        .test_ill = test_ill_rsr,
-        .par = (const uint32_t[]){MISC + 1},
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            MISC + 1,
+            XTENSA_OPTION_MISC_SR,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "rsr.misc2",
         .translate = translate_rsr,
-        .test_ill = test_ill_rsr,
-        .par = (const uint32_t[]){MISC + 2},
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            MISC + 2,
+            XTENSA_OPTION_MISC_SR,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "rsr.misc3",
         .translate = translate_rsr,
-        .test_ill = test_ill_rsr,
-        .par = (const uint32_t[]){MISC + 3},
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            MISC + 3,
+            XTENSA_OPTION_MISC_SR,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "rsr.prefctl",
         .translate = translate_rsr,
-        .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){PREFCTL},
     }, {
         .name = "rsr.prid",
         .translate = translate_rsr,
-        .test_ill = test_ill_rsr,
-        .par = (const uint32_t[]){PRID},
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            PRID,
+            XTENSA_OPTION_PROCESSOR_ID,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "rsr.ps",
         .translate = translate_rsr,
-        .test_ill = test_ill_rsr,
-        .par = (const uint32_t[]){PS},
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            PS,
+            XTENSA_OPTION_EXCEPTION,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "rsr.ptevaddr",
-        .translate = translate_rsr,
-        .test_ill = test_ill_rsr,
-        .par = (const uint32_t[]){PTEVADDR},
+        .translate = translate_rsr_ptevaddr,
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            PTEVADDR,
+            XTENSA_OPTION_MMU,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "rsr.rasid",
         .translate = translate_rsr,
-        .test_ill = test_ill_rsr,
-        .par = (const uint32_t[]){RASID},
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            RASID,
+            XTENSA_OPTION_MMU,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "rsr.sar",
         .translate = translate_rsr,
-        .test_ill = test_ill_rsr,
         .par = (const uint32_t[]){SAR},
     }, {
         .name = "rsr.scompare1",
         .translate = translate_rsr,
-        .test_ill = test_ill_rsr,
-        .par = (const uint32_t[]){SCOMPARE1},
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            SCOMPARE1,
+            XTENSA_OPTION_CONDITIONAL_STORE,
+        },
     }, {
         .name = "rsr.vecbase",
         .translate = translate_rsr,
-        .test_ill = test_ill_rsr,
-        .par = (const uint32_t[]){VECBASE},
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            VECBASE,
+            XTENSA_OPTION_RELOCATABLE_VECTOR,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "rsr.windowbase",
         .translate = translate_rsr,
-        .test_ill = test_ill_rsr,
-        .par = (const uint32_t[]){WINDOW_BASE},
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            WINDOW_BASE,
+            XTENSA_OPTION_WINDOWED_REGISTER,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "rsr.windowstart",
         .translate = translate_rsr,
-        .test_ill = test_ill_rsr,
-        .par = (const uint32_t[]){WINDOW_START},
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            WINDOW_START,
+            XTENSA_OPTION_WINDOWED_REGISTER,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "rsync",
@@ -4374,300 +4493,425 @@ static const XtensaOpcodeOps core_ops[] = {
         .translate = translate_wrmsk_expstate,
     }, {
         .name = "wsr.176",
-        .translate = translate_wsr,
-        .test_ill = test_ill_wsr,
-        .par = (const uint32_t[]){176},
-        .op_flags = XTENSA_OP_PRIVILEGED,
+        .op_flags = XTENSA_OP_ILL,
     }, {
         .name = "wsr.208",
-        .translate = translate_wsr,
-        .test_ill = test_ill_wsr,
-        .par = (const uint32_t[]){208},
-        .op_flags = XTENSA_OP_PRIVILEGED,
+        .op_flags = XTENSA_OP_ILL,
     }, {
         .name = "wsr.acchi",
-        .translate = translate_wsr,
-        .test_ill = test_ill_wsr,
-        .par = (const uint32_t[]){ACCHI},
+        .translate = translate_wsr_acchi,
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            ACCHI,
+            XTENSA_OPTION_MAC16,
+        },
     }, {
         .name = "wsr.acclo",
         .translate = translate_wsr,
-        .test_ill = test_ill_wsr,
-        .par = (const uint32_t[]){ACCLO},
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            ACCLO,
+            XTENSA_OPTION_MAC16,
+        },
     }, {
         .name = "wsr.atomctl",
-        .translate = translate_wsr,
-        .test_ill = test_ill_wsr,
-        .par = (const uint32_t[]){ATOMCTL},
+        .translate = translate_wsr_mask,
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            ATOMCTL,
+            XTENSA_OPTION_ATOMCTL,
+            0x3f,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "wsr.br",
-        .translate = translate_wsr,
-        .test_ill = test_ill_wsr,
-        .par = (const uint32_t[]){BR},
+        .translate = translate_wsr_mask,
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            BR,
+            XTENSA_OPTION_BOOLEAN,
+            0xffff,
+        },
     }, {
         .name = "wsr.cacheattr",
         .translate = translate_wsr,
-        .test_ill = test_ill_wsr,
-        .par = (const uint32_t[]){CACHEATTR},
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            CACHEATTR,
+            XTENSA_OPTION_CACHEATTR,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "wsr.ccompare0",
-        .translate = translate_wsr,
-        .test_ill = test_ill_wsr,
-        .par = (const uint32_t[]){CCOMPARE},
+        .translate = translate_wsr_ccompare,
+        .test_ill = test_ill_ccompare,
+        .par = (const uint32_t[]){
+            CCOMPARE,
+            XTENSA_OPTION_TIMER_INTERRUPT,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED | XTENSA_OP_EXIT_TB_0,
     }, {
         .name = "wsr.ccompare1",
-        .translate = translate_wsr,
-        .test_ill = test_ill_wsr,
-        .par = (const uint32_t[]){CCOMPARE + 1},
+        .translate = translate_wsr_ccompare,
+        .test_ill = test_ill_ccompare,
+        .par = (const uint32_t[]){
+            CCOMPARE + 1,
+            XTENSA_OPTION_TIMER_INTERRUPT,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED | XTENSA_OP_EXIT_TB_0,
     }, {
         .name = "wsr.ccompare2",
-        .translate = translate_wsr,
-        .test_ill = test_ill_wsr,
-        .par = (const uint32_t[]){CCOMPARE + 2},
+        .translate = translate_wsr_ccompare,
+        .test_ill = test_ill_ccompare,
+        .par = (const uint32_t[]){
+            CCOMPARE + 2,
+            XTENSA_OPTION_TIMER_INTERRUPT,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED | XTENSA_OP_EXIT_TB_0,
     }, {
         .name = "wsr.ccount",
-        .translate = translate_wsr,
-        .test_ill = test_ill_wsr,
-        .par = (const uint32_t[]){CCOUNT},
+        .translate = translate_wsr_ccount,
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            CCOUNT,
+            XTENSA_OPTION_TIMER_INTERRUPT,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED | XTENSA_OP_EXIT_TB_0,
     }, {
         .name = "wsr.configid0",
-        .translate = translate_wsr,
-        .test_ill = test_ill_wsr,
-        .par = (const uint32_t[]){CONFIGID0},
-        .op_flags = XTENSA_OP_PRIVILEGED,
+        .op_flags = XTENSA_OP_ILL,
     }, {
         .name = "wsr.configid1",
-        .translate = translate_wsr,
-        .test_ill = test_ill_wsr,
-        .par = (const uint32_t[]){CONFIGID1},
-        .op_flags = XTENSA_OP_PRIVILEGED,
+        .op_flags = XTENSA_OP_ILL,
     }, {
         .name = "wsr.cpenable",
-        .translate = translate_wsr,
-        .test_ill = test_ill_wsr,
-        .par = (const uint32_t[]){CPENABLE},
+        .translate = translate_wsr_mask,
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            CPENABLE,
+            XTENSA_OPTION_COPROCESSOR,
+            0xff,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED | XTENSA_OP_EXIT_TB_M1,
     }, {
         .name = "wsr.dbreaka0",
-        .translate = translate_wsr,
-        .test_ill = test_ill_wsr,
-        .par = (const uint32_t[]){DBREAKA},
+        .translate = translate_wsr_dbreaka,
+        .test_ill = test_ill_dbreak,
+        .par = (const uint32_t[]){
+            DBREAKA,
+            XTENSA_OPTION_DEBUG,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "wsr.dbreaka1",
-        .translate = translate_wsr,
-        .test_ill = test_ill_wsr,
-        .par = (const uint32_t[]){DBREAKA + 1},
+        .translate = translate_wsr_dbreaka,
+        .test_ill = test_ill_dbreak,
+        .par = (const uint32_t[]){
+            DBREAKA + 1,
+            XTENSA_OPTION_DEBUG,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "wsr.dbreakc0",
-        .translate = translate_wsr,
-        .test_ill = test_ill_wsr,
-        .par = (const uint32_t[]){DBREAKC},
+        .translate = translate_wsr_dbreakc,
+        .test_ill = test_ill_dbreak,
+        .par = (const uint32_t[]){
+            DBREAKC,
+            XTENSA_OPTION_DEBUG,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "wsr.dbreakc1",
-        .translate = translate_wsr,
-        .test_ill = test_ill_wsr,
-        .par = (const uint32_t[]){DBREAKC + 1},
+        .translate = translate_wsr_dbreakc,
+        .test_ill = test_ill_dbreak,
+        .par = (const uint32_t[]){
+            DBREAKC + 1,
+            XTENSA_OPTION_DEBUG,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "wsr.ddr",
         .translate = translate_wsr,
-        .test_ill = test_ill_wsr,
-        .par = (const uint32_t[]){DDR},
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            DDR,
+            XTENSA_OPTION_DEBUG,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "wsr.debugcause",
-        .translate = translate_wsr,
-        .test_ill = test_ill_wsr,
-        .par = (const uint32_t[]){DEBUGCAUSE},
-        .op_flags = XTENSA_OP_PRIVILEGED,
+        .op_flags = XTENSA_OP_ILL,
     }, {
         .name = "wsr.depc",
         .translate = translate_wsr,
-        .test_ill = test_ill_wsr,
-        .par = (const uint32_t[]){DEPC},
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            DEPC,
+            XTENSA_OPTION_EXCEPTION,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "wsr.dtlbcfg",
-        .translate = translate_wsr,
-        .test_ill = test_ill_wsr,
-        .par = (const uint32_t[]){DTLBCFG},
+        .translate = translate_wsr_mask,
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            DTLBCFG,
+            XTENSA_OPTION_MMU,
+            0x01130000,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "wsr.epc1",
         .translate = translate_wsr,
-        .test_ill = test_ill_wsr,
-        .par = (const uint32_t[]){EPC1},
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            EPC1,
+            XTENSA_OPTION_EXCEPTION,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "wsr.epc2",
         .translate = translate_wsr,
-        .test_ill = test_ill_wsr,
-        .par = (const uint32_t[]){EPC1 + 1},
+        .test_ill = test_ill_hpi,
+        .par = (const uint32_t[]){
+            EPC1 + 1,
+            XTENSA_OPTION_HIGH_PRIORITY_INTERRUPT,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "wsr.epc3",
         .translate = translate_wsr,
-        .test_ill = test_ill_wsr,
-        .par = (const uint32_t[]){EPC1 + 2},
+        .test_ill = test_ill_hpi,
+        .par = (const uint32_t[]){
+            EPC1 + 2,
+            XTENSA_OPTION_HIGH_PRIORITY_INTERRUPT,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "wsr.epc4",
         .translate = translate_wsr,
-        .test_ill = test_ill_wsr,
-        .par = (const uint32_t[]){EPC1 + 3},
+        .test_ill = test_ill_hpi,
+        .par = (const uint32_t[]){
+            EPC1 + 3,
+            XTENSA_OPTION_HIGH_PRIORITY_INTERRUPT,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "wsr.epc5",
         .translate = translate_wsr,
-        .test_ill = test_ill_wsr,
-        .par = (const uint32_t[]){EPC1 + 4},
+        .test_ill = test_ill_hpi,
+        .par = (const uint32_t[]){
+            EPC1 + 4,
+            XTENSA_OPTION_HIGH_PRIORITY_INTERRUPT,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "wsr.epc6",
         .translate = translate_wsr,
-        .test_ill = test_ill_wsr,
-        .par = (const uint32_t[]){EPC1 + 5},
+        .test_ill = test_ill_hpi,
+        .par = (const uint32_t[]){
+            EPC1 + 5,
+            XTENSA_OPTION_HIGH_PRIORITY_INTERRUPT,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "wsr.epc7",
         .translate = translate_wsr,
-        .test_ill = test_ill_wsr,
-        .par = (const uint32_t[]){EPC1 + 6},
+        .test_ill = test_ill_hpi,
+        .par = (const uint32_t[]){
+            EPC1 + 6,
+            XTENSA_OPTION_HIGH_PRIORITY_INTERRUPT,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "wsr.eps2",
         .translate = translate_wsr,
-        .test_ill = test_ill_wsr,
-        .par = (const uint32_t[]){EPS2},
+        .test_ill = test_ill_hpi,
+        .par = (const uint32_t[]){
+            EPS2,
+            XTENSA_OPTION_HIGH_PRIORITY_INTERRUPT,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "wsr.eps3",
         .translate = translate_wsr,
-        .test_ill = test_ill_wsr,
-        .par = (const uint32_t[]){EPS2 + 1},
+        .test_ill = test_ill_hpi,
+        .par = (const uint32_t[]){
+            EPS2 + 1,
+            XTENSA_OPTION_HIGH_PRIORITY_INTERRUPT,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "wsr.eps4",
         .translate = translate_wsr,
-        .test_ill = test_ill_wsr,
-        .par = (const uint32_t[]){EPS2 + 2},
+        .test_ill = test_ill_hpi,
+        .par = (const uint32_t[]){
+            EPS2 + 2,
+            XTENSA_OPTION_HIGH_PRIORITY_INTERRUPT,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "wsr.eps5",
         .translate = translate_wsr,
-        .test_ill = test_ill_wsr,
-        .par = (const uint32_t[]){EPS2 + 3},
+        .test_ill = test_ill_hpi,
+        .par = (const uint32_t[]){
+            EPS2 + 3,
+            XTENSA_OPTION_HIGH_PRIORITY_INTERRUPT,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "wsr.eps6",
         .translate = translate_wsr,
-        .test_ill = test_ill_wsr,
-        .par = (const uint32_t[]){EPS2 + 4},
+        .test_ill = test_ill_hpi,
+        .par = (const uint32_t[]){
+            EPS2 + 4,
+            XTENSA_OPTION_HIGH_PRIORITY_INTERRUPT,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "wsr.eps7",
         .translate = translate_wsr,
-        .test_ill = test_ill_wsr,
-        .par = (const uint32_t[]){EPS2 + 5},
+        .test_ill = test_ill_hpi,
+        .par = (const uint32_t[]){
+            EPS2 + 5,
+            XTENSA_OPTION_HIGH_PRIORITY_INTERRUPT,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "wsr.exccause",
         .translate = translate_wsr,
-        .test_ill = test_ill_wsr,
-        .par = (const uint32_t[]){EXCCAUSE},
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            EXCCAUSE,
+            XTENSA_OPTION_EXCEPTION,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "wsr.excsave1",
         .translate = translate_wsr,
-        .test_ill = test_ill_wsr,
-        .par = (const uint32_t[]){EXCSAVE1},
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            EXCSAVE1,
+            XTENSA_OPTION_EXCEPTION,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "wsr.excsave2",
         .translate = translate_wsr,
-        .test_ill = test_ill_wsr,
-        .par = (const uint32_t[]){EXCSAVE1 + 1},
+        .test_ill = test_ill_hpi,
+        .par = (const uint32_t[]){
+            EXCSAVE1 + 1,
+            XTENSA_OPTION_HIGH_PRIORITY_INTERRUPT,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "wsr.excsave3",
         .translate = translate_wsr,
-        .test_ill = test_ill_wsr,
-        .par = (const uint32_t[]){EXCSAVE1 + 2},
+        .test_ill = test_ill_hpi,
+        .par = (const uint32_t[]){
+            EXCSAVE1 + 2,
+            XTENSA_OPTION_HIGH_PRIORITY_INTERRUPT,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "wsr.excsave4",
         .translate = translate_wsr,
-        .test_ill = test_ill_wsr,
-        .par = (const uint32_t[]){EXCSAVE1 + 3},
+        .test_ill = test_ill_hpi,
+        .par = (const uint32_t[]){
+            EXCSAVE1 + 3,
+            XTENSA_OPTION_HIGH_PRIORITY_INTERRUPT,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "wsr.excsave5",
         .translate = translate_wsr,
-        .test_ill = test_ill_wsr,
-        .par = (const uint32_t[]){EXCSAVE1 + 4},
+        .test_ill = test_ill_hpi,
+        .par = (const uint32_t[]){
+            EXCSAVE1 + 4,
+            XTENSA_OPTION_HIGH_PRIORITY_INTERRUPT,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "wsr.excsave6",
         .translate = translate_wsr,
-        .test_ill = test_ill_wsr,
-        .par = (const uint32_t[]){EXCSAVE1 + 5},
+        .test_ill = test_ill_hpi,
+        .par = (const uint32_t[]){
+            EXCSAVE1 + 5,
+            XTENSA_OPTION_HIGH_PRIORITY_INTERRUPT,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "wsr.excsave7",
         .translate = translate_wsr,
-        .test_ill = test_ill_wsr,
-        .par = (const uint32_t[]){EXCSAVE1 + 6},
+        .test_ill = test_ill_hpi,
+        .par = (const uint32_t[]){
+            EXCSAVE1 + 6,
+            XTENSA_OPTION_HIGH_PRIORITY_INTERRUPT,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "wsr.excvaddr",
         .translate = translate_wsr,
-        .test_ill = test_ill_wsr,
-        .par = (const uint32_t[]){EXCVADDR},
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            EXCVADDR,
+            XTENSA_OPTION_EXCEPTION,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "wsr.ibreaka0",
-        .translate = translate_wsr,
-        .test_ill = test_ill_wsr,
-        .par = (const uint32_t[]){IBREAKA},
+        .translate = translate_wsr_ibreaka,
+        .test_ill = test_ill_ibreak,
+        .par = (const uint32_t[]){
+            IBREAKA,
+            XTENSA_OPTION_DEBUG,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED | XTENSA_OP_EXIT_TB_0,
     }, {
         .name = "wsr.ibreaka1",
-        .translate = translate_wsr,
-        .test_ill = test_ill_wsr,
-        .par = (const uint32_t[]){IBREAKA + 1},
+        .translate = translate_wsr_ibreaka,
+        .test_ill = test_ill_ibreak,
+        .par = (const uint32_t[]){
+            IBREAKA + 1,
+            XTENSA_OPTION_DEBUG,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED | XTENSA_OP_EXIT_TB_0,
     }, {
         .name = "wsr.ibreakenable",
-        .translate = translate_wsr,
-        .test_ill = test_ill_wsr,
-        .par = (const uint32_t[]){IBREAKENABLE},
+        .translate = translate_wsr_ibreakenable,
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            IBREAKENABLE,
+            XTENSA_OPTION_DEBUG,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED | XTENSA_OP_EXIT_TB_0,
     }, {
         .name = "wsr.icount",
-        .translate = translate_wsr,
-        .test_ill = test_ill_wsr,
-        .par = (const uint32_t[]){ICOUNT},
+        .translate = translate_wsr_icount,
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            ICOUNT,
+            XTENSA_OPTION_DEBUG,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "wsr.icountlevel",
-        .translate = translate_wsr,
-        .test_ill = test_ill_wsr,
-        .par = (const uint32_t[]){ICOUNTLEVEL},
+        .translate = translate_wsr_mask,
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            ICOUNTLEVEL,
+            XTENSA_OPTION_DEBUG,
+            0xf,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED | XTENSA_OP_EXIT_TB_M1,
     }, {
         .name = "wsr.intclear",
-        .translate = translate_wsr,
-        .test_ill = test_ill_wsr,
-        .par = (const uint32_t[]){INTCLEAR},
+        .translate = translate_wsr_intclear,
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            INTCLEAR,
+            XTENSA_OPTION_INTERRUPT,
+        },
         .op_flags =
             XTENSA_OP_PRIVILEGED |
             XTENSA_OP_EXIT_TB_0 |
@@ -4675,8 +4919,11 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "wsr.intenable",
         .translate = translate_wsr,
-        .test_ill = test_ill_wsr,
-        .par = (const uint32_t[]){INTENABLE},
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            INTENABLE,
+            XTENSA_OPTION_INTERRUPT,
+        },
         .op_flags =
             XTENSA_OP_PRIVILEGED |
             XTENSA_OP_EXIT_TB_0 |
@@ -4684,167 +4931,233 @@ static const XtensaOpcodeOps core_ops[] = {
     }, {
         .name = "wsr.interrupt",
         .translate = translate_wsr,
-        .test_ill = test_ill_wsr,
-        .par = (const uint32_t[]){INTSET},
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            INTSET,
+            XTENSA_OPTION_INTERRUPT,
+        },
         .op_flags =
             XTENSA_OP_PRIVILEGED |
             XTENSA_OP_EXIT_TB_0 |
             XTENSA_OP_CHECK_INTERRUPTS,
     }, {
         .name = "wsr.intset",
-        .translate = translate_wsr,
-        .test_ill = test_ill_wsr,
-        .par = (const uint32_t[]){INTSET},
+        .translate = translate_wsr_intset,
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            INTSET,
+            XTENSA_OPTION_INTERRUPT,
+        },
         .op_flags =
             XTENSA_OP_PRIVILEGED |
             XTENSA_OP_EXIT_TB_0 |
             XTENSA_OP_CHECK_INTERRUPTS,
     }, {
         .name = "wsr.itlbcfg",
-        .translate = translate_wsr,
-        .test_ill = test_ill_wsr,
-        .par = (const uint32_t[]){ITLBCFG},
+        .translate = translate_wsr_mask,
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            ITLBCFG,
+            XTENSA_OPTION_MMU,
+            0x01130000,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "wsr.lbeg",
         .translate = translate_wsr,
-        .test_ill = test_ill_wsr,
-        .par = (const uint32_t[]){LBEG},
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            LBEG,
+            XTENSA_OPTION_LOOP,
+        },
         .op_flags = XTENSA_OP_EXIT_TB_M1,
     }, {
         .name = "wsr.lcount",
         .translate = translate_wsr,
-        .test_ill = test_ill_wsr,
-        .par = (const uint32_t[]){LCOUNT},
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            LCOUNT,
+            XTENSA_OPTION_LOOP,
+        },
     }, {
         .name = "wsr.lend",
         .translate = translate_wsr,
-        .test_ill = test_ill_wsr,
-        .par = (const uint32_t[]){LEND},
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            LEND,
+            XTENSA_OPTION_LOOP,
+        },
         .op_flags = XTENSA_OP_EXIT_TB_M1,
     }, {
         .name = "wsr.litbase",
-        .translate = translate_wsr,
-        .test_ill = test_ill_wsr,
-        .par = (const uint32_t[]){LITBASE},
+        .translate = translate_wsr_mask,
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            LITBASE,
+            XTENSA_OPTION_EXTENDED_L32R,
+            0xfffff001,
+        },
         .op_flags = XTENSA_OP_EXIT_TB_M1,
     }, {
         .name = "wsr.m0",
         .translate = translate_wsr,
-        .test_ill = test_ill_wsr,
-        .par = (const uint32_t[]){MR},
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            MR,
+            XTENSA_OPTION_MAC16,
+        },
     }, {
         .name = "wsr.m1",
         .translate = translate_wsr,
-        .test_ill = test_ill_wsr,
-        .par = (const uint32_t[]){MR + 1},
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            MR + 1,
+            XTENSA_OPTION_MAC16,
+        },
     }, {
         .name = "wsr.m2",
         .translate = translate_wsr,
-        .test_ill = test_ill_wsr,
-        .par = (const uint32_t[]){MR + 2},
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            MR + 2,
+            XTENSA_OPTION_MAC16,
+        },
     }, {
         .name = "wsr.m3",
         .translate = translate_wsr,
-        .test_ill = test_ill_wsr,
-        .par = (const uint32_t[]){MR + 3},
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            MR + 3,
+            XTENSA_OPTION_MAC16,
+        },
     }, {
         .name = "wsr.memctl",
-        .translate = translate_wsr,
-        .test_ill = test_ill_wsr,
+        .translate = translate_wsr_memctl,
         .par = (const uint32_t[]){MEMCTL},
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "wsr.misc0",
         .translate = translate_wsr,
-        .test_ill = test_ill_wsr,
-        .par = (const uint32_t[]){MISC},
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            MISC,
+            XTENSA_OPTION_MISC_SR,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "wsr.misc1",
         .translate = translate_wsr,
-        .test_ill = test_ill_wsr,
-        .par = (const uint32_t[]){MISC + 1},
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            MISC + 1,
+            XTENSA_OPTION_MISC_SR,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "wsr.misc2",
         .translate = translate_wsr,
-        .test_ill = test_ill_wsr,
-        .par = (const uint32_t[]){MISC + 2},
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            MISC + 2,
+            XTENSA_OPTION_MISC_SR,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "wsr.misc3",
         .translate = translate_wsr,
-        .test_ill = test_ill_wsr,
-        .par = (const uint32_t[]){MISC + 3},
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            MISC + 3,
+            XTENSA_OPTION_MISC_SR,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "wsr.mmid",
         .translate = translate_wsr,
-        .test_ill = test_ill_wsr,
-        .par = (const uint32_t[]){MMID},
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            MMID,
+            XTENSA_OPTION_TRACE_PORT,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "wsr.prefctl",
         .translate = translate_wsr,
-        .test_ill = test_ill_wsr,
         .par = (const uint32_t[]){PREFCTL},
     }, {
         .name = "wsr.prid",
-        .translate = translate_wsr,
-        .test_ill = test_ill_wsr,
-        .par = (const uint32_t[]){PRID},
-        .op_flags = XTENSA_OP_PRIVILEGED,
+        .op_flags = XTENSA_OP_ILL,
     }, {
         .name = "wsr.ps",
-        .translate = translate_wsr,
-        .test_ill = test_ill_wsr,
-        .par = (const uint32_t[]){PS},
+        .translate = translate_wsr_ps,
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            PS,
+            XTENSA_OPTION_EXCEPTION,
+        },
         .op_flags =
             XTENSA_OP_PRIVILEGED |
             XTENSA_OP_EXIT_TB_M1 |
             XTENSA_OP_CHECK_INTERRUPTS,
     }, {
         .name = "wsr.ptevaddr",
-        .translate = translate_wsr,
-        .test_ill = test_ill_wsr,
-        .par = (const uint32_t[]){PTEVADDR},
+        .translate = translate_wsr_mask,
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            PTEVADDR,
+            XTENSA_OPTION_MMU,
+            0xffc00000,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "wsr.rasid",
-        .translate = translate_wsr,
-        .test_ill = test_ill_wsr,
-        .par = (const uint32_t[]){RASID},
+        .translate = translate_wsr_rasid,
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            RASID,
+            XTENSA_OPTION_MMU,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED | XTENSA_OP_EXIT_TB_M1,
     }, {
         .name = "wsr.sar",
-        .translate = translate_wsr,
-        .test_ill = test_ill_wsr,
+        .translate = translate_wsr_sar,
         .par = (const uint32_t[]){SAR},
     }, {
         .name = "wsr.scompare1",
         .translate = translate_wsr,
-        .test_ill = test_ill_wsr,
-        .par = (const uint32_t[]){SCOMPARE1},
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            SCOMPARE1,
+            XTENSA_OPTION_CONDITIONAL_STORE,
+        },
     }, {
         .name = "wsr.vecbase",
         .translate = translate_wsr,
-        .test_ill = test_ill_wsr,
-        .par = (const uint32_t[]){VECBASE},
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            VECBASE,
+            XTENSA_OPTION_RELOCATABLE_VECTOR,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "wsr.windowbase",
-        .translate = translate_wsr,
-        .test_ill = test_ill_wsr,
-        .par = (const uint32_t[]){WINDOW_BASE},
+        .translate = translate_wsr_windowbase,
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            WINDOW_BASE,
+            XTENSA_OPTION_WINDOWED_REGISTER,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED |
             XTENSA_OP_EXIT_TB_M1 |
             XTENSA_OP_SYNC_REGISTER_WINDOW,
     }, {
         .name = "wsr.windowstart",
-        .translate = translate_wsr,
-        .test_ill = test_ill_wsr,
-        .par = (const uint32_t[]){WINDOW_START},
+        .translate = translate_wsr_windowstart,
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            WINDOW_START,
+            XTENSA_OPTION_WINDOWED_REGISTER,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED | XTENSA_OP_EXIT_TB_M1,
     }, {
         .name = "wur.expstate",
@@ -4852,12 +5165,12 @@ static const XtensaOpcodeOps core_ops[] = {
         .par = (const uint32_t[]){EXPSTATE},
     }, {
         .name = "wur.fcr",
-        .translate = translate_wur,
+        .translate = translate_wur_fcr,
         .par = (const uint32_t[]){FCR},
         .coprocessor = 0x1,
     }, {
         .name = "wur.fsr",
-        .translate = translate_wur,
+        .translate = translate_wur_fsr,
         .par = (const uint32_t[]){FSR},
         .coprocessor = 0x1,
     }, {
@@ -4873,471 +5186,635 @@ static const XtensaOpcodeOps core_ops[] = {
         .par = (const uint32_t[]){BOOLEAN_XOR},
     }, {
         .name = "xsr.176",
-        .translate = translate_xsr,
-        .test_ill = test_ill_xsr,
-        .par = (const uint32_t[]){176},
-        .op_flags = XTENSA_OP_PRIVILEGED,
+        .op_flags = XTENSA_OP_ILL,
     }, {
         .name = "xsr.208",
-        .translate = translate_xsr,
-        .test_ill = test_ill_xsr,
-        .par = (const uint32_t[]){208},
-        .op_flags = XTENSA_OP_PRIVILEGED,
+        .op_flags = XTENSA_OP_ILL,
     }, {
         .name = "xsr.acchi",
-        .translate = translate_xsr,
-        .test_ill = test_ill_xsr,
-        .par = (const uint32_t[]){ACCHI},
+        .translate = translate_xsr_acchi,
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            ACCHI,
+            XTENSA_OPTION_MAC16,
+        },
     }, {
         .name = "xsr.acclo",
         .translate = translate_xsr,
-        .test_ill = test_ill_xsr,
-        .par = (const uint32_t[]){ACCLO},
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            ACCLO,
+            XTENSA_OPTION_MAC16,
+        },
     }, {
         .name = "xsr.atomctl",
-        .translate = translate_xsr,
-        .test_ill = test_ill_xsr,
-        .par = (const uint32_t[]){ATOMCTL},
+        .translate = translate_xsr_mask,
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            ATOMCTL,
+            XTENSA_OPTION_ATOMCTL,
+            0x3f,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "xsr.br",
-        .translate = translate_xsr,
-        .test_ill = test_ill_xsr,
-        .par = (const uint32_t[]){BR},
+        .translate = translate_xsr_mask,
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            BR,
+            XTENSA_OPTION_BOOLEAN,
+            0xffff,
+        },
     }, {
         .name = "xsr.cacheattr",
         .translate = translate_xsr,
-        .test_ill = test_ill_xsr,
-        .par = (const uint32_t[]){CACHEATTR},
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            CACHEATTR,
+            XTENSA_OPTION_CACHEATTR,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "xsr.ccompare0",
-        .translate = translate_xsr,
-        .test_ill = test_ill_xsr,
-        .par = (const uint32_t[]){CCOMPARE},
+        .translate = translate_xsr_ccompare,
+        .test_ill = test_ill_ccompare,
+        .par = (const uint32_t[]){
+            CCOMPARE,
+            XTENSA_OPTION_TIMER_INTERRUPT,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED | XTENSA_OP_EXIT_TB_0,
     }, {
         .name = "xsr.ccompare1",
-        .translate = translate_xsr,
-        .test_ill = test_ill_xsr,
-        .par = (const uint32_t[]){CCOMPARE + 1},
+        .translate = translate_xsr_ccompare,
+        .test_ill = test_ill_ccompare,
+        .par = (const uint32_t[]){
+            CCOMPARE + 1,
+            XTENSA_OPTION_TIMER_INTERRUPT,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED | XTENSA_OP_EXIT_TB_0,
     }, {
         .name = "xsr.ccompare2",
-        .translate = translate_xsr,
-        .test_ill = test_ill_xsr,
-        .par = (const uint32_t[]){CCOMPARE + 2},
+        .translate = translate_xsr_ccompare,
+        .test_ill = test_ill_ccompare,
+        .par = (const uint32_t[]){
+            CCOMPARE + 2,
+            XTENSA_OPTION_TIMER_INTERRUPT,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED | XTENSA_OP_EXIT_TB_0,
     }, {
         .name = "xsr.ccount",
-        .translate = translate_xsr,
-        .test_ill = test_ill_xsr,
-        .par = (const uint32_t[]){CCOUNT},
+        .translate = translate_xsr_ccount,
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            CCOUNT,
+            XTENSA_OPTION_TIMER_INTERRUPT,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED | XTENSA_OP_EXIT_TB_0,
     }, {
         .name = "xsr.configid0",
-        .translate = translate_xsr,
-        .test_ill = test_ill_xsr,
-        .par = (const uint32_t[]){CONFIGID0},
-        .op_flags = XTENSA_OP_PRIVILEGED,
+        .op_flags = XTENSA_OP_ILL,
     }, {
         .name = "xsr.configid1",
-        .translate = translate_xsr,
-        .test_ill = test_ill_xsr,
-        .par = (const uint32_t[]){CONFIGID1},
-        .op_flags = XTENSA_OP_PRIVILEGED,
+        .op_flags = XTENSA_OP_ILL,
     }, {
         .name = "xsr.cpenable",
-        .translate = translate_xsr,
-        .test_ill = test_ill_xsr,
-        .par = (const uint32_t[]){CPENABLE},
+        .translate = translate_xsr_mask,
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            CPENABLE,
+            XTENSA_OPTION_COPROCESSOR,
+            0xff,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED | XTENSA_OP_EXIT_TB_M1,
     }, {
         .name = "xsr.dbreaka0",
-        .translate = translate_xsr,
-        .test_ill = test_ill_xsr,
-        .par = (const uint32_t[]){DBREAKA},
+        .translate = translate_xsr_dbreaka,
+        .test_ill = test_ill_dbreak,
+        .par = (const uint32_t[]){
+            DBREAKA,
+            XTENSA_OPTION_DEBUG,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "xsr.dbreaka1",
-        .translate = translate_xsr,
-        .test_ill = test_ill_xsr,
-        .par = (const uint32_t[]){DBREAKA + 1},
+        .translate = translate_xsr_dbreaka,
+        .test_ill = test_ill_dbreak,
+        .par = (const uint32_t[]){
+            DBREAKA + 1,
+            XTENSA_OPTION_DEBUG,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "xsr.dbreakc0",
-        .translate = translate_xsr,
-        .test_ill = test_ill_xsr,
-        .par = (const uint32_t[]){DBREAKC},
+        .translate = translate_xsr_dbreakc,
+        .test_ill = test_ill_dbreak,
+        .par = (const uint32_t[]){
+            DBREAKC,
+            XTENSA_OPTION_DEBUG,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "xsr.dbreakc1",
-        .translate = translate_xsr,
-        .test_ill = test_ill_xsr,
-        .par = (const uint32_t[]){DBREAKC + 1},
+        .translate = translate_xsr_dbreakc,
+        .test_ill = test_ill_dbreak,
+        .par = (const uint32_t[]){
+            DBREAKC + 1,
+            XTENSA_OPTION_DEBUG,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "xsr.ddr",
         .translate = translate_xsr,
-        .test_ill = test_ill_xsr,
-        .par = (const uint32_t[]){DDR},
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            DDR,
+            XTENSA_OPTION_DEBUG,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "xsr.debugcause",
-        .translate = translate_xsr,
-        .test_ill = test_ill_xsr,
-        .par = (const uint32_t[]){DEBUGCAUSE},
-        .op_flags = XTENSA_OP_PRIVILEGED,
+        .op_flags = XTENSA_OP_ILL,
     }, {
         .name = "xsr.depc",
         .translate = translate_xsr,
-        .test_ill = test_ill_xsr,
-        .par = (const uint32_t[]){DEPC},
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            DEPC,
+            XTENSA_OPTION_EXCEPTION,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "xsr.dtlbcfg",
-        .translate = translate_xsr,
-        .test_ill = test_ill_xsr,
-        .par = (const uint32_t[]){DTLBCFG},
+        .translate = translate_xsr_mask,
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            DTLBCFG,
+            XTENSA_OPTION_MMU,
+            0x01130000,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "xsr.epc1",
         .translate = translate_xsr,
-        .test_ill = test_ill_xsr,
-        .par = (const uint32_t[]){EPC1},
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            EPC1,
+            XTENSA_OPTION_EXCEPTION,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "xsr.epc2",
         .translate = translate_xsr,
-        .test_ill = test_ill_xsr,
-        .par = (const uint32_t[]){EPC1 + 1},
+        .test_ill = test_ill_hpi,
+        .par = (const uint32_t[]){
+            EPC1 + 1,
+            XTENSA_OPTION_HIGH_PRIORITY_INTERRUPT,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "xsr.epc3",
         .translate = translate_xsr,
-        .test_ill = test_ill_xsr,
-        .par = (const uint32_t[]){EPC1 + 2},
+        .test_ill = test_ill_hpi,
+        .par = (const uint32_t[]){
+            EPC1 + 2,
+            XTENSA_OPTION_HIGH_PRIORITY_INTERRUPT,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "xsr.epc4",
         .translate = translate_xsr,
-        .test_ill = test_ill_xsr,
-        .par = (const uint32_t[]){EPC1 + 3},
+        .test_ill = test_ill_hpi,
+        .par = (const uint32_t[]){
+            EPC1 + 3,
+            XTENSA_OPTION_HIGH_PRIORITY_INTERRUPT,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "xsr.epc5",
         .translate = translate_xsr,
-        .test_ill = test_ill_xsr,
-        .par = (const uint32_t[]){EPC1 + 4},
+        .test_ill = test_ill_hpi,
+        .par = (const uint32_t[]){
+            EPC1 + 4,
+            XTENSA_OPTION_HIGH_PRIORITY_INTERRUPT,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "xsr.epc6",
         .translate = translate_xsr,
-        .test_ill = test_ill_xsr,
-        .par = (const uint32_t[]){EPC1 + 5},
+        .test_ill = test_ill_hpi,
+        .par = (const uint32_t[]){
+            EPC1 + 5,
+            XTENSA_OPTION_HIGH_PRIORITY_INTERRUPT,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "xsr.epc7",
         .translate = translate_xsr,
-        .test_ill = test_ill_xsr,
-        .par = (const uint32_t[]){EPC1 + 6},
+        .test_ill = test_ill_hpi,
+        .par = (const uint32_t[]){
+            EPC1 + 6,
+            XTENSA_OPTION_HIGH_PRIORITY_INTERRUPT,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "xsr.eps2",
         .translate = translate_xsr,
-        .test_ill = test_ill_xsr,
-        .par = (const uint32_t[]){EPS2},
+        .test_ill = test_ill_hpi,
+        .par = (const uint32_t[]){
+            EPS2,
+            XTENSA_OPTION_HIGH_PRIORITY_INTERRUPT,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "xsr.eps3",
         .translate = translate_xsr,
-        .test_ill = test_ill_xsr,
-        .par = (const uint32_t[]){EPS2 + 1},
+        .test_ill = test_ill_hpi,
+        .par = (const uint32_t[]){
+            EPS2 + 1,
+            XTENSA_OPTION_HIGH_PRIORITY_INTERRUPT,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "xsr.eps4",
         .translate = translate_xsr,
-        .test_ill = test_ill_xsr,
-        .par = (const uint32_t[]){EPS2 + 2},
+        .test_ill = test_ill_hpi,
+        .par = (const uint32_t[]){
+            EPS2 + 2,
+            XTENSA_OPTION_HIGH_PRIORITY_INTERRUPT,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "xsr.eps5",
         .translate = translate_xsr,
-        .test_ill = test_ill_xsr,
-        .par = (const uint32_t[]){EPS2 + 3},
+        .test_ill = test_ill_hpi,
+        .par = (const uint32_t[]){
+            EPS2 + 3,
+            XTENSA_OPTION_HIGH_PRIORITY_INTERRUPT,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "xsr.eps6",
         .translate = translate_xsr,
-        .test_ill = test_ill_xsr,
-        .par = (const uint32_t[]){EPS2 + 4},
+        .test_ill = test_ill_hpi,
+        .par = (const uint32_t[]){
+            EPS2 + 4,
+            XTENSA_OPTION_HIGH_PRIORITY_INTERRUPT,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "xsr.eps7",
         .translate = translate_xsr,
-        .test_ill = test_ill_xsr,
-        .par = (const uint32_t[]){EPS2 + 5},
+        .test_ill = test_ill_hpi,
+        .par = (const uint32_t[]){
+            EPS2 + 5,
+            XTENSA_OPTION_HIGH_PRIORITY_INTERRUPT,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "xsr.exccause",
         .translate = translate_xsr,
-        .test_ill = test_ill_xsr,
-        .par = (const uint32_t[]){EXCCAUSE},
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            EXCCAUSE,
+            XTENSA_OPTION_EXCEPTION,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "xsr.excsave1",
         .translate = translate_xsr,
-        .test_ill = test_ill_xsr,
-        .par = (const uint32_t[]){EXCSAVE1},
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            EXCSAVE1,
+            XTENSA_OPTION_EXCEPTION,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "xsr.excsave2",
         .translate = translate_xsr,
-        .test_ill = test_ill_xsr,
-        .par = (const uint32_t[]){EXCSAVE1 + 1},
+        .test_ill = test_ill_hpi,
+        .par = (const uint32_t[]){
+            EXCSAVE1 + 1,
+            XTENSA_OPTION_HIGH_PRIORITY_INTERRUPT,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "xsr.excsave3",
         .translate = translate_xsr,
-        .test_ill = test_ill_xsr,
-        .par = (const uint32_t[]){EXCSAVE1 + 2},
+        .test_ill = test_ill_hpi,
+        .par = (const uint32_t[]){
+            EXCSAVE1 + 2,
+            XTENSA_OPTION_HIGH_PRIORITY_INTERRUPT,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "xsr.excsave4",
         .translate = translate_xsr,
-        .test_ill = test_ill_xsr,
-        .par = (const uint32_t[]){EXCSAVE1 + 3},
+        .test_ill = test_ill_hpi,
+        .par = (const uint32_t[]){
+            EXCSAVE1 + 3,
+            XTENSA_OPTION_HIGH_PRIORITY_INTERRUPT,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "xsr.excsave5",
         .translate = translate_xsr,
-        .test_ill = test_ill_xsr,
-        .par = (const uint32_t[]){EXCSAVE1 + 4},
+        .test_ill = test_ill_hpi,
+        .par = (const uint32_t[]){
+            EXCSAVE1 + 4,
+            XTENSA_OPTION_HIGH_PRIORITY_INTERRUPT,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "xsr.excsave6",
         .translate = translate_xsr,
-        .test_ill = test_ill_xsr,
-        .par = (const uint32_t[]){EXCSAVE1 + 5},
+        .test_ill = test_ill_hpi,
+        .par = (const uint32_t[]){
+            EXCSAVE1 + 5,
+            XTENSA_OPTION_HIGH_PRIORITY_INTERRUPT,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "xsr.excsave7",
         .translate = translate_xsr,
-        .test_ill = test_ill_xsr,
-        .par = (const uint32_t[]){EXCSAVE1 + 6},
+        .test_ill = test_ill_hpi,
+        .par = (const uint32_t[]){
+            EXCSAVE1 + 6,
+            XTENSA_OPTION_HIGH_PRIORITY_INTERRUPT,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "xsr.excvaddr",
         .translate = translate_xsr,
-        .test_ill = test_ill_xsr,
-        .par = (const uint32_t[]){EXCVADDR},
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            EXCVADDR,
+            XTENSA_OPTION_EXCEPTION,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "xsr.ibreaka0",
-        .translate = translate_xsr,
-        .test_ill = test_ill_xsr,
-        .par = (const uint32_t[]){IBREAKA},
+        .translate = translate_xsr_ibreaka,
+        .test_ill = test_ill_ibreak,
+        .par = (const uint32_t[]){
+            IBREAKA,
+            XTENSA_OPTION_DEBUG,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED | XTENSA_OP_EXIT_TB_0,
     }, {
         .name = "xsr.ibreaka1",
-        .translate = translate_xsr,
-        .test_ill = test_ill_xsr,
-        .par = (const uint32_t[]){IBREAKA + 1},
+        .translate = translate_xsr_ibreaka,
+        .test_ill = test_ill_ibreak,
+        .par = (const uint32_t[]){
+            IBREAKA + 1,
+            XTENSA_OPTION_DEBUG,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED | XTENSA_OP_EXIT_TB_0,
     }, {
         .name = "xsr.ibreakenable",
-        .translate = translate_xsr,
-        .test_ill = test_ill_xsr,
-        .par = (const uint32_t[]){IBREAKENABLE},
+        .translate = translate_xsr_ibreakenable,
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            IBREAKENABLE,
+            XTENSA_OPTION_DEBUG,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED | XTENSA_OP_EXIT_TB_0,
     }, {
         .name = "xsr.icount",
-        .translate = translate_xsr,
-        .test_ill = test_ill_xsr,
-        .par = (const uint32_t[]){ICOUNT},
+        .translate = translate_xsr_icount,
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            ICOUNT,
+            XTENSA_OPTION_DEBUG,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "xsr.icountlevel",
-        .translate = translate_xsr,
-        .test_ill = test_ill_xsr,
-        .par = (const uint32_t[]){ICOUNTLEVEL},
+        .translate = translate_xsr_mask,
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            ICOUNTLEVEL,
+            XTENSA_OPTION_DEBUG,
+            0xf,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED | XTENSA_OP_EXIT_TB_M1,
     }, {
         .name = "xsr.intclear",
-        .translate = translate_xsr,
-        .test_ill = test_ill_xsr,
-        .par = (const uint32_t[]){INTCLEAR},
-        .op_flags =
-            XTENSA_OP_PRIVILEGED |
-            XTENSA_OP_EXIT_TB_0 |
-            XTENSA_OP_CHECK_INTERRUPTS,
+        .op_flags = XTENSA_OP_ILL,
     }, {
         .name = "xsr.intenable",
         .translate = translate_xsr,
-        .test_ill = test_ill_xsr,
-        .par = (const uint32_t[]){INTENABLE},
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            INTENABLE,
+            XTENSA_OPTION_INTERRUPT,
+        },
         .op_flags =
             XTENSA_OP_PRIVILEGED |
             XTENSA_OP_EXIT_TB_0 |
             XTENSA_OP_CHECK_INTERRUPTS,
     }, {
         .name = "xsr.interrupt",
-        .translate = translate_xsr,
-        .test_ill = test_ill_xsr,
-        .par = (const uint32_t[]){INTSET},
-        .op_flags =
-            XTENSA_OP_PRIVILEGED |
-            XTENSA_OP_EXIT_TB_0 |
-            XTENSA_OP_CHECK_INTERRUPTS,
+        .op_flags = XTENSA_OP_ILL,
     }, {
         .name = "xsr.intset",
-        .translate = translate_xsr,
-        .test_ill = test_ill_xsr,
-        .par = (const uint32_t[]){INTSET},
-        .op_flags =
-            XTENSA_OP_PRIVILEGED |
-            XTENSA_OP_EXIT_TB_0 |
-            XTENSA_OP_CHECK_INTERRUPTS,
+        .op_flags = XTENSA_OP_ILL,
     }, {
         .name = "xsr.itlbcfg",
-        .translate = translate_xsr,
-        .test_ill = test_ill_xsr,
-        .par = (const uint32_t[]){ITLBCFG},
+        .translate = translate_xsr_mask,
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            ITLBCFG,
+            XTENSA_OPTION_MMU,
+            0x01130000,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "xsr.lbeg",
         .translate = translate_xsr,
-        .test_ill = test_ill_xsr,
-        .par = (const uint32_t[]){LBEG},
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            LBEG,
+            XTENSA_OPTION_LOOP,
+        },
         .op_flags = XTENSA_OP_EXIT_TB_M1,
     }, {
         .name = "xsr.lcount",
         .translate = translate_xsr,
-        .test_ill = test_ill_xsr,
-        .par = (const uint32_t[]){LCOUNT},
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            LCOUNT,
+            XTENSA_OPTION_LOOP,
+        },
     }, {
         .name = "xsr.lend",
         .translate = translate_xsr,
-        .test_ill = test_ill_xsr,
-        .par = (const uint32_t[]){LEND},
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            LEND,
+            XTENSA_OPTION_LOOP,
+        },
         .op_flags = XTENSA_OP_EXIT_TB_M1,
     }, {
         .name = "xsr.litbase",
-        .translate = translate_xsr,
-        .test_ill = test_ill_xsr,
-        .par = (const uint32_t[]){LITBASE},
+        .translate = translate_xsr_mask,
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            LITBASE,
+            XTENSA_OPTION_EXTENDED_L32R,
+            0xfffff001,
+        },
         .op_flags = XTENSA_OP_EXIT_TB_M1,
     }, {
         .name = "xsr.m0",
         .translate = translate_xsr,
-        .test_ill = test_ill_xsr,
-        .par = (const uint32_t[]){MR},
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            MR,
+            XTENSA_OPTION_MAC16,
+        },
     }, {
         .name = "xsr.m1",
         .translate = translate_xsr,
-        .test_ill = test_ill_xsr,
-        .par = (const uint32_t[]){MR + 1},
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            MR + 1,
+            XTENSA_OPTION_MAC16,
+        },
     }, {
         .name = "xsr.m2",
         .translate = translate_xsr,
-        .test_ill = test_ill_xsr,
-        .par = (const uint32_t[]){MR + 2},
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            MR + 2,
+            XTENSA_OPTION_MAC16,
+        },
     }, {
         .name = "xsr.m3",
         .translate = translate_xsr,
-        .test_ill = test_ill_xsr,
-        .par = (const uint32_t[]){MR + 3},
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            MR + 3,
+            XTENSA_OPTION_MAC16,
+        },
     }, {
         .name = "xsr.memctl",
-        .translate = translate_xsr,
-        .test_ill = test_ill_xsr,
+        .translate = translate_xsr_memctl,
         .par = (const uint32_t[]){MEMCTL},
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "xsr.misc0",
         .translate = translate_xsr,
-        .test_ill = test_ill_xsr,
-        .par = (const uint32_t[]){MISC},
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            MISC,
+            XTENSA_OPTION_MISC_SR,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "xsr.misc1",
         .translate = translate_xsr,
-        .test_ill = test_ill_xsr,
-        .par = (const uint32_t[]){MISC + 1},
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            MISC + 1,
+            XTENSA_OPTION_MISC_SR,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "xsr.misc2",
         .translate = translate_xsr,
-        .test_ill = test_ill_xsr,
-        .par = (const uint32_t[]){MISC + 2},
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            MISC + 2,
+            XTENSA_OPTION_MISC_SR,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "xsr.misc3",
         .translate = translate_xsr,
-        .test_ill = test_ill_xsr,
-        .par = (const uint32_t[]){MISC + 3},
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            MISC + 3,
+            XTENSA_OPTION_MISC_SR,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "xsr.prefctl",
         .translate = translate_xsr,
-        .test_ill = test_ill_xsr,
         .par = (const uint32_t[]){PREFCTL},
     }, {
         .name = "xsr.prid",
-        .translate = translate_xsr,
-        .test_ill = test_ill_xsr,
-        .par = (const uint32_t[]){PRID},
-        .op_flags = XTENSA_OP_PRIVILEGED,
+        .op_flags = XTENSA_OP_ILL,
     }, {
         .name = "xsr.ps",
-        .translate = translate_xsr,
-        .test_ill = test_ill_xsr,
-        .par = (const uint32_t[]){PS},
+        .translate = translate_xsr_ps,
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            PS,
+            XTENSA_OPTION_EXCEPTION,
+        },
         .op_flags =
             XTENSA_OP_PRIVILEGED |
             XTENSA_OP_EXIT_TB_M1 |
             XTENSA_OP_CHECK_INTERRUPTS,
     }, {
         .name = "xsr.ptevaddr",
-        .translate = translate_xsr,
-        .test_ill = test_ill_xsr,
-        .par = (const uint32_t[]){PTEVADDR},
+        .translate = translate_xsr_mask,
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            PTEVADDR,
+            XTENSA_OPTION_MMU,
+            0xffc00000,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "xsr.rasid",
-        .translate = translate_xsr,
-        .test_ill = test_ill_xsr,
-        .par = (const uint32_t[]){RASID},
+        .translate = translate_xsr_rasid,
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            RASID,
+            XTENSA_OPTION_MMU,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED | XTENSA_OP_EXIT_TB_M1,
     }, {
         .name = "xsr.sar",
-        .translate = translate_xsr,
-        .test_ill = test_ill_xsr,
+        .translate = translate_xsr_sar,
         .par = (const uint32_t[]){SAR},
     }, {
         .name = "xsr.scompare1",
         .translate = translate_xsr,
-        .test_ill = test_ill_xsr,
-        .par = (const uint32_t[]){SCOMPARE1},
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            SCOMPARE1,
+            XTENSA_OPTION_CONDITIONAL_STORE,
+        },
     }, {
         .name = "xsr.vecbase",
         .translate = translate_xsr,
-        .test_ill = test_ill_xsr,
-        .par = (const uint32_t[]){VECBASE},
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            VECBASE,
+            XTENSA_OPTION_RELOCATABLE_VECTOR,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
         .name = "xsr.windowbase",
-        .translate = translate_xsr,
-        .test_ill = test_ill_xsr,
-        .par = (const uint32_t[]){WINDOW_BASE},
+        .translate = translate_xsr_windowbase,
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            WINDOW_BASE,
+            XTENSA_OPTION_WINDOWED_REGISTER,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED |
             XTENSA_OP_EXIT_TB_M1 |
             XTENSA_OP_SYNC_REGISTER_WINDOW,
     }, {
         .name = "xsr.windowstart",
-        .translate = translate_xsr,
-        .test_ill = test_ill_xsr,
-        .par = (const uint32_t[]){WINDOW_START},
+        .translate = translate_xsr_windowstart,
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            WINDOW_START,
+            XTENSA_OPTION_WINDOWED_REGISTER,
+        },
         .op_flags = XTENSA_OP_PRIVILEGED | XTENSA_OP_EXIT_TB_M1,
     },
 };
-- 
2.11.0


