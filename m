Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 859CBC4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 10:38:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1386F21D91
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 10:38:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gSi3WZbz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1386F21D91
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLl7B-0005ko-S2
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 06:38:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47412)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kLl69-00055r-SW; Fri, 25 Sep 2020 06:37:05 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:45334)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kLl67-0001ag-5T; Fri, 25 Sep 2020 06:37:05 -0400
Received: by mail-wr1-x443.google.com with SMTP id x14so2997845wrl.12;
 Fri, 25 Sep 2020 03:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=HmbYA9Zds+8r1qRu/zDGbiiDrx76X2OrtKK3M3pkzi0=;
 b=gSi3WZbzP2XQA76ecKctUMblYKmkhAK9UaC//cu7pPuROIPRUH7CjJ4NLKEdabF5g7
 NG9ZOw0KXoUdvd7nUKW0e62q/0d9kCQ1QKWnHPQF/2dgZdefyZ50V7L32Ue3gJvt9PIM
 gnY4/AdnsSwvn10dhQLWoBH/D6b8y3WDTs4+ZtXBfs6Tkc934oo9RhHZVOXTraobBFG/
 GeR9s4wNqY8lmf1HjNy7KytLxgiKDPVfVS5mMYVlrAUHGA9GQGrJKI+0s1mPR2uZEozx
 4LN6b1ncJ5qmxUzj4m994Hm1fSkpcmFtx7QSm8xHYjGyJaf0DjIjgrsu3NAQTC6CIK+C
 hB+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=HmbYA9Zds+8r1qRu/zDGbiiDrx76X2OrtKK3M3pkzi0=;
 b=MWiCqlKOtPe5OfAdqD5X7AoR5TA3L6Vp4ea8H3l/LlGrWd73eUGn2AbvravoHy6f+U
 cisDyfS2wZUFPEbECnkIm6sgE322AQyvbHVv7/0qELX8NsEmxfzl/h3x0wnYRtCcTx8B
 zEFIOqFin4F+Pg7uq4a+C0yOBb8ubho6sYEwYsp5C+cRTsvVulcvyBRIJ3Yc5rGnmEDB
 jUC89k9CR7W8x9sfODON48R2P1dqeu4XhSyo+gdb2Bwrfz3/PBla9hvT7T5J/p+bRAzg
 NOjP0qXiIYWf3Y5F90BMLA9Fc+zDJOzBbQt0lim+k2Y3ZL041ZZ9hwMPHRJsbT4nVVhT
 6Kgg==
X-Gm-Message-State: AOAM5310Zg9Uo8ogDwOnj21A3klfRmkjcmmGFrW/G9VYM7T2gUs56kEc
 chETcklXmj6x/ww1lIIL3K8=
X-Google-Smtp-Source: ABdhPJyoOQmUHmRYijcXgRMYiJ7KCLI+3RUCkpL/U2ZU56YWHh8Vr7hP6Vm1JzHHjE4yG4jIwD/zgw==
X-Received: by 2002:adf:f3cd:: with SMTP id g13mr3748255wrp.298.1601030221356; 
 Fri, 25 Sep 2020 03:37:01 -0700 (PDT)
Received: from [192.168.1.34] (234.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.234])
 by smtp.gmail.com with ESMTPSA id u186sm2415779wmu.34.2020.09.25.03.37.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Sep 2020 03:37:00 -0700 (PDT)
Subject: Re: [RFC PATCH 13/14] hw/char/pl011: add a clock input
To: Luc Michel <luc@lmichel.fr>, qemu-devel@nongnu.org
References: <20200925101731.2159827-1-luc@lmichel.fr>
 <20200925101731.2159827-14-luc@lmichel.fr>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <fd3197cf-6715-3392-00e5-676dbf0070a8@amsat.org>
Date: Fri, 25 Sep 2020 12:36:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200925101731.2159827-14-luc@lmichel.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.248, NICE_REPLY_A=-0.214,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Andrew Baumann <Andrew.Baumann@microsoft.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/25/20 12:17 PM, Luc Michel wrote:
> Add a clock input to the PL011 UART so we can compute the current baud
> rate and trace it. This is intended for developers who wish to use QEMU
> to e.g. debug their firmware or to figure out the baud rate configured
> by an unknown/closed source binary.
> 
> Signed-off-by: Luc Michel <luc@lmichel.fr>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  include/hw/char/pl011.h |  1 +
>  hw/char/pl011.c         | 45 +++++++++++++++++++++++++++++++++++++++++
>  hw/char/trace-events    |  1 +
>  3 files changed, 47 insertions(+)
> 
> diff --git a/include/hw/char/pl011.h b/include/hw/char/pl011.h
> index a91ea50e11..33e5e5317b 100644
> --- a/include/hw/char/pl011.h
> +++ b/include/hw/char/pl011.h
> @@ -47,10 +47,11 @@ struct PL011State {
>      int read_pos;
>      int read_count;
>      int read_trigger;
>      CharBackend chr;
>      qemu_irq irq[6];
> +    Clock *clk;
>      const unsigned char *id;
>  };
>  
>  static inline DeviceState *pl011_create(hwaddr addr,
>                                          qemu_irq irq,
> diff --git a/hw/char/pl011.c b/hw/char/pl011.c
> index 13e784f9d9..ede16c781c 100644
> --- a/hw/char/pl011.c
> +++ b/hw/char/pl011.c
> @@ -20,10 +20,11 @@
>  
>  #include "qemu/osdep.h"
>  #include "hw/char/pl011.h"
>  #include "hw/irq.h"
>  #include "hw/sysbus.h"
> +#include "hw/qdev-clock.h"
>  #include "migration/vmstate.h"
>  #include "chardev/char-fe.h"
>  #include "qemu/log.h"
>  #include "qemu/module.h"
>  #include "trace.h"
> @@ -167,10 +168,29 @@ static void pl011_set_read_trigger(PL011State *s)
>      else
>  #endif
>          s->read_trigger = 1;
>  }
>  
> +static unsigned int pl011_get_baudrate(const PL011State *s)
> +{
> +    uint64_t clk;
> +
> +    if (s->fbrd == 0) {
> +        return 0;
> +    }
> +
> +    clk = clock_get_hz(s->clk);
> +    return (clk / ((s->ibrd << 6) + s->fbrd)) << 2;
> +}
> +
> +static void pl011_trace_baudrate_change(const PL011State *s)
> +{
> +    trace_pl011_baudrate_change(pl011_get_baudrate(s),
> +                                clock_get_hz(s->clk),
> +                                s->ibrd, s->fbrd);
> +}
> +
>  static void pl011_write(void *opaque, hwaddr offset,
>                          uint64_t value, unsigned size)
>  {
>      PL011State *s = (PL011State *)opaque;
>      unsigned char ch;
> @@ -196,13 +216,15 @@ static void pl011_write(void *opaque, hwaddr offset,
>      case 8: /* UARTUARTILPR */
>          s->ilpr = value;
>          break;
>      case 9: /* UARTIBRD */
>          s->ibrd = value;
> +        pl011_trace_baudrate_change(s);
>          break;
>      case 10: /* UARTFBRD */
>          s->fbrd = value;
> +        pl011_trace_baudrate_change(s);
>          break;
>      case 11: /* UARTLCR_H */
>          /* Reset the FIFO state on FIFO enable or disable */
>          if ((s->lcr ^ value) & 0x10) {
>              s->read_count = 0;
> @@ -284,16 +306,33 @@ static void pl011_event(void *opaque, QEMUChrEvent event)
>  {
>      if (event == CHR_EVENT_BREAK)
>          pl011_put_fifo(opaque, 0x400);
>  }
>  
> +static void pl011_clock_update(void *opaque)
> +{
> +    PL011State *s = PL011(opaque);
> +
> +    pl011_trace_baudrate_change(s);
> +}
> +
>  static const MemoryRegionOps pl011_ops = {
>      .read = pl011_read,
>      .write = pl011_write,
>      .endianness = DEVICE_NATIVE_ENDIAN,
>  };
>  
> +static const VMStateDescription vmstate_pl011_clock = {
> +    .name = "pl011/clock",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_CLOCK(clk, PL011State),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
>  static const VMStateDescription vmstate_pl011 = {
>      .name = "pl011",
>      .version_id = 2,
>      .minimum_version_id = 2,
>      .fields = (VMStateField[]) {
> @@ -312,10 +351,14 @@ static const VMStateDescription vmstate_pl011 = {
>          VMSTATE_UINT32(ifl, PL011State),
>          VMSTATE_INT32(read_pos, PL011State),
>          VMSTATE_INT32(read_count, PL011State),
>          VMSTATE_INT32(read_trigger, PL011State),
>          VMSTATE_END_OF_LIST()
> +    },
> +    .subsections = (const VMStateDescription * []) {
> +        &vmstate_pl011_clock,
> +        NULL
>      }
>  };
>  
>  static Property pl011_properties[] = {
>      DEFINE_PROP_CHR("chardev", PL011State, chr),
> @@ -332,10 +375,12 @@ static void pl011_init(Object *obj)
>      sysbus_init_mmio(sbd, &s->iomem);
>      for (i = 0; i < ARRAY_SIZE(s->irq); i++) {
>          sysbus_init_irq(sbd, &s->irq[i]);
>      }
>  
> +    s->clk = qdev_init_clock_in(DEVICE(obj), "clk", pl011_clock_update, s);
> +
>      s->read_trigger = 1;
>      s->ifl = 0x12;
>      s->cr = 0x300;
>      s->flags = 0x90;
>  
> diff --git a/hw/char/trace-events b/hw/char/trace-events
> index 2442a9f7d5..cc1f0065ac 100644
> --- a/hw/char/trace-events
> +++ b/hw/char/trace-events
> @@ -62,10 +62,11 @@ pl011_read(uint32_t addr, uint32_t value) "addr 0x%08x value 0x%08x"
>  pl011_read_fifo(int read_count) "FIFO read, read_count now %d"
>  pl011_write(uint32_t addr, uint32_t value) "addr 0x%08x value 0x%08x"
>  pl011_can_receive(uint32_t lcr, int read_count, int r) "LCR 0x%08x read_count %d returning %d"
>  pl011_put_fifo(uint32_t c, int read_count) "new char 0x%x read_count now %d"
>  pl011_put_fifo_full(void) "FIFO now full, RXFF set"
> +pl011_baudrate_change(unsigned int baudrate, uint64_t clock, uint32_t ibrd, uint32_t fbrd) "new baudrate %u (clk: %" PRIu64 "hz, ibrd: %" PRIu32 ", fbrd: %" PRIu32 ")"
>  
>  # cmsdk-apb-uart.c
>  cmsdk_apb_uart_read(uint64_t offset, uint64_t data, unsigned size) "CMSDK APB UART read: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u"
>  cmsdk_apb_uart_write(uint64_t offset, uint64_t data, unsigned size) "CMSDK APB UART write: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u"
>  cmsdk_apb_uart_reset(void) "CMSDK APB UART: reset"
> 

