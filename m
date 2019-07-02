Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E708C06513
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 09:51:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A70C206A2
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 09:51:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A70C206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiFRG-0002lR-MD
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 05:51:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40150)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aravinda@linux.vnet.ibm.com>) id 1hiFPz-0001Du-HC
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 05:49:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aravinda@linux.vnet.ibm.com>) id 1hiFPx-0008N7-CJ
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 05:49:43 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:64932)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aravinda@linux.vnet.ibm.com>)
 id 1hiFPx-0008KE-10
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 05:49:41 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x629m43X097252
 for <qemu-devel@nongnu.org>; Tue, 2 Jul 2019 05:49:34 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2tg3644jwd-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2019 05:49:34 -0400
Received: from localhost
 by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <aravinda@linux.vnet.ibm.com>;
 Tue, 2 Jul 2019 10:49:32 +0100
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
 by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 2 Jul 2019 10:49:29 +0100
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com
 [9.57.199.106])
 by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x629nSpJ44433764
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 2 Jul 2019 09:49:28 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3749E2805C;
 Tue,  2 Jul 2019 09:49:28 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7ED742805A;
 Tue,  2 Jul 2019 09:49:25 +0000 (GMT)
Received: from [9.102.27.232] (unknown [9.102.27.232])
 by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
 Tue,  2 Jul 2019 09:49:25 +0000 (GMT)
To: David Gibson <david@gibson.dropbear.id.au>
References: <156033104292.26635.15759339817253067370.stgit@aravinda>
 <156033128111.26635.16279854031001093005.stgit@aravinda>
 <20190702040307.GI6779@umbus.fritz.box>
From: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Date: Tue, 2 Jul 2019 15:19:24 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20190702040307.GI6779@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19070209-2213-0000-0000-000003A7625D
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011365; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01226316; UDB=6.00645590; IPR=6.01007528; 
 MB=3.00027550; MTD=3.00000008; XFM=3.00000015; UTC=2019-07-02 09:49:31
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19070209-2214-0000-0000-00005F12F524
Message-Id: <80028d4d-88a7-4f90-f26d-52559857c66d@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-07-02_06:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907020114
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



On Tuesday 02 July 2019 09:33 AM, David Gibson wrote:
> On Wed, Jun 12, 2019 at 02:51:21PM +0530, Aravinda Prasad wrote:
>> Upon a machine check exception (MCE) in a guest address space,
>> KVM causes a guest exit to enable QEMU to build and pass the
>> error to the guest in the PAPR defined rtas error log format.
>>
>> This patch builds the rtas error log, copies it to the rtas_addr
>> and then invokes the guest registered machine check handler. The
>> handler in the guest takes suitable action(s) depending on the type
>> and criticality of the error. For example, if an error is
>> unrecoverable memory corruption in an application inside the
>> guest, then the guest kernel sends a SIGBUS to the application.
>> For recoverable errors, the guest performs recovery actions and
>> logs the error.
>>
>> Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
>> ---
>>  hw/ppc/spapr.c         |   13 +++
>>  hw/ppc/spapr_events.c  |  238 ++++++++++++++++++++++++++++++++++++++++++++++++
>>  hw/ppc/spapr_rtas.c    |   26 +++++
>>  include/hw/ppc/spapr.h |    6 +
>>  target/ppc/kvm.c       |    4 +
>>  5 files changed, 284 insertions(+), 3 deletions(-)
>>
>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>> index 6cc2c3b..d61905b 100644
>> --- a/hw/ppc/spapr.c
>> +++ b/hw/ppc/spapr.c
>> @@ -2908,6 +2908,19 @@ static void spapr_machine_init(MachineState *machine)
>>          error_report("Could not get size of LPAR rtas '%s'", filename);
>>          exit(1);
>>      }
>> +
>> +    if (spapr_get_cap(spapr, SPAPR_CAP_FWNMI_MCE) == SPAPR_CAP_ON) {
>> +        /*
>> +         * Ensure that the rtas image size is less than RTAS_ERROR_LOG_OFFSET
>> +         * or else the rtas image will be overwritten with the rtas error log
>> +         * when a machine check exception is encountered.
>> +         */
>> +        g_assert(spapr->rtas_size < RTAS_ERROR_LOG_OFFSET);
>> +
>> +        /* Resize rtas blob to accommodate error log */
>> +        spapr->rtas_size = RTAS_ERROR_LOG_MAX;
>> +    }
>> +
>>      spapr->rtas_blob = g_malloc(spapr->rtas_size);
>>      if (load_image_size(filename, spapr->rtas_blob, spapr->rtas_size) < 0) {
>>          error_report("Could not load LPAR rtas '%s'", filename);
>> diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
>> index a0c66d7..51c052e 100644
>> --- a/hw/ppc/spapr_events.c
>> +++ b/hw/ppc/spapr_events.c
>> @@ -212,6 +212,106 @@ struct hp_extended_log {
>>      struct rtas_event_log_v6_hp hp;
>>  } QEMU_PACKED;
>>  
>> +struct rtas_event_log_v6_mc {
>> +#define RTAS_LOG_V6_SECTION_ID_MC                   0x4D43 /* MC */
>> +    struct rtas_event_log_v6_section_header hdr;
>> +    uint32_t fru_id;
>> +    uint32_t proc_id;
>> +    uint8_t error_type;
>> +#define RTAS_LOG_V6_MC_TYPE_UE                           0
>> +#define RTAS_LOG_V6_MC_TYPE_SLB                          1
>> +#define RTAS_LOG_V6_MC_TYPE_ERAT                         2
>> +#define RTAS_LOG_V6_MC_TYPE_TLB                          4
>> +#define RTAS_LOG_V6_MC_TYPE_D_CACHE                      5
>> +#define RTAS_LOG_V6_MC_TYPE_I_CACHE                      7
>> +    uint8_t sub_err_type;
>> +#define RTAS_LOG_V6_MC_UE_INDETERMINATE                  0
>> +#define RTAS_LOG_V6_MC_UE_IFETCH                         1
>> +#define RTAS_LOG_V6_MC_UE_PAGE_TABLE_WALK_IFETCH         2
>> +#define RTAS_LOG_V6_MC_UE_LOAD_STORE                     3
>> +#define RTAS_LOG_V6_MC_UE_PAGE_TABLE_WALK_LOAD_STORE     4
>> +#define RTAS_LOG_V6_MC_SLB_PARITY                        0
>> +#define RTAS_LOG_V6_MC_SLB_MULTIHIT                      1
>> +#define RTAS_LOG_V6_MC_SLB_INDETERMINATE                 2
>> +#define RTAS_LOG_V6_MC_ERAT_PARITY                       1
>> +#define RTAS_LOG_V6_MC_ERAT_MULTIHIT                     2
>> +#define RTAS_LOG_V6_MC_ERAT_INDETERMINATE                3
>> +#define RTAS_LOG_V6_MC_TLB_PARITY                        1
>> +#define RTAS_LOG_V6_MC_TLB_MULTIHIT                      2
>> +#define RTAS_LOG_V6_MC_TLB_INDETERMINATE                 3
>> +    uint8_t reserved_1[6];
>> +    uint64_t effective_address;
>> +    uint64_t logical_address;
>> +} QEMU_PACKED;
>> +
>> +struct mc_extended_log {
>> +    struct rtas_event_log_v6 v6hdr;
>> +    struct rtas_event_log_v6_mc mc;
>> +} QEMU_PACKED;
>> +
>> +struct MC_ierror_table {
>> +    unsigned long srr1_mask;
>> +    unsigned long srr1_value;
>> +    bool nip_valid; /* nip is a valid indicator of faulting address */
>> +    uint8_t error_type;
>> +    uint8_t error_subtype;
>> +    unsigned int initiator;
>> +    unsigned int severity;
>> +};
>> +
>> +static const struct MC_ierror_table mc_ierror_table[] = {
>> +{ 0x00000000081c0000, 0x0000000000040000, true,
>> +  RTAS_LOG_V6_MC_TYPE_UE, RTAS_LOG_V6_MC_UE_IFETCH,
>> +  RTAS_LOG_INITIATOR_CPU, RTAS_LOG_SEVERITY_ERROR_SYNC, },
>> +{ 0x00000000081c0000, 0x0000000000080000, true,
>> +  RTAS_LOG_V6_MC_TYPE_SLB, RTAS_LOG_V6_MC_SLB_PARITY,
>> +  RTAS_LOG_INITIATOR_CPU, RTAS_LOG_SEVERITY_ERROR_SYNC, },
>> +{ 0x00000000081c0000, 0x00000000000c0000, true,
>> +  RTAS_LOG_V6_MC_TYPE_SLB, RTAS_LOG_V6_MC_SLB_MULTIHIT,
>> +  RTAS_LOG_INITIATOR_CPU, RTAS_LOG_SEVERITY_ERROR_SYNC, },
>> +{ 0x00000000081c0000, 0x0000000000100000, true,
>> +  RTAS_LOG_V6_MC_TYPE_ERAT, RTAS_LOG_V6_MC_ERAT_MULTIHIT,
>> +  RTAS_LOG_INITIATOR_CPU, RTAS_LOG_SEVERITY_ERROR_SYNC, },
>> +{ 0x00000000081c0000, 0x0000000000140000, true,
>> +  RTAS_LOG_V6_MC_TYPE_TLB, RTAS_LOG_V6_MC_TLB_MULTIHIT,
>> +  RTAS_LOG_INITIATOR_CPU, RTAS_LOG_SEVERITY_ERROR_SYNC, },
>> +{ 0x00000000081c0000, 0x0000000000180000, true,
>> +  RTAS_LOG_V6_MC_TYPE_UE, RTAS_LOG_V6_MC_UE_PAGE_TABLE_WALK_IFETCH,
>> +  RTAS_LOG_INITIATOR_CPU, RTAS_LOG_SEVERITY_ERROR_SYNC, },
>> +{ 0, 0, 0, 0, 0, 0 } };
>> +
>> +struct MC_derror_table {
>> +    unsigned long dsisr_value;
>> +    bool dar_valid; /* dar is a valid indicator of faulting address */
>> +    uint8_t error_type;
>> +    uint8_t error_subtype;
>> +    unsigned int initiator;
>> +    unsigned int severity;
>> +};
>> +
>> +static const struct MC_derror_table mc_derror_table[] = {
>> +{ 0x00008000, false,
>> +  RTAS_LOG_V6_MC_TYPE_UE, RTAS_LOG_V6_MC_UE_LOAD_STORE,
>> +  RTAS_LOG_INITIATOR_CPU, RTAS_LOG_SEVERITY_ERROR_SYNC, },
>> +{ 0x00004000, true,
>> +  RTAS_LOG_V6_MC_TYPE_UE, RTAS_LOG_V6_MC_UE_PAGE_TABLE_WALK_LOAD_STORE,
>> +  RTAS_LOG_INITIATOR_CPU, RTAS_LOG_SEVERITY_ERROR_SYNC, },
>> +{ 0x00000800, true,
>> +  RTAS_LOG_V6_MC_TYPE_ERAT, RTAS_LOG_V6_MC_ERAT_MULTIHIT,
>> +  RTAS_LOG_INITIATOR_CPU, RTAS_LOG_SEVERITY_ERROR_SYNC, },
>> +{ 0x00000400, true,
>> +  RTAS_LOG_V6_MC_TYPE_TLB, RTAS_LOG_V6_MC_TLB_MULTIHIT,
>> +  RTAS_LOG_INITIATOR_CPU, RTAS_LOG_SEVERITY_ERROR_SYNC, },
>> +{ 0x00000080, true,
>> +  RTAS_LOG_V6_MC_TYPE_SLB, RTAS_LOG_V6_MC_SLB_MULTIHIT,  /* Before PARITY */
>> +  RTAS_LOG_INITIATOR_CPU, RTAS_LOG_SEVERITY_ERROR_SYNC, },
>> +{ 0x00000100, true,
>> +  RTAS_LOG_V6_MC_TYPE_SLB, RTAS_LOG_V6_MC_SLB_PARITY,
>> +  RTAS_LOG_INITIATOR_CPU, RTAS_LOG_SEVERITY_ERROR_SYNC, },
>> +{ 0, false, 0, 0, 0, 0 } };
>> +
>> +#define SRR1_MC_LOADSTORE(srr1) ((srr1) & PPC_BIT(42))
>> +
>>  typedef enum EventClass {
>>      EVENT_CLASS_INTERNAL_ERRORS     = 0,
>>      EVENT_CLASS_EPOW                = 1,
>> @@ -620,7 +720,141 @@ void spapr_hotplug_req_remove_by_count_indexed(SpaprDrcType drc_type,
>>                              RTAS_LOG_V6_HP_ACTION_REMOVE, drc_type, &drc_id);
>>  }
>>  
>> -void spapr_mce_req_event(PowerPCCPU *cpu)
>> +static uint32_t spapr_mce_get_elog_type(PowerPCCPU *cpu, bool recovered,
>> +                                        struct mc_extended_log *ext_elog)
>> +{
>> +    int i;
>> +    CPUPPCState *env = &cpu->env;
>> +    uint32_t summary;
>> +    uint64_t dsisr = env->spr[SPR_DSISR];
>> +
>> +    summary = RTAS_LOG_VERSION_6 | RTAS_LOG_OPTIONAL_PART_PRESENT;
>> +    if (recovered) {
>> +        summary |= RTAS_LOG_DISPOSITION_FULLY_RECOVERED;
>> +    } else {
>> +        summary |= RTAS_LOG_DISPOSITION_NOT_RECOVERED;
>> +    }
>> +
>> +    if (SRR1_MC_LOADSTORE(env->spr[SPR_SRR1])) {
>> +        for (i = 0; mc_derror_table[i].dsisr_value; i++) {
>> +            if (!(dsisr & mc_derror_table[i].dsisr_value)) {
>> +                continue;
>> +            }
>> +
>> +            ext_elog->mc.error_type = mc_derror_table[i].error_type;
>> +            ext_elog->mc.sub_err_type = mc_derror_table[i].error_subtype;
>> +            if (mc_derror_table[i].dar_valid) {
>> +                ext_elog->mc.effective_address = cpu_to_be64(env->spr[SPR_DAR]);
>> +            }
>> +
>> +            summary |= mc_derror_table[i].initiator
>> +                        | mc_derror_table[i].severity;
>> +
>> +            return summary;
>> +        }
>> +    } else {
>> +        for (i = 0; mc_ierror_table[i].srr1_mask; i++) {
>> +            if ((env->spr[SPR_SRR1] & mc_ierror_table[i].srr1_mask) !=
>> +                    mc_ierror_table[i].srr1_value) {
>> +                continue;
>> +            }
>> +
>> +            ext_elog->mc.error_type = mc_ierror_table[i].error_type;
>> +            ext_elog->mc.sub_err_type = mc_ierror_table[i].error_subtype;
>> +            if (mc_ierror_table[i].nip_valid) {
>> +                ext_elog->mc.effective_address = cpu_to_be64(env->nip);
>> +            }
>> +
>> +            summary |= mc_ierror_table[i].initiator
>> +                        | mc_ierror_table[i].severity;
>> +
>> +            return summary;
>> +        }
>> +    }
>> +
>> +    summary |= RTAS_LOG_INITIATOR_CPU;
>> +    return summary;
>> +}
>> +
>> +static void spapr_mce_dispatch_elog(PowerPCCPU *cpu, bool recovered)
>> +{
>> +    SpaprMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
>> +    CPUState *cs = CPU(cpu);
>> +    uint64_t rtas_addr;
>> +    CPUPPCState *env = &cpu->env;
>> +    PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
>> +    target_ulong r3, msr = 0;
>> +    struct rtas_error_log log;
>> +    struct mc_extended_log *ext_elog;
>> +    uint32_t summary;
>> +
>> +    /*
>> +     * Properly set bits in MSR before we invoke the handler.
>> +     * SRR0/1, DAR and DSISR are properly set by KVM
>> +     */
>> +    if (!(*pcc->interrupts_big_endian)(cpu)) {
>> +        msr |= (1ULL << MSR_LE);
>> +    }
>> +
>> +    if (env->msr & (1ULL << MSR_SF)) {
>> +        msr |= (1ULL << MSR_SF);
>> +    }
>> +
>> +    msr |= (1ULL << MSR_ME);
>> +
>> +    if (spapr->guest_machine_check_addr == -1) {
>> +        /*
>> +         * This implies that we have hit a machine check between system
>> +         * reset and "ibm,nmi-register". Fall back to the old machine
>> +         * check behavior in such cases.
>> +         */
>> +        env->spr[SPR_SRR0] = env->nip;
>> +        env->spr[SPR_SRR1] = env->msr;
>> +        env->msr = msr;
>> +        env->nip = 0x200;
>> +        return;
> 
> Hm, does this differ from what ppc_cpu_do_system_reset() will do?

Not much, but we branch to 0x200 instead of 0x100. But I think calling

powerpc_excp(cpu, env->excp_model, POWERPC_EXCP_MCHECK)

should also work. Let me if you prefer using powerpc_excp().

> 
>> +    }
>> +
>> +    ext_elog = g_malloc0(sizeof(*ext_elog));
>> +    summary = spapr_mce_get_elog_type(cpu, recovered, ext_elog);
>> +
>> +    log.summary = cpu_to_be32(summary);
>> +    log.extended_length = cpu_to_be32(sizeof(*ext_elog));
>> +
>> +    /* r3 should be in BE always */
>> +    r3 = cpu_to_be64(env->gpr[3]);
> 
> I don't love bare integer variables being store in a particular
> "endianness" because logically they're endianness-free values.  They
> only get an endianness when they are placed into byte-ordered memory.

ok.

> 
>> +    env->msr = msr;
>> +
>> +    spapr_init_v6hdr(&ext_elog->v6hdr);
>> +    ext_elog->mc.hdr.section_id = cpu_to_be16(RTAS_LOG_V6_SECTION_ID_MC);
>> +    ext_elog->mc.hdr.section_length =
>> +                    cpu_to_be16(sizeof(struct rtas_event_log_v6_mc));
>> +    ext_elog->mc.hdr.section_version = 1;
>> +
>> +    /* get rtas addr from fdt */
>> +    rtas_addr = spapr_get_rtas_addr();
>> +    if (!rtas_addr) {
>> +        /* Unable to fetch rtas_addr. Hence reset the guest */
>> +        ppc_cpu_do_system_reset(cs);
>> +        g_free(ext_elog);
>> +        return;
>> +    }
>> +
>> +    cpu_physical_memory_write(rtas_addr + RTAS_ERROR_LOG_OFFSET, &r3,
>> +                              sizeof(r3));
> 
> So, I'd prefer to see the endianness coversion done as part of the
> memory store.  You can do that using the stl_be_phys() helper.

ok.

Regards,
Aravinda

> 
>> +    cpu_physical_memory_write(rtas_addr + RTAS_ERROR_LOG_OFFSET + sizeof(r3),
>> +                              &log, sizeof(log));
>> +    cpu_physical_memory_write(rtas_addr + RTAS_ERROR_LOG_OFFSET + sizeof(r3) +
>> +                              sizeof(log), ext_elog,
>> +                              sizeof(*ext_elog));
>> +
>> +    env->gpr[3] = rtas_addr + RTAS_ERROR_LOG_OFFSET;
>> +    env->nip = spapr->guest_machine_check_addr;
>> +
>> +    g_free(ext_elog);
>> +}
>> +
>> +void spapr_mce_req_event(PowerPCCPU *cpu, bool recovered)
>>  {
>>      SpaprMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
>>  
>> @@ -641,6 +875,8 @@ void spapr_mce_req_event(PowerPCCPU *cpu)
>>          }
>>      }
>>      spapr->mc_status = cpu->vcpu_id;
>> +
>> +    spapr_mce_dispatch_elog(cpu, recovered);
>>  }
>>  
>>  static void check_exception(PowerPCCPU *cpu, SpaprMachineState *spapr,
>> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
>> index 5bc1a93..a015a80 100644
>> --- a/hw/ppc/spapr_rtas.c
>> +++ b/hw/ppc/spapr_rtas.c
>> @@ -470,6 +470,32 @@ void spapr_load_rtas(SpaprMachineState *spapr, void *fdt, hwaddr addr)
>>      }
>>  }
>>  
>> +hwaddr spapr_get_rtas_addr(void)
>> +{
>> +    SpaprMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
>> +    int rtas_node;
>> +    const fdt32_t *rtas_data;
>> +    void *fdt = spapr->fdt_blob;
>> +
>> +    /* fetch rtas addr from fdt */
>> +    rtas_node = fdt_path_offset(fdt, "/rtas");
>> +    if (rtas_node < 0) {
>> +        return 0;
>> +    }
>> +
>> +    rtas_data = fdt_getprop(fdt, rtas_node, "linux,rtas-base", NULL);
>> +    if (!rtas_data) {
>> +        return 0;
>> +    }
>> +
>> +    /*
>> +     * We assume that the OS called RTAS instantiate-rtas, but some other
>> +     * OS might call RTAS instantiate-rtas-64 instead. This fine as of now
>> +     * as SLOF only supports 32-bit variant.
>> +     */
>> +    return (hwaddr)fdt32_to_cpu(*rtas_data);
>> +}
>> +
>>  static void core_rtas_register_types(void)
>>  {
>>      spapr_rtas_register(RTAS_DISPLAY_CHARACTER, "display-character",
>> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
>> index f34c79f..debb57b 100644
>> --- a/include/hw/ppc/spapr.h
>> +++ b/include/hw/ppc/spapr.h
>> @@ -710,6 +710,9 @@ void spapr_load_rtas(SpaprMachineState *spapr, void *fdt, hwaddr addr);
>>  
>>  #define RTAS_ERROR_LOG_MAX      2048
>>  
>> +/* Offset from rtas-base where error log is placed */
>> +#define RTAS_ERROR_LOG_OFFSET       0x30
>> +
>>  #define RTAS_EVENT_SCAN_RATE    1
>>  
>>  /* This helper should be used to encode interrupt specifiers when the related
>> @@ -798,7 +801,7 @@ void spapr_clear_pending_events(SpaprMachineState *spapr);
>>  int spapr_max_server_number(SpaprMachineState *spapr);
>>  void spapr_store_hpte(PowerPCCPU *cpu, hwaddr ptex,
>>                        uint64_t pte0, uint64_t pte1);
>> -void spapr_mce_req_event(PowerPCCPU *cpu);
>> +void spapr_mce_req_event(PowerPCCPU *cpu, bool recovered);
>>  
>>  /* DRC callbacks. */
>>  void spapr_core_release(DeviceState *dev);
>> @@ -888,4 +891,5 @@ void spapr_check_pagesize(SpaprMachineState *spapr, hwaddr pagesize,
>>  #define SPAPR_OV5_XIVE_BOTH     0x80 /* Only to advertise on the platform */
>>  
>>  void spapr_set_all_lpcrs(target_ulong value, target_ulong mask);
>> +hwaddr spapr_get_rtas_addr(void);
>>  #endif /* HW_SPAPR_H */
>> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
>> index 99f33fe..368ec6e 100644
>> --- a/target/ppc/kvm.c
>> +++ b/target/ppc/kvm.c
>> @@ -2870,9 +2870,11 @@ int kvm_arch_msi_data_to_gsi(uint32_t data)
>>  
>>  int kvm_handle_nmi(PowerPCCPU *cpu, struct kvm_run *run)
>>  {
>> +    bool recovered = run->flags & KVM_RUN_PPC_NMI_DISP_FULLY_RECOV;
>> +
>>      cpu_synchronize_state(CPU(cpu));
>>  
>> -    spapr_mce_req_event(cpu);
>> +    spapr_mce_req_event(cpu, recovered);
>>  
>>      return 0;
>>  }
>>
> 

-- 
Regards,
Aravinda


