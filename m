Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF53AC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 06:38:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAF60205CB
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 06:38:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAF60205CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZ7VW-0005cH-Uu
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 02:38:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41174)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jZ7ST-0001Q1-Bd
 for qemu-devel@nongnu.org; Thu, 14 May 2020 02:35:05 -0400
Received: from 15.mo7.mail-out.ovh.net ([87.98.180.21]:46957)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jZ7SR-0002HC-1M
 for qemu-devel@nongnu.org; Thu, 14 May 2020 02:35:05 -0400
Received: from player734.ha.ovh.net (unknown [10.108.42.196])
 by mo7.mail-out.ovh.net (Postfix) with ESMTP id 078F6160E86
 for <qemu-devel@nongnu.org>; Thu, 14 May 2020 08:35:01 +0200 (CEST)
Received: from kaod.org (82-64-250-170.subs.proxad.net [82.64.250.170])
 (Authenticated sender: clg@kaod.org)
 by player734.ha.ovh.net (Postfix) with ESMTPSA id 8A5F91232B139;
 Thu, 14 May 2020 06:34:57 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-96R001b52fda9c-6d62-4f12-b561-81b15c564397,92317E36A8DCBCCD86D4D3FC09BF80838F08FB4C)
 smtp.auth=clg@kaod.org
Subject: Re: [PATCH v2 6/6] target/ppc: Don't update radix PTE R/C bits with
 gdbstub
To: Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>
References: <158941060199.240484.5620994992064687533.stgit@bahia.lan>
 <158941063899.240484.2778628492106387793.stgit@bahia.lan>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <083fee97-e40c-8cfa-cf3d-166ed2a67395@kaod.org>
Date: Thu, 14 May 2020 08:34:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <158941063899.240484.2778628492106387793.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 16614904925954214739
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrleehgddutdejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfesthekredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeefffdvtddugeeifeduuefghfejgfeigeeigeeltedthefgieeiveeuiefhgeefgfenucfkpheptddrtddrtddrtddpkedvrdeigedrvdehtddrudejtdenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejfeegrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
Received-SPF: pass client-ip=87.98.180.21; envelope-from=clg@kaod.org;
 helo=15.mo7.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 02:35:01
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/14/20 12:57 AM, Greg Kurz wrote:
> gdbstub shouldn't silently change guest visible state when doing address
> translation. Since the R/C bits can only be updated when handling a MMU
> fault, let's reuse the cause_excp flag and rename it to guest_visible.
> While here drop a not very useful comment.
> 
> This was found while reading the code. I could verify that this affects
> both powernv and pseries, but I failed to observe any actual bug.
> 
> Fixes: d04ea940c597 "target/ppc: Add support for Radix partition-scoped translation"
> Signed-off-by: Greg Kurz <groug@kaod.org>

Reviewed-by: Cédric Le Goater <clg@kaod.org>

> ---
>  target/ppc/mmu-radix64.c |   39 +++++++++++++++++++++------------------
>  1 file changed, 21 insertions(+), 18 deletions(-)
> 
> diff --git a/target/ppc/mmu-radix64.c b/target/ppc/mmu-radix64.c
> index 7ce37cb778db..0d3922537c4c 100644
> --- a/target/ppc/mmu-radix64.c
> +++ b/target/ppc/mmu-radix64.c
> @@ -274,7 +274,7 @@ static int ppc_radix64_partition_scoped_xlate(PowerPCCPU *cpu, int rwx,
>                                                ppc_v3_pate_t pate,
>                                                hwaddr *h_raddr, int *h_prot,
>                                                int *h_page_size, bool pde_addr,
> -                                              bool cause_excp)
> +                                              bool guest_visible)
>  {
>      int fault_cause = 0;
>      hwaddr pte_addr;
> @@ -289,14 +289,15 @@ static int ppc_radix64_partition_scoped_xlate(PowerPCCPU *cpu, int rwx,
>          if (pde_addr) { /* address being translated was that of a guest pde */
>              fault_cause |= DSISR_PRTABLE_FAULT;
>          }
> -        if (cause_excp) {
> +        if (guest_visible) {
>              ppc_radix64_raise_hsi(cpu, rwx, eaddr, g_raddr, fault_cause);
>          }
>          return 1;
>      }
>  
> -    /* Update Reference and Change Bits */
> -    ppc_radix64_set_rc(cpu, rwx, pte, pte_addr, h_prot);
> +    if (guest_visible) {
> +        ppc_radix64_set_rc(cpu, rwx, pte, pte_addr, h_prot);
> +    }
>  
>      return 0;
>  }
> @@ -305,7 +306,7 @@ static int ppc_radix64_process_scoped_xlate(PowerPCCPU *cpu, int rwx,
>                                              vaddr eaddr, uint64_t pid,
>                                              ppc_v3_pate_t pate, hwaddr *g_raddr,
>                                              int *g_prot, int *g_page_size,
> -                                            bool cause_excp)
> +                                            bool guest_visible)
>  {
>      CPUState *cs = CPU(cpu);
>      CPUPPCState *env = &cpu->env;
> @@ -319,7 +320,7 @@ static int ppc_radix64_process_scoped_xlate(PowerPCCPU *cpu, int rwx,
>      size = 1ULL << ((pate.dw1 & PATE1_R_PRTS) + 12);
>      if (offset >= size) {
>          /* offset exceeds size of the process table */
> -        if (cause_excp) {
> +        if (guest_visible) {
>              ppc_radix64_raise_si(cpu, rwx, eaddr, DSISR_NOPTE);
>          }
>          return 1;
> @@ -340,7 +341,7 @@ static int ppc_radix64_process_scoped_xlate(PowerPCCPU *cpu, int rwx,
>          ret = ppc_radix64_partition_scoped_xlate(cpu, 0, eaddr, prtbe_addr,
>                                                   pate, &h_raddr, &h_prot,
>                                                   &h_page_size, true,
> -                                                 cause_excp);
> +                                                 guest_visible);
>          if (ret) {
>              return ret;
>          }
> @@ -360,7 +361,7 @@ static int ppc_radix64_process_scoped_xlate(PowerPCCPU *cpu, int rwx,
>                                      &fault_cause, &pte_addr);
>          if (ret) {
>              /* No valid PTE */
> -            if (cause_excp) {
> +            if (guest_visible) {
>                  ppc_radix64_raise_si(cpu, rwx, eaddr, fault_cause);
>              }
>              return ret;
> @@ -380,7 +381,7 @@ static int ppc_radix64_process_scoped_xlate(PowerPCCPU *cpu, int rwx,
>              ret = ppc_radix64_partition_scoped_xlate(cpu, 0, eaddr, pte_addr,
>                                                       pate, &h_raddr, &h_prot,
>                                                       &h_page_size, true,
> -                                                     cause_excp);
> +                                                     guest_visible);
>              if (ret) {
>                  return ret;
>              }
> @@ -389,7 +390,7 @@ static int ppc_radix64_process_scoped_xlate(PowerPCCPU *cpu, int rwx,
>                                           &nls, g_page_size, &pte, &fault_cause);
>              if (ret) {
>                  /* No valid pte */
> -                if (cause_excp) {
> +                if (guest_visible) {
>                      ppc_radix64_raise_si(cpu, rwx, eaddr, fault_cause);
>                  }
>                  return ret;
> @@ -406,13 +407,15 @@ static int ppc_radix64_process_scoped_xlate(PowerPCCPU *cpu, int rwx,
>  
>      if (ppc_radix64_check_prot(cpu, rwx, pte, &fault_cause, g_prot, false)) {
>          /* Access denied due to protection */
> -        if (cause_excp) {
> +        if (guest_visible) {
>              ppc_radix64_raise_si(cpu, rwx, eaddr, fault_cause);
>          }
>          return 1;
>      }
>  
> -    ppc_radix64_set_rc(cpu, rwx, pte, pte_addr, g_prot);
> +    if (guest_visible) {
> +        ppc_radix64_set_rc(cpu, rwx, pte, pte_addr, g_prot);
> +    }
>  
>      return 0;
>  }
> @@ -437,7 +440,7 @@ static int ppc_radix64_process_scoped_xlate(PowerPCCPU *cpu, int rwx,
>  static int ppc_radix64_xlate(PowerPCCPU *cpu, vaddr eaddr, int rwx,
>                               bool relocation,
>                               hwaddr *raddr, int *psizep, int *protp,
> -                             bool cause_excp)
> +                             bool guest_visible)
>  {
>      CPUPPCState *env = &cpu->env;
>      uint64_t lpid, pid;
> @@ -447,7 +450,7 @@ static int ppc_radix64_xlate(PowerPCCPU *cpu, vaddr eaddr, int rwx,
>  
>      /* Virtual Mode Access - get the fully qualified address */
>      if (!ppc_radix64_get_fully_qualified_addr(&cpu->env, eaddr, &lpid, &pid)) {
> -        if (cause_excp) {
> +        if (guest_visible) {
>              ppc_radix64_raise_segi(cpu, rwx, eaddr);
>          }
>          return 1;
> @@ -460,13 +463,13 @@ static int ppc_radix64_xlate(PowerPCCPU *cpu, vaddr eaddr, int rwx,
>          vhc->get_pate(cpu->vhyp, &pate);
>      } else {
>          if (!ppc64_v3_get_pate(cpu, lpid, &pate)) {
> -            if (cause_excp) {
> +            if (guest_visible) {
>                  ppc_radix64_raise_si(cpu, rwx, eaddr, DSISR_NOPTE);
>              }
>              return 1;
>          }
>          if (!validate_pate(cpu, lpid, &pate)) {
> -            if (cause_excp) {
> +            if (guest_visible) {
>                  ppc_radix64_raise_si(cpu, rwx, eaddr, DSISR_R_BADCONFIG);
>              }
>              return 1;
> @@ -487,7 +490,7 @@ static int ppc_radix64_xlate(PowerPCCPU *cpu, vaddr eaddr, int rwx,
>      if (relocation) {
>          int ret = ppc_radix64_process_scoped_xlate(cpu, rwx, eaddr, pid,
>                                                     pate, &g_raddr, &prot,
> -                                                   &psize, cause_excp);
> +                                                   &psize, guest_visible);
>          if (ret) {
>              return ret;
>          }
> @@ -510,7 +513,7 @@ static int ppc_radix64_xlate(PowerPCCPU *cpu, vaddr eaddr, int rwx,
>  
>              ret = ppc_radix64_partition_scoped_xlate(cpu, rwx, eaddr, g_raddr,
>                                                       pate, raddr, &prot, &psize,
> -                                                     0, cause_excp);
> +                                                     0, guest_visible);
>              if (ret) {
>                  return ret;
>              }
> 


