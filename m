Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC0E8C35DEA
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 00:26:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFBF621927
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 00:26:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFBF621927
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6O3k-00059m-SC
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 19:26:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52673)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <farosas@linux.ibm.com>) id 1j6O2N-00031a-3l
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 19:25:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <farosas@linux.ibm.com>) id 1j6O2L-0000h7-Ll
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 19:25:22 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:19496)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <farosas@linux.ibm.com>)
 id 1j6O2L-0000gm-Dr; Mon, 24 Feb 2020 19:25:21 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 01P0JnA7108262; Mon, 24 Feb 2020 19:25:13 -0500
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ybu13f62j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Feb 2020 19:25:13 -0500
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 01P0K61x111750;
 Mon, 24 Feb 2020 19:25:12 -0500
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com
 [169.53.41.122])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ybu13f61s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Feb 2020 19:25:12 -0500
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
 by ppma04dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 01P0JCbK001634;
 Tue, 25 Feb 2020 00:25:11 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26]) by ppma04dal.us.ibm.com with ESMTP id 2yaux6nqyu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 25 Feb 2020 00:25:11 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com
 [9.57.199.111])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 01P0PA1134341138
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 25 Feb 2020 00:25:10 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 68A77AC05E;
 Tue, 25 Feb 2020 00:25:10 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 67958AC05B;
 Tue, 25 Feb 2020 00:25:09 +0000 (GMT)
Received: from localhost (unknown [9.85.139.151])
 by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTPS;
 Tue, 25 Feb 2020 00:25:09 +0000 (GMT)
From: Fabiano Rosas <farosas@linux.ibm.com>
To: David Gibson <david@gibson.dropbear.id.au>, groug@kaod.org,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org, clg@kaod.org
Subject: Re: [PATCH v6 12/18] target/ppc: Don't store VRMA SLBE persistently
In-Reply-To: <20200224233724.46415-13-david@gibson.dropbear.id.au>
References: <20200224233724.46415-1-david@gibson.dropbear.id.au>
 <20200224233724.46415-13-david@gibson.dropbear.id.au>
Date: Mon, 24 Feb 2020 21:25:07 -0300
Message-ID: <87lfor5x98.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-02-24_12:2020-02-21,
 2020-02-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=1
 malwarescore=0 bulkscore=0 phishscore=0 mlxlogscore=959 spamscore=0
 adultscore=0 impostorscore=0 mlxscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002250000
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
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
Cc: lvivier@redhat.com, Thomas Huth <thuth@redhat.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, paulus@samba.org,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

David Gibson <david@gibson.dropbear.id.au> writes:

> Currently, we construct the SLBE used for VRMA translations when the LPCR
> is written (which controls some bits in the SLBE), then use it later for
> translations.
>
> This is a bit complex and confusing - simplify it by simply constructing
> the SLBE directly from the LPCR when we need it.
>
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Reviewed-by: Fabiano Rosas <farosas@linux.ibm.com>

> ---
>  target/ppc/cpu.h        |  3 ---
>  target/ppc/mmu-hash64.c | 28 ++++++----------------------
>  2 files changed, 6 insertions(+), 25 deletions(-)
>
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index f9871b1233..5a55fb02bd 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -1044,9 +1044,6 @@ struct CPUPPCState {
>      uint32_t flags;
>      uint64_t insns_flags;
>      uint64_t insns_flags2;
> -#if defined(TARGET_PPC64)
> -    ppc_slb_t vrma_slb;
> -#endif
>  
>      int error_code;
>      uint32_t pending_interrupts;
> diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
> index ac21c14f68..f8bf92aa2e 100644
> --- a/target/ppc/mmu-hash64.c
> +++ b/target/ppc/mmu-hash64.c
> @@ -825,6 +825,7 @@ int ppc_hash64_handle_mmu_fault(PowerPCCPU *cpu, vaddr eaddr,
>  {
>      CPUState *cs = CPU(cpu);
>      CPUPPCState *env = &cpu->env;
> +    ppc_slb_t vrma_slbe;
>      ppc_slb_t *slb;
>      unsigned apshift;
>      hwaddr ptex;
> @@ -863,8 +864,8 @@ int ppc_hash64_handle_mmu_fault(PowerPCCPU *cpu, vaddr eaddr,
>              }
>          } else if (ppc_hash64_use_vrma(env)) {
>              /* Emulated VRMA mode */
> -            slb = &env->vrma_slb;
> -            if (!slb->sps) {
> +            slb = &vrma_slbe;
> +            if (build_vrma_slbe(cpu, slb) != 0) {
>                  /* Invalid VRMA setup, machine check */
>                  cs->exception_index = POWERPC_EXCP_MCHECK;
>                  env->error_code = 0;
> @@ -1012,6 +1013,7 @@ skip_slb_search:
>  hwaddr ppc_hash64_get_phys_page_debug(PowerPCCPU *cpu, target_ulong addr)
>  {
>      CPUPPCState *env = &cpu->env;
> +    ppc_slb_t vrma_slbe;
>      ppc_slb_t *slb;
>      hwaddr ptex, raddr;
>      ppc_hash_pte64_t pte;
> @@ -1033,8 +1035,8 @@ hwaddr ppc_hash64_get_phys_page_debug(PowerPCCPU *cpu, target_ulong addr)
>              return raddr | env->spr[SPR_HRMOR];
>          } else if (ppc_hash64_use_vrma(env)) {
>              /* Emulated VRMA mode */
> -            slb = &env->vrma_slb;
> -            if (!slb->sps) {
> +            slb = &vrma_slbe;
> +            if (build_vrma_slbe(cpu, slb) != 0) {
>                  return -1;
>              }
>          } else {
> @@ -1072,30 +1074,12 @@ void ppc_hash64_tlb_flush_hpte(PowerPCCPU *cpu, target_ulong ptex,
>      cpu->env.tlb_need_flush = TLB_NEED_GLOBAL_FLUSH | TLB_NEED_LOCAL_FLUSH;
>  }
>  
> -static void ppc_hash64_update_vrma(PowerPCCPU *cpu)
> -{
> -    CPUPPCState *env = &cpu->env;
> -    ppc_slb_t *slb = &env->vrma_slb;
> -
> -    /* Is VRMA enabled ? */
> -    if (ppc_hash64_use_vrma(env)) {
> -        if (build_vrma_slbe(cpu, slb) == 0) {
> -            return;
> -        }
> -    }
> -
> -    /* Otherwise, clear it to indicate error */
> -    slb->esid = slb->vsid = 0;
> -    slb->sps = NULL;
> -}
> -
>  void ppc_store_lpcr(PowerPCCPU *cpu, target_ulong val)
>  {
>      PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
>      CPUPPCState *env = &cpu->env;
>  
>      env->spr[SPR_LPCR] = val & pcc->lpcr_mask;
> -    ppc_hash64_update_vrma(cpu);
>  }
>  
>  void helper_store_lpcr(CPUPPCState *env, target_ulong val)

