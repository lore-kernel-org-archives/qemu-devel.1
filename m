Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46C8BC06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 15:09:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03CA12146F
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 15:09:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="khT7ruDg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03CA12146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54323 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiKPS-00085A-91
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 11:09:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57243)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hiKIW-0001xM-2Y
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 11:02:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hiKIT-0004wL-5D
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 11:02:19 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:39708)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1hiKIS-0004Qg-NQ
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 11:02:16 -0400
Received: by mail-wm1-x344.google.com with SMTP id z23so1386765wma.4
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2019 08:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=K+89fQ/fX+ypbNnKP14sPM2acp10lPWkFTDtpz8P/es=;
 b=khT7ruDgDEIZqirs/6PAHAs8RWLnXixc/SlhigdGtJRD8HpJb8KsSUSODwegOENu8v
 SU8XHtXw/q546dvoIELH8rde2a9Aw8p2vQeNe7f2JEgxhmY297bPU+R94Nw41BtVhuT5
 k/AbPN+M7Z/t/yaA9AVHce8GVZjGRd4gfmwLw1FkSBOOjFFM2qVjOBVbSd1IE5JwvHU0
 /maN32xLvUcfl07UtrEOgaFHv5frv9jQtS8cSjELq+jp2W3hjACWhUcjZKrJjh6MSN6Y
 g5GE7nZPTlMK5AO7hcyu9tQjKRE8nj7WcO/cve/Byb2RuJIZEQaQRFWTgqqNvzEgBK5N
 Ig+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=K+89fQ/fX+ypbNnKP14sPM2acp10lPWkFTDtpz8P/es=;
 b=NhY5GD9enuqP2sQ1xoTQAq+6nh/xgFc+6T4eRFeysB0CEsUMEkTptsb9YW+dcpmt5v
 8ue0UppLL1Tg+vy+5DpW49ej3Mo6DoaZegSZI0T2FtxqO2GkYot9mZhqYPYRdMD8Ml+f
 +6NCNQdVBX55VsGgnWsMTQZNBEtvAGOYyf5KdTvHahXpJZWxJg7tDVKyK6sN01Hi5JhY
 wAkUlxfPdgNHo+bO3pBh+SlPF/RyJBYj9DSMgj81mldM31W4TFltWt1HhRldzQNw+p8X
 jbw/+sp9uqz/K+7y3o/83doL4idvE69OLcdIDBHthGiCZEhN0iakX99IlSYO64IfDMuS
 640w==
X-Gm-Message-State: APjAAAWkQb5Kwy1ggH7FhVCO9Rz3DvkMIVvVUKNP2Tuo2pl7CiE0VZ3p
 +absIVyg4DH0L3WYma3QMnYO5LcJGKg=
X-Google-Smtp-Source: APXvYqx/i4zk4DZJbEc0AO0abm4CPu9RuOUnjBlmPadGH7NcsMx7Pkhu1b73oHCrT8LnTwlQgufEgA==
X-Received: by 2002:a1c:544d:: with SMTP id p13mr3974366wmi.78.1562079686711; 
 Tue, 02 Jul 2019 08:01:26 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id m24sm3006262wmi.39.2019.07.02.08.01.25
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 02 Jul 2019 08:01:25 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue,  2 Jul 2019 17:01:17 +0200
Message-Id: <1562079681-19204-4-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1562079681-19204-1-git-send-email-pbonzini@redhat.com>
References: <1562079681-19204-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: [Qemu-devel] [PATCH 3/7] target/i386: expand feature words to 64
 bits
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
Cc: Liran Alon <liran.alon@oracle.com>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

VMX requires 64-bit feature words for the IA32_VMX_EPT_VPID_CAP
and IA32_VMX_BASIC MSRs.  (The VMX control MSRs are 64-bit wide but
actually have only 32 bits of information).

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/sysemu/kvm.h |  2 +-
 target/i386/cpu.c    | 63 +++++++++++++++++++++++++++-------------------------
 target/i386/cpu.h    |  4 ++--
 target/i386/kvm.c    |  2 +-
 4 files changed, 37 insertions(+), 34 deletions(-)

diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index acd90ae..f8157bc 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -463,7 +463,7 @@ int kvm_vm_check_extension(KVMState *s, unsigned int extension);
 
 uint32_t kvm_arch_get_supported_cpuid(KVMState *env, uint32_t function,
                                       uint32_t index, int reg);
-uint32_t kvm_arch_get_supported_msr_feature(KVMState *s, uint32_t index);
+uint64_t kvm_arch_get_supported_msr_feature(KVMState *s, uint32_t index);
 
 
 void kvm_set_sigmask_len(KVMState *s, unsigned int sigmask_len);
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 412e834..4de44e4 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -787,7 +787,7 @@ typedef struct FeatureWordInfo {
      * In cases of disagreement between feature naming conventions,
      * aliases may be added.
      */
-    const char *feat_names[32];
+    const char *feat_names[64];
     union {
         /* If type==CPUID_FEATURE_WORD */
         struct {
@@ -801,11 +801,11 @@ typedef struct FeatureWordInfo {
             uint32_t index;
         } msr;
     };
-    uint32_t tcg_features; /* Feature flags supported by TCG */
-    uint32_t unmigratable_flags; /* Feature flags known to be unmigratable */
-    uint32_t migratable_flags; /* Feature flags known to be migratable */
+    uint64_t tcg_features; /* Feature flags supported by TCG */
+    uint64_t unmigratable_flags; /* Feature flags known to be unmigratable */
+    uint64_t migratable_flags; /* Feature flags known to be migratable */
     /* Features that shouldn't be auto-enabled by "-cpu host" */
-    uint32_t no_autoenable_flags;
+    uint64_t no_autoenable_flags;
 } FeatureWordInfo;
 
 static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
@@ -1337,14 +1337,14 @@ const char *get_register_name_32(unsigned int reg)
  * Returns the set of feature flags that are supported and migratable by
  * QEMU, for a given FeatureWord.
  */
-static uint32_t x86_cpu_get_migratable_flags(FeatureWord w)
+static uint64_t x86_cpu_get_migratable_flags(FeatureWord w)
 {
     FeatureWordInfo *wi = &feature_word_info[w];
-    uint32_t r = 0;
+    uint64_t r = 0;
     int i;
 
-    for (i = 0; i < 32; i++) {
-        uint32_t f = 1U << i;
+    for (i = 0; i < 64; i++) {
+        uint64_t f = 1ULL << i;
 
         /* If the feature name is known, it is implicitly considered migratable,
          * unless it is explicitly set in unmigratable_flags */
@@ -3059,7 +3059,7 @@ void x86_cpu_change_kvm_default(const char *prop, const char *value)
     assert(pv->prop);
 }
 
-static uint32_t x86_cpu_get_supported_feature_word(FeatureWord w,
+static uint64_t x86_cpu_get_supported_feature_word(FeatureWord w,
                                                    bool migratable_only);
 
 static bool lmce_supported(void)
@@ -3253,7 +3253,7 @@ static bool x86_cpu_have_filtered_features(X86CPU *cpu)
     return false;
 }
 
-static void mark_unavailable_features(X86CPU *cpu, FeatureWord w, uint32_t mask,
+static void mark_unavailable_features(X86CPU *cpu, FeatureWord w, uint64_t mask,
                                       const char *prefix)
 {
     CPUX86State *env = &cpu->env;
@@ -3268,8 +3268,8 @@ static void mark_unavailable_features(X86CPU *cpu, FeatureWord w, uint32_t mask,
         return;
     }
 
-    for (i = 0; i < 32; ++i) {
-        if ((1UL << i) & mask) {
+    for (i = 0; i < 64; ++i) {
+        if ((1ULL << i) & mask) {
             feat_word_str = feature_word_description(f, i);
             warn_report("%s: %s%s%s [bit %d]",
                         prefix,
@@ -3512,7 +3512,7 @@ static void x86_cpu_get_feature_words(Object *obj, Visitor *v,
                                       const char *name, void *opaque,
                                       Error **errp)
 {
-    uint32_t *array = (uint32_t *)opaque;
+    uint64_t *array = (uint64_t *)opaque;
     FeatureWord w;
     X86CPUFeatureWordInfo word_infos[FEATURE_WORDS] = { };
     X86CPUFeatureWordInfoList list_entries[FEATURE_WORDS] = { };
@@ -3596,6 +3596,7 @@ static inline void feat2prop(char *s)
 /* Return the feature property name for a feature flag bit */
 static const char *x86_cpu_feature_name(FeatureWord w, int bitnr)
 {
+    const char *name;
     /* XSAVE components are automatically enabled by other features,
      * so return the original feature name instead
      */
@@ -3609,9 +3610,11 @@ static const char *x86_cpu_feature_name(FeatureWord w, int bitnr)
         }
     }
 
-    assert(bitnr < 32);
+    assert(bitnr < 64);
     assert(w < FEATURE_WORDS);
-    return feature_word_info[w].feat_names[bitnr];
+    name = feature_word_info[w].feat_names[bitnr];
+    assert(bitnr < 32 || !(name && feature_word_info[w].type == CPUID_FEATURE_WORD));
+    return name;
 }
 
 /* Compatibily hack to maintain legacy +-feat semantic,
@@ -3727,10 +3730,10 @@ static void x86_cpu_list_feature_names(FeatureWordArray features,
     strList **next = feat_names;
 
     for (w = 0; w < FEATURE_WORDS; w++) {
-        uint32_t filtered = features[w];
+        uint64_t filtered = features[w];
         int i;
-        for (i = 0; i < 32; i++) {
-            if (filtered & (1UL << i)) {
+        for (i = 0; i < 64; i++) {
+            if (filtered & (1ULL << i)) {
                 strList *new = g_new0(strList, 1);
                 new->value = g_strdup(x86_cpu_feature_name(w, i));
                 *next = new;
@@ -3866,7 +3869,7 @@ void x86_cpu_list(void)
     names = NULL;
     for (i = 0; i < ARRAY_SIZE(feature_word_info); i++) {
         FeatureWordInfo *fw = &feature_word_info[i];
-        for (j = 0; j < 32; j++) {
+        for (j = 0; j < 64; j++) {
             if (fw->feat_names[j]) {
                 names = g_list_append(names, (gpointer)fw->feat_names[j]);
             }
@@ -3913,11 +3916,11 @@ CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
     return cpu_list;
 }
 
-static uint32_t x86_cpu_get_supported_feature_word(FeatureWord w,
+static uint64_t x86_cpu_get_supported_feature_word(FeatureWord w,
                                                    bool migratable_only)
 {
     FeatureWordInfo *wi = &feature_word_info[w];
-    uint32_t r = 0;
+    uint64_t r = 0;
 
     if (kvm_enabled()) {
         switch (wi->type) {
@@ -4057,7 +4060,7 @@ static QDict *x86_cpu_static_props(void)
     for (w = 0; w < FEATURE_WORDS; w++) {
         FeatureWordInfo *fi = &feature_word_info[w];
         int bit;
-        for (bit = 0; bit < 32; bit++) {
+        for (bit = 0; bit < 64; bit++) {
             if (!fi->feat_names[bit]) {
                 continue;
             }
@@ -5213,10 +5216,10 @@ static void x86_cpu_filter_features(X86CPU *cpu)
                          : "TCG doesn't support requested feature";
 
     for (w = 0; w < FEATURE_WORDS; w++) {
-        uint32_t host_feat =
+        uint64_t host_feat =
             x86_cpu_get_supported_feature_word(w, false);
-        uint32_t requested_features = env->features[w];
-        uint32_t unavailable_features = requested_features & ~host_feat;
+        uint64_t requested_features = env->features[w];
+        uint64_t unavailable_features = requested_features & ~host_feat;
         mark_unavailable_features(cpu, w, unavailable_features, prefix);
     }
 
@@ -5512,7 +5515,7 @@ static void x86_cpu_unrealizefn(DeviceState *dev, Error **errp)
 
 typedef struct BitProperty {
     FeatureWord w;
-    uint32_t mask;
+    uint64_t mask;
 } BitProperty;
 
 static void x86_cpu_get_bit_prop(Object *obj, Visitor *v, const char *name,
@@ -5520,7 +5523,7 @@ static void x86_cpu_get_bit_prop(Object *obj, Visitor *v, const char *name,
 {
     X86CPU *cpu = X86_CPU(obj);
     BitProperty *fp = opaque;
-    uint32_t f = cpu->env.features[fp->w];
+    uint64_t f = cpu->env.features[fp->w];
     bool value = (f & fp->mask) == fp->mask;
     visit_type_bool(v, name, &value, errp);
 }
@@ -5573,7 +5576,7 @@ static void x86_cpu_register_bit_prop(X86CPU *cpu,
 {
     BitProperty *fp;
     ObjectProperty *op;
-    uint32_t mask = (1UL << bitnr);
+    uint64_t mask = (1ULL << bitnr);
 
     op = object_property_find(OBJECT(cpu), prop_name, NULL);
     if (op) {
@@ -5708,7 +5711,7 @@ static void x86_cpu_initfn(Object *obj)
     for (w = 0; w < FEATURE_WORDS; w++) {
         int bitnr;
 
-        for (bitnr = 0; bitnr < 32; bitnr++) {
+        for (bitnr = 0; bitnr < 64; bitnr++) {
             x86_cpu_register_feature_bit_props(cpu, w, bitnr);
         }
     }
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 9334579..4e5dc30 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -501,7 +501,7 @@ typedef enum FeatureWord {
     FEATURE_WORDS,
 } FeatureWord;
 
-typedef uint32_t FeatureWordArray[FEATURE_WORDS];
+typedef uint64_t FeatureWordArray[FEATURE_WORDS];
 
 /* cpuid_features bits */
 #define CPUID_FP87 (1U << 0)
@@ -1438,7 +1438,7 @@ struct X86CPU {
     } mwait;
 
     /* Features that were filtered out because of missing host capabilities */
-    uint32_t filtered_features[FEATURE_WORDS];
+    FeatureWordArray filtered_features;
 
     /* Enable PMU CPUID bits. This can't be enabled by default yet because
      * it doesn't have ABI stability guarantees, as it passes all PMU CPUID
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index e4b4f57..6801696 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -432,7 +432,7 @@ uint32_t kvm_arch_get_supported_cpuid(KVMState *s, uint32_t function,
     return ret;
 }
 
-uint32_t kvm_arch_get_supported_msr_feature(KVMState *s, uint32_t index)
+uint64_t kvm_arch_get_supported_msr_feature(KVMState *s, uint32_t index)
 {
     struct {
         struct kvm_msrs info;
-- 
1.8.3.1



