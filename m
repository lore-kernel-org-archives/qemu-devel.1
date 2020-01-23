Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5258BC33CAF
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 15:48:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22A0021734
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 15:48:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VSmqLjEf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22A0021734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iueiY-0005WQ-GN
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 10:48:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51422)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iucrP-000510-7v
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:49:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iucrO-0003NI-2e
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:49:27 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:33976)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iucrN-0003Li-Sq
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:49:26 -0500
Received: by mail-wr1-x42c.google.com with SMTP id t2so3184863wrr.1
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 05:49:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references;
 bh=UMWrztDn+2LOmfXo42GQL/DUYv1hMbW6To+XMh241c8=;
 b=VSmqLjEfDORaSkkfqKJkOzc4jyped5SjgrwHODGjHHEBG/x9lAr76n1QWUR0qykeIa
 AR9o7H8pg7YAl40FtkbWGnDQZqIFKzPoVnq8lhcFUDoJxnR7gB1r5hmGrmivfQ33Re5r
 tscxSwOGICaQeLIHIOQ664HdXN7EL/CAKXzfhWetpTjhXLDmUzGTUp64AHjLwGi9G9PJ
 v0JODmi4LsJvn4HA5Xm33uqWBDr0CeMOjIY2gtk1NUMaiOciJXYYcYZg83tlyx9cEJfL
 e31HhHi791/xZzPOTXzUx8N+cZNNkE9QSTNG/O94aXRoeWLeCQsarZOSc5rH4rx+j6cf
 gUPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references;
 bh=UMWrztDn+2LOmfXo42GQL/DUYv1hMbW6To+XMh241c8=;
 b=P/yaCbNHsWmbDPqu6tZrzpHgkS78ebtnnkSdiv0rkbS2hYCb6qKAw6pSmNZlau1TjW
 KGSObF74BWu0Q6CS75ZbaBRO/e4U1CGTJnMZYKXwRETh3vjZopDL42vG2bkvd78Z4ob+
 uTKIDXQLn6BoPICcaDvjoOuOmVJPipqpRnKHB2tH5VBRGrAvDDy84R1IP5Ckf/Sk4k6T
 dSdhBzaVNuAVWprQ+Z2D5Kb7nFE7gCTsehDlryDBv1XKYEopbR9t5Vi5Vn2lhod2lsxT
 cVSW2T5ugRrSRi+OaNvNK9JS4kXz9URYBTplyuMQXxzVYBivElGTqI2z6D17M3OqHH8h
 U/BQ==
X-Gm-Message-State: APjAAAXWdQKq2tYN8yCnKo9HjJwmmvNhfPZH9OjoQcYMy16wWrJrk5Jt
 OI4OWpySZOIvMVmz03bYphhCvxp/
X-Google-Smtp-Source: APXvYqw3pudCNWgLIwx8kvTUfuoebXNC0GGHmXmGVuqkx20fLotv3YMtHr386pTSqYKMd78PXRGMOQ==
X-Received: by 2002:a5d:6305:: with SMTP id i5mr18053571wru.399.1579787364676; 
 Thu, 23 Jan 2020 05:49:24 -0800 (PST)
Received: from 640k.localdomain.com ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id s15sm3073171wrp.4.2020.01.23.05.49.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 23 Jan 2020 05:49:24 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 20/59] target/i386: kvm: initialize microcode revision from KVM
Date: Thu, 23 Jan 2020 14:48:23 +0100
Message-Id: <1579787342-27146-21-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1579787342-27146-1-git-send-email-pbonzini@redhat.com>
References: <1579787342-27146-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42c
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

KVM can return the host microcode revision as a feature MSR.
Use it as the default value for -cpu host.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <1579544504-3616-4-git-send-email-pbonzini@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 4 ++++
 target/i386/kvm.c | 5 +++++
 2 files changed, 9 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 790254e..ffe5de0 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6416,6 +6416,10 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
                        &cpu->mwait.ecx, &cpu->mwait.edx);
             env->features[FEAT_1_ECX] |= CPUID_EXT_MONITOR;
         }
+        if (kvm_enabled() && cpu->ucode_rev == 0) {
+            cpu->ucode_rev = kvm_arch_get_supported_msr_feature(kvm_state,
+                                                                MSR_IA32_UCODE_REV);
+        }
     }
 
     if (cpu->ucode_rev == 0) {
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index f6dd6b7..1b67090 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -2696,6 +2696,11 @@ static void kvm_init_msrs(X86CPU *cpu)
                           env->features[FEAT_CORE_CAPABILITY]);
     }
 
+    if (kvm_arch_get_supported_msr_feature(kvm_state,
+                                           MSR_IA32_UCODE_REV)) {
+        kvm_msr_entry_add(cpu, MSR_IA32_UCODE_REV, cpu->ucode_rev);
+    }
+
     /*
      * Older kernels do not include VMX MSRs in KVM_GET_MSR_INDEX_LIST, but
      * all kernels with MSR features should have them.
-- 
1.8.3.1



