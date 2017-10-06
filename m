Received: from eggs.gnu.org ([2001:4830:134:3::10]:52085)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1e0NES-0004DA-7h
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 03:39:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1e0NEP-0004Fd-2Y
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 03:39:40 -0400
Received: from 16.mo4.mail-out.ovh.net ([188.165.55.104]:41522)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1e0NEO-0004E4-SN
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 03:39:37 -0400
Received: from player772.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id 557A8CB956
	for <qemu-devel@nongnu.org>; Fri,  6 Oct 2017 09:39:34 +0200 (CEST)
Date: Fri, 6 Oct 2017 09:39:25 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20171006093925.71e1b3cd@bahia.lan>
In-Reply-To: <1507220690-265042-17-git-send-email-imammedo@redhat.com>
References: <1507220690-265042-1-git-send-email-imammedo@redhat.com>
	<1507220690-265042-17-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 16/23] ppc: spapr: use cpu model names as
 tcg defaults instead of aliases
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, "open list:ppce500" <qemu-ppc@nongnu.org>, "Edgar
	E. Iglesias" <edgar.iglesias@gmail.com>, =?UTF-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>, Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>

On Thu,  5 Oct 2017 18:24:43 +0200
Igor Mammedov <imammedo@redhat.com> wrote:

> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---

So... this is preparatory work for the next patch because the generic cpu_model
parsing code doesn't handle aliases, is it ?

>  hw/ppc/spapr.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index ad7afd6..0661dba 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -3603,7 +3603,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
>      hc->unplug_request = spapr_machine_device_unplug_request;
>  
>      smc->dr_lmb_enabled = true;
> -    smc->tcg_default_cpu = "POWER8";
> +    smc->tcg_default_cpu = "power8_v2.0";
>      mc->has_hotpluggable_cpus = true;
>      smc->resize_hpt_default = SPAPR_RESIZE_HPT_ENABLED;
>      fwc->get_dev_path = spapr_get_fw_dev_path;
> @@ -3849,7 +3849,7 @@ static void spapr_machine_2_7_class_options(MachineClass *mc)
>      sPAPRMachineClass *smc = SPAPR_MACHINE_CLASS(mc);
>  
>      spapr_machine_2_8_class_options(mc);
> -    smc->tcg_default_cpu = "POWER7";
> +    smc->tcg_default_cpu = "power7_v2.3";
>      SET_MACHINE_COMPAT(mc, SPAPR_COMPAT_2_7);
>      smc->phb_placement = phb_placement_2_7;
>  }
