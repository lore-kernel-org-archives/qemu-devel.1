Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLACK,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1598CC0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 17:39:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFA56205ED
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 17:39:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFA56205ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDtiA-0006Hq-3D
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 13:39:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60978)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1jDsKe-0005rp-S7
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:11:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1jDsKd-0002UN-HN
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:11:12 -0400
Received: from 14.mo4.mail-out.ovh.net ([46.105.40.29]:47052)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1jDsKd-0002Bd-8N
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:11:11 -0400
Received: from player715.ha.ovh.net (unknown [10.108.54.217])
 by mo4.mail-out.ovh.net (Postfix) with ESMTP id 2E43322886F
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 17:11:08 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player715.ha.ovh.net (Postfix) with ESMTPSA id 584AE104B9DC3;
 Mon, 16 Mar 2020 16:10:57 +0000 (UTC)
Date: Mon, 16 Mar 2020 17:10:56 +0100
From: Greg Kurz <groug@kaod.org>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH qemu] spapr/rtas: Reserve space for RTAS blob and log
Message-ID: <20200316171056.0389b72c@bahia.lan>
In-Reply-To: <20200316011841.99970-1-aik@ozlabs.ru>
References: <20200316011841.99970-1-aik@ozlabs.ru>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 11897384318377368053
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrudeffedgkeehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejudehrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.40.29
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 16 Mar 2020 12:18:41 +1100
Alexey Kardashevskiy <aik@ozlabs.ru> wrote:

> At the moment SLOF reserves space for RTAS and instantiates the RTAS blob
> which is 20 bytes binary blob calling an hypercall. The rest of the RTAS
> area is a log which SLOF has no idea about but QEMU does.
> 
> This moves RTAS sizing to QEMU and this overrides the size from SLOF.
> The only remaining problem is that SLOF copies the number of bytes it
> reserved (2KB for now) so QEMU needs to reserve at least this much;
> SLOF will be fixed separately to check that rtas-size from QEMU is
> enough for those 20 bytes the H_RTAS hcall.

20 bytes >for< the H_RTAS hcall ?

Reviewed-by: Greg Kurz <groug@kaod.org>

> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>  include/hw/ppc/spapr.h | 1 +
>  hw/ppc/spapr.c         | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 2015e37ac5c8..35b489a54929 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -736,6 +736,7 @@ void spapr_load_rtas(SpaprMachineState *spapr, void *fdt, hwaddr addr);
>  #define SPAPR_IS_PCI_LIOBN(liobn)   (!!((liobn) & 0x80000000))
>  #define SPAPR_PCI_DMA_WINDOW_NUM(liobn) ((liobn) & 0xff)
>  
> +#define RTAS_SIZE               2048
>  #define RTAS_ERROR_LOG_MAX      2048
>  
>  /* Offset from rtas-base where error log is placed */
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 64bc8b83e91e..d3db3ec56e9c 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -967,6 +967,7 @@ static void spapr_dt_rtas(SpaprMachineState *spapr, void *fdt)
>      _FDT(fdt_setprop(fdt, rtas, "ibm,max-associativity-domains",
>                       maxdomains, sizeof(maxdomains)));
>  
> +    _FDT(fdt_setprop_cell(fdt, rtas, "rtas-size", RTAS_SIZE));
>      _FDT(fdt_setprop_cell(fdt, rtas, "rtas-error-log-max",
>                            RTAS_ERROR_LOG_MAX));
>      _FDT(fdt_setprop_cell(fdt, rtas, "rtas-event-scan-rate",


