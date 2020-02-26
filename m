Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42DD1C4BA13
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 14:49:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19F6C21D7E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 14:49:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19F6C21D7E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6xzm-0004cq-9F
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 09:49:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54093)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1j6xz6-000452-2n
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 09:48:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1j6xz4-0003fP-Sf
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 09:48:24 -0500
Received: from 4.mo177.mail-out.ovh.net ([46.105.37.72]:53070)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1j6xz4-0003bS-NJ
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 09:48:22 -0500
Received: from player791.ha.ovh.net (unknown [10.110.208.83])
 by mo177.mail-out.ovh.net (Postfix) with ESMTP id BA6CB121BCD
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2020 15:48:19 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player791.ha.ovh.net (Postfix) with ESMTPSA id A6D3FFBF011F;
 Wed, 26 Feb 2020 14:47:56 +0000 (UTC)
Date: Wed, 26 Feb 2020 15:47:53 +0100
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v6 18/18] spapr: Fold spapr_node0_size() into its only
 caller
Message-ID: <20200226154753.31782c90@bahia.home>
In-Reply-To: <20200224233724.46415-19-david@gibson.dropbear.id.au>
References: <20200224233724.46415-1-david@gibson.dropbear.id.au>
 <20200224233724.46415-19-david@gibson.dropbear.id.au>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 9598015234245171686
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrleeggdejtdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgfgsehtjeertdertddvnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpkedvrddvheefrddvtdekrddvgeeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeeluddrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.37.72
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
 "Michael S. Tsirkin" <mst@redhat.com>, aik@ozlabs.ru, farosas@linux.ibm.com,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>, qemu-ppc@nongnu.org, clg@kaod.org,
 Paolo Bonzini <pbonzini@redhat.com>, "Edgar E.
 Iglesias" <edgar.iglesias@gmail.com>, paulus@samba.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 25 Feb 2020 10:37:24 +1100
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
> index f0354b699d..9ba645c9cb 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -296,20 +296,6 @@ static void spapr_populate_pa_features(SpaprMachineState *spapr,
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
> @@ -2652,10 +2638,24 @@ static hwaddr spapr_rma_size(SpaprMachineState *spapr, Error **errp)
>  {
>      MachineState *machine = MACHINE(spapr);
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
> +                rma_size = MIN(rma_size,
> +                               machine->numa_state->nodes[i].node_mem);
> +                break;
> +            }
> +        }
> +    }
>  
>      /*
>       * VRMA access is via a special 1TiB SLB mapping, so the RMA can
> @@ -2672,6 +2672,11 @@ static hwaddr spapr_rma_size(SpaprMachineState *spapr, Error **errp)
>          spapr->rma_size = MIN(spapr->rma_size, smc->rma_limit);
>      }
>  
> +    /*
> +     * RMA size must be a power of 2
> +     */
> +    rma_size = pow2floor(rma_size);
> +

This slightly changes semantics. In a scenario without NUMA,
we used to get:

    rma_size == machine->ram_size

but with this patch we now get:

    rma_size == pow2floor(machine->ram_size)

Maybe mention it in the changelog ?

Anyway,

Reviewed-by: Greg Kurz <groug@kaod.org>

>      if (rma_size < (MIN_RMA_SLOF * MiB)) {
>          error_setg(errp,
>  "pSeries SLOF firmware requires >= %ldMiB guest RMA (Real Mode Area)",


