Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B6B3C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 22:44:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3423F207E8
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 22:44:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jwKTGkot"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3423F207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlKK7-00028v-HN
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 18:44:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48282)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <beata.michalska@linaro.org>)
 id 1jlKJW-0001ix-9B
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 18:44:18 -0400
Received: from mail-il1-x141.google.com ([2607:f8b0:4864:20::141]:38986)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <beata.michalska@linaro.org>)
 id 1jlKJU-000229-6f
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 18:44:17 -0400
Received: by mail-il1-x141.google.com with SMTP id p5so209054ile.6
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 15:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=rj7RCWU2TEDQylXlKwtIkp9D//dlG4LaBf/aiSxKiVc=;
 b=jwKTGkot7wWAsWfAevCa7n4oDDIULZWG6+IvhL/aBsSUfd8xoi1CHHiQjNLbPy6Nds
 JzjmjeLcF8+swR/XLC2A3jG0dcBSOPUzA2ZwIsmx3x6s8DiGcQMI8MaOvbKuOhGL3iYy
 0KumbVWOS0jshNewOy9vw25TKxRiETG0JjFw98aGQ3JcK+pWrrCyV8NDVg0fVI2Nfhg2
 nGkdogLmLckeWxseHoQIjJdjZeGFa3Ks2awf3XLJTLM3lizA3GGFWi+FkkaZY+b6Tkan
 xb734VFuz1YHqZpeU8IIPlD0OLN3yShVm8rLkPK2IudZOBAZ8XBOyvbGyz8qrXKvRRrz
 YUFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=rj7RCWU2TEDQylXlKwtIkp9D//dlG4LaBf/aiSxKiVc=;
 b=T00KUS53eFKCcO1H5BKuRGUHbsZz2/IzsHnokL7tyhBMGtlSQtngmsQEi62Edxk/P9
 n4xwJtbCjK8axpmMk33Pk7ZIyzalmi3XxNnDzu/692rP546xGgLym5DXpxd7MkZrnFJS
 oTgBO+yuSVh5BQeTP+s8rLroyUSSbBzkQjQWEwcwTloSrHOqV9X2CAOCAIL7uzWCdbe3
 kJ0jh3sWQCo1TzDtqtkICurGr7OTHCrjH+D5a45nHwbhc7gRvAKRUYAGKuNeN+isE3Pb
 HbX98W8nUvT/A+ThXEbehmj3UZVpOlnzDoi17nO3z8nVSAZiDaPjRjWZ6SfORKypp+k3
 gnug==
X-Gm-Message-State: AOAM5331XfTJplUDdD/xU/dDquvM5U4aY7t3C6aa7IbocPkq6pTlFyI9
 0COr93JRVUR4AkoYRf2ERUYlWlviPdP6KGP7D7tQNw==
X-Google-Smtp-Source: ABdhPJyHSf6KGlyZm3i8Rr//oem1gemzV8CkuAY8ysTcBDzQxMk28uTJD2ZJioCvlncaZT55iRuz0w3yi9d26EBUClw=
X-Received: by 2002:a05:6e02:11a5:: with SMTP id
 5mr5677396ilj.108.1592347454432; 
 Tue, 16 Jun 2020 15:44:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200529112757.32235-1-beata.michalska@linaro.org>
 <20200529112757.32235-2-beata.michalska@linaro.org>
 <20200616083337.yfgc4cyad4ipaqb7@kamzik.brq.redhat.com>
In-Reply-To: <20200616083337.yfgc4cyad4ipaqb7@kamzik.brq.redhat.com>
From: Beata Michalska <beata.michalska@linaro.org>
Date: Tue, 16 Jun 2020 23:44:03 +0100
Message-ID: <CADSWDzvGSPkLgjafEg2j0oUMhj0gVEOiiB5PCusJKZHqMRV14g@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] target/arm: kvm: Handle DABT with no valid ISS
To: Andrew Jones <drjones@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::141;
 envelope-from=beata.michalska@linaro.org; helo=mail-il1-x141.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Christoffer Dall <Christoffer.Dall@arm.com>, qemu-arm <qemu-arm@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, kvmarm@lists.cs.columbia.edu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Andrew,

Thanks for the feedback.

On Tue, 16 Jun 2020 at 09:33, Andrew Jones <drjones@redhat.com> wrote:
>
> Hi Beata,
>
> I see Peter just picked this up, so I'm a bit late getting to it. I do
> have a couple comments below though.
>
> Thanks,
> drew
>
> On Fri, May 29, 2020 at 12:27:56PM +0100, Beata Michalska wrote:
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
> >  target/arm/kvm.c     | 64 +++++++++++++++++++++++++++++++++++++++++++++++++++-
> >  target/arm/kvm_arm.h | 11 +++++++++
> >  3 files changed, 76 insertions(+), 1 deletion(-)
> >
> > diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> > index 677584e..3702f21 100644
> > --- a/target/arm/cpu.h
> > +++ b/target/arm/cpu.h
> > @@ -570,6 +570,8 @@ typedef struct CPUARMState {
> >          uint64_t esr;
> >      } serror;
> >
> > +    uint8_t ext_dabt_pending; /* Request for injecting ext DABT */
> > +
> >      /* State of our input IRQ/FIQ/VIRQ/VFIQ lines */
> >      uint32_t irq_line_state;
> >
> > diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> > index 4bdbe6d..bf84224 100644
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
> > +            error_report("Failed to enable KVM_CAP_ARM_NISV_TO_USER cap");
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
> > @@ -819,7 +837,12 @@ int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
> >              ret = EXCP_DEBUG;
> >          } /* otherwise return to guest */
> >          break;
> > -    default:
> > +    case KVM_EXIT_ARM_NISV:
> > +        /* External DABT with no valid iss to decode */
> > +        ret = kvm_arm_handle_dabt_nisv(cs, run->arm_nisv.esr_iss,
> > +                                       run->arm_nisv.fault_ipa);
> > +        break;
> > +     default:
> >          qemu_log_mask(LOG_UNIMP, "%s: un-handled exit reason %d\n",
> >                        __func__, run->exit_reason);
> >          break;
> > @@ -955,3 +978,42 @@ int kvm_arch_msi_data_to_gsi(uint32_t data)
> >  {
> >      return (data - 32) & 0xffff;
> >  }
> > +
> > +int kvm_arm_handle_dabt_nisv(CPUState *cs, uint64_t esr_iss,
> > +                             uint64_t fault_ipa)
>
> This function could be static since it's in the same file as its one
> and only caller.
>
Right. Will do.

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
> > +     * Request KVM to inject the external data abort into the guest
> > +     * by setting a pending exception on the affected vcpu.
> > +     */
> > +    if (cap_has_inject_ext_dabt) {
> > +        /* Set pending exception */
> > +        env->ext_dabt_pending = 1;
> > +        /*
> > +         * Even though at this point, the vcpu regs are out of sync,
> > +         * directly calling the KVM_SET_VCPU_EVENTS ioctl without
> > +         * explicitly synchronizing those, is enough and it also avoids
> > +         * overwriting changes done by KVM.
> > +         * The vcpu is not being marked as 'dirty' as all the changes
> > +         * needed to inject the abort are being handled by KVM only
> > +         * and there is no need for syncing either way
> > +         */
> > +        return kvm_put_vcpu_events(cpu);
>
> This looks fragile. What if we change kvm_put_vcpu_events() in a way
> that requires CPU synchronization? Or, what if we change something else
> that results in the VCPU getting flagged as dirty before finishing this
> run loop, and then we end up calling kvm_put_vcpu_events() twice, possibly
> causing some other problem?
>
> I think I'd prefer seeing the KVM_SET_VCPU_EVENTS ioctl get called
> directly from here with the events set to only inject the dabt, as we
> know that will be handled immediately and doesn't require any CPU
> synchronization.
>
It might be 'fragile' though I would expect any  changes to kvm_put_vcpu_events
revisit all users, but I have no objections to calling ioctl directly
here if that's
the prefered way.

Will try to push the changes sometime later this week.

Thanks again for the review.

BR
Beata

> Thanks,
> drew
>
> > +    } else {
> > +        error_report("Data abort exception triggered by guest memory access "
> > +                     "at physical address: 0x"  TARGET_FMT_lx,
> > +                     (target_ulong)fault_ipa);
> > +        error_printf("KVM unable to emulate faulting instruction.\n");
> > +        return -1;
> > +    }
> > +}
> > diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
> > index 48bf5e1..e939e51 100644
> > --- a/target/arm/kvm_arm.h
> > +++ b/target/arm/kvm_arm.h
> > @@ -453,6 +453,17 @@ struct kvm_guest_debug_arch;
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
> > +                            uint64_t fault_ipa);
> > +/**
> >   * its_class_name:
> >   *
> >   * Return the ITS class name to use depending on whether KVM acceleration
> > --
> > 2.7.4
> >
> >
>

