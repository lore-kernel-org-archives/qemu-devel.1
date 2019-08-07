Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5853C32751
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 08:00:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90AD822C7C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 08:00:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90AD822C7C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvGrZ-00054C-TQ
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 04:00:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39164)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <clg@kaod.org>) id 1hvGrC-0004dc-M5
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 03:59:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1hvGrB-0005jb-Fb
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 03:59:38 -0400
Received: from 13.mo7.mail-out.ovh.net ([87.98.150.175]:44189)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1hvGrB-0005j0-A5
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 03:59:37 -0400
Received: from player687.ha.ovh.net (unknown [10.108.42.119])
 by mo7.mail-out.ovh.net (Postfix) with ESMTP id 265BD12D38C
 for <qemu-devel@nongnu.org>; Wed,  7 Aug 2019 09:59:35 +0200 (CEST)
Received: from kaod.org (bad36-1-78-202-132-1.fbx.proxad.net [78.202.132.1])
 (Authenticated sender: clg@kaod.org)
 by player687.ha.ovh.net (Postfix) with ESMTPSA id 272F78A329A8;
 Wed,  7 Aug 2019 07:59:28 +0000 (UTC)
To: Balamuruhan S <bala24@linux.ibm.com>, qemu-devel@nongnu.org
References: <20190807071445.4109-1-bala24@linux.ibm.com>
 <20190807071445.4109-5-bala24@linux.ibm.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <555de06b-a959-76ce-ee89-05c4b7cab25a@kaod.org>
Date: Wed, 7 Aug 2019 09:59:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190807071445.4109-5-bala24@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 9576341660949908454
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrudduuddguddviecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 87.98.150.175
Subject: Re: [Qemu-devel] [RFC PATCH 4/6] hw/ppc/pnv: initialize and realize
 homer/occ common area
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
Cc: pbonzini@redhat.com, maddy@linux.vnet.ibm.com, anju@linux.vnet.ibm.com,
 david@gibson.dropbear.id.au, hari@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/08/2019 09:14, Balamuruhan S wrote:
> homer and occ common area region base address are initialized
> to create device tree and realized to map the address with
> mmio callbacks during `pnv_chip_realize()`.
> 
> `SysBusNum` enum is introduced to set sysbus for XSCOM, ICP,
> HOMER and OCC appropriately and chip_num to initialize and
> retrieve base address + size contiguously on a PowerNV with
> multichip boot.

Can't you use the chip_id ? 

> 
> Signed-off-by: Balamuruhan S <bala24@linux.ibm.com>
> ---
>  hw/ppc/pnv.c         | 49 +++++++++++++++++++++++++++++++++++++++++++++----
>  include/hw/ppc/pnv.h |  1 +
>  2 files changed, 46 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index bd4531c822..f6e56e915d 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -675,6 +675,7 @@ static void pnv_init(MachineState *machine)
>          Object *chip = object_new(chip_typename);
>  
>          pnv->chips[i] = PNV_CHIP(chip);
> +        PNV_CHIP(chip)->chip_num = i;
>
>          /* TODO: put all the memory in one node on chip 0 until we find a
>           * way to specify different ranges for each chip
> @@ -824,18 +825,20 @@ static void pnv_chip_icp_realize(Pnv8Chip *chip8, Error **errp)
>   {
>      PnvChip *chip = PNV_CHIP(chip8);
>      PnvChipClass *pcc = PNV_CHIP_GET_CLASS(chip);
> +    SysBusDevice *sbd = SYS_BUS_DEVICE(chip);
>      const char *typename = pnv_chip_core_typename(chip);
>      size_t typesize = object_type_get_instance_size(typename);
>      int i, j;
>      char *name;
>      XICSFabric *xi = XICS_FABRIC(qdev_get_machine());
>  
> +    sbd->num_mmio = PNV_ICP_SYSBUS;

OK. I think I know why you want this but it probably means that you need 
a new PnvHomer model and that you should use PnvOCC instead. 

>      name = g_strdup_printf("icp-%x", chip->chip_id);
>      memory_region_init(&chip8->icp_mmio, OBJECT(chip), name, PNV_ICP_SIZE);
> -    sysbus_init_mmio(SYS_BUS_DEVICE(chip), &chip8->icp_mmio);
> +    sysbus_init_mmio(sbd, &chip8->icp_mmio);
>      g_free(name);
>  
> -    sysbus_mmio_map(SYS_BUS_DEVICE(chip), 1, PNV_ICP_BASE(chip));
> +    sysbus_mmio_map(sbd, PNV_ICP_SYSBUS, PNV_ICP_BASE(chip));
>  
>      /* Map the ICP registers for each thread */
>      for (i = 0; i < chip->nr_cores; i++) {
> @@ -866,7 +869,26 @@ static void pnv_chip_power8_realize(DeviceState *dev, Error **errp)
>          error_propagate(errp, local_err);
>          return;
>      }
> -    sysbus_mmio_map(SYS_BUS_DEVICE(chip), 0, PNV_XSCOM_BASE(chip));
> +    sysbus_mmio_map(SYS_BUS_DEVICE(chip), PNV_XSCOM_SYSBUS,
> +                                   PNV_XSCOM_BASE(chip));
> +
> +    /* homer */
> +    pnv_homer_realize(chip, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return;
> +    }
> +    sysbus_mmio_map(SYS_BUS_DEVICE(chip), PNV_HOMER_SYSBUS,
> +                    PNV_HOMER_BASE(chip));
> +    /* occ common area */
> +    pnv_occ_common_area_realize(chip, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return;
> +    }
> +    sysbus_mmio_map(SYS_BUS_DEVICE(chip), PNV_OCC_COMMON_AREA_SYSBUS,
> +                    PNV_OCC_COMMON_AREA(chip));
>  
>      pcc->parent_realize(dev, &local_err);
>      if (local_err) {
> @@ -1035,7 +1057,26 @@ static void pnv_chip_power9_realize(DeviceState *dev, Error **errp)
>          error_propagate(errp, local_err);
>          return;
>      }
> -    sysbus_mmio_map(SYS_BUS_DEVICE(chip), 0, PNV9_XSCOM_BASE(chip));
> +    sysbus_mmio_map(SYS_BUS_DEVICE(chip), PNV_XSCOM_SYSBUS,
> +                    PNV9_XSCOM_BASE(chip));
> +
> +    /* homer */
> +    pnv_homer_realize(chip, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return;
> +    }
> +    sysbus_mmio_map(SYS_BUS_DEVICE(chip), PNV_HOMER_SYSBUS,
> +                    PNV9_HOMER_BASE(chip));
> +
> +    /* occ common area */
> +    pnv_occ_common_area_realize(chip, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return;
> +    }
> +    sysbus_mmio_map(SYS_BUS_DEVICE(chip), PNV_OCC_COMMON_AREA_SYSBUS,
> +                    PNV9_OCC_COMMON_AREA(chip));
>  
>      pcc->parent_realize(dev, &local_err);
>      if (local_err) {
> diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
> index 6464e32892..dea6772988 100644
> --- a/include/hw/ppc/pnv.h
> +++ b/include/hw/ppc/pnv.h
> @@ -57,6 +57,7 @@ typedef struct PnvChip {
>  
>      /*< public >*/
>      uint32_t     chip_id;
> +    uint32_t     chip_num;
>      uint64_t     ram_start;
>      uint64_t     ram_size;
>  
> 


