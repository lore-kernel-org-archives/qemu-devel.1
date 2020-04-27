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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2773AC81857
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 22:26:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBF4C2078C
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 22:26:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GQoGpVWe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBF4C2078C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTCCW-0004Mr-Vq
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 18:26:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40416)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1jTCBW-0003UT-1I
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 18:25:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1jTCBU-0001Zn-QJ
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 18:25:05 -0400
Received: from mail-il1-x143.google.com ([2607:f8b0:4864:20::143]:39388)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jTCBU-0001Ze-Du; Mon, 27 Apr 2020 18:25:04 -0400
Received: by mail-il1-x143.google.com with SMTP id r2so18368361ilo.6;
 Mon, 27 Apr 2020 15:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=4d6orcMdn3i38NRXjqfckA7ZIJIuprEpeNRLSnhBce8=;
 b=GQoGpVWewjY9XNx8Gnb9BsAKWvo36OVkwpkt4i5O+PQhCr4S4QWD7op0YjlbnNjclZ
 HmwK/ghEdKEwrE1OeE8XCWOoXwu4tbrT7mj09Vtfg7uMYqV1psl4OXcbSkyBkvRicuLT
 rsVV11fXlPxPjuxnYSbLhjFM35FDzUOXOKZPwRAqY3fDeUUClPJljWRoy05NQr3tZEGO
 6I1Li1gcKZI1ojp3MIuiG/gxlU9butuQkpH5WtW6N3VZpQCgfsfh7OiEkwzps63VtUl3
 cMqz4yr1Gr3KLiCTrjMYPrkLvO79a6IU9+pvk7F5nKUgVUvNLHFJKca7WWsh9dWuFk9t
 FgZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4d6orcMdn3i38NRXjqfckA7ZIJIuprEpeNRLSnhBce8=;
 b=FaNN5QcbwgfOiTV0Pu3SKrOK84Vtv45S+GIGLQK/Yjss3QOXTHkjgj3qlkY4qAOTpx
 9whkCtk3SqmssDdw0Ww4E2JmPXYY9/Qu7EAlySu7fDoooapW6QcauH8qr6021NgiYBO2
 EI5iZwYbgZJWTttSASzlkIY+PBd2xp6P0IgTxu3S5SK2RuzGRKmZbWG2rWBfGHFerM4/
 0z5gH14bFCoufe3L+Q9P9TB+6W+8IZ7NNr2GDMfRrqUHH5T5/xGG3F2yxqKF2QC52UIj
 1X6dl4fuClpdtENO4dVnNp5+dh4CghzPrn128Ojx3CTJxMCi83gTrpk2wVtTS0VhQ67E
 HduA==
X-Gm-Message-State: AGi0PuY2cGUUp1W8PMhQp0fAZpnFELTvVwhcq+IvCJK8It9TPkwgCC5l
 bUtjFsGTUuG8fDRxK1P91ucceDB50bFe02NldIU=
X-Google-Smtp-Source: APiQypKYvod25dDv15F0NKkf3yHInNX2aCEDZyYa8FnlxM1X3niDg7dIfSy/PlQGU9EqCK9r0cQuYwnsa9qMzzjD4yk=
X-Received: by 2002:a92:9a5c:: with SMTP id t89mr24196092ili.267.1588026302807; 
 Mon, 27 Apr 2020 15:25:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200427181649.26851-1-edgar.iglesias@gmail.com>
 <20200427181649.26851-5-edgar.iglesias@gmail.com>
In-Reply-To: <20200427181649.26851-5-edgar.iglesias@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 27 Apr 2020 15:16:24 -0700
Message-ID: <CAKmqyKNd55rbOCtWYk8LUJ31WhpDsp9AN+qtYqmEyh6QTKG4EA@mail.gmail.com>
Subject: Re: [PATCH v1 04/11] hw/arm: versal: Embedd the UARTs into the SoC
 type
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::143;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x143.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::143
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

On Mon, Apr 27, 2020 at 11:17 AM Edgar E. Iglesias
<edgar.iglesias@gmail.com> wrote:
>
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
>
> Embedd the UARTs into the SoC type.
>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/arm/xlnx-versal.c         | 12 ++++++------
>  include/hw/arm/xlnx-versal.h |  3 ++-
>  2 files changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
> index cc696e44c0..dbde03b7e6 100644
> --- a/hw/arm/xlnx-versal.c
> +++ b/hw/arm/xlnx-versal.c
> @@ -21,7 +21,6 @@
>  #include "kvm_arm.h"
>  #include "hw/misc/unimp.h"
>  #include "hw/arm/xlnx-versal.h"
> -#include "hw/char/pl011.h"
>
>  #define XLNX_VERSAL_ACPU_TYPE ARM_CPU_TYPE_NAME("cortex-a72")
>  #define GEM_REVISION        0x40070106
> @@ -144,16 +143,17 @@ static void versal_create_uarts(Versal *s, qemu_irq *pic)
>          DeviceState *dev;
>          MemoryRegion *mr;
>
> -        dev = qdev_create(NULL, TYPE_PL011);
> -        s->lpd.iou.uart[i] = SYS_BUS_DEVICE(dev);
> +        sysbus_init_child_obj(OBJECT(s), name,
> +                              &s->lpd.iou.uart[i], sizeof(s->lpd.iou.uart[i]),
> +                              TYPE_PL011);
> +        dev = DEVICE(&s->lpd.iou.uart[i]);
>          qdev_prop_set_chr(dev, "chardev", serial_hd(i));
> -        object_property_add_child(OBJECT(s), name, OBJECT(dev), &error_fatal);
>          qdev_init_nofail(dev);
>
> -        mr = sysbus_mmio_get_region(s->lpd.iou.uart[i], 0);
> +        mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
>          memory_region_add_subregion(&s->mr_ps, addrs[i], mr);
>
> -        sysbus_connect_irq(s->lpd.iou.uart[i], 0, pic[irqs[i]]);
> +        sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, pic[irqs[i]]);
>          g_free(name);
>      }
>  }
> diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
> index 6c0a692b2f..a3dfd064b3 100644
> --- a/include/hw/arm/xlnx-versal.h
> +++ b/include/hw/arm/xlnx-versal.h
> @@ -15,6 +15,7 @@
>  #include "hw/sysbus.h"
>  #include "hw/arm/boot.h"
>  #include "hw/intc/arm_gicv3.h"
> +#include "hw/char/pl011.h"
>
>  #define TYPE_XLNX_VERSAL "xlnx-versal"
>  #define XLNX_VERSAL(obj) OBJECT_CHECK(Versal, (obj), TYPE_XLNX_VERSAL)
> @@ -49,7 +50,7 @@ typedef struct Versal {
>          MemoryRegion mr_ocm;
>
>          struct {
> -            SysBusDevice *uart[XLNX_VERSAL_NR_UARTS];
> +            PL011State uart[XLNX_VERSAL_NR_UARTS];
>              SysBusDevice *gem[XLNX_VERSAL_NR_GEMS];
>              SysBusDevice *adma[XLNX_VERSAL_NR_ADMAS];
>          } iou;
> --
> 2.20.1
>
>

