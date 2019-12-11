Return-Path: <SRS0=Q6KP=2B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67129C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 17:27:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27751206A5
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 17:27:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M0zqe6M9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27751206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1if5lh-0003UV-RZ
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 12:27:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53860)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1if5WJ-0003OE-CH
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 12:11:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1if5WH-0003O8-AR
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 12:11:27 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:34600)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1if5WF-0003J5-Gi
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 12:11:24 -0500
Received: by mail-wm1-x344.google.com with SMTP id f4so1658498wmj.1
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2019 09:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=3DbtusU2Ih08QJ6+xacVGyMR/0il0pzTPOprXECSOtU=;
 b=M0zqe6M9SM8Ozy1ID+t/7xsmeiyM2zAVzW9KcvKsnp4DpywwywM4GPf4WHfN1GR/RP
 ZR3ZOqPhb2BoBxoYPzuGsJQCIQqpn2O77hMy2FtYm+GofWY3cdxXZU9S6cCLYX3Sl+WW
 DWaIlYd7MK5lPL5mrYXEtY3arTyYvcHqTrcqoipmlQx+lg7cQ2FMsSthJnP8WJeTFm0X
 ByHf2uxU0FJSDoiIPvXKCLkrVN9qscYSq0JLXQ/etDea7/ZsSmr38EiFU8AFUsrFF64S
 rrKFj+Ib83e6dLaw++xGPOoKRqHHp1urOIXVbTXkVnUePPXZB76lCzsRTDnfgsSBavsL
 mTiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=3DbtusU2Ih08QJ6+xacVGyMR/0il0pzTPOprXECSOtU=;
 b=qD+zWzzT2h7QO7xfni9un2mozg8nc7mPdmS5T6bNWpV82IqDeUYjwNQ6euuIIvzSUy
 y/GEtRj76NVx8B/Fi5Ue9B2k8XaEL3alALd9asF+x+otjj9UhC3p1oVY0CK/xEZLd7pJ
 ++VwwXGXA8jVV7B+95D+KCNs41IVwwrnKto1ymdVTNQRP9mvE+ho6Xk+1YgDEJnlY1v7
 lnvuSgCNkno7TMFtlF3ATThPWNvz0Dp2nO17DoW4/AocGBqZg3dAytRJdVVahU/UUZwa
 xbxV5yYCssexMN7DLFX8JdrCXl4iNoWX/0P7fAYbML9sdQvc0RlJVSFfcB1ituh9OUmN
 gTSg==
X-Gm-Message-State: APjAAAWPMfWCn7yvta7h536UCB8mJke3lXm3Y+DV+HF3qhs/pZVh/5vR
 LfNidhvj67St+Iwma/kmcIZpMw==
X-Google-Smtp-Source: APXvYqzT3duQdKSYZhFNYYyVExycQuv7AgS8iTuJ7bgcdTHnX7wf3K+FirtF0k01WKAue1LtO9J1RQ==
X-Received: by 2002:a1c:f009:: with SMTP id a9mr887758wmb.73.1576084281972;
 Wed, 11 Dec 2019 09:11:21 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id p26sm2955834wmc.24.2019.12.11.09.11.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2019 09:11:19 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C98281FF9B;
 Wed, 11 Dec 2019 17:05:23 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 12/20] target/arm: generate xml description of our SVE
 registers
Date: Wed, 11 Dec 2019 17:05:12 +0000
Message-Id: <20191211170520.7747-13-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191211170520.7747-1-alex.bennee@linaro.org>
References: <20191211170520.7747-1-alex.bennee@linaro.org>
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

We also expose a the helpers to read/write the the registers.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - instead of zNpM expose zN at sve_max_vq width
  - wrap union in union q(us), d(usf), s(usf), h(usf), b(us)
v3
  - add a vg pseudo register for current width
  - spacing fixes
  - use switch/case for whole group
  - drop fpsr_pos marker
  - remove unused variables
---
 target/arm/cpu.h     |   7 ++-
 target/arm/gdbstub.c | 133 +++++++++++++++++++++++++++++++++++++++++++
 target/arm/helper.c  | 121 ++++++++++++++++++++++++++++++++++++++-
 3 files changed, 256 insertions(+), 5 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index cc7258d5f1d..25d34bc5197 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -755,6 +755,7 @@ struct ARMCPU {
     int32_t cpreg_vmstate_array_len;
 
     DynamicGDBXMLInfo dyn_sysreg_xml;
+    DynamicGDBXMLInfo dyn_svereg_xml;
 
     /* Timers used by the generic (architected) timer */
     QEMUTimer *gt_timer[NUM_GTIMERS];
@@ -958,10 +959,12 @@ hwaddr arm_cpu_get_phys_page_attrs_debug(CPUState *cpu, vaddr addr,
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
index 69c35462a63..546906dbcb2 100644
--- a/target/arm/gdbstub.c
+++ b/target/arm/gdbstub.c
@@ -171,12 +171,145 @@ int arm_gen_dynamic_sysreg_xml(CPUState *cs, int base_reg)
     return cpu->dyn_sysreg_xml.num;
 }
 
+struct TypeSize {
+    const char *gdb_type;
+    int  size;
+    const char sz, suffix;
+};
+
+static struct TypeSize vec_lanes[] = {
+    /* quads */
+    { "uint128", 128, 'q', 'u' },
+    { "int128", 128, 'q', 's' },
+    /* 64 bit */
+    { "uint64", 64, 'd', 'u' },
+    { "int64", 64, 'd', 's' },
+    { "ieee_double", 64, 'd', 'f' },
+    /* 32 bit */
+    { "uint32", 32, 's', 'u' },
+    { "int32", 32, 's', 's' },
+    { "ieee_single", 32, 's', 'f' },
+    /* 16 bit */
+    { "uint16", 16, 'h', 'u' },
+    { "int16", 16, 'h', 's' },
+    { "ieee_half", 16, 'h', 'f' },
+    /* bytes */
+    { "uint8", 8, 'b', 'u' },
+    { "int8", 8, 'b', 's' },
+};
+
+
+int arm_gen_dynamic_svereg_xml(CPUState *cs, int base_reg)
+{
+    ARMCPU *cpu = ARM_CPU(cs);
+    GString *s = g_string_new(NULL);
+    DynamicGDBXMLInfo *info = &cpu->dyn_svereg_xml;
+    g_autoptr(GString) ts = g_string_new("");
+    int i, bits, reg_width = (cpu->sve_max_vq * 128);
+    info->num = 0;
+    g_string_printf(s, "<?xml version=\"1.0\"?>");
+    g_string_append_printf(s, "<!DOCTYPE target SYSTEM \"gdb-target.dtd\">");
+    g_string_append_printf(s, "<feature name=\"org.qemu.gdb.aarch64.sve\">");
+
+    /* First define types and totals in a whole VL */
+    for (i = 0; i < ARRAY_SIZE(vec_lanes); i++) {
+        int count = reg_width / vec_lanes[i].size;
+        g_string_printf(ts, "vq%d%c%c", count,
+                        vec_lanes[i].sz, vec_lanes[i].suffix);
+        g_string_append_printf(s,
+                               "<vector id=\"%s\" type=\"%s\" count=\"%d\"/>",
+                               ts->str, vec_lanes[i].gdb_type, count);
+    }
+    /*
+     * Now define a union for each size group containing unsigned and
+     * signed and potentially float versions of each size from 128 to
+     * 8 bits.
+     */
+    for (bits = 128; bits >= 8; bits /= 2) {
+        int count = reg_width / bits;
+        g_string_append_printf(s, "<union id=\"vq%dn\">", count);
+        for (i = 0; i < ARRAY_SIZE(vec_lanes); i++) {
+            if (vec_lanes[i].size == bits) {
+                g_string_append_printf(s, "<field name=\"%c\" type=\"vq%d%c%c\"/>",
+                                       vec_lanes[i].suffix,
+                                       count,
+                                       vec_lanes[i].sz, vec_lanes[i].suffix);
+            }
+        }
+        g_string_append(s, "</union>");
+    }
+    /* And now the final union of unions */
+    g_string_append(s, "<union id=\"vq\">");
+    for (bits = 128; bits >= 8; bits /= 2) {
+        int count = reg_width / bits;
+        for (i = 0; i < ARRAY_SIZE(vec_lanes); i++) {
+            if (vec_lanes[i].size == bits) {
+                g_string_append_printf(s, "<field name=\"%c\" type=\"vq%dn\"/>",
+                                       vec_lanes[i].sz, count);
+                break;
+            }
+        }
+    }
+    g_string_append(s, "</union>");
+
+    /* Then define each register in parts for each vq */
+    for (i = 0; i < 32; i++) {
+        g_string_append_printf(s,
+                               "<reg name=\"z%d\" bitsize=\"%d\""
+                               " regnum=\"%d\" group=\"vector\""
+                               " type=\"vq\"/>",
+                               i, reg_width, base_reg++);
+        info->num++;
+    }
+    /* fpscr & status registers */
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
+    g_string_append_printf(s,
+                           "<reg name=\"vg\" bitsize=\"64\""
+                           " regnum=\"%d\" group=\"vector\""
+                           " type=\"int\"/>", base_reg++);
+    info->num += 2;
+    g_string_append_printf(s, "</feature>");
+    cpu->dyn_svereg_xml.desc = g_string_free(s, false);
+
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
index d00e4fcca86..b6e1fe51d76 100644
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
@@ -224,6 +233,98 @@ static int arm_gdb_set_sysreg(CPUARMState *env, uint8_t *buf, int reg)
     return 0;
 }
 
+#ifdef TARGET_AARCH64
+static int arm_gdb_get_svereg(CPUARMState *env, GByteArray *buf, int reg)
+{
+    ARMCPU *cpu = env_archcpu(env);
+
+    switch (reg) {
+    /* The first 32 registers are the zregs */
+    case 0 ... 31:
+    {
+        int vq, len = 0;
+        for (vq = 0; vq < cpu->sve_max_vq; vq++) {
+            len += gdb_get_reg128(buf,
+                                  env->vfp.zregs[reg].d[vq * 2 + 1],
+                                  env->vfp.zregs[reg].d[vq * 2]);
+        }
+        return len;
+    }
+    case 32:
+        return gdb_get_reg32(buf, vfp_get_fpsr(env));
+    case 33:
+        return gdb_get_reg32(buf, vfp_get_fpcr(env));
+    /* then 16 predicates and the ffr */
+    case 34 ... 50:
+    {
+        int preg = reg - 34;
+        int vq, len = 0;
+        for (vq = 0; vq < cpu->sve_max_vq; vq = vq + 4) {
+            len += gdb_get_reg64(buf, env->vfp.pregs[preg].p[vq / 4]);
+        }
+        return len;
+    }
+    case 51:
+        return gdb_get_reg64(buf, (cpu->env.vfp.zcr_el[1] & 0xf) + 1);
+    default:
+        /* gdbstub asked for something out our range */
+        qemu_log_mask(LOG_UNIMP, "%s: out of range register %d", __func__, reg);
+        break;
+    }
+
+    return 0;
+}
+
+static int arm_gdb_set_svereg(CPUARMState *env, uint8_t *buf, int reg)
+{
+    ARMCPU *cpu = env_archcpu(env);
+
+    /* The first 32 registers are the zregs */
+    switch (reg) {
+    /* The first 32 registers are the zregs */
+    case 0 ... 31:
+    {
+        int vq, len = 0;
+        uint64_t *p = (uint64_t *) buf;
+        for (vq = 0; vq < cpu->sve_max_vq; vq++) {
+            env->vfp.zregs[reg].d[vq * 2 + 1] = *p++;
+            env->vfp.zregs[reg].d[vq * 2] = *p++;
+            len += 16;
+        }
+        return len;
+    }
+    case 32:
+        vfp_set_fpsr(env, *(uint32_t *)buf);
+        return 4;
+    case 33:
+        vfp_set_fpcr(env, *(uint32_t *)buf);
+        return 4;
+    case 34 ... 50:
+    {
+        int preg = reg - 34;
+        int vq, len = 0;
+        uint64_t *p = (uint64_t *) buf;
+        for (vq = 0; vq < cpu->sve_max_vq; vq = vq + 4) {
+            env->vfp.pregs[preg].p[vq / 4] = *p++;
+            len += 8;
+        }
+        return len;
+    }
+    case 51:
+    {
+        uint64_t val = *(uint64_t *) buf;
+        cpu->env.vfp.zcr_el[1] = (val - 1) & 0xf;
+        return 8;
+    }
+    default:
+        /* gdbstub asked for something out our range */
+        break;
+    }
+
+    return 0;
+}
+#endif /* TARGET_AARCH64 */
+
 static bool raw_accessors_invalid(const ARMCPRegInfo *ri)
 {
    /* Return true if the regdef would cause an assertion if you called
@@ -6981,9 +7082,22 @@ void arm_cpu_register_gdb_regs_for_features(ARMCPU *cpu)
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
@@ -6997,6 +7111,7 @@ void arm_cpu_register_gdb_regs_for_features(ARMCPU *cpu)
     gdb_register_coprocessor(cs, arm_gdb_get_sysreg, arm_gdb_set_sysreg,
                              arm_gen_dynamic_sysreg_xml(cs, cs->gdb_num_regs),
                              "system-registers.xml", 0);
+
 }
 
 /* Sort alphabetically by type name, except for "any". */
-- 
2.20.1


