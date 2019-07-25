Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC058C7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 15:43:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1FE422BED
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 15:43:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1FE422BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqfuA-0004pX-Vr
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 11:43:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51850)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hqftz-0004R7-BP
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 11:43:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hqfty-0006xf-2i
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 11:43:31 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44005)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hqftx-0006xW-Rk
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 11:43:30 -0400
Received: by mail-wr1-f67.google.com with SMTP id p13so51266101wru.10
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2019 08:43:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ooix8/FJqtST+aidE5Gv1JtNQK7VBm1DtK339Lu67Bg=;
 b=DbEUDhK7Z4FV4SwmRPEAb+F/5hkUhNZ6uRWKYEnPC+/hG+FuOLvbjurYu1IQpNRjju
 lQ/1mxiOUV/vOjICq5K8NDioJuLElqtKcJ6HRU7BV1b5TG8B0IDa1A6hMV4S8asUd9Sa
 hBAiH+FgAIulyGwHJ1d7epDo8Bf4xBnVFSPielx8AYNBurslDiqcOyFHUVyAQwA0NLXV
 GY2aLnkztPCV0LJpBMtfKjGQYyvxCgSTUAy87knhK/j0BbGbXiHDb8y7IpepWmRZGHmj
 EQYUKjnDDMotakcy3jlhoYtv/mFoip4xCjBfJO9sA0tW/jX0cibcgyUnyG1ug0cnsjjj
 EGpw==
X-Gm-Message-State: APjAAAXH6oAS6s8F7B3ZgPRj7Vq8OciWpAdD8/pefGp45fNKGVvIgHR+
 MP8zZMBMFMsdWw8Moe8tgqmphA==
X-Google-Smtp-Source: APXvYqwPbPy4Kk8mWwXuQHGZJx55b319SWJOxLlveNKvbkulHHsnsFHFLT+jtAXaE+4h/1cIz7LqmQ==
X-Received: by 2002:a5d:63c8:: with SMTP id c8mr13410406wrw.21.1564069408486; 
 Thu, 25 Jul 2019 08:43:28 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:cc23:f353:392:d2ee?
 ([2001:b07:6468:f312:cc23:f353:392:d2ee])
 by smtp.gmail.com with ESMTPSA id j10sm84913736wrd.26.2019.07.25.08.43.27
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Thu, 25 Jul 2019 08:43:27 -0700 (PDT)
To: Li Qiang <liq3ea@163.com>, mtosatti@redhat.com
References: <20190725151639.21693-1-liq3ea@163.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <9ada2330-1f55-20f9-3d60-b888fb127bac@redhat.com>
Date: Thu, 25 Jul 2019 17:43:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190725151639.21693-1-liq3ea@163.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [PATCH] target-i386: kvm: 'kvm_get_supported_msrs'
 cleanup
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
Cc: liq3ea@gmail.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 25/07/19 17:16, Li Qiang wrote:
> Function 'kvm_get_supported_msrs' is only called once
> now, get rid of the static variable 'kvm_supported_msrs'.
> 
> Signed-off-by: Li Qiang <liq3ea@163.com>

Queued, thanks.

Paolo

> ---
>  target/i386/kvm.c | 185 +++++++++++++++++++++++-----------------------
>  1 file changed, 91 insertions(+), 94 deletions(-)
> 
> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> index dbbb13772a..07c9250f45 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -1837,108 +1837,105 @@ static int kvm_get_supported_feature_msrs(KVMState *s)
>  
>  static int kvm_get_supported_msrs(KVMState *s)
>  {
> -    static int kvm_supported_msrs;
>      int ret = 0;
> +    struct kvm_msr_list msr_list, *kvm_msr_list;
>  
> -    /* first time */
> -    if (kvm_supported_msrs == 0) {
> -        struct kvm_msr_list msr_list, *kvm_msr_list;
> +    /*
> +     *  Obtain MSR list from KVM.  These are the MSRs that we must
> +     *  save/restore.
> +     */
> +    msr_list.nmsrs = 0;
> +    ret = kvm_ioctl(s, KVM_GET_MSR_INDEX_LIST, &msr_list);
> +    if (ret < 0 && ret != -E2BIG) {
> +        return ret;
> +    }
> +    /*
> +     * Old kernel modules had a bug and could write beyond the provided
> +     * memory. Allocate at least a safe amount of 1K.
> +     */
> +    kvm_msr_list = g_malloc0(MAX(1024, sizeof(msr_list) +
> +                                          msr_list.nmsrs *
> +                                          sizeof(msr_list.indices[0])));
>  
> -        kvm_supported_msrs = -1;
> +    kvm_msr_list->nmsrs = msr_list.nmsrs;
> +    ret = kvm_ioctl(s, KVM_GET_MSR_INDEX_LIST, kvm_msr_list);
> +    if (ret >= 0) {
> +        int i;
>  
> -        /* Obtain MSR list from KVM.  These are the MSRs that we must
> -         * save/restore */
> -        msr_list.nmsrs = 0;
> -        ret = kvm_ioctl(s, KVM_GET_MSR_INDEX_LIST, &msr_list);
> -        if (ret < 0 && ret != -E2BIG) {
> -            return ret;
> -        }
> -        /* Old kernel modules had a bug and could write beyond the provided
> -           memory. Allocate at least a safe amount of 1K. */
> -        kvm_msr_list = g_malloc0(MAX(1024, sizeof(msr_list) +
> -                                              msr_list.nmsrs *
> -                                              sizeof(msr_list.indices[0])));
> -
> -        kvm_msr_list->nmsrs = msr_list.nmsrs;
> -        ret = kvm_ioctl(s, KVM_GET_MSR_INDEX_LIST, kvm_msr_list);
> -        if (ret >= 0) {
> -            int i;
> -
> -            for (i = 0; i < kvm_msr_list->nmsrs; i++) {
> -                switch (kvm_msr_list->indices[i]) {
> -                case MSR_STAR:
> -                    has_msr_star = true;
> -                    break;
> -                case MSR_VM_HSAVE_PA:
> -                    has_msr_hsave_pa = true;
> -                    break;
> -                case MSR_TSC_AUX:
> -                    has_msr_tsc_aux = true;
> -                    break;
> -                case MSR_TSC_ADJUST:
> -                    has_msr_tsc_adjust = true;
> -                    break;
> -                case MSR_IA32_TSCDEADLINE:
> -                    has_msr_tsc_deadline = true;
> -                    break;
> -                case MSR_IA32_SMBASE:
> -                    has_msr_smbase = true;
> -                    break;
> -                case MSR_SMI_COUNT:
> -                    has_msr_smi_count = true;
> -                    break;
> -                case MSR_IA32_MISC_ENABLE:
> -                    has_msr_misc_enable = true;
> -                    break;
> -                case MSR_IA32_BNDCFGS:
> -                    has_msr_bndcfgs = true;
> -                    break;
> -                case MSR_IA32_XSS:
> -                    has_msr_xss = true;
> -                    break;
> -                case HV_X64_MSR_CRASH_CTL:
> -                    has_msr_hv_crash = true;
> -                    break;
> -                case HV_X64_MSR_RESET:
> -                    has_msr_hv_reset = true;
> -                    break;
> -                case HV_X64_MSR_VP_INDEX:
> -                    has_msr_hv_vpindex = true;
> -                    break;
> -                case HV_X64_MSR_VP_RUNTIME:
> -                    has_msr_hv_runtime = true;
> -                    break;
> -                case HV_X64_MSR_SCONTROL:
> -                    has_msr_hv_synic = true;
> -                    break;
> -                case HV_X64_MSR_STIMER0_CONFIG:
> -                    has_msr_hv_stimer = true;
> -                    break;
> -                case HV_X64_MSR_TSC_FREQUENCY:
> -                    has_msr_hv_frequencies = true;
> -                    break;
> -                case HV_X64_MSR_REENLIGHTENMENT_CONTROL:
> -                    has_msr_hv_reenlightenment = true;
> -                    break;
> -                case MSR_IA32_SPEC_CTRL:
> -                    has_msr_spec_ctrl = true;
> -                    break;
> -                case MSR_VIRT_SSBD:
> -                    has_msr_virt_ssbd = true;
> -                    break;
> -                case MSR_IA32_ARCH_CAPABILITIES:
> -                    has_msr_arch_capabs = true;
> -                    break;
> -                case MSR_IA32_CORE_CAPABILITY:
> -                    has_msr_core_capabs = true;
> -                    break;
> -                }
> +        for (i = 0; i < kvm_msr_list->nmsrs; i++) {
> +            switch (kvm_msr_list->indices[i]) {
> +            case MSR_STAR:
> +                has_msr_star = true;
> +                break;
> +            case MSR_VM_HSAVE_PA:
> +                has_msr_hsave_pa = true;
> +                break;
> +            case MSR_TSC_AUX:
> +                has_msr_tsc_aux = true;
> +                break;
> +            case MSR_TSC_ADJUST:
> +                has_msr_tsc_adjust = true;
> +                break;
> +            case MSR_IA32_TSCDEADLINE:
> +                has_msr_tsc_deadline = true;
> +                break;
> +            case MSR_IA32_SMBASE:
> +                has_msr_smbase = true;
> +                break;
> +            case MSR_SMI_COUNT:
> +                has_msr_smi_count = true;
> +                break;
> +            case MSR_IA32_MISC_ENABLE:
> +                has_msr_misc_enable = true;
> +                break;
> +            case MSR_IA32_BNDCFGS:
> +                has_msr_bndcfgs = true;
> +                break;
> +            case MSR_IA32_XSS:
> +                has_msr_xss = true;
> +                break;
> +            case HV_X64_MSR_CRASH_CTL:
> +                has_msr_hv_crash = true;
> +                break;
> +            case HV_X64_MSR_RESET:
> +                has_msr_hv_reset = true;
> +                break;
> +            case HV_X64_MSR_VP_INDEX:
> +                has_msr_hv_vpindex = true;
> +                break;
> +            case HV_X64_MSR_VP_RUNTIME:
> +                has_msr_hv_runtime = true;
> +                break;
> +            case HV_X64_MSR_SCONTROL:
> +                has_msr_hv_synic = true;
> +                break;
> +            case HV_X64_MSR_STIMER0_CONFIG:
> +                has_msr_hv_stimer = true;
> +                break;
> +            case HV_X64_MSR_TSC_FREQUENCY:
> +                has_msr_hv_frequencies = true;
> +                break;
> +            case HV_X64_MSR_REENLIGHTENMENT_CONTROL:
> +                has_msr_hv_reenlightenment = true;
> +                break;
> +            case MSR_IA32_SPEC_CTRL:
> +                has_msr_spec_ctrl = true;
> +                break;
> +            case MSR_VIRT_SSBD:
> +                has_msr_virt_ssbd = true;
> +                break;
> +            case MSR_IA32_ARCH_CAPABILITIES:
> +                has_msr_arch_capabs = true;
> +                break;
> +            case MSR_IA32_CORE_CAPABILITY:
> +                has_msr_core_capabs = true;
> +                break;
>              }
>          }
> -
> -        g_free(kvm_msr_list);
>      }
>  
> +    g_free(kvm_msr_list);
> +
>      return ret;
>  }
>  
> 


