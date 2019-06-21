Return-Path: <SRS0=2JTU=UU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCB46C43613
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 15:07:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D8FA20449
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 15:07:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D8FA20449
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35906 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1heL82-00037M-U2
	for qemu-devel@archiver.kernel.org; Fri, 21 Jun 2019 11:07:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50982)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1heL3Y-0000NM-Kk
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 11:02:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1heL3W-0002b5-Pn
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 11:02:24 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36731)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1heL3T-0002RK-U2
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 11:02:22 -0400
Received: by mail-wr1-f68.google.com with SMTP id n4so5716209wrs.3
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2019 08:02:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=yt8+QS4tHfiNtFJC+C6Pob3T+ZEmL4sVkzzJViLfl9c=;
 b=pQChZ98zEiwhqv6n3hMeEK6vKWOrW8J1YE4Q5W7df9fsdNcnTVenoxOAwsowhGyHB8
 49yb0FcSkMz6MnTNNAb/xDq64V9KFmitaadfSf+DyurSo013Ok9JBNh2bFVEOhEcdjiQ
 66Mq0HPgpOUypdZPdhxQXNEbR2Gf1/ZhAz3wkyMgIVwVsoN0d5v/bMLeGQDd5Jsvh/rY
 wRa7gS614ns5K0cPllGx9hX7fcqr5TG4PMOlkgSocqcNjokzzkxNA5s8iYDRrWN0W9GT
 0c6mm7BqPI/wEv3r/KTWOk7kD1HYjWePqnFcUv5Lq+N/TJsNEc0BP8JIn9qeAHkrYHmw
 jPhA==
X-Gm-Message-State: APjAAAVSXmBvo1D2tmLfpg46KaH2pG28JVmxOMrXta8iF18bpTcbj6pE
 mjs03Qfl9x3wfi2w1NLF7m/sVvFq1sU=
X-Google-Smtp-Source: APXvYqxRCFao7HJQhPI0In4PAoVjsC3t6LIcxl35NJOkVbYJNTFZastmv+00zUCI71ozj3Bn3JakFQ==
X-Received: by 2002:adf:fdc2:: with SMTP id i2mr47312531wrs.146.1561129337727; 
 Fri, 21 Jun 2019 08:02:17 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:45fb:a0de:928e:79e8?
 ([2001:b07:6468:f312:45fb:a0de:928e:79e8])
 by smtp.gmail.com with ESMTPSA id s9sm2439579wmc.11.2019.06.21.08.02.17
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 21 Jun 2019 08:02:17 -0700 (PDT)
To: Liran Alon <liran.alon@oracle.com>
References: <1561116620-22245-1-git-send-email-pbonzini@redhat.com>
 <1561116620-22245-23-git-send-email-pbonzini@redhat.com>
 <96A3CC63-2B7D-44C2-AA9A-C02AF8FC3691@oracle.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <150eb2f8-3b1a-e0ab-df36-adcbd601055d@redhat.com>
Date: Fri, 21 Jun 2019 17:02:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <96A3CC63-2B7D-44C2-AA9A-C02AF8FC3691@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [PULL 22/25] target/i386: kvm: Add nested
 migration blocker only when kernel lacks required capabilities
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 21/06/19 14:39, Liran Alon wrote:
>> On 21 Jun 2019, at 14:30, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>> From: Liran Alon <liran.alon@oracle.com>
>>
>> Previous commits have added support for migration of nested virtualization
>> workloads. This was done by utilising two new KVM capabilities:
>> KVM_CAP_NESTED_STATE and KVM_CAP_EXCEPTION_PAYLOAD. Both which are
>> required in order to correctly migrate such workloads.
>>
>> Therefore, change code to add a migration blocker for vCPUs exposed with
>> Intel VMX or AMD SVM in case one of these kernel capabilities is
>> missing.
>>
>> Signed-off-by: Liran Alon <liran.alon@oracle.com>
>> Reviewed-by: Maran Wilson <maran.wilson@oracle.com>
>> Message-Id: <20190619162140.133674-11-liran.alon@oracle.com>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>> target/i386/kvm.c     | 9 +++++++--
>> target/i386/machine.c | 2 +-
>> 2 files changed, 8 insertions(+), 3 deletions(-)
>>
>> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
>> index c931e9d..e4b4f57 100644
>> --- a/target/i386/kvm.c
>> +++ b/target/i386/kvm.c
>> @@ -1640,9 +1640,14 @@ int kvm_arch_init_vcpu(CPUState *cs)
>>                                   !!(c->ecx & CPUID_EXT_SMX);
>>     }
>>
>> -    if (cpu_has_nested_virt(env) && !nested_virt_mig_blocker) {
>> +    if (cpu_has_vmx(env) && !nested_virt_mig_blocker &&
> 
> The change here from cpu_has_nested_virt(env) to cpu_has_vmx(env) is not clear.
> We should explicitly explain that it’s because we still wish to preserve backwards-compatability
> to migrating AMD vCPU exposed with SVM.
> 
> In addition, commit ("target/i386: kvm: Block migration for vCPUs exposed with nested virtualization")
> doesn’t make sense in case we still want to allow migrating AMD vCPU exposed with SVM.
> 
> Since QEMU commit 75d373ef9729 ("target-i386: Disable SVM by default in KVM mode"),
> machine-types since v2.2 don’t expose AMD SVM by default.
> Therefore, my personal opinion on this is that it’s fine to block migration in this case.

I totally missed that commit.  My bad.

Actually, now that I think about it SVM *will* have some state while
running in guest mode, namely:

- the NPT page table root

- the L1 CR4.PAE, EFER.LMA and EFER.NXE bits, which determine the format
of the NPT12 page tables

These are covered by the existing vmstate_svm_npt subsection.

On the other hand, the lack of something like VMXON/VMCS12 state means
that AMD already sorta works unless you're migrating while in guest
mode.  For Intel, just execute VMXON before migration, and starting any
VM after migration is doomed.

So, overall I prefer not to block migration.

>> +        ((kvm_max_nested_state_length() <= 0) || !has_exception_payload)) {
>>         error_setg(&nested_virt_mig_blocker,
>> -                   "Nested virtualization does not support live migration yet");
>> +                   "Kernel do not provide required capabilities for “
> 
> As Maran have noted, we should change this “do not” to “does not”.
> Sorry for my bad English grammer. :)
> 
>> +                   "nested virtualization migration. "
>> +                   "(CAP_NESTED_STATE=%d, CAP_EXCEPTION_PAYLOAD=%d)",
>> +                   kvm_max_nested_state_length() > 0,
>> +                   has_exception_payload);
>>         r = migrate_add_blocker(nested_virt_mig_blocker, &local_err);
>>         if (local_err) {
>>             error_report_err(local_err);
>> diff --git a/target/i386/machine.c b/target/i386/machine.c
>> index fc49e5a..851b249 100644
>> --- a/target/i386/machine.c
>> +++ b/target/i386/machine.c
>> @@ -233,7 +233,7 @@ static int cpu_pre_save(void *opaque)
>>
>> #ifdef CONFIG_KVM
>>     /* Verify we have nested virtualization state from kernel if required */
>> -    if (cpu_has_nested_virt(env) && !env->nested_state) {
>> +    if (kvm_enabled() && cpu_has_vmx(env) && !env->nested_state) {
> 
> Good catch regarding adding kvm_enabled() here.

Caught by "make check", not by me!

> But I think this should have been added to commit ("target/i386: kvm: Add support for save and restore nested state”).

This commit is where bisection broke. :)

Paolo

