Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B5D9C06511
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 15:06:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 579902146F
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 15:06:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iYfBKDtt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 579902146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiKM6-0004HI-Js
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 11:06:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57007)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hiKI7-0001hK-Pr
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 11:02:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hiKI4-0004go-Rb
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 11:01:55 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:41989)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1hiKI2-0004PQ-49
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 11:01:51 -0400
Received: by mail-wr1-x441.google.com with SMTP id x17so18205324wrl.9
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2019 08:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=z7SMJQN5ch0Lf7RMVZTRcrUdNwwfv1XHqd7aVFJ/HLw=;
 b=iYfBKDttAdFhAuMWLdFLPZattY0I4oJ45Iul5k4rTyp34PTpJpyX3wkvyX1HcqAVQP
 T6IVH4H/OA0NYpFTfRvl3/aCcl0kl9JxYfiVNPRfeCex//U9H+TdiBgTRP4V116otQpP
 CQX750okeIJcp3KptEmONYN2Am4hpNnBfq9IkOZaeAHX6hYQOwQtMBfI9T+mkQG4kUze
 pDJ2Wdfg56mIj7vd8kmaaps66YpCptNjvF+p2i6Ds+JDuCc1a4AF2+kwC0gzOghnxGvh
 KEwjOIInDWCyTurjM6kYPQEGZDcVOaHRSPWDtZqyGK6/XcBRM4aHu5w0TwcbR+5pa7LZ
 jzUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=z7SMJQN5ch0Lf7RMVZTRcrUdNwwfv1XHqd7aVFJ/HLw=;
 b=UbJPl9RwhL99mX3goigdF7EimHbCtWcFiWDvG59B1Yq5CTFPYS+8356/ndzyZx/t0R
 qS4xwGDHzyr2lVzOwvmFi83bSCJoMh+r5MfKNVmtGKHqnGqfG4zh9CQ4txv1mQe2Ak5q
 fkFNIkwi31g2EMc5VDSkvIc0ydZrvK9YGbBIaVvlpFXoJFW6W1n6gVpYJaEnPbe0c1nE
 w+iPa8ScS220GTplUBDjmnOM/Hcjp/MAvnE9xlFhXHSDk8Qsbg6kmV1ZMGikCCSAzIRh
 EHOf2wvuiIc7R0zhB1V+108ckk8fTvThfV0FqHfRLBEYgRR/5uMFfG/5hutNBh6X/Sbg
 VHXQ==
X-Gm-Message-State: APjAAAWsuTJmAz1BtYgv6RR02wLuWOlu0g4O87cgP9youkvwPHnzQOdg
 u3YwONsjtenvtwUsyPpD8JIoji2wZP0=
X-Google-Smtp-Source: APXvYqzaQ12nxUvnytKPYXPageNnqsvygsLhkqaDsXmgBiN/hAAGYlXMCfdjQyRxjUVu+kA24KUzbw==
X-Received: by 2002:adf:c508:: with SMTP id q8mr19559372wrf.148.1562079684340; 
 Tue, 02 Jul 2019 08:01:24 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id m24sm3006262wmi.39.2019.07.02.08.01.23
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 02 Jul 2019 08:01:23 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue,  2 Jul 2019 17:01:15 +0200
Message-Id: <1562079681-19204-2-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1562079681-19204-1-git-send-email-pbonzini@redhat.com>
References: <1562079681-19204-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: [Qemu-devel] [PATCH 1/7] target/i386: handle filtered_features in a
 new function mark_unavailable_features
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

The next patch will add a different reason for filtering features, unrelated
to host feature support.  Extract a new function that takes care of disabling
the features and reporting them.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 76 ++++++++++++++++++++++++++++++-------------------------
 1 file changed, 41 insertions(+), 35 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index da6eb67..9149d0d 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -3236,17 +3236,39 @@ static char *feature_word_description(FeatureWordInfo *f, uint32_t bit)
     return NULL;
 }
 
-static void report_unavailable_features(FeatureWord w, uint32_t mask)
+static bool x86_cpu_have_filtered_features(X86CPU *cpu)
 {
+    FeatureWord w;
+
+    for (w = 0; w < ARRAY_SIZE(feature_word_info); w++) {
+         if (cpu->filtered_features[w]) {
+             return true;
+         }
+    }
+
+    return false;
+}
+
+static void mark_unavailable_features(X86CPU *cpu, FeatureWord w, uint32_t mask,
+                                      const char *prefix)
+{
+    CPUX86State *env = &cpu->env;
     FeatureWordInfo *f = &feature_word_info[w];
     int i;
     char *feat_word_str;
 
+    env->features[w] &= ~mask;
+    cpu->filtered_features[w] |= mask;
+
+    if (!cpu->check_cpuid && !cpu->enforce_cpuid) {
+        return;
+    }
+
     for (i = 0; i < 32; ++i) {
         if ((1UL << i) & mask) {
             feat_word_str = feature_word_description(f, i);
-            warn_report("%s doesn't support requested feature: %s%s%s [bit %d]",
-                        accel_uses_host_cpuid() ? "host" : "TCG",
+            warn_report("%s: %s%s%s [bit %d]",
+                        prefix,
                         feat_word_str,
                         f->feat_names[i] ? "." : "",
                         f->feat_names[i] ? f->feat_names[i] : "", i);
@@ -3691,7 +3713,7 @@ static void x86_cpu_parse_featurestr(const char *typename, char *features,
 }
 
 static void x86_cpu_expand_features(X86CPU *cpu, Error **errp);
-static int x86_cpu_filter_features(X86CPU *cpu);
+static void x86_cpu_filter_features(X86CPU *cpu);
 
 /* Build a list with the name of all features on a feature word array */
 static void x86_cpu_list_feature_names(FeatureWordArray features,
@@ -3923,15 +3945,6 @@ static uint32_t x86_cpu_get_supported_feature_word(FeatureWord w,
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
@@ -5170,21 +5183,20 @@ out:
  *
  * Returns: 0 if all flags are supported by the host, non-zero otherwise.
  */
-static int x86_cpu_filter_features(X86CPU *cpu)
+static void x86_cpu_filter_features(X86CPU *cpu)
 {
     CPUX86State *env = &cpu->env;
     FeatureWord w;
-    int rv = 0;
+    const char *prefix = accel_uses_host_cpuid()
+                         ? "host doesn't support requested feature"
+                         : "TCG doesn't support requested feature";
 
     for (w = 0; w < FEATURE_WORDS; w++) {
         uint32_t host_feat =
             x86_cpu_get_supported_feature_word(w, false);
         uint32_t requested_features = env->features[w];
-        env->features[w] &= host_feat;
-        cpu->filtered_features[w] = requested_features & ~env->features[w];
-        if (cpu->filtered_features[w]) {
-            rv = 1;
-        }
+        uint32_t unavailable_features = requested_features & ~host_feat;
+        mark_unavailable_features(cpu, w, unavailable_features, prefix);
     }
 
     if ((env->features[FEAT_7_0_EBX] & CPUID_7_0_EBX_INTEL_PT) &&
@@ -5210,13 +5222,9 @@ static int x86_cpu_filter_features(X86CPU *cpu)
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
@@ -5257,16 +5265,14 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
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
+    x86_cpu_filter_features(cpu);
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



