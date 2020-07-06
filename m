Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D7FCC433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 16:24:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 088ED20720
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 16:24:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SJswZLFv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 088ED20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsTuw-0006ax-9M
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 12:24:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52172)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jsTta-0004Yw-PZ; Mon, 06 Jul 2020 12:23:06 -0400
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:43949)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jsTtY-0007W6-L4; Mon, 06 Jul 2020 12:23:06 -0400
Received: by mail-io1-xd41.google.com with SMTP id k23so39912206iom.10;
 Mon, 06 Jul 2020 09:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=ZCFsUgKWMHvjDffglxEwENbngV4NS85ssCNLB+uyOKU=;
 b=SJswZLFvxKUNl19tgpP9pnlvN/y2gsQha2ge8zsRL4LRd9lwtCWSkt0+RF1hAxJlRZ
 wvxy8wmDphGoq5KWwitWEDh5DN2Dyblo+9gqxtz4TFCXfRaNBH5BJ2q8WA7rFd8t2GSW
 wkVwZVVkuCjFoF+W+um5hWmkJAWLN7DkVzpIWc4wqoKm1bYRquQSt+wOKHXHSwhuba1h
 +fWv/8RPzK+nv5GiHl707mQ/IRX4ffMGOl46MDAtjiJ3sQ31lJ/BDxhWgigopIdDdkOl
 I6bS882r/k+WVtZ/bU5i5wcB2OxEe85eNm7j9YCPyjy+k/QA8eBb+BwygpQdIcMDkzyn
 N7YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=ZCFsUgKWMHvjDffglxEwENbngV4NS85ssCNLB+uyOKU=;
 b=QP2yLM9PlxGXDiQo2WKVvQGyZpPcC1V6RMoJ29SA4I3sN5KBAc27B2l8kyNvhFf/6A
 K3H/uCJe888QNj8Gb3i5sCvcuR3G36Kg7mmT3w2Lv/V6GmnjRH4U7WzVOR24SGbxNtS8
 GTFnXP4Z4qmF/Zrf81PrUlwGVE0aPGr2xKeWMCyDw9Yi0W/yKQMcG/Xtbi0MtIZt/b/o
 83obBOvh9B/0tbnl+w/x2baoKjWmqmtZUNv1ER1AQCAikkr/pcSClDEBiy9htTkj3L9M
 l2fcAhGRYYHGOXfqYU9EIEttAT3EytjeVq0JGbBqtcjjPFxvHvazovnMlZ7pGDTNoKcM
 lNXQ==
X-Gm-Message-State: AOAM532l6f+bfvBM5OLfcGjpp0TUlXvzY+hN1QcoIl3aifeFF/AeV747
 T/f+BfqAWOP2z6ZsN/KXAXvwQ6aFIVOELPAN89g=
X-Google-Smtp-Source: ABdhPJyMxcEKWgHqyXGjQC7edshOzxWyXa5rwxXI9sZnrZzKqcjcqWXyX3XcfmTSFQVGUb6RdGBmn4EYeFrJKfH/NtA=
X-Received: by 2002:a02:6c4c:: with SMTP id w73mr55307238jab.26.1594052582475; 
 Mon, 06 Jul 2020 09:23:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200705204630.4133-1-f4bug@amsat.org>
 <20200705204630.4133-9-f4bug@amsat.org>
In-Reply-To: <20200705204630.4133-9-f4bug@amsat.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 6 Jul 2020 09:13:15 -0700
Message-ID: <CAKmqyKOu9Wpu-9pZLCxdMZUHW2Ku=8BazzuTSpUba8=rRqDUWQ@mail.gmail.com>
Subject: Re: [PATCH v4 08/10] hw/sd/pl181: Replace disabled fprintf()s by
 trace events
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <alistair@alistair23.me>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Jul 5, 2020 at 1:51 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org=
> wrote:
>
> Convert disabled DPRINTF() to trace events and remove ifdef'ry.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/sd/pl181.c      | 26 +++++++++-----------------
>  hw/sd/trace-events | 10 ++++++++++
>  2 files changed, 19 insertions(+), 17 deletions(-)
>
> diff --git a/hw/sd/pl181.c b/hw/sd/pl181.c
> index f69488ebac..574500ce60 100644
> --- a/hw/sd/pl181.c
> +++ b/hw/sd/pl181.c
> @@ -17,15 +17,7 @@
>  #include "qemu/module.h"
>  #include "qemu/error-report.h"
>  #include "qapi/error.h"
> -
> -//#define DEBUG_PL181 1
> -
> -#ifdef DEBUG_PL181
> -#define DPRINTF(fmt, ...) \
> -do { printf("pl181: " fmt , ## __VA_ARGS__); } while (0)
> -#else
> -#define DPRINTF(fmt, ...) do {} while(0)
> -#endif
> +#include "trace.h"
>
>  #define PL181_FIFO_LEN 16
>
> @@ -158,7 +150,7 @@ static void pl181_fifo_push(PL181State *s, uint32_t v=
alue)
>      n =3D (s->fifo_pos + s->fifo_len) & (PL181_FIFO_LEN - 1);
>      s->fifo_len++;
>      s->fifo[n] =3D value;
> -    DPRINTF("FIFO push %08x\n", (int)value);
> +    trace_pl181_fifo_push(value);
>  }
>
>  static uint32_t pl181_fifo_pop(PL181State *s)
> @@ -172,7 +164,7 @@ static uint32_t pl181_fifo_pop(PL181State *s)
>      value =3D s->fifo[s->fifo_pos];
>      s->fifo_len--;
>      s->fifo_pos =3D (s->fifo_pos + 1) & (PL181_FIFO_LEN - 1);
> -    DPRINTF("FIFO pop %08x\n", (int)value);
> +    trace_pl181_fifo_pop(value);
>      return value;
>  }
>
> @@ -184,7 +176,7 @@ static void pl181_do_command(PL181State *s)
>
>      request.cmd =3D s->cmd & PL181_CMD_INDEX;
>      request.arg =3D s->cmdarg;
> -    DPRINTF("Command %d %08x\n", request.cmd, request.arg);
> +    trace_pl181_command_send(request.cmd, request.arg);
>      rlen =3D sdbus_do_command(&s->sdbus, &request, response);
>      if (rlen < 0)
>          goto error;
> @@ -201,16 +193,16 @@ static void pl181_do_command(PL181State *s)
>              s->response[2] =3D ldl_be_p(&response[8]);
>              s->response[3] =3D ldl_be_p(&response[12]) & ~1;
>          }
> -        DPRINTF("Response received\n");
> +        trace_pl181_command_response_pending();
>          s->status |=3D PL181_STATUS_CMDRESPEND;
>      } else {
> -        DPRINTF("Command sent\n");
> +        trace_pl181_command_sent();
>          s->status |=3D PL181_STATUS_CMDSENT;
>      }
>      return;
>
>  error:
> -    DPRINTF("Timeout\n");
> +    trace_pl181_command_timeout();
>      s->status |=3D PL181_STATUS_CMDTIMEOUT;
>  }
>
> @@ -262,11 +254,11 @@ static void pl181_fifo_run(PL181State *s)
>          s->status |=3D PL181_STATUS_DATAEND;
>          /* HACK: */
>          s->status |=3D PL181_STATUS_DATABLOCKEND;
> -        DPRINTF("Transfer Complete\n");
> +        trace_pl181_fifo_transfer_complete();
>      }
>      if (s->datacnt =3D=3D 0 && s->fifo_len =3D=3D 0) {
>          s->datactrl &=3D ~PL181_DATA_ENABLE;
> -        DPRINTF("Data engine idle\n");
> +        trace_pl181_data_engine_idle();
>      } else {
>          /* Update FIFO bits.  */
>          bits =3D PL181_STATUS_TXACTIVE | PL181_STATUS_RXACTIVE;
> diff --git a/hw/sd/trace-events b/hw/sd/trace-events
> index 5f09d32eb2..a87d7355fb 100644
> --- a/hw/sd/trace-events
> +++ b/hw/sd/trace-events
> @@ -62,3 +62,13 @@ milkymist_memcard_memory_write(uint32_t addr, uint32_t=
 value) "addr 0x%08x value
>  # pxa2xx_mmci.c
>  pxa2xx_mmci_read(uint8_t size, uint32_t addr, uint32_t value) "size %d a=
ddr 0x%02x value 0x%08x"
>  pxa2xx_mmci_write(uint8_t size, uint32_t addr, uint32_t value) "size %d =
addr 0x%02x value 0x%08x"
> +
> +# pl181.c
> +pl181_command_send(uint8_t cmd, uint32_t arg) "sending CMD%02d arg 0x%08=
" PRIx32
> +pl181_command_sent(void) "command sent"
> +pl181_command_response_pending(void) "response received"
> +pl181_command_timeout(void) "command timeouted"
> +pl181_fifo_push(uint32_t data) "FIFO push 0x%08" PRIx32
> +pl181_fifo_pop(uint32_t data) "FIFO pop 0x%08" PRIx32
> +pl181_fifo_transfer_complete(void) "FIFO transfer complete"
> +pl181_data_engine_idle(void) "data engine idle"
> --
> 2.21.3
>
>

