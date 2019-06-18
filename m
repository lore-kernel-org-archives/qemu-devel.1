Return-Path: <SRS0=M8fn=UR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_HK_NAME_DR,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 320DFC31E51
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 09:11:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2D62206BA
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 09:11:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2D62206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55050 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdA91-0001IB-Ae
	for qemu-devel@archiver.kernel.org; Tue, 18 Jun 2019 05:11:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48809)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1hdA63-0007XB-90
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 05:08:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hdA5x-0003gl-HY
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 05:08:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52564)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hdA5x-0003b9-6i
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 05:08:01 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E79C0550CF;
 Tue, 18 Jun 2019 09:07:57 +0000 (UTC)
Received: from work-vm (ovpn-117-76.ams2.redhat.com [10.36.117.76])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BE28482A26;
 Tue, 18 Jun 2019 09:07:55 +0000 (UTC)
Date: Tue, 18 Jun 2019 10:07:53 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Liran Alon <liran.alon@oracle.com>
Message-ID: <20190618090752.GD2850@work-vm>
References: <20190617175658.135869-1-liran.alon@oracle.com>
 <20190617175658.135869-9-liran.alon@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190617175658.135869-9-liran.alon@oracle.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Tue, 18 Jun 2019 09:07:58 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [QEMU PATCH v3 8/9] KVM: i386: Add support for
 KVM_CAP_EXCEPTION_PAYLOAD
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
Cc: ehabkost@redhat.com, kvm@vger.kernel.org, maran.wilson@oracle.com,
 mtosatti@redhat.com, qemu-devel@nongnu.org,
 Nikita Leshenko <nikita.leshchenko@oracle.com>, pbonzini@redhat.com,
 jmattson@google.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Liran Alon (liran.alon@oracle.com) wrote:
> Kernel commit c4f55198c7c2 ("kvm: x86: Introduce KVM_CAP_EXCEPTION_PAYLOAD")
> introduced a new KVM capability which allows userspace to correctly
> distinguish between pending and injected exceptions.
> 
> This distinguish is important in case of nested virtualization scenarios
> because a L2 pending exception can still be intercepted by the L1 hypervisor
> while a L2 injected exception cannot.
> 
> Furthermore, when an exception is attempted to be injected by QEMU,
> QEMU should specify the exception payload (CR2 in case of #PF or
> DR6 in case of #DB) instead of having the payload already delivered in
> the respective vCPU register. Because in case exception is injected to
> L2 guest and is intercepted by L1 hypervisor, then payload needs to be
> reported to L1 intercept (VMExit handler) while still preserving
> respective vCPU register unchanged.
> 
> This commit adds support for QEMU to properly utilise this new KVM
> capability (KVM_CAP_EXCEPTION_PAYLOAD).

Does this kvm capability become a requirement for the nested migration
then? If so, is it wired into the blockers?

Dave

> Reviewed-by: Nikita Leshenko <nikita.leshchenko@oracle.com>
> Signed-off-by: Liran Alon <liran.alon@oracle.com>
> ---
>  target/i386/cpu.c        |   6 ++-
>  target/i386/cpu.h        |   6 ++-
>  target/i386/hvf/hvf.c    |  10 ++--
>  target/i386/hvf/x86hvf.c |   4 +-
>  target/i386/kvm.c        | 101 ++++++++++++++++++++++++++++++++-------
>  target/i386/machine.c    |  84 +++++++++++++++++++++++++++++++-
>  6 files changed, 187 insertions(+), 24 deletions(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 197201087e65..a026e49f5c0d 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -4774,7 +4774,11 @@ static void x86_cpu_reset(CPUState *s)
>      memset(env->mtrr_fixed, 0, sizeof(env->mtrr_fixed));
>  
>      env->interrupt_injected = -1;
> -    env->exception_injected = -1;
> +    env->exception_nr = -1;
> +    env->exception_pending = 0;
> +    env->exception_injected = 0;
> +    env->exception_has_payload = false;
> +    env->exception_payload = 0;
>      env->nmi_injected = false;
>  #if !defined(CONFIG_USER_ONLY)
>      /* We hard-wire the BSP to the first CPU. */
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index a6bb71849869..e2ac4132972d 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -1338,10 +1338,14 @@ typedef struct CPUX86State {
>  
>      /* For KVM */
>      uint32_t mp_state;
> -    int32_t exception_injected;
> +    int32_t exception_nr;
>      int32_t interrupt_injected;
>      uint8_t soft_interrupt;
> +    uint8_t exception_pending;
> +    uint8_t exception_injected;
>      uint8_t has_error_code;
> +    uint8_t exception_has_payload;
> +    uint64_t exception_payload;
>      uint32_t ins_len;
>      uint32_t sipi_vector;
>      bool tsc_valid;
> diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
> index 2751c8125ca2..dc4bb63536c8 100644
> --- a/target/i386/hvf/hvf.c
> +++ b/target/i386/hvf/hvf.c
> @@ -605,7 +605,9 @@ static void hvf_store_events(CPUState *cpu, uint32_t ins_len, uint64_t idtvec_in
>      X86CPU *x86_cpu = X86_CPU(cpu);
>      CPUX86State *env = &x86_cpu->env;
>  
> -    env->exception_injected = -1;
> +    env->exception_nr = -1;
> +    env->exception_pending = 0;
> +    env->exception_injected = 0;
>      env->interrupt_injected = -1;
>      env->nmi_injected = false;
>      if (idtvec_info & VMCS_IDT_VEC_VALID) {
> @@ -619,7 +621,8 @@ static void hvf_store_events(CPUState *cpu, uint32_t ins_len, uint64_t idtvec_in
>              break;
>          case VMCS_IDT_VEC_HWEXCEPTION:
>          case VMCS_IDT_VEC_SWEXCEPTION:
> -            env->exception_injected = idtvec_info & VMCS_IDT_VEC_VECNUM;
> +            env->exception_nr = idtvec_info & VMCS_IDT_VEC_VECNUM;
> +            env->exception_injected = 1;
>              break;
>          case VMCS_IDT_VEC_PRIV_SWEXCEPTION:
>          default:
> @@ -912,7 +915,8 @@ int hvf_vcpu_exec(CPUState *cpu)
>              macvm_set_rip(cpu, rip + ins_len);
>              break;
>          case VMX_REASON_VMCALL:
> -            env->exception_injected = EXCP0D_GPF;
> +            env->exception_nr = EXCP0D_GPF;
> +            env->exception_injected = 1;
>              env->has_error_code = true;
>              env->error_code = 0;
>              break;
> diff --git a/target/i386/hvf/x86hvf.c b/target/i386/hvf/x86hvf.c
> index df8e946fbcde..e0ea02d631e6 100644
> --- a/target/i386/hvf/x86hvf.c
> +++ b/target/i386/hvf/x86hvf.c
> @@ -362,8 +362,8 @@ bool hvf_inject_interrupts(CPUState *cpu_state)
>      if (env->interrupt_injected != -1) {
>          vector = env->interrupt_injected;
>          intr_type = VMCS_INTR_T_SWINTR;
> -    } else if (env->exception_injected != -1) {
> -        vector = env->exception_injected;
> +    } else if (env->exception_nr != -1) {
> +        vector = env->exception_nr;
>          if (vector == EXCP03_INT3 || vector == EXCP04_INTO) {
>              intr_type = VMCS_INTR_T_SWEXCEPTION;
>          } else {
> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> index 5950c3ed0d1c..797f8ac46435 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -104,6 +104,7 @@ static uint32_t num_architectural_pmu_fixed_counters;
>  static int has_xsave;
>  static int has_xcrs;
>  static int has_pit_state2;
> +static int has_exception_payload;
>  
>  static bool has_msr_mcg_ext_ctl;
>  
> @@ -584,15 +585,56 @@ void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
>      /* Hope we are lucky for AO MCE */
>  }
>  
> +static void kvm_reset_exception(CPUX86State *env)
> +{
> +	env->exception_nr = -1;
> +	env->exception_pending = 0;
> +	env->exception_injected = 0;
> +	env->exception_has_payload = false;
> +	env->exception_payload = 0;
> +}
> +
> +static void kvm_queue_exception(CPUX86State *env,
> +                                int32_t exception_nr,
> +                                uint8_t exception_has_payload,
> +                                uint64_t exception_payload)
> +{
> +    assert(env->exception_nr == -1);
> +    assert(!env->exception_pending);
> +    assert(!env->exception_injected);
> +    assert(!env->exception_has_payload);
> +
> +    env->exception_nr = exception_nr;
> +
> +    if (has_exception_payload) {
> +        env->exception_pending = 1;
> +
> +        env->exception_has_payload = exception_has_payload;
> +        env->exception_payload = exception_payload;
> +    } else {
> +        env->exception_injected = 1;
> +
> +        if (exception_nr == EXCP01_DB) {
> +            assert(exception_has_payload);
> +            env->dr[6] = exception_payload;
> +        } else if (exception_nr == EXCP0E_PAGE) {
> +            assert(exception_has_payload);
> +            env->cr[2] = exception_payload;
> +        } else {
> +            assert(!exception_has_payload);
> +        }
> +    }
> +}
> +
>  static int kvm_inject_mce_oldstyle(X86CPU *cpu)
>  {
>      CPUX86State *env = &cpu->env;
>  
> -    if (!kvm_has_vcpu_events() && env->exception_injected == EXCP12_MCHK) {
> +    if (!kvm_has_vcpu_events() && env->exception_nr == EXCP12_MCHK) {
>          unsigned int bank, bank_num = env->mcg_cap & 0xff;
>          struct kvm_x86_mce mce;
>  
> -        env->exception_injected = -1;
> +        kvm_reset_exception(env);
>  
>          /*
>           * There must be at least one bank in use if an MCE is pending.
> @@ -1610,6 +1652,16 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>  
>      hv_vpindex_settable = kvm_check_extension(s, KVM_CAP_HYPERV_VP_INDEX);
>  
> +    has_exception_payload = kvm_check_extension(s, KVM_CAP_EXCEPTION_PAYLOAD);
> +    if (has_exception_payload) {
> +        ret = kvm_vm_enable_cap(s, KVM_CAP_EXCEPTION_PAYLOAD, 0, true);
> +        if (ret < 0) {
> +            error_report("kvm: Failed to enable exception payload cap: %s",
> +                         strerror(-ret));
> +            return ret;
> +        }
> +    }
> +
>      ret = kvm_get_supported_msrs(s);
>      if (ret < 0) {
>          return ret;
> @@ -2914,8 +2966,16 @@ static int kvm_put_vcpu_events(X86CPU *cpu, int level)
>          return 0;
>      }
>  
> -    events.exception.injected = (env->exception_injected >= 0);
> -    events.exception.nr = env->exception_injected;
> +    events.flags = 0;
> +
> +    if (has_exception_payload) {
> +        events.flags |= KVM_VCPUEVENT_VALID_PAYLOAD;
> +        events.exception.pending = env->exception_pending;
> +        events.exception_has_payload = env->exception_has_payload;
> +        events.exception_payload = env->exception_payload;
> +    }
> +    events.exception.nr = env->exception_nr;
> +    events.exception.injected = env->exception_injected;
>      events.exception.has_error_code = env->has_error_code;
>      events.exception.error_code = env->error_code;
>  
> @@ -2928,7 +2988,6 @@ static int kvm_put_vcpu_events(X86CPU *cpu, int level)
>      events.nmi.masked = !!(env->hflags2 & HF2_NMI_MASK);
>  
>      events.sipi_vector = env->sipi_vector;
> -    events.flags = 0;
>  
>      if (has_msr_smbase) {
>          events.smi.smm = !!(env->hflags & HF_SMM_MASK);
> @@ -2978,8 +3037,19 @@ static int kvm_get_vcpu_events(X86CPU *cpu)
>      if (ret < 0) {
>         return ret;
>      }
> -    env->exception_injected =
> -       events.exception.injected ? events.exception.nr : -1;
> +
> +    if (events.flags & KVM_VCPUEVENT_VALID_PAYLOAD) {
> +        env->exception_pending = events.exception.pending;
> +        env->exception_has_payload = events.exception_has_payload;
> +        env->exception_payload = events.exception_payload;
> +    } else {
> +        env->exception_pending = 0;
> +        env->exception_has_payload = false;
> +    }
> +    env->exception_injected = events.exception.injected;
> +    env->exception_nr =
> +        (env->exception_pending || env->exception_injected) ?
> +        events.exception.nr : -1;
>      env->has_error_code = events.exception.has_error_code;
>      env->error_code = events.exception.error_code;
>  
> @@ -3031,12 +3101,12 @@ static int kvm_guest_debug_workarounds(X86CPU *cpu)
>      unsigned long reinject_trap = 0;
>  
>      if (!kvm_has_vcpu_events()) {
> -        if (env->exception_injected == EXCP01_DB) {
> +        if (env->exception_nr == EXCP01_DB) {
>              reinject_trap = KVM_GUESTDBG_INJECT_DB;
>          } else if (env->exception_injected == EXCP03_INT3) {
>              reinject_trap = KVM_GUESTDBG_INJECT_BP;
>          }
> -        env->exception_injected = -1;
> +        kvm_reset_exception(env);
>      }
>  
>      /*
> @@ -3412,13 +3482,13 @@ int kvm_arch_process_async_events(CPUState *cs)
>  
>          kvm_cpu_synchronize_state(cs);
>  
> -        if (env->exception_injected == EXCP08_DBLE) {
> +        if (env->exception_nr == EXCP08_DBLE) {
>              /* this means triple fault */
>              qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
>              cs->exit_request = 1;
>              return 0;
>          }
> -        env->exception_injected = EXCP12_MCHK;
> +        kvm_queue_exception(env, EXCP12_MCHK, 0, 0);
>          env->has_error_code = 0;
>  
>          cs->halted = 0;
> @@ -3633,14 +3703,13 @@ static int kvm_handle_debug(X86CPU *cpu,
>      }
>      if (ret == 0) {
>          cpu_synchronize_state(cs);
> -        assert(env->exception_injected == -1);
> +        assert(env->exception_nr == -1);
>  
>          /* pass to guest */
> -        env->exception_injected = arch_info->exception;
> +        kvm_queue_exception(env, arch_info->exception,
> +                            arch_info->exception == EXCP01_DB,
> +                            arch_info->dr6);
>          env->has_error_code = 0;
> -        if (arch_info->exception == EXCP01_DB) {
> -            env->dr[6] = arch_info->dr6;
> -        }
>      }
>  
>      return ret;
> diff --git a/target/i386/machine.c b/target/i386/machine.c
> index 95299ebff44a..6aac0fe9cb56 100644
> --- a/target/i386/machine.c
> +++ b/target/i386/machine.c
> @@ -240,6 +240,41 @@ static int cpu_pre_save(void *opaque)
>      }
>  #endif
>  
> +    /*
> +     * When vCPU is running L2 and exception is still pending,
> +     * it can potentially be intercepted by L1 hypervisor.
> +     * In contrast to an injected exception which cannot be
> +     * intercepted anymore.
> +     *
> +     * Furthermore, when a L2 exception is intercepted by L1
> +     * hypervisor, it's exception payload (CR2/DR6 on #PF/#DB)
> +     * should not be set yet in the respective vCPU register.
> +     * Thus, in case an exception is pending, it is
> +     * important to save the exception payload seperately.
> +     *
> +     * Therefore, if an exception is not in a pending state
> +     * or vCPU is not in guest-mode, it is not important to
> +     * distinguish between a pending and injected exception
> +     * and we don't need to store seperately the exception payload.
> +     *
> +     * In order to preserve better backwards-compatabile migration,
> +     * convert a pending exception to an injected exception in
> +     * case it is not important to distingiush between them
> +     * as described above.
> +     */
> +    if (env->exception_pending && !(env->hflags & HF_GUEST_MASK)) {
> +        env->exception_pending = 0;
> +        env->exception_injected = 1;
> +
> +        if (env->exception_has_payload) {
> +            if (env->exception_nr == EXCP01_DB) {
> +                env->dr[6] = env->exception_payload;
> +            } else if (env->exception_nr == EXCP0E_PAGE) {
> +                env->cr[2] = env->exception_payload;
> +            }
> +        }
> +    }
> +
>      return 0;
>  }
>  
> @@ -297,6 +332,23 @@ static int cpu_post_load(void *opaque, int version_id)
>      }
>  #endif
>  
> +    /*
> +     * There are cases that we can get valid exception_nr with both
> +     * exception_pending and exception_injected being cleared.
> +     * This can happen in one of the following scenarios:
> +     * 1) Source is older QEMU without KVM_CAP_EXCEPTION_PAYLOAD support.
> +     * 2) Source is running on kernel without KVM_CAP_EXCEPTION_PAYLOAD support.
> +     * 3) "cpu/exception_info" subsection not sent because there is no exception
> +     *	  pending or guest wasn't running L2 (See comment in cpu_pre_save()).
> +     *
> +     * In those cases, we can just deduce that a valid exception_nr means
> +     * we can treat the exception as already injected.
> +     */
> +    if ((env->exception_nr != -1) &&
> +        !env->exception_pending && !env->exception_injected) {
> +        env->exception_injected = 1;
> +    }
> +
>      env->fpstt = (env->fpus_vmstate >> 11) & 7;
>      env->fpus = env->fpus_vmstate & ~0x3800;
>      env->fptag_vmstate ^= 0xff;
> @@ -342,6 +394,35 @@ static bool steal_time_msr_needed(void *opaque)
>      return cpu->env.steal_time_msr != 0;
>  }
>  
> +static bool exception_info_needed(void *opaque)
> +{
> +    X86CPU *cpu = opaque;
> +    CPUX86State *env = &cpu->env;
> +
> +    /*
> +     * It is important to save exception-info only in case
> +     * we need to distingiush between a pending and injected
> +     * exception. Which is only required in case there is a
> +     * pending exception and vCPU is running L2.
> +     * For more info, refer to comment in cpu_pre_save().
> +     */
> +    return (env->exception_pending && (env->hflags & HF_GUEST_MASK));
> +}
> +
> +static const VMStateDescription vmstate_exception_info = {
> +    .name = "cpu/exception_info",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .needed = exception_info_needed,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_UINT8(env.exception_pending, X86CPU),
> +        VMSTATE_UINT8(env.exception_injected, X86CPU),
> +        VMSTATE_UINT8(env.exception_has_payload, X86CPU),
> +        VMSTATE_UINT64(env.exception_payload, X86CPU),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
>  static const VMStateDescription vmstate_steal_time_msr = {
>      .name = "cpu/steal_time_msr",
>      .version_id = 1,
> @@ -1228,7 +1309,7 @@ VMStateDescription vmstate_x86_cpu = {
>          VMSTATE_INT32(env.interrupt_injected, X86CPU),
>          VMSTATE_UINT32(env.mp_state, X86CPU),
>          VMSTATE_UINT64(env.tsc, X86CPU),
> -        VMSTATE_INT32(env.exception_injected, X86CPU),
> +        VMSTATE_INT32(env.exception_nr, X86CPU),
>          VMSTATE_UINT8(env.soft_interrupt, X86CPU),
>          VMSTATE_UINT8(env.nmi_injected, X86CPU),
>          VMSTATE_UINT8(env.nmi_pending, X86CPU),
> @@ -1252,6 +1333,7 @@ VMStateDescription vmstate_x86_cpu = {
>          /* The above list is not sorted /wrt version numbers, watch out! */
>      },
>      .subsections = (const VMStateDescription*[]) {
> +        &vmstate_exception_info,
>          &vmstate_async_pf_msr,
>          &vmstate_pv_eoi_msr,
>          &vmstate_steal_time_msr,
> -- 
> 2.20.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

