Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BA86C5B578
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 07:18:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CC0B21882
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 07:18:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CC0B21882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiZXR-0003LL-2h
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 03:18:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59119)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aravinda@linux.vnet.ibm.com>) id 1hiZVy-0002nW-UA
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 03:17:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aravinda@linux.vnet.ibm.com>) id 1hiZVw-00077P-K9
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 03:17:14 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58930)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aravinda@linux.vnet.ibm.com>)
 id 1hiZVp-0006qM-6f; Wed, 03 Jul 2019 03:17:06 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x637FAl4118584; Wed, 3 Jul 2019 03:16:28 -0400
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com
 [169.55.85.253])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2tgpa23bf5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 03 Jul 2019 03:16:28 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
 by ppma01wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x637Ejvo029157;
 Wed, 3 Jul 2019 07:16:27 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by ppma01wdc.us.ibm.com with ESMTP id 2tdym6uwtg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 03 Jul 2019 07:16:27 +0000
Received: from b03ledav006.gho.boulder.ibm.com
 (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x637GQV046989716
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 3 Jul 2019 07:16:26 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 30EEBC6057;
 Wed,  3 Jul 2019 07:16:26 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2AB76C6055;
 Wed,  3 Jul 2019 07:16:24 +0000 (GMT)
Received: from [9.124.31.179] (unknown [9.124.31.179])
 by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
 Wed,  3 Jul 2019 07:16:23 +0000 (GMT)
To: David Gibson <david@gibson.dropbear.id.au>
References: <156033104292.26635.15759339817253067370.stgit@aravinda>
 <156033128111.26635.16279854031001093005.stgit@aravinda>
 <20190702040307.GI6779@umbus.fritz.box>
 <80028d4d-88a7-4f90-f26d-52559857c66d@linux.vnet.ibm.com>
 <20190703030700.GH9442@umbus.fritz.box>
From: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Message-ID: <b2804eaa-b18b-cd32-e8c3-d0d0a023ee5f@linux.vnet.ibm.com>
Date: Wed, 3 Jul 2019 12:46:22 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20190703030700.GH9442@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-07-03_02:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907030086
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
Subject: Re: [Qemu-devel] [PATCH v10 4/6] target/ppc: Build rtas error log
 upon an MCE
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
Cc: aik@au1.ibm.com, qemu-devel@nongnu.org, groug@kaod.org, paulus@ozlabs.org,
 qemu-ppc@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On Wednesday 03 July 2019 08:37 AM, David Gibson wrote:
> On Tue, Jul 02, 2019 at 03:19:24PM +0530, Aravinda Prasad wrote:
>>
>>
>> On Tuesday 02 July 2019 09:33 AM, David Gibson wrote:
>>> On Wed, Jun 12, 2019 at 02:51:21PM +0530, Aravinda Prasad wrote:
>>>> Upon a machine check exception (MCE) in a guest address space,
>>>> KVM causes a guest exit to enable QEMU to build and pass the
>>>> error to the guest in the PAPR defined rtas error log format.
>>>>
>>>> This patch builds the rtas error log, copies it to the rtas_addr
>>>> and then invokes the guest registered machine check handler. The
>>>> handler in the guest takes suitable action(s) depending on the type
>>>> and criticality of the error. For example, if an error is
>>>> unrecoverable memory corruption in an application inside the
>>>> guest, then the guest kernel sends a SIGBUS to the application.
>>>> For recoverable errors, the guest performs recovery actions and
>>>> logs the error.
>>>>
>>>> Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
>>>> ---
>>>>  hw/ppc/spapr.c         |   13 +++
>>>>  hw/ppc/spapr_events.c  |  238 ++++++++++++++++++++++++++++++++++++++++++++++++
>>>>  hw/ppc/spapr_rtas.c    |   26 +++++
>>>>  include/hw/ppc/spapr.h |    6 +
>>>>  target/ppc/kvm.c       |    4 +
>>>>  5 files changed, 284 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>>>> index 6cc2c3b..d61905b 100644
>>>> --- a/hw/ppc/spapr.c
>>>> +++ b/hw/ppc/spapr.c
>>>> @@ -2908,6 +2908,19 @@ static void spapr_machine_init(MachineState *machine)
>>>>          error_report("Could not get size of LPAR rtas '%s'", filename);
>>>>          exit(1);
>>>>      }
>>>> +
>>>> +    if (spapr_get_cap(spapr, SPAPR_CAP_FWNMI_MCE) == SPAPR_CAP_ON) {
>>>> +        /*
>>>> +         * Ensure that the rtas image size is less than RTAS_ERROR_LOG_OFFSET
>>>> +         * or else the rtas image will be overwritten with the rtas error log
>>>> +         * when a machine check exception is encountered.
>>>> +         */
>>>> +        g_assert(spapr->rtas_size < RTAS_ERROR_LOG_OFFSET);
>>>> +
>>>> +        /* Resize rtas blob to accommodate error log */
>>>> +        spapr->rtas_size = RTAS_ERROR_LOG_MAX;
>>>> +    }
>>>> +
>>>>      spapr->rtas_blob = g_malloc(spapr->rtas_size);
>>>>      if (load_image_size(filename, spapr->rtas_blob, spapr->rtas_size) < 0) {
>>>>          error_report("Could not load LPAR rtas '%s'", filename);
>>>> diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
>>>> index a0c66d7..51c052e 100644
>>>> --- a/hw/ppc/spapr_events.c
>>>> +++ b/hw/ppc/spapr_events.c
>>>> @@ -212,6 +212,106 @@ struct hp_extended_log {
>>>>      struct rtas_event_log_v6_hp hp;
>>>>  } QEMU_PACKED;
>>>>  
>>>> +struct rtas_event_log_v6_mc {
>>>> +#define RTAS_LOG_V6_SECTION_ID_MC                   0x4D43 /* MC */
>>>> +    struct rtas_event_log_v6_section_header hdr;
>>>> +    uint32_t fru_id;
>>>> +    uint32_t proc_id;
>>>> +    uint8_t error_type;
>>>> +#define RTAS_LOG_V6_MC_TYPE_UE                           0
>>>> +#define RTAS_LOG_V6_MC_TYPE_SLB                          1
>>>> +#define RTAS_LOG_V6_MC_TYPE_ERAT                         2
>>>> +#define RTAS_LOG_V6_MC_TYPE_TLB                          4
>>>> +#define RTAS_LOG_V6_MC_TYPE_D_CACHE                      5
>>>> +#define RTAS_LOG_V6_MC_TYPE_I_CACHE                      7
>>>> +    uint8_t sub_err_type;
>>>> +#define RTAS_LOG_V6_MC_UE_INDETERMINATE                  0
>>>> +#define RTAS_LOG_V6_MC_UE_IFETCH                         1
>>>> +#define RTAS_LOG_V6_MC_UE_PAGE_TABLE_WALK_IFETCH         2
>>>> +#define RTAS_LOG_V6_MC_UE_LOAD_STORE                     3
>>>> +#define RTAS_LOG_V6_MC_UE_PAGE_TABLE_WALK_LOAD_STORE     4
>>>> +#define RTAS_LOG_V6_MC_SLB_PARITY                        0
>>>> +#define RTAS_LOG_V6_MC_SLB_MULTIHIT                      1
>>>> +#define RTAS_LOG_V6_MC_SLB_INDETERMINATE                 2
>>>> +#define RTAS_LOG_V6_MC_ERAT_PARITY                       1
>>>> +#define RTAS_LOG_V6_MC_ERAT_MULTIHIT                     2
>>>> +#define RTAS_LOG_V6_MC_ERAT_INDETERMINATE                3
>>>> +#define RTAS_LOG_V6_MC_TLB_PARITY                        1
>>>> +#define RTAS_LOG_V6_MC_TLB_MULTIHIT                      2
>>>> +#define RTAS_LOG_V6_MC_TLB_INDETERMINATE                 3
>>>> +    uint8_t reserved_1[6];
>>>> +    uint64_t effective_address;
>>>> +    uint64_t logical_address;
>>>> +} QEMU_PACKED;
>>>> +
>>>> +struct mc_extended_log {
>>>> +    struct rtas_event_log_v6 v6hdr;
>>>> +    struct rtas_event_log_v6_mc mc;
>>>> +} QEMU_PACKED;
>>>> +
>>>> +struct MC_ierror_table {
>>>> +    unsigned long srr1_mask;
>>>> +    unsigned long srr1_value;
>>>> +    bool nip_valid; /* nip is a valid indicator of faulting address */
>>>> +    uint8_t error_type;
>>>> +    uint8_t error_subtype;
>>>> +    unsigned int initiator;
>>>> +    unsigned int severity;
>>>> +};
>>>> +
>>>> +static const struct MC_ierror_table mc_ierror_table[] = {
>>>> +{ 0x00000000081c0000, 0x0000000000040000, true,
>>>> +  RTAS_LOG_V6_MC_TYPE_UE, RTAS_LOG_V6_MC_UE_IFETCH,
>>>> +  RTAS_LOG_INITIATOR_CPU, RTAS_LOG_SEVERITY_ERROR_SYNC, },
>>>> +{ 0x00000000081c0000, 0x0000000000080000, true,
>>>> +  RTAS_LOG_V6_MC_TYPE_SLB, RTAS_LOG_V6_MC_SLB_PARITY,
>>>> +  RTAS_LOG_INITIATOR_CPU, RTAS_LOG_SEVERITY_ERROR_SYNC, },
>>>> +{ 0x00000000081c0000, 0x00000000000c0000, true,
>>>> +  RTAS_LOG_V6_MC_TYPE_SLB, RTAS_LOG_V6_MC_SLB_MULTIHIT,
>>>> +  RTAS_LOG_INITIATOR_CPU, RTAS_LOG_SEVERITY_ERROR_SYNC, },
>>>> +{ 0x00000000081c0000, 0x0000000000100000, true,
>>>> +  RTAS_LOG_V6_MC_TYPE_ERAT, RTAS_LOG_V6_MC_ERAT_MULTIHIT,
>>>> +  RTAS_LOG_INITIATOR_CPU, RTAS_LOG_SEVERITY_ERROR_SYNC, },
>>>> +{ 0x00000000081c0000, 0x0000000000140000, true,
>>>> +  RTAS_LOG_V6_MC_TYPE_TLB, RTAS_LOG_V6_MC_TLB_MULTIHIT,
>>>> +  RTAS_LOG_INITIATOR_CPU, RTAS_LOG_SEVERITY_ERROR_SYNC, },
>>>> +{ 0x00000000081c0000, 0x0000000000180000, true,
>>>> +  RTAS_LOG_V6_MC_TYPE_UE, RTAS_LOG_V6_MC_UE_PAGE_TABLE_WALK_IFETCH,
>>>> +  RTAS_LOG_INITIATOR_CPU, RTAS_LOG_SEVERITY_ERROR_SYNC, },
>>>> +{ 0, 0, 0, 0, 0, 0 } };
>>>> +
>>>> +struct MC_derror_table {
>>>> +    unsigned long dsisr_value;
>>>> +    bool dar_valid; /* dar is a valid indicator of faulting address */
>>>> +    uint8_t error_type;
>>>> +    uint8_t error_subtype;
>>>> +    unsigned int initiator;
>>>> +    unsigned int severity;
>>>> +};
>>>> +
>>>> +static const struct MC_derror_table mc_derror_table[] = {
>>>> +{ 0x00008000, false,
>>>> +  RTAS_LOG_V6_MC_TYPE_UE, RTAS_LOG_V6_MC_UE_LOAD_STORE,
>>>> +  RTAS_LOG_INITIATOR_CPU, RTAS_LOG_SEVERITY_ERROR_SYNC, },
>>>> +{ 0x00004000, true,
>>>> +  RTAS_LOG_V6_MC_TYPE_UE, RTAS_LOG_V6_MC_UE_PAGE_TABLE_WALK_LOAD_STORE,
>>>> +  RTAS_LOG_INITIATOR_CPU, RTAS_LOG_SEVERITY_ERROR_SYNC, },
>>>> +{ 0x00000800, true,
>>>> +  RTAS_LOG_V6_MC_TYPE_ERAT, RTAS_LOG_V6_MC_ERAT_MULTIHIT,
>>>> +  RTAS_LOG_INITIATOR_CPU, RTAS_LOG_SEVERITY_ERROR_SYNC, },
>>>> +{ 0x00000400, true,
>>>> +  RTAS_LOG_V6_MC_TYPE_TLB, RTAS_LOG_V6_MC_TLB_MULTIHIT,
>>>> +  RTAS_LOG_INITIATOR_CPU, RTAS_LOG_SEVERITY_ERROR_SYNC, },
>>>> +{ 0x00000080, true,
>>>> +  RTAS_LOG_V6_MC_TYPE_SLB, RTAS_LOG_V6_MC_SLB_MULTIHIT,  /* Before PARITY */
>>>> +  RTAS_LOG_INITIATOR_CPU, RTAS_LOG_SEVERITY_ERROR_SYNC, },
>>>> +{ 0x00000100, true,
>>>> +  RTAS_LOG_V6_MC_TYPE_SLB, RTAS_LOG_V6_MC_SLB_PARITY,
>>>> +  RTAS_LOG_INITIATOR_CPU, RTAS_LOG_SEVERITY_ERROR_SYNC, },
>>>> +{ 0, false, 0, 0, 0, 0 } };
>>>> +
>>>> +#define SRR1_MC_LOADSTORE(srr1) ((srr1) & PPC_BIT(42))
>>>> +
>>>>  typedef enum EventClass {
>>>>      EVENT_CLASS_INTERNAL_ERRORS     = 0,
>>>>      EVENT_CLASS_EPOW                = 1,
>>>> @@ -620,7 +720,141 @@ void spapr_hotplug_req_remove_by_count_indexed(SpaprDrcType drc_type,
>>>>                              RTAS_LOG_V6_HP_ACTION_REMOVE, drc_type, &drc_id);
>>>>  }
>>>>  
>>>> -void spapr_mce_req_event(PowerPCCPU *cpu)
>>>> +static uint32_t spapr_mce_get_elog_type(PowerPCCPU *cpu, bool recovered,
>>>> +                                        struct mc_extended_log *ext_elog)
>>>> +{
>>>> +    int i;
>>>> +    CPUPPCState *env = &cpu->env;
>>>> +    uint32_t summary;
>>>> +    uint64_t dsisr = env->spr[SPR_DSISR];
>>>> +
>>>> +    summary = RTAS_LOG_VERSION_6 | RTAS_LOG_OPTIONAL_PART_PRESENT;
>>>> +    if (recovered) {
>>>> +        summary |= RTAS_LOG_DISPOSITION_FULLY_RECOVERED;
>>>> +    } else {
>>>> +        summary |= RTAS_LOG_DISPOSITION_NOT_RECOVERED;
>>>> +    }
>>>> +
>>>> +    if (SRR1_MC_LOADSTORE(env->spr[SPR_SRR1])) {
>>>> +        for (i = 0; mc_derror_table[i].dsisr_value; i++) {
>>>> +            if (!(dsisr & mc_derror_table[i].dsisr_value)) {
>>>> +                continue;
>>>> +            }
>>>> +
>>>> +            ext_elog->mc.error_type = mc_derror_table[i].error_type;
>>>> +            ext_elog->mc.sub_err_type = mc_derror_table[i].error_subtype;
>>>> +            if (mc_derror_table[i].dar_valid) {
>>>> +                ext_elog->mc.effective_address = cpu_to_be64(env->spr[SPR_DAR]);
>>>> +            }
>>>> +
>>>> +            summary |= mc_derror_table[i].initiator
>>>> +                        | mc_derror_table[i].severity;
>>>> +
>>>> +            return summary;
>>>> +        }
>>>> +    } else {
>>>> +        for (i = 0; mc_ierror_table[i].srr1_mask; i++) {
>>>> +            if ((env->spr[SPR_SRR1] & mc_ierror_table[i].srr1_mask) !=
>>>> +                    mc_ierror_table[i].srr1_value) {
>>>> +                continue;
>>>> +            }
>>>> +
>>>> +            ext_elog->mc.error_type = mc_ierror_table[i].error_type;
>>>> +            ext_elog->mc.sub_err_type = mc_ierror_table[i].error_subtype;
>>>> +            if (mc_ierror_table[i].nip_valid) {
>>>> +                ext_elog->mc.effective_address = cpu_to_be64(env->nip);
>>>> +            }
>>>> +
>>>> +            summary |= mc_ierror_table[i].initiator
>>>> +                        | mc_ierror_table[i].severity;
>>>> +
>>>> +            return summary;
>>>> +        }
>>>> +    }
>>>> +
>>>> +    summary |= RTAS_LOG_INITIATOR_CPU;
>>>> +    return summary;
>>>> +}
>>>> +
>>>> +static void spapr_mce_dispatch_elog(PowerPCCPU *cpu, bool recovered)
>>>> +{
>>>> +    SpaprMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
>>>> +    CPUState *cs = CPU(cpu);
>>>> +    uint64_t rtas_addr;
>>>> +    CPUPPCState *env = &cpu->env;
>>>> +    PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
>>>> +    target_ulong r3, msr = 0;
>>>> +    struct rtas_error_log log;
>>>> +    struct mc_extended_log *ext_elog;
>>>> +    uint32_t summary;
>>>> +
>>>> +    /*
>>>> +     * Properly set bits in MSR before we invoke the handler.
>>>> +     * SRR0/1, DAR and DSISR are properly set by KVM
>>>> +     */
>>>> +    if (!(*pcc->interrupts_big_endian)(cpu)) {
>>>> +        msr |= (1ULL << MSR_LE);
>>>> +    }
>>>> +
>>>> +    if (env->msr & (1ULL << MSR_SF)) {
>>>> +        msr |= (1ULL << MSR_SF);
>>>> +    }
>>>> +
>>>> +    msr |= (1ULL << MSR_ME);
>>>> +
>>>> +    if (spapr->guest_machine_check_addr == -1) {
>>>> +        /*
>>>> +         * This implies that we have hit a machine check between system
>>>> +         * reset and "ibm,nmi-register". Fall back to the old machine
>>>> +         * check behavior in such cases.
>>>> +         */
>>>> +        env->spr[SPR_SRR0] = env->nip;
>>>> +        env->spr[SPR_SRR1] = env->msr;
>>>> +        env->msr = msr;
>>>> +        env->nip = 0x200;
>>>> +        return;
>>>
>>> Hm, does this differ from what ppc_cpu_do_system_reset() will do?
>>
>> Not much, but we branch to 0x200 instead of 0x100. But I think calling
>>
>> powerpc_excp(cpu, env->excp_model, POWERPC_EXCP_MCHECK)
>>
>> should also work. Let me if you prefer using powerpc_excp().
> 
> Yes, I'd prefer to share code with existing exception paths where
> possible.

sure.

> 

-- 
Regards,
Aravinda

