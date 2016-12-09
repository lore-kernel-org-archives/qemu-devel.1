Received: from eggs.gnu.org ([2001:4830:134:3::10]:34961)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1cFLBt-0002o5-Ss
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 08:26:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1cFLBo-0006VW-A4
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 08:26:21 -0500
References: <20161209022314.14399-1-david@gibson.dropbear.id.au>
	<20161209022314.14399-5-david@gibson.dropbear.id.au>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <052cc407-d920-8277-3ad9-6754fb675b0f@redhat.com>
Date: Fri, 9 Dec 2016 14:26:11 +0100
MIME-Version: 1.0
In-Reply-To: <20161209022314.14399-5-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [for-2.9 4/5] pseries: Enable HPT resizing for 2.9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, paulus@samba.org, sjitindarsingh@gmail.com
Cc: agraf@suse.de, mdroth@linux.vnet.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, thuth@redhat.com



On 09/12/2016 03:23, David Gibson wrote:
> We've now implemented a PAPR extensions which allows PAPR guests (i.e.
> "pseries" machine type) to resize their hash page table during runtime.
> 
> However, that extension is only enabled if explicitly chosen on the
> command line.  This patch enables it by default for spapr-2.9, but leaves
> it disabled (by default) for older machine types.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  hw/ppc/spapr.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index f3b74dc..25468f6 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2770,7 +2770,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
>  
>      smc->dr_lmb_enabled = true;
>      smc->tcg_default_cpu = "POWER8";
> -    smc->resize_hpt_default = SPAPR_RESIZE_HPT_DISABLED;
> +    smc->resize_hpt_default = SPAPR_RESIZE_HPT_ENABLED;
>      mc->query_hotpluggable_cpus = spapr_query_hotpluggable_cpus;
>      fwc->get_dev_path = spapr_get_fw_dev_path;
>      nc->nmi_monitor_handler = spapr_nmi;
> @@ -2851,8 +2851,11 @@ static void spapr_machine_2_8_instance_options(MachineState *machine)
>  
>  static void spapr_machine_2_8_class_options(MachineClass *mc)
>  {
> +    sPAPRMachineClass *smc = SPAPR_MACHINE_CLASS(mc);
> +
>      spapr_machine_2_9_class_options(mc);
>      SET_MACHINE_COMPAT(mc, SPAPR_COMPAT_2_8);
> +    smc->resize_hpt_default = SPAPR_RESIZE_HPT_DISABLED;
>  }
>  
>  DEFINE_SPAPR_MACHINE(2_8, "2.8", false);
> 

Reviewed-by: Laurent Vivier <lvivier@redhat.com>
