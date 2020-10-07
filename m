Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA0C6C4363C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 06:00:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF942208C7
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 06:00:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF942208C7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49612 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQ2VI-0008CA-NQ
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 02:00:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45080)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1kQ2UB-0007GF-OB; Wed, 07 Oct 2020 01:59:35 -0400
Received: from smtpout1.mo529.mail-out.ovh.net ([178.32.125.2]:34141)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1kQ2U9-0000al-7V; Wed, 07 Oct 2020 01:59:35 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.109.146.194])
 by mo529.mail-out.ovh.net (Postfix) with ESMTPS id A3AF762CBA33;
 Wed,  7 Oct 2020 07:59:27 +0200 (CEST)
Received: from kaod.org (37.59.142.99) by DAG4EX1.mxp5.local (172.16.2.31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Wed, 7 Oct 2020
 07:59:26 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-99G003a4b998ac-687c-43e1-a25e-241361c49f33,
 A1FB6DEFD4FFF4B2E39ADAD8D1A9CF0B60FA0B96) smtp.auth=clg@kaod.org
Subject: Re: [PATCH v2 1/6] spapr/xive: Introduce a StoreEOI capability
To: Greg Kurz <groug@kaod.org>
References: <20201005165147.526426-1-clg@kaod.org>
 <20201005165147.526426-2-clg@kaod.org> <20201006184236.62523fdc@bahia.lan>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <1c9ba295-d5a6-2e3e-2c02-1298361b294c@kaod.org>
Date: Wed, 7 Oct 2020 07:59:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201006184236.62523fdc@bahia.lan>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.99]
X-ClientProxiedBy: DAG1EX2.mxp5.local (172.16.2.2) To DAG4EX1.mxp5.local
 (172.16.2.31)
X-Ovh-Tracer-GUID: d417bb11-79d3-4db0-8216-3b418bb37efa
X-Ovh-Tracer-Id: 6430858794637233059
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedujedrgeehgddutdefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfhisehtkeertddtfeejnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepjeekudeuudevleegudeugeekleffveeludejteffiedvledvgfekueefudehheefnecukfhppedtrddtrddtrddtpdefjedrheelrddugedvrdelleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehmgihplhgrnhehrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepghhrohhugheskhgrohgurdhorhhg
Received-SPF: pass client-ip=178.32.125.2; envelope-from=clg@kaod.org;
 helo=smtpout1.mo529.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/07 01:59:29
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Gustavo Romero <gromero@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 10/6/20 6:42 PM, Greg Kurz wrote:
> On Mon, 5 Oct 2020 18:51:42 +0200
> Cédric Le Goater <clg@kaod.org> wrote:
> 
>> When an interrupt has been handled, the OS notifies the interrupt
>> controller with an EOI sequence. On the XIVE interrupt controller
>> (POWER9 and POWER10), this can be done with a load or a store
>> operation on the ESB interrupt management page of the interrupt. The
>> StoreEOI operation has less latency and improves interrupt handling
>> performance but it was deactivated during the POWER9 DD2.0 time-frame
>> because of ordering issues. POWER9 systems use the LoadEOI instead.
>> POWER10 has fixed the issue with a special load command which enforces
>> Load-after-Store ordering and StoreEOI can be safely used.
>>
>> The new StoreEOI capability adds StoreEOI support to the flags
>> returned by the hcall H_INT_GET_SOURCE_INFO. When the machine is using
>> an emulated interrupt controller, TCG or without kernel IRQ chip,
>> there are no limitations and activating StoreEOI is not an issue.
>> However, when running with a kernel IRQ chip, some verification needs
>> to be done on the host. This is done through the DT, which tells us
>> that firmware has configured the HW for StoreEOI, but a new KVM
>> capability would be cleaner.
>>
> 
> Cleaner and even required... a user could possibly run an older
> KVM that doesn't know about StoreEOI on a POWER10 host and QEMU
> would wrongly assume the feature is supported. 

Well, no, because the ESB pages of the interrupts being passthrough 
in the guest, it should be safe to use StoreEOI in a guest even if 
the host kernel is not aware of it. As long as HW is correctly 
configured by FW of course, which is what the DT property says.

I agree it's a bit of shortcut but it works. 

> Also, I guess this
> should rather be an attribute of the XIVE KVM device rather than a
> plain KVM property.

It should even be a source attribute in theory. Since QEMU does not, 
an attribute of the XIVE KVM device is fine but we would just be
looking at the device tree from KVM. So may be, it's easier to make
it global to VM without relying on the XIVE device.

>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
>> ---
>>  include/hw/ppc/spapr.h |  4 +++-
>>  target/ppc/kvm_ppc.h   |  6 ++++++
>>  hw/ppc/spapr.c         |  1 +
>>  hw/ppc/spapr_caps.c    | 30 ++++++++++++++++++++++++++++++
>>  target/ppc/kvm.c       | 18 ++++++++++++++++++
>>  5 files changed, 58 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
>> index bba8736269f4..b701c14b4e09 100644
>> --- a/include/hw/ppc/spapr.h
>> +++ b/include/hw/ppc/spapr.h
>> @@ -74,8 +74,10 @@ typedef enum {
>>  #define SPAPR_CAP_CCF_ASSIST            0x09
>>  /* Implements PAPR FWNMI option */
>>  #define SPAPR_CAP_FWNMI                 0x0A
>> +/* Implements XIVE StoreEOI feature */
>> +#define SPAPR_CAP_STOREEOI              0x0B
> 
> The name should mention XIVE, ie. SPAPR_CAP_XIVE_STOREEOI

ok.

> 
>>  /* Num Caps */
>> -#define SPAPR_CAP_NUM                   (SPAPR_CAP_FWNMI + 1)
>> +#define SPAPR_CAP_NUM                   (SPAPR_CAP_STOREEOI + 1)
>>  
>>  /*
>>   * Capability Values
>> diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
>> index 72e05f1cd2fc..c5a487dbba13 100644
>> --- a/target/ppc/kvm_ppc.h
>> +++ b/target/ppc/kvm_ppc.h
>> @@ -64,6 +64,7 @@ bool kvmppc_has_cap_htm(void);
>>  bool kvmppc_has_cap_mmu_radix(void);
>>  bool kvmppc_has_cap_mmu_hash_v3(void);
>>  bool kvmppc_has_cap_xive(void);
>> +bool kvmppc_has_cap_xive_storeeoi(void);
>>  int kvmppc_get_cap_safe_cache(void);
>>  int kvmppc_get_cap_safe_bounds_check(void);
>>  int kvmppc_get_cap_safe_indirect_branch(void);
>> @@ -346,6 +347,11 @@ static inline bool kvmppc_has_cap_xive(void)
>>      return false;
>>  }
>>  
>> +static inline bool kvmppc_has_cap_xive_storeeoi(void)
>> +{
>> +    return false;
>> +}
>> +
>>  static inline int kvmppc_get_cap_safe_cache(void)
>>  {
>>      return 0;
>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>> index 4256794f3bed..e83de0580142 100644
>> --- a/hw/ppc/spapr.c
>> +++ b/hw/ppc/spapr.c
>> @@ -4447,6 +4447,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
>>      smc->default_caps.caps[SPAPR_CAP_LARGE_DECREMENTER] = SPAPR_CAP_ON;
>>      smc->default_caps.caps[SPAPR_CAP_CCF_ASSIST] = SPAPR_CAP_ON;
>>      smc->default_caps.caps[SPAPR_CAP_FWNMI] = SPAPR_CAP_ON;
>> +    smc->default_caps.caps[SPAPR_CAP_STOREEOI] = SPAPR_CAP_OFF;
>>      spapr_caps_add_properties(smc);
>>      smc->irq = &spapr_irq_dual;
>>      smc->dr_phb_enabled = true;
>> diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
>> index 9341e9782a3f..57c62c22e4cc 100644
>> --- a/hw/ppc/spapr_caps.c
>> +++ b/hw/ppc/spapr_caps.c
>> @@ -524,6 +524,26 @@ static void cap_fwnmi_apply(SpaprMachineState *spapr, uint8_t val,
>>      }
>>  }
>>  
>> +static void cap_storeeoi_apply(SpaprMachineState *spapr, uint8_t val,
>> +                               Error **errp)
>> +{
>> +    ERRP_GUARD();
> 
> From "qapi/error.h":
> 
>  * = Why, when and how to use ERRP_GUARD() =
>  *
>  * Without ERRP_GUARD(), use of the @errp parameter is restricted:
>  * - It must not be dereferenced, because it may be null.
>  * - It should not be passed to error_prepend() or
>  *   error_append_hint(), because that doesn't work with &error_fatal.
>  * ERRP_GUARD() lifts these restrictions.
>  *
>  * To use ERRP_GUARD(), add it right at the beginning of the function.
>  * @errp can then be used without worrying about the argument being
>  * NULL or &error_fatal.
>  *
>  * Using it when it's not needed is safe, but please avoid cluttering
>  * the source with useless code.
>  *
> 
> So for this ERRP_GUARD() to be justified, you should come up with
> a hint, otherwise you should drop it.

OK. 

>> +    MachineState *machine = MACHINE(spapr);
>> +    bool kvm_storeeoi = kvmppc_has_cap_xive_storeeoi();
>> +
>> +    if (!val) {
>> +        return; /* Disabled by default */
>> +    }
>> +
>> +    /* Check host support when the KVM device is in use */
>> +    if (kvm_irqchip_in_kernel()) {
> 
> Hmm... checking kvm_irqchip_in_kernel() is imprecise because
> it returns true if either the XIVE or XICS KVM device has
> been open, regardless of the flavor we're going to use. This
> really depends on the ic-mode setting:
True.
> 1) xics: we really don't care whether StoreEOI is available or not.
>    This is very similar to the case of POWER8 in patch 2. Spit a
>    warning and return.

yes

> 2) xive: at this point the XIVE KVM device is open and we can check
>    the availability of StoreEOI with kvm_device_check_attr().

yes and similar to kvmppc_has_cap_xive_storeeoi() in a sense. 

> 3) dual: this one is problematic because at this point the XICS KVM
>    device is open but XIVE KVM won't be open until CAS.
> 
> So I think we can only do something sensible for cases 1) and 2),
> eg:
> 
>     if (!spapr->irq->xive) {
>         warn_report(...);
>         return;
>     }
> 
>     if (spapr_xive_in_kernel(spapr->xive)) {
>         !kvm_device_check_attr(spapr->xive->fd, ...) {
>         error_setg(errp, "StoreEOI not supported by XIVE KVM");
>         return;
>     }
> 
> Case 3) requires a similar check in CAS if the guest asked for XIVE
> and cap-xive-storeeoi=on.

Yes. dual is more complex because we could be using the XIVE emulated
device which does not have limitations on P9. I need to take a closer 
look.


>> +        if (!kvm_storeeoi) {
>> +            error_setg(errp, "StoreEOI not supported by KVM");
>> +            return;
>> +        }
>> +    }
>> +}
>> +
>>  SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
>>      [SPAPR_CAP_HTM] = {
>>          .name = "htm",
>> @@ -632,6 +652,15 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
>>          .type = "bool",
>>          .apply = cap_fwnmi_apply,
>>      },
>> +    [SPAPR_CAP_STOREEOI] = {
>> +        .name = "storeeoi",
>> +        .description = "Implements XIVE StoreEOI feature",
>> +        .index = SPAPR_CAP_STOREEOI,
>> +        .get = spapr_cap_get_bool,
>> +        .set = spapr_cap_set_bool,
>> +        .type = "bool",
>> +        .apply = cap_storeeoi_apply,
>> +    },
>>  };
>>  
>>  static SpaprCapabilities default_caps_with_cpu(SpaprMachineState *spapr,
>> @@ -772,6 +801,7 @@ SPAPR_CAP_MIG_STATE(nested_kvm_hv, SPAPR_CAP_NESTED_KVM_HV);
>>  SPAPR_CAP_MIG_STATE(large_decr, SPAPR_CAP_LARGE_DECREMENTER);
>>  SPAPR_CAP_MIG_STATE(ccf_assist, SPAPR_CAP_CCF_ASSIST);
>>  SPAPR_CAP_MIG_STATE(fwnmi, SPAPR_CAP_FWNMI);
>> +SPAPR_CAP_MIG_STATE(storeeoi, SPAPR_CAP_STOREEOI);
>>  
>>  void spapr_caps_init(SpaprMachineState *spapr)
>>  {
>> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
>> index d85ba8ffe00b..9ad637151070 100644
>> --- a/target/ppc/kvm.c
>> +++ b/target/ppc/kvm.c
>> @@ -2448,6 +2448,24 @@ bool kvmppc_has_cap_xive(void)
>>      return cap_xive;
>>  }
>>  
>> +/*
>> + * TODO: Introduce a new KVM capability
>> + */
> 
> Is there anything that prevents to add such a capability
> or KVM device attribute before modifying QEMU ?

no. I was just lazy as the device tree check is good enough.

Thanks for the review,

C. 


>> +bool kvmppc_has_cap_xive_storeeoi(void)
>> +{
>> +    static const char *compat = "ibm,opal-xive-pe";
>> +    void *host_fdt;
>> +    int xive_node;
>> +
>> +    host_fdt = load_device_tree_from_sysfs();
>> +    xive_node = fdt_node_offset_by_compatible(host_fdt, -1, compat);
>> +    if (xive_node < 0) {
>> +        return false;
>> +    }
>> +
>> +    return !!fdt_getprop(host_fdt, xive_node, "store-eoi-support", NULL);
>> +}
>> +
>>  static void kvmppc_get_cpu_characteristics(KVMState *s)
>>  {
>>      struct kvm_ppc_cpu_char c;
> 

