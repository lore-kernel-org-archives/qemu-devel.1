Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4558BC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 17:30:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 110992073E
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 17:30:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bJK/P/uo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 110992073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55572 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsrQi-00055x-Ak
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 13:30:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51952)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jsrPu-0004Q1-QF; Tue, 07 Jul 2020 13:30:02 -0400
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:40046)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jsrPt-0003yb-1N; Tue, 07 Jul 2020 13:30:02 -0400
Received: by mail-io1-xd41.google.com with SMTP id q8so44051978iow.7;
 Tue, 07 Jul 2020 10:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=rLt3e0hI/eZ5dLp6vWtmVMpb8Frs6XxfQeKeBZLZRzw=;
 b=bJK/P/uoxKmXyTxi4pW5KCk5nXWaYV76z9vWTiDAbrs8FqhikFEk/tvz/P6XUuCzYc
 R3vS8qlxXGLKL+bgjPfO3rxN6bMFto7QgbzaTCqGaDjLDf8XInMs+9QWRK6hBPCct9Wf
 7PFa2o6J9xCgZJzOb14AImfJeclJtpFgBhWkuHTihBgSxiLqGJ9Xi8c8oEgPnt9eviRm
 WRi24L29awdJnzyKcGsCjhaFjPkuA/z1jlxNs4GwptJ3j5QE6P4g2DO+eYrjh6l2GT25
 fDons5yfd7ZjlL3oo8PHbgeTTa8fcc/8uXYlZLN/OcyryF80T1tcCXILNtxNBdc8kk7R
 1BFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=rLt3e0hI/eZ5dLp6vWtmVMpb8Frs6XxfQeKeBZLZRzw=;
 b=nlv6q58aBNZpHD+oIwUMv6pDkaQ4ZPftHc8CY5itkIBECAz8QehnVIGMlcmVQJWUNe
 iUL795PvsmhYQhENVUkHd4N04heAB12oLz7ggyrSY0FuTDtdyEZDxQgtbxZ0tm9mNXX6
 /j92Ih7uWMiSDi5CMx9HxKcIDBB7dIzZnSoYDmZ1qMGmbpYOftHe6QOPNmEHqYN51aOH
 QOQdK1Pnk/7pNQnRjstuKkLxsyl9A5kjuebzuMvl704JHjDCK3Iq9R3tZlnkGJfCX4EE
 uAmopsLr+CmgNrDpIf1ws66z63QUB0TEM2+/3cUJ+gQFeLUDukzXH/uZNGB1LtoeBdyA
 LXMw==
X-Gm-Message-State: AOAM531TsNErB5QyMj21v64j4BodX1h7yQa5nUHSPVsVu68OGR665zkf
 WTuUdQdhQuQ5scu3DM3Nc4pq/JCb/Klk0mkOiWA=
X-Google-Smtp-Source: ABdhPJzP7MBZZcXgpvh/HhqUwjyTNHJZz9JuYZdadHXiUvFHKIxmlTn7bEzMrtM3AMotOzgqwMSfddN3HSYc9A2ABEU=
X-Received: by 2002:a6b:8dd1:: with SMTP id
 p200mr32366991iod.118.1594142999622; 
 Tue, 07 Jul 2020 10:29:59 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1593547870.git.alistair.francis@wdc.com>
 <bd1e09bc3c721bf92e3f0e3e260d0f548acbce8f.1593547870.git.alistair.francis@wdc.com>
 <3e856aa3-9142-feae-3259-3936b47bef17@amsat.org>
In-Reply-To: <3e856aa3-9142-feae-3259-3936b47bef17@amsat.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 7 Jul 2020 10:20:11 -0700
Message-ID: <CAKmqyKPgvDDhbG-qX-TO+xLLGwKyTYBqDTvmC=hY4WYABZPD7A@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] hw/char: Convert the Ibex UART to use the qdev
 Clock model
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::d41;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd41.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jul 3, 2020 at 12:42 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
>
> +Damien
>
> On 6/30/20 10:12 PM, Alistair Francis wrote:
> > Conver the Ibex UART to use the recently added qdev-clock functions.
>
> Yeah! This is our first user \o/

:)

>
> >
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > ---
> >  include/hw/char/ibex_uart.h |  2 ++
> >  hw/char/ibex_uart.c         | 19 ++++++++++++++++++-
> >  2 files changed, 20 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/hw/char/ibex_uart.h b/include/hw/char/ibex_uart.h
> > index 2bec772615..322bfffd8b 100644
> > --- a/include/hw/char/ibex_uart.h
> > +++ b/include/hw/char/ibex_uart.h
> > @@ -101,6 +101,8 @@ typedef struct {
> >      uint32_t uart_val;
> >      uint32_t uart_timeout_ctrl;
> >
> > +    Clock *f_clk;
> > +
> >      CharBackend chr;
> >      qemu_irq tx_watermark;
> >      qemu_irq rx_watermark;
> > diff --git a/hw/char/ibex_uart.c b/hw/char/ibex_uart.c
> > index 45cd724998..f967e6919a 100644
> > --- a/hw/char/ibex_uart.c
> > +++ b/hw/char/ibex_uart.c
> > @@ -28,6 +28,7 @@
> >  #include "qemu/osdep.h"
> >  #include "hw/char/ibex_uart.h"
> >  #include "hw/irq.h"
> > +#include "hw/qdev-clock.h"
> >  #include "hw/qdev-properties.h"
> >  #include "migration/vmstate.h"
> >  #include "qemu/log.h"
> > @@ -330,7 +331,7 @@ static void ibex_uart_write(void *opaque, hwaddr ad=
dr,
> >          }
> >          if (value & UART_CTRL_NCO) {
> >              uint64_t baud =3D ((value & UART_CTRL_NCO) >> 16);
>
> UART_CTRL_NCO is defined as:
>
>   #define UART_CTRL_NCO           (0xFFFF << 16)
>
> Note for later, convert to the clearer registerfields API?

Done, I have added a patch to do this.

>
> > -            baud *=3D 1000;
> > +            baud *=3D clock_get_hz(s->f_clk);
> >              baud >>=3D 20;
> >
> >              s->char_tx_time =3D (NANOSECONDS_PER_SECOND / baud) * 10;
> > @@ -385,6 +386,18 @@ static void ibex_uart_write(void *opaque, hwaddr a=
ddr,
> >      }
> >  }
> >
> > +static void ibex_uart_clk_update(void *opaque)
> > +{
> > +    IbexUartState *s =3D opaque;
> > +
> > +    /* recompute uart's speed on clock change */
> > +    uint64_t baud =3D ((s->uart_ctrl & UART_CTRL_NCO) >> 16);
> > +    baud *=3D clock_get_hz(s->f_clk);
> > +    baud >>=3D 20;
>
> Maybe worth to extract:
>
>   uint64_t ibex_uart_get_baud(IbexUartState *s)
>   {
>        uint64_t baud;
>
>        baud =3D ((s->uart_ctrl & UART_CTRL_NCO) >> 16);
>        baud *=3D clock_get_hz(s->f_clk);
>        baud >>=3D 20;
>
>        return baud;
>   }

Done.

>
> > +
> > +    s->char_tx_time =3D (NANOSECONDS_PER_SECOND / baud) * 10;
> > +}
> > +
> >  static void fifo_trigger_update(void *opaque)
> >  {
> >      IbexUartState *s =3D opaque;
> > @@ -444,6 +457,10 @@ static void ibex_uart_init(Object *obj)
> >  {
> >      IbexUartState *s =3D IBEX_UART(obj);
> >
> > +    s->f_clk =3D qdev_init_clock_in(DEVICE(obj), "f_clock",
> > +                                  ibex_uart_clk_update, s);
> > +    clock_set_hz(s->f_clk, 50000000);
>
> Can you add a definition for this 50 MHz value:

Done.

>
> Otherwise:
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Thanks!

Alistair

>
> > +
> >      sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->tx_watermark);
> >      sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->rx_watermark);
> >      sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->tx_empty);
> >
>

