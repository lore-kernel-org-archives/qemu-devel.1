Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBFB3C432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 17:42:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B7392072B
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 17:42:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QW9/hvzd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B7392072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVfcC-0007SI-4T
	for qemu-devel@archiver.kernel.org; Fri, 15 Nov 2019 12:42:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35111)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iVfQN-0007SK-18
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 12:30:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iVfQJ-00034f-9J
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 12:30:22 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:40155)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iVfQI-00033r-W4
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 12:30:19 -0500
Received: by mail-wm1-x344.google.com with SMTP id f3so11274702wmc.5
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2019 09:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=gDNQ6jd5KtQyxOB0ZoMedQcNspZkCdSb8aZGFqdtZ3w=;
 b=QW9/hvzdAuKfyS0eMvBz+I8scgYQ9K8h6m+yRISWSGNbUKXnd/NADyTTVtouItyDpL
 SBBrAaBdeBCJxMzsBEsfe/DMkVGILz/KCKAZzmEzUzRfdfxQNPLOpLdubCdMhtc3Hxk6
 mn4Ix4c9KXqfhTg5luYSm83zc8Vvy4rXq6QT+70ep3kGPTNCWN/ePosZvqNDvOnb37VT
 sak50ENmN9IyioQ3BkNrr6rEfNiChOk9pcZ2SsjYhNlPKcdBTkWjpV1lUMsnpQ+1bBlb
 b+D6da6prYL6ruswXBUsAbXm9y2CymkLxGIRkdf2pUF6adFcKNT2tqeSRGmxDsXnwxHc
 1mkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=gDNQ6jd5KtQyxOB0ZoMedQcNspZkCdSb8aZGFqdtZ3w=;
 b=TZ79CJJ+itRvVFeNgpoojD/gNSxWViQs0XmHZjSIxFJGBwZKuced4UG3IpFQxIe5Zh
 rpp9veSWyAU7LyTW6rn6UBQ2Oqe3ka91kxc7T2iiid+XTPMdTllvlT8w7tb4CgHJU6OJ
 vGLcFwcfIvaPdi7xUqzgc19cRG7XQhAwIIn4xC/eidXAcuc0UvEQiKsXSIz3rIvUp5fd
 xN4guGqTJ77e6WiBcyHoeEiwC4mfM6d6c7R/k1uh06E/vjuN3SWn9N1/coQp0b3rqilB
 2Zy1zrW67dvk+amVziyvStOFlUliyyLYevwgkc2OVp34dt/D2oHShHzC3VKlYu4SILNA
 MqYg==
X-Gm-Message-State: APjAAAWzdXRBpIcmnoPAPka4WPBO0X4rR8Qiypppss3iJ2kn/Pzt1TKB
 iovAtBqHN0/QdzbSD6tX9ompUQ==
X-Google-Smtp-Source: APXvYqwxqF0SfsWWV0w8ZUQ/M5d8kHvlsAtVwwlpkEgixWQhCY16QKjwdCMjGiNWTWzRmeLQoj6Baw==
X-Received: by 2002:a1c:20ce:: with SMTP id g197mr14906905wmg.99.1573839017761; 
 Fri, 15 Nov 2019 09:30:17 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a26sm2586691wmm.14.2019.11.15.09.30.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Nov 2019 09:30:13 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 16CA01FF9B;
 Fri, 15 Nov 2019 17:30:02 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 11/11] target/arm: generate xml description of our SVE
 registers
Date: Fri, 15 Nov 2019 17:30:00 +0000
Message-Id: <20191115173000.21891-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191115173000.21891-1-alex.bennee@linaro.org>
References: <20191115173000.21891-1-alex.bennee@linaro.org>
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
Cc: damien.hedde@greensocs.com, Peter Maydell <peter.maydell@linaro.org>,
 luis.machado@linaro.org, richard.henderson@linaro.org,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>, alan.hayward@arm.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/cpu.h     | 10 ++++-
 target/arm/gdbstub.c | 99 ++++++++++++++++++++++++++++++++++++++++++++
 target/arm/helper.c  | 69 ++++++++++++++++++++++++++++--
 3 files changed, 173 insertions(+), 5 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index d5b6eeeb2f0..5470548a057 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -141,6 +141,9 @@ typedef struct DynamicGDBXMLInfo {
         struct {
             uint32_t *keys;
         } cpregs;
+        struct {
+            int fpsr_pos;
+        } sve;
     } data;
 } DynamicGDBXMLInfo;
 
@@ -758,6 +761,7 @@ struct ARMCPU {
     int32_t cpreg_vmstate_array_len;
 
     DynamicGDBXMLInfo dyn_sysreg_xml;
+    DynamicGDBXMLInfo dyn_svereg_xml;
 
     /* Timers used by the generic (architected) timer */
     QEMUTimer *gt_timer[NUM_GTIMERS];
@@ -961,10 +965,12 @@ hwaddr arm_cpu_get_phys_page_attrs_debug(CPUState *cpu, vaddr addr,
 int arm_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
 int arm_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 
-/* Dynamically generates for gdb stub an XML description of the sysregs from
- * the cp_regs hashtable. Returns the registered sysregs number.
+/*
+ * Helpers to dynamically generates XML descriptions of the sysregs
+ * and SVE registers. Returns the number of registers in each set.
  */
 int arm_gen_dynamic_sysreg_xml(CPUState *cpu, int base_reg);
+int arm_gen_dynamic_svereg_xml(CPUState *cpu, int base_reg);
 
 /* Returns the dynamically generated XML for the gdb stub.
  * Returns a pointer to the XML contents for the specified XML file or NULL
diff --git a/target/arm/gdbstub.c b/target/arm/gdbstub.c
index ca2abedd8cf..62b17fccbe7 100644
--- a/target/arm/gdbstub.c
+++ b/target/arm/gdbstub.c
@@ -170,12 +170,111 @@ int arm_gen_dynamic_sysreg_xml(CPUState *cs, int base_reg)
     return cpu->dyn_sysreg_xml.num;
 }
 
+struct TypeSize {
+    const char *gdb_type;
+    int  size;
+    const char *suffix;
+};
+
+static struct TypeSize vec_lanes[] = {
+    { "uint128", 128, "qu"},
+    { "int128", 128, "qs" },
+    { "uint64", 64, "lu"},
+    { "int64", 64, "ls" },
+    { "uint32", 32, "u"},
+    { "int32", 32, "s" },
+    { "uint16", 16, "hu"},
+    { "int16", 16, "hs" },
+    { "uint8", 8, "ub"},
+    { "int8", 8, "sb" },
+    { "ieee_double", 64, "df" },
+    { "ieee_single", 32, "sf" },
+    { "ieee_half", 16, "hf" },
+};
+
+
+int arm_gen_dynamic_svereg_xml(CPUState *cs, int base_reg)
+{
+    ARMCPU *cpu = ARM_CPU(cs);
+    GString *s = g_string_new(NULL);
+    DynamicGDBXMLInfo *info = &cpu->dyn_svereg_xml;
+    g_autoptr(GString) ts = g_string_new("");
+    g_autoptr(GString) us = g_string_new("");
+    int i, j;
+    info->num = 0;
+    g_string_printf(s, "<?xml version=\"1.0\"?>");
+    g_string_append_printf(s, "<!DOCTYPE target SYSTEM \"gdb-target.dtd\">");
+    g_string_append_printf(s, "<feature name=\"org.qemu.gdb.aarch64.sve\">");
+    /* first define types and the union they belong to */
+    for (i = 0; i < ARRAY_SIZE(vec_lanes); i++) {
+        int count = 128 / vec_lanes[i].size;
+        g_string_printf(ts, "vq%d%s", count, vec_lanes[i].suffix);
+        g_string_append_printf(s, "<vector id=\"%s\" type=\"%s\" count=\"%d\"/>",
+                               ts->str, vec_lanes[i].gdb_type, count);
+        g_string_append_printf(us, "<field name=\"%s\" type=\"%s\"/>",
+                               vec_lanes[i].suffix, ts->str);
+    }
+    /* wrap the union around define the overall vq type */
+    us = g_string_prepend(us, "<union id=\"vq\">");
+    us = g_string_append(us,"</union>");
+    g_string_append(s, us->str);
+
+    /* Then define each register in parts for each vq */
+    for (i = 0; i < 32; i++) {
+        for (j = 0; j < cpu->sve_max_vq; j++) {
+            g_string_append_printf(s,
+                                   "<reg name=\"z%dp%d\" bitsize=\"128\""
+                                   " regnum=\"%d\" group=\"vector\""
+                                   " type=\"vq\"/>",
+                                   i, j, base_reg++);
+            info->num++;
+        }
+    }
+    /* fpscr & status registers */
+    info->data.sve.fpsr_pos = info->num;
+    g_string_append_printf(s, "<reg name=\"fpsr\" bitsize=\"32\""
+                           " regnum=\"%d\" group=\"float\""
+                           " type=\"int\"/>", base_reg++);
+    g_string_append_printf(s, "<reg name=\"fpcr\" bitsize=\"32\""
+                           " regnum=\"%d\" group=\"float\""
+                           " type=\"int\"/>", base_reg++);
+    info->num += 2;
+    /*
+     * Predicate registers aren't so big they are worth splitting up
+     * but we do need to define a type to hold the array of quad
+     * references.
+     */
+    g_string_append_printf(s,
+                           "<vector id=\"vqp\" type=\"uint16\" count=\"%d\"/>",
+                           cpu->sve_max_vq);
+    for (i = 0; i < 16; i++) {
+        g_string_append_printf(s,
+                               "<reg name=\"p%d\" bitsize=\"%d\""
+                               " regnum=\"%d\" group=\"vector\""
+                               " type=\"vqp\"/>",
+                               i, cpu->sve_max_vq * 16, base_reg++);
+        info->num++;
+    }
+    g_string_append_printf(s,
+                           "<reg name=\"ffr\" bitsize=\"%d\""
+                           " regnum=\"%d\" group=\"vector\""
+                           " type=\"vqp\"/>",
+                           cpu->sve_max_vq * 16, base_reg++);
+    info->num++;
+    g_string_append_printf(s, "</feature>");
+    cpu->dyn_svereg_xml.desc = g_string_free(s, false);
+    return cpu->dyn_svereg_xml.num;
+}
+
+
 const char *arm_gdb_get_dynamic_xml(CPUState *cs, const char *xmlname)
 {
     ARMCPU *cpu = ARM_CPU(cs);
 
     if (strcmp(xmlname, "system-registers.xml") == 0) {
         return cpu->dyn_sysreg_xml.desc;
+    } else if (strcmp(xmlname, "sve-registers.xml") == 0) {
+        return cpu->dyn_svereg_xml.desc;
     }
     return NULL;
 }
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 421e27e0f32..b517b88ba3c 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -201,6 +201,15 @@ static void write_raw_cp_reg(CPUARMState *env, const ARMCPRegInfo *ri,
     }
 }
 
+/**
+ * arm_get/set_gdb_*: get/set a gdb register
+ * @env: the CPU state
+ * @buf: a buffer to copy to/from
+ * @reg: register number (offset from start of group)
+ *
+ * We return the number of bytes copied
+ */
+
 static int arm_gdb_get_sysreg(CPUARMState *env, GByteArray *buf, int reg)
 {
     ARMCPU *cpu = env_archcpu(env);
@@ -224,6 +233,46 @@ static int arm_gdb_set_sysreg(CPUARMState *env, uint8_t *buf, int reg)
     return 0;
 }
 
+#ifdef TARGET_AARCH64
+static int arm_gdb_get_svereg(CPUARMState *env, GByteArray *buf, int reg)
+{
+    ARMCPU *cpu = env_archcpu(env);
+    DynamicGDBXMLInfo *info = &cpu->dyn_svereg_xml;
+
+    /* The first 32 * vq registers are the zNpQ regs */
+    if (reg < (32 * cpu->sve_max_vq)) {
+        int vq = reg % cpu->sve_max_vq;
+        int z = reg / cpu->sve_max_vq;
+        return gdb_get_reg128(buf,
+                              env->vfp.zregs[z].d[vq * 2 + 1],
+                              env->vfp.zregs[z].d[vq * 2]);
+    }
+    switch (reg - info->data.sve.fpsr_pos) {
+    case 0:
+        return gdb_get_reg32(buf, vfp_get_fpsr(env));
+    case 1:
+        return gdb_get_reg32(buf, vfp_get_fpsr(env));
+    case 2 ... 19:
+    {
+        /* XXX FIXME: not quite right, we could be bigger */
+        int preg = reg - info->data.sve.fpsr_pos - 2;
+        return gdb_get_reg64(buf, env->vfp.pregs[preg].p[0]);
+    }
+    default:
+        /* gdbstub asked for something out our range */
+        break;
+    }
+
+    return 0;
+}
+
+static int arm_gdb_set_svereg(CPUARMState *env, uint8_t *buf, int reg)
+{
+    fprintf(stderr, "%s: %d\n", __func__, reg);
+    return 0;
+}
+#endif /* TARGET_AARCH64 */
+
 static bool raw_accessors_invalid(const ARMCPRegInfo *ri)
 {
    /* Return true if the regdef would cause an assertion if you called
@@ -6897,9 +6946,22 @@ void arm_cpu_register_gdb_regs_for_features(ARMCPU *cpu)
     CPUARMState *env = &cpu->env;
 
     if (arm_feature(env, ARM_FEATURE_AARCH64)) {
-        gdb_register_coprocessor(cs, aarch64_fpu_gdb_get_reg,
-                                 aarch64_fpu_gdb_set_reg,
-                                 34, "aarch64-fpu.xml", 0);
+        /*
+         * The lower part of each SVE register aliases to the FPU
+         * registers so we don't need to include both.
+         */
+#ifdef TARGET_AARCH64
+        if (isar_feature_aa64_sve(&cpu->isar)) {
+            gdb_register_coprocessor(cs, arm_gdb_get_svereg, arm_gdb_set_svereg,
+                                     arm_gen_dynamic_svereg_xml(cs, cs->gdb_num_regs),
+                                     "sve-registers.xml", 0);
+        } else
+#endif
+        {
+            gdb_register_coprocessor(cs, aarch64_fpu_gdb_get_reg,
+                                     aarch64_fpu_gdb_set_reg,
+                                     34, "aarch64-fpu.xml", 0);
+        }
     } else if (arm_feature(env, ARM_FEATURE_NEON)) {
         gdb_register_coprocessor(cs, vfp_gdb_get_reg, vfp_gdb_set_reg,
                                  51, "arm-neon.xml", 0);
@@ -6913,6 +6975,7 @@ void arm_cpu_register_gdb_regs_for_features(ARMCPU *cpu)
     gdb_register_coprocessor(cs, arm_gdb_get_sysreg, arm_gdb_set_sysreg,
                              arm_gen_dynamic_sysreg_xml(cs, cs->gdb_num_regs),
                              "system-registers.xml", 0);
+
 }
 
 /* Sort alphabetically by type name, except for "any". */
-- 
2.20.1


