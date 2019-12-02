Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE3F2C432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 07:09:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2FF42146E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 07:09:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2FF42146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibfpT-0006P1-02
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 02:09:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35338)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1ibfkw-0002FV-2W
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 02:04:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1ibfku-0000jP-Bc
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 02:04:25 -0500
Received: from 3.mo178.mail-out.ovh.net ([46.105.44.197]:56707)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1ibfkp-0000cW-Io
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 02:04:21 -0500
Received: from player726.ha.ovh.net (unknown [10.108.16.46])
 by mo178.mail-out.ovh.net (Postfix) with ESMTP id 4DAB982D9A
 for <qemu-devel@nongnu.org>; Mon,  2 Dec 2019 08:04:16 +0100 (CET)
Received: from kaod.org (lfbn-1-2229-223.w90-76.abo.wanadoo.fr [90.76.50.223])
 (Authenticated sender: clg@kaod.org)
 by player726.ha.ovh.net (Postfix) with ESMTPSA id 66F4CCB2A324;
 Mon,  2 Dec 2019 07:04:08 +0000 (UTC)
Subject: Re: [for-5.0 3/4] spapr: Fold h_cas_compose_response() into
 h_client_architecture_support()
To: David Gibson <david@gibson.dropbear.id.au>, groug@kaod.org
References: <20191129053356.232413-1-david@gibson.dropbear.id.au>
 <20191129053356.232413-4-david@gibson.dropbear.id.au>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <b0a972a1-df7c-475c-aa48-3adc85744dbe@kaod.org>
Date: Mon, 2 Dec 2019 08:04:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191129053356.232413-4-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 13218064908697897792
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudejgedguddthecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjqdffgfeufgfipdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdeltddrjeeirdehtddrvddvfeenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjedviedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgnecuvehluhhsthgvrhfuihiivgepud
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.44.197
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
Cc: lvivier@redhat.com, qemu-ppc@nongnu.org, mdroth@linux.vnet.ibm.com,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 29/11/2019 06:33, David Gibson wrote:
> spapr_h_cas_compose_response() handles the last piece of the PAPR feature
> negotiation process invoked via the ibm,client-architecture-support OF
> call.  Its only caller is h_client_architecture_support() which handles
> most of the rest of that process.
> 
> I believe it was place in a separate file originally to handle some fiddly
> dependencies between functions, but mostly it's just confusing to have
> the CAS process split into two pieces like this.  Now that compose response
> is simplified (by just generating the whole device tree anew), it's cleaner
> to just fold it into h_client_architecture_support().
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Reviewed-by: Cedric Le Goater <clg@fr.ibm.com>

> ---
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
> 


