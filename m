Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3755C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 07:43:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82293206B6
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 07:43:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uDtAwF/1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82293206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrGLm-000343-Pf
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 03:43:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40880)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jrGLB-0002bq-Vt; Fri, 03 Jul 2020 03:42:34 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:50244)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jrGLA-0002dK-EM; Fri, 03 Jul 2020 03:42:33 -0400
Received: by mail-wm1-x342.google.com with SMTP id l17so31056562wmj.0;
 Fri, 03 Jul 2020 00:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=OcGtQhJRMUZfDgXX7pdu/Iotiu0PoVya/fQ4Kmv2YdE=;
 b=uDtAwF/1Uz90P+mkoX3UQK/2w/3maBZhn0kPIq0w500ed+nCqDbbnGScBmebLq0Hpx
 7SzuNsvHT86Q8j/FlfrKkgX1TNWNHWC+1oGi4qqq5mztTVZpRu5YhtMsnq1hv+fBp4J8
 yYtKau1L6/MrRD5rPmnfUOC0oCW7Nhf+TDrCyWL3x5slJEIfJwTczSletYqEltOY+p1a
 QNySocFVgEBpX76BBWFlFS6WpnFMz77BAx0hHBhsWsJ1sA19uwbpkLp/SX4FeH+hpoK/
 S/RVdhMykhR6tVoFXLQFfxIHI5R6pXFDc5H0y3+M0qSzR/swSugFuzExcapWsW53aqPR
 Ir+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=OcGtQhJRMUZfDgXX7pdu/Iotiu0PoVya/fQ4Kmv2YdE=;
 b=PrUSI4vFNGMKMC83gebguB2X1ZKvumoNcCc15U40koERn9i+YshNChvcZK3ZXO/0Wn
 iSS67Fh1ii1SigaJAlHo5AeuijuO6epnKvZDEJ8YZSJALaYBqWbKjRkm8+ow2ixG1P/J
 RFOTWv2ZlBYrewNvVNbqpPS05M2MIv36/BfxzdWKdhR4Y7Coe6crpBdjLm/eE+uMImu+
 NnK2oZbnjERxwmmPiIvPx3niLHAo4XWpgmQGpP04zcI2flbI4No5mb+lEC10mSvwRmpw
 yl4ZUlVT5QLEt1RA15DyqvUy2Rcnk/oSO0jSdI4SehP/LslaMPW4+7z5UVSTZ4LhpO7I
 t3AQ==
X-Gm-Message-State: AOAM530afrFwbJ0ZJxhHVfJeZwpFIxSiNzxDGA+11qv2ZzOR8jkQYUKa
 OOFoEWZYjwzGITQaD8odIt4=
X-Google-Smtp-Source: ABdhPJxPaJMJhkKZHGUTHvNN8gNXcDDtlMHpCmheKMp0+2GmflgRfcpvd5bzn45S7LK/L8iuiyLxxw==
X-Received: by 2002:a1c:f203:: with SMTP id s3mr34232460wmc.126.1593762150570; 
 Fri, 03 Jul 2020 00:42:30 -0700 (PDT)
Received: from [192.168.1.39] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id q188sm12712397wma.46.2020.07.03.00.42.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Jul 2020 00:42:29 -0700 (PDT)
Subject: Re: [PATCH v1 1/3] hw/char: Convert the Ibex UART to use the qdev
 Clock model
To: Alistair Francis <alistair.francis@wdc.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
References: <cover.1593547870.git.alistair.francis@wdc.com>
 <bd1e09bc3c721bf92e3f0e3e260d0f548acbce8f.1593547870.git.alistair.francis@wdc.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <3e856aa3-9142-feae-3259-3936b47bef17@amsat.org>
Date: Fri, 3 Jul 2020 09:42:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <bd1e09bc3c721bf92e3f0e3e260d0f548acbce8f.1593547870.git.alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Damien Hedde <damien.hedde@greensocs.com>, alistair23@gmail.com,
 palmer@dabbelt.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

+Damien

On 6/30/20 10:12 PM, Alistair Francis wrote:
> Conver the Ibex UART to use the recently added qdev-clock functions.

Yeah! This is our first user \o/

> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  include/hw/char/ibex_uart.h |  2 ++
>  hw/char/ibex_uart.c         | 19 ++++++++++++++++++-
>  2 files changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/include/hw/char/ibex_uart.h b/include/hw/char/ibex_uart.h
> index 2bec772615..322bfffd8b 100644
> --- a/include/hw/char/ibex_uart.h
> +++ b/include/hw/char/ibex_uart.h
> @@ -101,6 +101,8 @@ typedef struct {
>      uint32_t uart_val;
>      uint32_t uart_timeout_ctrl;
>  
> +    Clock *f_clk;
> +
>      CharBackend chr;
>      qemu_irq tx_watermark;
>      qemu_irq rx_watermark;
> diff --git a/hw/char/ibex_uart.c b/hw/char/ibex_uart.c
> index 45cd724998..f967e6919a 100644
> --- a/hw/char/ibex_uart.c
> +++ b/hw/char/ibex_uart.c
> @@ -28,6 +28,7 @@
>  #include "qemu/osdep.h"
>  #include "hw/char/ibex_uart.h"
>  #include "hw/irq.h"
> +#include "hw/qdev-clock.h"
>  #include "hw/qdev-properties.h"
>  #include "migration/vmstate.h"
>  #include "qemu/log.h"
> @@ -330,7 +331,7 @@ static void ibex_uart_write(void *opaque, hwaddr addr,
>          }
>          if (value & UART_CTRL_NCO) {
>              uint64_t baud = ((value & UART_CTRL_NCO) >> 16);

UART_CTRL_NCO is defined as:

  #define UART_CTRL_NCO           (0xFFFF << 16)

Note for later, convert to the clearer registerfields API?

> -            baud *= 1000;
> +            baud *= clock_get_hz(s->f_clk);
>              baud >>= 20;
>  
>              s->char_tx_time = (NANOSECONDS_PER_SECOND / baud) * 10;
> @@ -385,6 +386,18 @@ static void ibex_uart_write(void *opaque, hwaddr addr,
>      }
>  }
>  
> +static void ibex_uart_clk_update(void *opaque)
> +{
> +    IbexUartState *s = opaque;
> +
> +    /* recompute uart's speed on clock change */
> +    uint64_t baud = ((s->uart_ctrl & UART_CTRL_NCO) >> 16);
> +    baud *= clock_get_hz(s->f_clk);
> +    baud >>= 20;

Maybe worth to extract:

  uint64_t ibex_uart_get_baud(IbexUartState *s)
  {
       uint64_t baud;

       baud = ((s->uart_ctrl & UART_CTRL_NCO) >> 16);
       baud *= clock_get_hz(s->f_clk);
       baud >>= 20;

       return baud;
  }

> +
> +    s->char_tx_time = (NANOSECONDS_PER_SECOND / baud) * 10;
> +}
> +
>  static void fifo_trigger_update(void *opaque)
>  {
>      IbexUartState *s = opaque;
> @@ -444,6 +457,10 @@ static void ibex_uart_init(Object *obj)
>  {
>      IbexUartState *s = IBEX_UART(obj);
>  
> +    s->f_clk = qdev_init_clock_in(DEVICE(obj), "f_clock",
> +                                  ibex_uart_clk_update, s);
> +    clock_set_hz(s->f_clk, 50000000);

Can you add a definition for this 50 MHz value:

Otherwise:
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> +
>      sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->tx_watermark);
>      sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->rx_watermark);
>      sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->tx_empty);
> 


