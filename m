Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA339C33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 12:51:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81CE12073D
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 12:51:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WgYWYkgu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81CE12073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iooK7-0001ht-ID
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 07:51:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43366)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <beata.michalska@linaro.org>) id 1ionCJ-0004A7-LG
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 06:38:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <beata.michalska@linaro.org>) id 1ionCH-0006dC-GL
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 06:38:55 -0500
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:40955)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <beata.michalska@linaro.org>)
 id 1ionCH-0006cR-8O
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 06:38:53 -0500
Received: by mail-io1-xd43.google.com with SMTP id x1so52222127iop.7
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 03:38:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=YgOOvIHmgEAYkj1dSZ3wIToeDR4f9fqXSbINzbX1HBI=;
 b=WgYWYkguAFJ0jbmWkLzSiBwphmBzvOykcTwK/v8+xRDvORUyh/nOh1E61+0gumXTA+
 gplCfJ3bayzvLtFkv57G5rPDdH1xmTeBMq1QcVrWwtev1RF58r8rHBFtkzJgqex5z6in
 DC7+gBcO7czahJJvAVRtVVDJ1AmRktNhNOCvSaH2a4TA8pG19cEG2vHm87+QIVYyqoWW
 7VRmjPEOcm8BVAAKIUFeK4do7ySoEuhQZCrsNypALmn73ibw94PN3xqYOngZshXi6mS1
 S6uQnZRh2Pqw/KnxrwXmSdWRe0nJyIFdJSQu6uK6NJTifY6iAGxZ2RFabaZ16iDSeH8b
 IvzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=YgOOvIHmgEAYkj1dSZ3wIToeDR4f9fqXSbINzbX1HBI=;
 b=mIlLVqk0OYJkKOkrqICaMNrZApDCPfild99xtD/KzXUk6bdYYnW8CGzMddi13ztVET
 P/Qw3pQS+q7sJuKI/3tH2xGcA35APAWSCr5xdyRO2kstVKKBM5UkghOKx1wiGX/LAiug
 MEmavxqg8I0CuG3hAbu8aojFrZSXbrKXaJjLtv4jBs8r15wfjQSwCtkaZwh64v45sWyP
 I+LUPUOfpSQczuNAVyB/bxbr2sh5mqEXULiUCRLyyayfAObhNAtLOuOS/3glIsw0wkrH
 zcq5wUYu3USs3Q/0IdQMbTEc/7GFsskdO5ui1NVyTrWCNR+CjYGmzoRvk2CvJaCZ27Sl
 IDeQ==
X-Gm-Message-State: APjAAAV6Yfy4IiVxopwtWtH6iQRQboKIRHSTibCnduCjZVPsrJ70tPqI
 futC3mtA/95C0w2xjmZ9RvBntKRpjp33lo7bBIzREQ==
X-Google-Smtp-Source: APXvYqxmgTqv4na5+76QbdZmpgJW2qeWzd5x3dLuA814d/8IGvsqaf4l1hw3Tt24IDQAhnlxloSyI2xtYYAtpaaJFdU=
X-Received: by 2002:a6b:e711:: with SMTP id b17mr68948035ioh.307.1578397131795; 
 Tue, 07 Jan 2020 03:38:51 -0800 (PST)
MIME-Version: 1.0
References: <20191220202707.30641-1-beata.michalska@linaro.org>
 <20191220202707.30641-2-beata.michalska@linaro.org>
 <CAFEAcA-N=Xsnb3522mm7tT-7TOxBtJ6S_cE23XHw-4vXVVA7Xw@mail.gmail.com>
In-Reply-To: <CAFEAcA-N=Xsnb3522mm7tT-7TOxBtJ6S_cE23XHw-4vXVVA7Xw@mail.gmail.com>
From: Beata Michalska <beata.michalska@linaro.org>
Date: Tue, 7 Jan 2020 11:38:40 +0000
Message-ID: <CADSWDzv-W+=++HkeyuyixWP5uDP0A3cys9aRa7WcJ4pjB+P1yg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] target/arm: kvm: Handle DABT with no valid ISS
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d43
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Christoffer Dall <Christoffer.Dall@arm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 6 Jan 2020 at 17:15, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Fri, 20 Dec 2019 at 20:27, Beata Michalska
> <beata.michalska@linaro.org> wrote:
> >
> > On ARMv7 & ARMv8 some load/store instructions might trigger a data abort
> > exception with no valid ISS info to be decoded. The lack of decode info
> > makes it at least tricky to emulate those instruction which is one of the
> > (many) reasons why KVM will not even try to do so.
> >
> > Add suport for handling those by requesting KVM to inject external
> > dabt into the quest.
> >
> > Signed-off-by: Beata Michalska <beata.michalska@linaro.org>
> > ---
> >  accel/kvm/kvm-all.c    | 15 +++++++
> >  accel/stubs/kvm-stub.c |  4 ++
> >  include/sysemu/kvm.h   |  1 +
> >  target/arm/cpu.h       |  3 +-
> >  target/arm/kvm.c       | 95 ++++++++++++++++++++++++++++++++++++++++++
> >  target/arm/kvm32.c     |  3 ++
> >  target/arm/kvm64.c     |  3 ++
> >  target/arm/kvm_arm.h   | 19 +++++++++
> >  8 files changed, 142 insertions(+), 1 deletion(-)
> >
> > diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> > index ca00daa2f5..a3ee038142 100644
> > --- a/accel/kvm/kvm-all.c
> > +++ b/accel/kvm/kvm-all.c
> > @@ -2174,6 +2174,14 @@ static void do_kvm_cpu_synchronize_state(CPUState *cpu, run_on_cpu_data arg)
> >      }
> >  }
> >
> > +static void do_kvm_cpu_synchronize_state_force(CPUState *cpu,
> > +                                               run_on_cpu_data arg)
> > +{
> > +    kvm_arch_get_registers(cpu);
> > +    cpu->vcpu_dirty = true;
> > +}
>
> Why is this functionality special such that it needs a non-standard
> way of synchronizing state with KVM that nothing else does ?

We need the up-to-date state when handling the NISV and this is being
achieved by calling  synchronise cpu state. This will set the 'dirty' flag,
as expected. In order to get KVM to insert the external abort we need to
set vcpu events. So far so good. Still, as the cpu state is marked as 'dirty',
before entering the KVM_RUN again, Qemu will overwrite  relevant regs
-> see kvm_arch_put_registers. This messes up with  the regs
setup done by KVM when injecting the external abort. This is why we need
a sequence:
sync vcpu -> put events -> sync vcpu again
so that when entering KVM_RUN Qemu has all the updates needed.
Now, I could just set the 'dirty' flag to false and skip the regular
kvm_arch_put_registers after setting the vcpu event,
but it seemed more  sensible to have the sync version that despite the dirty
flag performs the requested sync. This is just to avoid hacky way
round the problem.
I was tempted to re-factor slightly syncing regs and events but that seemed
too invasive for this particular change. I might try to do just that though.

>
> > diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
> > index 9fe233b9bf..0cacc61d8a 100644
> > --- a/include/sysemu/kvm.h
> > +++ b/include/sysemu/kvm.h
> > @@ -483,6 +483,7 @@ void kvm_cpu_synchronize_state(CPUState *cpu);
> >  void kvm_cpu_synchronize_post_reset(CPUState *cpu);
> >  void kvm_cpu_synchronize_post_init(CPUState *cpu);
> >  void kvm_cpu_synchronize_pre_loadvm(CPUState *cpu);
> > +void kvm_cpu_synchronize_state_force(CPUState *cpu);
> >
> >  void kvm_init_cpu_signals(CPUState *cpu);
> >
> > diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> > index 5f70e9e043..e11b5e7438 100644
> > --- a/target/arm/cpu.h
> > +++ b/target/arm/cpu.h
> > @@ -558,7 +558,8 @@ typedef struct CPUARMState {
> >          uint8_t has_esr;
> >          uint64_t esr;
> >      } serror;
> > -
> > +    /* Status field for pending extarnal dabt */
>
> "external" (I think you have the same typo later in the patch too)

And I did run the codespell  ... Will blame it on Christmas rush ...
And will fix all the typos.

>
> > +    uint8_t ext_dabt_pending;
> >      /* State of our input IRQ/FIQ/VIRQ/VFIQ lines */
> >      uint32_t irq_line_state;
>
>
> > @@ -701,6 +719,11 @@ int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
> >              ret = EXCP_DEBUG;
> >          } /* otherwise return to guest */
> >          break;
> > +    case KVM_EXIT_ARM_NISV:
> > +        /* External DAB with no valid iss to decode */
>
> "DABT"
>
> > +        ret = kvm_arm_handle_dabt_nisv(cs, run->arm_nisv.esr_iss,
> > +                                 run->arm_nisv.fault_ipa);
>
> (indentation looks odd here?)

It does indeed ....
>
> > +        break;
> >      default:
> >          qemu_log_mask(LOG_UNIMP, "%s: un-handled exit reason %d\n",
> >                        __func__, run->exit_reason);
> > @@ -835,3 +858,75 @@ int kvm_arch_msi_data_to_gsi(uint32_t data)
> >  {
> >      return (data - 32) & 0xffff;
> >  }
> > +
> > +int kvm_arm_handle_dabt_nisv(CPUState *cs, uint64_t esr_iss,
> > +                              uint64_t fault_ipa)
> > +{
> > +    ARMCPU *cpu = ARM_CPU(cs);
> > +    CPUARMState *env = &cpu->env;
> > +    hwaddr xlat, len;
> > +    AddressSpace *as = cs->as ? cs->as : &address_space_memory;
>
> I don't think you should need to test cs->as for NULL;
> qemu_init_vcpu() ensures that one is always set up.
>
> Probably the neatest way to get the AddressSpace* is to
> call arm_addressspace(cs, MEMTXATTRS_UNSPECIFIED).
>
All right, will update that.
>
> > +    int store_ins = ((esr_iss >> 6) & 1); /* WnR bit */
>
> This should be a bool (matching the argument type for
> address_space_translate), so you can just do
>    bool is_write = esr_iss & (1 << 6);
>
Ditto
> > +    int ret;
> > +
> > +    /*
> > +     * Note: The ioctl for SET_EVENTS will be triggered before next
> > +     * KVM_RUN call though the vcpu regs need to be updated before hand
> > +     * so to not to overwrite changes done by KVM upon injecting the abort.
> > +     * This sadly requires running sync twice - shame ...
> > +     */
> > +    kvm_cpu_synchronize_state(cs);
> > +   /*
> > +    * ISS [23:14] is invalid so there is a limited info
> > +    * on what has just happened so the only *useful* thing that can
> > +    * be retrieved from ISS is WnR & DFSC (though in some cases WnR
> > +    * might be less of a value as well)
> > +    */
> > +    /* Verify whether the memory being accessed is even recognisable */
> > +    if (!address_space_translate(as, fault_ipa, &xlat, &len,
> > +                                 store_ins, MEMTXATTRS_UNSPECIFIED)) {
> > +        error_report("An attemp to access memory outside of the boundries"
>
> "attempt"; "boundaries". But I think what we should actually report here
> is:
>
> "Guest attempted to access memory/device at guest physical address
> 0x... using an instruction that KVM could not emulate (no valid ISS).
> Injecting a data abort exception into guest."
>
> It doesn't seem to me worth distinguishing whether the guest
> physical address happens to have anything mapped there or not;
> we're going to inject a somewhat bogus dabt anyway.
>
> After the initial error_report(), supplemental information like
> the offending instruction should be printed with error_printf(),
> because it isn't a separate new error.
>
Will fix that as well.

> > +                     "at 0x" TARGET_FMT_lx, (target_ulong) fault_ipa);
> > +    } else {
> > +        uint32_t ins;
> > +        uint8_t ins_fetched;
> > +
> > +        /*
> > +         * Get current PC before it will get updated to except vector entry
>
> "exception"
>
> > +         */
> > +        target_ulong ins_addr = is_a64(env) ? env->pc
> > +                                /* AArch32 mode vs T32 aka Thumb mode */
> > +                                : env->regs[15] - (env->thumb ? 4 : 8);
> > +
> > +        /*
> > +         * Get the faulting instruction
> > +         * Instructions have a fixed length of 32 bits
> > +         * and are always little-endian
>
> ...unless they're 16-bit Thumb. In an ideal world you should handle
> the Thumb case by doing a 16-bit load, and then loading another 16-bit
> value if the top 3 bits of the first part are 0b111.
>
Sigh, I have completely missed that (ashamed)

> At least we don't have to consider the possibility ofold-style
> really-big-endian-instruction-ordering :-)
>
> > +         */
> > +        ins_fetched = !cpu_memory_rw_debug(cs, ins_addr, (uint8_t *) &ins,
> > +                                           sizeof(uint32_t), store_ins) ;
>
> stray space before semicolon
>
> > +
> > +        error_report("Data abort exception with no valid ISS generated by "
> > +                     "memory access at 0x" TARGET_FMT_lx,
> > +                     (target_ulong)fault_ipa);
> > +        error_report(ins_fetched ? "%s: 0x%" PRIx32 " (encoded)" : "%s",
> > +                     "Unable to emulate memory instruction",
> > +                     (!ins_fetched ? 0 : ldl_le_p(&ins)));
> > +
> > +        error_report("Faulting instruction at 0x" TARGET_FMT_lx, ins_addr);
> > +    }
> > +    /*
> > +     * Set pending ext dabt amd trigger SET_EVENTS so that
> > +     * KVM can inject the abort
> > +     */
> > +    env->ext_dabt_pending = 1;
> > +
> > +    ret = kvm_put_vcpu_events(cpu);
> > +
> > +    /* Get the most up-tp-date state */
>
> "to"
>
> > +    if (!ret) {
> > +        /* Hacky but the sync needs to be forced */
> > +        kvm_cpu_synchronize_state_force(cs);
> > +    }
> > +    return ret;
> > +}
> > diff --git a/target/arm/kvm32.c b/target/arm/kvm32.c
> > index 32bf8d6757..5539c3a3f2 100644
> > --- a/target/arm/kvm32.c
> > +++ b/target/arm/kvm32.c
> > @@ -240,6 +240,9 @@ int kvm_arch_init_vcpu(CPUState *cs)
> >      /* Check whether userspace can specify guest syndrome value */
> >      kvm_arm_init_serror_injection(cs);
> >
> > +    /* Set status for supporting the extarnal dabt injection */
> > +    kvm_arm_init_ext_dabt_injection(cs);
> > +
> >      return kvm_arm_init_cpreg_list(cpu);
> >  }
> >
> > diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
> > index 876184b8fe..3da4e2e70e 100644
> > --- a/target/arm/kvm64.c
> > +++ b/target/arm/kvm64.c
> > @@ -792,6 +792,9 @@ int kvm_arch_init_vcpu(CPUState *cs)
> >      /* Check whether user space can specify guest syndrome value */
> >      kvm_arm_init_serror_injection(cs);
> >
> > +    /* Set status for supporting the extarnal dabt injection */
> > +    kvm_arm_init_ext_dabt_injection(cs);
> > +
> >      return kvm_arm_init_cpreg_list(cpu);
> >  }
>

Thanks for reviewing!

BR
Beata
> thanks
> -- PMM

