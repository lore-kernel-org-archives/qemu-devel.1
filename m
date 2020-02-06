Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FD00C35247
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 23:33:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21BF020838
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 23:33:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21BF020838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=invisible.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izqei-0007Ot-At
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 18:33:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58488)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jmcneill@invisible.ca>) id 1izoMk-0002dm-M5
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 16:07:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jmcneill@invisible.ca>) id 1izoMj-0001pV-9I
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 16:07:14 -0500
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:35079)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jmcneill@invisible.ca>)
 id 1izoMi-0001hv-L9
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 16:07:13 -0500
X-Originating-IP: 159.2.138.7
Received: from performa.invisible.ca
 (stjhnbsu6iw-159-2-138-7.dhcp-dynamic.fibreop.nb.bellaliant.net
 [159.2.138.7]) (Authenticated sender: jmcneill@invisible.ca)
 by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id CEA5E240004;
 Thu,  6 Feb 2020 21:07:07 +0000 (UTC)
Date: Thu, 6 Feb 2020 17:07:05 -0400 (AST)
From: Jared McNeill <jmcneill@invisible.ca>
To: Kamil Rytarowski <n54@gmx.com>
Subject: Re: [PATCH v3 4/4] Add the NVMM acceleration enlightenments
In-Reply-To: <20200206115731.13552-5-n54@gmx.com>
Message-ID: <alpine.NEB.2.21.2002061706590.671@performa.invisible.ca>
References: <20200128140945.929-1-n54@gmx.com>
 <20200206115731.13552-1-n54@gmx.com> <20200206115731.13552-5-n54@gmx.com>
User-Agent: Alpine 2.21 (NEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-545032645-1581023230=:671"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 217.70.183.193
X-Mailman-Approved-At: Thu, 06 Feb 2020 18:31:32 -0500
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
Cc: peter.maydell@linaro.org, ehabkost@redhat.com, slp@redhat.com,
 Kamil Rytarowski <krytarowski@gmail.com>, qemu-devel@nongnu.org,
 pbonzini@redhat.com, philmd@redhat.com, max@m00nbsd.net, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-545032645-1581023230=:671
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

Tested-by: Jared McNeill <jmcneill@invisible.ca>

On Thu, 6 Feb 2020, Kamil Rytarowski wrote:

> From: Maxime Villard <max@m00nbsd.net>
>
> Implements the NVMM accelerator cpu enlightenments to actually use the nvmm-all
> accelerator on NetBSD platforms.
>
> Signed-off-by: Maxime Villard <max@m00nbsd.net>
> Signed-off-by: Kamil Rytarowski <n54@gmx.com>
> Reviewed-by: Sergio Lopez <slp@redhat.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
> cpus.c                    | 58 +++++++++++++++++++++++++++++++++++++++
> include/sysemu/hw_accel.h | 14 ++++++++++
> target/i386/helper.c      |  2 +-
> 3 files changed, 73 insertions(+), 1 deletion(-)
>
> diff --git a/cpus.c b/cpus.c
> index b4f8b84b61..f833da4a60 100644
> --- a/cpus.c
> +++ b/cpus.c
> @@ -42,6 +42,7 @@
> #include "sysemu/hax.h"
> #include "sysemu/hvf.h"
> #include "sysemu/whpx.h"
> +#include "sysemu/nvmm.h"
> #include "exec/exec-all.h"
>
> #include "qemu/thread.h"
> @@ -1670,6 +1671,48 @@ static void *qemu_whpx_cpu_thread_fn(void *arg)
>     return NULL;
> }
>
> +static void *qemu_nvmm_cpu_thread_fn(void *arg)
> +{
> +    CPUState *cpu = arg;
> +    int r;
> +
> +    assert(nvmm_enabled());
> +
> +    rcu_register_thread();
> +
> +    qemu_mutex_lock_iothread();
> +    qemu_thread_get_self(cpu->thread);
> +    cpu->thread_id = qemu_get_thread_id();
> +    current_cpu = cpu;
> +
> +    r = nvmm_init_vcpu(cpu);
> +    if (r < 0) {
> +        fprintf(stderr, "nvmm_init_vcpu failed: %s\n", strerror(-r));
> +        exit(1);
> +    }
> +
> +    /* signal CPU creation */
> +    cpu->created = true;
> +    qemu_cond_signal(&qemu_cpu_cond);
> +
> +    do {
> +        if (cpu_can_run(cpu)) {
> +            r = nvmm_vcpu_exec(cpu);
> +            if (r == EXCP_DEBUG) {
> +                cpu_handle_guest_debug(cpu);
> +            }
> +        }
> +        qemu_wait_io_event(cpu);
> +    } while (!cpu->unplug || cpu_can_run(cpu));
> +
> +    nvmm_destroy_vcpu(cpu);
> +    cpu->created = false;
> +    qemu_cond_signal(&qemu_cpu_cond);
> +    qemu_mutex_unlock_iothread();
> +    rcu_unregister_thread();
> +    return NULL;
> +}
> +
> #ifdef _WIN32
> static void CALLBACK dummy_apc_func(ULONG_PTR unused)
> {
> @@ -2038,6 +2081,19 @@ static void qemu_whpx_start_vcpu(CPUState *cpu)
> #endif
> }
>
> +static void qemu_nvmm_start_vcpu(CPUState *cpu)
> +{
> +    char thread_name[VCPU_THREAD_NAME_SIZE];
> +
> +    cpu->thread = g_malloc0(sizeof(QemuThread));
> +    cpu->halt_cond = g_malloc0(sizeof(QemuCond));
> +    qemu_cond_init(cpu->halt_cond);
> +    snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/NVMM",
> +             cpu->cpu_index);
> +    qemu_thread_create(cpu->thread, thread_name, qemu_nvmm_cpu_thread_fn,
> +                       cpu, QEMU_THREAD_JOINABLE);
> +}
> +
> static void qemu_dummy_start_vcpu(CPUState *cpu)
> {
>     char thread_name[VCPU_THREAD_NAME_SIZE];
> @@ -2078,6 +2134,8 @@ void qemu_init_vcpu(CPUState *cpu)
>         qemu_tcg_init_vcpu(cpu);
>     } else if (whpx_enabled()) {
>         qemu_whpx_start_vcpu(cpu);
> +    } else if (nvmm_enabled()) {
> +        qemu_nvmm_start_vcpu(cpu);
>     } else {
>         qemu_dummy_start_vcpu(cpu);
>     }
> diff --git a/include/sysemu/hw_accel.h b/include/sysemu/hw_accel.h
> index 0ec2372477..dbfa7a02f9 100644
> --- a/include/sysemu/hw_accel.h
> +++ b/include/sysemu/hw_accel.h
> @@ -15,6 +15,7 @@
> #include "sysemu/hax.h"
> #include "sysemu/kvm.h"
> #include "sysemu/whpx.h"
> +#include "sysemu/nvmm.h"
>
> static inline void cpu_synchronize_state(CPUState *cpu)
> {
> @@ -27,6 +28,9 @@ static inline void cpu_synchronize_state(CPUState *cpu)
>     if (whpx_enabled()) {
>         whpx_cpu_synchronize_state(cpu);
>     }
> +    if (nvmm_enabled()) {
> +        nvmm_cpu_synchronize_state(cpu);
> +    }
> }
>
> static inline void cpu_synchronize_post_reset(CPUState *cpu)
> @@ -40,6 +44,10 @@ static inline void cpu_synchronize_post_reset(CPUState *cpu)
>     if (whpx_enabled()) {
>         whpx_cpu_synchronize_post_reset(cpu);
>     }
> +    if (nvmm_enabled()) {
> +        nvmm_cpu_synchronize_post_reset(cpu);
> +    }
> +
> }
>
> static inline void cpu_synchronize_post_init(CPUState *cpu)
> @@ -53,6 +61,9 @@ static inline void cpu_synchronize_post_init(CPUState *cpu)
>     if (whpx_enabled()) {
>         whpx_cpu_synchronize_post_init(cpu);
>     }
> +    if (nvmm_enabled()) {
> +        nvmm_cpu_synchronize_post_init(cpu);
> +    }
> }
>
> static inline void cpu_synchronize_pre_loadvm(CPUState *cpu)
> @@ -66,6 +77,9 @@ static inline void cpu_synchronize_pre_loadvm(CPUState *cpu)
>     if (whpx_enabled()) {
>         whpx_cpu_synchronize_pre_loadvm(cpu);
>     }
> +    if (nvmm_enabled()) {
> +        nvmm_cpu_synchronize_pre_loadvm(cpu);
> +    }
> }
>
> #endif /* QEMU_HW_ACCEL_H */
> diff --git a/target/i386/helper.c b/target/i386/helper.c
> index c3a6e4fabe..2e79d61329 100644
> --- a/target/i386/helper.c
> +++ b/target/i386/helper.c
> @@ -981,7 +981,7 @@ void cpu_report_tpr_access(CPUX86State *env, TPRAccess access)
>     X86CPU *cpu = env_archcpu(env);
>     CPUState *cs = env_cpu(env);
>
> -    if (kvm_enabled() || whpx_enabled()) {
> +    if (kvm_enabled() || whpx_enabled() || nvmm_enabled()) {
>         env->tpr_access_type = access;
>
>         cpu_interrupt(cs, CPU_INTERRUPT_TPR);
> --
> 2.25.0
>
>
--0-545032645-1581023230=:671--

