Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C563C3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 15:19:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6475720665
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 15:19:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6475720665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45516 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAyDW-0007kb-Gn
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 11:19:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34560)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iAyAt-0006KQ-P0
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 11:16:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iAyAs-0007PL-5T
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 11:16:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56306)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iAyAr-0007P3-SV
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 11:16:50 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AD0AE60A8C
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 15:16:48 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id 124so2981322wmz.1
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 08:16:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=SomDk/eXJvZMikdm505goLMgQuNRGCz9HjaU4TX6/Eo=;
 b=gr/MU+wWpN7VinTm1/FXbA8o0FBPborwS5qbO6DrUf8xvTU4kmKU4yi21huROU0uCj
 6LV5XxQxcrJDkiduVZfh5+JemvsoiDOYNFGjwm4sN4wZPM6A8g/9TjCpLPvf9QBZkg9C
 vry+nbOq8sIjwRUefqYLn9IvaPjl/SLEEEMWTXjt+82W9gmNtOm5lNACASb21ZVTEI5g
 Yhk6ruJoI0eIAb5BnrKLZaxLQTqfGoAsTdryEqK+lthBWTMCCQNWHuG1Rzss5Ok7WM1d
 R6iwOY4ZZHDsNo6W71lrotcw53TjB0j+31LAjI5gTFeR4rfpBmKtOu2VhN/A1Guj5pj9
 DfMg==
X-Gm-Message-State: APjAAAUoe/ekdFOC1Xsv5Ycw54EVoQcqDJkhoJswSvGUg1nycIk1MLeg
 a3Al0e3CNH0UcbP3FOjrv7iYoXrpvdN03IfBZZLbwXos4NMEKLGauUOo5xaQZbgiI7k0qlZap8+
 pkgK+4/p00zq0viQ=
X-Received: by 2002:a05:600c:20c4:: with SMTP id
 y4mr2987362wmm.87.1568906207393; 
 Thu, 19 Sep 2019 08:16:47 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyDuk5zB0bKLpKE2YgDu8UUNHYp48sT+GoEOlUVpk11f2zdDbNPu260eHIESxnzezAGdnG8Mw==
X-Received: by 2002:a05:600c:20c4:: with SMTP id
 y4mr2987349wmm.87.1568906207133; 
 Thu, 19 Sep 2019 08:16:47 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c46c:2acb:d8d2:21d8?
 ([2001:b07:6468:f312:c46c:2acb:d8d2:21d8])
 by smtp.gmail.com with ESMTPSA id e20sm15646151wrc.34.2019.09.19.08.16.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Sep 2019 08:16:46 -0700 (PDT)
Subject: Re: [PATCH 6/7] target/i386: add VMX features
From: Paolo Bonzini <pbonzini@redhat.com>
To: Liran Alon <liran.alon@oracle.com>
References: <1568716480-9973-1-git-send-email-pbonzini@redhat.com>
 <1568716480-9973-7-git-send-email-pbonzini@redhat.com>
 <A0C3DD36-966F-46CC-8705-903112BECBC2@oracle.com>
 <60820b32-42df-dbc0-9fc7-81821b2e42cb@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <4cbabffc-f2dd-35f8-e4cd-161f539b3fec@redhat.com>
Date: Thu, 19 Sep 2019 17:16:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <60820b32-42df-dbc0-9fc7-81821b2e42cb@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: qemu-devel@nongnu.org, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 19/09/19 16:54, Paolo Bonzini wrote:
> I will add defines for fixed_vmx_basic, fixed_vmx_misc and
> fixed_vmx_ept_mask, though.

... like this:

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 8447ece..c62e3b6 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -779,14 +779,19 @@ typedef uint64_t FeatureWordArray[FEATURE_WORDS];
 #define MSR_CORE_CAP_SPLIT_LOCK_DETECT  (1U << 5)
 
 /* VMX MSR features */
+#define MSR_VMX_BASIC_VMCS_REVISION_MASK             0x7FFFFFFFull
+#define MSR_VMX_BASIC_VMXON_REGION_SIZE_MASK         (0x00001FFFull << 32)
+#define MSR_VMX_BASIC_VMCS_MEM_TYPE_MASK             (0x003C0000ull << 32)
 #define MSR_VMX_BASIC_DUAL_MONITOR                   (1ULL << 49)
 #define MSR_VMX_BASIC_INS_OUTS                       (1ULL << 54)
 #define MSR_VMX_BASIC_TRUE_CTLS                      (1ULL << 55)
 
+#define MSR_VMX_MISC_PREEMPTION_TIMER_SHIFT_MASK     0x1Full
 #define MSR_VMX_MISC_STORE_LMA                       (1ULL << 5)
 #define MSR_VMX_MISC_ACTIVITY_HLT                    (1ULL << 6)
 #define MSR_VMX_MISC_ACTIVITY_SHUTDOWN               (1ULL << 7)
 #define MSR_VMX_MISC_ACTIVITY_WAIT_SIPI              (1ULL << 8)
+#define MSR_VMX_MISC_MAX_MSR_LIST_SIZE_MASK          0x0E000000ull
 #define MSR_VMX_MISC_VMWRITE_VMEXIT                  (1ULL << 29)
 #define MSR_VMX_MISC_ZERO_LEN_INJECT                 (1ULL << 30)
 
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 29865c3..7c5ad26 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -2500,7 +2500,10 @@ static void kvm_msr_entry_add_vmx(X86CPU *cpu, FeatureWordArray f)
      * Bits 0-30, 32-44 and 50-53 come from the host.  KVM should
      * not change them for backwards compatibility.
      */
-    uint64_t fixed_vmx_basic = kvm_vmx_basic & 0x003c1fff7fffffffULL;
+    uint64_t fixed_vmx_basic = kvm_vmx_basic &
+        (MSR_VMX_BASIC_VMCS_REVISION_MASK |
+         MSR_VMX_BASIC_VMXON_REGION_SIZE_MASK |
+         MSR_VMX_BASIC_VMCS_MEM_TYPE_MASK);
 
     /*
      * Same for bits 0-4 and 25-27.  Bits 16-24 (CR3 target count) can
@@ -2509,14 +2512,17 @@ static void kvm_msr_entry_add_vmx(X86CPU *cpu, FeatureWordArray f)
      * not support dual-monitor treatment and probably never will; mask
      * them out as well.
      */
-    uint64_t fixed_vmx_misc = kvm_vmx_misc & 0x0e00001f;
+    uint64_t fixed_vmx_misc = kvm_vmx_misc &
+        (MSR_VMX_MISC_PREEMPTION_TIMER_SHIFT_MASK |
+         MSR_VMX_MISC_MAX_MSR_LIST_SIZE_MASK);
 
     /*
      * EPT memory types should not change either, so we do not bother
      * adding features for them.
      */
     uint64_t fixed_vmx_ept_mask =
-            (f[FEAT_VMX_SECONDARY_CTLS] & VMX_SECONDARY_EXEC_ENABLE_EPT ? 0x4100ull : 0);
+            (f[FEAT_VMX_SECONDARY_CTLS] & VMX_SECONDARY_EXEC_ENABLE_EPT ?
+	     MSR_VMX_EPT_UC | MSR_VMX_EPT_WB : 0);
     uint64_t fixed_vmx_ept_vpid = kvm_vmx_ept_vpid & fixed_vmx_ept_mask;
 
     kvm_msr_entry_add(cpu, MSR_IA32_VMX_TRUE_PROCBASED_CTLS,


Paolo

