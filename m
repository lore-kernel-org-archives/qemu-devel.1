Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47000C1975A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 15:16:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F2472076A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 15:16:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J11jbYhc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F2472076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH7lM-0003j7-0E
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 11:16:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41315)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <beata.michalska@linaro.org>) id 1jH7kY-0002xE-Lq
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 11:15:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <beata.michalska@linaro.org>) id 1jH7kW-0007Yw-Lg
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 11:15:22 -0400
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42]:33294)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <beata.michalska@linaro.org>)
 id 1jH7kW-0007Vy-DT
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 11:15:20 -0400
Received: by mail-io1-xd42.google.com with SMTP id o127so2614791iof.0
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2020 08:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=f/nHfhqolLq9DAlvAPV5hSMp5M2cRTZ5m4aLtZbOM8s=;
 b=J11jbYhcH8sxlSp+x21Pqjk5+VPDMUjGAYfVtnYu3o3RC0TjQX8zi3QIYaaIr8S7kH
 D00oZSFQjRO7/BfJ646aizaA+2/vDXVfnxyMkKI+/N3c6RvuW4PPGLn/3YA4NFzpr5Zq
 u9ticRNE+WCfBtatOB+Kx6JLY1IE9dOdHm3GSIEm/cFaQkb2tpV+DgBNlqowWcsq5pKQ
 bCGxSf0w4RaydLePY6VPWRywD6Pa2Jtnilcbe5YAeSfaXcyeXzFvFZv+8oRxrdW82W2a
 J0XA1zlqurqgsCk3yjiE5CY8nBr0CGGPvy8yJrInPmMlUiccgDgByOnjadZUrKMu+3Mv
 DhVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=f/nHfhqolLq9DAlvAPV5hSMp5M2cRTZ5m4aLtZbOM8s=;
 b=qKAU6QNFJ5PFMtWGDw/dRm62WfJbwYwwB9sEDPogFVVGTvuYbs5MNDM5+28yBvhFtX
 kkIe3itG3cDn93m3xIRI33lca+wsFKTzt+qQxNPWL/sBcFAMYbuRfooCXshlOYT/MwBT
 xRl4PHYAOa1YxOJ6BZm//koawSemjvF0tf/pkmYjvJOk50gpLivRpKITcBa4AikgMMm5
 IjnymjjMp9KANT5S9lyLHKAGxbS0yLqjpo3pR28Vx5EiAZJWNsBkiDwKdkMTK5dZ0MTp
 ALfVxQ8Acy1detkx7cSfuwH/TIBJy/ZKw44ymcSOvzb+24oT4PlQmpEND//3otaoy3/d
 UcDA==
X-Gm-Message-State: ANhLgQ3lYJkenrKbdz7vr7YMe+0x3OD9eU/lGjZlI9C20kXSCJRGs/te
 x594eZqkRnbdT89xXHYkP5F0mDm3h3KOwooSw3XCsg==
X-Google-Smtp-Source: ADFU+vtGkefyEPNZu1kccV3WqAr8fY1zL3k8ApBQ+YFOAgIsLdyKoYg3Xb5HqXWhcgAOrETpgTzpHNpuSmbuXVx+0Q8=
X-Received: by 2002:a6b:b212:: with SMTP id b18mr3384277iof.117.1585149319068; 
 Wed, 25 Mar 2020 08:15:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200323113227.3169-1-beata.michalska@linaro.org>
 <20200323113227.3169-2-beata.michalska@linaro.org>
 <20200323124405.xdv56zplli23sl46@kamzik.brq.redhat.com>
In-Reply-To: <20200323124405.xdv56zplli23sl46@kamzik.brq.redhat.com>
From: Beata Michalska <beata.michalska@linaro.org>
Date: Wed, 25 Mar 2020 15:15:07 +0000
Message-ID: <CADSWDzt7SL3bBYdm5a7CTzsHJbuo4GbewxaTQOkbfsUmSYFzZA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] target/arm: kvm: Handle DABT with no valid ISS
To: Andrew Jones <drjones@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d42
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Christoffer Dall <Christoffer.Dall@arm.com>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, kvmarm@lists.cs.columbia.edu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

On Mon, 23 Mar 2020 at 12:44, Andrew Jones <drjones@redhat.com> wrote:
>
> On Mon, Mar 23, 2020 at 11:32:26AM +0000, Beata Michalska wrote:
> > On ARMv7 & ARMv8 some load/store instructions might trigger a data abort
> > exception with no valid ISS info to be decoded. The lack of decode info
> > makes it at least tricky to emulate those instruction which is one of the
> > (many) reasons why KVM will not even try to do so.
> >
> > Add support for handling those by requesting KVM to inject external
> > dabt into the quest.
> >
> > Signed-off-by: Beata Michalska <beata.michalska@linaro.org>
> > ---
> >  target/arm/cpu.h     |  2 ++
> >  target/arm/kvm.c     | 54 ++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  target/arm/kvm_arm.h | 11 +++++++++++
> >  3 files changed, 67 insertions(+)
> >
> > diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> > index 4ffd991..4f834c1 100644
> > --- a/target/arm/cpu.h
> > +++ b/target/arm/cpu.h
> > @@ -560,6 +560,8 @@ typedef struct CPUARMState {
> >          uint64_t esr;
> >      } serror;
> >
> > +    uint8_t ext_dabt_pending; /* Request for injecting ext DABT */
> > +
> >      /* State of our input IRQ/FIQ/VIRQ/VFIQ lines */
> >      uint32_t irq_line_state;
> >
> > diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> > index 85860e6..c088589 100644
> > --- a/target/arm/kvm.c
> > +++ b/target/arm/kvm.c
> > @@ -39,6 +39,7 @@ const KVMCapabilityInfo kvm_arch_required_capabilities[] = {
> >
> >  static bool cap_has_mp_state;
> >  static bool cap_has_inject_serror_esr;
> > +static bool cap_has_inject_ext_dabt;
> >
> >  static ARMHostCPUFeatures arm_host_cpu_features;
> >
> > @@ -244,6 +245,16 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
> >          ret = -EINVAL;
> >      }
> >
> > +    if (kvm_check_extension(s, KVM_CAP_ARM_NISV_TO_USER)) {
> > +        if (kvm_vm_enable_cap(s, KVM_CAP_ARM_NISV_TO_USER, 0)) {
> > +            warn_report("Failed to enable DABT NISV cap");
>
> Shouldn't this be an error? If KVM says it has KVM_CAP_ARM_NISV_TO_USER,
> then I think it should always work to enable it, unless userspace passes
> the wrong flags. Currently flags must be zero, but if they were to change
> then we'll need to add the flags to vmstate and fail migration when they
> aren't compatible, and I guess that failure would occur here.
>
That's a fair point. From the kernel point of view this one is pretty
straightforward,
so it should not fail. I haven't used the error here as the lack of
this cap is not really
critical for guest but indeed it might be worth to have it here .

> > +        } else {
> > +            /* Set status for supporting the external dabt injection */
> > +            cap_has_inject_ext_dabt = kvm_check_extension(s,
> > +                                    KVM_CAP_ARM_INJECT_EXT_DABT);
> > +        }
> > +    }
> > +
> >      return ret;
> >  }
> >
> > @@ -703,9 +714,16 @@ int kvm_put_vcpu_events(ARMCPU *cpu)
> >          events.exception.serror_esr = env->serror.esr;
> >      }
> >
> > +    if (cap_has_inject_ext_dabt) {
> > +        events.exception.ext_dabt_pending = env->ext_dabt_pending;
> > +    }
> > +
> >      ret = kvm_vcpu_ioctl(CPU(cpu), KVM_SET_VCPU_EVENTS, &events);
> >      if (ret) {
> >          error_report("failed to put vcpu events");
> > +    } else {
> > +        /* Clear instantly if the call was successful */
> > +        env->ext_dabt_pending = 0;
> >      }
> >
> >      return ret;
> > @@ -819,6 +837,11 @@ int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
> >              ret = EXCP_DEBUG;
> >          } /* otherwise return to guest */
> >          break;
> > +    case KVM_EXIT_ARM_NISV:
> > +        /* External DABT with no valid iss to decode */
> > +        ret = kvm_arm_handle_dabt_nisv(cs, run->arm_nisv.esr_iss,
> > +                                       run->arm_nisv.fault_ipa);
> > +        break;
> >      default:
> >          qemu_log_mask(LOG_UNIMP, "%s: un-handled exit reason %d\n",
> >                        __func__, run->exit_reason);
> > @@ -953,3 +976,34 @@ int kvm_arch_msi_data_to_gsi(uint32_t data)
> >  {
> >      return (data - 32) & 0xffff;
> >  }
> > +
> > +int kvm_arm_handle_dabt_nisv(CPUState *cs, uint64_t esr_iss,
> > +                             uint64_t fault_ipa)
> > +{
> > +    ARMCPU *cpu = ARM_CPU(cs);
> > +    CPUARMState *env = &cpu->env;
> > +
> > +   /*
> > +    * ISS [23:14] is invalid so there is a limited info
> > +    * on what has just happened so the only *useful* thing that can
> > +    * be retrieved from ISS is WnR & DFSC (though in some cases WnR
> > +    * might be less of a value as well)
> > +    */
> > +
> > +    /*
> > +     * Set pending ext dabt and trigger SET_EVENTS so that
> > +     * KVM can inject the abort
> > +     */
> > +    if (cap_has_inject_ext_dabt) {
> > +        kvm_cpu_synchronize_state(cs);
>
> I guess this is just an expensive 'vcpu_dirty=true', which the comment
> above justifies, but not super clearly. Can you try to clarify the
> comment some more?  I also wonder if we shouldn't add a KVM function
> that just marks a vcpu dirty, rather than fetching all registers.
>
I can definitely adjust the comments here to explain the case more
clearly. And I would definitely vote for moving the flag
setting/clearing outside the
sync so that it can be triggered separately without involving all the series
of potentially unnecessary ioctls. WIll draft that in the next iteration.

Thanks
Beata


> > +        env->ext_dabt_pending = 1;
> > +    } else {
> > +        error_report("Data abort exception triggered by guest memory access "
> > +                     "at physical address: 0x"  TARGET_FMT_lx,
> > +                     (target_ulong)fault_ipa);
> > +        error_printf("KVM unable to emulate faulting instruction.\n");
> > +        return -1;
> > +    }
> > +
> > +    return 0;
> > +}
> > diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
> > index ae9e075..39472d5 100644
> > --- a/target/arm/kvm_arm.h
> > +++ b/target/arm/kvm_arm.h
> > @@ -450,6 +450,17 @@ struct kvm_guest_debug_arch;
> >  void kvm_arm_copy_hw_debug_data(struct kvm_guest_debug_arch *ptr);
> >
> >  /**
> > + * kvm_arm_handle_dabt_nisv:
> > + * @cs: CPUState
> > + * @esr_iss: ISS encoding (limited) for the exception from Data Abort
> > + *           ISV bit set to '0b0' -> no valid instruction syndrome
> > + * @fault_ipa: faulting address for the synch data abort
> > + *
> > + * Returns: 0 if the exception has been handled, < 0 otherwise
> > + */
> > +int kvm_arm_handle_dabt_nisv(CPUState *cs, uint64_t esr_iss,
> > +                             uint64_t fault_ipa);
> > +/**
> >   * its_class_name:
> >   *
> >   * Return the ITS class name to use depending on whether KVM acceleration
> > --
> > 2.7.4
> >
>
> Thanks,
> drew
>

