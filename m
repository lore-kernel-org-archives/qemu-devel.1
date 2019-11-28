Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9213C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 01:57:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABE93215F1
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 01:57:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABE93215F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ia93w-0005H4-BH
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 20:57:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40915)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ia92Y-0003xd-RM
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 20:56:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ia92W-0004cZ-MN
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 20:56:18 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:34712)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ia92S-0004Uc-Qj
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 20:56:14 -0500
Received: by mail-yw1-f65.google.com with SMTP id l14so6380542ywh.1
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2019 17:56:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=9USG4mgpvp0dd6xIcahnoYauzfXdRp/3eI0e3G+vWkc=;
 b=lagI3LRsWxnhl9Fp7nB63Frbt7Cd4pfJuCR7CjuNFh+Txop1ZynpXu3t87V0GS19OH
 +5BsJl6mAH9Y5DBJrht7vI7wK7ua6e2VC5G3PaOuZAgrdyoItLCnvEq7yLtSNcNM5hNf
 5LKX9nUIXOL1YPWDQ5OiVlRN6MActLjykNywQaHOTZN8Uq2x+d9YWfD9i+4aYSNF2+x5
 iivlMbsDRrsrazKOVgw506fD1AfGwhUexMuKZzcEW2YHj+obvc4eb4qajSLPSFlM46Uj
 Jvun3CXVHLzWFET358mtR9p57bFe9oCyd7GY+OUYlVuU0VEXwGk5QP5cbNUfdO40WWP8
 dTgg==
X-Gm-Message-State: APjAAAXvvR3sOu49eyuGTGVPGV1MrEz42F71BgzPE69PXtnTzVz/U0xH
 35uNjkm9DdM/8IzrjXdz9Lpb3IDEuYqp6GYDuOQJJg==
X-Google-Smtp-Source: APXvYqw+M2OGyfhS8cAGEzpZB7aKDuDFrO+TU3HJawB8mxxjaEu/NdeE7pgL6nn2ZIobCPNYXOw9LCurvYphAm82eBU=
X-Received: by 2002:a81:c609:: with SMTP id l9mr5187929ywi.37.1574906165422;
 Wed, 27 Nov 2019 17:56:05 -0800 (PST)
MIME-Version: 1.0
References: <20191128015030.27543-1-f4bug@amsat.org>
 <20191128015030.27543-7-f4bug@amsat.org>
In-Reply-To: <20191128015030.27543-7-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 28 Nov 2019 02:55:54 +0100
Message-ID: <CAAdtpL4mscutkOxXxORJXGd-OeWEtnAGeCy4LY8RG7YuqtEi+Q@mail.gmail.com>
Subject: Re: [RFC PATCH 06/10] hw/avr: Add ATmega microcontrollers
To: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Michael Rolnik <mrolnik@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.161.65
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
Cc: Sarah Harris <S.E.Harris@kent.ac.uk>, Igor Mammedov <imammedo@redhat.com>,
 Thomas Huth <huth@tuxfamily.org>, Joaquin de Andres <me@xcancerberox.com.ar>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pavel Dovgalyuk <dovgaluk@ispras.ru>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Nov 28, 2019 at 2:50 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
>
> Add famous ATmega MCUs:
>
> - middle range: ATmega168 and ATmega328
> - high range: ATmega1280 and ATmega2560
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/avr/atmega.h      |  58 +++++++
>  hw/avr/atmega.c      | 379 +++++++++++++++++++++++++++++++++++++++++++
>  hw/avr/Makefile.objs |   1 +
>  3 files changed, 438 insertions(+)
>  create mode 100644 hw/avr/atmega.h
>  create mode 100644 hw/avr/atmega.c
>
> diff --git a/hw/avr/atmega.h b/hw/avr/atmega.h
> new file mode 100644
> index 0000000000..d22d90a962
> --- /dev/null
> +++ b/hw/avr/atmega.h
> @@ -0,0 +1,58 @@
> +/*
> + * QEMU ATmega MCU
> + *
> + * Copyright (c) 2019 Philippe Mathieu-Daud=C3=A9
> + *
> + * This work is licensed under the terms of the GNU GPLv2 or later.
> + * See the COPYING file in the top-level directory.
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef HW_AVR_ATMEGA_H
> +#define HW_AVR_ATMEGA_H
> +
> +#include "hw/char/avr_usart.h"
> +#include "hw/char/avr_usart.h"

Oops duplicated header.

> +#include "hw/timer/avr_timer16.h"
> +#include "hw/misc/avr_mask.h"
> +#include "target/avr/cpu.h"
[...]

