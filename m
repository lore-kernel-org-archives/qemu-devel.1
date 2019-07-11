Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 679EBC74A5B
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 17:27:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3521D20863
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 17:27:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nSnmul48"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3521D20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlcqW-0000mM-Cg
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 13:27:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33036)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hlcqM-0000MU-E1
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 13:26:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hlcqL-0007wM-An
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 13:26:54 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:38614)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1hlcqL-0007v1-4e
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 13:26:53 -0400
Received: by mail-wm1-x343.google.com with SMTP id s15so6458533wmj.3
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2019 10:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id;
 bh=iUgof65FlBg0LXx+uLyqSdziWBu7F3VhET5Hbgi+8Ac=;
 b=nSnmul48Fsa+bnPIajSKakOIIRERqIcXICBJrNOidlOdb9JtgvR3sWzRbaOin1J7Rw
 dN4O/vaXuTn46LPy4CpJN9NBCHddyZUTFGI9MrdK0cGhBDhpxa0tJrqgF65D9uwmsOSE
 5v/Blh83dnjHwuHIxGaT9dpGQGXQHk4whTrlJ/+xPF9iR9KoZMZCoPL+prpQcWoBTw54
 CuYHA7yGY6g7DpNa0ici10G7qsGiSlHSZcQAXG2lqvKtxnTt7hV8UhHosisbhuKbA+Sj
 B4ajztMrP8zYcnkknl3o/w09+2vzXu/v8NVWEm4uqIHiYTSrlQq4aqrFzzVFhccd8Z8P
 /DKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id;
 bh=iUgof65FlBg0LXx+uLyqSdziWBu7F3VhET5Hbgi+8Ac=;
 b=fMJ50tvNa6a8TXLiqPr9ZX1G1m1U8LxzUSdT/LwX6digFO4Dbs4C1K+u+/87gpIGK2
 0qiJN/UogIBuu9LbDaX+uQyiWdcZTXBA0v/Itrj1sCvkNisV15n4DWUunQIUM9tdI1qE
 vvzTSDiXsqzjNsyNuBkZZ17risQsyKaGdmy49s6NhP7rvGwxt18NbmpuuzoMLDiYvLtS
 buEOjdcGUihDuTt7Y0rR0F1GD4fiTxRh7YqrsN6U1660FvzBA2fURy/XXifSWk3nBHil
 oTbpHRRiJ3wZ/v1hHfQ3NeM8nEXGCCRnqzFwQMLtQ3j9q9Y6Fk7rW7IVTGVSF5It4TwF
 RVxQ==
X-Gm-Message-State: APjAAAXA58tbDZeH3e6Fcvhkh+yWKoG9zA1yfxEsSjct6VkX9K7YmKcm
 6ObLovpqFiNeyOwPkjdzvTokUSJ6Twk=
X-Google-Smtp-Source: APXvYqySaaMIc18XW+avIJRv2JwmlqD0GzcldyRxJyr+lgqQeF04nDKYUwiMW63fbm5cFZlQMNCgAw==
X-Received: by 2002:a1c:f914:: with SMTP id x20mr5344997wmh.142.1562866011732; 
 Thu, 11 Jul 2019 10:26:51 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id a64sm9701910wmf.1.2019.07.11.10.26.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 11 Jul 2019 10:26:51 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 11 Jul 2019 19:26:50 +0200
Message-Id: <1562866010-5355-1-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: [Qemu-devel] [PATCH] target/i386: skip KVM_GET/SET_NESTED_STATE if
 VMX disabled, or for SVM
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
 target/i386/kvm.c     | 11 +++++------
 target/i386/machine.c | 21 +--------------------
 2 files changed, 6 insertions(+), 26 deletions(-)

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 5035092..73ab102 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -1748,14 +1748,13 @@ int kvm_arch_init_vcpu(CPUState *cs)
     max_nested_state_len = kvm_max_nested_state_length();
     if (max_nested_state_len > 0) {
         assert(max_nested_state_len >= offsetof(struct kvm_nested_state, data));
-        env->nested_state = g_malloc0(max_nested_state_len);
 
-        env->nested_state->size = max_nested_state_len;
-
-        if (IS_INTEL_CPU(env)) {
+        if (cpu_has_vmx(env)) {
             struct kvm_vmx_nested_state_hdr *vmx_hdr =
                 &env->nested_state->hdr.vmx;
 
+            env->nested_state = g_malloc0(max_nested_state_len);
+            env->nested_state->size = max_nested_state_len;
             env->nested_state->format = KVM_STATE_NESTED_FORMAT_VMX;
             vmx_hdr->vmxon_pa = -1ull;
             vmx_hdr->vmcs12_pa = -1ull;
@@ -3682,7 +3681,7 @@ static int kvm_put_nested_state(X86CPU *cpu)
     CPUX86State *env = &cpu->env;
     int max_nested_state_len = kvm_max_nested_state_length();
 
-    if (max_nested_state_len <= 0) {
+    if (!env->nested_state) {
         return 0;
     }
 
@@ -3696,7 +3695,7 @@ static int kvm_get_nested_state(X86CPU *cpu)
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


