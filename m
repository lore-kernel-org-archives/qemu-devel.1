Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10815C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 00:58:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF35120721
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 00:58:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF35120721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJoBZ-00022c-VH
	for qemu-devel@archiver.kernel.org; Wed, 01 Apr 2020 20:58:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34550)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <colin.xu@intel.com>) id 1jJoAi-0001a4-Li
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 20:57:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <colin.xu@intel.com>) id 1jJoAf-0001eu-Ez
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 20:57:26 -0400
Received: from mga18.intel.com ([134.134.136.126]:64165)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <colin.xu@intel.com>) id 1jJoAf-0001Sd-54
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 20:57:25 -0400
IronPort-SDR: Eg/EJmroFoxSmdP6GkyYtqG6yUCM/PIMa5c3kE/7KI+H4Qho5XjE+a/I3jCt0IkT7tLSvGhwAk
 v/sjufrS9VCg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Apr 2020 17:57:20 -0700
IronPort-SDR: eVFsaNTarnU5gnCI1Hyrayw61ZHXvhsFTa7DpFKqSg2B5KR6qGfNOgdfrQAmoVrU+KeZkWgp1h
 9cBav0ZoSLAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,333,1580803200"; d="scan'208";a="449428913"
Received: from huanxu-mobl1.ccr.corp.intel.com (HELO [10.249.171.97])
 ([10.249.171.97])
 by fmsmga005.fm.intel.com with ESMTP; 01 Apr 2020 17:57:19 -0700
Subject: Re: [PATCH] Add PAT, cr8 and EFER for 32-bit qemu to hax ioctl
 interface
To: Alexey Romko <nevilad@yahoo.com>,
 "wenchao.wang@intel.com colin.xu"@intel.com
References: <1786823015.3514736.1582923592218.ref@mail.yahoo.com>
 <1786823015.3514736.1582923592218@mail.yahoo.com>
From: Colin Xu <colin.xu@intel.com>
Message-ID: <765908e2-a829-3863-ea74-5264134f1c55@intel.com>
Date: Thu, 2 Apr 2020 08:57:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <1786823015.3514736.1582923592218@mail.yahoo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 134.134.136.126
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

Sorry for missing this one.

If I remembered correctly, this patch together with the HAXM patch in 
github will cause some regression in SMP case. So we'd like to fully 
understand the technique details to make proper change, not only for a 
very specific purpose, i.e. boot Windows on Windows.

This patch together with PR#204 doens't change the IOCTL interface 
itself, but extend set/get regs with a version check, so the description 
here isn't quite clear.
And the change looks just sync the qemu/haxm status but no more. Could 
you provide more details that why Windows can't boot without the change. 
Like CR8 (TPR), is there logic that need to be handled when TPR is 
read/write?

On 2/29/2020 04:59, Alexey Romko wrote:
> Add PAT, cr8 and EFER for 32-bit qemu to hax ioctl interface, part of HAX PR 204
>
> Signed-off-by: Alexey Romko <nevilad@yahoo.com>
> ---
>   target/i386/hax-all.c       | 32 ++++++++++++++++++++++++++++----
>   target/i386/hax-i386.h      |  2 +-
>   target/i386/hax-interface.h |  2 ++
>   3 files changed, 31 insertions(+), 5 deletions(-)
>
>
> diff --git a/target/i386/hax-all.c b/target/i386/hax-all.c
> index a8b6e5aeb8..0bdd309665 100644
> --- a/target/i386/hax-all.c
> +++ b/target/i386/hax-all.c
> @@ -45,7 +45,7 @@
>       } while (0)
>   
>   /* Current version */
> -const uint32_t hax_cur_version = 0x4; /* API v4: unmapping and MMIO moves */
> +const uint32_t hax_cur_version = 0x5; /* API v5: supports CR8/EFER/PAT */
>   /* Minimum HAX kernel version */
>   const uint32_t hax_min_version = 0x4; /* API v4: supports unmapping */
>   
> @@ -137,6 +137,7 @@ static int hax_version_support(struct hax_state *hax)
>           return 0;
>       }
>   
> +    hax_global.cur_api_version = version.cur_version;
>       return 1;
>   }
>   
> @@ -845,12 +846,24 @@ static int hax_sync_vcpu_register(CPUArchState *env, int set)
>           regs._cr2 = env->cr[2];
>           regs._cr3 = env->cr[3];
>           regs._cr4 = env->cr[4];
> +
> +        if( hax_global.cur_api_version >= 0x5 ) {
> +          CPUState *cs = env_cpu(env);
> +          X86CPU *x86_cpu = X86_CPU(cs);
> +          regs._cr8 = cpu_get_apic_tpr(x86_cpu->apic_state);
> +        }
> +
>           hax_set_segments(env, &regs);
>       } else {
>           env->cr[0] = regs._cr0;
>           env->cr[2] = regs._cr2;
>           env->cr[3] = regs._cr3;
>           env->cr[4] = regs._cr4;
> +
> +        //if( hax_global.cur_api_version >= 0x5 ) {
> +          //no need to update TPR from regs._cr8, since all changes are notified.
> +        //}
> +
>           hax_get_segments(env, &regs);
>       }
>   
> @@ -881,14 +894,18 @@ static int hax_get_msrs(CPUArchState *env)
>       msrs[n++].entry = MSR_IA32_SYSENTER_ESP;
>       msrs[n++].entry = MSR_IA32_SYSENTER_EIP;
>       msrs[n++].entry = MSR_IA32_TSC;
> -#ifdef TARGET_X86_64
>       msrs[n++].entry = MSR_EFER;
> +#ifdef TARGET_X86_64
>       msrs[n++].entry = MSR_STAR;
>       msrs[n++].entry = MSR_LSTAR;
>       msrs[n++].entry = MSR_CSTAR;
>       msrs[n++].entry = MSR_FMASK;
>       msrs[n++].entry = MSR_KERNELGSBASE;
>   #endif
> +    if( hax_global.cur_api_version >= 0x5 ) {
> +      msrs[n++].entry = MSR_PAT;
> +    }
> +
>       md.nr_msr = n;
>       ret = hax_sync_msr(env, &md, 0);
>       if (ret < 0) {
> @@ -909,10 +926,10 @@ static int hax_get_msrs(CPUArchState *env)
>           case MSR_IA32_TSC:
>               env->tsc = msrs[i].value;
>               break;
> -#ifdef TARGET_X86_64
>           case MSR_EFER:
>               env->efer = msrs[i].value;
>               break;
> +#ifdef TARGET_X86_64
>           case MSR_STAR:
>               env->star = msrs[i].value;
>               break;
> @@ -929,6 +946,9 @@ static int hax_get_msrs(CPUArchState *env)
>               env->kernelgsbase = msrs[i].value;
>               break;
>   #endif
> +        case MSR_PAT:
> +            env->pat = msrs[i].value;
> +            break;
>           }
>       }
>   
> @@ -947,14 +967,18 @@ static int hax_set_msrs(CPUArchState *env)
>       hax_msr_entry_set(&msrs[n++], MSR_IA32_SYSENTER_ESP, env->sysenter_esp);
>       hax_msr_entry_set(&msrs[n++], MSR_IA32_SYSENTER_EIP, env->sysenter_eip);
>       hax_msr_entry_set(&msrs[n++], MSR_IA32_TSC, env->tsc);
> -#ifdef TARGET_X86_64
>       hax_msr_entry_set(&msrs[n++], MSR_EFER, env->efer);
> +#ifdef TARGET_X86_64
>       hax_msr_entry_set(&msrs[n++], MSR_STAR, env->star);
>       hax_msr_entry_set(&msrs[n++], MSR_LSTAR, env->lstar);
>       hax_msr_entry_set(&msrs[n++], MSR_CSTAR, env->cstar);
>       hax_msr_entry_set(&msrs[n++], MSR_FMASK, env->fmask);
>       hax_msr_entry_set(&msrs[n++], MSR_KERNELGSBASE, env->kernelgsbase);
>   #endif
> +    if( hax_global.cur_api_version >= 0x5 ) {
> +      hax_msr_entry_set(&msrs[n++], MSR_PAT, env->pat);
> +    }
> +
>       md.nr_msr = n;
>       md.done = 0;
>   
> diff --git a/target/i386/hax-i386.h b/target/i386/hax-i386.h
> index 54e9d8b057..9515803184 100644
> --- a/target/i386/hax-i386.h
> +++ b/target/i386/hax-i386.h
> @@ -34,7 +34,7 @@ struct hax_vcpu_state {
>   
>   struct hax_state {
>       hax_fd fd; /* the global hax device interface */
> -    uint32_t version;
> +    uint32_t cur_api_version;
>       struct hax_vm *vm;
>       uint64_t mem_quota;
>       bool supports_64bit_ramblock;
> diff --git a/target/i386/hax-interface.h b/target/i386/hax-interface.h
> index 537ae084e9..c87aedbc2e 100644
> --- a/target/i386/hax-interface.h
> +++ b/target/i386/hax-interface.h
> @@ -218,6 +218,8 @@ struct vcpu_state_t {
>       uint32_t _activity_state;
>       uint32_t pad;
>       interruptibility_state_t _interruptibility_state;
> +
> +    uint64_t _cr8;
>   };
>   
>   /* HAX exit status */
> -- 
> 2.15.0.windows.1
>
-- 
Best Regards,
Colin Xu


