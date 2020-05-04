Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLACK,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9300C47258
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 11:32:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 908CF2073E
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 11:32:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 908CF2073E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVZL8-0006NZ-QU
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 07:32:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48982)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jVZJ7-0004fq-Ta
 for qemu-devel@nongnu.org; Mon, 04 May 2020 07:30:46 -0400
Received: from 5.mo69.mail-out.ovh.net ([46.105.43.105]:54153)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jVZJ4-0000nC-VO
 for qemu-devel@nongnu.org; Mon, 04 May 2020 07:30:45 -0400
Received: from player761.ha.ovh.net (unknown [10.108.35.124])
 by mo69.mail-out.ovh.net (Postfix) with ESMTP id 325C58D931
 for <qemu-devel@nongnu.org>; Mon,  4 May 2020 13:30:40 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player761.ha.ovh.net (Postfix) with ESMTPSA id E3C4D1201243F;
 Mon,  4 May 2020 11:30:29 +0000 (UTC)
Date: Mon, 4 May 2020 13:30:27 +0200
From: Greg Kurz <groug@kaod.org>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH qemu] spapr: Add PVR setting capability
Message-ID: <20200504133027.4f5a18f8@bahia.lan>
In-Reply-To: <20200417041105.63563-1-aik@ozlabs.ru>
References: <20200417041105.63563-1-aik@ozlabs.ru>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 18221282617894738421
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrjeeggdefkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgfgsehtjeertdertddvnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeehkefhtdehgeehheejledufeekhfdvleefvdeihefhkefhudffhfeuuedvffdthfenucfkpheptddrtddrtddrtddpkedvrddvheefrddvtdekrddvgeeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeeiuddrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
Received-SPF: pass client-ip=46.105.43.105; envelope-from=groug@kaod.org;
 helo=5.mo69.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 07:30:41
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 17 Apr 2020 14:11:05 +1000
Alexey Kardashevskiy <aik@ozlabs.ru> wrote:

> At the moment the VCPU init sequence includes setting PVR which in case of
> KVM-HV only checks if it matches the hardware PVR mask as PVR cannot be
> virtualized by the hardware. In order to cope with various CPU revisions
> only top 16bit of PVR are checked which works for minor revision updates.
> 
> However in every CPU generation starting POWER7 (at least) there were CPUs
> supporting the (almost) same POWER ISA level but having different top
> 16bits of PVR - POWER7+, POWER8E, POWER8NVL; this time we got POWER9+
> with a new PVR family. We would normally add the PVR mask for the new one
> too, the problem with it is that although the physical machines exist,
> P9+ is not going to be released as a product, and this situation is likely
> to repeat in the future.
> 
> Instead of adding every new CPU family in QEMU, this adds a new sPAPR
> machine capability to force PVR setting/checking. It is "on" by default
> to preserve the existing behavior. When "off", it is the user's
> responsibility to specify the correct CPU.
> 

I don't quite understand the motivation for this... what does this
buy us ?

> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>  include/hw/ppc/spapr.h |  5 ++++-
>  hw/ppc/spapr.c         |  1 +
>  hw/ppc/spapr_caps.c    | 18 ++++++++++++++++++
>  target/ppc/kvm.c       | 16 ++++++++++++++--
>  4 files changed, 37 insertions(+), 3 deletions(-)
> 
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index e579eaf28c05..5ccac4d56871 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -81,8 +81,10 @@ typedef enum {
>  #define SPAPR_CAP_CCF_ASSIST            0x09
>  /* Implements PAPR FWNMI option */
>  #define SPAPR_CAP_FWNMI                 0x0A
> +/* Implements PAPR PVR option */
> +#define SPAPR_CAP_PVR                   0x0B
>  /* Num Caps */
> -#define SPAPR_CAP_NUM                   (SPAPR_CAP_FWNMI + 1)
> +#define SPAPR_CAP_NUM                   (SPAPR_CAP_PVR + 1)
>  
>  /*
>   * Capability Values
> @@ -912,6 +914,7 @@ extern const VMStateDescription vmstate_spapr_cap_nested_kvm_hv;
>  extern const VMStateDescription vmstate_spapr_cap_large_decr;
>  extern const VMStateDescription vmstate_spapr_cap_ccf_assist;
>  extern const VMStateDescription vmstate_spapr_cap_fwnmi;
> +extern const VMStateDescription vmstate_spapr_cap_pvr;
>  
>  static inline uint8_t spapr_get_cap(SpaprMachineState *spapr, int cap)
>  {
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 841b5ec59b12..ecc74c182b9f 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -4535,6 +4535,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
>      smc->default_caps.caps[SPAPR_CAP_LARGE_DECREMENTER] = SPAPR_CAP_ON;
>      smc->default_caps.caps[SPAPR_CAP_CCF_ASSIST] = SPAPR_CAP_ON;
>      smc->default_caps.caps[SPAPR_CAP_FWNMI] = SPAPR_CAP_ON;
> +    smc->default_caps.caps[SPAPR_CAP_PVR] = SPAPR_CAP_ON;
>      spapr_caps_add_properties(smc, &error_abort);
>      smc->irq = &spapr_irq_dual;
>      smc->dr_phb_enabled = true;
> diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
> index eb54f9422722..398b72b77f9f 100644
> --- a/hw/ppc/spapr_caps.c
> +++ b/hw/ppc/spapr_caps.c
> @@ -525,6 +525,14 @@ static void cap_fwnmi_apply(SpaprMachineState *spapr, uint8_t val,
>      }
>  }
>  
> +static void cap_pvr_apply(SpaprMachineState *spapr, uint8_t val, Error **errp)
> +{
> +    if (val) {
> +        return;
> +    }
> +    warn_report("If you're uing kvm-hv.ko, only \"-cpu host\" is supported");
> +}
> +
>  SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
>      [SPAPR_CAP_HTM] = {
>          .name = "htm",
> @@ -633,6 +641,15 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
>          .type = "bool",
>          .apply = cap_fwnmi_apply,
>      },
> +    [SPAPR_CAP_PVR] = {
> +        .name = "pvr",
> +        .description = "Enforce PVR in KVM",
> +        .index = SPAPR_CAP_PVR,
> +        .get = spapr_cap_get_bool,
> +        .set = spapr_cap_set_bool,
> +        .type = "bool",
> +        .apply = cap_pvr_apply,
> +    },
>  };
>  
>  static SpaprCapabilities default_caps_with_cpu(SpaprMachineState *spapr,
> @@ -773,6 +790,7 @@ SPAPR_CAP_MIG_STATE(nested_kvm_hv, SPAPR_CAP_NESTED_KVM_HV);
>  SPAPR_CAP_MIG_STATE(large_decr, SPAPR_CAP_LARGE_DECREMENTER);
>  SPAPR_CAP_MIG_STATE(ccf_assist, SPAPR_CAP_CCF_ASSIST);
>  SPAPR_CAP_MIG_STATE(fwnmi, SPAPR_CAP_FWNMI);
> +SPAPR_CAP_MIG_STATE(pvr, SPAPR_CAP_PVR);
>  
>  void spapr_caps_init(SpaprMachineState *spapr)
>  {
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 03d0667e8f94..a4adc29b6522 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -466,15 +466,27 @@ int kvm_arch_init_vcpu(CPUState *cs)
>      PowerPCCPU *cpu = POWERPC_CPU(cs);
>      CPUPPCState *cenv = &cpu->env;
>      int ret;
> +    SpaprMachineState *spapr;
>  

We generally try to avoid adding such explicit dependencies to the
machine code within the target directory... A virtual hypervisor
hook could possibly do the trick but this would require to set
PowerPCCPU::vhyp before kvm_arch_init_vcpu() gets called, eg.
when the vCPU is created in spapr_create_vcpu() rather than
when it gets realized.

>      /* Synchronize sregs with kvm */
>      ret = kvm_arch_sync_sregs(cpu);
>      if (ret) {
>          if (ret == -EINVAL) {
>              error_report("Register sync failed... If you're using kvm-hv.ko,"
> -                         " only \"-cpu host\" is possible");
> +                         " only \"-cpu host\" is supported");
> +        }
> +        /*
> +         * The user chose not to set PVR which makes sense if we are running
> +         * on a CPU with known ISA level but unknown PVR.
> +         */
> +        spapr = (SpaprMachineState *)
> +            object_dynamic_cast(OBJECT(qdev_get_machine()), TYPE_SPAPR_MACHINE);
> +
> +        if (spapr && spapr->eff.caps[SPAPR_CAP_PVR] == SPAPR_CAP_OFF) {
> +            ret = 0;
> +        } else {
> +            return ret;
>          }
> -        return ret;
>      }
>  
>      switch (cenv->mmu_model) {


