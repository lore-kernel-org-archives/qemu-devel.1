Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDE11C47247
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 16:42:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2D1420746
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 16:42:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rP6HSnYQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2D1420746
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jW0eV-0000xN-Q5
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 12:42:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60136)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jW0d1-0008Ci-Uh; Tue, 05 May 2020 12:41:13 -0400
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:42187)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jW0d0-0003nB-9T; Tue, 05 May 2020 12:41:07 -0400
Received: by mail-io1-xd43.google.com with SMTP id e9so2618641iok.9;
 Tue, 05 May 2020 09:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=a3BifNvPbVwluYeKRL84K9yT77rhPqmGn0+TObNAbXk=;
 b=rP6HSnYQRiq668N9eSUUC0P8s99ox2lQCbWMJO6cnq1v3uSab42nB0/y/PeCTtjfKS
 fDlUvd0KEafTah0GJNuvybq/4cCXkYxAXcakAND+0zfdEXQfRxENhbX35fCtpyU/yhNr
 gK9eFw9pAlFPLU+c5/u1nohMcur1co3pKv1rfCtBAjCVIw6e7UPq8qlL5w3aGUgARVam
 2I8guhlVW2lci4StNcqrz5oDtaT1lapMg5Cs7bZMW6gBO7/6SnJq6oXoE1UKTyqwqvAl
 93KrfeZNogGqlHxnmtG1X1G3pdpiBunfn6BgOciS6i0+WU9Q4UUXLNRd7UFT4HPh+WAH
 b25w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=a3BifNvPbVwluYeKRL84K9yT77rhPqmGn0+TObNAbXk=;
 b=ZbagN2YhtA9/l+IPliI5WhKIbCG0v2VdOSCIazmlQoy84RS+wPwjJPcCuzJpXb2B/K
 7vC2+RhZduvJrTnrj5LdegRkAZSMDg5sopSekxJg/LKs2TbHQnQQckg1U/Ndc4zwHnJl
 ro/Z8UbAuWD395O8NM0cu9xObuO0FVrNN4boSO6kgSMCShpMUjUo3o4WmgIjHB6o4MVI
 9kdAzrQSxffDyaMZlzRm0Z22yWlKJjAU30dPv+YDJPiPgtVwco16/t+Y9JMikvMaIE2N
 M+2vp9eZofnjsRs1vVm/40DboAiE5mSeIk9MzYP5sKVszjGcX6H88qj7y72OrhzSIbyO
 WRUg==
X-Gm-Message-State: AGi0PuaAfMcLNJ0GvRyz2E8e9e5uVEesWvR4sgi6RcgcG8NXFWGUgrQQ
 F4ohSGSMdvHRs8vDUUt4+BOAnGL4WGat3DNShSI=
X-Google-Smtp-Source: APiQypKacCVJoT+F81hEFU+ci8RV92pSKCLm7jUcnKNZJzlHgkIwn7lr4i9oHgIr+cGF3B2yOYeLJgoZ0n+NxzRSrGs=
X-Received: by 2002:a05:6602:d:: with SMTP id
 b13mr4074236ioa.176.1588696864976; 
 Tue, 05 May 2020 09:41:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200430162439.2659-1-edgar.iglesias@gmail.com>
 <20200430162439.2659-5-edgar.iglesias@gmail.com>
In-Reply-To: <20200430162439.2659-5-edgar.iglesias@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 5 May 2020 09:32:23 -0700
Message-ID: <CAKmqyKNhj6QK_httF8S+D0T_U=D4fCEm3y6z9O99=qmJDiEs6Q@mail.gmail.com>
Subject: Re: [PATCH v1 4/9] hw/dma/xilinx_axidma: Add DMA memory-region
 property
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d43;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd43.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Damien Hedde <damien.hedde@greensocs.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Edgar Iglesias <edgar.iglesias@xilinx.com>,
 Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>,
 Francisco Iglesias <frasse.iglesias@gmail.com>,
 Jason Wang <jasowang@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 Stefano Stabellini <sstabellini@kernel.org>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Luc Michel <luc.michel@greensocs.com>, figlesia@xilinx.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Apr 30, 2020 at 9:29 AM Edgar E. Iglesias
<edgar.iglesias@gmail.com> wrote:
>
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
>
> Add DMA memory-region property to externally control what
> address-space this DMA operates on.
>
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/dma/xilinx_axidma.c | 30 +++++++++++++++++++++++-------
>  1 file changed, 23 insertions(+), 7 deletions(-)
>
> diff --git a/hw/dma/xilinx_axidma.c b/hw/dma/xilinx_axidma.c
> index 018f36991b..4540051448 100644
> --- a/hw/dma/xilinx_axidma.c
> +++ b/hw/dma/xilinx_axidma.c
> @@ -33,6 +33,7 @@
>  #include "qemu/log.h"
>  #include "qemu/module.h"
>
> +#include "sysemu/dma.h"
>  #include "hw/stream.h"
>
>  #define D(x)
> @@ -103,6 +104,7 @@ enum {
>  };
>
>  struct Stream {
> +    struct XilinxAXIDMA *dma;
>      ptimer_state *ptimer;
>      qemu_irq irq;
>
> @@ -125,6 +127,9 @@ struct XilinxAXIDMAStreamSlave {
>  struct XilinxAXIDMA {
>      SysBusDevice busdev;
>      MemoryRegion iomem;
> +    MemoryRegion *dma_mr;
> +    AddressSpace as;
> +
>      uint32_t freqhz;
>      StreamSlave *tx_data_dev;
>      StreamSlave *tx_control_dev;
> @@ -186,7 +191,7 @@ static void stream_desc_load(struct Stream *s, hwaddr addr)
>  {
>      struct SDesc *d = &s->desc;
>
> -    cpu_physical_memory_read(addr, d, sizeof *d);
> +    address_space_read(&s->dma->as, addr, MEMTXATTRS_UNSPECIFIED, d, sizeof *d);
>
>      /* Convert from LE into host endianness.  */
>      d->buffer_address = le64_to_cpu(d->buffer_address);
> @@ -204,7 +209,8 @@ static void stream_desc_store(struct Stream *s, hwaddr addr)
>      d->nxtdesc = cpu_to_le64(d->nxtdesc);
>      d->control = cpu_to_le32(d->control);
>      d->status = cpu_to_le32(d->status);
> -    cpu_physical_memory_write(addr, d, sizeof *d);
> +    address_space_write(&s->dma->as, addr, MEMTXATTRS_UNSPECIFIED,
> +                        d, sizeof *d);
>  }
>
>  static void stream_update_irq(struct Stream *s)
> @@ -286,8 +292,9 @@ static void stream_process_mem2s(struct Stream *s, StreamSlave *tx_data_dev,
>                       txlen + s->pos);
>          }
>
> -        cpu_physical_memory_read(s->desc.buffer_address,
> -                                 s->txbuf + s->pos, txlen);
> +        address_space_read(&s->dma->as, s->desc.buffer_address,
> +                           MEMTXATTRS_UNSPECIFIED,
> +                           s->txbuf + s->pos, txlen);
>          s->pos += txlen;
>
>          if (stream_desc_eof(&s->desc)) {
> @@ -336,7 +343,8 @@ static size_t stream_process_s2mem(struct Stream *s, unsigned char *buf,
>              rxlen = len;
>          }
>
> -        cpu_physical_memory_write(s->desc.buffer_address, buf + pos, rxlen);
> +        address_space_write(&s->dma->as, s->desc.buffer_address,
> +                            MEMTXATTRS_UNSPECIFIED, buf + pos, rxlen);
>          len -= rxlen;
>          pos += rxlen;
>
> @@ -525,6 +533,7 @@ static void xilinx_axidma_realize(DeviceState *dev, Error **errp)
>      XilinxAXIDMAStreamSlave *cs = XILINX_AXI_DMA_CONTROL_STREAM(
>                                                              &s->rx_control_dev);
>      Error *local_err = NULL;
> +    int i;
>
>      object_property_add_link(OBJECT(ds), "dma", TYPE_XILINX_AXI_DMA,
>                               (Object **)&ds->dma,
> @@ -545,17 +554,19 @@ static void xilinx_axidma_realize(DeviceState *dev, Error **errp)
>          goto xilinx_axidma_realize_fail;
>      }
>
> -    int i;
> -
>      for (i = 0; i < 2; i++) {
>          struct Stream *st = &s->streams[i];
>
> +        st->dma = s;
>          st->nr = i;
>          st->ptimer = ptimer_init(timer_hit, st, PTIMER_POLICY_DEFAULT);
>          ptimer_transaction_begin(st->ptimer);
>          ptimer_set_freq(st->ptimer, s->freqhz);
>          ptimer_transaction_commit(st->ptimer);
>      }
> +
> +    address_space_init(&s->as,
> +                       s->dma_mr ? s->dma_mr : get_system_memory(), "dma");
>      return;
>
>  xilinx_axidma_realize_fail:
> @@ -575,6 +586,11 @@ static void xilinx_axidma_init(Object *obj)
>                              &s->rx_control_dev, sizeof(s->rx_control_dev),
>                              TYPE_XILINX_AXI_DMA_CONTROL_STREAM, &error_abort,
>                              NULL);
> +    object_property_add_link(obj, "dma", TYPE_MEMORY_REGION,
> +                             (Object **)&s->dma_mr,
> +                             qdev_prop_allow_set_link_before_realize,
> +                             OBJ_PROP_LINK_STRONG,
> +                             &error_abort);
>
>      sysbus_init_irq(sbd, &s->streams[0].irq);
>      sysbus_init_irq(sbd, &s->streams[1].irq);
> --
> 2.20.1
>
>

