Return-Path: <SRS0=aoXf=X5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02120C4360C
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 17:08:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C27532084D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 17:08:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nqccnty7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C27532084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGR3f-0003Tg-Ex
	for qemu-devel@archiver.kernel.org; Fri, 04 Oct 2019 13:07:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51082)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iGQvU-0007Mg-2C
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 12:59:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iGQvS-0001ta-Mr
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 12:59:31 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:39670)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iGQvS-0001ss-7Q
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 12:59:30 -0400
Received: by mail-wr1-x441.google.com with SMTP id r3so8091459wrj.6
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2019 09:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references;
 bh=ENyllfGZkEo7zYLWR0n6K+bmlcFkTFrnASUR8ihWMqE=;
 b=nqccnty7ksBxLKCFiLX2OGBce1x6BVWqnWL1Y9nlliPP9+mSO4m1awwUZnHwgEh0aB
 MdQEg0ccgbVQLJn+J+rSwB3LPNxQzIWhscybVHuSh8EgUeI068Xe6zzR0O8RPe3XI+Xm
 myjcJ3Aan8foHbvm+Pe55HGOYD+NXoQweXX1p6GtusM6yF1b4/M9LyBcbgg4yiNYGa1b
 L35B5keAI5VKjG9ZHkiLEuigQr0f71kXupXr8xAccEqDXk1UIp9uAefj9hYWAv1vTrOQ
 q5tHEXm5+Kcjg59f1UOfLlEuiDgoEX80288t8OOo93MI+NtzYfc6zoh6HOJ9ltM4KRWT
 xqgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references;
 bh=ENyllfGZkEo7zYLWR0n6K+bmlcFkTFrnASUR8ihWMqE=;
 b=C7a7aUZc8xfR+nVrQuwHWwN+EntDtwZAoaSpyXKQz9zj17XJKemucoRLe5NPPD1BFs
 AlR1wtf6aZLLHm4J+ZVdIY6eYi8isSY2RdS22WedsEZ5n5XAiz6UJA7WhzaYkxqMRbw0
 8y4W62Xup+oiEs7VdWojIFurZIzhodCMUod2OssgqczpuFcdUNeqCuSkXKexL8ExEmeQ
 2pFcxjHQBF7Q13qO9a0JWPez7OENCFgKpw06dXIf27dU11yTbQ2BMk0QSLx/WqKeT9mx
 azJe/A9Ms7SApDEbzZHXwm6uZa+SHFHW875+Lf3+GBwtO/KntpnlBDP+6MSokWb/iLb1
 X2ZQ==
X-Gm-Message-State: APjAAAVLMd5tlB4KS6w5MfW8wdHV76Yq1B0guF/lPNfE+ezNpxRPfiyi
 250LnO95FMRp5lRdlZelCtFauKYD
X-Google-Smtp-Source: APXvYqwoOlY22GQUnea/wndo5ciU7LKDLDCtHEf2+vOLJbaDBIQMLzkTMtEgo4jIlJyPGJR1dHTlNQ==
X-Received: by 2002:a5d:44d2:: with SMTP id z18mr12761375wrr.122.1570208367673; 
 Fri, 04 Oct 2019 09:59:27 -0700 (PDT)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id u7sm7041270wrp.19.2019.10.04.09.59.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 04 Oct 2019 09:59:26 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 22/29] target/i386: handle filtered_features in a new function
 mark_unavailable_features
Date: Fri,  4 Oct 2019 18:59:16 +0200
Message-Id: <1570208363-11948-2-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1570208363-11948-1-git-send-email-pbonzini@redhat.com>
References: <1570208363-11948-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The next patch will add a different reason for filtering features, unrelated
to host feature support.  Extract a new function that takes care of disabling
the features and optionally reporting them.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 87 ++++++++++++++++++++++++++++++-------------------------
 1 file changed, 48 insertions(+), 39 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 80cfab0..83f8981 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -3096,17 +3096,41 @@ static char *feature_word_description(FeatureWordInfo *f, uint32_t bit)
     return NULL;
 }
 
-static void report_unavailable_features(FeatureWord w, uint32_t mask)
+static bool x86_cpu_have_filtered_features(X86CPU *cpu)
 {
+    FeatureWord w;
+
+    for (w = 0; w < FEATURE_WORDS; w++) {
+        if (cpu->filtered_features[w]) {
+            return true;
+        }
+    }
+
+    return false;
+}
+
+static void mark_unavailable_features(X86CPU *cpu, FeatureWord w, uint32_t mask,
+                                      const char *verbose_prefix)
+{
+    CPUX86State *env = &cpu->env;
     FeatureWordInfo *f = &feature_word_info[w];
     int i;
     char *feat_word_str;
 
+    if (!cpu->force_features) {
+        env->features[w] &= ~mask;
+    }
+    cpu->filtered_features[w] |= mask;
+
+    if (!verbose_prefix) {
+        return;
+    }
+
     for (i = 0; i < 32; ++i) {
         if ((1UL << i) & mask) {
             feat_word_str = feature_word_description(f, i);
-            warn_report("%s doesn't support requested feature: %s%s%s [bit %d]",
-                        accel_uses_host_cpuid() ? "host" : "TCG",
+            warn_report("%s: %s%s%s [bit %d]",
+                        verbose_prefix,
                         feat_word_str,
                         f->feat_names[i] ? "." : "",
                         f->feat_names[i] ? f->feat_names[i] : "", i);
@@ -3511,7 +3535,7 @@ static void x86_cpu_parse_featurestr(const char *typename, char *features,
 }
 
 static void x86_cpu_expand_features(X86CPU *cpu, Error **errp);
-static int x86_cpu_filter_features(X86CPU *cpu);
+static void x86_cpu_filter_features(X86CPU *cpu, bool verbose);
 
 /* Build a list with the name of all features on a feature word array */
 static void x86_cpu_list_feature_names(FeatureWordArray features,
@@ -3576,7 +3600,7 @@ static void x86_cpu_class_check_missing_features(X86CPUClass *xcc,
         next = &new->next;
     }
 
-    x86_cpu_filter_features(xc);
+    x86_cpu_filter_features(xc, false);
 
     x86_cpu_list_feature_names(xc->filtered_features, next);
 
@@ -3784,15 +3808,6 @@ static uint32_t x86_cpu_get_supported_feature_word(FeatureWord w,
     return r;
 }
 
-static void x86_cpu_report_filtered_features(X86CPU *cpu)
-{
-    FeatureWord w;
-
-    for (w = 0; w < FEATURE_WORDS; w++) {
-        report_unavailable_features(w, cpu->filtered_features[w]);
-    }
-}
-
 static void x86_cpu_apply_props(X86CPU *cpu, PropValue *props)
 {
     PropValue *pv;
@@ -5154,24 +5169,24 @@ out:
  *
  * Returns: 0 if all flags are supported by the host, non-zero otherwise.
  */
-static int x86_cpu_filter_features(X86CPU *cpu)
+static void x86_cpu_filter_features(X86CPU *cpu, bool verbose)
 {
     CPUX86State *env = &cpu->env;
     FeatureWord w;
-    int rv = 0;
+    const char *prefix = NULL;
+
+    if (verbose) {
+        prefix = accel_uses_host_cpuid()
+                 ? "host doesn't support requested feature"
+                 : "TCG doesn't support requested feature";
+    }
 
     for (w = 0; w < FEATURE_WORDS; w++) {
         uint32_t host_feat =
             x86_cpu_get_supported_feature_word(w, false);
         uint32_t requested_features = env->features[w];
-        uint32_t available_features = requested_features & host_feat;
-        if (!cpu->force_features) {
-            env->features[w] = available_features;
-        }
-        cpu->filtered_features[w] = requested_features & ~available_features;
-        if (cpu->filtered_features[w]) {
-            rv = 1;
-        }
+        uint32_t unavailable_features = requested_features & ~host_feat;
+        mark_unavailable_features(cpu, w, unavailable_features, prefix);
     }
 
     if ((env->features[FEAT_7_0_EBX] & CPUID_7_0_EBX_INTEL_PT) &&
@@ -5197,13 +5212,9 @@ static int x86_cpu_filter_features(X86CPU *cpu)
              * host can't emulate the capabilities we report on
              * cpu_x86_cpuid(), intel-pt can't be enabled on the current host.
              */
-            env->features[FEAT_7_0_EBX] &= ~CPUID_7_0_EBX_INTEL_PT;
-            cpu->filtered_features[FEAT_7_0_EBX] |= CPUID_7_0_EBX_INTEL_PT;
-            rv = 1;
+            mark_unavailable_features(cpu, FEAT_7_0_EBX, CPUID_7_0_EBX_INTEL_PT, prefix);
         }
     }
-
-    return rv;
 }
 
 static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
@@ -5244,16 +5255,14 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
         goto out;
     }
 
-    if (x86_cpu_filter_features(cpu) &&
-        (cpu->check_cpuid || cpu->enforce_cpuid)) {
-        x86_cpu_report_filtered_features(cpu);
-        if (cpu->enforce_cpuid) {
-            error_setg(&local_err,
-                       accel_uses_host_cpuid() ?
-                           "Host doesn't support requested features" :
-                           "TCG doesn't support requested features");
-            goto out;
-        }
+    x86_cpu_filter_features(cpu, cpu->check_cpuid || cpu->enforce_cpuid);
+
+    if (cpu->enforce_cpuid && x86_cpu_have_filtered_features(cpu)) {
+        error_setg(&local_err,
+                   accel_uses_host_cpuid() ?
+                       "Host doesn't support requested features" :
+                       "TCG doesn't support requested features");
+        goto out;
     }
 
     /* On AMD CPUs, some CPUID[8000_0001].EDX bits must match the bits on
-- 
1.8.3.1



