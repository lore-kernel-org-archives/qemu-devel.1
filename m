Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 025B4C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 09:34:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCD3F2073E
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 09:34:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCD3F2073E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCgi0-0005Zm-Vc
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 05:34:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44774)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1jCghR-00055c-MG
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 05:33:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1jCghQ-00023K-6w
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 05:33:49 -0400
Received: from 6.mo5.mail-out.ovh.net ([178.32.119.138]:48765)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1jCghP-0001P5-VB
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 05:33:48 -0400
Received: from player786.ha.ovh.net (unknown [10.110.208.83])
 by mo5.mail-out.ovh.net (Postfix) with ESMTP id 1F9072736DE
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2020 10:33:38 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player786.ha.ovh.net (Postfix) with ESMTPSA id 4737A108A0D3C;
 Fri, 13 Mar 2020 09:33:34 +0000 (UTC)
Date: Fri, 13 Mar 2020 10:33:30 +0100
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 4/4] spapr: Fold spapr_node0_size() into its only caller
Message-ID: <20200313103330.125530ee@bahia.home>
In-Reply-To: <20200313040539.819138-5-david@gibson.dropbear.id.au>
References: <20200313040539.819138-1-david@gibson.dropbear.id.au>
 <20200313040539.819138-5-david@gibson.dropbear.id.au>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 6012868454024780262
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedruddvjedgtdehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejkeeirdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 178.32.119.138
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
Cc: qemu-ppc@nongnu.org, philmd@redhat.com, clg@kaod.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 13 Mar 2020 15:05:39 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> The Real Mode Area (RMA) needs to fit within the NUMA node owning memory
> at address 0.  That's usually node 0, but can be a later one if there are
> some nodes which have no memory (only CPUs).
> 
> This is currently handled by the spapr_node0_size() helper.  It has only
> one caller, so there's not a lot of point splitting it out.  It's also
> extremely easy to misread the code as clamping to the size of the smallest
> node rather than the first node with any memory.
> 
> So, fold it into the caller, and add some commentary to make it a bit
> clearer exactly what it's doing.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  hw/ppc/spapr.c | 37 +++++++++++++++++++++----------------
>  1 file changed, 21 insertions(+), 16 deletions(-)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 6c32ec3c0a..6a42c0f1c9 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -295,20 +295,6 @@ static void spapr_dt_pa_features(SpaprMachineState *spapr,
>      _FDT((fdt_setprop(fdt, offset, "ibm,pa-features", pa_features, pa_size)));
>  }
>  
> -static hwaddr spapr_node0_size(MachineState *machine)
> -{
> -    if (machine->numa_state->num_nodes) {
> -        int i;
> -        for (i = 0; i < machine->numa_state->num_nodes; ++i) {
> -            if (machine->numa_state->nodes[i].node_mem) {
> -                return MIN(pow2floor(machine->numa_state->nodes[i].node_mem),
> -                           machine->ram_size);
> -            }
> -        }
> -    }
> -    return machine->ram_size;
> -}
> -
>  static void add_str(GString *s, const gchar *s1)
>  {
>      g_string_append_len(s, s1, strlen(s1) + 1);
> @@ -2631,10 +2617,24 @@ static hwaddr spapr_rma_size(SpaprMachineState *spapr, Error **errp)
>      MachineState *machine = MACHINE(spapr);
>      SpaprMachineClass *smc = SPAPR_MACHINE_GET_CLASS(spapr);
>      hwaddr rma_size = machine->ram_size;
> -    hwaddr node0_size = spapr_node0_size(machine);
>  
>      /* RMA has to fit in the first NUMA node */
> -    rma_size = MIN(rma_size, node0_size);
> +    if (machine->numa_state->num_nodes) {
> +        /*
> +         * It's possible for there to be some zero-memory nodes first
> +         * in the list.  We need the RMA to fit inside the memory of
> +         * the first node which actually has some memory.
> +         */
> +        int i;
> +
> +        for (i = 0; i < machine->numa_state->num_nodes; ++i) {
> +            if (machine->numa_state->nodes[i].node_mem != 0) {
> +                hwaddr node_size = machine->numa_state->nodes[i].node_mem;
> +                rma_size = MIN(rma_size, pow2floor(node_size));
> +                break;
> +            }
> +        }
> +    }
>  
>      /*
>       * VRMA access is via a special 1TiB SLB mapping, so the RMA can
> @@ -2651,6 +2651,11 @@ static hwaddr spapr_rma_size(SpaprMachineState *spapr, Error **errp)
>          rma_size = MIN(rma_size, smc->rma_limit);
>      }
>  
> +    /*
> +     * RMA size must be a power of 2
> +     */
> +    rma_size = pow2floor(rma_size);
> +

The patch is identical to the last spin, for which I had
a comment already:

-----------------------------------------------------------------------
On Wed, 4 Mar 2020 12:25:55 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:
> On Tue, Mar 03, 2020 at 11:32:49AM +0100, Greg Kurz wrote:

[...]

> > In any case, it would probably help to mention somewhere
> > why the rounding is introduced by this patch.
> 
> Drat.  I meant to sort out your comment on the last spin better than
> this, but got part way through and forgot what I was doing.
>
-----------------------------------------------------------------------

I still think that the rounding introduced by this patch deserves
some explanations in the changelog...

>      if (rma_size < MIN_RMA_SLOF) {
>          error_setg(errp,
>  "pSeries SLOF firmware requires >= %ldMiB guest RMA (Real Mode Area memory)",


