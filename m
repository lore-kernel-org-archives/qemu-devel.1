Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C371BC46499
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 11:20:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85234218CA
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 11:20:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85234218CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjMGh-0000ij-RO
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 07:20:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35710)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aravinda@linux.vnet.ibm.com>) id 1hjM7y-0005IU-HL
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 07:11:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aravinda@linux.vnet.ibm.com>) id 1hjM7w-0005Dd-HE
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 07:11:42 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:17734
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aravinda@linux.vnet.ibm.com>)
 id 1hjM7t-0004r2-PT
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 07:11:38 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x65B9ggG079116
 for <qemu-devel@nongnu.org>; Fri, 5 Jul 2019 07:11:35 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2tj5bwg8ye-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2019 07:11:34 -0400
Received: from localhost
 by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <aravinda@linux.vnet.ibm.com>;
 Fri, 5 Jul 2019 12:11:34 +0100
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
 by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 5 Jul 2019 12:11:30 +0100
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com
 [9.57.199.111])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x65BBTGS48693506
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 5 Jul 2019 11:11:29 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6F6C0AC05B;
 Fri,  5 Jul 2019 11:11:29 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B5FA6AC059;
 Fri,  5 Jul 2019 11:11:26 +0000 (GMT)
Received: from [9.85.75.69] (unknown [9.85.75.69])
 by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
 Fri,  5 Jul 2019 11:11:26 +0000 (GMT)
To: Greg Kurz <groug@kaod.org>
References: <156033104292.26635.15759339817253067370.stgit@aravinda>
 <156033129836.26635.3348706829139659071.stgit@aravinda>
 <20190702041129.GJ6779@umbus.fritz.box>
 <89a68bbd-801e-876c-3105-877790a3189b@linux.vnet.ibm.com>
 <20190703032027.GI9442@umbus.fritz.box>
 <c8f78a4c-d4a0-10e9-e0c9-0e37e3415b5c@linux.vnet.ibm.com>
 <20190704011222.GT9442@umbus.fritz.box>
 <cbabc1ce-4360-64ac-9d06-a57887130c4d@linux.vnet.ibm.com>
 <20190704203735.30c7fc8a@bahia.lan>
From: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Date: Fri, 5 Jul 2019 16:41:25 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20190704203735.30c7fc8a@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19070511-0052-0000-0000-000003DAC601
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011382; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01227752; UDB=6.00646466; IPR=6.01008994; 
 MB=3.00027596; MTD=3.00000008; XFM=3.00000015; UTC=2019-07-05 11:11:32
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19070511-0053-0000-0000-00006193D017
Message-Id: <ec4f5cf3-ae91-8160-6df6-27829c5f5401@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-07-05_04:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907050137
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v10 6/6] ppc: spapr: Handle "ibm,
 nmi-register" and "ibm, nmi-interlock" RTAS calls
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
Cc: aik@au1.ibm.com, qemu-devel@nongnu.org, paulus@ozlabs.org,
 qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On Friday 05 July 2019 12:07 AM, Greg Kurz wrote:
> On Thu, 4 Jul 2019 10:49:05 +0530
> Aravinda Prasad <aravinda@linux.vnet.ibm.com> wrote:
> 
>>
>>
>> On Thursday 04 July 2019 06:42 AM, David Gibson wrote:
>>> On Wed, Jul 03, 2019 at 02:30:31PM +0530, Aravinda Prasad wrote:
>>>>
>>>>
>>>> On Wednesday 03 July 2019 08:50 AM, David Gibson wrote:
>>>>> On Tue, Jul 02, 2019 at 04:10:08PM +0530, Aravinda Prasad wrote:
>>>>>>
>>>>>>
>>>>>> On Tuesday 02 July 2019 09:41 AM, David Gibson wrote:
>>>>>>> On Wed, Jun 12, 2019 at 02:51:38PM +0530, Aravinda Prasad wrote:
>>>>>>>> This patch adds support in QEMU to handle "ibm,nmi-register"
>>>>>>>> and "ibm,nmi-interlock" RTAS calls and sets the default
>>>>>>>> value of SPAPR_CAP_FWNMI_MCE to SPAPR_CAP_ON for machine
>>>>>>>> type 4.0.
>>>>>>>>
>>>>>>>> The machine check notification address is saved when the
>>>>>>>> OS issues "ibm,nmi-register" RTAS call.
>>>>>>>>
>>>>>>>> This patch also handles the case when multiple processors
>>>>>>>> experience machine check at or about the same time by
>>>>>>>> handling "ibm,nmi-interlock" call. In such cases, as per
>>>>>>>> PAPR, subsequent processors serialize waiting for the first
>>>>>>>> processor to issue the "ibm,nmi-interlock" call. The second
>>>>>>>> processor that also received a machine check error waits
>>>>>>>> till the first processor is done reading the error log.
>>>>>>>> The first processor issues "ibm,nmi-interlock" call
>>>>>>>> when the error log is consumed.
>>>>>>>>
>>>>>>>> Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
>>>>>>>> ---
>>>>>>>>  hw/ppc/spapr.c         |    6 ++++-
>>>>>>>>  hw/ppc/spapr_rtas.c    |   63 ++++++++++++++++++++++++++++++++++++++++++++++++
>>>>>>>>  include/hw/ppc/spapr.h |    5 +++-
>>>>>>>>  3 files changed, 72 insertions(+), 2 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>>>>>>>> index 3d6d139..213d493 100644
>>>>>>>> --- a/hw/ppc/spapr.c
>>>>>>>> +++ b/hw/ppc/spapr.c
>>>>>>>> @@ -2946,6 +2946,9 @@ static void spapr_machine_init(MachineState *machine)
>>>>>>>>          /* Create the error string for live migration blocker */
>>>>>>>>          error_setg(&spapr->fwnmi_migration_blocker,
>>>>>>>>                  "Live migration not supported during machine check handling");
>>>>>>>> +
>>>>>>>> +        /* Register ibm,nmi-register and ibm,nmi-interlock RTAS calls */
>>>>>>>> +        spapr_fwnmi_register();
>>>>>>>>      }
>>>>>>>>  
>>>>>>>>      spapr->rtas_blob = g_malloc(spapr->rtas_size);
>>>>>>>> @@ -4408,7 +4411,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
>>>>>>>>      smc->default_caps.caps[SPAPR_CAP_NESTED_KVM_HV] = SPAPR_CAP_OFF;
>>>>>>>>      smc->default_caps.caps[SPAPR_CAP_LARGE_DECREMENTER] = SPAPR_CAP_ON;
>>>>>>>>      smc->default_caps.caps[SPAPR_CAP_CCF_ASSIST] = SPAPR_CAP_OFF;
>>>>>>>> -    smc->default_caps.caps[SPAPR_CAP_FWNMI_MCE] = SPAPR_CAP_OFF;
>>>>>>>> +    smc->default_caps.caps[SPAPR_CAP_FWNMI_MCE] = SPAPR_CAP_ON;
>>>>>>>
>>>>>>> Turning this on by default really isn't ok if it stops you running TCG
>>>>>>> guests at all.
>>>>>>
>>>>>> If so this can be "off" by default until TCG is supported.
>>>>>>
>>>>>>>
>>>>>>>>      spapr_caps_add_properties(smc, &error_abort);
>>>>>>>>      smc->irq = &spapr_irq_dual;
>>>>>>>>      smc->dr_phb_enabled = true;
>>>>>>>> @@ -4512,6 +4515,7 @@ static void spapr_machine_3_1_class_options(MachineClass *mc)
>>>>>>>>      smc->default_caps.caps[SPAPR_CAP_SBBC] = SPAPR_CAP_BROKEN;
>>>>>>>>      smc->default_caps.caps[SPAPR_CAP_IBS] = SPAPR_CAP_BROKEN;
>>>>>>>>      smc->default_caps.caps[SPAPR_CAP_LARGE_DECREMENTER] = SPAPR_CAP_OFF;
>>>>>>>> +    smc->default_caps.caps[SPAPR_CAP_FWNMI_MCE] = SPAPR_CAP_OFF;
>>>>>>>
>>>>>>> We're now well past 4.0, and in fact we're about to go into soft
>>>>>>> freeze for 4.1, so we're going to miss that too.  So 4.1 and earlier
>>>>>>> will need to retain the old default.
>>>>>>
>>>>>> ok.
>>>>>>
>>>>>>>
>>>>>>>>  }
>>>>>>>>  
>>>>>>>>  DEFINE_SPAPR_MACHINE(3_1, "3.1", false);
>>>>>>>> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
>>>>>>>> index a015a80..e010cb2 100644
>>>>>>>> --- a/hw/ppc/spapr_rtas.c
>>>>>>>> +++ b/hw/ppc/spapr_rtas.c
>>>>>>>> @@ -49,6 +49,7 @@
>>>>>>>>  #include "hw/ppc/fdt.h"
>>>>>>>>  #include "target/ppc/mmu-hash64.h"
>>>>>>>>  #include "target/ppc/mmu-book3s-v3.h"
>>>>>>>> +#include "migration/blocker.h"
>>>>>>>>  
>>>>>>>>  static void rtas_display_character(PowerPCCPU *cpu, SpaprMachineState *spapr,
>>>>>>>>                                     uint32_t token, uint32_t nargs,
>>>>>>>> @@ -352,6 +353,60 @@ static void rtas_get_power_level(PowerPCCPU *cpu, SpaprMachineState *spapr,
>>>>>>>>      rtas_st(rets, 1, 100);
>>>>>>>>  }
>>>>>>>>  
>>>>>>>> +static void rtas_ibm_nmi_register(PowerPCCPU *cpu,
>>>>>>>> +                                  SpaprMachineState *spapr,
>>>>>>>> +                                  uint32_t token, uint32_t nargs,
>>>>>>>> +                                  target_ulong args,
>>>>>>>> +                                  uint32_t nret, target_ulong rets)
>>>>>>>> +{
>>>>>>>> +    int ret;
>>>>>>>> +    hwaddr rtas_addr = spapr_get_rtas_addr();
>>>>>>>> +
>>>>>>>> +    if (!rtas_addr) {
>>>>>>>> +        rtas_st(rets, 0, RTAS_OUT_NOT_SUPPORTED);
>>>>>>>> +        return;
>>>>>>>> +    }
>>>>>>>> +
>>>>>>>> +    if (spapr_get_cap(spapr, SPAPR_CAP_FWNMI_MCE) == SPAPR_CAP_OFF) {
>>>>>>>> +        rtas_st(rets, 0, RTAS_OUT_NOT_SUPPORTED);
>>>>>>>> +        return;
>>>>>>>> +    }
>>>>>>>> +
>>>>>>>> +    ret = kvmppc_fwnmi_enable(cpu);
>>>>>>>> +    if (ret == 1) {
>>>>>>>> +        rtas_st(rets, 0, RTAS_OUT_NOT_SUPPORTED);
>>>>>>>
>>>>>>> I don't understand this case separate from the others.  We've already
>>>>>>> set the cap, so fwnmi support should be checked and available.
>>>>>>
>>>>>> But we have not enabled fwnmi in KVM. kvmppc_fwnmi_enable() returns 1 if
>>>>>> cap_ppc_fwnmi is not available in KVM.
>>>>>
>>>>> But you've checked for the presence of the extension, yes?  So a
>>>>> failure to enable the cap would be unexpected.  In which case how does
>>>>> this case differ from.. 
>>>>
>>>> No, this is the function where I check for the presence of the
>>>> extension. In kvm_arch_init() we just set cap_ppc_fwnmi to 1 if KVM
>>>> support is available, but don't take any action if unavailable.
>>>
>>> Yeah, that's not ok.  You should be checking for the presence of the
>>> extension in the .apply() function.  If you start up with the spapr
>>> cap selected then failing at nmi-register time means something has
>>> gone badly wrong.
>>
>> So, I should check for two things in the .apply() function: first if
>> cap_ppc_fwnmi is supported and second if cap_ppc_fwnmi is enabled in KVM.
>>
>> In that case kvm_vcpu_enable_cap(cs, KVM_CAP_PPC_FWNMI, 0) should be
>> called during spapr_machine_init().
>>
>> So, we will fail to boot (when SPAPR_CAP_FWNMI_MCE=ON) if cap_ppc_fwnmi
>> can't be enabled irrespective of whether a guest issues nmi,register or not.
>>
> 
> Yes. The idea is that we don't want to expose some feature to the guest
> if we already know it cannot work. The same stands for migration, if
> we know the destination host doesn't support the feature, we don't want
> to confuse the guest because the feature disappeared unexpectedly. The
> correct way to address that is to check the feature is supported in QEMU
> and/or KVM before we start the guest or before we accept a migration
> stream and fail early if we can't provide the feature.

ok.

> 
> Speaking of migration, kvmppc_fwnmi_enable() should be called in a
> post load callback... and the problem I see is that this is a vCPU
> ioctl. So either we add a state "I should enable FWNMI on post load"
> to the vCPU that called nmi,register, or maybe first_cpu can do the
> trick in a post load callback of vmstate_spapr_machine_check.

To summarize the changes I am planning:

If SPAPR_CAP_FWNMI_MCE=ON, then enable cap_ppc_fwnmi in KVM. If
cap_ppc_fwnmi can't be enabled then fail early. This can be included in
spapr_machine_init() function.

During migration, if SPAPR_CAP_FWNMI_MCE=ON then enable cap_ppc_fwnmi by
having a .post_load callback which calls kvmppc_fwnmi_enable(). Fail the
migration if we can't enable cap_ppc_fwnmi on the destination host.

> 
> BTW, since FWNMI is a platform wide feature, ie. you don't need to
> enable it on a per-CPU basis), why is KVM_CAP_PPC_FWNMI a vCPU ioctl
> and not a VM ioctl ?

I think it should be VM ioctl, let me check.

Regards,
Aravinda

> 
>>>
>>> This is necessary for migration: if you start on a system with nmi
>>> support and the guest registers for it, you can't then migrate safely
>>> to a system that doesn't have nmi support.  The way to handle that
>>> case is to have qemu fail to even start up on a destination without
>>> the support.
>>>
>>>> So this case is when we are running an old version of KVM with no
>>>> cap_ppc_fwnmi support.
>>>>
>>>>>
>>>>>>
>>>>>>>
>>>>>>>> +        return;
>>>>>>>> +    } else if (ret < 0) {
>>>>>>>> +        error_report("Couldn't enable KVM FWNMI capability");
>>>>>>>> +        rtas_st(rets, 0, RTAS_OUT_HW_ERROR);
>>>>>>>> +        return;
>>>>>
>>>>> ..this case.
>>>>
>>>> And this is when we have the KVM support but due to some problem with
>>>> either KVM or QEMU we are unable to enable cap_ppc_fwnmi.
>>>>
>>>>>
>>>>>>>> +    }
>>>>>>>> +
>>>>>>>> +    spapr->guest_machine_check_addr = rtas_ld(args, 1);
>>>>>>>> +    rtas_st(rets, 0, RTAS_OUT_SUCCESS);
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> +static void rtas_ibm_nmi_interlock(PowerPCCPU *cpu,
>>>>>>>> +                                   SpaprMachineState *spapr,
>>>>>>>> +                                   uint32_t token, uint32_t nargs,
>>>>>>>> +                                   target_ulong args,
>>>>>>>> +                                   uint32_t nret, target_ulong rets)
>>>>>>>> +{
>>>>>>>> +    if (spapr->guest_machine_check_addr == -1) {
>>>>>>>> +        /* NMI register not called */
>>>>>>>> +        rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
>>>>>>>> +    } else {
>>>>>>>> +        /*
>>>>>>>> +         * vCPU issuing "ibm,nmi-interlock" is done with NMI handling,
>>>>>>>> +         * hence unset mc_status.
>>>>>>>> +         */
>>>>>>>> +        spapr->mc_status = -1;
>>>>>>>> +        qemu_cond_signal(&spapr->mc_delivery_cond);
>>>>>>>> +        migrate_del_blocker(spapr->fwnmi_migration_blocker);
>>>>>>>
>>>>>>> Hrm.  We add the blocker at the mce request point.  First, that's in
>>>>>>> another patch, which isn't great.  Second, does that mean we could add
>>>>>>> multiple times if we get an MCE on multiple CPUs?  Will that work and
>>>>>>> correctly match adds and removes properly?
>>>>>>
>>>>>> If it is fine to move the migration patch as the last patch in the
>>>>>> sequence, then we will have add and del blocker in the same patch.
>>>>>>
>>>>>> And yes we could add multiple times if we get MCE on multiple CPUs and
>>>>>> as all those cpus call interlock there should be matching number of
>>>>>> delete blockers.
>>>>>
>>>>> Ok, and I think adding the same pointer to the list multiple times
>>>>> will work ok.
>>>>
>>>> I think so
>>>>
>>>>>
>>>>> Btw, add_blocker() can fail - have you handled failure conditions?
>>>>
>>>> yes, I am handling it.
>>>>
>>>>>
>>>>
>>>
>>
> 

-- 
Regards,
Aravinda


