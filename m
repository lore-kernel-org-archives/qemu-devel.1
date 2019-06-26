Return-Path: <SRS0=5EQe=UZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54299C4646B
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 05:16:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1012C208CB
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 05:16:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1012C208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hg0II-0006cg-PS
	for qemu-devel@archiver.kernel.org; Wed, 26 Jun 2019 01:16:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60013)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aravinda@linux.vnet.ibm.com>) id 1hg0Fg-0005ow-Gw
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 01:13:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aravinda@linux.vnet.ibm.com>) id 1hg0Fc-0001hs-7S
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 01:13:48 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:6064)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aravinda@linux.vnet.ibm.com>)
 id 1hg0Fb-0001fd-QE
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 01:13:44 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x5Q5D1lx006887
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2019 01:13:40 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2tc0mvb5bw-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2019 01:13:40 -0400
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <aravinda@linux.vnet.ibm.com>;
 Wed, 26 Jun 2019 06:13:39 +0100
Received: from b03cxnp08026.gho.boulder.ibm.com (9.17.130.18)
 by e34.co.us.ibm.com (192.168.1.134) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 26 Jun 2019 06:13:37 +0100
Received: from b03ledav005.gho.boulder.ibm.com
 (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x5Q5DaOH32506286
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Jun 2019 05:13:36 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 95E1BBE058;
 Wed, 26 Jun 2019 05:13:36 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 89284BE051;
 Wed, 26 Jun 2019 05:13:34 +0000 (GMT)
Received: from [9.124.31.148] (unknown [9.124.31.148])
 by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
 Wed, 26 Jun 2019 05:13:34 +0000 (GMT)
To: david@gibson.dropbear.id.au
References: <156033104292.26635.15759339817253067370.stgit@aravinda>
 <156033129836.26635.3348706829139659071.stgit@aravinda>
 <20190624162935.02d08837@bahia.lan>
 <658ed3c3-9722-e23a-b65c-89df6025461e@linux.vnet.ibm.com>
 <20190625090023.10c26982@bahia.lan>
From: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Date: Wed, 26 Jun 2019 10:43:33 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20190625090023.10c26982@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19062605-0016-0000-0000-000009C7B160
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011331; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01223380; UDB=6.00643806; IPR=6.01004559; 
 MB=3.00027470; MTD=3.00000008; XFM=3.00000015; UTC=2019-06-26 05:13:39
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19062605-0017-0000-0000-000043CA4C0E
Message-Id: <29912bc9-4241-90f2-5cf6-57e6ed8f420b@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-06-26_02:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906260062
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
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
Cc: aik@au1.ibm.com, Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org,
 paulus@ozlabs.org, qemu-ppc@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On Tuesday 25 June 2019 12:30 PM, Greg Kurz wrote:
> On Tue, 25 Jun 2019 11:46:06 +0530
> Aravinda Prasad <aravinda@linux.vnet.ibm.com> wrote:
> 
>> On Monday 24 June 2019 07:59 PM, Greg Kurz wrote:
>>> On Wed, 12 Jun 2019 14:51:38 +0530
>>> Aravinda Prasad <aravinda@linux.vnet.ibm.com> wrote:
>>>   
>>>> This patch adds support in QEMU to handle "ibm,nmi-register"
>>>> and "ibm,nmi-interlock" RTAS calls and sets the default
>>>> value of SPAPR_CAP_FWNMI_MCE to SPAPR_CAP_ON for machine
>>>> type 4.0.
>>>>  
>>>
>>> Next machine type is 4.1.  
>>
>> ok.
>>
>>>   
>>>> The machine check notification address is saved when the
>>>> OS issues "ibm,nmi-register" RTAS call.
>>>>
>>>> This patch also handles the case when multiple processors
>>>> experience machine check at or about the same time by
>>>> handling "ibm,nmi-interlock" call. In such cases, as per
>>>> PAPR, subsequent processors serialize waiting for the first
>>>> processor to issue the "ibm,nmi-interlock" call. The second
>>>> processor that also received a machine check error waits
>>>> till the first processor is done reading the error log.
>>>> The first processor issues "ibm,nmi-interlock" call
>>>> when the error log is consumed.
>>>>
>>>> Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
>>>> ---
>>>>  hw/ppc/spapr.c         |    6 ++++-
>>>>  hw/ppc/spapr_rtas.c    |   63 ++++++++++++++++++++++++++++++++++++++++++++++++
>>>>  include/hw/ppc/spapr.h |    5 +++-
>>>>  3 files changed, 72 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>>>> index 3d6d139..213d493 100644
>>>> --- a/hw/ppc/spapr.c
>>>> +++ b/hw/ppc/spapr.c
>>>> @@ -2946,6 +2946,9 @@ static void spapr_machine_init(MachineState *machine)
>>>>          /* Create the error string for live migration blocker */
>>>>          error_setg(&spapr->fwnmi_migration_blocker,
>>>>                  "Live migration not supported during machine check handling");
>>>> +
>>>> +        /* Register ibm,nmi-register and ibm,nmi-interlock RTAS calls */
>>>> +        spapr_fwnmi_register();  
>>>
>>> IIRC this was supposed to depend on SPAPR_CAP_FWNMI_MCE being ON.  
>>
>> Yes this is inside SPAPR_CAP_FWNMI_MCE check:
>>
>> if (spapr_get_cap(spapr, SPAPR_CAP_FWNMI_MCE) == SPAPR_CAP_ON) {
>>     /*
>>      * Ensure that the rtas image size is less than RTAS_ERROR_LOG_OFFSET
>>      * or else the rtas image will be overwritten with the rtas error log
>>      * when a machine check exception is encountered.
>>      */
>>     g_assert(spapr->rtas_size < RTAS_ERROR_LOG_OFFSET);
>>
>>     /* Resize rtas blob to accommodate error log */
>>     spapr->rtas_size = RTAS_ERROR_LOG_MAX;
>>
>>     /* Create the error string for live migration blocker */
>>     error_setg(&spapr->fwnmi_migration_blocker,
>>             "Live migration not supported during machine check handling");
>>
>>     /* Register ibm,nmi-register and ibm,nmi-interlock RTAS calls */
>>     spapr_fwnmi_register();
>> }
>>
> 
> Oops my bad... sorry for the noise.
> 
>>
>>>   
>>>>      }
>>>>  
>>>>      spapr->rtas_blob = g_malloc(spapr->rtas_size);
>>>> @@ -4408,7 +4411,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
>>>>      smc->default_caps.caps[SPAPR_CAP_NESTED_KVM_HV] = SPAPR_CAP_OFF;
>>>>      smc->default_caps.caps[SPAPR_CAP_LARGE_DECREMENTER] = SPAPR_CAP_ON;
>>>>      smc->default_caps.caps[SPAPR_CAP_CCF_ASSIST] = SPAPR_CAP_OFF;
>>>> -    smc->default_caps.caps[SPAPR_CAP_FWNMI_MCE] = SPAPR_CAP_OFF;
>>>> +    smc->default_caps.caps[SPAPR_CAP_FWNMI_MCE] = SPAPR_CAP_ON;
>>>>      spapr_caps_add_properties(smc, &error_abort);
>>>>      smc->irq = &spapr_irq_dual;
>>>>      smc->dr_phb_enabled = true;
>>>> @@ -4512,6 +4515,7 @@ static void spapr_machine_3_1_class_options(MachineClass *mc)
>>>>      smc->default_caps.caps[SPAPR_CAP_SBBC] = SPAPR_CAP_BROKEN;
>>>>      smc->default_caps.caps[SPAPR_CAP_IBS] = SPAPR_CAP_BROKEN;
>>>>      smc->default_caps.caps[SPAPR_CAP_LARGE_DECREMENTER] = SPAPR_CAP_OFF;
>>>> +    smc->default_caps.caps[SPAPR_CAP_FWNMI_MCE] = SPAPR_CAP_OFF;  
>>>
>>> This should have been put into spapr_machine_4_0_class_options().  
>>
>> ok. I will change it.
>>
>>>
>>> But unless you manage to get this merged before soft-freeze (2019-07-02),
>>> I'm afraid this will be a 4.2 feature.  
>>
>> If there are no other comments, can this be merged to 4.1? I will send a
>> revised version with the above changes.
>>
> 
> This is David's call.

David, can you let me know if this can be merged to 4.1 with the above
minor changes?

> 
>> Regards,
>> Aravinda
>>
>>>   
>>>>  }
>>>>  
>>>>  DEFINE_SPAPR_MACHINE(3_1, "3.1", false);
>>>> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
>>>> index a015a80..e010cb2 100644
>>>> --- a/hw/ppc/spapr_rtas.c
>>>> +++ b/hw/ppc/spapr_rtas.c
>>>> @@ -49,6 +49,7 @@
>>>>  #include "hw/ppc/fdt.h"
>>>>  #include "target/ppc/mmu-hash64.h"
>>>>  #include "target/ppc/mmu-book3s-v3.h"
>>>> +#include "migration/blocker.h"
>>>>  
>>>>  static void rtas_display_character(PowerPCCPU *cpu, SpaprMachineState *spapr,
>>>>                                     uint32_t token, uint32_t nargs,
>>>> @@ -352,6 +353,60 @@ static void rtas_get_power_level(PowerPCCPU *cpu, SpaprMachineState *spapr,
>>>>      rtas_st(rets, 1, 100);
>>>>  }
>>>>  
>>>> +static void rtas_ibm_nmi_register(PowerPCCPU *cpu,
>>>> +                                  SpaprMachineState *spapr,
>>>> +                                  uint32_t token, uint32_t nargs,
>>>> +                                  target_ulong args,
>>>> +                                  uint32_t nret, target_ulong rets)
>>>> +{
>>>> +    int ret;
>>>> +    hwaddr rtas_addr = spapr_get_rtas_addr();
>>>> +
>>>> +    if (!rtas_addr) {
>>>> +        rtas_st(rets, 0, RTAS_OUT_NOT_SUPPORTED);
>>>> +        return;
>>>> +    }
>>>> +
>>>> +    if (spapr_get_cap(spapr, SPAPR_CAP_FWNMI_MCE) == SPAPR_CAP_OFF) {
>>>> +        rtas_st(rets, 0, RTAS_OUT_NOT_SUPPORTED);
>>>> +        return;
>>>> +    }
>>>> +
>>>> +    ret = kvmppc_fwnmi_enable(cpu);
>>>> +    if (ret == 1) {
>>>> +        rtas_st(rets, 0, RTAS_OUT_NOT_SUPPORTED);
>>>> +        return;
>>>> +    } else if (ret < 0) {
>>>> +        error_report("Couldn't enable KVM FWNMI capability");
>>>> +        rtas_st(rets, 0, RTAS_OUT_HW_ERROR);
>>>> +        return;
>>>> +    }
>>>> +
>>>> +    spapr->guest_machine_check_addr = rtas_ld(args, 1);
>>>> +    rtas_st(rets, 0, RTAS_OUT_SUCCESS);
>>>> +}
>>>> +
>>>> +static void rtas_ibm_nmi_interlock(PowerPCCPU *cpu,
>>>> +                                   SpaprMachineState *spapr,
>>>> +                                   uint32_t token, uint32_t nargs,
>>>> +                                   target_ulong args,
>>>> +                                   uint32_t nret, target_ulong rets)
>>>> +{
>>>> +    if (spapr->guest_machine_check_addr == -1) {
>>>> +        /* NMI register not called */
>>>> +        rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
>>>> +    } else {
>>>> +        /*
>>>> +         * vCPU issuing "ibm,nmi-interlock" is done with NMI handling,
>>>> +         * hence unset mc_status.
>>>> +         */
>>>> +        spapr->mc_status = -1;
>>>> +        qemu_cond_signal(&spapr->mc_delivery_cond);
>>>> +        migrate_del_blocker(spapr->fwnmi_migration_blocker);
>>>> +        rtas_st(rets, 0, RTAS_OUT_SUCCESS);
>>>> +    }
>>>> +}
>>>> +
>>>>  static struct rtas_call {
>>>>      const char *name;
>>>>      spapr_rtas_fn fn;
>>>> @@ -496,6 +551,14 @@ hwaddr spapr_get_rtas_addr(void)
>>>>      return (hwaddr)fdt32_to_cpu(*rtas_data);
>>>>  }
>>>>  
>>>> +void spapr_fwnmi_register(void)
>>>> +{
>>>> +    spapr_rtas_register(RTAS_IBM_NMI_REGISTER, "ibm,nmi-register",
>>>> +                        rtas_ibm_nmi_register);
>>>> +    spapr_rtas_register(RTAS_IBM_NMI_INTERLOCK, "ibm,nmi-interlock",
>>>> +                        rtas_ibm_nmi_interlock);
>>>> +}
>>>> +
>>>>  static void core_rtas_register_types(void)
>>>>  {
>>>>      spapr_rtas_register(RTAS_DISPLAY_CHARACTER, "display-character",
>>>> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
>>>> index 0dedf0a..7ae53e2 100644
>>>> --- a/include/hw/ppc/spapr.h
>>>> +++ b/include/hw/ppc/spapr.h
>>>> @@ -637,8 +637,10 @@ target_ulong spapr_hypercall(PowerPCCPU *cpu, target_ulong opcode,
>>>>  #define RTAS_IBM_CREATE_PE_DMA_WINDOW           (RTAS_TOKEN_BASE + 0x27)
>>>>  #define RTAS_IBM_REMOVE_PE_DMA_WINDOW           (RTAS_TOKEN_BASE + 0x28)
>>>>  #define RTAS_IBM_RESET_PE_DMA_WINDOW            (RTAS_TOKEN_BASE + 0x29)
>>>> +#define RTAS_IBM_NMI_REGISTER                   (RTAS_TOKEN_BASE + 0x2A)
>>>> +#define RTAS_IBM_NMI_INTERLOCK                  (RTAS_TOKEN_BASE + 0x2B)
>>>>  
>>>> -#define RTAS_TOKEN_MAX                          (RTAS_TOKEN_BASE + 0x2A)
>>>> +#define RTAS_TOKEN_MAX                          (RTAS_TOKEN_BASE + 0x2C)
>>>>  
>>>>  /* RTAS ibm,get-system-parameter token values */
>>>>  #define RTAS_SYSPARM_SPLPAR_CHARACTERISTICS      20
>>>> @@ -894,4 +896,5 @@ void spapr_check_pagesize(SpaprMachineState *spapr, hwaddr pagesize,
>>>>  
>>>>  void spapr_set_all_lpcrs(target_ulong value, target_ulong mask);
>>>>  hwaddr spapr_get_rtas_addr(void);
>>>> +void spapr_fwnmi_register(void);
>>>>  #endif /* HW_SPAPR_H */
>>>>  
>>>   
>>
> 
> 

-- 
Regards,
Aravinda


