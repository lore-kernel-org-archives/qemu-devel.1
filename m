Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E4F2C35280
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 16:54:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B41921920
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 16:54:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bmEcAfJz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B41921920
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57704 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFhtH-00075D-HS
	for qemu-devel@archiver.kernel.org; Wed, 02 Oct 2019 12:54:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35247)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iFhr7-000589-Uy
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 12:52:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iFhr6-000381-Km
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 12:52:01 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:45124)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iFhr6-00036d-Dp
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 12:52:00 -0400
Received: by mail-wr1-x42a.google.com with SMTP id r5so20435427wrm.12
 for <qemu-devel@nongnu.org>; Wed, 02 Oct 2019 09:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references;
 bh=FRGhgVOwY1ofv0mbUj5TGM+MvOHQ8R0yf6r9ZTR8PxU=;
 b=bmEcAfJzeVrwNwFo/XXQ3OrjlfYwokwHJh2/2MYt/DMGSflqmlErfBlU8wzzV1wJfA
 Gmn1OqmBxcCIdfkWuJBpE9n/MaAjzMi/EB9QDEWWI2H7Szv/7L2dmIqAh1lGdwbL5KCt
 viogsex/dltfzdHAAGdO3A/6p23g+H8ex0lITuxzFaQYGOuf4Cjgo1twYI0rFK4EPD0c
 DhFl3+b44aSgdiH4nQF3AJiIW3/r3gNK+qESv30sMgEob/PgD/WRZYAl5HyWuuWcx/Vv
 rUcdEMKffg9+j6TU9BI28VGGa87raeLvOkk7VplPhccMFbPRmKR4+PFCoBSwpbmaBbI6
 1q2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references;
 bh=FRGhgVOwY1ofv0mbUj5TGM+MvOHQ8R0yf6r9ZTR8PxU=;
 b=XvFezrfj92albiJdiMDz1T9dKP4JCUxSpm00rkb0eCD1G9EbRAd5s6ZohqwHlkfLcW
 13DThDUrA6zW1MQC181QuB5aAipODA7qqSAeWKC4G2ZUTnbPX1OnCDj8rZIVRjyxtiHM
 rmc9iiHL2Z2J+utzUuu/LjtFYiWAcdMySZmDwEfWOrpglyc/FWnsQa4bhDjCdU/Z3ise
 hptOOPdKMV6wru4hWRL9q1qSTQs6+47JYCgCjkfnbDTt5WnnTjs13lH+se4G3pDCw/ID
 bsgnQ1yGGUZfRlTUV4l/i3lzQEEphRoPtW1WTOdyEe5JrKhdX2JIR6JTOuYshvMOlChl
 MOMg==
X-Gm-Message-State: APjAAAXxDUJuFeJ3Kax85NX0JayzyUCcSYJlRqhFqh376SzQVf/SHbZA
 1B8LV1N0wJFyA4SHWffHVr11vhZk
X-Google-Smtp-Source: APXvYqzS3B6OGtc0XwNxDX7xlzitbwjNQT/woso/SxTwdvhQjcjYavgZgAAiLGvIkGSuSGl3+NI4Nw==
X-Received: by 2002:adf:9d87:: with SMTP id p7mr3339613wre.245.1570035118350; 
 Wed, 02 Oct 2019 09:51:58 -0700 (PDT)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id g4sm27303990wrw.9.2019.10.02.09.51.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 02 Oct 2019 09:51:57 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 03/30] target/i386: introduce generic feature dependency
 mechanism
Date: Wed,  2 Oct 2019 18:51:26 +0200
Message-Id: <1570035113-56848-4-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1570035113-56848-1-git-send-email-pbonzini@redhat.com>
References: <1570035113-56848-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42a
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
index 52b3f3e..fae458c 100644
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



