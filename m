Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F033EC83003
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 07:46:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B917F2076B
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 07:46:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="hGNVY5Wf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B917F2076B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jThQ7-0004fC-Pk
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 03:46:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46976)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <luc.michel@greensocs.com>) id 1jTh8S-0003RF-Ua
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 03:28:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <luc.michel@greensocs.com>) id 1jTh8S-00019I-0z
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 03:28:00 -0400
Received: from beetle.greensocs.com ([5.135.226.135]:57522)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc.michel@greensocs.com>)
 id 1jTh8Q-00018p-4s; Wed, 29 Apr 2020 03:27:58 -0400
Received: from [172.17.10.6] (unknown [172.17.10.6])
 by beetle.greensocs.com (Postfix) with ESMTPSA id 00D7796EF0;
 Wed, 29 Apr 2020 07:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1588145276;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tcaL1irC3UlzPATCOvhdRskAtxHglkpqk3lFPisDTEQ=;
 b=hGNVY5WfAWkPlPOqDDlwUptmhqu3CYxNuCEZF2asm80Qn+yciZLGNlM9olu+92poTEVx7c
 EPNW30kWCFe5z+p8FfBxMepXFkSh0vQ7f+0suT9zFM3S9l1GF+JfEFfkE2TV/rqzTICIvz
 G0acS9QQSmgAX0qWfMD07n+FJXQC4ns=
Subject: Re: [PATCH v1 05/11] hw/arm: versal: Embedd the GEMs into the SoC type
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org
References: <20200427181649.26851-1-edgar.iglesias@gmail.com>
 <20200427181649.26851-6-edgar.iglesias@gmail.com>
From: Luc Michel <luc.michel@greensocs.com>
Message-ID: <965721ca-a327-0a5d-b962-2729e245e1a2@greensocs.com>
Date: Wed, 29 Apr 2020 09:27:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200427181649.26851-6-edgar.iglesias@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1588145276;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tcaL1irC3UlzPATCOvhdRskAtxHglkpqk3lFPisDTEQ=;
 b=4Vcr4QbCzRLsvJATcLiiKTljjt6rasrcvG7PLBrIR+v8Hku+GB0LoEiM2cDyIEBqAO5kYB
 qnQaJiEdydQ7smWDvcfb2RmGWc3DHfinUi47UzEGMJ4+xnkqamQzinqrcgeUB8t0rqHyz8
 YXuVHBrFUlkv4FOFkLzDHElm1eIzx5c=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1588145276; a=rsa-sha256; cv=none;
 b=mAr2Ddlwn83BGA88cWP/QhzSlDSzWe0+3RFntJQXhNga7Nq+ORiwbmfWrxSVNd5dJy9WfY
 MAwmckcq1OKBSPFnT42i/8zJPQuDYxG7yuI1qAAzlvPizt++LxtDs+xMjpguLBIgdW/GOs
 ZswPFOTiqba1Yt33aIx+ZCN0JmzkLnw=
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=luc smtp.mailfrom=luc.michel@greensocs.com
Received-SPF: pass client-ip=5.135.226.135;
 envelope-from=luc.michel@greensocs.com; helo=beetle.greensocs.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 03:23:35
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Received-From: 5.135.226.135
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
Cc: figlesia@xilinx.com, peter.maydell@linaro.org, sstabellini@kernel.org,
 edgar.iglesias@xilinx.com, sai.pavan.boddu@xilinx.com,
 frasse.iglesias@gmail.com, alistair@alistair23.me,
 richard.henderson@linaro.org, frederic.konrad@adacore.com, qemu-arm@nongnu.org,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/27/20 8:16 PM, Edgar E. Iglesias wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
> 
> Embedd the GEMs into the SoC type.
> 
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

Reviewed-by: Luc Michel <luc.michel@greensocs.com>

> ---
>  hw/arm/xlnx-versal.c         | 15 ++++++++-------
>  include/hw/arm/xlnx-versal.h |  3 ++-
>  2 files changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
> index dbde03b7e6..e424aa789e 100644
> --- a/hw/arm/xlnx-versal.c
> +++ b/hw/arm/xlnx-versal.c
> @@ -170,25 +170,26 @@ static void versal_create_gems(Versal *s, qemu_irq *pic)
>          DeviceState *dev;
>          MemoryRegion *mr;
>  
> -        dev = qdev_create(NULL, "cadence_gem");
> -        s->lpd.iou.gem[i] = SYS_BUS_DEVICE(dev);
> -        object_property_add_child(OBJECT(s), name, OBJECT(dev), &error_fatal);
> +        sysbus_init_child_obj(OBJECT(s), name,
> +                              &s->lpd.iou.gem[i], sizeof(s->lpd.iou.gem[i]),
> +                              TYPE_CADENCE_GEM);
> +        dev = DEVICE(&s->lpd.iou.gem[i]);
>          if (nd->used) {
>              qemu_check_nic_model(nd, "cadence_gem");
>              qdev_set_nic_properties(dev, nd);
>          }
> -        object_property_set_int(OBJECT(s->lpd.iou.gem[i]),
> +        object_property_set_int(OBJECT(dev),
>                                  2, "num-priority-queues",
>                                  &error_abort);
> -        object_property_set_link(OBJECT(s->lpd.iou.gem[i]),
> +        object_property_set_link(OBJECT(dev),
>                                   OBJECT(&s->mr_ps), "dma",
>                                   &error_abort);
>          qdev_init_nofail(dev);
>  
> -        mr = sysbus_mmio_get_region(s->lpd.iou.gem[i], 0);
> +        mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
>          memory_region_add_subregion(&s->mr_ps, addrs[i], mr);
>  
> -        sysbus_connect_irq(s->lpd.iou.gem[i], 0, pic[irqs[i]]);
> +        sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, pic[irqs[i]]);
>          g_free(name);
>      }
>  }
> diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
> index a3dfd064b3..01da736a5b 100644
> --- a/include/hw/arm/xlnx-versal.h
> +++ b/include/hw/arm/xlnx-versal.h
> @@ -16,6 +16,7 @@
>  #include "hw/arm/boot.h"
>  #include "hw/intc/arm_gicv3.h"
>  #include "hw/char/pl011.h"
> +#include "hw/net/cadence_gem.h"
>  
>  #define TYPE_XLNX_VERSAL "xlnx-versal"
>  #define XLNX_VERSAL(obj) OBJECT_CHECK(Versal, (obj), TYPE_XLNX_VERSAL)
> @@ -51,7 +52,7 @@ typedef struct Versal {
>  
>          struct {
>              PL011State uart[XLNX_VERSAL_NR_UARTS];
> -            SysBusDevice *gem[XLNX_VERSAL_NR_GEMS];
> +            CadenceGEMState gem[XLNX_VERSAL_NR_GEMS];
>              SysBusDevice *adma[XLNX_VERSAL_NR_ADMAS];
>          } iou;
>      } lpd;
> 

