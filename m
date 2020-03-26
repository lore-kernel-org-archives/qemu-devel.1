Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F853C43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 11:58:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2250F20409
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 11:58:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2250F20409
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHR9X-0000ai-9S
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 07:58:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38855)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1jHR8v-00008z-CE
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 07:57:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1jHR8t-0007GZ-Tr
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 07:57:49 -0400
Received: from 13.mo3.mail-out.ovh.net ([188.165.33.202]:52791)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1jHR8t-0007Cx-Mw
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 07:57:47 -0400
Received: from player762.ha.ovh.net (unknown [10.108.42.142])
 by mo3.mail-out.ovh.net (Postfix) with ESMTP id 984F02425FE
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 12:57:45 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player762.ha.ovh.net (Postfix) with ESMTPSA id 804DC10CF4402;
 Thu, 26 Mar 2020 11:57:40 +0000 (UTC)
Date: Thu, 26 Mar 2020 12:57:38 +0100
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [RFC for-5.1 1/4] spapr: Refactor locating NVLink2 devices for
 device tree creation
Message-ID: <20200326125738.4df23c2b@bahia.lan>
In-Reply-To: <20200326054009.454477-2-david@gibson.dropbear.id.au>
References: <20200326054009.454477-1-david@gibson.dropbear.id.au>
 <20200326054009.454477-2-david@gibson.dropbear.id.au>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 11004827166136768998
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrudehiedgfeegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejiedvrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 188.165.33.202
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
Cc: aik@ozlabs.ru, qemu-ppc@nongnu.org, clg@kaod.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 26 Mar 2020 16:40:06 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> Currently spapr_phb_nvgpu_populate_pcidev_dt() works a little cryptically.
> It steps through all the NVLink2 GPUs and NPUs and if they match the device
> we're called for, we generate the relevant device tree information.
> 
> Make this a little more obvious by introducing helpers to determine it a

... to determine if a

> given PCI device is an NVLink2 GPU or NPU, returning the NVLink2 slot and
> link number information as well.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---

LGTM

Reviewed-by: Greg Kurz <groug@kaod.org>

>  hw/ppc/spapr_pci_nvlink2.c | 115 +++++++++++++++++++++++++------------
>  1 file changed, 79 insertions(+), 36 deletions(-)
> 
> diff --git a/hw/ppc/spapr_pci_nvlink2.c b/hw/ppc/spapr_pci_nvlink2.c
> index 8332d5694e..7d3a685421 100644
> --- a/hw/ppc/spapr_pci_nvlink2.c
> +++ b/hw/ppc/spapr_pci_nvlink2.c
> @@ -390,13 +390,12 @@ void spapr_phb_nvgpu_ram_populate_dt(SpaprPhbState *sphb, void *fdt)
>  
>  }
>  
> -void spapr_phb_nvgpu_populate_pcidev_dt(PCIDevice *dev, void *fdt, int offset,
> -                                        SpaprPhbState *sphb)
> +static bool is_nvgpu(PCIDevice *dev, SpaprPhbState *sphb, int *slot)
>  {
> -    int i, j;
> +    int i;
>  
>      if (!sphb->nvgpus) {
> -        return;
> +        return false;
>      }
>  
>      for (i = 0; i < sphb->nvgpus->num; ++i) {
> @@ -406,47 +405,91 @@ void spapr_phb_nvgpu_populate_pcidev_dt(PCIDevice *dev, void *fdt, int offset,
>          if (!nvslot->gpdev) {
>              continue;
>          }
> +
>          if (dev == nvslot->gpdev) {
> -            uint32_t npus[nvslot->linknum];
> +            if (slot) {
> +                *slot = i;
> +            }
> +            return true;
> +        }
> +    }
>  
> -            for (j = 0; j < nvslot->linknum; ++j) {
> -                PCIDevice *npdev = nvslot->links[j].npdev;
> +    return false;
> +}
>  
> -                npus[j] = cpu_to_be32(PHANDLE_PCIDEV(sphb, npdev));
> -            }
> -            _FDT(fdt_setprop(fdt, offset, "ibm,npu", npus,
> -                             j * sizeof(npus[0])));
> -            _FDT((fdt_setprop_cell(fdt, offset, "phandle",
> -                                   PHANDLE_PCIDEV(sphb, dev))));
> +static bool is_nvnpu(PCIDevice *dev, SpaprPhbState *sphb, int *slot, int *link)
> +{
> +    int i, j;
> +
> +    if (!sphb->nvgpus) {
> +        return false;
> +    }
> +
> +    for (i = 0; i < sphb->nvgpus->num; ++i) {
> +        SpaprPhbPciNvGpuSlot *nvslot = &sphb->nvgpus->slots[i];
> +
> +        /* Skip "slot" without attached GPU */
> +        if (!nvslot->gpdev) {
>              continue;
>          }
>  
>          for (j = 0; j < nvslot->linknum; ++j) {
> -            if (dev != nvslot->links[j].npdev) {
> -                continue;
> +            if (dev == nvslot->links[j].npdev) {
> +                if (slot) {
> +                    *slot = i;
> +                }
> +                if (link) {
> +                    *link = j;
> +                }
> +                return true;
>              }
> +        }
> +    }
>  
> -            _FDT((fdt_setprop_cell(fdt, offset, "phandle",
> -                                   PHANDLE_PCIDEV(sphb, dev))));
> -            _FDT(fdt_setprop_cell(fdt, offset, "ibm,gpu",
> -                                  PHANDLE_PCIDEV(sphb, nvslot->gpdev)));
> -            _FDT((fdt_setprop_cell(fdt, offset, "ibm,nvlink",
> -                                   PHANDLE_NVLINK(sphb, i, j))));
> -            /*
> -             * If we ever want to emulate GPU RAM at the same location as on
> -             * the host - here is the encoding GPA->TGT:
> -             *
> -             * gta  = ((sphb->nv2_gpa >> 42) & 0x1) << 42;
> -             * gta |= ((sphb->nv2_gpa >> 45) & 0x3) << 43;
> -             * gta |= ((sphb->nv2_gpa >> 49) & 0x3) << 45;
> -             * gta |= sphb->nv2_gpa & ((1UL << 43) - 1);
> -             */
> -            _FDT(fdt_setprop_cell(fdt, offset, "memory-region",
> -                                  PHANDLE_GPURAM(sphb, i)));
> -            _FDT(fdt_setprop_u64(fdt, offset, "ibm,device-tgt-addr",
> -                                 nvslot->tgt));
> -            _FDT(fdt_setprop_cell(fdt, offset, "ibm,nvlink-speed",
> -                                  nvslot->links[j].link_speed));
> +    return false;
> +}
> +
> +void spapr_phb_nvgpu_populate_pcidev_dt(PCIDevice *dev, void *fdt, int offset,
> +                                        SpaprPhbState *sphb)
> +{
> +    int slot, link;
> +
> +    if (is_nvgpu(dev, sphb, &slot)) {
> +        SpaprPhbPciNvGpuSlot *nvslot = &sphb->nvgpus->slots[slot];
> +        uint32_t npus[nvslot->linknum];
> +
> +        for (link = 0; link < nvslot->linknum; ++link) {
> +            PCIDevice *npdev = nvslot->links[link].npdev;
> +
> +            npus[link] = cpu_to_be32(PHANDLE_PCIDEV(sphb, npdev));
>          }
> +        _FDT(fdt_setprop(fdt, offset, "ibm,npu", npus,
> +                         link * sizeof(npus[0])));
> +        _FDT((fdt_setprop_cell(fdt, offset, "phandle",
> +                               PHANDLE_PCIDEV(sphb, dev))));
> +    } else if (is_nvnpu(dev, sphb, &slot, &link)) {
> +        SpaprPhbPciNvGpuSlot *nvslot = &sphb->nvgpus->slots[slot];
> +
> +        _FDT((fdt_setprop_cell(fdt, offset, "phandle",
> +                               PHANDLE_PCIDEV(sphb, dev))));
> +        _FDT(fdt_setprop_cell(fdt, offset, "ibm,gpu",
> +                              PHANDLE_PCIDEV(sphb, nvslot->gpdev)));
> +        _FDT((fdt_setprop_cell(fdt, offset, "ibm,nvlink",
> +                               PHANDLE_NVLINK(sphb, slot, link))));
> +        /*
> +         * If we ever want to emulate GPU RAM at the same location as
> +         * on the host - here is the encoding GPA->TGT:
> +         *
> +         * gta  = ((sphb->nv2_gpa >> 42) & 0x1) << 42;
> +         * gta |= ((sphb->nv2_gpa >> 45) & 0x3) << 43;
> +         * gta |= ((sphb->nv2_gpa >> 49) & 0x3) << 45;
> +         * gta |= sphb->nv2_gpa & ((1UL << 43) - 1);
> +         */
> +        _FDT(fdt_setprop_cell(fdt, offset, "memory-region",
> +                              PHANDLE_GPURAM(sphb, slot)));
> +        _FDT(fdt_setprop_u64(fdt, offset, "ibm,device-tgt-addr",
> +                             nvslot->tgt));
> +        _FDT(fdt_setprop_cell(fdt, offset, "ibm,nvlink-speed",
> +                              nvslot->links[link].link_speed));
>      }
>  }


