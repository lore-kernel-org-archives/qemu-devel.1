Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5253C3F2C6
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 10:03:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD1FC20873
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 10:03:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD1FC20873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j94Ou-0002mM-TN
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 05:03:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51268)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1j94O0-0001w5-6O
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 05:02:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1j94Ny-0003XD-Ue
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 05:02:48 -0500
Received: from 6.mo2.mail-out.ovh.net ([87.98.165.38]:42846)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1j94Ny-0003Wk-OC
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 05:02:46 -0500
Received: from player729.ha.ovh.net (unknown [10.108.54.94])
 by mo2.mail-out.ovh.net (Postfix) with ESMTP id E93361CD51E
 for <qemu-devel@nongnu.org>; Tue,  3 Mar 2020 11:02:42 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player729.ha.ovh.net (Postfix) with ESMTPSA id 321131021BF13;
 Tue,  3 Mar 2020 10:02:16 +0000 (UTC)
Date: Tue, 3 Mar 2020 11:02:15 +0100
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v7 15/17] spapr: Don't clamp RMA to 16GiB on new machine
 types
Message-ID: <20200303110215.769a1f66@bahia.home>
In-Reply-To: <20200303034351.333043-16-david@gibson.dropbear.id.au>
References: <20200303034351.333043-1-david@gibson.dropbear.id.au>
 <20200303034351.333043-16-david@gibson.dropbear.id.au>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 3117053894847994342
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedruddtiedguddvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejvdelrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 87.98.165.38
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
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>, farosas@linux.ibm.com,
 aik@ozlabs.ru, "Michael S.
 Tsirkin" <mst@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-ppc@nongnu.org, clg@kaod.org, Igor Mammedov <imammedo@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, paulus@samba.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue,  3 Mar 2020 14:43:49 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> In spapr_machine_init() we clamp the size of the RMA to 16GiB and the
> comment saying why doesn't make a whole lot of sense.  In fact, this was
> done because the real mode handling code elsewhere limited the RMA in TCG
> mode to the maximum value configurable in LPCR[RMLS], 16GiB.
> 
> But,
>  * Actually LPCR[RMLS] has been able to encode a 256GiB size for a very
>    long time, we just didn't implement it properly in the softmmu
>  * LPCR[RMLS] shouldn't really be relevant anyway, it only was because we
>    used to abuse the RMOR based translation mode in order to handle the
>    fact that we're not modelling the hypervisor parts of the cpu
> 
> We've now removed those limitations in the modelling so the 16GiB clamp no
> longer serves a function.  However, we can't just remove the limit
> universally: that would break migration to earlier qemu versions, where
> the 16GiB RMLS limit still applies, no matter how bad the reasons for it
> are.
> 
> So, we replace the 16GiB clamp, with a clamp to a limit defined in the
> machine type class.  We set it to 16 GiB for machine types 4.2 and earlier,
> but set it to 0 meaning unlimited for the new 5.0 machine type.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  hw/ppc/spapr.c         | 13 ++++++++-----
>  include/hw/ppc/spapr.h |  1 +
>  2 files changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index ef7667455c..95bda4a615 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2701,12 +2701,14 @@ static void spapr_machine_init(MachineState *machine)
>  
>      spapr->rma_size = node0_size;
>  
> -    /* Actually we don't support unbounded RMA anymore since we added
> -     * proper emulation of HV mode. The max we can get is 16G which
> -     * also happens to be what we configure for PAPR mode so make sure
> -     * we don't do anything bigger than that
> +    /*
> +     * Clamp the RMA size based on machine type.  This is for
> +     * migration compatibility with older qemu versions, which limited
> +     * the RMA size for complicated and mostly bad reasons.
>       */
> -    spapr->rma_size = MIN(spapr->rma_size, 0x400000000ull);
> +    if (smc->rma_limit) {
> +        spapr->rma_size = MIN(spapr->rma_size, smc->rma_limit);
> +    }
>  
>      if (spapr->rma_size > node0_size) {
>          error_report("Numa node 0 has to span the RMA (%#08"HWADDR_PRIx")",
> @@ -4598,6 +4600,7 @@ static void spapr_machine_4_2_class_options(MachineClass *mc)
>      compat_props_add(mc->compat_props, hw_compat_4_2, hw_compat_4_2_len);
>      smc->default_caps.caps[SPAPR_CAP_CCF_ASSIST] = SPAPR_CAP_OFF;
>      smc->default_caps.caps[SPAPR_CAP_FWNMI_MCE] = SPAPR_CAP_OFF;
> +    smc->rma_limit = 16 * GiB;
>      mc->nvdimm_supported = false;
>  }
>  
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 90dbc55931..2015e37ac5 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -126,6 +126,7 @@ struct SpaprMachineClass {
>      bool pre_4_1_migration; /* don't migrate hpt-max-page-size */
>      bool linux_pci_probe;
>      bool smp_threads_vsmt; /* set VSMT to smp_threads by default */
> +    hwaddr rma_limit;          /* clamp the RMA to this size */
>  
>      void (*phb_placement)(SpaprMachineState *spapr, uint32_t index,
>                            uint64_t *buid, hwaddr *pio, 


