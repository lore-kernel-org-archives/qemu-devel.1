Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2DC8C04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 21:07:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4875920879
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 21:07:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vJ+s9fee"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4875920879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54200 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQede-0005Yb-Gb
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 17:07:06 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38829)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1hQeV3-0007X1-Eo
	for qemu-devel@nongnu.org; Tue, 14 May 2019 16:58:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1hQeIj-0007XS-4W
	for qemu-devel@nongnu.org; Tue, 14 May 2019 16:45:32 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:44965)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1hQeId-0007PN-E4
	for qemu-devel@nongnu.org; Tue, 14 May 2019 16:45:28 -0400
Received: by mail-lj1-x244.google.com with SMTP id e13so466778ljl.11
	for <qemu-devel@nongnu.org>; Tue, 14 May 2019 13:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=BcH00gQ3TIulNwsNHVK3TUj8Vja71dKWcTQcNQsozMQ=;
	b=vJ+s9feedeMjD6ToBPPgZrVZj+gyVOCYJbOoCPekPbarZo0FfVoLRpP6+hAUOb5Laq
	2F9HIHVSKzwZHvx8lvM3FpUZwRU9MdNrjQG9e5neL5DkL5cWuSIQysiWYO1KFfsG3gGY
	HYmNhkEnNunYOnCwPKVhFGbN4QXy+dwI668Go3R84Evs7/baBSWCnuE4QnSoprcQP5ko
	DhenypZjwygXIes0hfcLivSo6tXGPMs+JCfztWevQonik6rctEdhTy+kTpPiL3WVrIC+
	ZYim7BJMaHoD50u+YovNfV5PN6Y7lqw2E7NZtv5FZGPzFjHCLPOuJ2HyC9AssGS+bLoZ
	CfiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=BcH00gQ3TIulNwsNHVK3TUj8Vja71dKWcTQcNQsozMQ=;
	b=DYDa/xBtNNOm9iR62bsN4fCm4Xujwjd4a5d5EsrHXEGUxXJUWvETNsqjugh1ikokQo
	HfGN4TIsH70M4u+VxyzM3sJx5ePNOszkrV4fyo9vZftij0JRzGT3YAYeA+QQUIgKb97p
	D4pr1qQcZHB77qBnKrfgL22ixF2NP/hYrqvlIv8SaO6L8ClrQqxJ4HARSCXYqZgNTDTE
	FR6qrEsPBb8e6fOqAHkB2hWbLi6HosccK/WjbobfSIla24nI46C9DtDzOO1vYD1WBrTB
	DikNNHXk84bR77ZUbuX7hPY+v9NSkEsQsQ1SE5xVKbEY+LcnYsZwyorzAvgTuWesscfk
	owow==
X-Gm-Message-State: APjAAAWFNALSbA44Qoj0TJ3oxhw9lJa3zktt60wooAyM59QtuuEEeT32
	kK84ONvcIg2aUkgMWjbvtwpwlLSXzxg=
X-Google-Smtp-Source: APXvYqy7UPLFdJL48ITHSZ4EDDbJm8jbGDgEX3mYDzImbppxCzN7PQVEzsWJakvkrWHAClczPVpDNA==
X-Received: by 2002:a2e:4b19:: with SMTP id y25mr17313887lja.149.1557866718655;
	Tue, 14 May 2019 13:45:18 -0700 (PDT)
Received: from octofox.cadence.com
	(jcmvbkbc-1-pt.tunnel.tserv24.sto1.ipv6.he.net. [2001:470:27:1fa::2])
	by smtp.gmail.com with ESMTPSA id 78sm4011lje.81.2019.05.14.13.45.16
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 14 May 2019 13:45:18 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
To: qemu-devel@nongnu.org
Date: Tue, 14 May 2019 13:44:43 -0700
Message-Id: <20190514204447.17486-6-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190514204447.17486-1-jcmvbkbc@gmail.com>
References: <20190514204447.17486-1-jcmvbkbc@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::244
Subject: [Qemu-devel] [PATCH 5/9] target/xtensa: implement MPU option
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

The Memory Protection Unit Option (MPU) is a combined instruction and
data memory protection unit with more protection flexibility than the
Region Protection Option or the Region Translation Option but without
any translation capability. It does no demand paging and does not
reference a memory-based page table.

Add memory protection unit option, internal state, SRs and opcodes.
Implement MPU entries dumping in dump_mmu.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 target/xtensa/cpu.c          |   1 -
 target/xtensa/cpu.h          |  17 ++
 target/xtensa/helper.h       |   5 +
 target/xtensa/mmu_helper.c   | 369 +++++++++++++++++++++++++++++++++++++++++++
 target/xtensa/overlay_tool.h |  29 ++++
 target/xtensa/translate.c    | 146 +++++++++++++++++
 6 files changed, 566 insertions(+), 1 deletion(-)

diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index a54dbe42602d..4215a1881ec7 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -78,7 +78,6 @@ static void xtensa_cpu_reset(CPUState *s)
     env->sregs[VECBASE] = env->config->vecbase;
     env->sregs[IBREAKENABLE] = 0;
     env->sregs[MEMCTL] = MEMCTL_IL0EN & env->config->memctl_mask;
-    env->sregs[CACHEATTR] = 0x22222222;
     env->sregs[ATOMCTL] = xtensa_option_enabled(env->config,
             XTENSA_OPTION_ATOMCTL) ? 0x28 : 0x15;
     env->sregs[CONFIGID0] = env->config->configid[0];
diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index 74ee7d125360..d6e6bf6ca183 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -99,6 +99,7 @@ enum {
     /* Memory protection and translation */
     XTENSA_OPTION_REGION_PROTECTION,
     XTENSA_OPTION_REGION_TRANSLATION,
+    XTENSA_OPTION_MPU,
     XTENSA_OPTION_MMU,
     XTENSA_OPTION_CACHEATTR,
 
@@ -137,11 +138,15 @@ enum {
     PTEVADDR = 83,
     MMID = 89,
     RASID = 90,
+    MPUENB = 90,
     ITLBCFG = 91,
     DTLBCFG = 92,
+    MPUCFG = 92,
+    ERACCESS = 95,
     IBREAKENABLE = 96,
     MEMCTL = 97,
     CACHEATTR = 98,
+    CACHEADRDIS = 98,
     ATOMCTL = 99,
     DDR = 104,
     MEPC = 106,
@@ -234,6 +239,7 @@ enum {
 #define MAX_TLB_WAY_SIZE 8
 #define MAX_NDBREAK 2
 #define MAX_NMEMORY 4
+#define MAX_MPU_FOREGROUND_SEGMENTS 32
 
 #define REGION_PAGE_MASK 0xe0000000
 
@@ -327,6 +333,11 @@ typedef struct xtensa_tlb {
     unsigned nrefillentries;
 } xtensa_tlb;
 
+typedef struct xtensa_mpu_entry {
+    uint32_t vaddr;
+    uint32_t attr;
+} xtensa_mpu_entry;
+
 typedef struct XtensaGdbReg {
     int targno;
     unsigned flags;
@@ -477,6 +488,11 @@ struct XtensaConfig {
 
     xtensa_tlb itlb;
     xtensa_tlb dtlb;
+
+    uint32_t mpu_align;
+    unsigned n_mpu_fg_segments;
+    unsigned n_mpu_bg_segments;
+    const xtensa_mpu_entry *mpu_bg;
 };
 
 typedef struct XtensaConfigList {
@@ -513,6 +529,7 @@ typedef struct CPUXtensaState {
 #ifndef CONFIG_USER_ONLY
     xtensa_tlb_entry itlb[7][MAX_TLB_WAY_SIZE];
     xtensa_tlb_entry dtlb[10][MAX_TLB_WAY_SIZE];
+    xtensa_mpu_entry mpu_fg[MAX_MPU_FOREGROUND_SEGMENTS];
     unsigned autorefill_idx;
     bool runstall;
     AddressSpace *address_space_er;
diff --git a/target/xtensa/helper.h b/target/xtensa/helper.h
index 0b9ec670c86e..9216bee57e9a 100644
--- a/target/xtensa/helper.h
+++ b/target/xtensa/helper.h
@@ -33,6 +33,11 @@ DEF_HELPER_FLAGS_3(rtlb1, TCG_CALL_NO_RWG_SE, i32, env, i32, i32)
 DEF_HELPER_3(itlb, void, env, i32, i32)
 DEF_HELPER_3(ptlb, i32, env, i32, i32)
 DEF_HELPER_4(wtlb, void, env, i32, i32, i32)
+DEF_HELPER_2(wsr_mpuenb, void, env, i32)
+DEF_HELPER_3(wptlb, void, env, i32, i32)
+DEF_HELPER_FLAGS_2(rptlb0, TCG_CALL_NO_RWG_SE, i32, env, i32)
+DEF_HELPER_FLAGS_2(rptlb1, TCG_CALL_NO_RWG_SE, i32, env, i32)
+DEF_HELPER_2(pptlb, i32, env, i32)
 
 DEF_HELPER_2(wsr_ibreakenable, void, env, i32)
 DEF_HELPER_3(wsr_ibreaka, void, env, i32, i32)
diff --git a/target/xtensa/mmu_helper.c b/target/xtensa/mmu_helper.c
index 465cfbf61359..cab39f687a21 100644
--- a/target/xtensa/mmu_helper.c
+++ b/target/xtensa/mmu_helper.c
@@ -35,6 +35,31 @@
 #include "exec/exec-all.h"
 #include "exec/cpu_ldst.h"
 
+#define XTENSA_MPU_SEGMENT_MASK 0x0000001f
+#define XTENSA_MPU_ACC_RIGHTS_MASK 0x00000f00
+#define XTENSA_MPU_ACC_RIGHTS_SHIFT 8
+#define XTENSA_MPU_MEM_TYPE_MASK 0x001ff000
+#define XTENSA_MPU_MEM_TYPE_SHIFT 12
+#define XTENSA_MPU_ATTR_MASK 0x001fff00
+
+#define XTENSA_MPU_PROBE_B 0x40000000
+#define XTENSA_MPU_PROBE_V 0x80000000
+
+#define XTENSA_MPU_SYSTEM_TYPE_DEVICE 0x0001
+#define XTENSA_MPU_SYSTEM_TYPE_NC     0x0002
+#define XTENSA_MPU_SYSTEM_TYPE_C      0x0003
+#define XTENSA_MPU_SYSTEM_TYPE_MASK   0x0003
+
+#define XTENSA_MPU_TYPE_SYS_C     0x0010
+#define XTENSA_MPU_TYPE_SYS_W     0x0020
+#define XTENSA_MPU_TYPE_SYS_R     0x0040
+#define XTENSA_MPU_TYPE_CPU_C     0x0100
+#define XTENSA_MPU_TYPE_CPU_W     0x0200
+#define XTENSA_MPU_TYPE_CPU_R     0x0400
+#define XTENSA_MPU_TYPE_CPU_CACHE 0x0800
+#define XTENSA_MPU_TYPE_B         0x1000
+#define XTENSA_MPU_TYPE_INT       0x2000
+
 void HELPER(itlb_hit_test)(CPUXtensaState *env, uint32_t vaddr)
 {
     /*
@@ -382,7 +407,20 @@ void reset_mmu(CPUXtensaState *env)
         reset_tlb_mmu_all_ways(env, &env->config->dtlb, env->dtlb);
         reset_tlb_mmu_ways56(env, &env->config->itlb, env->itlb);
         reset_tlb_mmu_ways56(env, &env->config->dtlb, env->dtlb);
+    } else if (xtensa_option_enabled(env->config, XTENSA_OPTION_MPU)) {
+        unsigned i;
+
+        env->sregs[MPUENB] = 0;
+        env->sregs[MPUCFG] = env->config->n_mpu_fg_segments;
+        env->sregs[CACHEADRDIS] = 0;
+        assert(env->config->n_mpu_bg_segments > 0 &&
+               env->config->mpu_bg[0].vaddr == 0);
+        for (i = 1; i < env->config->n_mpu_bg_segments; ++i) {
+            assert(env->config->mpu_bg[i].vaddr >=
+                   env->config->mpu_bg[i - 1].vaddr);
+        }
     } else {
+        env->sregs[CACHEATTR] = 0x22222222;
         reset_tlb_region_way0(env, env->itlb);
         reset_tlb_region_way0(env, env->dtlb);
     }
@@ -579,6 +617,149 @@ static unsigned cacheattr_attr_to_access(uint32_t attr)
     return access[attr & 0xf];
 }
 
+struct attr_pattern {
+    uint32_t mask;
+    uint32_t value;
+};
+
+static int attr_pattern_match(uint32_t attr,
+                              const struct attr_pattern *pattern,
+                              size_t n)
+{
+    size_t i;
+
+    for (i = 0; i < n; ++i) {
+        if ((attr & pattern[i].mask) == pattern[i].value) {
+            return 1;
+        }
+    }
+    return 0;
+}
+
+static unsigned mpu_attr_to_cpu_cache(uint32_t attr)
+{
+    static const struct attr_pattern cpu_c[] = {
+        { .mask = 0x18f, .value = 0x089 },
+        { .mask = 0x188, .value = 0x080 },
+        { .mask = 0x180, .value = 0x180 },
+    };
+
+    unsigned type = 0;
+
+    if (attr_pattern_match(attr, cpu_c, ARRAY_SIZE(cpu_c))) {
+        type |= XTENSA_MPU_TYPE_CPU_CACHE;
+        if (attr & 0x10) {
+            type |= XTENSA_MPU_TYPE_CPU_C;
+        }
+        if (attr & 0x20) {
+            type |= XTENSA_MPU_TYPE_CPU_W;
+        }
+        if (attr & 0x40) {
+            type |= XTENSA_MPU_TYPE_CPU_R;
+        }
+    }
+    return type;
+}
+
+static unsigned mpu_attr_to_type(uint32_t attr)
+{
+    static const struct attr_pattern device_type[] = {
+        { .mask = 0x1f6, .value = 0x000 },
+        { .mask = 0x1f6, .value = 0x006 },
+    };
+    static const struct attr_pattern sys_nc_type[] = {
+        { .mask = 0x1fe, .value = 0x018 },
+        { .mask = 0x1fe, .value = 0x01e },
+        { .mask = 0x18f, .value = 0x089 },
+    };
+    static const struct attr_pattern sys_c_type[] = {
+        { .mask = 0x1f8, .value = 0x010 },
+        { .mask = 0x188, .value = 0x080 },
+        { .mask = 0x1f0, .value = 0x030 },
+        { .mask = 0x180, .value = 0x180 },
+    };
+    static const struct attr_pattern b[] = {
+        { .mask = 0x1f7, .value = 0x001 },
+        { .mask = 0x1f7, .value = 0x007 },
+        { .mask = 0x1ff, .value = 0x019 },
+        { .mask = 0x1ff, .value = 0x01f },
+    };
+
+    unsigned type = 0;
+
+    attr = (attr & XTENSA_MPU_MEM_TYPE_MASK) >> XTENSA_MPU_MEM_TYPE_SHIFT;
+    if (attr_pattern_match(attr, device_type, ARRAY_SIZE(device_type))) {
+        type |= XTENSA_MPU_SYSTEM_TYPE_DEVICE;
+        if (attr & 0x80) {
+            type |= XTENSA_MPU_TYPE_INT;
+        }
+    }
+    if (attr_pattern_match(attr, sys_nc_type, ARRAY_SIZE(sys_nc_type))) {
+        type |= XTENSA_MPU_SYSTEM_TYPE_NC;
+    }
+    if (attr_pattern_match(attr, sys_c_type, ARRAY_SIZE(sys_c_type))) {
+        type |= XTENSA_MPU_SYSTEM_TYPE_C;
+        if (attr & 0x1) {
+            type |= XTENSA_MPU_TYPE_SYS_C;
+        }
+        if (attr & 0x2) {
+            type |= XTENSA_MPU_TYPE_SYS_W;
+        }
+        if (attr & 0x4) {
+            type |= XTENSA_MPU_TYPE_SYS_R;
+        }
+    }
+    if (attr_pattern_match(attr, b, ARRAY_SIZE(b))) {
+        type |= XTENSA_MPU_TYPE_B;
+    }
+    type |= mpu_attr_to_cpu_cache(attr);
+
+    return type;
+}
+
+static unsigned mpu_attr_to_access(uint32_t attr, unsigned ring)
+{
+    static const unsigned access[2][16] = {
+        [0] = {
+             [4] = PAGE_READ,
+             [5] = PAGE_READ              | PAGE_EXEC,
+             [6] = PAGE_READ | PAGE_WRITE,
+             [7] = PAGE_READ | PAGE_WRITE | PAGE_EXEC,
+             [8] =             PAGE_WRITE,
+             [9] = PAGE_READ | PAGE_WRITE,
+            [10] = PAGE_READ | PAGE_WRITE,
+            [11] = PAGE_READ | PAGE_WRITE | PAGE_EXEC,
+            [12] = PAGE_READ,
+            [13] = PAGE_READ              | PAGE_EXEC,
+            [14] = PAGE_READ | PAGE_WRITE,
+            [15] = PAGE_READ | PAGE_WRITE | PAGE_EXEC,
+        },
+        [1] = {
+             [8] =             PAGE_WRITE,
+             [9] = PAGE_READ | PAGE_WRITE | PAGE_EXEC,
+            [10] = PAGE_READ,
+            [11] = PAGE_READ              | PAGE_EXEC,
+            [12] = PAGE_READ,
+            [13] = PAGE_READ              | PAGE_EXEC,
+            [14] = PAGE_READ | PAGE_WRITE,
+            [15] = PAGE_READ | PAGE_WRITE | PAGE_EXEC,
+        },
+    };
+    unsigned rv;
+    unsigned type;
+
+    type = mpu_attr_to_cpu_cache(attr);
+    rv = access[ring != 0][(attr & XTENSA_MPU_ACC_RIGHTS_MASK) >>
+        XTENSA_MPU_ACC_RIGHTS_SHIFT];
+
+    if (type & XTENSA_MPU_TYPE_CPU_CACHE) {
+        rv |= (type & XTENSA_MPU_TYPE_CPU_C) ? PAGE_CACHE_WB : PAGE_CACHE_WT;
+    } else {
+        rv |= PAGE_CACHE_BYPASS;
+    }
+    return rv;
+}
+
 static bool is_access_granted(unsigned access, int is_write)
 {
     switch (is_write) {
@@ -723,6 +904,129 @@ static int get_physical_addr_region(CPUXtensaState *env,
     return 0;
 }
 
+static int xtensa_mpu_lookup(const xtensa_mpu_entry *entry, unsigned n,
+                             uint32_t vaddr, unsigned *segment)
+{
+    unsigned nhits = 0;
+    unsigned i;
+
+    for (i = 0; i < n; ++i) {
+        if (vaddr >= entry[i].vaddr &&
+            (i == n - 1 || vaddr < entry[i + 1].vaddr)) {
+            if (nhits++) {
+                break;
+            }
+            *segment = i;
+        }
+    }
+    return nhits;
+}
+
+void HELPER(wsr_mpuenb)(CPUXtensaState *env, uint32_t v)
+{
+    XtensaCPU *cpu = xtensa_env_get_cpu(env);
+
+    v &= (2u << (env->config->n_mpu_fg_segments - 1)) - 1;
+
+    if (v != env->sregs[MPUENB]) {
+        env->sregs[MPUENB] = v;
+        tlb_flush(CPU(cpu));
+    }
+}
+
+void HELPER(wptlb)(CPUXtensaState *env, uint32_t p, uint32_t v)
+{
+    unsigned segment = p & XTENSA_MPU_SEGMENT_MASK;
+
+    if (segment < env->config->n_mpu_fg_segments) {
+        env->mpu_fg[segment].vaddr = v & -env->config->mpu_align;
+        env->mpu_fg[segment].attr = p & XTENSA_MPU_ATTR_MASK;
+        env->sregs[MPUENB] = deposit32(env->sregs[MPUENB], segment, 1, v);
+        tlb_flush(CPU(xtensa_env_get_cpu(env)));
+    }
+}
+
+uint32_t HELPER(rptlb0)(CPUXtensaState *env, uint32_t s)
+{
+    unsigned segment = s & XTENSA_MPU_SEGMENT_MASK;
+
+    if (segment < env->config->n_mpu_fg_segments) {
+        return env->mpu_fg[segment].vaddr |
+            extract32(env->sregs[MPUENB], segment, 1);
+    } else {
+        return 0;
+    }
+}
+
+uint32_t HELPER(rptlb1)(CPUXtensaState *env, uint32_t s)
+{
+    unsigned segment = s & XTENSA_MPU_SEGMENT_MASK;
+
+    if (segment < env->config->n_mpu_fg_segments) {
+        return env->mpu_fg[segment].attr;
+    } else {
+        return 0;
+    }
+}
+
+uint32_t HELPER(pptlb)(CPUXtensaState *env, uint32_t v)
+{
+    unsigned nhits;
+    unsigned segment = XTENSA_MPU_PROBE_B;
+    unsigned bg_segment;
+
+    nhits = xtensa_mpu_lookup(env->mpu_fg, env->config->n_mpu_fg_segments,
+                              v, &segment);
+    if (nhits > 1) {
+        HELPER(exception_cause_vaddr)(env, env->pc,
+                                      LOAD_STORE_TLB_MULTI_HIT_CAUSE, v);
+    } else if (nhits == 1 && (env->sregs[MPUENB] & (1u << segment))) {
+        return env->mpu_fg[segment].attr | segment | XTENSA_MPU_PROBE_V;
+    } else {
+        xtensa_mpu_lookup(env->config->mpu_bg,
+                          env->config->n_mpu_bg_segments,
+                          v, &bg_segment);
+        return env->config->mpu_bg[bg_segment].attr | segment;
+    }
+}
+
+static int get_physical_addr_mpu(CPUXtensaState *env,
+                                 uint32_t vaddr, int is_write, int mmu_idx,
+                                 uint32_t *paddr, uint32_t *page_size,
+                                 unsigned *access)
+{
+    unsigned nhits;
+    unsigned segment;
+    uint32_t attr;
+
+    nhits = xtensa_mpu_lookup(env->mpu_fg, env->config->n_mpu_fg_segments,
+                              vaddr, &segment);
+    if (nhits > 1) {
+        return is_write < 2 ?
+            LOAD_STORE_TLB_MULTI_HIT_CAUSE :
+            INST_TLB_MULTI_HIT_CAUSE;
+    } else if (nhits == 1 && (env->sregs[MPUENB] & (1u << segment))) {
+        attr = env->mpu_fg[segment].attr;
+    } else {
+        xtensa_mpu_lookup(env->config->mpu_bg,
+                          env->config->n_mpu_bg_segments,
+                          vaddr, &segment);
+        attr = env->config->mpu_bg[segment].attr;
+    }
+
+    *access = mpu_attr_to_access(attr, mmu_idx);
+    if (!is_access_granted(*access, is_write)) {
+        return is_write < 2 ?
+            (is_write ?
+             STORE_PROHIBITED_CAUSE :
+             LOAD_PROHIBITED_CAUSE) :
+            INST_FETCH_PROHIBITED_CAUSE;
+    }
+    *paddr = vaddr;
+    *page_size = env->config->mpu_align;
+    return 0;
+}
+
 /*!
  * Convert virtual address to physical addr.
  * MMU may issue pagewalk and change xtensa autorefill TLB way entry.
@@ -743,6 +1047,9 @@ int xtensa_get_physical_addr(CPUXtensaState *env, bool update_tlb,
                 XTENSA_OPTION_BIT(XTENSA_OPTION_REGION_TRANSLATION))) {
         return get_physical_addr_region(env, vaddr, is_write, mmu_idx,
                                         paddr, page_size, access);
+    } else if (xtensa_option_enabled(env->config, XTENSA_OPTION_MPU)) {
+        return get_physical_addr_mpu(env, vaddr, is_write, mmu_idx,
+                                     paddr, page_size, access);
     } else {
         *paddr = vaddr;
         *page_size = TARGET_PAGE_SIZE;
@@ -810,6 +1117,63 @@ static void dump_tlb(CPUXtensaState *env, bool dtlb)
     }
 }
 
+static void dump_mpu(CPUXtensaState *env,
+                     const xtensa_mpu_entry *entry, unsigned n)
+{
+    unsigned i;
+
+    qemu_printf("\t%s  Vaddr       Attr        Ring0  Ring1  System Type    CPU cache\n"
+                "\t%s  ----------  ----------  -----  -----  -------------  ---------\n",
+                env ? "En" : "  ",
+                env ? "--" : "  ");
+
+    for (i = 0; i < n; ++i) {
+        uint32_t attr = entry[i].attr;
+        unsigned access0 = mpu_attr_to_access(attr, 0);
+        unsigned access1 = mpu_attr_to_access(attr, 1);
+        unsigned type = mpu_attr_to_type(attr);
+        char cpu_cache = (type & XTENSA_MPU_TYPE_CPU_CACHE) ? '-' : ' ';
+
+        qemu_printf("\t %c  0x%08x  0x%08x   %c%c%c    %c%c%c   ",
+                    env ?
+                    ((env->sregs[MPUENB] & (1u << i)) ? '+' : '-') : ' ',
+                    entry[i].vaddr, attr,
+                    (access0 & PAGE_READ) ? 'R' : '-',
+                    (access0 & PAGE_WRITE) ? 'W' : '-',
+                    (access0 & PAGE_EXEC) ? 'X' : '-',
+                    (access1 & PAGE_READ) ? 'R' : '-',
+                    (access1 & PAGE_WRITE) ? 'W' : '-',
+                    (access1 & PAGE_EXEC) ? 'X' : '-');
+
+        switch (type & XTENSA_MPU_SYSTEM_TYPE_MASK) {
+        case XTENSA_MPU_SYSTEM_TYPE_DEVICE:
+            qemu_printf("Device %cB %3s\n",
+                        (type & XTENSA_MPU_TYPE_B) ? ' ' : 'n',
+                        (type & XTENSA_MPU_TYPE_INT) ? "int" : "");
+            break;
+        case XTENSA_MPU_SYSTEM_TYPE_NC:
+            qemu_printf("Sys NC %cB      %c%c%c\n",
+                        (type & XTENSA_MPU_TYPE_B) ? ' ' : 'n',
+                        (type & XTENSA_MPU_TYPE_CPU_R) ? 'r' : cpu_cache,
+                        (type & XTENSA_MPU_TYPE_CPU_W) ? 'w' : cpu_cache,
+                        (type & XTENSA_MPU_TYPE_CPU_C) ? 'c' : cpu_cache);
+            break;
+        case XTENSA_MPU_SYSTEM_TYPE_C:
+            qemu_printf("Sys  C %c%c%c     %c%c%c\n",
+                        (type & XTENSA_MPU_TYPE_SYS_R) ? 'R' : '-',
+                        (type & XTENSA_MPU_TYPE_SYS_W) ? 'W' : '-',
+                        (type & XTENSA_MPU_TYPE_SYS_C) ? 'C' : '-',
+                        (type & XTENSA_MPU_TYPE_CPU_R) ? 'r' : cpu_cache,
+                        (type & XTENSA_MPU_TYPE_CPU_W) ? 'w' : cpu_cache,
+                        (type & XTENSA_MPU_TYPE_CPU_C) ? 'c' : cpu_cache);
+            break;
+        default:
+            qemu_printf("Unknown\n");
+            break;
+        }
+    }
+}
+
 void dump_mmu(CPUXtensaState *env)
 {
     if (xtensa_option_bits_enabled(env->config,
@@ -821,6 +1185,11 @@ void dump_mmu(CPUXtensaState *env)
         dump_tlb(env, false);
         qemu_printf("\nDTLB:\n");
         dump_tlb(env, true);
+    } else if (xtensa_option_enabled(env->config, XTENSA_OPTION_MPU)) {
+        qemu_printf("Foreground map:\n");
+        dump_mpu(env, env->mpu_fg, env->config->n_mpu_fg_segments);
+        qemu_printf("\nBackground map:\n");
+        dump_mpu(NULL, env->config->mpu_bg, env->config->n_mpu_bg_segments);
     } else {
         qemu_printf("No TLB for this CPU core\n");
     }
diff --git a/target/xtensa/overlay_tool.h b/target/xtensa/overlay_tool.h
index ffaab4b094cc..b61c92539861 100644
--- a/target/xtensa/overlay_tool.h
+++ b/target/xtensa/overlay_tool.h
@@ -72,6 +72,10 @@
 #define XCHAL_HAVE_EXTERN_REGS 0
 #endif
 
+#ifndef XCHAL_HAVE_MPU
+#define XCHAL_HAVE_MPU 0
+#endif
+
 #define XCHAL_OPTION(xchal, qemu) ((xchal) ? XTENSA_OPTION_BIT(qemu) : 0)
 
 #define XTENSA_OPTIONS ( \
@@ -119,6 +123,7 @@
             XTENSA_OPTION_REGION_PROTECTION) | \
     XCHAL_OPTION(XCHAL_HAVE_XLT_CACHEATTR, \
             XTENSA_OPTION_REGION_TRANSLATION) | \
+    XCHAL_OPTION(XCHAL_HAVE_MPU, XTENSA_OPTION_MPU) | \
     XCHAL_OPTION(XCHAL_HAVE_PTP_MMU, XTENSA_OPTION_MMU) | \
     XCHAL_OPTION(XCHAL_HAVE_CACHEATTR, XTENSA_OPTION_CACHEATTR) | \
     /* Other, TODO */ \
@@ -361,6 +366,30 @@
 #define XCHAL_SYSRAM0_SIZE  0x04000000
 #endif
 
+#elif XCHAL_HAVE_MPU
+
+#ifndef XTENSA_MPU_BG_MAP
+#define XTENSA_MPU_BG_MAP (xtensa_mpu_entry []){\
+    { .vaddr = 0, .attr = 0x00006700, }, \
+}
+#endif
+
+#define TLB_SECTION \
+    .mpu_align = XCHAL_MPU_ALIGN, \
+    .n_mpu_fg_segments = XCHAL_MPU_ENTRIES, \
+    .n_mpu_bg_segments = 1, \
+    .mpu_bg = XTENSA_MPU_BG_MAP
+
+#ifndef XCHAL_SYSROM0_PADDR
+#define XCHAL_SYSROM0_PADDR 0x50000000
+#define XCHAL_SYSROM0_SIZE  0x04000000
+#endif
+
+#ifndef XCHAL_SYSRAM0_PADDR
+#define XCHAL_SYSRAM0_PADDR 0x60000000
+#define XCHAL_SYSRAM0_SIZE  0x04000000
+#endif
+
 #else
 
 #ifndef XCHAL_SYSROM0_PADDR
diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index 63a90fdd17dc..782f2ec62099 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -1992,6 +1992,15 @@ static void translate_ptlb(DisasContext *dc, const OpcodeArg arg[],
 #endif
 }
 
+static void translate_pptlb(DisasContext *dc, const OpcodeArg arg[],
+                            const uint32_t par[])
+{
+#ifndef CONFIG_USER_ONLY
+    tcg_gen_movi_i32(cpu_pc, dc->pc);
+    gen_helper_pptlb(arg[0].out, cpu_env, arg[1].in);
+#endif
+}
+
 static void translate_quos(DisasContext *dc, const OpcodeArg arg[],
                            const uint32_t par[])
 {
@@ -2184,6 +2193,22 @@ static void translate_rtlb(DisasContext *dc, const OpcodeArg arg[],
 #endif
 }
 
+static void translate_rptlb0(DisasContext *dc, const OpcodeArg arg[],
+                             const uint32_t par[])
+{
+#ifndef CONFIG_USER_ONLY
+    gen_helper_rptlb0(arg[0].out, cpu_env, arg[1].in);
+#endif
+}
+
+static void translate_rptlb1(DisasContext *dc, const OpcodeArg arg[],
+                             const uint32_t par[])
+{
+#ifndef CONFIG_USER_ONLY
+    gen_helper_rptlb1(arg[0].out, cpu_env, arg[1].in);
+#endif
+}
+
 static void translate_rur(DisasContext *dc, const OpcodeArg arg[],
                           const uint32_t par[])
 {
@@ -2445,6 +2470,14 @@ static void translate_wtlb(DisasContext *dc, const OpcodeArg arg[],
 #endif
 }
 
+static void translate_wptlb(DisasContext *dc, const OpcodeArg arg[],
+                            const uint32_t par[])
+{
+#ifndef CONFIG_USER_ONLY
+    gen_helper_wptlb(cpu_env, arg[0].in, arg[1].in);
+#endif
+}
+
 static void translate_wer(DisasContext *dc, const OpcodeArg arg[],
                           const uint32_t par[])
 {
@@ -2593,6 +2626,14 @@ static void translate_wsr_memctl(DisasContext *dc, const OpcodeArg arg[],
 #endif
 }
 
+static void translate_wsr_mpuenb(DisasContext *dc, const OpcodeArg arg[],
+                                 const uint32_t par[])
+{
+#ifndef CONFIG_USER_ONLY
+    gen_helper_wsr_mpuenb(cpu_env, arg[0].in);
+#endif
+}
+
 static void translate_wsr_ps(DisasContext *dc, const OpcodeArg arg[],
                              const uint32_t par[])
 {
@@ -2731,6 +2772,7 @@ gen_translate_xsr(ibreaka)
 gen_translate_xsr(ibreakenable)
 gen_translate_xsr(icount)
 gen_translate_xsr(memctl)
+gen_translate_xsr(mpuenb)
 gen_translate_xsr(ps)
 gen_translate_xsr(rasid)
 gen_translate_xsr(sar)
@@ -3581,6 +3623,10 @@ static const XtensaOpcodeOps core_ops[] = {
         .par = (const uint32_t[]){false},
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
+        .name = "pptlb",
+        .translate = translate_pptlb,
+        .op_flags = XTENSA_OP_PRIVILEGED,
+    }, {
         .name = "quos",
         .translate = translate_quos,
         .par = (const uint32_t[]){true},
@@ -3667,6 +3713,14 @@ static const XtensaOpcodeOps core_ops[] = {
         .par = (const uint32_t[]){false, 1},
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
+        .name = "rptlb0",
+        .translate = translate_rptlb0,
+        .op_flags = XTENSA_OP_PRIVILEGED,
+    }, {
+        .name = "rptlb1",
+        .translate = translate_rptlb1,
+        .op_flags = XTENSA_OP_PRIVILEGED,
+    }, {
         .name = "rotw",
         .translate = translate_rotw,
         .op_flags = XTENSA_OP_PRIVILEGED |
@@ -3723,6 +3777,15 @@ static const XtensaOpcodeOps core_ops[] = {
             XTENSA_OPTION_BOOLEAN,
         },
     }, {
+        .name = "rsr.cacheadrdis",
+        .translate = translate_rsr,
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            CACHEADRDIS,
+            XTENSA_OPTION_MPU,
+        },
+        .op_flags = XTENSA_OP_PRIVILEGED,
+    }, {
         .name = "rsr.cacheattr",
         .translate = translate_rsr,
         .test_ill = test_ill_sr,
@@ -3976,6 +4039,11 @@ static const XtensaOpcodeOps core_ops[] = {
         },
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
+        .name = "rsr.eraccess",
+        .translate = translate_rsr,
+        .par = (const uint32_t[]){ERACCESS},
+        .op_flags = XTENSA_OP_PRIVILEGED,
+    }, {
         .name = "rsr.exccause",
         .translate = translate_rsr,
         .test_ill = test_ill_sr,
@@ -4306,6 +4374,24 @@ static const XtensaOpcodeOps core_ops[] = {
         },
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
+        .name = "rsr.mpucfg",
+        .translate = translate_rsr,
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            MPUCFG,
+            XTENSA_OPTION_MPU,
+        },
+        .op_flags = XTENSA_OP_PRIVILEGED,
+    }, {
+        .name = "rsr.mpuenb",
+        .translate = translate_rsr,
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            MPUENB,
+            XTENSA_OPTION_MPU,
+        },
+        .op_flags = XTENSA_OP_PRIVILEGED,
+    }, {
         .name = "rsr.prefctl",
         .translate = translate_rsr,
         .par = (const uint32_t[]){PREFCTL},
@@ -4543,6 +4629,10 @@ static const XtensaOpcodeOps core_ops[] = {
         .par = (const uint32_t[]){false},
         .op_flags = XTENSA_OP_PRIVILEGED | XTENSA_OP_EXIT_TB_M1,
     }, {
+        .name = "wptlb",
+        .translate = translate_wptlb,
+        .op_flags = XTENSA_OP_PRIVILEGED | XTENSA_OP_EXIT_TB_M1,
+    }, {
         .name = "wrmsk_expstate",
         .translate = translate_wrmsk_expstate,
     }, {
@@ -4587,6 +4677,16 @@ static const XtensaOpcodeOps core_ops[] = {
             0xffff,
         },
     }, {
+        .name = "wsr.cacheadrdis",
+        .translate = translate_wsr_mask,
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            CACHEADRDIS,
+            XTENSA_OPTION_MPU,
+            0xff,
+        },
+        .op_flags = XTENSA_OP_PRIVILEGED,
+    }, {
         .name = "wsr.cacheattr",
         .translate = translate_wsr,
         .test_ill = test_ill_sr,
@@ -4832,6 +4932,15 @@ static const XtensaOpcodeOps core_ops[] = {
         },
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
+        .name = "wsr.eraccess",
+        .translate = translate_wsr_mask,
+        .par = (const uint32_t[]){
+            ERACCESS,
+            0,
+            0xffff,
+        },
+        .op_flags = XTENSA_OP_PRIVILEGED,
+    }, {
         .name = "wsr.exccause",
         .translate = translate_wsr,
         .test_ill = test_ill_sr,
@@ -5189,6 +5298,15 @@ static const XtensaOpcodeOps core_ops[] = {
         },
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
+        .name = "wsr.mpuenb",
+        .translate = translate_wsr_mpuenb,
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            MPUENB,
+            XTENSA_OPTION_MPU,
+        },
+        .op_flags = XTENSA_OP_PRIVILEGED | XTENSA_OP_EXIT_TB_M1,
+    }, {
         .name = "wsr.prefctl",
         .translate = translate_wsr,
         .par = (const uint32_t[]){PREFCTL},
@@ -5334,6 +5452,16 @@ static const XtensaOpcodeOps core_ops[] = {
             0xffff,
         },
     }, {
+        .name = "xsr.cacheadrdis",
+        .translate = translate_xsr_mask,
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            CACHEADRDIS,
+            XTENSA_OPTION_MPU,
+            0xff,
+        },
+        .op_flags = XTENSA_OP_PRIVILEGED,
+    }, {
         .name = "xsr.cacheattr",
         .translate = translate_xsr,
         .test_ill = test_ill_sr,
@@ -5579,6 +5707,15 @@ static const XtensaOpcodeOps core_ops[] = {
         },
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
+        .name = "xsr.eraccess",
+        .translate = translate_xsr_mask,
+        .par = (const uint32_t[]){
+            ERACCESS,
+            0,
+            0xffff,
+        },
+        .op_flags = XTENSA_OP_PRIVILEGED,
+    }, {
         .name = "xsr.exccause",
         .translate = translate_xsr,
         .test_ill = test_ill_sr,
@@ -5900,6 +6037,15 @@ static const XtensaOpcodeOps core_ops[] = {
         },
         .op_flags = XTENSA_OP_PRIVILEGED,
     }, {
+        .name = "xsr.mpuenb",
+        .translate = translate_xsr_mpuenb,
+        .test_ill = test_ill_sr,
+        .par = (const uint32_t[]){
+            MPUENB,
+            XTENSA_OPTION_MPU,
+        },
+        .op_flags = XTENSA_OP_PRIVILEGED | XTENSA_OP_EXIT_TB_M1,
+    }, {
         .name = "xsr.prefctl",
         .translate = translate_xsr,
         .par = (const uint32_t[]){PREFCTL},
-- 
2.11.0


