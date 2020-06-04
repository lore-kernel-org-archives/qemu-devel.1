Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C40CC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 09:54:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D5AA206DC
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 09:54:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D5AA206DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgmZz-0003yv-D1
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 05:54:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58812)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1jgmZR-0003YZ-OJ
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 05:53:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:56024)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1jgmZQ-0005sr-Kp
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 05:53:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 1DFDCABE2;
 Thu,  4 Jun 2020 09:53:58 +0000 (UTC)
Subject: Re: [PATCH 02/13] i386: hvf: Drop useless declarations in sysemu
To: Roman Bolshakov <r.bolshakov@yadro.com>, qemu-devel@nongnu.org
References: <20200528193758.51454-1-r.bolshakov@yadro.com>
 <20200528193758.51454-3-r.bolshakov@yadro.com>
From: Claudio Fontana <cfontana@suse.de>
Message-ID: <04c723c8-9d7d-ef93-f45c-4a7dd99b5a8d@suse.de>
Date: Thu, 4 Jun 2020 11:53:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200528193758.51454-3-r.bolshakov@yadro.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=195.135.220.15; envelope-from=cfontana@suse.de;
 helo=mx2.suse.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 00:26:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Cameron Esfahani <dirty@apple.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/28/20 9:37 PM, Roman Bolshakov wrote:
> They're either declared elsewhere or have no use.
> 
> While at it, rename _hvf_cpu_synchronize_post_init() to
> do_hvf_cpu_synchronize_post_init().
> 
> Signed-off-by: Roman Bolshakov <r.bolshakov@yadro.com>
> ---
>  include/sysemu/hvf.h  | 22 ----------------------
>  target/i386/hvf/hvf.c |  7 ++++---
>  2 files changed, 4 insertions(+), 25 deletions(-)
> 
> diff --git a/include/sysemu/hvf.h b/include/sysemu/hvf.h
> index 30a565ab73..03f3cd7db3 100644
> --- a/include/sysemu/hvf.h
> +++ b/include/sysemu/hvf.h
> @@ -30,35 +30,13 @@ uint32_t hvf_get_supported_cpuid(uint32_t func, uint32_t idx,
>  #define hvf_get_supported_cpuid(func, idx, reg) 0
>  #endif
>  
> -/* Disable HVF if |disable| is 1, otherwise, enable it iff it is supported by
> - * the host CPU. Use hvf_enabled() after this to get the result. */
> -void hvf_disable(int disable);
> -
> -/* Returns non-0 if the host CPU supports the VMX "unrestricted guest" feature
> - * which allows the virtual CPU to directly run in "real mode". If true, this
> - * allows QEMU to run several vCPU threads in parallel (see cpus.c). Otherwise,
> - * only a a single TCG thread can run, and it will call HVF to run the current
> - * instructions, except in case of "real mode" (paging disabled, typically at
> - * boot time), or MMIO operations. */
> -
> -int hvf_sync_vcpus(void);
> -
>  int hvf_init_vcpu(CPUState *);
>  int hvf_vcpu_exec(CPUState *);
> -int hvf_smp_cpu_exec(CPUState *);
>  void hvf_cpu_synchronize_state(CPUState *);
>  void hvf_cpu_synchronize_post_reset(CPUState *);
>  void hvf_cpu_synchronize_post_init(CPUState *);
> -void _hvf_cpu_synchronize_post_init(CPUState *, run_on_cpu_data);
> -
>  void hvf_vcpu_destroy(CPUState *);
> -void hvf_raise_event(CPUState *);
> -/* void hvf_reset_vcpu_state(void *opaque); */
>  void hvf_reset_vcpu(CPUState *);
> -void vmx_update_tpr(CPUState *);
> -void update_apic_tpr(CPUState *);
> -int hvf_put_registers(CPUState *);
> -void vmx_clear_int_window_exiting(CPUState *cpu);
>  
>  #define TYPE_HVF_ACCEL ACCEL_CLASS_NAME("hvf")
>  
> diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
> index d72543dc31..9ccdb7e7c7 100644
> --- a/target/i386/hvf/hvf.c
> +++ b/target/i386/hvf/hvf.c
> @@ -251,7 +251,7 @@ void vmx_update_tpr(CPUState *cpu)
>      }
>  }
>  
> -void update_apic_tpr(CPUState *cpu)
> +static void update_apic_tpr(CPUState *cpu)
>  {
>      X86CPU *x86_cpu = X86_CPU(cpu);
>      int tpr = rreg(cpu->hvf_fd, HV_X86_TPR) >> 4;
> @@ -312,7 +312,8 @@ void hvf_cpu_synchronize_post_reset(CPUState *cpu_state)
>      run_on_cpu(cpu_state, do_hvf_cpu_synchronize_post_reset, RUN_ON_CPU_NULL);
>  }
>  
> -void _hvf_cpu_synchronize_post_init(CPUState *cpu, run_on_cpu_data arg)
> +static void do_hvf_cpu_synchronize_post_init(CPUState *cpu,
> +                                             run_on_cpu_data arg)
>  {
>      CPUState *cpu_state = cpu;
>      hvf_put_registers(cpu_state);
> @@ -321,7 +322,7 @@ void _hvf_cpu_synchronize_post_init(CPUState *cpu, run_on_cpu_data arg)
>  
>  void hvf_cpu_synchronize_post_init(CPUState *cpu_state)
>  {
> -    run_on_cpu(cpu_state, _hvf_cpu_synchronize_post_init, RUN_ON_CPU_NULL);
> +    run_on_cpu(cpu_state, do_hvf_cpu_synchronize_post_init, RUN_ON_CPU_NULL);
>  }
>  
>  static bool ept_emulation_fault(hvf_slot *slot, uint64_t gpa, uint64_t ept_qual)
> 

in this file (hvf.c) there is a comment:

/* TODO: synchronize vcpu state */

is the TODO still valid after this change? Or should the TODO be eliminated?

Thanks,

Claudio

