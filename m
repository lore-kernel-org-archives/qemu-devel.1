Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A46C2C43331
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 15:36:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71E502072E
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 15:36:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71E502072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51446 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIwSj-00067t-LK
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 11:36:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39777)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1jIwRX-0005AO-2I
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 11:35:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1jIwRV-0007CW-5i
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 11:35:14 -0400
Received: from 2.mo177.mail-out.ovh.net ([178.33.109.80]:47147)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1jIwRU-00073v-9g
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 11:35:12 -0400
Received: from player761.ha.ovh.net (unknown [10.108.35.103])
 by mo177.mail-out.ovh.net (Postfix) with ESMTP id 6406712B603
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2020 17:35:08 +0200 (CEST)
Received: from kaod.org (unknown [82.64.250.170])
 (Authenticated sender: clg@kaod.org)
 by player761.ha.ovh.net (Postfix) with ESMTPSA id 1D06010EF9DFA;
 Mon, 30 Mar 2020 15:34:57 +0000 (UTC)
Subject: Re: [PATCH 4/7] target/ppc: Introduce ppc_radix64_xlate() for Radix
 tree translation
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
To: Greg Kurz <groug@kaod.org>
References: <20200330094946.24678-1-clg@kaod.org>
 <20200330094946.24678-5-clg@kaod.org> <20200330161848.27226542@bahia.lan>
 <99dd89d6-f385-7cc1-d688-c104708092c2@kaod.org>
Message-ID: <88580970-a739-b32f-528f-26c6aa81b598@kaod.org>
Date: Mon, 30 Mar 2020 17:34:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <99dd89d6-f385-7cc1-d688-c104708092c2@kaod.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 1272548371958172568
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrudeihedgkeefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffhvfhfkffffgggjggtgfesthejredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpkedvrdeigedrvdehtddrudejtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejiedurdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 178.33.109.80
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
Cc: Suraj Jitindar Singh <sjitindarsingh@gmail.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

>>> +        /* No valid pte or access denied due to protection */
>>> +        if (cause_excp) {
>>> +            ppc_radix64_raise_si(cpu, rwx, eaddr, fault_cause);
>>> +        }
>>> +        return 1;
>>> +    }
>>> +
>>> +    ppc_radix64_set_rc(cpu, rwx, pte, pte_addr, g_prot);
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static int ppc_radix64_xlate(PowerPCCPU *cpu, vaddr eaddr, int rwx,
>>> +                             uint64_t lpid, uint64_t pid, bool relocation,
>>> +                             hwaddr *raddr, int *psizep, int *protp,
>>> +                             bool cause_excp)
>>> +{
>>> +    ppc_v3_pate_t pate;
>>> +    int psize, prot;
>>> +    hwaddr g_raddr;
>>> +
>>> +    *psizep = INT_MAX;
>>> +    *protp = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
>>> +
>>> +    /* Get Process Table */
>>> +    if (cpu->vhyp && lpid == 0) {
>>
>> Current code doesn't check lpid == 0. Not sure to see what it's for...
> 
> cpu->vhyp means a pseries machine, lpid == 0 means accessing quadrant3, 
> so it's the kernel.

Sorry. I misread that. It would pid == 0 for the kernel. 

So yes, the test cpu->vhyp && lpid == 0 might be a bit overkill, given 
that lpid is always 0 when running under a QEMU pseries machine.


C.

> 
>> especially env->spr[SPR_LPIDR] is always 0 with pseries machine types
>> AFAICT... is it even possible to have lpid != 0 here ?
> 
> When under PowerNV, SPR_LPIDR can be set, but not under pseries.
> 
> C.
> 
>>
>>
>> Rest LGTM.
>>
>>> +        PPCVirtualHypervisorClass *vhc;
>>> +        vhc = PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
>>> +        vhc->get_pate(cpu->vhyp, &pate);
>>> +    } else {
>>> +        if (!ppc64_v3_get_pate(cpu, lpid, &pate)) {
>>> +            if (cause_excp) {
>>> +                ppc_radix64_raise_si(cpu, rwx, eaddr, DSISR_NOPTE);
>>> +            }
>>> +            return 1;
>>> +        }
>>> +        if (!validate_pate(cpu, lpid, &pate)) {
>>> +            if (cause_excp) {
>>> +                ppc_radix64_raise_si(cpu, rwx, eaddr, DSISR_R_BADCONFIG);
>>> +            }
>>> +            return 1;
>>> +        }
>>> +        /* We don't support guest mode yet */
>>> +        if (lpid != 0) {
>>> +            error_report("PowerNV guest support Unimplemented");
>>> +            exit(1);
>>> +        }
>>> +    }
>>> +
>>> +    /*
>>> +     * Perform process-scoped translation if relocation enabled.
>>> +     *
>>> +     * - Translates an effective address to a host real address in
>>> +     *   quadrants 0 and 3 when HV=1.
>>> +     */
>>> +    if (relocation) {
>>> +        int ret = ppc_radix64_process_scoped_xlate(cpu, rwx, eaddr, lpid, pid,
>>> +                                                   pate, &g_raddr, &prot,
>>> +                                                   &psize, cause_excp);
>>> +        if (ret) {
>>> +            return ret;
>>> +        }
>>> +        *psizep = MIN(*psizep, psize);
>>> +        *protp &= prot;
>>> +    } else {
>>> +        g_raddr = eaddr & R_EADDR_MASK;
>>> +    }
>>> +
>>> +    *raddr = g_raddr;
>>> +    return 0;
>>> +}
>>> +
>>>  int ppc_radix64_handle_mmu_fault(PowerPCCPU *cpu, vaddr eaddr, int rwx,
>>>                                   int mmu_idx)
>>>  {
>>>      CPUState *cs = CPU(cpu);
>>>      CPUPPCState *env = &cpu->env;
>>> -    PPCVirtualHypervisorClass *vhc;
>>> -    hwaddr raddr, pte_addr;
>>> -    uint64_t lpid = 0, pid = 0, offset, size, prtbe0, pte;
>>> -    int page_size, prot, fault_cause = 0;
>>> -    ppc_v3_pate_t pate;
>>> +    uint64_t lpid = 0, pid = 0;
>>> +    int page_size, prot;
>>>      bool relocation;
>>> +    hwaddr raddr;
>>>  
>>>      assert(!(msr_hv && cpu->vhyp));
>>>      assert((rwx == 0) || (rwx == 1) || (rwx == 2));
>>> @@ -268,48 +370,11 @@ int ppc_radix64_handle_mmu_fault(PowerPCCPU *cpu, vaddr eaddr, int rwx,
>>>          return 1;
>>>      }
>>>  
>>> -    /* Get Process Table */
>>> -    if (cpu->vhyp) {
>>> -        vhc = PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
>>> -        vhc->get_pate(cpu->vhyp, &pate);
>>> -    } else {
>>> -        if (!ppc64_v3_get_pate(cpu, lpid, &pate)) {
>>> -            ppc_radix64_raise_si(cpu, rwx, eaddr, DSISR_NOPTE);
>>> -            return 1;
>>> -        }
>>> -        if (!validate_pate(cpu, lpid, &pate)) {
>>> -            ppc_radix64_raise_si(cpu, rwx, eaddr, DSISR_R_BADCONFIG);
>>> -        }
>>> -        /* We don't support guest mode yet */
>>> -        if (lpid != 0) {
>>> -            error_report("PowerNV guest support Unimplemented");
>>> -            exit(1);
>>> -       }
>>> -    }
>>> -
>>> -    /* Index Process Table by PID to Find Corresponding Process Table Entry */
>>> -    offset = pid * sizeof(struct prtb_entry);
>>> -    size = 1ULL << ((pate.dw1 & PATE1_R_PRTS) + 12);
>>> -    if (offset >= size) {
>>> -        /* offset exceeds size of the process table */
>>> -        ppc_radix64_raise_si(cpu, rwx, eaddr, DSISR_NOPTE);
>>> +    /* Translate eaddr to raddr (where raddr is addr qemu needs for access) */
>>> +    if (ppc_radix64_xlate(cpu, eaddr, rwx, lpid, pid, relocation, &raddr,
>>> +                          &page_size, &prot, 1)) {
>>>          return 1;
>>>      }
>>> -    prtbe0 = ldq_phys(cs->as, (pate.dw1 & PATE1_R_PRTB) + offset);
>>> -
>>> -    /* Walk Radix Tree from Process Table Entry to Convert EA to RA */
>>> -    page_size = PRTBE_R_GET_RTS(prtbe0);
>>> -    pte = ppc_radix64_walk_tree(cpu, eaddr & R_EADDR_MASK,
>>> -                                prtbe0 & PRTBE_R_RPDB, prtbe0 & PRTBE_R_RPDS,
>>> -                                &raddr, &page_size, &fault_cause, &pte_addr);
>>> -    if (!pte || ppc_radix64_check_prot(cpu, rwx, pte, &fault_cause, &prot)) {
>>> -        /* Couldn't get pte or access denied due to protection */
>>> -        ppc_radix64_raise_si(cpu, rwx, eaddr, fault_cause);
>>> -        return 1;
>>> -    }
>>> -
>>> -    /* Update Reference and Change Bits */
>>> -    ppc_radix64_set_rc(cpu, rwx, pte, pte_addr, &prot);
>>>  
>>>      tlb_set_page(cs, eaddr & TARGET_PAGE_MASK, raddr & TARGET_PAGE_MASK,
>>>                   prot, mmu_idx, 1UL << page_size);
>>> @@ -318,16 +383,13 @@ int ppc_radix64_handle_mmu_fault(PowerPCCPU *cpu, vaddr eaddr, int rwx,
>>>  
>>>  hwaddr ppc_radix64_get_phys_page_debug(PowerPCCPU *cpu, target_ulong eaddr)
>>>  {
>>> -    CPUState *cs = CPU(cpu);
>>>      CPUPPCState *env = &cpu->env;
>>> -    PPCVirtualHypervisorClass *vhc;
>>> -    hwaddr raddr, pte_addr;
>>> -    uint64_t lpid = 0, pid = 0, offset, size, prtbe0, pte;
>>> -    int page_size, fault_cause = 0;
>>> -    ppc_v3_pate_t pate;
>>> +    uint64_t lpid = 0, pid = 0;
>>> +    int psize, prot;
>>> +    hwaddr raddr;
>>>  
>>>      /* Handle Real Mode */
>>> -    if (msr_dr == 0) {
>>> +    if ((msr_dr == 0) && (msr_hv || (cpu->vhyp && lpid == 0))) {
>>>          /* In real mode top 4 effective addr bits (mostly) ignored */
>>>          return eaddr & 0x0FFFFFFFFFFFFFFFULL;
>>>      }
>>> @@ -337,39 +399,8 @@ hwaddr ppc_radix64_get_phys_page_debug(PowerPCCPU *cpu, target_ulong eaddr)
>>>          return -1;
>>>      }
>>>  
>>> -    /* Get Process Table */
>>> -    if (cpu->vhyp) {
>>> -        vhc = PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
>>> -        vhc->get_pate(cpu->vhyp, &pate);
>>> -    } else {
>>> -        if (!ppc64_v3_get_pate(cpu, lpid, &pate)) {
>>> -            return -1;
>>> -        }
>>> -        if (!validate_pate(cpu, lpid, &pate)) {
>>> -            return -1;
>>> -        }
>>> -        /* We don't support guest mode yet */
>>> -        if (lpid != 0) {
>>> -            error_report("PowerNV guest support Unimplemented");
>>> -            exit(1);
>>> -       }
>>> -    }
>>> -
>>> -    /* Index Process Table by PID to Find Corresponding Process Table Entry */
>>> -    offset = pid * sizeof(struct prtb_entry);
>>> -    size = 1ULL << ((pate.dw1 & PATE1_R_PRTS) + 12);
>>> -    if (offset >= size) {
>>> -        /* offset exceeds size of the process table */
>>> -        return -1;
>>> -    }
>>> -    prtbe0 = ldq_phys(cs->as, (pate.dw1 & PATE1_R_PRTB) + offset);
>>> -
>>> -    /* Walk Radix Tree from Process Table Entry to Convert EA to RA */
>>> -    page_size = PRTBE_R_GET_RTS(prtbe0);
>>> -    pte = ppc_radix64_walk_tree(cpu, eaddr & R_EADDR_MASK,
>>> -                                prtbe0 & PRTBE_R_RPDB, prtbe0 & PRTBE_R_RPDS,
>>> -                                &raddr, &page_size, &fault_cause, &pte_addr);
>>> -    if (!pte) {
>>> +    if (ppc_radix64_xlate(cpu, eaddr, 0, lpid, pid, msr_dr, &raddr, &psize,
>>> +                          &prot, 0)) {
>>>          return -1;
>>>      }
>>>  
>>
> 


