Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC3CBECDE28
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 06:05:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4C1421928
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 06:05:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4C1421928
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7vkT-0006Dq-ST
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 02:05:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33989)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aravinda@linux.vnet.ibm.com>) id 1i7vix-0005Sq-OR
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 02:03:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aravinda@linux.vnet.ibm.com>) id 1i7viw-00086y-EK
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 02:03:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:62348
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aravinda@linux.vnet.ibm.com>)
 id 1i7vit-00085k-CL; Wed, 11 Sep 2019 02:03:23 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x8B62UD2125005; Wed, 11 Sep 2019 02:03:10 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.10])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2uxpb8021s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 11 Sep 2019 02:03:10 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
 by ppma02dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x8B5xZie023043;
 Wed, 11 Sep 2019 06:03:09 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29]) by ppma02dal.us.ibm.com with ESMTP id 2uv467h0sp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 11 Sep 2019 06:03:09 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com
 [9.57.199.111])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x8B638Ma40370650
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 11 Sep 2019 06:03:08 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 443B6AC062;
 Wed, 11 Sep 2019 06:03:08 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 67EDFAC059;
 Wed, 11 Sep 2019 06:03:06 +0000 (GMT)
Received: from [9.102.2.149] (unknown [9.102.2.149])
 by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
 Wed, 11 Sep 2019 06:03:06 +0000 (GMT)
To: Greg Kurz <groug@kaod.org>
References: <156801373576.24362.1904051970114447107.stgit@aravinda>
 <156801389377.24362.17801924925988245591.stgit@aravinda>
 <20190909171908.2b8f8343@bahia.lan>
From: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Message-ID: <0d986bc1-9dfb-0d8a-6cc3-305f0b7e924a@linux.vnet.ibm.com>
Date: Wed, 11 Sep 2019 11:33:05 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20190909171908.2b8f8343@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-09-11_04:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1909110058
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
Subject: Re: [Qemu-devel] [PATCH v13 5/6] ppc: spapr: Handle "ibm,
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
Cc: aik@ozlabs.ru, qemu-devel@nongnu.org, paulus@ozlabs.org,
 qemu-ppc@nongnu.org, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On Monday 09 September 2019 08:49 PM, Greg Kurz wrote:
> On Mon, 09 Sep 2019 12:54:53 +0530
> Aravinda Prasad <aravinda@linux.vnet.ibm.com> wrote:
> 
>> This patch adds support in QEMU to handle "ibm,nmi-register"
>> and "ibm,nmi-interlock" RTAS calls and sets the default
>> value of SPAPR_CAP_FWNMI_MCE to SPAPR_CAP_ON for machine
>> type 4.2.
>>
> 
> I'd rather activate the feature for the default machine type at the end
> of the series, when we have everything in place, including migration.

I can do that by having a separate patch.

> 
>> The machine check notification address is saved when the
>> OS issues "ibm,nmi-register" RTAS call.
>>
>> This patch also handles the case when multiple processors
>> experience machine check at or about the same time by
>> handling "ibm,nmi-interlock" call. In such cases, as per
>> PAPR, subsequent processors serialize waiting for the first
>> processor to issue the "ibm,nmi-interlock" call. The second
>> processor that also received a machine check error waits
>> till the first processor is done reading the error log.
>> The first processor issues "ibm,nmi-interlock" call
>> when the error log is consumed.
>>
>> Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
>> ---
>>  hw/ppc/spapr.c         |   12 +++++++++++-
>>  hw/ppc/spapr_rtas.c    |   50 ++++++++++++++++++++++++++++++++++++++++++++++++
>>  include/hw/ppc/spapr.h |    5 ++++-
>>  3 files changed, 65 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>> index 9f2e5d2..1c0908e 100644
>> --- a/hw/ppc/spapr.c
>> +++ b/hw/ppc/spapr.c
>> @@ -2941,6 +2941,15 @@ static void spapr_machine_init(MachineState *machine)
>>  
>>          /* Resize rtas blob to accommodate error log */
>>          spapr->rtas_size = RTAS_ERROR_LOG_MAX;
>> +
>> +        /* Set fwnmi capability in KVM */
>> +        if (kvmppc_set_fwnmi() < 0) {
>> +            error_report("Could not enable FWNMI capability");
>> +            exit(1);
>> +        }
>> +
>> +        /* Register ibm,nmi-register and ibm,nmi-interlock RTAS calls */
>> +        spapr_fwnmi_register();
>>      }
>>  
>>      spapr->rtas_blob = g_malloc(spapr->rtas_size);
>> @@ -4508,7 +4517,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
>>      smc->default_caps.caps[SPAPR_CAP_NESTED_KVM_HV] = SPAPR_CAP_OFF;
>>      smc->default_caps.caps[SPAPR_CAP_LARGE_DECREMENTER] = SPAPR_CAP_ON;
>>      smc->default_caps.caps[SPAPR_CAP_CCF_ASSIST] = SPAPR_CAP_OFF;
>> -    smc->default_caps.caps[SPAPR_CAP_FWNMI_MCE] = SPAPR_CAP_OFF;
>> +    smc->default_caps.caps[SPAPR_CAP_FWNMI_MCE] = SPAPR_CAP_ON;
>>      spapr_caps_add_properties(smc, &error_abort);
>>      smc->irq = &spapr_irq_dual;
>>      smc->dr_phb_enabled = true;
>> @@ -4582,6 +4591,7 @@ static void spapr_machine_4_1_class_options(MachineClass *mc)
>>      smc->linux_pci_probe = false;
>>      compat_props_add(mc->compat_props, hw_compat_4_1, hw_compat_4_1_len);
>>      compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
>> +    smc->default_caps.caps[SPAPR_CAP_FWNMI_MCE] = SPAPR_CAP_OFF;
>>  }
>>  
>>  DEFINE_SPAPR_MACHINE(4_1, "4.1", false);
>> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
>> index d8fb8a8..d892583 100644
>> --- a/hw/ppc/spapr_rtas.c
>> +++ b/hw/ppc/spapr_rtas.c
>> @@ -400,6 +400,48 @@ static void rtas_get_power_level(PowerPCCPU *cpu, SpaprMachineState *spapr,
>>      rtas_st(rets, 1, 100);
>>  }
>>  
>> +static void rtas_ibm_nmi_register(PowerPCCPU *cpu,
>> +                                  SpaprMachineState *spapr,
>> +                                  uint32_t token, uint32_t nargs,
>> +                                  target_ulong args,
>> +                                  uint32_t nret, target_ulong rets)
>> +{
>> +    hwaddr rtas_addr = spapr_get_rtas_addr();
>> +
>> +    if (!rtas_addr) {
>> +        rtas_st(rets, 0, RTAS_OUT_NOT_SUPPORTED);
>> +        return;
>> +    }
>> +
>> +    if (spapr_get_cap(spapr, SPAPR_CAP_FWNMI_MCE) == SPAPR_CAP_OFF) {
>> +        rtas_st(rets, 0, RTAS_OUT_NOT_SUPPORTED);
>> +        return;
>> +    }
>> +
>> +    spapr->guest_machine_check_addr = rtas_ld(args, 1);
>> +    rtas_st(rets, 0, RTAS_OUT_SUCCESS);
>> +}
>> +
>> +static void rtas_ibm_nmi_interlock(PowerPCCPU *cpu,
>> +                                   SpaprMachineState *spapr,
>> +                                   uint32_t token, uint32_t nargs,
>> +                                   target_ulong args,
>> +                                   uint32_t nret, target_ulong rets)
>> +{
>> +    if (spapr->guest_machine_check_addr == -1) {
>> +        /* NMI register not called */
>> +        rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
>> +    } else {
>> +        /*
>> +         * vCPU issuing "ibm,nmi-interlock" is done with NMI handling,
>> +         * hence unset mc_status.
>> +         */
> 
> We only expect the vCPU that handled the NMI to call this, right ?
> Shouldn't we return an error if this gets called by some other
> vCPU ?

Yes, vCPU that encountered the machine check should call
ibm,nmi-interlock. I will add a check.

Regards,
Aravinda

> 
>> +        spapr->mc_status = -1;
>> +        qemu_cond_signal(&spapr->mc_delivery_cond);
>> +        rtas_st(rets, 0, RTAS_OUT_SUCCESS);
>> +    }
>> +}
>> +
>>  static struct rtas_call {
>>      const char *name;
>>      spapr_rtas_fn fn;
>> @@ -544,6 +586,14 @@ hwaddr spapr_get_rtas_addr(void)
>>      return (hwaddr)fdt32_to_cpu(*rtas_data);
>>  }
>>  
>> +void spapr_fwnmi_register(void)
>> +{
>> +    spapr_rtas_register(RTAS_IBM_NMI_REGISTER, "ibm,nmi-register",
>> +                        rtas_ibm_nmi_register);
>> +    spapr_rtas_register(RTAS_IBM_NMI_INTERLOCK, "ibm,nmi-interlock",
>> +                        rtas_ibm_nmi_interlock);
>> +}
>> +
>>  static void core_rtas_register_types(void)
>>  {
>>      spapr_rtas_register(RTAS_DISPLAY_CHARACTER, "display-character",
>> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
>> index ffefde7..dada821 100644
>> --- a/include/hw/ppc/spapr.h
>> +++ b/include/hw/ppc/spapr.h
>> @@ -655,8 +655,10 @@ target_ulong spapr_hypercall(PowerPCCPU *cpu, target_ulong opcode,
>>  #define RTAS_IBM_REMOVE_PE_DMA_WINDOW           (RTAS_TOKEN_BASE + 0x28)
>>  #define RTAS_IBM_RESET_PE_DMA_WINDOW            (RTAS_TOKEN_BASE + 0x29)
>>  #define RTAS_IBM_SUSPEND_ME                     (RTAS_TOKEN_BASE + 0x2A)
>> +#define RTAS_IBM_NMI_REGISTER                   (RTAS_TOKEN_BASE + 0x2B)
>> +#define RTAS_IBM_NMI_INTERLOCK                  (RTAS_TOKEN_BASE + 0x2C)
>>  
>> -#define RTAS_TOKEN_MAX                          (RTAS_TOKEN_BASE + 0x2B)
>> +#define RTAS_TOKEN_MAX                          (RTAS_TOKEN_BASE + 0x2D)
>>  
>>  /* RTAS ibm,get-system-parameter token values */
>>  #define RTAS_SYSPARM_SPLPAR_CHARACTERISTICS      20
>> @@ -908,4 +910,5 @@ void spapr_check_pagesize(SpaprMachineState *spapr, hwaddr pagesize,
>>  
>>  void spapr_set_all_lpcrs(target_ulong value, target_ulong mask);
>>  hwaddr spapr_get_rtas_addr(void);
>> +void spapr_fwnmi_register(void);
>>  #endif /* HW_SPAPR_H */
>>
> 

-- 
Regards,
Aravinda

