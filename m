Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C8A4C76186
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 09:41:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03A7C20880
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 09:41:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03A7C20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hngQz-0007B6-TK
	for qemu-devel@archiver.kernel.org; Wed, 17 Jul 2019 05:41:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39954)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hngQp-0006mm-5S
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 05:41:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hngQo-0000ym-3f
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 05:41:03 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53819)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hngQn-0000yL-Sk
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 05:41:02 -0400
Received: by mail-wm1-f67.google.com with SMTP id x15so21444643wmj.3
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2019 02:41:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=kaYgjRiYZdZJ50mocqHXkEiexatRolziE7a5qVryLHw=;
 b=ailwZj1W+5GHwG1IilCuj0k/jtNmGVykNtn21bfFrlDIe9UmItwi8ou38s6FGFdq7j
 WwEu+6pAqXzxVKCVrXGxZgI+BS6gQ3c3cD8uugoEp9ExFBvXMuNTS0vXYUJIe5JWMOUY
 VMBt5RwfCUnXaxyNGsxEYx0k2orA3GVMpPIvhHYo83eUqufOPy2iNFvjigjRVue3eGMv
 sqBTNAGJ41K5sO3cVQA3lzo/eH6pDeqF4ZQMQ9ocGbnfTu4EbSx51t6t2793ng+l3PXS
 E4zpAiQmuLIX4Y3aaq6aMONQSrjLgABVlaXx2l2Hj9acnditsnwgtJV9OoN5dKWLCZ8m
 fqYQ==
X-Gm-Message-State: APjAAAW+HO6qTn17kwWgiuXmpR2ltN1D2wCzlnc0BNrva9gSIVtnZnOR
 eBBthweIz03PNpWKHCIncRJusw==
X-Google-Smtp-Source: APXvYqyZp5j638BK+Tla5RTHT5srQJUuE4IERJbTvBWr3asN2jJky8EtotPshUVJxCaYtgh/ikc3Xw==
X-Received: by 2002:a05:600c:10ce:: with SMTP id
 l14mr34822957wmd.118.1563356460607; 
 Wed, 17 Jul 2019 02:41:00 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:e427:3beb:1110:dda2?
 ([2001:b07:6468:f312:e427:3beb:1110:dda2])
 by smtp.gmail.com with ESMTPSA id b203sm25705283wmd.41.2019.07.17.02.40.59
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 17 Jul 2019 02:40:59 -0700 (PDT)
To: Mark Kanda <mark.kanda@oracle.com>, qemu-devel@nongnu.org
References: <1563313451-19861-1-git-send-email-mark.kanda@oracle.com>
 <1563313451-19861-2-git-send-email-mark.kanda@oracle.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <1c441297-bf3b-7b0b-465a-dbb12b31280f@redhat.com>
Date: Wed, 17 Jul 2019 11:40:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <1563313451-19861-2-git-send-email-mark.kanda@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.67
Subject: Re: [Qemu-devel] [PATCH-for-4.2 1/1] Only enable the halt poll
 control MSR if it is supported by the host
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
Cc: mtosatti@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 16/07/19 23:44, Mark Kanda wrote:
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index a8bafdb8b9..dacbf7a9fe 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -2838,7 +2838,6 @@ static PropValue kvm_default_props[] = {
>      { "kvm-asyncpf", "on" },
>      { "kvm-steal-time", "on" },
>      { "kvm-pv-eoi", "on" },
> -    { "kvm-poll-control", "on" },
>      { "kvmclock-stable-bit", "on" },
>      { "x2apic", "on" },
>      { "acpi", "off" },
> @@ -5109,6 +5108,13 @@ static void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
>          env->cpuid_xlevel2 = env->cpuid_min_xlevel2;
>      }
>  
> +    /* Enable the halt poll control MSR if it is supported by the host */
> +    if (x86_cpu_get_supported_feature_word(FEAT_KVM, cpu->migratable) &
> +        (1 << KVM_FEATURE_POLL_CONTROL)) {
> +        env->features[FEAT_KVM] |= 1 << KVM_FEATURE_POLL_CONTROL;

This is already done by the "if (cpu->max_features)" block (and should
not be done if !cpu->max_features, or you break migration to older hosts).

> +        env->poll_control_msr = 1;
> +    }


> +
>  out:
>      if (local_err != NULL) {
>          error_propagate(errp, local_err);
> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> index cb22684139..81dd5d2c1b 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -1796,8 +1796,6 @@ void kvm_arch_reset_vcpu(X86CPU *cpu)
>  
>          hyperv_x86_synic_reset(cpu);
>      }
> -    /* enabled by default */
> -    env->poll_control_msr = 1;
>  }
>  
>  void kvm_arch_do_init_vcpu(X86CPU *cpu)
> diff --git a/target/i386/machine.c b/target/i386/machine.c
> index 20077a8a5a..9d6095b264 100644
> --- a/target/i386/machine.c
> +++ b/target/i386/machine.c
> @@ -394,7 +394,6 @@ static bool steal_time_msr_needed(void *opaque)
>      return cpu->env.steal_time_msr != 0;
>  }
>  
> -/* Poll control MSR enabled by default */
>  static bool poll_control_msr_needed(void *opaque)
>  {
>      X86CPU *cpu = opaque;
> 

This will cause the migration subsection to be sent always on old hosts,
thus breaking migration to older QEMU.  I think leaving in the "/*
enabled by default */" hunk is fine, because indeed on hosts that lack
the MSR you have the same behavior as if it were 1.

So all in all only the first hunk is needed.

Paolo

