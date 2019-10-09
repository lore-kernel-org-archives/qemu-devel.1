Return-Path: <SRS0=qKtL=YC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69BBBC47404
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 20:09:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 224E7206B6
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 20:09:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 224E7206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIIHP-00018u-Qi
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 16:09:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58775)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iIFM9-0004Ys-T6
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 13:02:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iIFM7-0000lT-Ea
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 13:02:33 -0400
Received: from 7.mo2.mail-out.ovh.net ([188.165.48.182]:52867)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iIFM7-0000kw-5E
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 13:02:31 -0400
Received: from player731.ha.ovh.net (unknown [10.108.54.230])
 by mo2.mail-out.ovh.net (Postfix) with ESMTP id A780E1AEE71
 for <qemu-devel@nongnu.org>; Wed,  9 Oct 2019 19:02:28 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player731.ha.ovh.net (Postfix) with ESMTPSA id DC2E2A9677C0;
 Wed,  9 Oct 2019 17:02:16 +0000 (UTC)
Date: Wed, 9 Oct 2019 19:02:15 +0200
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v4 17/19] spapr: Remove last pieces of SpaprIrq
Message-ID: <20191009190215.7e05c017@bahia.lan>
In-Reply-To: <20191009060818.29719-18-david@gibson.dropbear.id.au>
References: <20191009060818.29719-1-david@gibson.dropbear.id.au>
 <20191009060818.29719-18-david@gibson.dropbear.id.au>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 1343198588955957734
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedriedugdekhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 188.165.48.182
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
Cc: Jason Wang <jasowang@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>, qemu-ppc@nongnu.org,
 clg@kaod.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed,  9 Oct 2019 17:08:16 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> The only thing remaining in this structure are the flags to allow either
> XICS or XIVE to be present.  These actually make more sense as spapr
> capabilities - that way they can take advantage of the existing
> infrastructure to sanity check capability states across migration and so
> forth.
> 

The user can now choose the interrupt controller mode either through
ic-mode or through cap-xics/cap-xive. I guess it doesn't break anything
to expose another API to do the same thing but it raises some questions.

We should at least document somewhere that ic-mode is an alias to these
caps, and maybe state which is the preferred method (I personally vote
for the caps).

Also, we must keep ic-mode for the moment to stay compatible with the
existing pseries-4.0 and pseries-4.1 machine types, but will we
keep ic-mode forever ? If no, maybe start by not allowing it for
pseries-4.2 ?

> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  hw/ppc/spapr.c             | 40 ++++++++++--------
>  hw/ppc/spapr_caps.c        | 64 +++++++++++++++++++++++++++++
>  hw/ppc/spapr_hcall.c       |  7 ++--
>  hw/ppc/spapr_irq.c         | 84 ++------------------------------------
>  include/hw/ppc/spapr.h     | 10 +++--
>  include/hw/ppc/spapr_irq.h | 10 -----
>  6 files changed, 103 insertions(+), 112 deletions(-)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index e1ff03152e..bf9fdb1693 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1072,12 +1072,13 @@ static void spapr_dt_ov5_platform_support(SpaprMachineState *spapr, void *fdt,
>          26, 0x40, /* Radix options: GTSE == yes. */
>      };
>  
> -    if (spapr->irq->xics && spapr->irq->xive) {
> +    if (spapr_get_cap(spapr, SPAPR_CAP_XICS)
> +        && spapr_get_cap(spapr, SPAPR_CAP_XIVE)) {
>          val[1] = SPAPR_OV5_XIVE_BOTH;
> -    } else if (spapr->irq->xive) {
> +    } else if (spapr_get_cap(spapr, SPAPR_CAP_XIVE)) {
>          val[1] = SPAPR_OV5_XIVE_EXPLOIT;
>      } else {
> -        assert(spapr->irq->xics);
> +        assert(spapr_get_cap(spapr, SPAPR_CAP_XICS));
>          val[1] = SPAPR_OV5_XIVE_LEGACY;
>      }
>  
> @@ -2075,6 +2076,8 @@ static const VMStateDescription vmstate_spapr = {
>          &vmstate_spapr_dtb,
>          &vmstate_spapr_cap_large_decr,
>          &vmstate_spapr_cap_ccf_assist,
> +        &vmstate_spapr_cap_xics,
> +        &vmstate_spapr_cap_xive,
>          NULL
>      }
>  };
> @@ -2775,7 +2778,7 @@ static void spapr_machine_init(MachineState *machine)
>      spapr_ovec_set(spapr->ov5, OV5_DRMEM_V2);
>  
>      /* advertise XIVE on POWER9 machines */
> -    if (spapr->irq->xive) {
> +    if (spapr_get_cap(spapr, SPAPR_CAP_XIVE)) {
>          spapr_ovec_set(spapr->ov5, OV5_XIVE_EXPLOIT);
>      }
>  
> @@ -3242,14 +3245,18 @@ static void spapr_set_vsmt(Object *obj, Visitor *v, const char *name,
>  static char *spapr_get_ic_mode(Object *obj, Error **errp)
>  {
>      SpaprMachineState *spapr = SPAPR_MACHINE(obj);
> +    SpaprMachineClass *smc = SPAPR_MACHINE_GET_CLASS(spapr);
>  
> -    if (spapr->irq == &spapr_irq_xics_legacy) {
> +    if (smc->legacy_irq_allocation) {
>          return g_strdup("legacy");
> -    } else if (spapr->irq == &spapr_irq_xics) {
> +    } else if (spapr_get_cap(spapr, SPAPR_CAP_XICS)
> +               && !spapr_get_cap(spapr, SPAPR_CAP_XIVE)) {
>          return g_strdup("xics");
> -    } else if (spapr->irq == &spapr_irq_xive) {
> +    } else if (!spapr_get_cap(spapr, SPAPR_CAP_XICS)
> +               && spapr_get_cap(spapr, SPAPR_CAP_XIVE)) {
>          return g_strdup("xive");
> -    } else if (spapr->irq == &spapr_irq_dual) {
> +    } else if (spapr_get_cap(spapr, SPAPR_CAP_XICS)
> +               && spapr_get_cap(spapr, SPAPR_CAP_XIVE)) {
>          return g_strdup("dual");
>      }
>      g_assert_not_reached();
> @@ -3266,11 +3273,14 @@ static void spapr_set_ic_mode(Object *obj, const char *value, Error **errp)
>  
>      /* The legacy IRQ backend can not be set */
>      if (strcmp(value, "xics") == 0) {
> -        spapr->irq = &spapr_irq_xics;
> +        object_property_set_bool(obj, true, "cap-xics", errp);
> +        object_property_set_bool(obj, false, "cap-xive", errp);
>      } else if (strcmp(value, "xive") == 0) {
> -        spapr->irq = &spapr_irq_xive;
> +        object_property_set_bool(obj, false, "cap-xics", errp);
> +        object_property_set_bool(obj, true, "cap-xive", errp);
>      } else if (strcmp(value, "dual") == 0) {
> -        spapr->irq = &spapr_irq_dual;
> +        object_property_set_bool(obj, true, "cap-xics", errp);
> +        object_property_set_bool(obj, true, "cap-xive", errp);
>      } else {
>          error_setg(errp, "Bad value for \"ic-mode\" property");
>      }
> @@ -3309,7 +3319,6 @@ static void spapr_set_host_serial(Object *obj, const char *value, Error **errp)
>  static void spapr_instance_init(Object *obj)
>  {
>      SpaprMachineState *spapr = SPAPR_MACHINE(obj);
> -    SpaprMachineClass *smc = SPAPR_MACHINE_GET_CLASS(spapr);
>  
>      spapr->htab_fd = -1;
>      spapr->use_hotplug_event_source = true;
> @@ -3345,7 +3354,6 @@ static void spapr_instance_init(Object *obj)
>                               spapr_get_msix_emulation, NULL, NULL);
>  
>      /* The machine class defines the default interrupt controller mode */
> -    spapr->irq = smc->irq;
>      object_property_add_str(obj, "ic-mode", spapr_get_ic_mode,
>                              spapr_set_ic_mode, NULL);
>      object_property_set_description(obj, "ic-mode",
> @@ -4439,8 +4447,9 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
>      smc->default_caps.caps[SPAPR_CAP_NESTED_KVM_HV] = SPAPR_CAP_OFF;
>      smc->default_caps.caps[SPAPR_CAP_LARGE_DECREMENTER] = SPAPR_CAP_ON;
>      smc->default_caps.caps[SPAPR_CAP_CCF_ASSIST] = SPAPR_CAP_OFF;
> +    smc->default_caps.caps[SPAPR_CAP_XICS] = SPAPR_CAP_ON;
> +    smc->default_caps.caps[SPAPR_CAP_XIVE] = SPAPR_CAP_ON;
>      spapr_caps_add_properties(smc, &error_abort);
> -    smc->irq = &spapr_irq_dual;
>      smc->dr_phb_enabled = true;
>      smc->linux_pci_probe = true;
>      smc->nr_xirqs = SPAPR_NR_XIRQS;
> @@ -4539,7 +4548,7 @@ static void spapr_machine_4_0_class_options(MachineClass *mc)
>      spapr_machine_4_1_class_options(mc);
>      compat_props_add(mc->compat_props, hw_compat_4_0, hw_compat_4_0_len);
>      smc->phb_placement = phb_placement_4_0;
> -    smc->irq = &spapr_irq_xics;
> +    smc->default_caps.caps[SPAPR_CAP_XIVE] = SPAPR_CAP_OFF;
>      smc->pre_4_1_migration = true;
>  }
>  
> @@ -4580,7 +4589,6 @@ static void spapr_machine_3_0_class_options(MachineClass *mc)
>  
>      smc->legacy_irq_allocation = true;
>      smc->nr_xirqs = 0x400;
> -    smc->irq = &spapr_irq_xics_legacy;
>  }
>  
>  DEFINE_SPAPR_MACHINE(3_0, "3.0", false);
> diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
> index 481dfd2a27..e06fd386f6 100644
> --- a/hw/ppc/spapr_caps.c
> +++ b/hw/ppc/spapr_caps.c
> @@ -496,6 +496,42 @@ static void cap_ccf_assist_apply(SpaprMachineState *spapr, uint8_t val,
>      }
>  }
>  
> +static void cap_xics_apply(SpaprMachineState *spapr, uint8_t val, Error **errp)
> +{
> +    SpaprMachineClass *smc = SPAPR_MACHINE_GET_CLASS(spapr);
> +
> +    if (!val) {
> +        if (!spapr_get_cap(spapr, SPAPR_CAP_XIVE)) {
> +            error_setg(errp,
> +"No interrupt controllers enabled, try cap-xics=on or cap-xive=on");
> +            return;
> +        }
> +
> +        if (smc->legacy_irq_allocation) {
> +            error_setg(errp, "This machine version requires XICS support");
> +            return;
> +        }
> +    }
> +}
> +
> +static void cap_xive_apply(SpaprMachineState *spapr, uint8_t val, Error **errp)
> +{
> +    SpaprMachineClass *smc = SPAPR_MACHINE_GET_CLASS(spapr);
> +    PowerPCCPU *cpu = POWERPC_CPU(first_cpu);
> +
> +    if (val) {
> +        if (smc->legacy_irq_allocation) {
> +            error_setg(errp, "This machine version cannot support XIVE");
> +            return;
> +        }
> +        if (!ppc_check_compat(cpu, CPU_POWERPC_LOGICAL_3_00, 0,
> +                              spapr->max_compat_pvr)) {
> +            error_setg(errp, "XIVE requires POWER9 CPU");
> +            return;
> +        }
> +    }
> +}
> +
>  SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
>      [SPAPR_CAP_HTM] = {
>          .name = "htm",
> @@ -595,6 +631,24 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
>          .type = "bool",
>          .apply = cap_ccf_assist_apply,
>      },
> +    [SPAPR_CAP_XICS] = {
> +        .name = "xics",
> +        .description = "Allow XICS interrupt controller",
> +        .index = SPAPR_CAP_XICS,
> +        .get = spapr_cap_get_bool,
> +        .set = spapr_cap_set_bool,
> +        .type = "bool",
> +        .apply = cap_xics_apply,
> +    },
> +    [SPAPR_CAP_XIVE] = {
> +        .name = "xive",
> +        .description = "Allow XIVE interrupt controller",
> +        .index = SPAPR_CAP_XIVE,
> +        .get = spapr_cap_get_bool,
> +        .set = spapr_cap_set_bool,
> +        .type = "bool",
> +        .apply = cap_xive_apply,
> +    },
>  };
>  
>  static SpaprCapabilities default_caps_with_cpu(SpaprMachineState *spapr,
> @@ -641,6 +695,14 @@ static SpaprCapabilities default_caps_with_cpu(SpaprMachineState *spapr,
>          caps.caps[SPAPR_CAP_HPT_MAXPAGESIZE] = mps;
>      }
>  
> +    /*
> +     * POWER8 machines don't have XIVE
> +     */
> +    if (!ppc_type_check_compat(cputype, CPU_POWERPC_LOGICAL_3_00,
> +                               0, spapr->max_compat_pvr)) {
> +        caps.caps[SPAPR_CAP_XIVE] = SPAPR_CAP_OFF;
> +    }
> +
>      return caps;
>  }
>  
> @@ -734,6 +796,8 @@ SPAPR_CAP_MIG_STATE(hpt_maxpagesize, SPAPR_CAP_HPT_MAXPAGESIZE);
>  SPAPR_CAP_MIG_STATE(nested_kvm_hv, SPAPR_CAP_NESTED_KVM_HV);
>  SPAPR_CAP_MIG_STATE(large_decr, SPAPR_CAP_LARGE_DECREMENTER);
>  SPAPR_CAP_MIG_STATE(ccf_assist, SPAPR_CAP_CCF_ASSIST);
> +SPAPR_CAP_MIG_STATE(xics, SPAPR_CAP_XICS);
> +SPAPR_CAP_MIG_STATE(xive, SPAPR_CAP_XIVE);
>  
>  void spapr_caps_init(SpaprMachineState *spapr)
>  {
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index 140f05c1c6..cb4c6edf63 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -1784,13 +1784,13 @@ static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
>       * terminate the boot.
>       */
>      if (guest_xive) {
> -        if (!spapr->irq->xive) {
> +        if (!spapr_get_cap(spapr, SPAPR_CAP_XIVE)) {
>              error_report(
>  "Guest requested unavailable interrupt mode (XIVE), try the ic-mode=xive or ic-mode=dual machine property");
>              exit(EXIT_FAILURE);
>          }
>      } else {
> -        if (!spapr->irq->xics) {
> +        if (!spapr_get_cap(spapr, SPAPR_CAP_XICS)) {
>              error_report(
>  "Guest requested unavailable interrupt mode (XICS), either don't set the ic-mode machine property or try ic-mode=xics or ic-mode=dual");
>              exit(EXIT_FAILURE);
> @@ -1804,7 +1804,8 @@ static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
>       */
>      if (!spapr->cas_reboot) {
>          spapr->cas_reboot = spapr_ovec_test(ov5_updates, OV5_XIVE_EXPLOIT)
> -            && spapr->irq->xics && spapr->irq->xive;
> +            && spapr_get_cap(spapr, SPAPR_CAP_XICS)
> +            && spapr_get_cap(spapr, SPAPR_CAP_XIVE);
>      }
>  
>      spapr_ovec_cleanup(ov5_updates);
> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> index 2768f9a765..473fc8780a 100644
> --- a/hw/ppc/spapr_irq.c
> +++ b/hw/ppc/spapr_irq.c
> @@ -101,90 +101,19 @@ int spapr_irq_init_kvm(int (*fn)(SpaprInterruptController *, Error **),
>      return 0;
>  }
>  
> -/*
> - * XICS IRQ backend.
> - */
> -
> -SpaprIrq spapr_irq_xics = {
> -    .xics        = true,
> -    .xive        = false,
> -};
> -
> -/*
> - * XIVE IRQ backend.
> - */
> -
> -SpaprIrq spapr_irq_xive = {
> -    .xics        = false,
> -    .xive        = true,
> -};
> -
> -/*
> - * Dual XIVE and XICS IRQ backend.
> - *
> - * Both interrupt mode, XIVE and XICS, objects are created but the
> - * machine starts in legacy interrupt mode (XICS). It can be changed
> - * by the CAS negotiation process and, in that case, the new mode is
> - * activated after an extra machine reset.
> - */
> -
> -/*
> - * Define values in sync with the XIVE and XICS backend
> - */
> -SpaprIrq spapr_irq_dual = {
> -    .xics        = true,
> -    .xive        = true,
> -};
> -
> -
>  static int spapr_irq_check(SpaprMachineState *spapr, Error **errp)
>  {
>      MachineState *machine = MACHINE(spapr);
>  
> -    /*
> -     * Sanity checks on non-P9 machines. On these, XIVE is not
> -     * advertised, see spapr_dt_ov5_platform_support()
> -     */
> -    if (!ppc_type_check_compat(machine->cpu_type, CPU_POWERPC_LOGICAL_3_00,
> -                               0, spapr->max_compat_pvr)) {
> -        /*
> -         * If the 'dual' interrupt mode is selected, force XICS as CAS
> -         * negotiation is useless.
> -         */
> -        if (spapr->irq == &spapr_irq_dual) {
> -            spapr->irq = &spapr_irq_xics;
> -            return 0;
> -        }
> -
> -        /*
> -         * Non-P9 machines using only XIVE is a bogus setup. We have two
> -         * scenarios to take into account because of the compat mode:
> -         *
> -         * 1. POWER7/8 machines should fail to init later on when creating
> -         *    the XIVE interrupt presenters because a POWER9 exception
> -         *    model is required.
> -
> -         * 2. POWER9 machines using the POWER8 compat mode won't fail and
> -         *    will let the OS boot with a partial XIVE setup : DT
> -         *    properties but no hcalls.
> -         *
> -         * To cover both and not confuse the OS, add an early failure in
> -         * QEMU.
> -         */
> -        if (spapr->irq == &spapr_irq_xive) {
> -            error_setg(errp, "XIVE-only machines require a POWER9 CPU");
> -            return -1;
> -        }
> -    }
> -
>      /*
>       * On a POWER9 host, some older KVM XICS devices cannot be destroyed and
>       * re-created. Detect that early to avoid QEMU to exit later when the
>       * guest reboots.
>       */
>      if (kvm_enabled() &&
> -        spapr->irq == &spapr_irq_dual &&
>          machine_kernel_irqchip_required(machine) &&
> +        spapr_get_cap(spapr, SPAPR_CAP_XICS) &&
> +        spapr_get_cap(spapr, SPAPR_CAP_XIVE) &&
>          xics_kvm_has_broken_disconnect(spapr)) {
>          error_setg(errp, "KVM is too old to support ic-mode=dual,kernel-irqchip=on");
>          return -1;
> @@ -280,7 +209,7 @@ void spapr_irq_init(SpaprMachineState *spapr, Error **errp)
>      /* Initialize the MSI IRQ allocator. */
>      spapr_irq_msi_init(spapr);
>  
> -    if (spapr->irq->xics) {
> +    if (spapr_get_cap(spapr, SPAPR_CAP_XICS)) {
>          Error *local_err = NULL;
>          Object *obj;
>  
> @@ -313,7 +242,7 @@ void spapr_irq_init(SpaprMachineState *spapr, Error **errp)
>          spapr->ics = ICS_SPAPR(obj);
>      }
>  
> -    if (spapr->irq->xive) {
> +    if (spapr_get_cap(spapr, SPAPR_CAP_XIVE)) {
>          uint32_t nr_servers = spapr_max_server_number(spapr);
>          DeviceState *dev;
>          int i;
> @@ -558,11 +487,6 @@ int spapr_irq_find(SpaprMachineState *spapr, int num, bool align, Error **errp)
>      return first + ics->offset;
>  }
>  
> -SpaprIrq spapr_irq_xics_legacy = {
> -    .xics        = true,
> -    .xive        = false,
> -};
> -
>  static void spapr_irq_register_types(void)
>  {
>      type_register_static(&spapr_intc_info);
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 623e8e3f93..d3b4dd7de3 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -79,8 +79,12 @@ typedef enum {
>  #define SPAPR_CAP_LARGE_DECREMENTER     0x08
>  /* Count Cache Flush Assist HW Instruction */
>  #define SPAPR_CAP_CCF_ASSIST            0x09
> +/* XICS interrupt controller */
> +#define SPAPR_CAP_XICS                  0x0a
> +/* XIVE interrupt controller */
> +#define SPAPR_CAP_XIVE                  0x0b
>  /* Num Caps */
> -#define SPAPR_CAP_NUM                   (SPAPR_CAP_CCF_ASSIST + 1)
> +#define SPAPR_CAP_NUM                   (SPAPR_CAP_XIVE + 1)
>  
>  /*
>   * Capability Values
> @@ -131,7 +135,6 @@ struct SpaprMachineClass {
>                            hwaddr *nv2atsd, Error **errp);
>      SpaprResizeHpt resize_hpt_default;
>      SpaprCapabilities default_caps;
> -    SpaprIrq *irq;
>  };
>  
>  /**
> @@ -195,7 +198,6 @@ struct SpaprMachineState {
>  
>      int32_t irq_map_nr;
>      unsigned long *irq_map;
> -    SpaprIrq *irq;
>      qemu_irq *qirqs;
>      SpaprInterruptController *active_intc;
>      ICSState *ics;
> @@ -870,6 +872,8 @@ extern const VMStateDescription vmstate_spapr_cap_hpt_maxpagesize;
>  extern const VMStateDescription vmstate_spapr_cap_nested_kvm_hv;
>  extern const VMStateDescription vmstate_spapr_cap_large_decr;
>  extern const VMStateDescription vmstate_spapr_cap_ccf_assist;
> +extern const VMStateDescription vmstate_spapr_cap_xics;
> +extern const VMStateDescription vmstate_spapr_cap_xive;
>  
>  static inline uint8_t spapr_get_cap(SpaprMachineState *spapr, int cap)
>  {
> diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
> index 5e150a6679..71aee13743 100644
> --- a/include/hw/ppc/spapr_irq.h
> +++ b/include/hw/ppc/spapr_irq.h
> @@ -77,16 +77,6 @@ int spapr_irq_msi_alloc(SpaprMachineState *spapr, uint32_t num, bool align,
>                          Error **errp);
>  void spapr_irq_msi_free(SpaprMachineState *spapr, int irq, uint32_t num);
>  
> -typedef struct SpaprIrq {
> -    bool        xics;
> -    bool        xive;
> -} SpaprIrq;
> -
> -extern SpaprIrq spapr_irq_xics;
> -extern SpaprIrq spapr_irq_xics_legacy;
> -extern SpaprIrq spapr_irq_xive;
> -extern SpaprIrq spapr_irq_dual;
> -
>  void spapr_irq_init(SpaprMachineState *spapr, Error **errp);
>  int spapr_irq_claim(SpaprMachineState *spapr, int irq, bool lsi, Error **errp);
>  void spapr_irq_free(SpaprMachineState *spapr, int irq, int num);


