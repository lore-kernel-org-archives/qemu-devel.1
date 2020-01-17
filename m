Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8D43C33CB1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 13:24:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1C74206B7
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 13:24:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oTgXrAgK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1C74206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isRcJ-0006wn-Jl
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 08:24:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47828)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1isRbT-00069E-Ts
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 08:24:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1isRbS-0007ul-MX
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 08:23:59 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:38028)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1isRbS-0007tx-Gn
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 08:23:58 -0500
Received: by mail-oi1-x244.google.com with SMTP id l9so22129642oii.5
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2020 05:23:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+zYS3Ud1rDBMQK54BEbf3637JZsB+MdOPqjMUZWYVTo=;
 b=oTgXrAgKu93y78nHno3/sYxNzUyyZcj7j18x93jXfFkjeJZrCGZLMbZn602Nf8WMsV
 2hs/uXRv/F/SAS5X9ZycgFNcDICR3Jn9K1Qzed1ZroBKqAIulc1O4f8oaxN+R2Igy6Ji
 PYytMGdvswT+MClLSKW5C8luW4PXoHiKkvqvWpZ7duN/5BBMCiBuOVXkaL9T0TNfboVd
 Mugm7UKR7uyuue93v6/G1D9CeiDRZfH8apLoajdE/92qmdX7Iha9uhqP+fLR1b3jPicC
 LrsrnLSIULjC7ruSsN5NXPz9PowFxQHO+LqCNqx7ePtrf4qZSER5w5lzih2AZVGx135o
 DYog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+zYS3Ud1rDBMQK54BEbf3637JZsB+MdOPqjMUZWYVTo=;
 b=duwbtrxAib1UJmH9fBxWNbMCKKh9q0AQp9+cSv2Q5p9MfqUcDCmHExoGcIuexgenIO
 gJNdD6Sen1BMnBRxeNPKqcatJCSnHprhzGQDRr6zVBfH5+ngxLyZwQLNFT82szZgSbI8
 1YwH3jYRrieaOI6UyU6vZLfDmvOoWr7MnTTLc7nFlUZDGqtRk6Dkl/hP8kA/Xxkf8lGg
 +OodC/wN7HZCojNvQqLMKr0nXTVog8041yjuvcZgdTwet0IPum6NtBEB/pHYkGQCpYma
 Hhd8XZ6dlF0579EWXFDS4Aoj1WkcAGGHf/uy+Rz5vGhzB/wo9buyAAVRAUwolm/x0Ma4
 XlIA==
X-Gm-Message-State: APjAAAXmExfpMLDVKcNlfN2tMLVK4X5tpCmHjqOcXLriMVh0rn+X1m7H
 3l5e5cy0Sez351xyd3pqJrinYQ2ozDMt1vvn+oDkRQ==
X-Google-Smtp-Source: APXvYqyqH3qPrXDpxCMo7ocDs9R5hor8HZk+8DTGrf27MfVxOr0NXByJQ+bVk2ZfBsqZDJ7TRVYnLtrFjOG6iQfr64c=
X-Received: by 2002:aca:f484:: with SMTP id s126mr3234670oih.48.1579267437500; 
 Fri, 17 Jan 2020 05:23:57 -0800 (PST)
MIME-Version: 1.0
References: <20200110203942.5745-1-linux@roeck-us.net>
 <20200110203942.5745-2-linux@roeck-us.net>
In-Reply-To: <20200110203942.5745-2-linux@roeck-us.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 17 Jan 2020 13:23:46 +0000
Message-ID: <CAFEAcA_k8xdzmsgMK+m6wSgnBN53UjCNU4nTBx=hnHnHz+Su6g@mail.gmail.com>
Subject: Re: [PATCH 1/6] dma/pl330: Convert to support tracing
To: Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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
>
> Replace debug logging code with tracing.
>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  hw/dma/pl330.c      | 88 +++++++++++++++++++++++----------------------
>  hw/dma/trace-events | 24 +++++++++++++

> +static void pl330_hexdump(uint8_t *buf, size_t size)
> +{
> +    unsigned int b, i, len;
> +    char tmpbuf[80];
> +
> +    for (b = 0; b < size; b += 16) {
> +        len = size - b;
> +        if (len > 16) {
> +            len = 16;
> +        }
> +        tmpbuf[0] = '\0';
> +        for (i = 0; i < len; i++) {
> +            if ((i % 4) == 0) {
> +                strcat(tmpbuf, " ");
> +            }
> +            sprintf(tmpbuf + strlen(tmpbuf), " %02x", buf[b + i]);
> +        }
> +        trace_pl330_hexdump(b, tmpbuf);
> +    }
> +}
>

> @@ -1175,11 +1186,8 @@ static int pl330_exec_cycle(PL330Chan *channel)
>          int len = q->len - (q->addr & (q->len - 1));
>
>          dma_memory_read(&address_space_memory, q->addr, buf, len);
> -        if (PL330_ERR_DEBUG > 1) {
> -            DB_PRINT("PL330 read from memory @%08" PRIx32 " (size = %08x):\n",
> -                      q->addr, len);
> -            qemu_hexdump((char *)buf, stderr, "", len);
> -        }
> +        trace_pl330_exec_cycle(q->addr, len);
> +        pl330_hexdump(buf, len);

Won't this now do all the work of constructing the hexdump strings,
even if tracing is disabled ?

thanks
-- PMM

