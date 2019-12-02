Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB322C432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 07:53:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 912682146E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 07:53:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 912682146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibgWn-0007gH-Nn
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 02:53:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39799)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1ibgVh-0006Wx-Uw
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 02:52:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1ibgVe-0007IB-50
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 02:52:44 -0500
Received: from 6.mo179.mail-out.ovh.net ([46.105.56.76]:60832)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1ibgVc-0007Ga-Iv
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 02:52:42 -0500
Received: from player762.ha.ovh.net (unknown [10.108.16.184])
 by mo179.mail-out.ovh.net (Postfix) with ESMTP id C34CB14A1F0
 for <qemu-devel@nongnu.org>; Mon,  2 Dec 2019 08:52:37 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player762.ha.ovh.net (Postfix) with ESMTPSA id 07092CC63E40;
 Mon,  2 Dec 2019 07:52:28 +0000 (UTC)
Date: Mon, 2 Dec 2019 08:52:27 +0100
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [for-5.0 2/4] spapr: Improve handling of fdt buffer size
Message-ID: <20191202085227.0077fc5a@bahia.w3ibm.bluemix.net>
In-Reply-To: <20191129053356.232413-3-david@gibson.dropbear.id.au>
References: <20191129053356.232413-1-david@gibson.dropbear.id.au>
 <20191129053356.232413-3-david@gibson.dropbear.id.au>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 14034623816943770086
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudejgedgudduhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjqdffgfeufgfipdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgfgsehtjeertdertddvnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpkedvrddvheefrddvtdekrddvgeeknecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejiedvrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghenucevlhhushhtvghrufhiiigvpedt
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.56.76
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
Cc: lvivier@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 clg@kaod.org, mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 29 Nov 2019 16:33:54 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> Previously, spapr_build_fdt() constructed the device tree in a fixed
> buffer of size FDT_MAX_SIZE.  This is a bit inflexible, but more
> importantly it's awkward for the case where we use it during CAS.  In
> that case the guest firmware supplies a buffer and we have to
> awkwardly check that what we generated fits into it afterwards, after
> doing a lot of size checks during spapr_build_fdt().
> 
> Simplify this by having spapr_build_fdt() take a 'space' parameter.
> For the CAS case, we pass in the buffer size provided by SLOF, for the
> machine init case, we continue to pass FDT_MAX_SIZE.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  hw/ppc/spapr.c | 33 +++++++++++----------------------
>  1 file changed, 11 insertions(+), 22 deletions(-)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index d9c9a2bcee..d34e317f48 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -917,7 +917,8 @@ static bool spapr_hotplugged_dev_before_cas(void)
>      return false;
>  }
>  
> -static void *spapr_build_fdt(SpaprMachineState *spapr, bool reset);
> +static void *spapr_build_fdt(SpaprMachineState *spapr, bool reset,
> +                             size_t space);
>  
>  int spapr_h_cas_compose_response(SpaprMachineState *spapr,
>                                   target_ulong addr, target_ulong size,
> @@ -930,24 +931,17 @@ int spapr_h_cas_compose_response(SpaprMachineState *spapr,
>          return 1;
>      }
>  
> -    if (size < sizeof(hdr) || size > FW_MAX_SIZE) {
> -        error_report("SLOF provided an unexpected CAS buffer size "
> -                     TARGET_FMT_lu " (min: %zu, max: %u)",
> -                     size, sizeof(hdr), FW_MAX_SIZE);
> +    if (size < sizeof(hdr)) {
> +        error_report("SLOF provided insufficient CAS buffer "
> +                     TARGET_FMT_lu " (min: %zu)", size, sizeof(hdr));
>          exit(EXIT_FAILURE);
>      }
>  
>      size -= sizeof(hdr);
>  
> -    fdt = spapr_build_fdt(spapr, false);
> +    fdt = spapr_build_fdt(spapr, false, size);
>      _FDT((fdt_pack(fdt)));
>  
> -    if (fdt_totalsize(fdt) + sizeof(hdr) > size) {
> -        g_free(fdt);
> -        trace_spapr_cas_failed(size);
> -        return -1;
> -    }
> -
>      cpu_physical_memory_write(addr, &hdr, sizeof(hdr));
>      cpu_physical_memory_write(addr + sizeof(hdr), fdt, fdt_totalsize(fdt));
>      trace_spapr_cas_continue(fdt_totalsize(fdt) + sizeof(hdr));
> @@ -1197,7 +1191,8 @@ static void spapr_dt_hypervisor(SpaprMachineState *spapr, void *fdt)
>      }
>  }
>  
> -static void *spapr_build_fdt(SpaprMachineState *spapr, bool reset)
> +static void *spapr_build_fdt(SpaprMachineState *spapr, bool reset,
> +                             size_t space)
>  {
>      MachineState *machine = MACHINE(spapr);
>      MachineClass *mc = MACHINE_GET_CLASS(machine);
> @@ -1207,8 +1202,8 @@ static void *spapr_build_fdt(SpaprMachineState *spapr, bool reset)
>      SpaprPhbState *phb;
>      char *buf;
>  
> -    fdt = g_malloc0(FDT_MAX_SIZE);
> -    _FDT((fdt_create_empty_tree(fdt, FDT_MAX_SIZE)));
> +    fdt = g_malloc0(space);
> +    _FDT((fdt_create_empty_tree(fdt, space)));
>  
>      /* Root node */
>      _FDT(fdt_setprop_string(fdt, 0, "device_type", "chrp"));
> @@ -1723,19 +1718,13 @@ static void spapr_machine_reset(MachineState *machine)
>       */
>      fdt_addr = MIN(spapr->rma_size, RTAS_MAX_ADDR) - FDT_MAX_SIZE;
>  
> -    fdt = spapr_build_fdt(spapr, true);
> +    fdt = spapr_build_fdt(spapr, true, FDT_MAX_SIZE);
>  
>      rc = fdt_pack(fdt);
>  
>      /* Should only fail if we've built a corrupted tree */
>      assert(rc == 0);
>  
> -    if (fdt_totalsize(fdt) > FDT_MAX_SIZE) {
> -        error_report("FDT too big ! 0x%x bytes (max is 0x%x)",
> -                     fdt_totalsize(fdt), FDT_MAX_SIZE);
> -        exit(1);
> -    }
> -
>      /* Load the fdt */
>      qemu_fdt_dumpdtb(fdt, fdt_totalsize(fdt));
>      cpu_physical_memory_write(fdt_addr, fdt, fdt_totalsize(fdt));


