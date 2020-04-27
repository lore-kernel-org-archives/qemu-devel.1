Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2584AC81CFF
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 22:28:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB1C92078C
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 22:28:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mAo6ZVjf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB1C92078C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTCEO-0006jC-Vu
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 18:28:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40636)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1jTCCh-0004xS-PJ
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 18:26:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1jTCCh-0003zE-4I
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 18:26:19 -0400
Received: from mail-il1-x144.google.com ([2607:f8b0:4864:20::144]:40080)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jTCCg-0003yq-OJ; Mon, 27 Apr 2020 18:26:18 -0400
Received: by mail-il1-x144.google.com with SMTP id e8so18352134ilm.7;
 Mon, 27 Apr 2020 15:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=j0AjaoVOIfBuXfuEp71fPg/spu4qN9/80erdUgjOY9k=;
 b=mAo6ZVjfQjFNutv2KeIubrn949guSayu/LGN+VK5JKIZDkc9TouR14H++c6E6blWSC
 ECAWGQfePeBQJDOR2//CSN68y8NV1jo3S9qdw4JEgXBd0bhB3+O+hrFb4suXVaYdH2Qw
 BX9tqV+TnZ6vzh0iiBoc5dEbbcdUtWeNgm6MxdtfNbkMmQvra6dC6NCjL8OL1dFENatN
 14rzM8aROfTzgNbVZyRDtCt6ioKWr+gtsv16zw8ELYqBzXRVBP1DZjpiCxQSKb1xbl0S
 AQcAFyFzbEuc/sa71OD9aTNYfxvM9TrmtAtcVXvrVafXBNi2VjlxSFrmwhcOj9R1sc+f
 FYng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=j0AjaoVOIfBuXfuEp71fPg/spu4qN9/80erdUgjOY9k=;
 b=THtspx6DaHGkItMk6xLN/VhKQIynDAjTEtPUhhXdaOeiFLSPZQm7OyT1hsJXb3fl+Q
 /PYhn/bvxEhwzl8woz/+54FTrQKi/tyMjLum0IhWzaC6zZP2au3Of3YZpdGbTTLCWwlv
 0HgR0jnVahiOhkNWQnmKFt+8/CbOjMxCLIHOELQMki2uR5jiBlNngZ4mA6zvm8dBJ4xG
 a3kE/AEudhN57j3ngAEQdXyUHVYzo9Upia6NJjFX1wF7LjdOqfH9BXn8Y6GyzrwoCtaa
 S9cG7bHaLwVlrCcai1wSSs4muKHMOKXDdsZUp3ag36WwZySyEVrP3MAfhHhha0NFYdn5
 K6mg==
X-Gm-Message-State: AGi0PuZLm1MlyYBFRKzqDEoNn0WkeBjz7IwX/pR62NXx27ntvX8ym0Mt
 Izp/aEwgNrhhsT1c9PW+vWqPzCYkbmXA6VjHCUo=
X-Google-Smtp-Source: APiQypKtxPqdBw2VUXAcKfF9J5O68q8oG3NHqc2DO5YKfd28AwPcBOrU0B3LbHzlcPxomt/zw98kF92ufzbrE3GJeCo=
X-Received: by 2002:a92:aa07:: with SMTP id j7mr4267679ili.40.1588026377275;
 Mon, 27 Apr 2020 15:26:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200427181649.26851-1-edgar.iglesias@gmail.com>
 <20200427181649.26851-6-edgar.iglesias@gmail.com>
In-Reply-To: <20200427181649.26851-6-edgar.iglesias@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 27 Apr 2020 15:17:38 -0700
Message-ID: <CAKmqyKPD0oMEKtoQpjwoqQYTLCaZ-JE9pYLEOo0Lnc+2ervNzA@mail.gmail.com>
Subject: Re: [PATCH v1 05/11] hw/arm: versal: Embedd the GEMs into the SoC type
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::144;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x144.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::144
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
Cc: figlesia@xilinx.com, Peter Maydell <peter.maydell@linaro.org>,
 Edgar Iglesias <edgar.iglesias@xilinx.com>,
 Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>,
 Francisco Iglesias <frasse.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 Stefano Stabellini <sstabellini@kernel.org>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Apr 27, 2020 at 11:20 AM Edgar E. Iglesias
<edgar.iglesias@gmail.com> wrote:
>
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
>
> Embedd the GEMs into the SoC type.
>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

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
> --
> 2.20.1
>
>

