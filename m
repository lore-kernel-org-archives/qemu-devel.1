Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB73EC04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 07:06:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A60F62089E
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 07:06:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A60F62089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38062 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOzby-0002dA-TW
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 03:06:30 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47571)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aravinda@linux.vnet.ibm.com>) id 1hOzb1-0002Cg-5v
	for qemu-devel@nongnu.org; Fri, 10 May 2019 03:05:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aravinda@linux.vnet.ibm.com>) id 1hOzaz-0003Dt-8P
	for qemu-devel@nongnu.org; Fri, 10 May 2019 03:05:31 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47468)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aravinda@linux.vnet.ibm.com>)
	id 1hOzau-00039j-RQ; Fri, 10 May 2019 03:05:25 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x4A72iFu072721; Fri, 10 May 2019 03:05:19 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com
	[169.63.214.131])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2sd41k9bqe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NOT); Fri, 10 May 2019 03:05:19 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
	by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id
	x4A18C2P014430; Fri, 10 May 2019 01:09:31 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
	[9.57.198.25]) by ppma01dal.us.ibm.com with ESMTP id 2s92c47650-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NOT); Fri, 10 May 2019 01:09:31 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com
	[9.57.199.109])
	by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	x4A75H9e20447354
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK); Fri, 10 May 2019 07:05:17 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8066611206D;
	Fri, 10 May 2019 07:05:17 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 248CD112061;
	Fri, 10 May 2019 07:05:15 +0000 (GMT)
Received: from [9.199.33.229] (unknown [9.199.33.229])
	by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
	Fri, 10 May 2019 07:05:14 +0000 (GMT)
To: David Gibson <david@gibson.dropbear.id.au>
References: <155591636364.20338.844048953355207313.stgit@aravinda>
	<155591660602.20338.9804738040071843715.stgit@aravinda>
	<20190510064213.GK20559@umbus.fritz.box>
From: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Message-ID: <2cf9df3f-c3ea-5a36-e5fc-1a40386d1586@linux.vnet.ibm.com>
Date: Fri, 10 May 2019 12:35:13 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20190510064213.GK20559@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
	definitions=2019-05-09_02:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
	priorityscore=1501
	malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
	clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
	mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
	scancount=1 engine=8.0.1-1810050000 definitions=main-1905100049
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
Subject: Re: [Qemu-devel] [PATCH v8 4/6] target/ppc: Build rtas error log
 upon an MCE
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
Cc: paulus@ozlabs.org, qemu-ppc@nongnu.org, aik@au1.ibm.com,
	qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On Friday 10 May 2019 12:12 PM, David Gibson wrote:
> On Mon, Apr 22, 2019 at 12:33:26PM +0530, Aravinda Prasad wrote:
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
>>  hw/ppc/spapr.c         |    4 +
>>  hw/ppc/spapr_events.c  |  245 ++++++++++++++++++++++++++++++++++++++++++++++++
>>  include/hw/ppc/spapr.h |    4 +
>>  3 files changed, 253 insertions(+)
>>
>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>> index 2779efe..ffd1715 100644
>> --- a/hw/ppc/spapr.c
>> +++ b/hw/ppc/spapr.c
>> @@ -2918,6 +2918,10 @@ static void spapr_machine_init(MachineState *machine)
>>          error_report("Could not get size of LPAR rtas '%s'", filename);
>>          exit(1);
>>      }
>> +
>> +    /* Resize blob to accommodate error log. */
>> +    spapr->rtas_size = spapr_get_rtas_size(spapr->rtas_size);
>> +
>>      spapr->rtas_blob = g_malloc(spapr->rtas_size);
>>      if (load_image_size(filename, spapr->rtas_blob, spapr->rtas_size) < 0) {
>>          error_report("Could not load LPAR rtas '%s'", filename);
>> diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
>> index 9922a23..4032db0 100644
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
>> @@ -620,6 +720,147 @@ void spapr_hotplug_req_remove_by_count_indexed(SpaprDrcType drc_type,
>>                              RTAS_LOG_V6_HP_ACTION_REMOVE, drc_type, &drc_id);
>>  }
>>  
>> +ssize_t spapr_get_rtas_size(ssize_t old_rtas_size)
>> +{
>> +    g_assert(old_rtas_size < RTAS_ERRLOG_OFFSET);
>> +    return RTAS_ERROR_LOG_MAX;
>> +}
>> +
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
>> +    if (env->msr && (1ULL << MSR_SF)) {
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
>> +    }
>> +
>> +    ext_elog = g_malloc0(sizeof(struct mc_extended_log));
>> +    summary = spapr_mce_get_elog_type(cpu, recovered, ext_elog);
>> +
>> +    log.summary = cpu_to_be32(summary);
>> +    log.extended_length = cpu_to_be32(sizeof(struct mc_extended_log));
>> +
>> +    /* r3 should be in BE always */
>> +    r3 = cpu_to_be64(env->gpr[3]);
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
>> +    }
>> +
>> +    cpu_physical_memory_write(rtas_addr + RTAS_ERRLOG_OFFSET, &r3, sizeof(r3));
>> +    cpu_physical_memory_write(rtas_addr + RTAS_ERRLOG_OFFSET + sizeof(r3),
>> +                              &log, sizeof(log));
>> +    cpu_physical_memory_write(rtas_addr + RTAS_ERRLOG_OFFSET + sizeof(r3) +
>> +                              sizeof(log), ext_elog,
>> +                              sizeof(struct mc_extended_log));
>> +
>> +    /* Save gpr[3] in the guest endian mode */
>> +    if ((*pcc->interrupts_big_endian)(cpu)) {
>> +        env->gpr[3] = cpu_to_be64(rtas_addr + RTAS_ERRLOG_OFFSET);
> 
> I don't think this is right.  AIUI env->gpr[] are all stored in *host*
> endianness (for ease of doing arithmetic).

env-gpr[3] is later used by guest to fetch the RTAS log. My guess is
that we will not do an endianness change of all the gprs during a switch
from host to guest (that will be costly). But let me cross check.

> 
>> +    } else {
>> +        env->gpr[3] = cpu_to_le64(rtas_addr + RTAS_ERRLOG_OFFSET);
>> +    }
>> +
>> +    env->nip = spapr->guest_machine_check_addr;
>> +}
>> +
>>  void spapr_mce_req_event(PowerPCCPU *cpu, bool recovered)
>>  {
>>      SpaprMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
>> @@ -640,6 +881,10 @@ void spapr_mce_req_event(PowerPCCPU *cpu, bool recovered)
>>          }
>>      }
>>      spapr->mc_status = cpu->vcpu_id;
>> +
>> +    spapr_mce_dispatch_elog(cpu, recovered);
>> +
>> +    return;
>>  }
>>  
>>  static void check_exception(PowerPCCPU *cpu, SpaprMachineState *spapr,
>> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
>> index f7204d0..03f34bf 100644
>> --- a/include/hw/ppc/spapr.h
>> +++ b/include/hw/ppc/spapr.h
>> @@ -661,6 +661,9 @@ target_ulong spapr_hypercall(PowerPCCPU *cpu, target_ulong opcode,
>>  #define DIAGNOSTICS_RUN_MODE_IMMEDIATE 2
>>  #define DIAGNOSTICS_RUN_MODE_PERIODIC  3
>>  
>> +/* Offset from rtas-base where error log is placed */
>> +#define RTAS_ERRLOG_OFFSET       0x25
> 
> Is this offset PAPR defined, or chosen here?  Using an entirely
> unaliged (odd) address seems a very strange choice.

This is not PAPR defined. I will make it 0x30. Or do you prefer any
other offset?

Regards,
Aravinda

> 
>> +
>>  static inline uint64_t ppc64_phys_to_real(uint64_t addr)
>>  {
>>      return addr & ~0xF000000000000000ULL;
>> @@ -798,6 +801,7 @@ int spapr_max_server_number(SpaprMachineState *spapr);
>>  void spapr_store_hpte(PowerPCCPU *cpu, hwaddr ptex,
>>                        uint64_t pte0, uint64_t pte1);
>>  void spapr_mce_req_event(PowerPCCPU *cpu, bool recovered);
>> +ssize_t spapr_get_rtas_size(ssize_t old_rtas_sizea);
>>  
>>  /* DRC callbacks. */
>>  void spapr_core_release(DeviceState *dev);
>>
> 

-- 
Regards,
Aravinda

