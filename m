Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE899C4BA24
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 23:03:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A779324650
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 23:03:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m7I0bnUB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A779324650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51375 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j75hm-0006V6-SW
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 18:03:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42527)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1j75h8-0005xK-K4
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 18:02:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1j75h6-0002sn-Op
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 18:02:22 -0500
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:37026)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1j75h6-0002pd-Dj; Wed, 26 Feb 2020 18:02:20 -0500
Received: by mail-lj1-x241.google.com with SMTP id q23so1059188ljm.4;
 Wed, 26 Feb 2020 15:02:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=lfiKTlyeXxLsn+X1WSKAxytELJiz7Eeecnonufgqrq8=;
 b=m7I0bnUB48Bw+SXm7+TyHw8VYsyj7bFOCkazgQJytqJNTjvRbYdK3aJm7JDCWMUCP3
 Hlqg7C/tnNab4h1mF0RS6m5Y5p/Wo9q+fk52Leq3j+QXUF1P49sTlB28erpsigTSd2AJ
 yaKu9gK+yKwT4C0KkbxZsZpAxmoH+E/RnBpBeeamq8kXNbCWbGK/Zdu/QSPlOf5HIkIy
 w6qEtYq7q5ViW9ebslfmgNeFHFVCMUiN6J70/rmkd5kAex4xrMRKooUCNztRjgLEYZIr
 Ys08XHRX6N4HJMzHacr+IpaqDEXr9bROyVqxULK0yBIUQdQmOs7ktmhwdc0wao1LE5KP
 0enA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=lfiKTlyeXxLsn+X1WSKAxytELJiz7Eeecnonufgqrq8=;
 b=s0HdNy6ge4rXTDgDOlhCdjJV5D7EYdWjRRQBN1IHHIAnUEI8+qketw4QtAOX9YO7iM
 4zAYcbcdrnRaXBB0Hkn74XiymEPOODoPtqQ6Wn8K5RjmOIYmHv7WJgpZRx0zHH2QpGn9
 4UIgHuZUCa7O4+UqCCtAfyM1HHAfJt5ej7chdAgh6keYkcuiAbkErcxqiwDTlUgXc5Et
 ecs4y5bVcLoSGZ+M5uuURwIWHfk35USpNbb0JAkUs9K/Pssif2aiZbWJlcQoAbUPDDzk
 AzjtP5+KhlIwZlUtaBhyLXXSjcAJF41+/fuVZCnjrq2GJ+IozUkjRBFNfRFy62yIICD8
 NykA==
X-Gm-Message-State: ANhLgQ0HITkeFW+/LQxdnR51gG0KllHbG5PdsmtTSUKqTVMe9Rr+bb5P
 x2eCvltNn32cl1XVQndlPDH9pi5qjfNS/E0uXTo=
X-Google-Smtp-Source: ADFU+vvixwU6Jf1+iQfrnVjOoY9T7LesNco5owXnZ6eOsmrt3ryfbE9WUXXL05WlMgqMiCB6rRji72n5hzbuu12k9xE=
X-Received: by 2002:a2e:544:: with SMTP id 65mr838621ljf.76.1582758138829;
 Wed, 26 Feb 2020 15:02:18 -0800 (PST)
MIME-Version: 1.0
References: <20200225131422.53368-1-damien.hedde@greensocs.com>
 <20200225131422.53368-8-damien.hedde@greensocs.com>
In-Reply-To: <20200225131422.53368-8-damien.hedde@greensocs.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 26 Feb 2020 14:54:41 -0800
Message-ID: <CAKmqyKMczNPHVqZdQXW1B7+Rrs-+eeWMjqpEjY_mUF+Bfa3BjA@mail.gmail.com>
Subject: Re: [PATCH v8 7/9] hw/char/cadence_uart: add clock support
To: Damien Hedde <damien.hedde@greensocs.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::241
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Mark Burton <mark.burton@greensocs.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Edgar Iglesias <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Feb 25, 2020 at 5:31 AM Damien Hedde <damien.hedde@greensocs.com> wrote:
>
> Switch the cadence uart to multi-phase reset and add the
> reference clock input.
>
> The input clock frequency is added to the migration structure.
>
> The reference clock controls the baudrate generation. If it disabled,
> any input characters and events are ignored.
>
> If this clock remains unconnected, the uart behaves as before
> (it default to a 50MHz ref clock).
>
> Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

>
> ---
>
> v7:
>  + update ClockIn/ClockOut types
>  + update due to resettable changes
>  + use a versioned field instead subsection in vmstate
> ---
>  include/hw/char/cadence_uart.h |  1 +
>  hw/char/cadence_uart.c         | 73 +++++++++++++++++++++++++++++-----
>  hw/char/trace-events           |  3 ++
>  3 files changed, 67 insertions(+), 10 deletions(-)
>
> diff --git a/include/hw/char/cadence_uart.h b/include/hw/char/cadence_uart.h
> index 47cec956c4..2a179a572f 100644
> --- a/include/hw/char/cadence_uart.h
> +++ b/include/hw/char/cadence_uart.h
> @@ -49,6 +49,7 @@ typedef struct {
>      CharBackend chr;
>      qemu_irq irq;
>      QEMUTimer *fifo_trigger_handle;
> +    Clock *refclk;
>  } CadenceUARTState;
>
>  static inline DeviceState *cadence_uart_create(hwaddr addr,
> diff --git a/hw/char/cadence_uart.c b/hw/char/cadence_uart.c
> index 22e47972f1..e196906c92 100644
> --- a/hw/char/cadence_uart.c
> +++ b/hw/char/cadence_uart.c
> @@ -31,6 +31,8 @@
>  #include "qemu/module.h"
>  #include "hw/char/cadence_uart.h"
>  #include "hw/irq.h"
> +#include "hw/qdev-clock.h"
> +#include "trace.h"
>
>  #ifdef CADENCE_UART_ERR_DEBUG
>  #define DB_PRINT(...) do { \
> @@ -97,7 +99,7 @@
>  #define LOCAL_LOOPBACK         (0x2 << UART_MR_CHMODE_SH)
>  #define REMOTE_LOOPBACK        (0x3 << UART_MR_CHMODE_SH)
>
> -#define UART_INPUT_CLK         50000000
> +#define UART_DEFAULT_REF_CLK (50 * 1000 * 1000)
>
>  #define R_CR       (0x00/4)
>  #define R_MR       (0x04/4)
> @@ -171,12 +173,15 @@ static void uart_send_breaks(CadenceUARTState *s)
>  static void uart_parameters_setup(CadenceUARTState *s)
>  {
>      QEMUSerialSetParams ssp;
> -    unsigned int baud_rate, packet_size;
> +    unsigned int baud_rate, packet_size, input_clk;
> +    input_clk = clock_get_hz(s->refclk);
>
> -    baud_rate = (s->r[R_MR] & UART_MR_CLKS) ?
> -            UART_INPUT_CLK / 8 : UART_INPUT_CLK;
> +    baud_rate = (s->r[R_MR] & UART_MR_CLKS) ? input_clk / 8 : input_clk;
> +    baud_rate /= (s->r[R_BRGR] * (s->r[R_BDIV] + 1));
> +    trace_cadence_uart_baudrate(baud_rate);
> +
> +    ssp.speed = baud_rate;
>
> -    ssp.speed = baud_rate / (s->r[R_BRGR] * (s->r[R_BDIV] + 1));
>      packet_size = 1;
>
>      switch (s->r[R_MR] & UART_MR_PAR) {
> @@ -215,6 +220,13 @@ static void uart_parameters_setup(CadenceUARTState *s)
>      }
>
>      packet_size += ssp.data_bits + ssp.stop_bits;
> +    if (ssp.speed == 0) {
> +        /*
> +         * Avoid division-by-zero below.
> +         * TODO: find something better
> +         */
> +        ssp.speed = 1;
> +    }
>      s->char_tx_time = (NANOSECONDS_PER_SECOND / ssp.speed) * packet_size;
>      qemu_chr_fe_ioctl(&s->chr, CHR_IOCTL_SERIAL_SET_PARAMS, &ssp);
>  }
> @@ -340,6 +352,11 @@ static void uart_receive(void *opaque, const uint8_t *buf, int size)
>      CadenceUARTState *s = opaque;
>      uint32_t ch_mode = s->r[R_MR] & UART_MR_CHMODE;
>
> +    /* ignore characters when unclocked or in reset */
> +    if (!clock_is_enabled(s->refclk) || device_is_in_reset(DEVICE(s))) {
> +        return;
> +    }
> +
>      if (ch_mode == NORMAL_MODE || ch_mode == ECHO_MODE) {
>          uart_write_rx_fifo(opaque, buf, size);
>      }
> @@ -353,6 +370,11 @@ static void uart_event(void *opaque, QEMUChrEvent event)
>      CadenceUARTState *s = opaque;
>      uint8_t buf = '\0';
>
> +    /* ignore characters when unclocked or in reset */
> +    if (!clock_is_enabled(s->refclk) || device_is_in_reset(DEVICE(s))) {
> +        return;
> +    }
> +
>      if (event == CHR_EVENT_BREAK) {
>          uart_write_rx_fifo(opaque, &buf, 1);
>      }
> @@ -462,9 +484,9 @@ static const MemoryRegionOps uart_ops = {
>      .endianness = DEVICE_NATIVE_ENDIAN,
>  };
>
> -static void cadence_uart_reset(DeviceState *dev)
> +static void cadence_uart_reset_init(Object *obj, ResetType type)
>  {
> -    CadenceUARTState *s = CADENCE_UART(dev);
> +    CadenceUARTState *s = CADENCE_UART(obj);
>
>      s->r[R_CR] = 0x00000128;
>      s->r[R_IMR] = 0;
> @@ -473,6 +495,11 @@ static void cadence_uart_reset(DeviceState *dev)
>      s->r[R_BRGR] = 0x0000028B;
>      s->r[R_BDIV] = 0x0000000F;
>      s->r[R_TTRIG] = 0x00000020;
> +}
> +
> +static void cadence_uart_reset_hold(Object *obj)
> +{
> +    CadenceUARTState *s = CADENCE_UART(obj);
>
>      uart_rx_reset(s);
>      uart_tx_reset(s);
> @@ -491,6 +518,14 @@ static void cadence_uart_realize(DeviceState *dev, Error **errp)
>                               uart_event, NULL, s, NULL, true);
>  }
>
> +static void cadence_uart_refclk_update(void *opaque)
> +{
> +    CadenceUARTState *s = opaque;
> +
> +    /* recompute uart's speed on clock change */
> +    uart_parameters_setup(s);
> +}
> +
>  static void cadence_uart_init(Object *obj)
>  {
>      SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
> @@ -500,9 +535,23 @@ static void cadence_uart_init(Object *obj)
>      sysbus_init_mmio(sbd, &s->iomem);
>      sysbus_init_irq(sbd, &s->irq);
>
> +    s->refclk = qdev_init_clock_in(DEVICE(obj), "refclk",
> +            cadence_uart_refclk_update, s);
> +    /* initialize the frequency in case the clock remains unconnected */
> +    clock_set_hz(s->refclk, UART_DEFAULT_REF_CLK);
> +
>      s->char_tx_time = (NANOSECONDS_PER_SECOND / 9600) * 10;
>  }
>
> +static int cadence_uart_pre_load(void *opaque)
> +{
> +    CadenceUARTState *s = opaque;
> +
> +    /* the frequency will be overriden if the refclk field is present */
> +    clock_set_hz(s->refclk, UART_DEFAULT_REF_CLK);
> +    return 0;
> +}
> +
>  static int cadence_uart_post_load(void *opaque, int version_id)
>  {
>      CadenceUARTState *s = opaque;
> @@ -521,8 +570,9 @@ static int cadence_uart_post_load(void *opaque, int version_id)
>
>  static const VMStateDescription vmstate_cadence_uart = {
>      .name = "cadence_uart",
> -    .version_id = 2,
> +    .version_id = 3,
>      .minimum_version_id = 2,
> +    .pre_load = cadence_uart_pre_load,
>      .post_load = cadence_uart_post_load,
>      .fields = (VMStateField[]) {
>          VMSTATE_UINT32_ARRAY(r, CadenceUARTState, CADENCE_UART_R_MAX),
> @@ -534,8 +584,9 @@ static const VMStateDescription vmstate_cadence_uart = {
>          VMSTATE_UINT32(tx_count, CadenceUARTState),
>          VMSTATE_UINT32(rx_wpos, CadenceUARTState),
>          VMSTATE_TIMER_PTR(fifo_trigger_handle, CadenceUARTState),
> +        VMSTATE_CLOCK_V(refclk, CadenceUARTState, 3),
>          VMSTATE_END_OF_LIST()
> -    }
> +    },
>  };
>
>  static Property cadence_uart_properties[] = {
> @@ -546,10 +597,12 @@ static Property cadence_uart_properties[] = {
>  static void cadence_uart_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
> +    ResettableClass *rc = RESETTABLE_CLASS(klass);
>
>      dc->realize = cadence_uart_realize;
>      dc->vmsd = &vmstate_cadence_uart;
> -    dc->reset = cadence_uart_reset;
> +    rc->phases.enter = cadence_uart_reset_init;
> +    rc->phases.hold  = cadence_uart_reset_hold;
>      device_class_set_props(dc, cadence_uart_properties);
>    }
>
> diff --git a/hw/char/trace-events b/hw/char/trace-events
> index 6f938301d9..d20eafd56f 100644
> --- a/hw/char/trace-events
> +++ b/hw/char/trace-events
> @@ -97,3 +97,6 @@ exynos_uart_wo_read(uint32_t channel, const char *name, uint32_t reg) "UART%d: T
>  exynos_uart_rxsize(uint32_t channel, uint32_t size) "UART%d: Rx FIFO size: %d"
>  exynos_uart_channel_error(uint32_t channel) "Wrong UART channel number: %d"
>  exynos_uart_rx_timeout(uint32_t channel, uint32_t stat, uint32_t intsp) "UART%d: Rx timeout stat=0x%x intsp=0x%x"
> +
> +# hw/char/cadence_uart.c
> +cadence_uart_baudrate(unsigned baudrate) "baudrate %u"
> --
> 2.25.1
>
>

