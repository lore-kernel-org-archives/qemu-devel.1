Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7FBCC2BB84
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 20:37:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8784208FE
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 20:37:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vw/H4GKC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8784208FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEISW-0002sJ-Jj
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 16:37:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57468)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kEIRx-0002NI-3M; Fri, 04 Sep 2020 16:36:45 -0400
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42]:44476)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kEIRu-0002z5-IW; Fri, 04 Sep 2020 16:36:44 -0400
Received: by mail-io1-xd42.google.com with SMTP id g128so8397166iof.11;
 Fri, 04 Sep 2020 13:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=vgCnJrRSAAjSpnwfLoGGmlYF88ToELrhPBc6j85A9oo=;
 b=Vw/H4GKC5bieHv5iy4z2V9nrSrryz9ppx4AyoKuiZ4y8+OX6ZHbpBpzpltCeCJA5fd
 QqHKdPxRRa193WwyJBCXPxqFKj6WNqBKdFisxUV/IOp74iiOb3lg8Oa4hMrLQv+shfOq
 TTGtSuW7bOM4GLsEhftV7YfkFBevXqm4rK2bjj8bHE95HO8remUD9V5ewwCb52xQURth
 GsBjUitd858JaRvHm/ttBQZ/pl9xYx/DDQBRxdy8r71S+8kuLRQJxV7xLBwKMpqBBzYu
 xL3JgZiSudZvBPSNphYHn24t25G69KMG0BfW4q6SBaSp2ISmGLe+5FCRmbsmEPbAC3Z0
 0uhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vgCnJrRSAAjSpnwfLoGGmlYF88ToELrhPBc6j85A9oo=;
 b=IBE+6Kfg/Vu3djBj8Vmn6RIsIuc5gt8CaM2brX3Ao5kayYhhLhS0r/z8+6SmJyvnhJ
 zzlJnWK2mgqKvd/1eFe4PjTuEqH/43oqzcoY4hm/39Ji8dWzHHyikWStvUFnAoj/S4nZ
 q/vMmlNjZ3RQj84RKDx41XvzHhhwnVBGaNj1x6RmFdXmf3CtBjF3324QDO0/3QgRm9Y2
 20ZCMq8vK7bEopKvRkdI3QgPTnxyLaPIBTsWcfezwUJaq+52taRK8INg82mdiWR9A/v/
 TfVr+ZYLTznwQms6cktDHJh9F40pNTp9aQAsctt84C1uCmh+BrdHobUSJdiquIR+2XLG
 Tvsg==
X-Gm-Message-State: AOAM533D4b7cRXf8/tlCOXiXBhKbzcstJ+Is8KG1tF3j+QJg0smoglHf
 r1EsbOkiaA4OeWB1/ol9PIg/ww3hwehawx1f670=
X-Google-Smtp-Source: ABdhPJwTq2oAznfl3KywGwZnbDXQdHLn9+Ltn8Tps9HqUnSnLXJs8NH9RAYiy6Z6XFdoRCJ/fwgYQXBX4yiJ/cCIdBc=
X-Received: by 2002:a05:6602:2f88:: with SMTP id
 u8mr8924130iow.175.1599251800980; 
 Fri, 04 Sep 2020 13:36:40 -0700 (PDT)
MIME-Version: 1.0
References: <1598924352-89526-1-git-send-email-bmeng.cn@gmail.com>
 <1598924352-89526-10-git-send-email-bmeng.cn@gmail.com>
In-Reply-To: <1598924352-89526-10-git-send-email-bmeng.cn@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 4 Sep 2020 13:25:46 -0700
Message-ID: <CAKmqyKMw6DfNQHrit1W0WTcANLJX-jXQQ-ULGHbPhq-mNiSF4A@mail.gmail.com>
Subject: Re: [PATCH v3 09/16] hw/dma: Add SiFive platform DMA controller
 emulation
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d42;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd42.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Bin Meng <bin.meng@windriver.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Aug 31, 2020 at 6:48 PM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> From: Bin Meng <bin.meng@windriver.com>
>
> Microchip PolarFire SoC integrates a DMA engine that supports:
> * Independent concurrent DMA transfers using 4 DMA channels
> * Generation of interrupts on various conditions during execution
> which is actually an IP reused from the SiFive FU540 chip.
>
> This creates a model to support both polling and interrupt modes.
>
> Signed-off-by: Bin Meng <bin.meng@windriver.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

>
> ---
>
> Changes in v3:
> - change MCHP_PFSOC_DMA to SIFIVE_PDMA
>
> Changes in v2:
> - change to update hw/dma/meson.build
> - rename the file names to sifive_pdma.[c|h]
> - update irq number to 8 per the SiFive FU540 manual
> - fix the register offset for channel 1/2/3 in the read/write ops
>
>  include/hw/dma/sifive_pdma.h |  57 ++++++++
>  hw/dma/sifive_pdma.c         | 313 +++++++++++++++++++++++++++++++++++++++++++
>  hw/dma/Kconfig               |   3 +
>  hw/dma/meson.build           |   1 +
>  4 files changed, 374 insertions(+)
>  create mode 100644 include/hw/dma/sifive_pdma.h
>  create mode 100644 hw/dma/sifive_pdma.c
>
> diff --git a/include/hw/dma/sifive_pdma.h b/include/hw/dma/sifive_pdma.h
> new file mode 100644
> index 0000000..e319bbd
> --- /dev/null
> +++ b/include/hw/dma/sifive_pdma.h
> @@ -0,0 +1,57 @@
> +/*
> + * SiFive Platform DMA emulation
> + *
> + * Copyright (c) 2020 Wind River Systems, Inc.
> + *
> + * Author:
> + *   Bin Meng <bin.meng@windriver.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation; either version 2 or
> + * (at your option) version 3 of the License.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License along
> + * with this program; if not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#ifndef SIFIVE_PDMA_H
> +#define SIFIVE_PDMA_H
> +
> +struct sifive_pdma_chan {
> +    uint32_t control;
> +    uint32_t next_config;
> +    uint64_t next_bytes;
> +    uint64_t next_dst;
> +    uint64_t next_src;
> +    uint32_t exec_config;
> +    uint64_t exec_bytes;
> +    uint64_t exec_dst;
> +    uint64_t exec_src;
> +    int state;
> +};
> +
> +#define SIFIVE_PDMA_CHANS           4
> +#define SIFIVE_PDMA_IRQS            (SIFIVE_PDMA_CHANS * 2)
> +#define SIFIVE_PDMA_REG_SIZE        0x100000
> +#define SIFIVE_PDMA_CHAN_NO(reg)    ((reg & (SIFIVE_PDMA_REG_SIZE - 1)) >> 12)
> +
> +typedef struct SiFivePDMAState {
> +    SysBusDevice parent;
> +    MemoryRegion iomem;
> +    qemu_irq irq[SIFIVE_PDMA_IRQS];
> +
> +    struct sifive_pdma_chan chan[SIFIVE_PDMA_CHANS];
> +} SiFivePDMAState;
> +
> +#define TYPE_SIFIVE_PDMA    "sifive.pdma"
> +
> +#define SIFIVE_PDMA(obj)    \
> +    OBJECT_CHECK(SiFivePDMAState, (obj), TYPE_SIFIVE_PDMA)
> +
> +#endif /* SIFIVE_PDMA_H */
> diff --git a/hw/dma/sifive_pdma.c b/hw/dma/sifive_pdma.c
> new file mode 100644
> index 0000000..e1f6fed
> --- /dev/null
> +++ b/hw/dma/sifive_pdma.c
> @@ -0,0 +1,313 @@
> +/*
> + * SiFive Platform DMA emulation
> + *
> + * Copyright (c) 2020 Wind River Systems, Inc.
> + *
> + * Author:
> + *   Bin Meng <bin.meng@windriver.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation; either version 2 or
> + * (at your option) version 3 of the License.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License along
> + * with this program; if not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/bitops.h"
> +#include "qemu/log.h"
> +#include "qapi/error.h"
> +#include "hw/hw.h"
> +#include "hw/irq.h"
> +#include "hw/qdev-properties.h"
> +#include "hw/sysbus.h"
> +#include "migration/vmstate.h"
> +#include "sysemu/dma.h"
> +#include "hw/dma/sifive_pdma.h"
> +
> +#define DMA_CONTROL         0x000
> +#define   CONTROL_CLAIM     BIT(0)
> +#define   CONTROL_RUN       BIT(1)
> +#define   CONTROL_DONE_IE   BIT(14)
> +#define   CONTROL_ERR_IE    BIT(15)
> +#define   CONTROL_DONE      BIT(30)
> +#define   CONTROL_ERR       BIT(31)
> +
> +#define DMA_NEXT_CONFIG     0x004
> +#define   CONFIG_REPEAT     BIT(2)
> +#define   CONFIG_ORDER      BIT(3)
> +#define   CONFIG_WRSZ_SHIFT 24
> +#define   CONFIG_RDSZ_SHIFT 28
> +#define   CONFIG_SZ_MASK    0xf
> +
> +#define DMA_NEXT_BYTES      0x008
> +#define DMA_NEXT_DST        0x010
> +#define DMA_NEXT_SRC        0x018
> +#define DMA_EXEC_CONFIG     0x104
> +#define DMA_EXEC_BYTES      0x108
> +#define DMA_EXEC_DST        0x110
> +#define DMA_EXEC_SRC        0x118
> +
> +enum dma_chan_state {
> +    DMA_CHAN_STATE_IDLE,
> +    DMA_CHAN_STATE_STARTED,
> +    DMA_CHAN_STATE_ERROR,
> +    DMA_CHAN_STATE_DONE
> +};
> +
> +static void sifive_pdma_run(SiFivePDMAState *s, int ch)
> +{
> +    uint64_t bytes = s->chan[ch].next_bytes;
> +    uint64_t dst = s->chan[ch].next_dst;
> +    uint64_t src = s->chan[ch].next_src;
> +    uint32_t config = s->chan[ch].next_config;
> +    int wsize, rsize, size;
> +    uint8_t buf[64];
> +    int n;
> +
> +    /* do nothing if bytes to transfer is zero */
> +    if (!bytes) {
> +        goto error;
> +    }
> +
> +    /*
> +     * The manual does not describe how the hardware behaviors when
> +     * config.wsize and config.rsize are given different values.
> +     * A common case is memory to memory DMA, and in this case they
> +     * are normally the same. Abort if this expectation fails.
> +     */
> +    wsize = (config >> CONFIG_WRSZ_SHIFT) & CONFIG_SZ_MASK;
> +    rsize = (config >> CONFIG_RDSZ_SHIFT) & CONFIG_SZ_MASK;
> +    if (wsize != rsize) {
> +        goto error;
> +    }
> +
> +    /*
> +     * Calculate the transaction size
> +     *
> +     * size field is base 2 logarithm of DMA transaction size,
> +     * but there is an upper limit of 64 bytes per transaction.
> +     */
> +    size = wsize;
> +    if (size > 6) {
> +        size = 6;
> +    }
> +    size = 1 << size;
> +
> +    /* the bytes to transfer should be multiple of transaction size */
> +    if (bytes % size) {
> +        goto error;
> +    }
> +
> +    /* indicate a DMA transfer is started */
> +    s->chan[ch].state = DMA_CHAN_STATE_STARTED;
> +    s->chan[ch].control &= ~CONTROL_DONE;
> +    s->chan[ch].control &= ~CONTROL_ERR;
> +
> +    /* load the next_ registers into their exec_ counterparts */
> +    s->chan[ch].exec_config = config;
> +    s->chan[ch].exec_bytes = bytes;
> +    s->chan[ch].exec_dst = dst;
> +    s->chan[ch].exec_src = src;
> +
> +    for (n = 0; n < bytes / size; n++) {
> +        cpu_physical_memory_read(s->chan[ch].exec_src, buf, size);
> +        cpu_physical_memory_write(s->chan[ch].exec_dst, buf, size);
> +        s->chan[ch].exec_src += size;
> +        s->chan[ch].exec_dst += size;
> +        s->chan[ch].exec_bytes -= size;
> +    }
> +
> +    /* indicate a DMA transfer is done */
> +    s->chan[ch].state = DMA_CHAN_STATE_DONE;
> +    s->chan[ch].control &= ~CONTROL_RUN;
> +    s->chan[ch].control |= CONTROL_DONE;
> +
> +    /* reload exec_ registers if repeat is required */
> +    if (s->chan[ch].next_config & CONFIG_REPEAT) {
> +        s->chan[ch].exec_bytes = bytes;
> +        s->chan[ch].exec_dst = dst;
> +        s->chan[ch].exec_src = src;
> +    }
> +
> +    return;
> +
> +error:
> +    s->chan[ch].state = DMA_CHAN_STATE_ERROR;
> +    s->chan[ch].control |= CONTROL_ERR;
> +    return;
> +}
> +
> +static inline void sifive_pdma_update_irq(SiFivePDMAState *s, int ch)
> +{
> +    bool done_ie, err_ie;
> +
> +    done_ie = !!(s->chan[ch].control & CONTROL_DONE_IE);
> +    err_ie = !!(s->chan[ch].control & CONTROL_ERR_IE);
> +
> +    if (done_ie && (s->chan[ch].control & CONTROL_DONE)) {
> +        qemu_irq_raise(s->irq[ch * 2]);
> +    } else {
> +        qemu_irq_lower(s->irq[ch * 2]);
> +    }
> +
> +    if (err_ie && (s->chan[ch].control & CONTROL_ERR)) {
> +        qemu_irq_raise(s->irq[ch * 2 + 1]);
> +    } else {
> +        qemu_irq_lower(s->irq[ch * 2 + 1]);
> +    }
> +
> +    s->chan[ch].state = DMA_CHAN_STATE_IDLE;
> +}
> +
> +static uint64_t sifive_pdma_read(void *opaque, hwaddr offset, unsigned size)
> +{
> +    SiFivePDMAState *s = opaque;
> +    int ch = SIFIVE_PDMA_CHAN_NO(offset);
> +    uint64_t val = 0;
> +
> +    if (ch >= SIFIVE_PDMA_CHANS) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: Invalid channel no %d\n",
> +                      __func__, ch);
> +        return 0;
> +    }
> +
> +    offset &= 0xfff;
> +    switch (offset) {
> +    case DMA_CONTROL:
> +        val = s->chan[ch].control;
> +        break;
> +    case DMA_NEXT_CONFIG:
> +        val = s->chan[ch].next_config;
> +        break;
> +    case DMA_NEXT_BYTES:
> +        val = s->chan[ch].next_bytes;
> +        break;
> +    case DMA_NEXT_DST:
> +        val = s->chan[ch].next_dst;
> +        break;
> +    case DMA_NEXT_SRC:
> +        val = s->chan[ch].next_src;
> +        break;
> +    case DMA_EXEC_CONFIG:
> +        val = s->chan[ch].exec_config;
> +        break;
> +    case DMA_EXEC_BYTES:
> +        val = s->chan[ch].exec_bytes;
> +        break;
> +    case DMA_EXEC_DST:
> +        val = s->chan[ch].exec_dst;
> +        break;
> +    case DMA_EXEC_SRC:
> +        val = s->chan[ch].exec_src;
> +        break;
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%" HWADDR_PRIX "\n",
> +                      __func__, offset);
> +        break;
> +    }
> +
> +    return val;
> +}
> +
> +static void sifive_pdma_write(void *opaque, hwaddr offset,
> +                              uint64_t value, unsigned size)
> +{
> +    SiFivePDMAState *s = opaque;
> +    int ch = SIFIVE_PDMA_CHAN_NO(offset);
> +
> +    if (ch >= SIFIVE_PDMA_CHANS) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: Invalid channel no %d\n",
> +                      __func__, ch);
> +        return;
> +    }
> +
> +    offset &= 0xfff;
> +    switch (offset) {
> +    case DMA_CONTROL:
> +        s->chan[ch].control = value;
> +
> +        if (value & CONTROL_RUN) {
> +            sifive_pdma_run(s, ch);
> +        }
> +
> +        sifive_pdma_update_irq(s, ch);
> +        break;
> +    case DMA_NEXT_CONFIG:
> +        s->chan[ch].next_config = value;
> +        break;
> +    case DMA_NEXT_BYTES:
> +        s->chan[ch].next_bytes = value;
> +        break;
> +    case DMA_NEXT_DST:
> +        s->chan[ch].next_dst = value;
> +        break;
> +    case DMA_NEXT_SRC:
> +        s->chan[ch].next_src = value;
> +        break;
> +    case DMA_EXEC_CONFIG:
> +    case DMA_EXEC_BYTES:
> +    case DMA_EXEC_DST:
> +    case DMA_EXEC_SRC:
> +        /* these are read-only registers */
> +        break;
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%" HWADDR_PRIX "\n",
> +                      __func__, offset);
> +        break;
> +    }
> +}
> +
> +static const MemoryRegionOps sifive_pdma_ops = {
> +    .read = sifive_pdma_read,
> +    .write = sifive_pdma_write,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +    /* there are 32-bit and 64-bit wide registers */
> +    .impl = {
> +        .min_access_size = 4,
> +        .max_access_size = 8,
> +    }
> +};
> +
> +static void sifive_pdma_realize(DeviceState *dev, Error **errp)
> +{
> +    SiFivePDMAState *s = SIFIVE_PDMA(dev);
> +    int i;
> +
> +    memory_region_init_io(&s->iomem, OBJECT(dev), &sifive_pdma_ops, s,
> +                          TYPE_SIFIVE_PDMA, SIFIVE_PDMA_REG_SIZE);
> +    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->iomem);
> +
> +    for (i = 0; i < SIFIVE_PDMA_IRQS; i++) {
> +        sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->irq[i]);
> +    }
> +}
> +
> +static void sifive_pdma_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    dc->desc = "SiFive Platform DMA controller";
> +    dc->realize = sifive_pdma_realize;
> +}
> +
> +static const TypeInfo sifive_pdma_info = {
> +    .name          = TYPE_SIFIVE_PDMA,
> +    .parent        = TYPE_SYS_BUS_DEVICE,
> +    .instance_size = sizeof(SiFivePDMAState),
> +    .class_init    = sifive_pdma_class_init,
> +};
> +
> +static void sifive_pdma_register_types(void)
> +{
> +    type_register_static(&sifive_pdma_info);
> +}
> +
> +type_init(sifive_pdma_register_types)
> diff --git a/hw/dma/Kconfig b/hw/dma/Kconfig
> index 5c61b67..d67492d 100644
> --- a/hw/dma/Kconfig
> +++ b/hw/dma/Kconfig
> @@ -20,3 +20,6 @@ config ZYNQ_DEVCFG
>
>  config STP2000
>      bool
> +
> +config SIFIVE_PDMA
> +    bool
> diff --git a/hw/dma/meson.build b/hw/dma/meson.build
> index ff5bb37..b991d76 100644
> --- a/hw/dma/meson.build
> +++ b/hw/dma/meson.build
> @@ -13,3 +13,4 @@ softmmu_ss.add(when: 'CONFIG_XLNX_ZYNQMP_ARM', if_true: files('xlnx-zdma.c'))
>  softmmu_ss.add(when: 'CONFIG_OMAP', if_true: files('omap_dma.c', 'soc_dma.c'))
>  softmmu_ss.add(when: 'CONFIG_PXA2XX', if_true: files('pxa2xx_dma.c'))
>  softmmu_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm2835_dma.c'))
> +softmmu_ss.add(when: 'CONFIG_SIFIVE_PDMA', if_true: files('sifive_pdma.c'))
> --
> 2.7.4
>
>

