Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A620ECA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 13:09:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AAEB20659
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 13:09:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AAEB20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMXRF-0002xy-MK
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 09:09:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33969)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iMXQZ-0002WA-Ci
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 09:08:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iMXQY-00027L-0w
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 09:08:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51362)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iMXQX-00026z-OF
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 09:08:49 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4AC5B81F31
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 13:08:48 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id s17so1628911wrp.17
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 06:08:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=iTv0LoYpH0/m3UFvPdNLfc8P+3IGaQlwurlQIrT5wyE=;
 b=qoOJJdW4oTfy9GUc3r6uXAnJJmedViykRKjeS2u9+KwnVdUJxRw0WNlJLvVvPaYd0m
 kP7DgeeCam9/gZ/F7KbKgpELgoPcdcD/Uec41Ob+ZhbMV+3U0Sdc8m2yLh4Du/3ZieSS
 erzorPCpkW0fgYUGLHIFxDp1/VJGO/FVPZurXRKAtsLJf/rWv9MISlrVnckAy7ORYF4b
 DVVWjGwbrxCXeDP3hFYRColGnSCTcE6fIZEkWJvfQZDPnFT33MBaUcTmN7fo05k4aQud
 cEImdtQG21tqFf8UognwDchRQLg3PZxD9j0kp6qJ36HKEYrOzRz4l4t2ZKxlCFSfbwLR
 4OOA==
X-Gm-Message-State: APjAAAWSex+ABb1H2HPhBeVGmOEHZ750YL5GtQCU+P3FOPGILFfdh5WX
 z2JFT3mjqtBC1FUKex0jx5aRXwqAZvesrgo6Rd8vUe692zjbraIwuZVRW3nylRKptmDF9ZdiQA2
 rozRSfACkfuWwExg=
X-Received: by 2002:a05:6000:10d:: with SMTP id
 o13mr1552353wrx.321.1571663326850; 
 Mon, 21 Oct 2019 06:08:46 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxS09JfKkE231hvpsf/VP9E6o/ZytbLEh6vzUw7i8EjX50IH20BYIbQJV3Ichl0zWP1xdh3Ig==
X-Received: by 2002:a05:6000:10d:: with SMTP id
 o13mr1552320wrx.321.1571663326458; 
 Mon, 21 Oct 2019 06:08:46 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id i3sm10987206wrw.69.2019.10.21.06.08.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Oct 2019 06:08:46 -0700 (PDT)
Subject: Re: [PATCH] i386/kvm: add NoNonArchitecturalCoreSharing Hyper-V
 enlightenment
To: Vitaly Kuznetsov <vkuznets@redhat.com>, qemu-devel@nongnu.org
References: <20191018163908.10246-1-vkuznets@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <4d89f852-85bc-8370-5929-848d24b80a6f@redhat.com>
Date: Mon, 21 Oct 2019 15:08:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191018163908.10246-1-vkuznets@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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

On 18/10/19 18:39, Vitaly Kuznetsov wrote:
> Hyper-V TLFS specifies this enlightenment as:
> "NoNonArchitecturalCoreSharing - Indicates that a virtual processor will never
> share a physical core with another virtual processor, except for virtual
> processors that are reported as sibling SMT threads. This can be used as an
> optimization to avoid the performance overhead of STIBP".
> 
> However, STIBP is not the only implication. It was found that Hyper-V on
> KVM doesn't pass MD_CLEAR bit to its guests if it doesn't see
> NoNonArchitecturalCoreSharing bit.
> 
> KVM reports NoNonArchitecturalCoreSharing in KVM_GET_SUPPORTED_HV_CPUID to
> indicate that SMT on the host is impossible (not supported of forcefully
> disabled).
> 
> Implement NoNonArchitecturalCoreSharing support in QEMU as tristate:
> 'off' - the feature is disabled (default)
> 'on' - the feature is enabled. This is only safe if vCPUS are properly
>  pinned and correct topology is exposed. As CPU pinning is done outside
>  of QEMU the enablement decision will be made on a higher level.
> 'auto' - copy KVM setting. As during live migration SMT settings on the
> source and destination host may differ this requires us to add a migration
> blocker.
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  docs/hyperv.txt            | 13 +++++++++++++
>  target/i386/cpu.c          |  2 ++
>  target/i386/cpu.h          |  2 ++
>  target/i386/hyperv-proto.h |  1 +
>  target/i386/kvm.c          | 26 ++++++++++++++++++++++++++
>  5 files changed, 44 insertions(+)
> 
> diff --git a/docs/hyperv.txt b/docs/hyperv.txt
> index 8fdf25c8291c..6518b716a958 100644
> --- a/docs/hyperv.txt
> +++ b/docs/hyperv.txt
> @@ -184,6 +184,19 @@ enabled.
>  
>  Requires: hv-vpindex, hv-synic, hv-time, hv-stimer
>  
> +3.17. hv-no-nonarch-coresharing=on/off/auto
> +===========================================
> +This enlightenment tells guest OS that virtual processors will never share a
> +physical core unless they are reported as sibling SMT threads. This information
> +is required by Windows and Hyper-V guests to properly mitigate SMT related CPU
> +vulnerabilities.
> +When the option is set to 'auto' QEMU will enable the feature only when KVM
> +reports that non-architectural coresharing is impossible, this means that
> +hyper-threading is not supported or completely disabled on the host. This
> +setting also prevents migration as SMT settings on the destination may differ.
> +When the option is set to 'on' QEMU will always enable the feature, regardless
> +of host setup. To keep guests secure, this can only be used in conjunction with
> +exposing correct vCPU topology and vCPU pinning.
>  
>  4. Development features
>  ========================
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 44f1bbdcac76..4086c0a16767 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -6156,6 +6156,8 @@ static Property x86_cpu_properties[] = {
>                        HYPERV_FEAT_IPI, 0),
>      DEFINE_PROP_BIT64("hv-stimer-direct", X86CPU, hyperv_features,
>                        HYPERV_FEAT_STIMER_DIRECT, 0),
> +    DEFINE_PROP_ON_OFF_AUTO("hv-no-nonarch-coresharing", X86CPU,
> +                            hyperv_no_nonarch_cs, ON_OFF_AUTO_OFF),
>      DEFINE_PROP_BOOL("hv-passthrough", X86CPU, hyperv_passthrough, false),
>  
>      DEFINE_PROP_BOOL("check", X86CPU, check_cpuid, true),
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index eaa5395aa539..9f47c1e2a52d 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -24,6 +24,7 @@
>  #include "cpu-qom.h"
>  #include "hyperv-proto.h"
>  #include "exec/cpu-defs.h"
> +#include "qapi/qapi-types-common.h"
>  
>  /* The x86 has a strong memory model with some store-after-load re-ordering */
>  #define TCG_GUEST_DEFAULT_MO      (TCG_MO_ALL & ~TCG_MO_ST_LD)
> @@ -1563,6 +1564,7 @@ struct X86CPU {
>      bool hyperv_synic_kvm_only;
>      uint64_t hyperv_features;
>      bool hyperv_passthrough;
> +    OnOffAuto hyperv_no_nonarch_cs;
>  
>      bool check_cpuid;
>      bool enforce_cpuid;
> diff --git a/target/i386/hyperv-proto.h b/target/i386/hyperv-proto.h
> index cffac10b45dc..056a305be38c 100644
> --- a/target/i386/hyperv-proto.h
> +++ b/target/i386/hyperv-proto.h
> @@ -63,6 +63,7 @@
>  #define HV_CLUSTER_IPI_RECOMMENDED          (1u << 10)
>  #define HV_EX_PROCESSOR_MASKS_RECOMMENDED   (1u << 11)
>  #define HV_ENLIGHTENED_VMCS_RECOMMENDED     (1u << 14)
> +#define HV_NO_NONARCH_CORESHARING           (1u << 18)
>  
>  /*
>   * Basic virtualized MSRs
> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> index 11b9c854b543..ef606e51babe 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -1208,6 +1208,16 @@ static int hyperv_handle_properties(CPUState *cs,
>          }
>      }
>  
> +    if (cpu->hyperv_no_nonarch_cs == ON_OFF_AUTO_ON) {
> +        env->features[FEAT_HV_RECOMM_EAX] |= HV_NO_NONARCH_CORESHARING;
> +    } else if (cpu->hyperv_no_nonarch_cs == ON_OFF_AUTO_AUTO) {

Do you want to make auto the default if "-cpu host,migratable=off"?  It
can be done on top so I started queueing this patch.

Paolo

