Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18558C28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 11:44:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8139206D5
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 11:44:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B6fQnv1h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8139206D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWITq-0006Nv-1D
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 07:44:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51230)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jWIS2-0004xl-ST; Wed, 06 May 2020 07:42:58 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:46396)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jWIS2-00019S-2D; Wed, 06 May 2020 07:42:58 -0400
Received: by mail-wr1-x442.google.com with SMTP id w7so972767wre.13;
 Wed, 06 May 2020 04:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=A/Az2XDN35xhRqhd5a6KCSsW2OrbB6KAjTnp3g3tixU=;
 b=B6fQnv1huRedz2Emov4uLOGEOUdCfr8nVsr61ek5g6YIS6hualvmPD8bE5mRnIJer8
 +ya0/5pwh6IV0JnNTsrlpdEjX1prAlHalvF2AK9D04xuHkhOGEHOupr6UWOcSj9GWdLx
 YUEi9hETXylZAmNpUJI2CcqSkkSeP5SYaAxGI9Ii8MOtfrL9XpDL+ZbZ+TGMV7R8Wq+A
 pHxV+dsWrUNO5l1/Dgv/jgK16jzsTmPSZXE5rYoaqtCvo+WYUXCBBQ3psuDXP2d9pB3K
 DYOaZCd+J/HtFOwEWdVEQIUWssiPis9w3CdCwMkc80C8/23M+Rlb5D1HfOBJIc0uvzNf
 ycsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=A/Az2XDN35xhRqhd5a6KCSsW2OrbB6KAjTnp3g3tixU=;
 b=QypoEjMoA1QQmC0PjCmRCaAIcUvadl+kmgRggB+ILaM3FlkvkmRjCnVKqjHByfwzXJ
 BOqzQ4z/I7XE0YCI88I8oj4T5AWYrReOB8NFkN3w5luiTmTC02b7qWk2iFalF+shgE/B
 SVfpuDzfQxBj9Z1kz55b8Od/v/5vAOtV8SIkQ5hHPgUMnlt/s47L7tb1odcgGmT7pFGU
 ISPb4IoryNdHjIB6rTbppGbyuKWt03iGv214HrGHMLofuvO2QdrHLl3ZJi0uK9YhOuY9
 U8MpKSz9XNynWsWBQbK5XR7nceAM/QRnqAR6cjBRwb6di829zAU0lJJrx2n4pxSjKImj
 9QcQ==
X-Gm-Message-State: AGi0PubRnvzjesZtHuqByREiedVNZozpIx7LkGNWvfFnQxcrmd1X6sF8
 XcX5OsDt7xAeRVYoDn+eh+c=
X-Google-Smtp-Source: APiQypItJ0OAbqD5pBI82CHQYlLWidVk1nGnkoQ8ZPhDSeLg3/YmFo8PRsZbZo7TY4g2CjftiIhLbA==
X-Received: by 2002:adf:ce02:: with SMTP id p2mr9035521wrn.173.1588765376288; 
 Wed, 06 May 2020 04:42:56 -0700 (PDT)
Received: from [192.168.1.37] (26.red-88-21-207.staticip.rima-tde.net.
 [88.21.207.26])
 by smtp.gmail.com with ESMTPSA id o18sm2347255wrp.23.2020.05.06.04.42.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 May 2020 04:42:55 -0700 (PDT)
Subject: Re: [PATCH v2 4/9] hw/dma/xilinx_axidma: Add DMA memory-region
 property
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org
References: <20200506082513.18751-1-edgar.iglesias@gmail.com>
 <20200506082513.18751-5-edgar.iglesias@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <6e5b9aa9-aff2-25b6-c294-4764d38e3bb8@amsat.org>
Date: Wed, 6 May 2020 13:42:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200506082513.18751-5-edgar.iglesias@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
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
Cc: damien.hedde@greensocs.com, peter.maydell@linaro.org,
 sstabellini@kernel.org, edgar.iglesias@xilinx.com, sai.pavan.boddu@xilinx.com,
 frasse.iglesias@gmail.com, jasowang@redhat.com, alistair@alistair23.me,
 frederic.konrad@adacore.com, qemu-arm@nongnu.org, figlesia@xilinx.com,
 luc.michel@greensocs.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Edgar,

On 5/6/20 10:25 AM, Edgar E. Iglesias wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
> 
> Add DMA memory-region property to externally control what
> address-space this DMA operates on.
> 
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> Reviewed-by: Francisco Iglesias <frasse.iglesias@gmail.com>
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> ---
>   hw/dma/xilinx_axidma.c | 30 +++++++++++++++++++++++-------
>   1 file changed, 23 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/dma/xilinx_axidma.c b/hw/dma/xilinx_axidma.c
> index 018f36991b..4540051448 100644
> --- a/hw/dma/xilinx_axidma.c
> +++ b/hw/dma/xilinx_axidma.c
> @@ -33,6 +33,7 @@
>   #include "qemu/log.h"
>   #include "qemu/module.h"
>   
> +#include "sysemu/dma.h"
>   #include "hw/stream.h"
>   
>   #define D(x)
> @@ -103,6 +104,7 @@ enum {
>   };
>   
>   struct Stream {
> +    struct XilinxAXIDMA *dma;
>       ptimer_state *ptimer;
>       qemu_irq irq;
>   
> @@ -125,6 +127,9 @@ struct XilinxAXIDMAStreamSlave {
>   struct XilinxAXIDMA {
>       SysBusDevice busdev;
>       MemoryRegion iomem;
> +    MemoryRegion *dma_mr;
> +    AddressSpace as;
> +
>       uint32_t freqhz;
>       StreamSlave *tx_data_dev;
>       StreamSlave *tx_control_dev;
> @@ -186,7 +191,7 @@ static void stream_desc_load(struct Stream *s, hwaddr addr)
>   {
>       struct SDesc *d = &s->desc;
>   
> -    cpu_physical_memory_read(addr, d, sizeof *d);
> +    address_space_read(&s->dma->as, addr, MEMTXATTRS_UNSPECIFIED, d, sizeof *d);
>   
>       /* Convert from LE into host endianness.  */
>       d->buffer_address = le64_to_cpu(d->buffer_address);
> @@ -204,7 +209,8 @@ static void stream_desc_store(struct Stream *s, hwaddr addr)
>       d->nxtdesc = cpu_to_le64(d->nxtdesc);
>       d->control = cpu_to_le32(d->control);
>       d->status = cpu_to_le32(d->status);
> -    cpu_physical_memory_write(addr, d, sizeof *d);
> +    address_space_write(&s->dma->as, addr, MEMTXATTRS_UNSPECIFIED,
> +                        d, sizeof *d);
>   }
>   
>   static void stream_update_irq(struct Stream *s)
> @@ -286,8 +292,9 @@ static void stream_process_mem2s(struct Stream *s, StreamSlave *tx_data_dev,
>                        txlen + s->pos);
>           }
>   
> -        cpu_physical_memory_read(s->desc.buffer_address,
> -                                 s->txbuf + s->pos, txlen);
> +        address_space_read(&s->dma->as, s->desc.buffer_address,
> +                           MEMTXATTRS_UNSPECIFIED,
> +                           s->txbuf + s->pos, txlen);
>           s->pos += txlen;
>   
>           if (stream_desc_eof(&s->desc)) {
> @@ -336,7 +343,8 @@ static size_t stream_process_s2mem(struct Stream *s, unsigned char *buf,
>               rxlen = len;
>           }
>   
> -        cpu_physical_memory_write(s->desc.buffer_address, buf + pos, rxlen);
> +        address_space_write(&s->dma->as, s->desc.buffer_address,
> +                            MEMTXATTRS_UNSPECIFIED, buf + pos, rxlen);
>           len -= rxlen;
>           pos += rxlen;
>   
> @@ -525,6 +533,7 @@ static void xilinx_axidma_realize(DeviceState *dev, Error **errp)
>       XilinxAXIDMAStreamSlave *cs = XILINX_AXI_DMA_CONTROL_STREAM(
>                                                               &s->rx_control_dev);
>       Error *local_err = NULL;
> +    int i;
>   
>       object_property_add_link(OBJECT(ds), "dma", TYPE_XILINX_AXI_DMA,
>                                (Object **)&ds->dma,
> @@ -545,17 +554,19 @@ static void xilinx_axidma_realize(DeviceState *dev, Error **errp)
>           goto xilinx_axidma_realize_fail;
>       }
>   
> -    int i;
> -
>       for (i = 0; i < 2; i++) {
>           struct Stream *st = &s->streams[i];
>   
> +        st->dma = s;
>           st->nr = i;
>           st->ptimer = ptimer_init(timer_hit, st, PTIMER_POLICY_DEFAULT);
>           ptimer_transaction_begin(st->ptimer);
>           ptimer_set_freq(st->ptimer, s->freqhz);
>           ptimer_transaction_commit(st->ptimer);
>       }
> +
> +    address_space_init(&s->as,
> +                       s->dma_mr ? s->dma_mr : get_system_memory(), "dma");

I'd instead return an error (earlier in this function) if dma_mr 
property is not set. If you ever respin...

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>


>       return;
>   
>   xilinx_axidma_realize_fail:
> @@ -575,6 +586,11 @@ static void xilinx_axidma_init(Object *obj)
>                               &s->rx_control_dev, sizeof(s->rx_control_dev),
>                               TYPE_XILINX_AXI_DMA_CONTROL_STREAM, &error_abort,
>                               NULL);
> +    object_property_add_link(obj, "dma", TYPE_MEMORY_REGION,
> +                             (Object **)&s->dma_mr,
> +                             qdev_prop_allow_set_link_before_realize,
> +                             OBJ_PROP_LINK_STRONG,
> +                             &error_abort);
>   
>       sysbus_init_irq(sbd, &s->streams[0].irq);
>       sysbus_init_irq(sbd, &s->streams[1].irq);
> 

