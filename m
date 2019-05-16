Return-Path: <SRS0=H6GY=TQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BA32C04AB4
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 05:00:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F165520862
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 05:00:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F165520862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48629 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hR8VU-0003Qs-Uo
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 01:00:40 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59017)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aravinda@linux.vnet.ibm.com>) id 1hR8UV-0002vH-IK
	for qemu-devel@nongnu.org; Thu, 16 May 2019 00:59:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aravinda@linux.vnet.ibm.com>) id 1hR8UT-0007jh-Ry
	for qemu-devel@nongnu.org; Thu, 16 May 2019 00:59:39 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40850
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aravinda@linux.vnet.ibm.com>)
	id 1hR8UT-0007jJ-Ls
	for qemu-devel@nongnu.org; Thu, 16 May 2019 00:59:37 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x4G4qvPB060724
	for <qemu-devel@nongnu.org>; Thu, 16 May 2019 00:59:36 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2sgxr5w9nx-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 16 May 2019 00:59:36 -0400
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <aravinda@linux.vnet.ibm.com>;
	Thu, 16 May 2019 05:59:35 +0100
Received: from b03cxnp07028.gho.boulder.ibm.com (9.17.130.15)
	by e35.co.us.ibm.com (192.168.1.135) with IBM ESMTP SMTP Gateway:
	Authorized Use Only! Violators will be prosecuted; 
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Thu, 16 May 2019 05:59:33 +0100
Received: from b03ledav006.gho.boulder.ibm.com
	(b03ledav006.gho.boulder.ibm.com [9.17.130.237])
	by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
	ESMTP id x4G4xWdP36569214
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK); Thu, 16 May 2019 04:59:32 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9D38DC6055;
	Thu, 16 May 2019 04:59:32 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 24855C6059;
	Thu, 16 May 2019 04:59:30 +0000 (GMT)
Received: from [9.102.2.175] (unknown [9.102.2.175])
	by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
	Thu, 16 May 2019 04:59:29 +0000 (GMT)
To: David Gibson <david@gibson.dropbear.id.au>
References: <155591636364.20338.844048953355207313.stgit@aravinda>
	<155591661564.20338.10693276428550708820.stgit@aravinda>
	<20190510064620.GL20559@umbus.fritz.box>
	<fa3f0f81-17bc-ce71-7fa0-e0bc706b3c17@linux.vnet.ibm.com>
	<20190510095321.GB5030@umbus.fritz.box>
	<69768ad0-7f08-6233-32df-f6a4a4c25d17@linux.vnet.ibm.com>
	<20190514044711.GI6441@umbus.fritz.box>
	<22c3e719-c14e-c07e-e014-7a55932b011e@linux.vnet.ibm.com>
	<20190516014535.GD3207@umbus.fritz.box>
From: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Date: Thu, 16 May 2019 10:29:27 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20190516014535.GD3207@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19051604-0012-0000-0000-000017377FF0
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011104; HX=3.00000242; KW=3.00000007;
	PH=3.00000004; SC=3.00000285; SDB=6.01203983; UDB=6.00632015;
	IPR=6.00984913; 
	MB=3.00026912; MTD=3.00000008; XFM=3.00000015; UTC=2019-05-16 04:59:35
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19051604-0013-0000-0000-000057494654
Message-Id: <d60f1a75-4716-4608-ab3b-40d96dd85ee4@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
	definitions=2019-05-16_04:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
	priorityscore=1501
	malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
	clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
	mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
	scancount=1 engine=8.0.1-1810050000 definitions=main-1905160034
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v8 5/6] ppc: spapr: Enable FWNMI
 capability
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: paulus@ozlabs.org, aik@au1.ibm.com, qemu-ppc@nongnu.org,
	qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On Thursday 16 May 2019 07:15 AM, David Gibson wrote:
> On Tue, May 14, 2019 at 11:02:07AM +0530, Aravinda Prasad wrote:
>>
>>
>> On Tuesday 14 May 2019 10:17 AM, David Gibson wrote:
>>> On Mon, May 13, 2019 at 04:00:43PM +0530, Aravinda Prasad wrote:
>>>>
>>>>
>>>> On Friday 10 May 2019 03:23 PM, David Gibson wrote:
>>>>> On Fri, May 10, 2019 at 12:45:29PM +0530, Aravinda Prasad wrote:
>>>>>>
>>>>>>
>>>>>> On Friday 10 May 2019 12:16 PM, David Gibson wrote:
>>>>>>> On Mon, Apr 22, 2019 at 12:33:35PM +0530, Aravinda Prasad wrote:
>>>>>>>> Enable the KVM capability KVM_CAP_PPC_FWNMI so that
>>>>>>>> the KVM causes guest exit with NMI as exit reason
>>>>>>>> when it encounters a machine check exception on the
>>>>>>>> address belonging to a guest. Without this capability
>>>>>>>> enabled, KVM redirects machine check exceptions to
>>>>>>>> guest's 0x200 vector.
>>>>>>>>
>>>>>>>> This patch also deals with the case when a guest with
>>>>>>>> the KVM_CAP_PPC_FWNMI capability enabled is attempted
>>>>>>>> to migrate to a host that does not support this
>>>>>>>> capability.
>>>>>>>>
>>>>>>>> Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
>>>>>>>> ---
>>>>>>>>  hw/ppc/spapr.c         |    1 +
>>>>>>>>  hw/ppc/spapr_caps.c    |   26 ++++++++++++++++++++++++++
>>>>>>>>  hw/ppc/spapr_rtas.c    |   14 ++++++++++++++
>>>>>>>>  include/hw/ppc/spapr.h |    4 +++-
>>>>>>>>  target/ppc/kvm.c       |   14 ++++++++++++++
>>>>>>>>  target/ppc/kvm_ppc.h   |    6 ++++++
>>>>>>>>  6 files changed, 64 insertions(+), 1 deletion(-)
>>>>>>>>
>>>>>>>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>>>>>>>> index ffd1715..44e09bb 100644
>>>>>>>> --- a/hw/ppc/spapr.c
>>>>>>>> +++ b/hw/ppc/spapr.c
>>>>>>>> @@ -4372,6 +4372,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
>>>>>>>>      smc->default_caps.caps[SPAPR_CAP_NESTED_KVM_HV] = SPAPR_CAP_OFF;
>>>>>>>>      smc->default_caps.caps[SPAPR_CAP_LARGE_DECREMENTER] = SPAPR_CAP_ON;
>>>>>>>>      smc->default_caps.caps[SPAPR_CAP_CCF_ASSIST] = SPAPR_CAP_OFF;
>>>>>>>> +    smc->default_caps.caps[SPAPR_CAP_FWNMI_MCE] = SPAPR_CAP_OFF;
>>>>>>>>      spapr_caps_add_properties(smc, &error_abort);
>>>>>>>>      smc->irq = &spapr_irq_xics;
>>>>>>>>      smc->dr_phb_enabled = true;
>>>>>>>> diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
>>>>>>>> index edc5ed0..5b3af04 100644
>>>>>>>> --- a/hw/ppc/spapr_caps.c
>>>>>>>> +++ b/hw/ppc/spapr_caps.c
>>>>>>>> @@ -473,6 +473,22 @@ static void cap_ccf_assist_apply(SpaprMachineState *spapr, uint8_t val,
>>>>>>>>      }
>>>>>>>>  }
>>>>>>>>  
>>>>>>>> +static void cap_fwnmi_mce_apply(SpaprMachineState *spapr, uint8_t val,
>>>>>>>> +                                Error **errp)
>>>>>>>> +{
>>>>>>>> +    PowerPCCPU *cpu = POWERPC_CPU(first_cpu);
>>>>>>>> +
>>>>>>>> +    if (!val) {
>>>>>>>> +        return; /* Disabled by default */
>>>>>>>> +    }
>>>>>>>> +
>>>>>>>> +    if (kvm_enabled()) {
>>>>>>>> +        if (kvmppc_fwnmi_enable(cpu)) {
>>>>>>>> +            error_setg(errp, "Requested fwnmi capability not support by KVM");
>>>>>>>> +        }
>>>>>>>> +    }
>>>>>>>> +}
>>>>>>>> +
>>>>>>>>  SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
>>>>>>>>      [SPAPR_CAP_HTM] = {
>>>>>>>>          .name = "htm",
>>>>>>>> @@ -571,6 +587,15 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
>>>>>>>>          .type = "bool",
>>>>>>>>          .apply = cap_ccf_assist_apply,
>>>>>>>>      },
>>>>>>>> +    [SPAPR_CAP_FWNMI_MCE] = {
>>>>>>>> +        .name = "fwnmi-mce",
>>>>>>>> +        .description = "Handle fwnmi machine check exceptions",
>>>>>>>> +        .index = SPAPR_CAP_FWNMI_MCE,
>>>>>>>> +        .get = spapr_cap_get_bool,
>>>>>>>> +        .set = spapr_cap_set_bool,
>>>>>>>> +        .type = "bool",
>>>>>>>> +        .apply = cap_fwnmi_mce_apply,
>>>>>>>> +    },
>>>>>>>>  };
>>>>>>>>  
>>>>>>>>  static SpaprCapabilities default_caps_with_cpu(SpaprMachineState *spapr,
>>>>>>>> @@ -706,6 +731,7 @@ SPAPR_CAP_MIG_STATE(ibs, SPAPR_CAP_IBS);
>>>>>>>>  SPAPR_CAP_MIG_STATE(nested_kvm_hv, SPAPR_CAP_NESTED_KVM_HV);
>>>>>>>>  SPAPR_CAP_MIG_STATE(large_decr, SPAPR_CAP_LARGE_DECREMENTER);
>>>>>>>>  SPAPR_CAP_MIG_STATE(ccf_assist, SPAPR_CAP_CCF_ASSIST);
>>>>>>>> +SPAPR_CAP_MIG_STATE(fwnmi, SPAPR_CAP_FWNMI_MCE);
>>>>>>>>  
>>>>>>>>  void spapr_caps_init(SpaprMachineState *spapr)
>>>>>>>>  {
>>>>>>>> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
>>>>>>>> index d3499f9..997cf19 100644
>>>>>>>> --- a/hw/ppc/spapr_rtas.c
>>>>>>>> +++ b/hw/ppc/spapr_rtas.c
>>>>>>>> @@ -49,6 +49,7 @@
>>>>>>>>  #include "hw/ppc/fdt.h"
>>>>>>>>  #include "target/ppc/mmu-hash64.h"
>>>>>>>>  #include "target/ppc/mmu-book3s-v3.h"
>>>>>>>> +#include "kvm_ppc.h"
>>>>>>>>  
>>>>>>>>  static void rtas_display_character(PowerPCCPU *cpu, SpaprMachineState *spapr,
>>>>>>>>                                     uint32_t token, uint32_t nargs,
>>>>>>>> @@ -354,6 +355,7 @@ static void rtas_ibm_nmi_register(PowerPCCPU *cpu,
>>>>>>>>                                    target_ulong args,
>>>>>>>>                                    uint32_t nret, target_ulong rets)
>>>>>>>>  {
>>>>>>>> +    int ret;
>>>>>>>>      uint64_t rtas_addr = spapr_get_rtas_addr();
>>>>>>>>  
>>>>>>>>      if (!rtas_addr) {
>>>>>>>> @@ -361,6 +363,18 @@ static void rtas_ibm_nmi_register(PowerPCCPU *cpu,
>>>>>>>>          return;
>>>>>>>>      }
>>>>>>>>  
>>>>>>>> +    ret = kvmppc_fwnmi_enable(cpu);
>>>>>>>
>>>>>>> You shouldn't need this here as well as in cap_fwnmi_mce_apply().
>>>>>>>
>>>>>>> Instead, you should unconditionally fail the nmi-register if the
>>>>>>> capability is not enabled.
>>>>>>
>>>>>> cap_fwnmi is not enabled by default, because if it is enabled by default
>>>>>> them KVM will start routing machine check exceptions via guest exit
>>>>>> instead of routing it to guest's 0x200.
>>>>>>
>>>>>> During early boot since guest has not yet issued nmi-register, KVM is
>>>>>> expected to route exceptions to 0x200. Therefore we enable cap_fwnmi
>>>>>> only when a guest issues nmi-register.
>>>>>
>>>>> Except that's not true - you enable it in cap_fwnmi_mce_apply() which
>>>>> will be executed whenever the machine capability is enabled.
>>>>
>>>> I enable cap_fwnmi in cap_fwnmi_mce_apply() only when the "val" argument
>>>> (which is the effective cap value) is set. In early boot "val" is not
>>>> set as cap_fwnmi by default is not set, hence cap_fwnmi is not
>>>> enabled.
>>>
>>> Uh.. if that's true, something else is horribly wrong.  SPAPR caps are
>>> designed to have a fixed value for the lifetime of the VM.  Otherwise
>>> they will fail in their purpose of making sure we have a consistent
>>> environment across migrations.  So if the 'val' changes after the
>>> first call to apply(), then something is broken.
>>
>> If SPAPR caps are initialized before boot that do not change later, then
>> for cap_fwnmi, the default value is off at boot and the cap is enabled
>> only when guest issues "ibm,nmi-register" call. Should SPAPR caps be
>> updated when "ibm,nmi-register" is called?
> 
> So the confusing thing here is that there are spapr machine caps, and
> those are separate from the KVM caps for the VM.  Then the KVM caps
> also have whether the cap is possible and whether it is current
> activated.
> 
> The spapr machine caps *must* remain static for the VM's lifetime and
> only cover possibilities, not runtime configuration.  KVM caps may be
> activated as necessary.
> 
> So you can leave activating the KVM cap until nmi-register.  But if
> the spapr cap is disabled you must prohibit nmi-register.
> 
> The apply() functions are responsible for checking if the spapr caps
> are possible on the KVM implementation.  So if cap_fwnmi_mci_apply()
> is called with val==1 and KVM doesn't support the fwnmi extensions, it
> must fail outright.

I see, this clears my confusion on spapr machine caps and KVM caps..

> 
>>>> My understanding is that, cap_fwnmi_mce_apply() is also called during
>>>> migration on the target machine.
>>>
>>> Only in the sense that the machine is initialized before processing
>>> the incoming migration.  The capability values must be equal on either
>>> side of the migration (that's checked elsewhere).  Well, actually,
>>> you're allowed to increase the cap value across a migration, just not
>>> decrease it.
>>
>> Ah.. ok.. I am still familiarizing myself with the migration code..
>>
>>>
>>>> If effective cap for cap_fwnmi is
>>>> enabled on source machine than I think "val" will be set when
>>>> cap_fwnmi_mce_apply() is called on target machine.
>>>
>>> Nope.  The migrated value of the cap will be *validated* against the
>>> value set on the destination setup, but it won't *alter* the value on
>>> the destination (the result is that you have it enabled on the source,
>>> but not the destination, the migration will fail).
>>
>> But if cap_fwnmi is set on the host, which function is responsible to
> 
> I'm not sure what you mean by "the host" here.
> 
>> enable it on the destination? I think cap_fwnmi_mce_apply() is
>> responsible for enabling it on the destination.
> 
> Enabling the spapr cap?  It is set based on the command line and
> machine type, just like on the source machine.
> 
>> If that is the case
>> cap_fwnmi_mce_apply() should know if cap_fwnmi is set on the host and
>> the only way it can check that is based on the "val" argument passed on
>> to it.
>>
>> Or am I missing something here?
> 
> Probably, but I'm not sure exactly what.
> 
> The val argument to apply() is set to the value of the spapr cap.
> This is based on the qemu command line and machine type, and must be
> the same on source and destination.  As a general rule, qemu requires
> that the same machine options are used on source and destination.

Please ignore my previous statements this was made without clear
understanding of spapr machine caps and KVM caps.

I will resend the patches with the modifications.

> 

-- 
Regards,
Aravinda


