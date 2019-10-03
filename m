Return-Path: <SRS0=VLgg=X4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFFD1C10F14
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 12:23:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 953D9218DE
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 12:23:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 953D9218DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iG08V-0005k3-NC
	for qemu-devel@archiver.kernel.org; Thu, 03 Oct 2019 08:23:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43829)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iG07X-0005AN-0h
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 08:22:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iG07V-0002wz-EW
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 08:22:10 -0400
Received: from 8.mo177.mail-out.ovh.net ([46.105.61.98]:39039)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iG07V-0002ve-6i
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 08:22:09 -0400
Received: from player776.ha.ovh.net (unknown [10.108.35.159])
 by mo177.mail-out.ovh.net (Postfix) with ESMTP id 6EC1E10CE4C
 for <qemu-devel@nongnu.org>; Thu,  3 Oct 2019 14:22:06 +0200 (CEST)
Received: from kaod.org (lfbn-1-2229-223.w90-76.abo.wanadoo.fr [90.76.50.223])
 (Authenticated sender: clg@kaod.org)
 by player776.ha.ovh.net (Postfix) with ESMTPSA id 9F0C2A820B90;
 Thu,  3 Oct 2019 12:22:00 +0000 (UTC)
Subject: Re: [PATCH 2/7] spapr, xive: Turn "nr-ends" property into
 "nr-servers" property
To: Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>
References: <157010404888.246126.9768030542733152637.stgit@bahia.lan>
 <157010406203.246126.13381271918474281392.stgit@bahia.lan>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <c6d66c57-fd1d-4f69-98b3-8325bcf4db24@kaod.org>
Date: Thu, 3 Oct 2019 14:21:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <157010406203.246126.13381271918474281392.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 16712013793413663552
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrgeekgdehfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.61.98
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 03/10/2019 14:01, Greg Kurz wrote:
> The sPAPR XIVE object has an nr_ends field which happens to be a
> multiple of spapr_max_server_number(). It is currently set with
> the help of "nr-ends" property. This is a bit unfortunate since
> it exposes to the sPAPR irq frontend what should remain an
> implemantation detail within the XIVE backend.

implementation

> It will be possible soon to inform the XIVE KVM device about the
> range of VCPU ids that may be used in the VM, as returned by the
> spapr_max_server_number() function. This will allow the device
> to substantially reduce the consumption of scarce resources
> in the XIVE HW.
> 
> For both reasons, replace the "nr-ends" property with an "nr-servers"
> one. The existing nr_ends field must be kept though since it tells how
> many ENDs are migrated, it is derived from "nr-servers" at realize time
> for simplicity. Convert spapr_dt_xive() to use it as well.

Looks good. one question below.

> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  hw/intc/spapr_xive.c        |   21 ++++++++++++++++-----
>  hw/ppc/spapr_irq.c          |    2 +-
>  include/hw/ppc/spapr_xive.h |    1 +
>  3 files changed, 18 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
> index 04879abf2e7a..62888ddc68db 100644
> --- a/hw/intc/spapr_xive.c
> +++ b/hw/intc/spapr_xive.c
> @@ -99,6 +99,15 @@ int spapr_xive_end_to_target(uint8_t end_blk, uint32_t end_idx,
>      return 0;
>  }
>  
> +static uint32_t spapr_xive_vcpu_id_to_end_idx(uint32_t vcpu_id)


may be use a simpler macro :

#define spapr_xive_cpu_end_idx(vcpu, prio) (((vcpu) << 3) + prio) 

> +{
> +    /*
> +     * 8 XIVE END structures per CPU. One for each available
> +     * priority
> +     */
> +    return vcpu_id << 3;
> +}
> +
>  static void spapr_xive_cpu_to_end(PowerPCCPU *cpu, uint8_t prio,
>                                    uint8_t *out_end_blk, uint32_t *out_end_idx)
>  {
> @@ -109,7 +118,7 @@ static void spapr_xive_cpu_to_end(PowerPCCPU *cpu, uint8_t prio,
>      }
>  
>      if (out_end_idx) {
> -        *out_end_idx = (cpu->vcpu_id << 3) + prio;
> +        *out_end_idx = spapr_xive_vcpu_id_to_end_idx(cpu->vcpu_id) + prio;
>      }
>  }
>  
> @@ -283,11 +292,13 @@ static void spapr_xive_realize(DeviceState *dev, Error **errp)
>          return;
>      }
>  
> -    if (!xive->nr_ends) {
> -        error_setg(errp, "Number of interrupt needs to be greater 0");
> +    if (!xive->nr_servers) {
> +        error_setg(errp, "Number of interrupt servers must be greater than 0");
>          return;
>      }
>  
> +    xive->nr_ends = spapr_xive_vcpu_id_to_end_idx(xive->nr_servers);
> +
>      /*
>       * Initialize the internal sources, for IPIs and virtual devices.
>       */
> @@ -489,7 +500,7 @@ static const VMStateDescription vmstate_spapr_xive = {
>  
>  static Property spapr_xive_properties[] = {
>      DEFINE_PROP_UINT32("nr-irqs", SpaprXive, nr_irqs, 0),
> -    DEFINE_PROP_UINT32("nr-ends", SpaprXive, nr_ends, 0),
> +    DEFINE_PROP_UINT32("nr-servers", SpaprXive, nr_servers, 0),
>      DEFINE_PROP_UINT64("vc-base", SpaprXive, vc_base, SPAPR_XIVE_VC_BASE),
>      DEFINE_PROP_UINT64("tm-base", SpaprXive, tm_base, SPAPR_XIVE_TM_BASE),
>      DEFINE_PROP_END_OF_LIST(),
> @@ -1550,7 +1561,7 @@ void spapr_dt_xive(SpaprMachineState *spapr, uint32_t nr_servers, void *fdt,

we should remove the 'uint32_t nr_servers' parameter from spapr_dt_xive() 
then ?

>      /* Interrupt number ranges for the IPIs */
>      uint32_t lisn_ranges[] = {
>          cpu_to_be32(0),
> -        cpu_to_be32(nr_servers),
> +        cpu_to_be32(xive->nr_servers),
>      };
>      /*
>       * EQ size - the sizes of pages supported by the system 4K, 64K,
> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> index 457eabe24cda..025fd00143a2 100644
> --- a/hw/ppc/spapr_irq.c
> +++ b/hw/ppc/spapr_irq.c
> @@ -591,7 +591,7 @@ void spapr_irq_init(SpaprMachineState *spapr, Error **errp)
>           * 8 XIVE END structures per CPU. One for each available
>           * priority
>           */
> -        qdev_prop_set_uint32(dev, "nr-ends", nr_servers << 3);
> +        qdev_prop_set_uint32(dev, "nr-servers", nr_servers);
>          qdev_init_nofail(dev);
>  
>          spapr->xive = SPAPR_XIVE(dev);
> diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
> index 0df20a6590a5..4a4a6fc6be7f 100644
> --- a/include/hw/ppc/spapr_xive.h
> +++ b/include/hw/ppc/spapr_xive.h
> @@ -22,6 +22,7 @@ typedef struct SpaprXive {
>      /* Internal interrupt source for IPIs and virtual devices */
>      XiveSource    source;
>      hwaddr        vc_base;
> +    uint32_t      nr_servers;
>  
>      /* END ESB MMIOs */
>      XiveENDSource end_source;
> 


