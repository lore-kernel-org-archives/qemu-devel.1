Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF448C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 18:35:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9156920674
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 18:35:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9156920674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46114 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDuaY-0005X0-QY
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 14:35:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39303)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1jDtND-0001jt-TH
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:17:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1jDtNB-0006ey-Ly
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:17:55 -0400
Received: from 8.mo2.mail-out.ovh.net ([188.165.52.147]:49930)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1jDtNB-0006Rn-CD
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:17:53 -0400
Received: from player711.ha.ovh.net (unknown [10.108.42.23])
 by mo2.mail-out.ovh.net (Postfix) with ESMTP id 932021CE1A9
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 18:17:48 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player711.ha.ovh.net (Postfix) with ESMTPSA id ED3211058437B;
 Mon, 16 Mar 2020 17:17:41 +0000 (UTC)
Date: Mon, 16 Mar 2020 18:17:39 +0100
From: Greg Kurz <groug@kaod.org>
To: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 3/8] ppc/spapr: Add FWNMI System Reset state
Message-ID: <20200316181739.78063a7c@bahia.lan>
In-Reply-To: <20200316142613.121089-4-npiggin@gmail.com>
References: <20200316142613.121089-1-npiggin@gmail.com>
 <20200316142613.121089-4-npiggin@gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 13023284222544222659
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrudeffedgleekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejuddurdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 188.165.52.147
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
 Ganesh Goudar <ganeshgr@linux.ibm.com>, qemu-ppc@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 17 Mar 2020 00:26:08 +1000
Nicholas Piggin <npiggin@gmail.com> wrote:

> The FWNMI option must deliver system reset interrupts to their
> registered address, and there are a few constraints on the handler
> addresses specified in PAPR. Add the system reset address state and
> checks.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  hw/ppc/spapr.c         |  2 ++
>  hw/ppc/spapr_rtas.c    | 14 +++++++++++++-
>  include/hw/ppc/spapr.h |  3 ++-
>  3 files changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index b03b26370d..5f93c49706 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1704,6 +1704,7 @@ static void spapr_machine_reset(MachineState *machine)
>  
>      spapr->cas_reboot = false;
>  
> +    spapr->fwnmi_system_reset_addr = -1;
>      spapr->fwnmi_machine_check_addr = -1;
>      spapr->fwnmi_machine_check_interlock = -1;
>  
> @@ -2023,6 +2024,7 @@ static const VMStateDescription vmstate_spapr_fwnmi = {
>      .needed = spapr_fwnmi_needed,
>      .pre_save = spapr_fwnmi_pre_save,
>      .fields = (VMStateField[]) {
> +        VMSTATE_UINT64(fwnmi_system_reset_addr, SpaprMachineState),
>          VMSTATE_UINT64(fwnmi_machine_check_addr, SpaprMachineState),
>          VMSTATE_INT32(fwnmi_machine_check_interlock, SpaprMachineState),
>          VMSTATE_END_OF_LIST()
> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
> index 0b8c481593..521e6b0b72 100644
> --- a/hw/ppc/spapr_rtas.c
> +++ b/hw/ppc/spapr_rtas.c
> @@ -414,6 +414,7 @@ static void rtas_ibm_nmi_register(PowerPCCPU *cpu,
>                                    uint32_t nret, target_ulong rets)
>  {
>      hwaddr rtas_addr;
> +    target_ulong sreset_addr, mce_addr;
>  
>      if (spapr_get_cap(spapr, SPAPR_CAP_FWNMI) == SPAPR_CAP_OFF) {
>          rtas_st(rets, 0, RTAS_OUT_NOT_SUPPORTED);
> @@ -426,7 +427,18 @@ static void rtas_ibm_nmi_register(PowerPCCPU *cpu,
>          return;
>      }
>  
> -    spapr->fwnmi_machine_check_addr = rtas_ld(args, 1);
> +    sreset_addr = rtas_ld(args, 0);
> +    mce_addr = rtas_ld(args, 1);
> +
> +    /* PAPR requires these are in the first 32M of memory and within RMA */
> +    if (sreset_addr >= 32 * MiB || sreset_addr >= spapr->rma_size ||
> +           mce_addr >= 32 * MiB ||    mce_addr >= spapr->rma_size) {
> +        rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
> +        return;
> +    }
> +
> +    spapr->fwnmi_system_reset_addr = sreset_addr;
> +    spapr->fwnmi_machine_check_addr = mce_addr;
>  
>      rtas_st(rets, 0, RTAS_OUT_SUCCESS);
>  }
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 64b83402cb..42d64a0368 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -194,9 +194,10 @@ struct SpaprMachineState {
>  
>      /* State related to FWNMI option */
>  
> -    /* Machine Check Notification Routine address
> +    /* System Reset and Machine Check Notification Routine addresses
>       * registered by "ibm,nmi-register" RTAS call.
>       */
> +    target_ulong fwnmi_system_reset_addr;
>      target_ulong fwnmi_machine_check_addr;
>  
>      /* Machine Check FWNMI synchronization, fwnmi_machine_check_interlock is


