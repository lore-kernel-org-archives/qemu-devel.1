Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B774CA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 14:10:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FF1D2070B
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 14:10:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FF1D2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMYO1-0006lI-Hf
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 10:10:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45285)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vkuznets@redhat.com>) id 1iMYNC-00063Y-Nh
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 10:09:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vkuznets@redhat.com>) id 1iMYNA-0003ZI-W4
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 10:09:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:15252)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vkuznets@redhat.com>) id 1iMYNA-0003Yl-Nh
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 10:09:24 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 706C559455
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 14:09:23 +0000 (UTC)
Received: by mail-wm1-f72.google.com with SMTP id l184so3480093wmf.6
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 07:09:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=dG/mhDB7SW4mhzPN2/LaIgihcVt6FqXkX0uEDIdo16k=;
 b=oOLFWTzrmU611IZsaLQW2q1K5g86u0ZpzgRMdLI5Hgo9DSI7nU0FO+Ou1VoxB9TiV3
 V3bNnaUR1wM93gYF3h6VVD8mM5z4jMxHWtDm8EXLF7HRIh9QCQCbs8awKaxQ5XT/78te
 O7CZ15C8p9h0VPQtMJFrVxG1+5jVflZ9uN28txkBaZMC4GzkTSCSVpXFv628x+8306Qg
 ETXkj4ZXV9R0FGIBgxjuFl7oca8gJkzSgczxAfXTJVdl5m99/RrZef2Rf9CWIx+zVXqX
 wB7KxyqBOl8SP10/ZcKttHDOFBZTlaqMMdTZkXYNASclfpyQYFOSCAA2AStlIRrkuP+I
 z8RA==
X-Gm-Message-State: APjAAAWOCuNqgGL3AeCKRE+hG3RCkXrYGvhnMdaCXxVrfGSYsCMjfKqq
 dQKQ3TMFmM6caVIXMJtdYihEQOIoCDLFUnRH6vcrURlgd18rz+5nsbm0POUPcyN3g1kbgzs5moP
 UfWN6f0Ltwm5Nh8E=
X-Received: by 2002:a7b:ca4d:: with SMTP id m13mr19952602wml.95.1571666962027; 
 Mon, 21 Oct 2019 07:09:22 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwgCD1h+lAL9JvFaiWk/sGpBJmIj/ol9hIuwlIGKeQV6qkb5KHWM36s6wBjwyFcC+ut3JEAtw==
X-Received: by 2002:a7b:ca4d:: with SMTP id m13mr19952584wml.95.1571666961699; 
 Mon, 21 Oct 2019 07:09:21 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10])
 by smtp.gmail.com with ESMTPSA id q22sm12929925wmj.31.2019.10.21.07.09.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Oct 2019 07:09:21 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH] i386/kvm: add NoNonArchitecturalCoreSharing Hyper-V
 enlightenment
In-Reply-To: <4d89f852-85bc-8370-5929-848d24b80a6f@redhat.com>
References: <20191018163908.10246-1-vkuznets@redhat.com>
 <4d89f852-85bc-8370-5929-848d24b80a6f@redhat.com>
Date: Mon, 21 Oct 2019 16:09:20 +0200
Message-ID: <878spe197z.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Roman Kagan <rkagan@virtuozzo.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 18/10/19 18:39, Vitaly Kuznetsov wrote:
>> Hyper-V TLFS specifies this enlightenment as:
>> "NoNonArchitecturalCoreSharing - Indicates that a virtual processor will never
>> share a physical core with another virtual processor, except for virtual
>> processors that are reported as sibling SMT threads. This can be used as an
>> optimization to avoid the performance overhead of STIBP".
>> 
>> However, STIBP is not the only implication. It was found that Hyper-V on
>> KVM doesn't pass MD_CLEAR bit to its guests if it doesn't see
>> NoNonArchitecturalCoreSharing bit.
>> 
>> KVM reports NoNonArchitecturalCoreSharing in KVM_GET_SUPPORTED_HV_CPUID to
>> indicate that SMT on the host is impossible (not supported of forcefully
>> disabled).
>> 
>> Implement NoNonArchitecturalCoreSharing support in QEMU as tristate:
>> 'off' - the feature is disabled (default)
>> 'on' - the feature is enabled. This is only safe if vCPUS are properly
>>  pinned and correct topology is exposed. As CPU pinning is done outside
>>  of QEMU the enablement decision will be made on a higher level.
>> 'auto' - copy KVM setting. As during live migration SMT settings on the
>> source and destination host may differ this requires us to add a migration
>> blocker.
>> 
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> ---
>>  docs/hyperv.txt            | 13 +++++++++++++
>>  target/i386/cpu.c          |  2 ++
>>  target/i386/cpu.h          |  2 ++
>>  target/i386/hyperv-proto.h |  1 +
>>  target/i386/kvm.c          | 26 ++++++++++++++++++++++++++
>>  5 files changed, 44 insertions(+)
>> 
>> diff --git a/docs/hyperv.txt b/docs/hyperv.txt
>> index 8fdf25c8291c..6518b716a958 100644
>> --- a/docs/hyperv.txt
>> +++ b/docs/hyperv.txt
>> @@ -184,6 +184,19 @@ enabled.
>>  
>>  Requires: hv-vpindex, hv-synic, hv-time, hv-stimer
>>  
>> +3.17. hv-no-nonarch-coresharing=on/off/auto
>> +===========================================
>> +This enlightenment tells guest OS that virtual processors will never share a
>> +physical core unless they are reported as sibling SMT threads. This information
>> +is required by Windows and Hyper-V guests to properly mitigate SMT related CPU
>> +vulnerabilities.
>> +When the option is set to 'auto' QEMU will enable the feature only when KVM
>> +reports that non-architectural coresharing is impossible, this means that
>> +hyper-threading is not supported or completely disabled on the host. This
>> +setting also prevents migration as SMT settings on the destination may differ.
>> +When the option is set to 'on' QEMU will always enable the feature, regardless
>> +of host setup. To keep guests secure, this can only be used in conjunction with
>> +exposing correct vCPU topology and vCPU pinning.
>>  
>>  4. Development features
>>  ========================
>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>> index 44f1bbdcac76..4086c0a16767 100644
>> --- a/target/i386/cpu.c
>> +++ b/target/i386/cpu.c
>> @@ -6156,6 +6156,8 @@ static Property x86_cpu_properties[] = {
>>                        HYPERV_FEAT_IPI, 0),
>>      DEFINE_PROP_BIT64("hv-stimer-direct", X86CPU, hyperv_features,
>>                        HYPERV_FEAT_STIMER_DIRECT, 0),
>> +    DEFINE_PROP_ON_OFF_AUTO("hv-no-nonarch-coresharing", X86CPU,
>> +                            hyperv_no_nonarch_cs, ON_OFF_AUTO_OFF),
>>      DEFINE_PROP_BOOL("hv-passthrough", X86CPU, hyperv_passthrough, false),
>>  
>>      DEFINE_PROP_BOOL("check", X86CPU, check_cpuid, true),
>> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
>> index eaa5395aa539..9f47c1e2a52d 100644
>> --- a/target/i386/cpu.h
>> +++ b/target/i386/cpu.h
>> @@ -24,6 +24,7 @@
>>  #include "cpu-qom.h"
>>  #include "hyperv-proto.h"
>>  #include "exec/cpu-defs.h"
>> +#include "qapi/qapi-types-common.h"
>>  
>>  /* The x86 has a strong memory model with some store-after-load re-ordering */
>>  #define TCG_GUEST_DEFAULT_MO      (TCG_MO_ALL & ~TCG_MO_ST_LD)
>> @@ -1563,6 +1564,7 @@ struct X86CPU {
>>      bool hyperv_synic_kvm_only;
>>      uint64_t hyperv_features;
>>      bool hyperv_passthrough;
>> +    OnOffAuto hyperv_no_nonarch_cs;
>>  
>>      bool check_cpuid;
>>      bool enforce_cpuid;
>> diff --git a/target/i386/hyperv-proto.h b/target/i386/hyperv-proto.h
>> index cffac10b45dc..056a305be38c 100644
>> --- a/target/i386/hyperv-proto.h
>> +++ b/target/i386/hyperv-proto.h
>> @@ -63,6 +63,7 @@
>>  #define HV_CLUSTER_IPI_RECOMMENDED          (1u << 10)
>>  #define HV_EX_PROCESSOR_MASKS_RECOMMENDED   (1u << 11)
>>  #define HV_ENLIGHTENED_VMCS_RECOMMENDED     (1u << 14)
>> +#define HV_NO_NONARCH_CORESHARING           (1u << 18)
>>  
>>  /*
>>   * Basic virtualized MSRs
>> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
>> index 11b9c854b543..ef606e51babe 100644
>> --- a/target/i386/kvm.c
>> +++ b/target/i386/kvm.c
>> @@ -1208,6 +1208,16 @@ static int hyperv_handle_properties(CPUState *cs,
>>          }
>>      }
>>  
>> +    if (cpu->hyperv_no_nonarch_cs == ON_OFF_AUTO_ON) {
>> +        env->features[FEAT_HV_RECOMM_EAX] |= HV_NO_NONARCH_CORESHARING;
>> +    } else if (cpu->hyperv_no_nonarch_cs == ON_OFF_AUTO_AUTO) {
>
> Do you want to make auto the default if "-cpu host,migratable=off"?  It
> can be done on top so I started queueing this patch.

Hm, one thing is that CPUID 0x40000004 doesn't exist if no Hyper-V
enlightenments are passed so we'll probably have to modify your idea to
"-cpu host,migratable=off,+any-hyperv-enlightenment" but then the
question is how conservative are we, like if QEMU command line doesn't
change can new CPUID flags appear or not? And we'll probably need a way
to explicitly disable HV_NO_NONARCH_CORESHARING if needed.

-- 
Vitaly

