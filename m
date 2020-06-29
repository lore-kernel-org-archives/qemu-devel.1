Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4673C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 11:56:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADC0F23D20
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 11:56:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Tei1JmJF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADC0F23D20
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpsOR-00038e-UD
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 07:56:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57072)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <beata.michalska@linaro.org>)
 id 1jpsNS-0001DU-Dh
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 07:55:10 -0400
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42]:41848)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <beata.michalska@linaro.org>)
 id 1jpsNQ-0007K0-7J
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 07:55:10 -0400
Received: by mail-io1-xd42.google.com with SMTP id o5so16761543iow.8
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2020 04:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=fEJFWBnpsD1Fzxq+UGFqbCNX3W+nZoqUk4DjhMHNxrc=;
 b=Tei1JmJFXM/uRL0vORJ6QdAtj+XiwqDwDInAPjjzy7erYQ2SGnDGFUqn8USuLbD/9R
 7EBZpHhfgdWUVBAR9BUeL7X+iRwSUbefOJRulJ3qKPH5DMqLCuJQjJ0ebLuvK0BDzvIC
 l6nKSIfU+smq3AMIOrjooYCcUCqhhZZbWS8CHQm0gpGp8SxNDSJcCDud1EVYjy772IC8
 PQ1D7fxPecfDC8J7XR8iS/sXTtqly3B9Aj+cGiQyyhtJfZ/1ZVgveKK5YdACUeuZz9Ps
 OFavMcU1tdlU17aJKgLQ28fYiM6N2TFL+4ZYQ8kl137rrszFZ4xTDiBisLVD+Pybhmlt
 fLeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fEJFWBnpsD1Fzxq+UGFqbCNX3W+nZoqUk4DjhMHNxrc=;
 b=JYnaiZ7fe+j1p+4elogIXzXcb09y0GSb5Qvduu8T0WLNG3+nAedQzHWKsnNVF6Q3op
 pttBB3hyMNU9EokSZBeJXUC1YojoayfCRm+cRXwSxbP+mCwm668d5q0LB7Ed+NDNX67Q
 YAvjZw8sl8OjcX0InxKwljTE6NhqlchLW0TMgvu9+bl0gjHoSf/+LNCvh/iblfgeKYOu
 z/8T9IfKPMXgTdxZ1Tg/9rKyene/9JlmYb2d+VTI3IpJ/euCs8RkLuWV0Hl9YK4DOq8Z
 Kzzbv2ev6NH7bLJa01XXT5DpOMPldVkKPp97oTb7LYGrp18SmuJT8AvtYqXKgJ5Zn3Xa
 PXjA==
X-Gm-Message-State: AOAM53301wH27swzwSmkQ6Qicw+StC9pGEiC3EZAQNnjkPyaXgZU2sC1
 D30EFs0qWMghvD3jZB/1vkw4mPNH1yx9WxoLyXRCYg==
X-Google-Smtp-Source: ABdhPJxFiRnOqZiR0JV6/Tck6vbv5sducHrJs2fK7Ug0C0z5E5z3rdeB5b5cpHQ1cqIsbnujm4ZIsDmbLRgcUGhgm9s=
X-Received: by 2002:a5d:849a:: with SMTP id t26mr16661198iom.22.1593431706751; 
 Mon, 29 Jun 2020 04:55:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200628150459.18566-1-beata.michalska@linaro.org>
 <20200628150459.18566-2-beata.michalska@linaro.org>
 <20200629081510.ochvmmmikhe62bsm@kamzik.brq.redhat.com>
In-Reply-To: <20200629081510.ochvmmmikhe62bsm@kamzik.brq.redhat.com>
From: Beata Michalska <beata.michalska@linaro.org>
Date: Mon, 29 Jun 2020 12:54:55 +0100
Message-ID: <CADSWDzvdX6iDgd8YuZ3aGnz6qDzjzs7=a7A0MB2k4KAcRG6s9Q@mail.gmail.com>
Subject: Re: [PATCH v8 1/2] target/arm: kvm: Handle DABT with no valid ISS
To: Andrew Jones <drjones@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d42;
 envelope-from=beata.michalska@linaro.org; helo=mail-io1-xd42.google.com
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

On Mon, 29 Jun 2020 at 09:15, Andrew Jones <drjones@redhat.com> wrote:
>
> On Sun, Jun 28, 2020 at 04:04:58PM +0100, Beata Michalska wrote:
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
> >  target/arm/kvm.c | 57 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 56 insertions(+), 1 deletion(-)
> >
> > diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> > index eef3bbd..2dd8a9a 100644
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
> > @@ -245,6 +246,16 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
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
> > @@ -810,6 +821,45 @@ void kvm_arm_vm_state_change(void *opaque, int running, RunState state)
> >      }
> >  }
> >
> > +/**
> > + * kvm_arm_handle_dabt_nisv:
> > + * @cs: CPUState
> > + * @esr_iss: ISS encoding (limited) for the exception from Data Abort
> > + *           ISV bit set to '0b0' -> no valid instruction syndrome
> > + * @fault_ipa: faulting address for the synchronous data abort
> > + *
> > + * Returns: 0 if the exception has been handled, < 0 otherwise
> > + */
> > +static int kvm_arm_handle_dabt_nisv(CPUState *cs, uint64_t esr_iss,
> > +                             uint64_t fault_ipa)
>
> The indent of 'uint64_t fault_ipa' is off. Should be under CPUState.
>
> > +{
> > +    /*
> > +     * Request KVM to inject the external data abort into the guest
> > +     */
> > +    if (cap_has_inject_ext_dabt) {
> > +        struct kvm_vcpu_events events = { };
> > +        /*
> > +         * The external data abort event will be handled immediately by KVM
> > +         * using the address fault that triggered the exit on given VCPU.
> > +         * Requesting injection of the external data abort does not rely
> > +         * on any other VCPU state. Therefore, in this particular case, the VCPU
> > +         * synchronization can be exceptionally skipped.
> > +         */
> > +        events.exception.ext_dabt_pending = 1;
> > +        /*
> > +         * KVM_CAP_ARM_INJECT_EXT_DABT implies KVM_CAP_VCPU_EVENTS
> > +         */
>
> Single line comments may be done with /* ... */
>
> > +        return kvm_vcpu_ioctl(cs, KVM_SET_VCPU_EVENTS, &events);
> > +
>
> Extra blank line here.
>
> > +    } else {
> > +        error_report("Data abort exception triggered by guest memory access "
> > +                     "at physical address: 0x"  TARGET_FMT_lx,
> > +                     (target_ulong)fault_ipa);
> > +        error_printf("KVM unable to emulate faulting instruction.\n");
> > +    }
> > +    return -1;
> > +}
> > +
> >  int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
> >  {
> >      int ret = 0;
> > @@ -820,7 +870,12 @@ int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
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
>
> An extra space got added in front of 'default:'
>
> >          qemu_log_mask(LOG_UNIMP, "%s: un-handled exit reason %d\n",
> >                        __func__, run->exit_reason);
> >          break;
> > --
> > 2.7.4
> >
> >
>
> Besides the format changes
>
> Reviewed-by: Andrew Jones <drjones@redhat.com>
>
Done.
Thanks a lot for the reviews!

BR
Beata

