Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B03C5C32771
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 20:13:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 855FE22522
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 20:13:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 855FE22522
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itdPx-0002e7-NS
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 15:13:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40629)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <farosas@linux.ibm.com>) id 1itdPI-00027p-7U
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 15:12:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <farosas@linux.ibm.com>) id 1itdPE-0005wP-Cd
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 15:12:20 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:4522)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <farosas@linux.ibm.com>)
 id 1itdPE-0005vj-4Z; Mon, 20 Jan 2020 15:12:16 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 00KKC6vn124458; Mon, 20 Jan 2020 15:12:08 -0500
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2xmgcnnvqk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 20 Jan 2020 15:12:08 -0500
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 00KKC7xT124637;
 Mon, 20 Jan 2020 15:12:07 -0500
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com
 [169.47.144.26])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2xmgcnnvjk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 20 Jan 2020 15:12:07 -0500
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
 by ppma04wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 00KKAxMu011303;
 Mon, 20 Jan 2020 20:11:53 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26]) by ppma04wdc.us.ibm.com with ESMTP id 2xksn65nmv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 20 Jan 2020 20:11:53 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com
 [9.57.199.110])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 00KKBr9f13238928
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 20 Jan 2020 20:11:53 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 08951AE062;
 Mon, 20 Jan 2020 20:11:53 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5C6B2AE05F;
 Mon, 20 Jan 2020 20:11:52 +0000 (GMT)
Received: from localhost (unknown [9.85.137.117])
 by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTPS;
 Mon, 20 Jan 2020 20:11:52 +0000 (GMT)
From: Fabiano Rosas <farosas@linux.ibm.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v6 3/3] target/ppc: support single stepping with KVM HV
In-Reply-To: <20200120023555.GK54439@umbus>
References: <20200110151344.278471-1-farosas@linux.ibm.com>
 <20200110151344.278471-4-farosas@linux.ibm.com>
 <20200120023555.GK54439@umbus>
Date: Mon, 20 Jan 2020 17:11:50 -0300
Message-ID: <87d0bd28hl.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-01-20_09:2020-01-20,
 2020-01-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 mlxscore=0
 phishscore=0 impostorscore=0 priorityscore=1501 bulkscore=0 adultscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-2001200171
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 148.163.156.1
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

David Gibson <david@gibson.dropbear.id.au> writes:

>> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
>> index 103bfe9dc2..b69f8565aa 100644
>> --- a/target/ppc/cpu.h
>> +++ b/target/ppc/cpu.h
>> @@ -440,6 +440,10 @@ typedef struct ppc_v3_pate_t {
>>  #define msr_ts   ((env->msr >> MSR_TS1)  & 3)
>>  #define msr_tm   ((env->msr >> MSR_TM)   & 1)
>>  
>> +#define srr1_ir ((env->spr[SPR_SRR1] >> MSR_IR) & 1)
>> +#define srr1_dr ((env->spr[SPR_SRR1] >> MSR_DR) & 1)
>> +#define srr1_se ((env->spr[SPR_SRR1] >> MSR_SE) & 1)
>
> I'd prefer not to introduce these.  The msr_xx macros are already kind
> of dubious because they assume the meaning of 'env' in the context
> they're used.  I'm ok to use them because they're so useful, so
> often.  These srr1 variants however are used in far fewer situations.
> So, I'd prefer to just open code these as (env->spr[SPR_SRR1] &
> MSR_IR) in the relatively few places they're used for now.
>

Ok. No problem.

>>  #define DBCR0_ICMP (1 << 27)
>>  #define DBCR0_BRT (1 << 26)
>>  #define DBSR_ICMP (1 << 27)
>> @@ -1158,6 +1162,16 @@ struct CPUPPCState {
>>      uint32_t tm_vscr;
>>      uint64_t tm_dscr;
>>      uint64_t tm_tar;
>> +
>> +    /* Used for software single step */
>> +    target_ulong sstep_srr0;
>> +    target_ulong sstep_srr1;
>> +    target_ulong sstep_insn;
>> +    target_ulong trace_handler_addr;
>> +    int sstep_kind;
>
> Won't you need to migrate this extra state, at least some of the time?
>

Ah. I haven't looked into this yet. Will do that for the next
version. Need to learn a bit about migration first.

>> +#define SSTEP_REGULAR 0
>> +#define SSTEP_PENDING 1
>> +#define SSTEP_GUEST   2
>
> Some comments on what these modes mean would be useful.
>

Ok.

>> +static uint32_t ppc_gdb_read_insn(CPUState *cs, target_ulong addr)
>> +{
>> +    PowerPCCPU *cpu = POWERPC_CPU(cs);
>> +    CPUPPCState *env = &cpu->env;
>> +    uint32_t insn;
>> +
>> +    cpu_memory_rw_debug(cs, addr, (uint8_t *)&insn, sizeof(insn), 0);
>> +
>> +    if (msr_le) {
>> +        return ldl_le_p(&insn);
>> +    } else {
>> +        return ldl_be_p(&insn);
>> +    }
>
> I think you can just use cpu_ldl_code() for this.
>

I'll look into it.

>> +static void kvm_insert_singlestep_breakpoint(CPUState *cs, bool mmu_on)
>> +{
>> +    PowerPCCPU *cpu = POWERPC_CPU(cs);
>> +    CPUPPCState *env = &cpu->env;
>> +    target_ulong bp_addr;
>> +    target_ulong saved_msr = env->msr;
>> +
>> +    bp_addr = ppc_get_trace_int_handler_addr(cs, mmu_on);
>> +    if (env->nip == bp_addr) {
>> +        /*
>> +         * We are trying to step the interrupt handler address itself;
>> +         * move the breakpoint to the next instruction.
>> +         */
>> +        bp_addr += 4;
>
> What if the first instruction of the interrupt handler is a branch?
>

Well, I need to displace the breakpoint somehow. I don't think I can
handle this particular case without having _some_ knowledge of the
handler's code. The ones I've seen so far don't have a branch as first
instruction.

>> +    }
>> +
>> +    /*
>> +     * The actual access by the guest might be made in a mode
>> +     * different than we are now (due to rfid) so temporarily set the
>> +     * MSR to reflect that during the breakpoint placement.
>> +     *
>> +     * Note: we need this because breakpoints currently use
>> +     * cpu_memory_rw_debug, which does the memory accesses from the
>> +     * guest point of view.
>> +     */
>> +    if ((msr_ir & msr_dr) != mmu_on) {
>
> Should be msr_ir && msr_dr - you only get away with bitwise and by
> accident.
>

Ack.

>> +        if (mmu_on) {
>> +            env->msr |= (1ULL << MSR_IR | 1ULL << MSR_DR);
>> +        } else {
>> +            env->msr &= ~(1ULL << MSR_IR | 1ULL << MSR_DR);
>> +        }
>> +    }
>
> Wouldn't it be simpler to unconditionally set env->msr based on
> mmu_on.
>

Yes.

>> +
>> +    kvm_insert_breakpoint(cs, bp_addr, 4, GDB_BREAKPOINT_SW);
>
> Hrm.... I don't actually see how changing env->msr helps you here.
> AFAICT if kvm_insert_breakpoint() resolves to kvm_arch_sw_breakpoint()
> it doesn't rely on the MSR value at all.  If it resolves to
> kvm_arch_hw_breakpoint(), then it looks like it just stashes
> information to be pushed into KVM when we re-enter the guest.  None of
> the information stashed appears to depend on the current MSR, and once
> we re-enter the MSR will already have been restored.
>

This is the call chain:

kvm_arch_insert_sw_breakpoint -> cpu_memory_rw_debug ->
cpu_get_phys_page_attrs_debug -> ppc_cpu_get_phys_page_debug ->
ppc64_v3_get_phys_page_debug -> ppc_radix64_get_phys_page_debug:

    /* Handle Real Mode */
    if (msr_dr == 0) {
        /* In real mode top 4 effective addr bits (mostly) ignored */
        return eaddr & 0x0FFFFFFFFFFFFFFFULL;
    }


Actually, I think there is a bug after ppc_cpu_get_phys_page_debug
somewhere. There are some cases where GDB wants to read/write to some
memory, but it gets denied access. Presumably because of one such
discrepancy as the one above. I need to spend more time looking at this
to define the problem properly, though.

>> +    /*
>> +     * MSR_SE = 1 will cause a Trace Interrupt in the guest after the
>> +     * next instruction executes. If this is a rfid, use SRR1 instead
>> +     * of MSR.
>> +     */
>> +    if (rfid) {
>> +        if ((env->spr[SPR_SRR1] >> MSR_SE) & 1) {
>> +            /*
>> +             * The guest is doing a single step itself. Make sure we
>> +             * restore it later.
>> +             */
>> +            env->sstep_kind = SSTEP_GUEST;
>> +        }
>> +
>> +        env->spr[SPR_SRR1] |= (1ULL << MSR_SE);
>> +        mmu_on = srr1_ir & srr1_dr;
>
> s/&/&&/
>

Ack.

>> +    } else {
>> +        env->msr |= (1ULL << MSR_SE);
>> +        mmu_on = msr_ir & msr_dr;
>
> s/&/&&/
>

Ack.

> Also, what happens if the guest is using MSR[DR] != MSR[IR]?  It's
> rare, but it is occasionally useful.
>

I understand from the ISA that for the purposes of AIL, both bits need
to be set. So mmu_on = 0 is correct here.

>> +    }
>> +
>> +    kvm_insert_singlestep_breakpoint(cs, mmu_on);
>> +}
>> +
>> +void kvm_singlestep_ail_change(CPUState *cs)
>> +{
>> +    PowerPCCPU *cpu = POWERPC_CPU(cs);
>> +    CPUPPCState *env = &cpu->env;
>> +
>> +    if (kvm_arch_can_singlestep(cs)) {
>> +        return;
>> +    }
>> +
>> +    /*
>> +     * The instruction being stepped altered the interrupt vectors
>> +     * location (AIL). Re-insert the single step breakpoint at the new
>> +     * location
>> +     */
>> +    kvm_remove_breakpoint(cs, env->trace_handler_addr, 4, GDB_BREAKPOINT_SW);
>> +    kvm_insert_singlestep_breakpoint(cs, (msr_ir & msr_dr));
>
> s/&/&&/
>

Ack.

>> +}
>> +
>>  void kvm_arch_update_guest_debug(CPUState *cs, struct kvm_guest_debug *dbg)
>>  {
>>      int n;
>> @@ -1585,6 +1781,98 @@ void kvm_arch_update_guest_debug(CPUState *cs, struct kvm_guest_debug *dbg)
>>      }
>>  }
>>  
>> +/* Revert any side-effects caused during single step */
>> +static void restore_singlestep_env(CPUState *cs)
>> +{
>> +    PowerPCCPU *cpu = POWERPC_CPU(cs);
>> +    CPUPPCState *env = &cpu->env;
>> +    uint32_t insn = env->sstep_insn;
>> +    int reg;
>> +    int spr;
>> +
>> +    env->spr[SPR_SRR0] = env->sstep_srr0;
>> +    env->spr[SPR_SRR1] = env->sstep_srr1;
>> +
>> +    if (ppc_gdb_get_op(insn) != OP_MOV) {
>> +        return;
>> +    }
>> +
>> +    reg = ppc_gdb_get_rt(insn);
>> +
>> +    switch (ppc_gdb_get_xop(insn)) {
>> +    case XOP_MTSPR:
>> +        /*
>> +         * mtspr: the guest altered the SRR, so do not use the
>> +         *        pre-step value.
>> +         */
>> +        spr = ppc_gdb_get_spr(insn);
>> +        if (spr == SPR_SRR0 || spr == SPR_SRR1) {
>> +            env->spr[spr] = env->gpr[reg];
>> +        }
>> +        break;
>> +    case XOP_MFMSR:
>> +        /*
>> +         * mfmsr: clear MSR_SE bit to avoid the guest knowing
>> +         *         that it is being single-stepped.
>> +         */
>> +        env->gpr[reg] &= ~(1ULL << MSR_SE);
>
> Don't you need to check for the case where the guest also thinks it is
> single stepping here?
>

Hm. I had this in some previous version but removed it for some
reason. I'll review it.


Thanks

