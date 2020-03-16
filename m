Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18687C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 18:14:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7E5220409
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 18:14:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tm8/qtKC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7E5220409
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDuGB-0001sZ-0f
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 14:14:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45648)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jDtRh-0001Ex-A6
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:22:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jDtRd-0001tW-3F
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:22:33 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:55426)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jDtRc-0001lD-MJ
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:22:28 -0400
Received: by mail-wm1-x344.google.com with SMTP id 6so18582204wmi.5
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 10:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=OAqoYZ6AoMn8SDyKfeJtk3cy7lCgGq0zc51fSuhUDjQ=;
 b=tm8/qtKCPPKAj8I18/kHxp0Zsv8l8MHKVYjwDkVulW9JL9KtGKvApsDuXWqzg1PowY
 ombb8tRnmceBrPM0roX3tv18cRiIsOmtE0Vdj72/Jc6JGq0skPUNJROTJ6xdX6Jme8+W
 Pc4PopL2d/KZIfAz+tTCmZTxLnVcb9uF/0GGwGEpfXOquxSekjcVNAKzdEpklMf8C9B1
 HfGCZn+X8hP0NKwQENJSH/KTtMh9XhloK1XrshlBwtpVhtVjedjBYwUFzNkweIIWbP5z
 ZCXFrSlzDH2nnpDmlUfPR7+WDvp0yeg4fHJq6Q2hW9j7kqfCJUpdPSFFh5uBZwa+DH/y
 1YYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=OAqoYZ6AoMn8SDyKfeJtk3cy7lCgGq0zc51fSuhUDjQ=;
 b=RPzTGh2iBuc2n+XpoSzjQI0cWf5hYTTWWqB8Y5zv2gyAkSAwMeV/iETqlOZ01BQn2b
 cxeOmVax9GUMos9MeMO6cE6Tw1lu/Mx3TW6cDlxxb98yROOkCPr5CfCCxXUnC8yQN9UN
 IMCV3Gwt6cxPwXOal9BLlp2dUr+s53PfpUL0DsHq0rtnTl8Tm2944njXAd9nsjEjnPlp
 vOVeCNZj5nN1A4XgyyvHfEwmEgmQ9Zn3vLbDvIawfLGnwfW2idHrxBSXWpV7BZUaHU7f
 YOlLo4Ki4VtiFuwXh8c+ZMLAu+oWjWglkKzAX6Oe1EZeAHLcbraPpz5NqOJzcnIPL771
 t72Q==
X-Gm-Message-State: ANhLgQ0lr9FkVF/a/oa5mxnSLtYELR2hwxGNCfzTuYih35zWNEp1xxw5
 RTcUAC7g0y0XCPQM25k8lkNuqQ==
X-Google-Smtp-Source: ADFU+vvCw6jNyM6N/YuvOmeMmPi7QWnOC/boHF+rOTe+81uMwK4xVXX8d63kBvimyLNk6ip8sZo3HQ==
X-Received: by 2002:a1c:f204:: with SMTP id s4mr135951wmc.127.1584379347502;
 Mon, 16 Mar 2020 10:22:27 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id n4sm725973wrs.64.2020.03.16.10.22.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 10:22:13 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C98E91FF9E;
 Mon, 16 Mar 2020 17:21:56 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 15/28] target/arm: prepare for multiple dynamic XMLs
Date: Mon, 16 Mar 2020 17:21:42 +0000
Message-Id: <20200316172155.971-16-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200316172155.971-1-alex.bennee@linaro.org>
References: <20200316172155.971-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We will want to generate similar dynamic XML for gdbstub support of
SVE registers (the upstream doesn't use XML). To that end lightly
rename a few things to make the distinction.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Acked-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h     | 20 +++++++++++++-------
 target/arm/gdbstub.c | 30 +++++++++++++++---------------
 target/arm/helper.c  |  4 ++--
 3 files changed, 30 insertions(+), 24 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 4ab2cbfd417..0ab82c987c3 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -128,14 +128,20 @@ enum {
 /**
  * DynamicGDBXMLInfo:
  * @desc: Contains the XML descriptions.
- * @num_cpregs: Number of the Coprocessor registers seen by GDB.
- * @cpregs_keys: Array that contains the corresponding Key of
- * a given cpreg with the same order of the cpreg in the XML description.
+ * @num: Number of the registers in this XML seen by GDB.
+ * @data: A union with data specific to the set of registers
+ *    @cpregs_keys: Array that contains the corresponding Key of
+ *                  a given cpreg with the same order of the cpreg
+ *                  in the XML description.
  */
 typedef struct DynamicGDBXMLInfo {
     char *desc;
-    int num_cpregs;
-    uint32_t *cpregs_keys;
+    int num;
+    union {
+        struct {
+            uint32_t *keys;
+        } cpregs;
+    } data;
 } DynamicGDBXMLInfo;
 
 /* CPU state for each instance of a generic timer (in cp15 c14) */
@@ -749,7 +755,7 @@ struct ARMCPU {
     uint64_t *cpreg_vmstate_values;
     int32_t cpreg_vmstate_array_len;
 
-    DynamicGDBXMLInfo dyn_xml;
+    DynamicGDBXMLInfo dyn_sysreg_xml;
 
     /* Timers used by the generic (architected) timer */
     QEMUTimer *gt_timer[NUM_GTIMERS];
@@ -974,7 +980,7 @@ int arm_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 /* Dynamically generates for gdb stub an XML description of the sysregs from
  * the cp_regs hashtable. Returns the registered sysregs number.
  */
-int arm_gen_dynamic_xml(CPUState *cpu);
+int arm_gen_dynamic_sysreg_xml(CPUState *cpu);
 
 /* Returns the dynamically generated XML for the gdb stub.
  * Returns a pointer to the XML contents for the specified XML file or NULL
diff --git a/target/arm/gdbstub.c b/target/arm/gdbstub.c
index 4557775d245..1f68ab98c3b 100644
--- a/target/arm/gdbstub.c
+++ b/target/arm/gdbstub.c
@@ -106,15 +106,15 @@ int arm_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
     return 0;
 }
 
-static void arm_gen_one_xml_reg_tag(GString *s, DynamicGDBXMLInfo *dyn_xml,
-                                    ARMCPRegInfo *ri, uint32_t ri_key,
-                                    int bitsize)
+static void arm_gen_one_xml_sysreg_tag(GString *s, DynamicGDBXMLInfo *dyn_xml,
+                                       ARMCPRegInfo *ri, uint32_t ri_key,
+                                       int bitsize)
 {
     g_string_append_printf(s, "<reg name=\"%s\"", ri->name);
     g_string_append_printf(s, " bitsize=\"%d\"", bitsize);
     g_string_append_printf(s, " group=\"cp_regs\"/>");
-    dyn_xml->num_cpregs++;
-    dyn_xml->cpregs_keys[dyn_xml->num_cpregs - 1] = ri_key;
+    dyn_xml->data.cpregs.keys[dyn_xml->num] = ri_key;
+    dyn_xml->num++;
 }
 
 static void arm_register_sysreg_for_xml(gpointer key, gpointer value,
@@ -126,12 +126,12 @@ static void arm_register_sysreg_for_xml(gpointer key, gpointer value,
     GString *s = param->s;
     ARMCPU *cpu = ARM_CPU(param->cs);
     CPUARMState *env = &cpu->env;
-    DynamicGDBXMLInfo *dyn_xml = &cpu->dyn_xml;
+    DynamicGDBXMLInfo *dyn_xml = &cpu->dyn_sysreg_xml;
 
     if (!(ri->type & (ARM_CP_NO_RAW | ARM_CP_NO_GDB))) {
         if (arm_feature(env, ARM_FEATURE_AARCH64)) {
             if (ri->state == ARM_CP_STATE_AA64) {
-                arm_gen_one_xml_reg_tag(s , dyn_xml, ri, ri_key, 64);
+                arm_gen_one_xml_sysreg_tag(s , dyn_xml, ri, ri_key, 64);
             }
         } else {
             if (ri->state == ARM_CP_STATE_AA32) {
@@ -140,30 +140,30 @@ static void arm_register_sysreg_for_xml(gpointer key, gpointer value,
                     return;
                 }
                 if (ri->type & ARM_CP_64BIT) {
-                    arm_gen_one_xml_reg_tag(s , dyn_xml, ri, ri_key, 64);
+                    arm_gen_one_xml_sysreg_tag(s , dyn_xml, ri, ri_key, 64);
                 } else {
-                    arm_gen_one_xml_reg_tag(s , dyn_xml, ri, ri_key, 32);
+                    arm_gen_one_xml_sysreg_tag(s , dyn_xml, ri, ri_key, 32);
                 }
             }
         }
     }
 }
 
-int arm_gen_dynamic_xml(CPUState *cs)
+int arm_gen_dynamic_sysreg_xml(CPUState *cs)
 {
     ARMCPU *cpu = ARM_CPU(cs);
     GString *s = g_string_new(NULL);
     RegisterSysregXmlParam param = {cs, s};
 
-    cpu->dyn_xml.num_cpregs = 0;
-    cpu->dyn_xml.cpregs_keys = g_new(uint32_t, g_hash_table_size(cpu->cp_regs));
+    cpu->dyn_sysreg_xml.num = 0;
+    cpu->dyn_sysreg_xml.data.cpregs.keys = g_new(uint32_t, g_hash_table_size(cpu->cp_regs));
     g_string_printf(s, "<?xml version=\"1.0\"?>");
     g_string_append_printf(s, "<!DOCTYPE target SYSTEM \"gdb-target.dtd\">");
     g_string_append_printf(s, "<feature name=\"org.qemu.gdb.arm.sys.regs\">");
     g_hash_table_foreach(cpu->cp_regs, arm_register_sysreg_for_xml, &param);
     g_string_append_printf(s, "</feature>");
-    cpu->dyn_xml.desc = g_string_free(s, false);
-    return cpu->dyn_xml.num_cpregs;
+    cpu->dyn_sysreg_xml.desc = g_string_free(s, false);
+    return cpu->dyn_sysreg_xml.num;
 }
 
 const char *arm_gdb_get_dynamic_xml(CPUState *cs, const char *xmlname)
@@ -171,7 +171,7 @@ const char *arm_gdb_get_dynamic_xml(CPUState *cs, const char *xmlname)
     ARMCPU *cpu = ARM_CPU(cs);
 
     if (strcmp(xmlname, "system-registers.xml") == 0) {
-        return cpu->dyn_xml.desc;
+        return cpu->dyn_sysreg_xml.desc;
     }
     return NULL;
 }
diff --git a/target/arm/helper.c b/target/arm/helper.c
index c0e1ba17272..b0e2a85b005 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -208,7 +208,7 @@ static int arm_gdb_get_sysreg(CPUARMState *env, GByteArray *buf, int reg)
     const ARMCPRegInfo *ri;
     uint32_t key;
 
-    key = cpu->dyn_xml.cpregs_keys[reg];
+    key = cpu->dyn_sysreg_xml.data.cpregs.keys[reg];
     ri = get_arm_cp_reginfo(cpu->cp_regs, key);
     if (ri) {
         if (cpreg_field_is_64bit(ri)) {
@@ -7973,7 +7973,7 @@ void arm_cpu_register_gdb_regs_for_features(ARMCPU *cpu)
                                  19, "arm-vfp.xml", 0);
     }
     gdb_register_coprocessor(cs, arm_gdb_get_sysreg, arm_gdb_set_sysreg,
-                             arm_gen_dynamic_xml(cs),
+                             arm_gen_dynamic_sysreg_xml(cs),
                              "system-registers.xml", 0);
 }
 
-- 
2.20.1


