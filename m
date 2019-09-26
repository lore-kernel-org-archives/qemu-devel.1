Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C39FC432C2
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 07:50:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E597621A4A
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 07:50:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E597621A4A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDOXN-0005Rg-Ve
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 03:50:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35240)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iDOWH-0004i2-SJ
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 03:48:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iDOWG-0004bU-Gt
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 03:48:57 -0400
Received: from 10.mo4.mail-out.ovh.net ([188.165.33.109]:52737)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iDOWG-0004af-Au
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 03:48:56 -0400
Received: from player692.ha.ovh.net (unknown [10.108.57.211])
 by mo4.mail-out.ovh.net (Postfix) with ESMTP id 9E06C208BA9
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2019 09:48:51 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player692.ha.ovh.net (Postfix) with ESMTPSA id 018D5A1F00EA;
 Thu, 26 Sep 2019 07:48:40 +0000 (UTC)
Date: Thu, 26 Sep 2019 09:48:39 +0200
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 13/20] spapr: Eliminate SpaprIrq:get_nodename method
Message-ID: <20190926094839.33913bdf@bahia.lan>
In-Reply-To: <20190925064534.19155-14-david@gibson.dropbear.id.au>
References: <20190925064534.19155-1-david@gibson.dropbear.id.au>
 <20190925064534.19155-14-david@gibson.dropbear.id.au>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 7882143774637660646
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrfeefgdduvdegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 188.165.33.109
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
Cc: Jason Wang <jasowang@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>, qemu-ppc@nongnu.org,
 clg@kaod.org,
 =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 25 Sep 2019 16:45:27 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> This method is used to determine the name of the irq backend's node in the
> device tree, so that we can find its phandle (after SLOF may have modified
> it from the phandle we initially gave it).
> 
> But, in the two cases the only difference between the node name is the
> presence of a unit address.  Searching for a node name without considering
> unit address is standard practice for the device tree, and
> fdt_subnode_offset() will do exactly that.
> 
> So, the method is unnecessary.
> 

So is the XICS_NODENAME macro which was introduced by the same
commit 743ed566c1d80, and it seems that "interrupt-controller"
is a well-known string that is used everywhere:

[greg@bahia qemu-spapr]$ git grep -E \"interrupt-controller\"
hw/arm/virt.c:    qemu_fdt_setprop(vms->fdt, nodename, "interrupt-controller", NULL, 0);
hw/arm/xlnx-versal-virt.c:    qemu_fdt_setprop(s->fdt, nodename, "interrupt-controller", NULL, 0);
hw/intc/sh_intc.c:                          "interrupt-controller", 0x100000000ULL);
hw/intc/spapr_xive.c:    _FDT(fdt_setprop(fdt, node, "interrupt-controller", NULL, 0));
hw/intc/xics_spapr.c:    _FDT(fdt_setprop(fdt, node, "interrupt-controller", NULL, 0));
hw/pci/pci.c:    { 0x0800, "Interrupt controller", "interrupt-controller"},
hw/ppc/e500.c:    qemu_fdt_setprop(fdt, mpic, "interrupt-controller", NULL, 0);
hw/ppc/pnv.c:    _FDT((fdt_setprop(fdt, offset, "interrupt-controller", NULL, 0)));
hw/ppc/spapr_events.c:    _FDT((fdt_setprop(fdt, event_sources, "interrupt-controller", NULL, 0)));
hw/ppc/spapr_irq.c:    const char *nodename = "interrupt-controller";
hw/ppc/spapr_pci.c:    { PCI_CLASS_SYSTEM_PIC, "interrupt-controller", pic_iface },
hw/ppc/spapr_vio.c:    _FDT(fdt_setprop(fdt, node, "interrupt-controller", NULL, 0));
hw/riscv/sifive_u.c:        qemu_fdt_setprop(fdt, intc, "interrupt-controller", NULL, 0);
hw/riscv/sifive_u.c:    qemu_fdt_setprop(fdt, nodename, "interrupt-controller", NULL, 0);
hw/riscv/spike.c:        qemu_fdt_setprop(fdt, intc, "interrupt-controller", NULL, 0);
hw/riscv/virt.c:        qemu_fdt_setprop(fdt, intc, "interrupt-controller", NULL, 0);
hw/riscv/virt.c:    qemu_fdt_setprop(fdt, nodename, "interrupt-controller", NULL, 0);
include/hw/ppc/spapr.h: * "interrupt-controller" node has its "#interrupt-cells" property set to 2 (ie,
include/hw/ppc/xics_spapr.h:#define XICS_NODENAME "interrupt-controller"

Maybe drop XICS_NODENAME as well while here ?

With or without that,

Reviewed-by: Greg Kurz <groug@kaod.org>

> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  hw/ppc/spapr_irq.c         | 25 +++----------------------
>  include/hw/ppc/spapr_irq.h |  1 -
>  2 files changed, 3 insertions(+), 23 deletions(-)
> 
> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> index 038bfffff4..79167ccc68 100644
> --- a/hw/ppc/spapr_irq.c
> +++ b/hw/ppc/spapr_irq.c
> @@ -211,11 +211,6 @@ static void spapr_irq_reset_xics(SpaprMachineState *spapr, Error **errp)
>      }
>  }
>  
> -static const char *spapr_irq_get_nodename_xics(SpaprMachineState *spapr)
> -{
> -    return XICS_NODENAME;
> -}
> -
>  static void spapr_irq_init_kvm_xics(SpaprMachineState *spapr, Error **errp)
>  {
>      if (kvm_enabled()) {
> @@ -237,7 +232,6 @@ SpaprIrq spapr_irq_xics = {
>      .post_load   = spapr_irq_post_load_xics,
>      .reset       = spapr_irq_reset_xics,
>      .set_irq     = spapr_irq_set_irq_xics,
> -    .get_nodename = spapr_irq_get_nodename_xics,
>      .init_kvm    = spapr_irq_init_kvm_xics,
>  };
>  
> @@ -362,11 +356,6 @@ static void spapr_irq_set_irq_xive(void *opaque, int irq, int val)
>      }
>  }
>  
> -static const char *spapr_irq_get_nodename_xive(SpaprMachineState *spapr)
> -{
> -    return spapr->xive->nodename;
> -}
> -
>  static void spapr_irq_init_kvm_xive(SpaprMachineState *spapr, Error **errp)
>  {
>      if (kvm_enabled()) {
> @@ -393,7 +382,6 @@ SpaprIrq spapr_irq_xive = {
>      .post_load   = spapr_irq_post_load_xive,
>      .reset       = spapr_irq_reset_xive,
>      .set_irq     = spapr_irq_set_irq_xive,
> -    .get_nodename = spapr_irq_get_nodename_xive,
>      .init_kvm    = spapr_irq_init_kvm_xive,
>  };
>  
> @@ -538,11 +526,6 @@ static void spapr_irq_set_irq_dual(void *opaque, int irq, int val)
>      spapr_irq_current(spapr)->set_irq(spapr, irq, val);
>  }
>  
> -static const char *spapr_irq_get_nodename_dual(SpaprMachineState *spapr)
> -{
> -    return spapr_irq_current(spapr)->get_nodename(spapr);
> -}
> -
>  /*
>   * Define values in sync with the XIVE and XICS backend
>   */
> @@ -560,7 +543,6 @@ SpaprIrq spapr_irq_dual = {
>      .post_load   = spapr_irq_post_load_dual,
>      .reset       = spapr_irq_reset_dual,
>      .set_irq     = spapr_irq_set_irq_dual,
> -    .get_nodename = spapr_irq_get_nodename_dual,
>      .init_kvm    = NULL, /* should not be used */
>  };
>  
> @@ -697,13 +679,13 @@ void spapr_irq_reset(SpaprMachineState *spapr, Error **errp)
>  
>  int spapr_irq_get_phandle(SpaprMachineState *spapr, void *fdt, Error **errp)
>  {
> -    const char *nodename = spapr->irq->get_nodename(spapr);
> +    const char *nodename = "interrupt-controller";
>      int offset, phandle;
>  
>      offset = fdt_subnode_offset(fdt, 0, nodename);
>      if (offset < 0) {
> -        error_setg(errp, "Can't find node \"%s\": %s", nodename,
> -                   fdt_strerror(offset));
> +        error_setg(errp, "Can't find node \"%s\": %s",
> +                   nodename, fdt_strerror(offset));
>          return -1;
>      }
>  
> @@ -787,6 +769,5 @@ SpaprIrq spapr_irq_xics_legacy = {
>      .post_load   = spapr_irq_post_load_xics,
>      .reset       = spapr_irq_reset_xics,
>      .set_irq     = spapr_irq_set_irq_xics,
> -    .get_nodename = spapr_irq_get_nodename_xics,
>      .init_kvm    = spapr_irq_init_kvm_xics,
>  };
> diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
> index a4e790ef60..9b60378e28 100644
> --- a/include/hw/ppc/spapr_irq.h
> +++ b/include/hw/ppc/spapr_irq.h
> @@ -52,7 +52,6 @@ typedef struct SpaprIrq {
>      int (*post_load)(SpaprMachineState *spapr, int version_id);
>      void (*reset)(SpaprMachineState *spapr, Error **errp);
>      void (*set_irq)(void *opaque, int srcno, int val);
> -    const char *(*get_nodename)(SpaprMachineState *spapr);
>      void (*init_kvm)(SpaprMachineState *spapr, Error **errp);
>  } SpaprIrq;
>  


