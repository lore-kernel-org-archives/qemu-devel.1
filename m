Return-Path: <SRS0=LaQQ=XZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A288EC4360C
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 05:30:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7777520815
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 05:30:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7777520815
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iEoGS-0007zd-Jd
	for qemu-devel@archiver.kernel.org; Mon, 30 Sep 2019 01:30:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57971)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iEoF3-0006lr-Sv
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 01:29:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iEoF2-0000BJ-G1
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 01:29:01 -0400
Received: from 5.mo173.mail-out.ovh.net ([46.105.40.148]:49986)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iEoF2-0000A1-9f
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 01:29:00 -0400
Received: from player772.ha.ovh.net (unknown [10.108.54.38])
 by mo173.mail-out.ovh.net (Postfix) with ESMTP id AEAA311AB6D
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2019 07:28:57 +0200 (CEST)
Received: from kaod.org (lfbn-1-2229-223.w90-76.abo.wanadoo.fr [90.76.50.223])
 (Authenticated sender: clg@kaod.org)
 by player772.ha.ovh.net (Postfix) with ESMTPSA id 20ABAA56F077;
 Mon, 30 Sep 2019 05:28:47 +0000 (UTC)
Subject: Re: [PATCH v2 21/33] spapr, xics, xive: Move cpu_intc_create from
 SpaprIrq to SpaprInterruptController
To: David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>
References: <20190927055028.11493-1-david@gibson.dropbear.id.au>
 <20190927055028.11493-22-david@gibson.dropbear.id.au>
 <20190927121649.5b9f3db7@bahia.lan> <20190930014904.GB11105@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <adb67721-5c4e-50ac-f459-a48570a45d6e@kaod.org>
Date: Mon, 30 Sep 2019 07:28:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190930014904.GB11105@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 10563474401845873433
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrgedugdelhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.40.148
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
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 30/09/2019 03:49, David Gibson wrote:
> On Fri, Sep 27, 2019 at 12:16:49PM +0200, Greg Kurz wrote:
>> On Fri, 27 Sep 2019 15:50:16 +1000
>> David Gibson <david@gibson.dropbear.id.au> wrote:
>>
>>> This method essentially represents code which belongs to the interrupt
>>> controller, but needs to be called on all possible intcs, rather than
>>> just the currently active one.  The "dual" version therefore calls
>>> into the xics and xive versions confusingly.
>>>
>>> Handle this more directly, by making it instead a method on the intc
>>> backend, and always calling it on every backend that exists.
>>>
>>> While we're there, streamline the error reporting a bit.
>>>
>>> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> [snip]
>>> @@ -525,6 +469,30 @@ static void spapr_irq_check(SpaprMachineState *spapr, Error **errp)
>>>  /*
>>>   * sPAPR IRQ frontend routines for devices
>>>   */
>>> +int spapr_irq_cpu_intc_create(SpaprMachineState *spapr,
>>> +                              PowerPCCPU *cpu, Error **errp)
>>> +{
>>> +    if (spapr->xive) {
>>> +        SpaprInterruptController *intc = SPAPR_INTC(spapr->xive);
>>> +        SpaprInterruptControllerClass *sicc = SPAPR_INTC_GET_CLASS(intc);
>>> +
>>> +        if (sicc->cpu_intc_create(intc, cpu, errp) < 0) {
>>> +            return -1;
>>> +        }
>>> +    }
>>> +
>>> +    if (spapr->ics) {
>>> +        SpaprInterruptController *intc = SPAPR_INTC(spapr->ics);
>>> +        SpaprInterruptControllerClass *sicc = SPAPR_INTC_GET_CLASS(intc);
>>> +
>>> +        if (sicc->cpu_intc_create(intc, cpu, errp) < 0) {
>>> +            return -1;
>>> +        }
>>> +    }
>>> +
>>
>> Instead of these hooks, what about open-coding spapr_xive_cpu_intc_create()
>> and xics_spapr_cpu_intc_create() directly here, like you already did for the
>> ICS and the XIVE objects in spapr_irq_init() ?
> 
> I'd prefer not to.  The idea is I want to treat this as basically:
> 
> 	foreach_possible_intc(intc)
> 		intc::cpu_intc_create(...)
> 
> If I find time I might indeed replace the explicit ics and xive
> pointers with just an array of SpaprInterruptController *.

Or you could use object_child_foreach() and check for the type. If we had
a helper object_child_foreach_type(), we could use it elsewhere.

 
> init is fundamentally different though, because it needs to *create*
> that list (implicit or explicit) of possible intcs, so it can't be
> based on an existing one.
> 
>>
>>> +    return 0;
>>> +}
>>> +
>>>  void spapr_irq_init(SpaprMachineState *spapr, Error **errp)
>>>  {
>>>      MachineState *machine = MACHINE(spapr);
>>> @@ -763,7 +731,6 @@ SpaprIrq spapr_irq_xics_legacy = {
>>>      .free        = spapr_irq_free_xics,
>>>      .print_info  = spapr_irq_print_info_xics,
>>>      .dt_populate = spapr_dt_xics,
>>> -    .cpu_intc_create = spapr_irq_cpu_intc_create_xics,
>>>      .post_load   = spapr_irq_post_load_xics,
>>>      .reset       = spapr_irq_reset_xics,
>>>      .set_irq     = spapr_irq_set_irq_xics,
>>> diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
>>> index b9398e0be3..30d660ff1e 100644
>>> --- a/include/hw/ppc/spapr_irq.h
>>> +++ b/include/hw/ppc/spapr_irq.h
>>> @@ -43,8 +43,22 @@ typedef struct SpaprInterruptController SpaprInterruptController;
>>>  
>>>  typedef struct SpaprInterruptControllerClass {
>>>      InterfaceClass parent;
>>> +
>>> +    /*
>>> +     * These methods will typically be called on all intcs, active and
>>> +     * inactive
>>> +     */
>>> +    int (*cpu_intc_create)(SpaprInterruptController *intc,
>>> +                            PowerPCCPU *cpu, Error **errp);
>>>  } SpaprInterruptControllerClass;
>>>  
>>> +void spapr_irq_print_info(SpaprMachineState *spapr, Monitor *mon);
>>> +void spapr_irq_dt(SpaprMachineState *spapr, uint32_t nr_servers,
>>> +                  void *fdt, uint32_t phandle);
>>
>> These two ^^ seem to belong to later patches.
>>
>>> +int spapr_irq_cpu_intc_create(SpaprMachineState *spapr,
>>> +                              PowerPCCPU *cpu, Error **errp);
>>> +
>>> +
>>>  void spapr_irq_msi_init(SpaprMachineState *spapr, uint32_t nr_msis);
>>>  int spapr_irq_msi_alloc(SpaprMachineState *spapr, uint32_t num, bool align,
>>>                          Error **errp);
>>> @@ -61,8 +75,6 @@ typedef struct SpaprIrq {
>>>      void (*print_info)(SpaprMachineState *spapr, Monitor *mon);
>>>      void (*dt_populate)(SpaprMachineState *spapr, uint32_t nr_servers,
>>>                          void *fdt, uint32_t phandle);
>>> -    void (*cpu_intc_create)(SpaprMachineState *spapr, PowerPCCPU *cpu,
>>> -                            Error **errp);
>>>      int (*post_load)(SpaprMachineState *spapr, int version_id);
>>>      void (*reset)(SpaprMachineState *spapr, Error **errp);
>>>      void (*set_irq)(void *opaque, int srcno, int val);
>>
> 


