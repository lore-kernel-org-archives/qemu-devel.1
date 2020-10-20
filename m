Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94E65C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 20:27:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D074522247
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 20:27:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gshesgkw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D074522247
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUyDm-0008Rt-Ct
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 16:27:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53502)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kUyD0-00080j-Cr
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 16:26:14 -0400
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642]:33702)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kUyCv-0007AU-LM
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 16:26:13 -0400
Received: by mail-ej1-x642.google.com with SMTP id c22so4720027ejx.0
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 13:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=/OiOZPnRXROviYwjP5xO4b4/d9l1A4zUf6PAHUUUyAA=;
 b=gshesgkwlkMum2z/Y+1rfsGpqYlpNyiDFMYnjW3vFejR/x9a1hXW92er1YZ57dQAgK
 RwiiaLlZ7vZ1Bkvx8DRpaAqwExyaoEMzApYMAiSYDVEKPV4YV11Q2KnoiLTG+lWdctrQ
 g3WyB9hWynWbXFt1dSOTgcNrPcRYKFlrWbbib2ZjF+op+fuezebh+/85LdsTcoGB3ezR
 BQ+EPsQXv8WgRiMnKpyJaG9eDXJglFlsMk0HxyS1QGHjQQTLx6Rbx5G6z3KRe08eqJqF
 2ILQ5lyK3y6SqySy1CpJDlEmkMc875fyGWC0bVBkxa1EDgChg0T7f1mNCD0MIWPokpsC
 Oa7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=/OiOZPnRXROviYwjP5xO4b4/d9l1A4zUf6PAHUUUyAA=;
 b=a9VlKbGBJ2c/KlmGx6/edEwiCPMDo1RuveKY7lZ2BD7T+UkOsLEHv+lAbZqyZQl+AS
 YTU4sc3vPyLV/ZgHDI6+oFwycQbnC2mi9iah4qvWNQWfLK2VdYDzjMiHjgH74eKFk1bP
 D4k9OFI9nv0+f/MEXQRM+gwQKdIAoJL5FYS93h8C3n2AACdBIc0qnZukIASFBwtxAITR
 AHpfz0FRH0vtVryB9D1JMztOtxrVXL8pTG8zEOfbzUjdyhldqGxYCk+uLHiuCCSei2vN
 4OuXQ4XmBNqudfaUmowuXLun6LGi5axPXlXEAgrTMhMDzk+JgtnRaLQwXz1CZeadRKcg
 U5eg==
X-Gm-Message-State: AOAM5336fiaF8EkXYqMOrVbNsWC0895o/agsRqJxHjxPYskhzAdsLxeL
 fSfGzb70mnsOydKiL22DJlQRNFXhTUpm6UexezCaMNRFxqo=
X-Google-Smtp-Source: ABdhPJy1CInQzayAusHT+1xrUlyFhV5Duz95hP69pOcTFMc9Tz50+ROE2M8HOrgF6rAK3OFFGdFA6STHNzNbWt9eij4=
X-Received: by 2002:a17:906:af8d:: with SMTP id
 mj13mr57800ejb.85.1603225565705; 
 Tue, 20 Oct 2020 13:26:05 -0700 (PDT)
MIME-Version: 1.0
References: <20201020182008.2240590-1-f4bug@amsat.org>
 <20201020182008.2240590-5-f4bug@amsat.org>
In-Reply-To: <20201020182008.2240590-5-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Oct 2020 21:25:54 +0100
Message-ID: <CAFEAcA_SjX3OVof0A1fOWNkVT8wc9QEmA=3Wj2RgRKZNMFbQqg@mail.gmail.com>
Subject: Re: [RFC PATCH 4/4] hw/clock: Inline and remove CLOCK_PERIOD_TO_NS()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::642;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x642.google.com
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
Cc: Damien Hedde <damien.hedde@greensocs.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 20 Oct 2020 at 19:20, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
>
> This macro is only used once. Inline caring about 64-bit
> multiplication, and remove it.
>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  include/hw/clock.h | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/include/hw/clock.h b/include/hw/clock.h
> index b58038f1e7d..f329fcf0ea5 100644
> --- a/include/hw/clock.h
> +++ b/include/hw/clock.h
> @@ -16,6 +16,7 @@
>
>  #include "qom/object.h"
>  #include "qemu/queue.h"
> +#include "qemu/host-utils.h"
>
>  #define TYPE_CLOCK "clock"
>  OBJECT_DECLARE_SIMPLE_TYPE(Clock, CLOCK)
> @@ -38,7 +39,6 @@ typedef void ClockCallback(void *opaque);
>   * macro helpers to convert to hertz / nanosecond
>   */
>  #define CLOCK_PERIOD_FROM_NS(ns) ((ns) * (CLOCK_PERIOD_1SEC / 1000000000=
llu))
> -#define CLOCK_PERIOD_TO_NS(per) ((per) / (CLOCK_PERIOD_1SEC / 1000000000=
llu))
>  #define CLOCK_PERIOD_FROM_HZ(hz) (((hz) !=3D 0) ? CLOCK_PERIOD_1SEC / (h=
z) : 0u)
>
>  /**
> @@ -210,9 +210,14 @@ static inline uint64_t clock_get_hz(Clock *clk)
>      return CLOCK_PERIOD_1SEC / clk->period;
>  }
>
> -static inline unsigned clock_get_ns(Clock *clk)
> +static inline uint64_t clock_get_ns(Clock *clk)
>  {
> -    return CLOCK_PERIOD_TO_NS(clock_get(clk));
> +    uint64_t lo, hi;
> +
> +    mulu64(&lo, &hi, clock_get(clk), 1000000000llu);
> +    divu128(&lo, &hi, CLOCK_PERIOD_1SEC);
> +
> +    return lo;
>  }

I think the clock_get_ns() function is still flawed
regardless of its return type or internal implementation.
If you have a 2GHz clock then the correct answer is
"0.5" and so an integer representation is going to be
wrong by 0.5ns. If the reason why you wanted the period
in nanoseconds was so you could multiply it by a number
of ticks in order to work out when to set a timer, you
cannot live with the error resulting from rounding it
either way. We need to replace this function with one
which does the whole job of "tell me how many nanoseconds
X ticks of this clock will take" and does the entire
calculation so it can do it without introducing rounding errors.

thanks
-- PMM

