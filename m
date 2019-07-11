Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB405C74A35
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 13:46:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6F9321019
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 13:46:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6F9321019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlZP8-0002dC-PL
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 09:46:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48182)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hlZNs-0008Pp-L2
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 09:45:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hlZNr-0001zl-Kv
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 09:45:16 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38459)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hlZNr-0001yv-DV
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 09:45:15 -0400
Received: by mail-wr1-f65.google.com with SMTP id g17so6378783wrr.5
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2019 06:45:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=tNB+Cdder5uir4F/Y1o1Nv0qZI/Q9BfOtg7q5GBmh1s=;
 b=XYiaVZsdY1ReO5SyVt/9CddTSXOGIXNf2F/kc4Dy6wFssGZDsIsEl+APzivBTH63Sc
 6PS+/NBfIyN9Jk9/y3kusBZsXUVv0Y6tI9twsR/HqSfBJYZagrHk0lW2zq8f0sdEC1n1
 AEsbFzi91HdW9i9hnd5AgZJeNO3CGcCqQ/6F0bAz+KwwvIn7OB8x6lX77yl5pa9PYGjZ
 ti+VfMcyQmFNgFb5alYPfA+nii6WQIp7Qa7sNfDPpYyzTRl3zwgHUmZlXnLt0lr2zdUs
 3UveZzpVyeppXU8Z5d+Adia1T1sWh8eWo/a7QcEzLr48ApgaxyBc0Y/u4llG9e+n07NG
 2EVw==
X-Gm-Message-State: APjAAAWR+iOTCTvD4gFCP3rxm0wg/fgT7I0WLUzQJ0xbPgkgRIoXGYi2
 t3sg0UtE5zlJffOPDS0niTSWrA==
X-Google-Smtp-Source: APXvYqzFyb+Jy/hSvo8JhEg2qgu6yKRmj3xzahjZ/U2b9GBadqIjUPYWPxzHnqcBuew+Nte86S5XzA==
X-Received: by 2002:a5d:55c2:: with SMTP id i2mr5297276wrw.96.1562852714320;
 Thu, 11 Jul 2019 06:45:14 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:d066:6881:ec69:75ab?
 ([2001:b07:6468:f312:d066:6881:ec69:75ab])
 by smtp.gmail.com with ESMTPSA id y18sm5636707wmi.23.2019.07.11.06.45.13
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Thu, 11 Jul 2019 06:45:13 -0700 (PDT)
To: Liran Alon <liran.alon@oracle.com>, qemu-devel@nongnu.org
References: <20190705210636.3095-1-liran.alon@oracle.com>
 <20190705210636.3095-2-liran.alon@oracle.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <805d7eb5-e171-60bb-94c2-574180f5c44c@redhat.com>
Date: Thu, 11 Jul 2019 15:45:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190705210636.3095-2-liran.alon@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [PATCH 1/4] target/i386: kvm: Init nested-state
 for VMX when vCPU expose VMX
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
Cc: Joao Martins <joao.m.martins@oracle.com>, ehabkost@redhat.com,
 kvm@vger.kernel.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 05/07/19 23:06, Liran Alon wrote:
> -        if (IS_INTEL_CPU(env)) {
> +        if (cpu_has_vmx(env)) {
>              struct kvm_vmx_nested_state_hdr *vmx_hdr =
>                  &env->nested_state->hdr.vmx;
>  

I am not sure this is enough, because kvm_get_nested_state and kvm_put_nested_state would run anyway later.  If we want to cull them completely for a non-VMX virtual machine, I'd do something like this:

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
 

What do you think?  (As a side effect, this completely disables
KVM_GET/SET_NESTED_STATE on SVM, which I think is safer since it
will have to save at least the NPT root and the paging mode.  So we
could remove vmstate_svm_nested_state as well).

Paolo

