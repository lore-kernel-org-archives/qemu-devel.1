Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37AD6C06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 15:08:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 044F92146F
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 15:08:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cin77Rru"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 044F92146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiKOc-0006vo-6k
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 11:08:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57008)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hiKI7-0001hN-QD
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 11:02:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hiKI5-0004hf-TU
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 11:01:55 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:37170)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1hiKI3-0004QQ-Rc
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 11:01:52 -0400
Received: by mail-wm1-x341.google.com with SMTP id f17so1402680wme.2
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2019 08:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=l+HvfXgsR2im8E+Ar9XqWafF5GI151pZVuknRW+lRlo=;
 b=Cin77Rru8tOXgrIIlyH1HATi306+b2U/7Oh5x+Jij5UbXwF/fz3hbM0b32RAuzkUQ2
 sxNGCHczs3BHpi1jlvwNW1GBTQu4NMmc5nNfWNERY97qzu6ptXwOsmT1JmO5quGHQyOy
 tyPBY3UMTAY1UZ5zXBhPNUYxvIDOGDhe71N1KL2b8IjAUbmOIKvrbS8zMBtLvfs9VK+W
 tLUGecaebSbFey2VBV8wfEuwfen+zEQSRmD8Rwkrxl/T8rkEKuyabMdNjxAmE7XDuD9d
 xYNr0TYaO8loJCYCOtEVb8nXdwjOxV7vmPYQAoECMnqNKJ4/nLtCL/sQKaKm789rtCj6
 30xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=l+HvfXgsR2im8E+Ar9XqWafF5GI151pZVuknRW+lRlo=;
 b=PxKypkdy2atgH9zvpNjzP8slDf+9kXHPR1GOu13hQUaSgRPyyhA6n2KTi8w9pJkg//
 MuT5PolmP0C19xkh4k28wtTplXgkteDEOvakyw5Os9qFZMJe+asAMPaxaveDcslGunlT
 JUKqPisWYJ2pCldfA8NtqJY5rLT1yOCxEtIvw9TwxwKqX6CSj35b0XZOitcP+7D9C7b2
 RFIWnDgJJPDdACxObZMlRrb+jdQg9ZGGNvoxS44OJrrmUBy3IYEN+52zxt+2IzW5B8i6
 RUztXshAjv5BO0MOidTv5BKOyVSoQ+JP7TU7Udsj9WRUVMLtVCzYgttGRcU+IWtLTT+/
 O9ag==
X-Gm-Message-State: APjAAAULP83ee8sYOi39NRfHevN/51VdQv/+Y1EAPovQSPqdQcRv/Twk
 Z9OzF+Q4kgUZ+LCxkCWh4Dcx8npy+kk=
X-Google-Smtp-Source: APXvYqxzEKHqYLvOz6ocgRZV/yBrEgZwTzHO/SThXrAwIWesyUZ7QW/8ODhmMGoBBcGt9g/nkZafbA==
X-Received: by 2002:a1c:7d4e:: with SMTP id y75mr3784875wmc.169.1562079685626; 
 Tue, 02 Jul 2019 08:01:25 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id m24sm3006262wmi.39.2019.07.02.08.01.24
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 02 Jul 2019 08:01:24 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue,  2 Jul 2019 17:01:16 +0200
Message-Id: <1562079681-19204-3-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1562079681-19204-1-git-send-email-pbonzini@redhat.com>
References: <1562079681-19204-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: [Qemu-devel] [PATCH 2/7] target/i386: introduce generic feature
 dependency mechanism
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

Sometimes a CPU feature does not make sense unless another is
present.  In the case of VMX features, KVM does not even allow
setting the VMX controls to some invalid combinations.

Therefore, this patch adds a generic mechanism that looks for bits
that the user explicitly cleared, and uses them to remove other bits
from the expanded CPU definition.  If these dependent bits were also
explicitly *set* by the user, this will be a warning for "-cpu check"
and an error for "-cpu enforce".  If not, then the dependent bits are
cleared silently, for convenience.

With VMX features, this will be used so that for example
"-cpu host,-rdrand" will also hide support for RDRAND exiting.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 77 +++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 49 insertions(+), 28 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 9149d0d..412e834 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -799,10 +799,6 @@ typedef struct FeatureWordInfo {
         /* If type==MSR_FEATURE_WORD */
         struct {
             uint32_t index;
-            struct {   /*CPUID that enumerate this MSR*/
-                FeatureWord cpuid_class;
-                uint32_t    cpuid_flag;
-            } cpuid_dep;
         } msr;
     };
     uint32_t tcg_features; /* Feature flags supported by TCG */
@@ -1197,10 +1193,6 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         },
         .msr = {
             .index = MSR_IA32_ARCH_CAPABILITIES,
-            .cpuid_dep = {
-                FEAT_7_0_EDX,
-                CPUID_7_0_EDX_ARCH_CAPABILITIES
-            }
         },
     },
     [FEAT_CORE_CAPABILITY] = {
@@ -1217,14 +1209,26 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         },
         .msr = {
             .index = MSR_IA32_CORE_CAPABILITY,
-            .cpuid_dep = {
-                FEAT_7_0_EDX,
-                CPUID_7_0_EDX_CORE_CAPABILITY,
-            },
         },
     },
 };
 
+typedef struct FeatureDep {
+    uint16_t from, to;
+    uint64_t from_flag, to_flags;
+} FeatureDep;
+
+static FeatureDep feature_dependencies[] = {
+    {
+        .from = FEAT_7_0_EDX,            .from_flag = CPUID_7_0_EDX_ARCH_CAPABILITIES,
+        .to = FEAT_ARCH_CAPABILITIES,    .to_flags = ~0ull,
+    },
+    {
+        .from = FEAT_7_0_EDX,            .from_flag = CPUID_7_0_EDX_CORE_CAPABILITY,
+        .to = FEAT_CORE_CAPABILITY,      .to_flags = ~0ull,
+    },
+};
+
 typedef struct X86RegisterInfo32 {
     /* Name of register */
     const char *name;
@@ -5086,9 +5090,42 @@ static void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
 {
     CPUX86State *env = &cpu->env;
     FeatureWord w;
+    int i;
     GList *l;
     Error *local_err = NULL;
 
+    for (l = plus_features; l; l = l->next) {
+        const char *prop = l->data;
+        object_property_set_bool(OBJECT(cpu), true, prop, &local_err);
+        if (local_err) {
+            goto out;
+        }
+    }
+
+    for (l = minus_features; l; l = l->next) {
+        const char *prop = l->data;
+        object_property_set_bool(OBJECT(cpu), false, prop, &local_err);
+        if (local_err) {
+            goto out;
+        }
+    }
+
+    for (i = 0; i < ARRAY_SIZE(feature_dependencies); i++) {
+        FeatureDep *d = &feature_dependencies[i];
+        if ((env->user_features[d->from] & d->from_flag) &&
+            !(env->features[d->from] & d->from_flag)) {
+            uint64_t unavailable_features = env->features[d->to] & d->to_flags;
+
+            /* Not an error unless the dependent feature was added explicitly.  */
+            mark_unavailable_features(cpu, d->to, unavailable_features & env->user_features[d->to],
+                                      "This feature depends on other features that were not requested");
+
+            /* Prevent adding the feature in the loop below.  */
+            env->user_features[d->to] |= d->to_flags;
+            env->features[d->to] &= ~d->to_flags;
+        }
+    }
+
     /*TODO: Now cpu->max_features doesn't overwrite features
      * set using QOM properties, and we can convert
      * plus_features & minus_features to global properties
@@ -5106,22 +5143,6 @@ static void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
         }
     }
 
-    for (l = plus_features; l; l = l->next) {
-        const char *prop = l->data;
-        object_property_set_bool(OBJECT(cpu), true, prop, &local_err);
-        if (local_err) {
-            goto out;
-        }
-    }
-
-    for (l = minus_features; l; l = l->next) {
-        const char *prop = l->data;
-        object_property_set_bool(OBJECT(cpu), false, prop, &local_err);
-        if (local_err) {
-            goto out;
-        }
-    }
-
     if (!kvm_enabled() || !cpu->expose_kvm) {
         env->features[FEAT_KVM] = 0;
     }
-- 
1.8.3.1



