Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EEA3C432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 08:24:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04E32215E5
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 08:24:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04E32215E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60391 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibh0Y-0007B2-6F
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 03:24:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43820)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1ibgzl-0006PM-Rx
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 03:23:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1ibgzj-0004FB-OS
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 03:23:49 -0500
Received: from 2.mo7.mail-out.ovh.net ([87.98.143.68]:40709)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1ibgzj-0004EO-H4
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 03:23:47 -0500
Received: from player730.ha.ovh.net (unknown [10.109.143.246])
 by mo7.mail-out.ovh.net (Postfix) with ESMTP id EEDB51418EB
 for <qemu-devel@nongnu.org>; Mon,  2 Dec 2019 09:23:44 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player730.ha.ovh.net (Postfix) with ESMTPSA id CC369CA34049;
 Mon,  2 Dec 2019 08:23:36 +0000 (UTC)
Date: Mon, 2 Dec 2019 09:23:35 +0100
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [for-5.0 3/4] spapr: Fold h_cas_compose_response() into
 h_client_architecture_support()
Message-ID: <20191202092335.5f474f06@bahia.w3ibm.bluemix.net>
In-Reply-To: <20191129053356.232413-4-david@gibson.dropbear.id.au>
References: <20191129053356.232413-1-david@gibson.dropbear.id.au>
 <20191129053356.232413-4-david@gibson.dropbear.id.au>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 14560137595893815782
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudejgedguddvudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjqdffgfeufgfipdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgfgsehtjeertdertddvnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpkedvrddvheefrddvtdekrddvgeeknecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejfedtrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghenucevlhhushhtvghrufhiiigvpedt
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 87.98.143.68
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

On Fri, 29 Nov 2019 16:33:55 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> spapr_h_cas_compose_response() handles the last piece of the PAPR feature
> negotiation process invoked via the ibm,client-architecture-support OF
> call.  Its only caller is h_client_architecture_support() which handles
> most of the rest of that process.
> 
> I believe it was place in a separate file originally to handle some fiddly

it was placed

> dependencies between functions, but mostly it's just confusing to have
> the CAS process split into two pieces like this.  Now that compose response
> is simplified (by just generating the whole device tree anew), it's cleaner
> to just fold it into h_client_architecture_support().
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  hw/ppc/spapr.c         | 61 +-----------------------------------------
>  hw/ppc/spapr_hcall.c   | 55 ++++++++++++++++++++++++++++++++++---
>  include/hw/ppc/spapr.h |  4 +--
>  3 files changed, 54 insertions(+), 66 deletions(-)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index d34e317f48..5187f5b0a5 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -76,7 +76,6 @@
>  #include "hw/nmi.h"
>  #include "hw/intc/intc.h"
>  
> -#include "qemu/cutils.h"
>  #include "hw/ppc/spapr_cpu_core.h"
>  #include "hw/mem/memory-device.h"
>  #include "hw/ppc/spapr_tpm_proxy.h"
> @@ -897,63 +896,6 @@ out:
>      return ret;
>  }
>  
> -static bool spapr_hotplugged_dev_before_cas(void)
> -{
> -    Object *drc_container, *obj;
> -    ObjectProperty *prop;
> -    ObjectPropertyIterator iter;
> -
> -    drc_container = container_get(object_get_root(), "/dr-connector");
> -    object_property_iter_init(&iter, drc_container);
> -    while ((prop = object_property_iter_next(&iter))) {
> -        if (!strstart(prop->type, "link<", NULL)) {
> -            continue;
> -        }
> -        obj = object_property_get_link(drc_container, prop->name, NULL);
> -        if (spapr_drc_needed(obj)) {
> -            return true;
> -        }
> -    }
> -    return false;
> -}
> -
> -static void *spapr_build_fdt(SpaprMachineState *spapr, bool reset,
> -                             size_t space);
> -
> -int spapr_h_cas_compose_response(SpaprMachineState *spapr,
> -                                 target_ulong addr, target_ulong size,
> -                                 SpaprOptionVector *ov5_updates)
> -{
> -    void *fdt;
> -    SpaprDeviceTreeUpdateHeader hdr = { .version_id = 1 };
> -
> -    if (spapr_hotplugged_dev_before_cas()) {
> -        return 1;
> -    }
> -
> -    if (size < sizeof(hdr)) {
> -        error_report("SLOF provided insufficient CAS buffer "
> -                     TARGET_FMT_lu " (min: %zu)", size, sizeof(hdr));
> -        exit(EXIT_FAILURE);
> -    }
> -
> -    size -= sizeof(hdr);
> -
> -    fdt = spapr_build_fdt(spapr, false, size);
> -    _FDT((fdt_pack(fdt)));
> -
> -    cpu_physical_memory_write(addr, &hdr, sizeof(hdr));
> -    cpu_physical_memory_write(addr + sizeof(hdr), fdt, fdt_totalsize(fdt));
> -    trace_spapr_cas_continue(fdt_totalsize(fdt) + sizeof(hdr));
> -
> -    g_free(spapr->fdt_blob);
> -    spapr->fdt_size = fdt_totalsize(fdt);
> -    spapr->fdt_initial_size = spapr->fdt_size;
> -    spapr->fdt_blob = fdt;
> -
> -    return 0;
> -}
> -
>  static void spapr_dt_rtas(SpaprMachineState *spapr, void *fdt)
>  {
>      MachineState *ms = MACHINE(spapr);
> @@ -1191,8 +1133,7 @@ static void spapr_dt_hypervisor(SpaprMachineState *spapr, void *fdt)
>      }
>  }
>  
> -static void *spapr_build_fdt(SpaprMachineState *spapr, bool reset,
> -                             size_t space)
> +void *spapr_build_fdt(SpaprMachineState *spapr, bool reset, size_t space)
>  {
>      MachineState *machine = MACHINE(spapr);
>      MachineClass *mc = MACHINE_GET_CLASS(machine);
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index 05a7ca275b..0f19be794c 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -1,4 +1,5 @@
>  #include "qemu/osdep.h"
> +#include "qemu/cutils.h"
>  #include "qapi/error.h"
>  #include "sysemu/hw_accel.h"
>  #include "sysemu/runstate.h"
> @@ -15,6 +16,7 @@
>  #include "cpu-models.h"
>  #include "trace.h"
>  #include "kvm_ppc.h"
> +#include "hw/ppc/fdt.h"
>  #include "hw/ppc/spapr_ovec.h"
>  #include "mmu-book3s-v3.h"
>  #include "hw/mem/memory-device.h"
> @@ -1638,6 +1640,26 @@ static uint32_t cas_check_pvr(SpaprMachineState *spapr, PowerPCCPU *cpu,
>      return best_compat;
>  }
>  
> +static bool spapr_hotplugged_dev_before_cas(void)
> +{
> +    Object *drc_container, *obj;
> +    ObjectProperty *prop;
> +    ObjectPropertyIterator iter;
> +
> +    drc_container = container_get(object_get_root(), "/dr-connector");
> +    object_property_iter_init(&iter, drc_container);
> +    while ((prop = object_property_iter_next(&iter))) {
> +        if (!strstart(prop->type, "link<", NULL)) {
> +            continue;
> +        }
> +        obj = object_property_get_link(drc_container, prop->name, NULL);
> +        if (spapr_drc_needed(obj)) {
> +            return true;
> +        }
> +    }
> +    return false;
> +}
> +
>  static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
>                                                    SpaprMachineState *spapr,
>                                                    target_ulong opcode,
> @@ -1645,6 +1667,8 @@ static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
>  {
>      /* Working address in data buffer */
>      target_ulong addr = ppc64_phys_to_real(args[0]);
> +    target_ulong fdt_buf = args[1];
> +    target_ulong fdt_bufsize = args[2];
>      target_ulong ov_table;
>      uint32_t cas_pvr;
>      SpaprOptionVector *ov1_guest, *ov5_guest, *ov5_cas_old, *ov5_updates;
> @@ -1788,16 +1812,41 @@ static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
>  
>      spapr_irq_update_active_intc(spapr);
>  
> +    if (spapr_hotplugged_dev_before_cas()) {
> +        spapr->cas_reboot = true;
> +    }
> +
>      if (!spapr->cas_reboot) {
> +        void *fdt;
> +        SpaprDeviceTreeUpdateHeader hdr = { .version_id = 1 };
> +
>          /* If spapr_machine_reset() did not set up a HPT but one is necessary
>           * (because the guest isn't going to use radix) then set it up here. */
>          if ((spapr->patb_entry & PATE1_GR) && !guest_radix) {
>              /* legacy hash or new hash: */
>              spapr_setup_hpt_and_vrma(spapr);
>          }
> -        spapr->cas_reboot =
> -            (spapr_h_cas_compose_response(spapr, args[1], args[2],
> -                                          ov5_updates) != 0);
> +
> +        if (fdt_bufsize < sizeof(hdr)) {
> +            error_report("SLOF provided insufficient CAS buffer "
> +                         TARGET_FMT_lu " (min: %zu)", fdt_bufsize, sizeof(hdr));
> +            exit(EXIT_FAILURE);
> +        }
> +
> +        fdt_bufsize -= sizeof(hdr);
> +
> +        fdt = spapr_build_fdt(spapr, false, fdt_bufsize);
> +        _FDT((fdt_pack(fdt)));
> +
> +        cpu_physical_memory_write(fdt_buf, &hdr, sizeof(hdr));
> +        cpu_physical_memory_write(fdt_buf + sizeof(hdr), fdt,
> +                                  fdt_totalsize(fdt));
> +        trace_spapr_cas_continue(fdt_totalsize(fdt) + sizeof(hdr));
> +
> +        g_free(spapr->fdt_blob);
> +        spapr->fdt_size = fdt_totalsize(fdt);
> +        spapr->fdt_initial_size = spapr->fdt_size;
> +        spapr->fdt_blob = fdt;
>      }
>  
>      spapr_ovec_cleanup(ov5_updates);
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index d5ab5ea7b2..61f005c6f6 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -766,11 +766,9 @@ struct SpaprEventLogEntry {
>      QTAILQ_ENTRY(SpaprEventLogEntry) next;
>  };
>  
> +void *spapr_build_fdt(SpaprMachineState *spapr, bool reset, size_t space);
>  void spapr_events_init(SpaprMachineState *sm);
>  void spapr_dt_events(SpaprMachineState *sm, void *fdt);
> -int spapr_h_cas_compose_response(SpaprMachineState *sm,
> -                                 target_ulong addr, target_ulong size,
> -                                 SpaprOptionVector *ov5_updates);
>  void close_htab_fd(SpaprMachineState *spapr);
>  void spapr_setup_hpt_and_vrma(SpaprMachineState *spapr);
>  void spapr_free_hpt(SpaprMachineState *spapr);


