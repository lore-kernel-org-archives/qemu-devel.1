Return-Path: <SRS0=2JTU=UU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E952BC43613
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 02:15:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B786320675
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 02:15:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W073YwQ3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B786320675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54184 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1he95D-0004Ko-W9
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 22:15:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41286)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <paolo.bonzini@gmail.com>) id 1he8a6-0006f0-GQ
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 21:43:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1he8a3-0006fV-JY
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 21:43:10 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:45211)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1he8a2-0006Ix-SR
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 21:43:07 -0400
Received: by mail-wr1-x442.google.com with SMTP id f9so4835964wre.12
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2019 18:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=rRyKyx29XW5YjtibDxKmJQDBBERS19STiC5lOwnEoTA=;
 b=W073YwQ3zWFFCFrtq23gIdHcBk0rkE6/cVfxqBC5oxlc2yLnr7T1tMU9nXw7GK7U4M
 /XVTCNzbrd+7Pq76eoitdr/0ERiJr09i4V1od1Lc0IVAvc35jl3fiajq9/9/FzbR+dfU
 mpDZhdPM8d7wC9SVLoMe5nIiVKTJLcR7JHgmAdYT6szXYvVive/Ba2zjGl7xiqCy6qYu
 dlur63JwRMRwD+fqQLrq2Pm/cfDaxwVjwuoT76nUB+q8gJ9mmXvK8OcMMrlUG2+g0OtW
 q4agdzNH8TtES+AHCcuk6W8xvAu64NNFbAmOYgvF9PkA1+raVAtkiiRwt/+yd9r9PsT3
 Tarw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=rRyKyx29XW5YjtibDxKmJQDBBERS19STiC5lOwnEoTA=;
 b=l9bDvhO5mabU8UBn0JDISgqcj45nsh5ASyaO07df8cXtqxLoZeaDkC0nEFHesP5rhF
 W6KDyWkA7JZYOlekPHFmGhqYGyMKzlBxFRh2NXtGeGDdJdn7Jysika/7MqKtcl+tterR
 gjQ2yX3M02pNUZop0T7e8bP5PmlAxwM/U+sgycXKgdzCg4nb9WBMdrEk4p5XY3mEu12/
 hwAFasw74L+WlB6AvUZucINHU1R2ItHL3emwipn9gtCJ32c9iCDZu/C1y4BZ1LBBxJxr
 fMHP6QN/PiK/Hp0gWJXg7mTTJVd++VBQuyrGOyDE50pjLOokLU9y+WHN4ijpokHUJzWF
 4U+Q==
X-Gm-Message-State: APjAAAXNhtM8fmU/Chm3xo16z/1xaRreb2v/eQycXHeZQDnZcJiPPcmn
 2Cq8MHj2bBjWb31dFALigwbsyy3Z
X-Google-Smtp-Source: APXvYqzgtimzlaBsjiVnxXxqwtOSh1Qi3lDDH49el2FQTWy6989CDpzZsyX7CK99kWVIdL9rFCDgBg==
X-Received: by 2002:adf:f544:: with SMTP id j4mr22541344wrp.150.1561081364292; 
 Thu, 20 Jun 2019 18:42:44 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id d1sm1123125wru.41.2019.06.20.18.42.43
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 20 Jun 2019 18:42:43 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 21 Jun 2019 03:42:16 +0200
Message-Id: <1561081350-3723-12-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1561081350-3723-1-git-send-email-pbonzini@redhat.com>
References: <1561081350-3723-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [PULL 11/25] i386/kvm: add support for Direct Mode for
 Hyper-V synthetic timers
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
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vitaly Kuznetsov <vkuznets@redhat.com>

Hyper-V on KVM can only use Synthetic timers with Direct Mode (opting for
an interrupt instead of VMBus message). This new capability is only
announced in KVM_GET_SUPPORTED_HV_CPUID.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Message-Id: <20190517141924.19024-10-vkuznets@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/hyperv.txt            | 10 ++++++++++
 target/i386/cpu.c          |  2 ++
 target/i386/cpu.h          |  1 +
 target/i386/hyperv-proto.h |  1 +
 target/i386/kvm.c          |  9 +++++++++
 5 files changed, 23 insertions(+)

diff --git a/docs/hyperv.txt b/docs/hyperv.txt
index beadb2d..8fdf25c 100644
--- a/docs/hyperv.txt
+++ b/docs/hyperv.txt
@@ -174,6 +174,16 @@ without the feature to find out if enabling it is beneficial.
 
 Requires: hv-vapic
 
+3.17. hv-stimer-direct
+=======================
+Hyper-V specification allows synthetic timer operation in two modes: "classic",
+when expiration event is delivered as SynIC message and "direct", when the event
+is delivered via normal interrupt. It is known that nested Hyper-V can only
+use synthetic timers in direct mode and thus 'hv-stimer-direct' needs to be
+enabled.
+
+Requires: hv-vpindex, hv-synic, hv-time, hv-stimer
+
 
 4. Development features
 ========================
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index e07996c..7beb8ab 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5883,6 +5883,8 @@ static Property x86_cpu_properties[] = {
                       HYPERV_FEAT_EVMCS, 0),
     DEFINE_PROP_BIT64("hv-ipi", X86CPU, hyperv_features,
                       HYPERV_FEAT_IPI, 0),
+    DEFINE_PROP_BIT64("hv-stimer-direct", X86CPU, hyperv_features,
+                      HYPERV_FEAT_STIMER_DIRECT, 0),
     DEFINE_PROP_BOOL("hv-passthrough", X86CPU, hyperv_passthrough, false),
 
     DEFINE_PROP_BOOL("check", X86CPU, check_cpuid, true),
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 86edbf5..7470acf 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -749,6 +749,7 @@ typedef uint32_t FeatureWordArray[FEATURE_WORDS];
 #define HYPERV_FEAT_TLBFLUSH            11
 #define HYPERV_FEAT_EVMCS               12
 #define HYPERV_FEAT_IPI                 13
+#define HYPERV_FEAT_STIMER_DIRECT       14
 
 #ifndef HYPERV_SPINLOCK_NEVER_RETRY
 #define HYPERV_SPINLOCK_NEVER_RETRY             0xFFFFFFFF
diff --git a/target/i386/hyperv-proto.h b/target/i386/hyperv-proto.h
index c0272b3..cffac10 100644
--- a/target/i386/hyperv-proto.h
+++ b/target/i386/hyperv-proto.h
@@ -49,6 +49,7 @@
 #define HV_GUEST_IDLE_STATE_AVAILABLE           (1u << 5)
 #define HV_FREQUENCY_MSRS_AVAILABLE             (1u << 8)
 #define HV_GUEST_CRASH_MSR_AVAILABLE            (1u << 10)
+#define HV_STIMER_DIRECT_MODE_AVAILABLE         (1u << 19)
 
 /*
  * HV_CPUID_ENLIGHTMENT_INFO.EAX bits
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 86de510..a323b1f 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -802,6 +802,14 @@ static struct {
         },
         .dependencies = BIT(HYPERV_FEAT_VPINDEX)
     },
+    [HYPERV_FEAT_STIMER_DIRECT] = {
+        .desc = "direct mode synthetic timers (hv-stimer-direct)",
+        .flags = {
+            {.fw = FEAT_HYPERV_EDX,
+             .bits = HV_STIMER_DIRECT_MODE_AVAILABLE}
+        },
+        .dependencies = BIT(HYPERV_FEAT_STIMER)
+    },
 };
 
 static struct kvm_cpuid2 *try_get_hv_cpuid(CPUState *cs, int max)
@@ -1124,6 +1132,7 @@ static int hyperv_handle_properties(CPUState *cs,
     r |= hv_cpuid_check_and_set(cs, cpuid, HYPERV_FEAT_TLBFLUSH);
     r |= hv_cpuid_check_and_set(cs, cpuid, HYPERV_FEAT_EVMCS);
     r |= hv_cpuid_check_and_set(cs, cpuid, HYPERV_FEAT_IPI);
+    r |= hv_cpuid_check_and_set(cs, cpuid, HYPERV_FEAT_STIMER_DIRECT);
 
     /* Additional dependencies not covered by kvm_hyperv_properties[] */
     if (hyperv_feat_enabled(cpu, HYPERV_FEAT_SYNIC) &&
-- 
1.8.3.1



