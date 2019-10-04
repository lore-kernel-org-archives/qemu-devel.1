Return-Path: <SRS0=aoXf=X5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A332C4360C
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 17:07:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2ACE20862
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 17:07:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jk1oh+XI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2ACE20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGR3T-0003NY-VF
	for qemu-devel@archiver.kernel.org; Fri, 04 Oct 2019 13:07:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51083)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iGQvU-0007Mh-3B
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 12:59:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iGQvS-0001tg-S0
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 12:59:31 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:36369)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iGQvS-0001tG-M4
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 12:59:30 -0400
Received: by mail-wr1-x430.google.com with SMTP id y19so8098544wrd.3
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2019 09:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references;
 bh=qws3AYzCutn9xQ5O+LYFZoPZNCpiVmvp4O0IhNmQG3Y=;
 b=jk1oh+XIQ3vWNX+vthQbuG2uuOF6nzv7bA2OKv4OQXfzWmNHQlVQquTKTurvEhCWKS
 Z4jd68HmxmVz94frarP0ur+6rXNRZLPMBw6gUbe9h9+OG4RyjRS0DQco0tofJQsQfBq+
 AWPN5pOZ5oUIjxOZxw4nrUPCJdB1esQiNC2ksmJopk89POtC9nGug+68iDvsArUh4oCq
 uM8VIvejCuME2Q64lmqVKb0Oh0isrsI4FS9J17I9a2x1UnwmGv99IEc2XaBNZ3e9lERU
 wOpoEbZi+uG8CdSi8NlnRjfQvcV3ifTL0/WaiDISEWtzxZLl/Yz0YOixjXGuWvLoTiBC
 6pZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references;
 bh=qws3AYzCutn9xQ5O+LYFZoPZNCpiVmvp4O0IhNmQG3Y=;
 b=gZCsQR+k98huJsyCQkQahoMbRIlA9gvfg5YWXznjEhuCHTOq0+AI5FWKNot2l5316d
 /Ku0lwtxLIeemM5y8yMMetRrTxr92gXtP/HYPkoRIHqZm3ep8VDBose0xbTK4AN+gVJS
 SrzW4yY+sMq8fHTxLyURaEvuggmkTOlsOifryRanQXsFqOiQGiq2/GrZrbrobCWb6xwx
 xU4eUkhOpA4aFPnbGiR2y7HakNZqTooW3tulfNUmQV8KfJEOBbsv0zu2sJh4AeRwXFlB
 OFzTCI9PW1a8sV3ReDn1Njl296KM8vkajy+6SlAdeIygn8bdsP/dVaGbbJ/a0QJcnf2n
 MG4A==
X-Gm-Message-State: APjAAAUdICNAh0i6+V56ggR4p/w4Dp9Lnp9arn/58tbp1BvmXmPWABCV
 Xx8PVsVmkVRrernXOF6VVIrGLP9b
X-Google-Smtp-Source: APXvYqyPrOc2LfmuUk76U/dkURDUt5+zmPxh5z8TZVN4pV5ubZ/zMTFqG7OxFcAF+aYWN/N8370n7A==
X-Received: by 2002:a5d:4c45:: with SMTP id n5mr13329839wrt.100.1570208369009; 
 Fri, 04 Oct 2019 09:59:29 -0700 (PDT)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id u7sm7041270wrp.19.2019.10.04.09.59.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 04 Oct 2019 09:59:27 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 23/29] target/i386: introduce generic feature dependency
 mechanism
Date: Fri,  4 Oct 2019 18:59:17 +0200
Message-Id: <1570208363-11948-3-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1570208363-11948-1-git-send-email-pbonzini@redhat.com>
References: <1570208363-11948-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::430
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
 target/i386/cpu.c | 72 ++++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 48 insertions(+), 24 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 83f8981..35d868d 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -801,10 +801,6 @@ typedef struct FeatureWordInfo {
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
@@ -1218,10 +1214,6 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
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
@@ -1238,14 +1230,30 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
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
 
+typedef struct FeatureMask {
+    FeatureWord index;
+    uint32_t mask;
+} FeatureMask;
+
+typedef struct FeatureDep {
+    FeatureMask from, to;
+} FeatureDep;
+
+static FeatureDep feature_dependencies[] = {
+    {
+        .from = { FEAT_7_0_EDX,             CPUID_7_0_EDX_ARCH_CAPABILITIES },
+        .to = { FEAT_ARCH_CAPABILITIES,     ~0u },
+    },
+    {
+        .from = { FEAT_7_0_EDX,             CPUID_7_0_EDX_CORE_CAPABILITY },
+        .to = { FEAT_CORE_CAPABILITY,       ~0u },
+    },
+};
+
 typedef struct X86RegisterInfo32 {
     /* Name of register */
     const char *name;
@@ -5063,9 +5071,26 @@ static void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
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
     /*TODO: Now cpu->max_features doesn't overwrite features
      * set using QOM properties, and we can convert
      * plus_features & minus_features to global properties
@@ -5083,19 +5108,18 @@ static void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
         }
     }
 
-    for (l = plus_features; l; l = l->next) {
-        const char *prop = l->data;
-        object_property_set_bool(OBJECT(cpu), true, prop, &local_err);
-        if (local_err) {
-            goto out;
-        }
-    }
+    for (i = 0; i < ARRAY_SIZE(feature_dependencies); i++) {
+        FeatureDep *d = &feature_dependencies[i];
+        if (!(env->features[d->from.index] & d->from.mask)) {
+            uint32_t unavailable_features = env->features[d->to.index] & d->to.mask;
 
-    for (l = minus_features; l; l = l->next) {
-        const char *prop = l->data;
-        object_property_set_bool(OBJECT(cpu), false, prop, &local_err);
-        if (local_err) {
-            goto out;
+            /* Not an error unless the dependent feature was added explicitly.  */
+            mark_unavailable_features(cpu, d->to.index,
+                                      unavailable_features & env->user_features[d->to.index],
+                                      "This feature depends on other features that were not requested");
+
+            env->user_features[d->to.index] |= unavailable_features;
+            env->features[d->to.index] &= ~unavailable_features;
         }
     }
 
-- 
1.8.3.1



