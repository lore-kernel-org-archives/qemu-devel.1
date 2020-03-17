Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 206E7C10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 11:04:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8BB620714
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 11:04:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8BB620714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEA12-0000m5-2K
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 07:04:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56043)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1jE9zj-0007sr-Ek
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 07:02:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1jE9zh-0007bx-NR
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 07:02:47 -0400
Received: from 1.mo173.mail-out.ovh.net ([178.33.111.180]:47433)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1jE9zh-0007SH-Gy
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 07:02:45 -0400
Received: from player159.ha.ovh.net (unknown [10.110.103.169])
 by mo173.mail-out.ovh.net (Postfix) with ESMTP id 59F761349CE
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 12:02:42 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player159.ha.ovh.net (Postfix) with ESMTPSA id 8A944107C9561;
 Tue, 17 Mar 2020 11:02:19 +0000 (UTC)
Date: Tue, 17 Mar 2020 12:02:14 +0100
From: Greg Kurz <groug@kaod.org>
To: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 1/5] ppc/spapr: KVM FWNMI should not be enabled until
 guest requests it
Message-ID: <20200317120214.58195d0e@bahia.lan>
In-Reply-To: <20200317050215.159334-2-npiggin@gmail.com>
References: <20200317050215.159334-1-npiggin@gmail.com>
 <20200317050215.159334-2-npiggin@gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 12561102312280988099
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrudefhedgudelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecuffhomhgrihhnpehoiihlrggsshdrohhrghenucfkpheptddrtddrtddrtddpkedvrddvheefrddvtdekrddvgeeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrudehledrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 178.33.111.180
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
Cc: Aravinda Prasad <arawinda.p@gmail.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org,
 =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@fr.ibm.com>,
 Ganesh Goudar <ganeshgr@linux.ibm.com>, qemu-ppc@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 17 Mar 2020 15:02:11 +1000
Nicholas Piggin <npiggin@gmail.com> wrote:

> The KVM FWNMI capability should be enabled with the "ibm,nmi-register"
> rtas call. Although MCEs from KVM will be delivered as architected
> interrupts to the guest before "ibm,nmi-register" is called, KVM has
> different behaviour depending on whether the guest has enabled FWNMI
> (it attempts to do more recovery on behalf of a non-FWNMI guest).
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  hw/ppc/spapr_caps.c  | 5 +++--
>  hw/ppc/spapr_rtas.c  | 7 +++++++
>  target/ppc/kvm.c     | 7 +++++++
>  target/ppc/kvm_ppc.h | 6 ++++++
>  4 files changed, 23 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
> index 679ae7959f..eb5521d0c2 100644
> --- a/hw/ppc/spapr_caps.c
> +++ b/hw/ppc/spapr_caps.c
> @@ -517,9 +517,10 @@ static void cap_fwnmi_apply(SpaprMachineState *spapr, uint8_t val,
>      }
>  
>      if (kvm_enabled()) {
> -        if (kvmppc_set_fwnmi() < 0) {
> +        if (!kvmppc_get_fwnmi()) {
>              error_setg(errp, "Firmware Assisted Non-Maskable Interrupts(FWNMI) "
> -                             "not supported by KVM");
> +                             "not supported by KVM, "
> +                             "try appending -machine cap-fwnmi=off");

It is usually preferred to keep error message strings on one
line for easier grepping. Also hints should be specified with
error_append_hint() because they are treated differently by
QMP (ie. not printed).

Something like:

        if (!kvmppc_get_fwnmi()) {
            error_setg(errp,
       "Firmware Assisted Non-Maskable Interrupts(FWNMI) not supported by KVM");
            error_append_hint(errp, "Try appending -machine cap-fwnmi=off\n");
        }

Note that the current error handling code has an issue that
prevents hints to be printed when errp == &error_fatal, which
is exactly what spapr_caps_apply() does. Since this affects
a lot of locations in the code base, there's an on-going
effort to fix that globally:

https://patchwork.ozlabs.org/project/qemu-devel/list/?series=163907

I don't know if this will make it for 5.0, but in any case I
think you should call error_append_hint() in this patch anyway
and the code will just work at some later point.

Rest looks good.

>          }
>      }
>  }
> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
> index 9fb8c8632a..29abe66d01 100644
> --- a/hw/ppc/spapr_rtas.c
> +++ b/hw/ppc/spapr_rtas.c
> @@ -437,6 +437,13 @@ static void rtas_ibm_nmi_register(PowerPCCPU *cpu,
>          return;
>      }
>  
> +    if (kvm_enabled()) {
> +        if (kvmppc_set_fwnmi() < 0) {
> +            rtas_st(rets, 0, RTAS_OUT_NOT_SUPPORTED);
> +            return;
> +        }
> +    }
> +
>      spapr->fwnmi_system_reset_addr = sreset_addr;
>      spapr->fwnmi_machine_check_addr = mce_addr;
>  
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 597f72be1b..03d0667e8f 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -88,6 +88,7 @@ static int cap_ppc_safe_indirect_branch;
>  static int cap_ppc_count_cache_flush_assist;
>  static int cap_ppc_nested_kvm_hv;
>  static int cap_large_decr;
> +static int cap_fwnmi;
>  
>  static uint32_t debug_inst_opcode;
>  
> @@ -136,6 +137,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>      kvmppc_get_cpu_characteristics(s);
>      cap_ppc_nested_kvm_hv = kvm_vm_check_extension(s, KVM_CAP_PPC_NESTED_HV);
>      cap_large_decr = kvmppc_get_dec_bits();
> +    cap_fwnmi = kvm_vm_check_extension(s, KVM_CAP_PPC_FWNMI);
>      /*
>       * Note: setting it to false because there is not such capability
>       * in KVM at this moment.
> @@ -2064,6 +2066,11 @@ void kvmppc_set_mpic_proxy(PowerPCCPU *cpu, int mpic_proxy)
>      }
>  }
>  
> +bool kvmppc_get_fwnmi(void)
> +{
> +    return cap_fwnmi;
> +}
> +
>  int kvmppc_set_fwnmi(void)
>  {
>      PowerPCCPU *cpu = POWERPC_CPU(first_cpu);
> diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
> index 332fa0aa1c..fcaf745516 100644
> --- a/target/ppc/kvm_ppc.h
> +++ b/target/ppc/kvm_ppc.h
> @@ -27,6 +27,7 @@ void kvmppc_enable_h_page_init(void);
>  void kvmppc_set_papr(PowerPCCPU *cpu);
>  int kvmppc_set_compat(PowerPCCPU *cpu, uint32_t compat_pvr);
>  void kvmppc_set_mpic_proxy(PowerPCCPU *cpu, int mpic_proxy);
> +bool kvmppc_get_fwnmi(void);
>  int kvmppc_set_fwnmi(void);
>  int kvmppc_smt_threads(void);
>  void kvmppc_error_append_smt_possible_hint(Error *const *errp);
> @@ -163,6 +164,11 @@ static inline void kvmppc_set_mpic_proxy(PowerPCCPU *cpu, int mpic_proxy)
>  {
>  }
>  
> +static inline bool kvmppc_get_fwnmi(void)
> +{
> +    return false;
> +}
> +
>  static inline int kvmppc_set_fwnmi(void)
>  {
>      return -1;


