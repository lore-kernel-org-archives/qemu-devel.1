Return-Path: <SRS0=lwXe=VR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B73EC76195
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2019 15:20:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B5B0217F5
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2019 15:20:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b3uMLfT5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B5B0217F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hor9Y-0001nD-H1
	for qemu-devel@archiver.kernel.org; Sat, 20 Jul 2019 11:20:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39798)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hor8Q-0005n2-IB
 for qemu-devel@nongnu.org; Sat, 20 Jul 2019 11:18:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hor8P-00084y-4Z
 for qemu-devel@nongnu.org; Sat, 20 Jul 2019 11:18:54 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:36376)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1hor8O-00084W-UP
 for qemu-devel@nongnu.org; Sat, 20 Jul 2019 11:18:53 -0400
Received: by mail-wm1-x329.google.com with SMTP id g67so27401685wme.1
 for <qemu-devel@nongnu.org>; Sat, 20 Jul 2019 08:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Arm9ZHazdpD84Li58k4dV1gofBpEGq70Z3WCUo90whY=;
 b=b3uMLfT5BbE9Ky2kA4f993N5IyqstzcRm5aTa3ilU2F0anVRGJCbKxRYTWa9VtXq1z
 Kw8/acwP2O5mFWyuc16F1T3IEVgQ3H48ViJe/sb91xg+Wtz3yo+Ln00gAw/UTsS4zUOS
 d7XWEbM/+PYq8rdin3UCkjgxSKbQh0Elc/gM9SVDX9cXxPZMztAq6VFRDilvg/lbYFyL
 P7LtHXA7AUprXBP/Be8JnnMjnUzPBhePgZnwBEe1/Ywy/iGyQAw2m4XjnkPQXIcmcxSX
 ElkaE8RuI/BlGonIQlpuvlRIrYXm5D6MHfBw7OqioYxDtmjInP7ctHCO5bPA/8DbEwfO
 CBvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=Arm9ZHazdpD84Li58k4dV1gofBpEGq70Z3WCUo90whY=;
 b=n39b5ze9I8+ygdXB2p6urJWFdTT/VHhO/zQPGB+TE6aUwcFfL+cKvMnT4QTuLVSB8x
 cwQa8wrRysm5WZoalyBDw2XQ1QZJVfJqQWxodbzY74Udx0vxu9UzoNW1C2OTKwz/CK54
 V5DDuqdJ3RYO2RlFvF/BS2AHzqo+hVp7StM306QYsIiP7qTXKKKF+MgM9LJlBUrW3ZwS
 daTMdvSo5H2s9ar+rD53/tRr3XuNb2UHRjW2USeDiDcZcT5vZxXStJBpCYSaVurG/HcP
 0hpjT5qDDuDRCqCloWBoZIHjB/KNswRit/cCPr8OXChoTAvj1x6k76LedFwRnuofiAPF
 HUVA==
X-Gm-Message-State: APjAAAU4OR71fasDX4PQTnfTG/i4mt3WwvbWNj8uxtJk3P1wlPL0+WFJ
 IPOuFlLkoHI1RbO1kI3+excAanq4oSA=
X-Google-Smtp-Source: APXvYqyLEuoTihZrzSCOGFXsIdar8OD2sXowEbZ1dQqj/Fs7FC65BmRrmq1MBGWkuh1+1BSRawe9yg==
X-Received: by 2002:a1c:3:: with SMTP id 3mr54334214wma.6.1563635931703;
 Sat, 20 Jul 2019 08:18:51 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:6468:f312:8501:6b03:f18c:74f8])
 by smtp.gmail.com with ESMTPSA id 4sm77517291wro.78.2019.07.20.08.18.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Sat, 20 Jul 2019 08:18:50 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Sat, 20 Jul 2019 17:18:36 +0200
Message-Id: <20190720151846.7450-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190720151846.7450-1-pbonzini@redhat.com>
References: <20190720151846.7450-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::329
Subject: [Qemu-devel] [PULL 02/12] target/i386: skip
 KVM_GET/SET_NESTED_STATE if VMX disabled, or for SVM
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

Do not allocate env->nested_state unless we later need to migrate the
nested virtualization state.

With this change, nested_state_needed() will return false if the
VMX flag is not included in the virtual machine.  KVM_GET/SET_NESTED_STATE
is also disabled for SVM which is safer (we know that at least the NPT
root and paging mode have to be saved/loaded), and thus the corresponding
subsection can go away as well.

Inspired by a patch from Liran Alon.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm.c     | 16 ++++++++--------
 target/i386/machine.c | 21 +--------------------
 2 files changed, 9 insertions(+), 28 deletions(-)

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 4542f0f..ada89d2 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -1711,15 +1711,15 @@ int kvm_arch_init_vcpu(CPUState *cs)
     max_nested_state_len = kvm_max_nested_state_length();
     if (max_nested_state_len > 0) {
         assert(max_nested_state_len >= offsetof(struct kvm_nested_state, data));
-        env->nested_state = g_malloc0(max_nested_state_len);
 
-        env->nested_state->size = max_nested_state_len;
-
-        if (IS_INTEL_CPU(env)) {
-            struct kvm_vmx_nested_state_hdr *vmx_hdr =
-                &env->nested_state->hdr.vmx;
+        if (cpu_has_vmx(env)) {
+            struct kvm_vmx_nested_state_hdr *vmx_hdr;
 
+            env->nested_state = g_malloc0(max_nested_state_len);
+            env->nested_state->size = max_nested_state_len;
             env->nested_state->format = KVM_STATE_NESTED_FORMAT_VMX;
+
+            vmx_hdr = &env->nested_state->hdr.vmx;
             vmx_hdr->vmxon_pa = -1ull;
             vmx_hdr->vmcs12_pa = -1ull;
         }
@@ -3515,7 +3515,7 @@ static int kvm_put_nested_state(X86CPU *cpu)
     CPUX86State *env = &cpu->env;
     int max_nested_state_len = kvm_max_nested_state_length();
 
-    if (max_nested_state_len <= 0) {
+    if (!env->nested_state) {
         return 0;
     }
 
@@ -3529,7 +3529,7 @@ static int kvm_get_nested_state(X86CPU *cpu)
     int max_nested_state_len = kvm_max_nested_state_length();
     int ret;
 
-    if (max_nested_state_len <= 0) {
+    if (!env->nested_state) {
         return 0;
     }
 
diff --git a/target/i386/machine.c b/target/i386/machine.c
index ac2d1d1..b114609 100644
--- a/target/i386/machine.c
+++ b/target/i386/machine.c
@@ -1035,31 +1035,13 @@ static const VMStateDescription vmstate_vmx_nested_state = {
     }
 };
 
-static bool svm_nested_state_needed(void *opaque)
-{
-    struct kvm_nested_state *nested_state = opaque;
-
-    return (nested_state->format == KVM_STATE_NESTED_FORMAT_SVM);
-}
-
-static const VMStateDescription vmstate_svm_nested_state = {
-    .name = "cpu/kvm_nested_state/svm",
-    .version_id = 1,
-    .minimum_version_id = 1,
-    .needed = svm_nested_state_needed,
-    .fields = (VMStateField[]) {
-        VMSTATE_END_OF_LIST()
-    }
-};
-
 static bool nested_state_needed(void *opaque)
 {
     X86CPU *cpu = opaque;
     CPUX86State *env = &cpu->env;
 
     return (env->nested_state &&
-            (vmx_nested_state_needed(env->nested_state) ||
-             svm_nested_state_needed(env->nested_state)));
+            vmx_nested_state_needed(env->nested_state));
 }
 
 static int nested_state_post_load(void *opaque, int version_id)
@@ -1121,7 +1103,6 @@ static const VMStateDescription vmstate_kvm_nested_state = {
     },
     .subsections = (const VMStateDescription*[]) {
         &vmstate_vmx_nested_state,
-        &vmstate_svm_nested_state,
         NULL
     }
 };
-- 
1.8.3.1



