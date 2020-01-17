Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACCC3C33CB1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 13:45:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7944420663
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 13:45:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m+6qWSB1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7944420663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isRwb-0007hi-4t
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 08:45:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50226)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1isRu0-0005eh-OE
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 08:43:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1isRtz-0006oW-DI
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 08:43:08 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:42668)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1isRtz-0006nD-3x
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 08:43:07 -0500
Received: by mail-oi1-x241.google.com with SMTP id 18so22194483oin.9
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2020 05:43:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=SHjqrPiiAA/pjq37bbCBfMTIkCnkKIakDVz/jgpBkyM=;
 b=m+6qWSB1Hss8yp231rHDVzh3/WIOHh0omyX0zBfVjFHXDO2Xu/l6aHVrQ/t94AXavT
 iyl/g6WyUe9ccV71hOpchsSu2rIqdrrkZhAo8RmJdMhHEPO4uxBaOTqqXDHaAMwzXkdr
 AdJjHpUio/2R6svhh+poG+ZFPLv1HZo1IhFj2JHTlPInZNG5aGQHNVm3ZUuQdBXOIv+F
 o/70V1VazJwfgC2nho+cLRqM8XxwdBbUWoySuotCJj7f6rmvcIWFbB+nN8ghGXNt2ume
 XSjlPQTJfbJAffxVieCVP6DSHhcfrez0IA4Yvpt0gCz7KEd8hgYUhGX13JGdELERR/ZE
 IZow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=SHjqrPiiAA/pjq37bbCBfMTIkCnkKIakDVz/jgpBkyM=;
 b=fnliR34WqNiXZesZJXzpI5fRJfUp6Y0CS5ruR+EXjjkmgXHjzspMqpf3wMQLzBqqul
 9yGDy2F5KS321alA8v/ZXevJ2QVVXE4Rn4bQ7cs2nPLugo67+zRSGugUPIF9Z5pU5OgV
 1+j0I9ejgbB6TC3eEc4Xr40M+D2XG/yBzG6Peklr45OTmaqJbitMYcJfhwnGnhbrjPC9
 sQjoH3uPmGfVgACeXwKrxeuI5o5Z3YAW1pXGlkfWleA2ZUd1FF2Km8eC7eLi3bBpmIP0
 o6MQx48Shotz8YyOpJFMfsX2CgHL30nbIRozhqTo9m82I3q3WX4fM5UkY7F8+SirC4bY
 Qv2Q==
X-Gm-Message-State: APjAAAXRRoOmNDYmOzLM7Hl5qr6J+FrJcSo37bsFwTo6Eny67qp2bZR5
 zm4GYiUhQUfPg8AhmK3d7AQ5SxfG9YtjvpMgz7DKjQ==
X-Google-Smtp-Source: APXvYqwv96wcnEG7FkirsH6cmkx+ychmieDcfAQnBsGOOtxG7D0kUs0ob70H8AdY3UUsD2mfyZpHJ7YwC67tQvSI800=
X-Received: by 2002:aca:3182:: with SMTP id x124mr3500687oix.170.1579268585863; 
 Fri, 17 Jan 2020 05:43:05 -0800 (PST)
MIME-Version: 1.0
References: <20200110203942.5745-1-linux@roeck-us.net>
 <20200110203942.5745-5-linux@roeck-us.net>
In-Reply-To: <20200110203942.5745-5-linux@roeck-us.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 17 Jan 2020 13:42:54 +0000
Message-ID: <CAFEAcA81V46N8eqTtBo7YZE0kDaqVNz=iAjbqdv8m=GPRsaewg@mail.gmail.com>
Subject: Re: [PATCH 4/6] hw/char/exynos4210_uart: Implement receive FIFO
To: Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
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
Cc: Igor Mitsyanko <i.mitsyanko@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 10 Jan 2020 at 20:39, Guenter Roeck <linux@roeck-us.net> wrote:

The subject just says "implement receive FIFO", but the
existing code clearly has an "Exynos4210UartFIFO   rx"
which it does some storing and retrieving data from.
Could the patch be more accurately described as something
like "Implement interrupts for rx FIFO level triggers and
timeouts" ?

> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  hw/char/exynos4210_uart.c | 120 ++++++++++++++++++++++++++++++--------
>  hw/char/trace-events      |   3 +-
>  2 files changed, 97 insertions(+), 26 deletions(-)
>
> diff --git a/hw/char/exynos4210_uart.c b/hw/char/exynos4210_uart.c
> index fb7a3ebd09..61134a7bdc 100644
> --- a/hw/char/exynos4210_uart.c
> +++ b/hw/char/exynos4210_uart.c
> @@ -24,6 +24,7 @@
>  #include "migration/vmstate.h"
>  #include "qemu/error-report.h"
>  #include "qemu/module.h"
> +#include "qemu/timer.h"
>  #include "chardev/char-fe.h"
>  #include "chardev/char-serial.h"
>
> @@ -118,6 +119,7 @@ static const Exynos4210UartReg exynos4210_uart_regs[] = {
>  #define ULCON_STOP_BIT_SHIFT  1
>
>  /* UART Tx/Rx Status */
> +#define UTRSTAT_Rx_TIMEOUT              0x8
>  #define UTRSTAT_TRANSMITTER_EMPTY       0x4
>  #define UTRSTAT_Tx_BUFFER_EMPTY         0x2
>  #define UTRSTAT_Rx_BUFFER_DATA_READY    0x1
> @@ -147,6 +149,9 @@ typedef struct Exynos4210UartState {
>      ";
>      Exynos4210UartFIFO   tx;
>
> +    QEMUTimer *fifo_timeout_timer;
> +    uint64_t wordtime;        /* word time in ns */

You need to do something on incoming migration to handle
the new fields. This probably looks like a .post_load function
that calculates the wordtime based on the register values
that have been set by the incoming migration and set the
QEMUTimer appropriately.

(Side note while I'm thinking about it: this device has
an "Exynos4210UartFIFO tx" but it never does anything
with it except call fifo_reset() on it. We don't migrate
it either, which is a bit of a bear trap for anybody who
adds code that uses it in future...)

thanks
-- PMM

