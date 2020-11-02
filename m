Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A84BC00A89
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 16:33:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B0C022245
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 16:33:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KIyTtbSP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B0C022245
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZcle-00025s-Bz
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 11:33:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44254)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kZckk-0001XE-Rk
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 11:32:18 -0500
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629]:38567)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kZcki-0000rg-HM
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 11:32:18 -0500
Received: by mail-ej1-x629.google.com with SMTP id za3so19716045ejb.5
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2020 08:32:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ajb/AoSgvJo1AXWeftCZ+HnTkV71eJWuV/jKC8A6ZXM=;
 b=KIyTtbSP77teIh4gznvmMIDZ7ch7LhH93Singk0LPR8Nj/pY8eUxvrA+8rGHq1/r1S
 3NAWh5GN+j7xdMe3EnvmXYyRUdOVSEtWaunmOGGivXNRS5K9emBWGzcJpW9W+ZRxLYP2
 pXjWjrlwFGOtbNUFT2+P9dfQP6KcNonurcV4FgjvLLSIX9hAitcfeC5FlxOXNiZOI2TB
 BcWX/UDY/ouY9LoFoMcBfGIiRAPi7B9vNZl/B6RCLD9vkidocnQY9PxY3Z8STOh+0kgg
 n6IvQTP82fW1SxsadbqQ8ELEK5SPWbweuLXsDgvR6+OB6LA5H9OfbZYW/JKiiXkL6ZDB
 S+6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ajb/AoSgvJo1AXWeftCZ+HnTkV71eJWuV/jKC8A6ZXM=;
 b=aoQ7M9/OY525ZRJUgIMQCwEGbEVfxhcfwEF37wXG1W+jH757SVeRFpaI9B0sCxRDBX
 pFjv2QUyvlVlvj4g4mOtys4NqoKIWYmwMvcOD91FWDxjkuR57BkRwl9nhabqWkCTTOAm
 hXDuQOS6wFutfbqSwMi8UibWr8+OvPsxU2grIkoT5jDkvxZmI9KMiuSzhWONv/9Oi+ja
 Vrf2DywR4P1HZtR7Vn77KSvGJ95JUCX/UN+//WJCNeQNNdbogChN22k44lDQ2HIJCJSX
 6eK5mxJg/BsqvTrV4DJ4n1fkE3iy11xjuK5uhgQoMwjaecVWq5V+9+6orkgfVNktJQhM
 jm+A==
X-Gm-Message-State: AOAM533eU8W5nK4aa4a/JPwzcpu1KYcBZuH9P+QATc7mq4moR5CaZSds
 ZeiI9u27Gh3BNwQubYztEdoquASrsUHjCzBiGLoyZw==
X-Google-Smtp-Source: ABdhPJzV8LTPi9C5eSqrenPMxh2ef8rfholDn6jHDeL1NMxtA5IbRvNrTpOUZCFR0kZKgtuFVuz16oI2dTVZqX1C+v8=
X-Received: by 2002:a17:906:3b59:: with SMTP id
 h25mr16977876ejf.56.1604334734815; 
 Mon, 02 Nov 2020 08:32:14 -0800 (PST)
MIME-Version: 1.0
References: <20200924092314.1722645-1-pbonzini@redhat.com>
 <20200924092314.1722645-91-pbonzini@redhat.com>
In-Reply-To: <20200924092314.1722645-91-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 2 Nov 2020 16:32:03 +0000
Message-ID: <CAFEAcA8KdpXrnL5fp6=HFXY5v-eCJwiCyCEp8QGaFpNrzXQEtw@mail.gmail.com>
Subject: Re: [PULL 90/92] hw/net/can: CTU CAN FD IP open hardware core
 emulation.
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x629.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: Pavel Pisa <pisa@cmp.felk.cvut.cz>, QEMU Developers <qemu-devel@nongnu.org>,
 Jan Charvat <charvj10@fel.cvut.cz>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 24 Sep 2020 at 11:21, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> From: Jan Charvat <charvj10@fel.cvut.cz>
>
> The implementation of the model of complete open-source/design/hardware
> CAN FD controller. The IP core project has been started and is maintained
> by Ondrej Ille at Czech Technical University in Prague.
>
> CTU CAN FD project pages:
>         https://gitlab.fel.cvut.cz/canbus/ctucanfd_ip_core
>
> CAN bus CTU FEE Projects Listing page:
>         http://canbus.pages.fel.cvut.cz/
>
> The core is mapped to PCIe card same as on one of its real hardware
> adaptations. The device implementing two CTU CAN FD ip cores
> is instantiated after CAN bus definition
>
>         -object can-bus,id=canbus0-bus
>
> by QEMU parameters
>
>         -device ctucan_pci,canbus0=canbus0-bus,canbus1=canbus0-bus
>
> Signed-off-by: Jan Charvat <charvj10@fel.cvut.cz>
> Signed-off-by: Pavel Pisa <pisa@cmp.felk.cvut.cz>
> Message-Id: <23e3ca4dcb2cc9900991016910a6cab7686c0e31.1600069689.git.pisa@cmp.felk.cvut.cz>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---

Hi; Coverity points out a couple of issues with this code,
one of which looks like a buffer overrun.

First, the minor one:

> +static void ctucan_send_ready_buffers(CtuCanCoreState *s)
> +{
> +    qemu_can_frame frame;
> +    uint8_t *pf;
> +    int buff2tx_idx;
> +    uint32_t tx_prio_max;
> +    unsigned int buff_st;
> +    uint32_t buff_st_mask;
> +
> +    if (!s->mode_settings.s.ena) {
> +        return;
> +    }
> +
> +    do {
> +        union ctu_can_fd_int_stat int_stat;
> +        int i;
> +        buff2tx_idx = -1;
> +        tx_prio_max = 0;
> +
> +        for (i = 0; i < CTUCAN_CORE_TXBUF_NUM; i++) {
> +            uint32_t prio;
> +
> +            buff_st_mask = 0xf << (i * 4);
> +            buff_st = (s->tx_status.u32 >> (i * 4)) & 0xf;

Here we write to buff_st_mask...

> +
> +            if (buff_st != TXT_RDY) {
> +                continue;
> +            }
> +            prio = (s->tx_priority.u32 >> (i * 4)) & 0x7;
> +            if (tx_prio_max < prio) {
> +                tx_prio_max = prio;
> +                buff2tx_idx = i;
> +            }
> +        }
> +        if (buff2tx_idx == -1) {
> +            break;
> +        }
> +        buff_st_mask = 0xf << (buff2tx_idx * 4);

...but we never use it before we overwrite with this assignment,
so the earlier assignment is dead code.

Is there a missing use of the variable in between, or should
the earlier assignment just be deleted ?

> +        buff_st = (s->tx_status.u32 >> (buff2tx_idx * 4)) & 0xf;
> +        int_stat.u32 = 0;
> +        buff_st = TXT_RDY;
> +        pf = s->tx_buffer[buff2tx_idx].data;
> +        ctucan_buff2frame(pf, &frame);
> +        s->status.s.idle = 0;
> +        s->status.s.txs = 1;
> +        can_bus_client_send(&s->bus_client, &frame, 1);
> +        s->status.s.idle = 1;
> +        s->status.s.txs = 0;
> +        s->tx_fr_ctr.s.tx_fr_ctr_val++;
> +        buff_st = TXT_TOK;
> +        int_stat.s.txi = 1;
> +        int_stat.s.txbhci = 1;
> +        s->int_stat.u32 |= int_stat.u32 & ~s->int_mask.u32;
> +        s->tx_status.u32 = (s->tx_status.u32 & ~buff_st_mask) |
> +                        (buff_st << (buff2tx_idx * 4));
> +    } while (1);
> +}

Now here's the buffer overrun:

> +void ctucan_mem_write(CtuCanCoreState *s, hwaddr addr, uint64_t val,
> +                       unsigned size)
> +{
> +    int              i;
> +
> +    DPRINTF("write 0x%02llx addr 0x%02x\n",
> +            (unsigned long long)val, (unsigned int)addr);
> +
> +    if (addr > CTUCAN_CORE_MEM_SIZE) {
> +        return;

Side note, this check should almost certainly be > and not >=
since addresses 0x0..0x499 are OK but 0x500 not.

> +    }
> +
> +    if (addr >= CTU_CAN_FD_TXTB1_DATA_1) {
> +        int buff_num;
> +        addr -= CTU_CAN_FD_TXTB1_DATA_1;
> +        buff_num = addr / CTUCAN_CORE_TXBUFF_SPAN;
> +        addr %= CTUCAN_CORE_TXBUFF_SPAN;
> +        if (buff_num < CTUCAN_CORE_TXBUF_NUM) {
> +            uint32_t *bufp = (uint32_t *)(s->tx_buffer[buff_num].data + addr);
> +            *bufp = cpu_to_le32(val);
> +        }

Here we take the address, and divide it into a buff_num
and an address inside that buffer. CTUCAN_CORE_TXBUFF_SPAN
is (CTU_CAN_FD_TXTB2_DATA_1 - CTU_CAN_FD_TXTB1_DATA_1),
which is 0x200 - 0x100 == 0x100 (256 in decimal).
So after the %= operation, addr can be between 0 and 255.
However, we then use this as an offset into the array
s->tx_buffer[buff_num].data.
tx_buffer is declared as:
    CtuCanCoreMsgBuffer tx_buffer[CTUCAN_CORE_TXBUF_NUM];
and CtuCanCoreMsgBuffer is
typedef struct CtuCanCoreMsgBuffer {
    uint8_t data[CTUCAN_CORE_MSG_MAX_LEN];
} CtuCanCoreMsgBuffer;

But CTUCAN_CORE_MSG_MAX_LEN is defined to be 0x50 (80 bytes),
so the data array is much smaller than the set of offsets
we allow the guest to make into it, and the guest can write
well off the end of the array.

Is the array too small, or should we be guarding the
permitted values of addr the way we do the value of
buff_num ?

Ironically, if we get the check against CTUCAN_CORE_MEM_SIZE
right then it's not actually possible for buff_num to
be >= CTUCAN_CORE_TXBUF_NUM, because CTUCAN_CORE_TXBUF_NUM
is 4, CTUCAN_CORE_MEM_SIZE is 0x500 and CTU_CAN_FD_TXTB1_DATA_1
is 0x100. So that should be assert()ed rather than tested,
I think.


> +        case CTU_CAN_FD_INT_STAT:
> +            s->int_stat.u32 &= ~(uint32_t)val;

Side note: using bitfields like this is non portable.
You have a lot of unions and ifdefs in your header file
as a result, and this in ctu_can_fd_regs.h suggests that
you're assuming little-endian order unconditionally:

#ifndef __LITTLE_ENDIAN_BITFIELD
#define __LITTLE_ENDIAN_BITFIELD 1
#endif

The minimum fix here is to define this only if
!defined(HOST_WORDS_BIGENDIAN) but really you ought
to replace all this code with extract32()/deposit32()
and other logical operations IMHO.

thanks
-- PMM

