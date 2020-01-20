Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FAB4C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 15:22:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 190C021D7E
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 15:22:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h4E4cun6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 190C021D7E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38612 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itYsw-0002we-9R
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 10:22:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49148)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groeck7@gmail.com>) id 1itYsG-0002My-LC
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 10:21:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groeck7@gmail.com>) id 1itYsE-0003YF-Fg
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 10:21:56 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:38563)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <groeck7@gmail.com>) id 1itYsE-0003Xl-9b
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 10:21:54 -0500
Received: by mail-pl1-x642.google.com with SMTP id f20so13308003plj.5
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2020 07:21:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=1jyHH4S0ZqGSYa8JeLqCuP1RGAdX7mumjjv4TgoI5xc=;
 b=h4E4cun6NuXbJcl+jd/RrzM7D254T69LyudTccQSbeeBmoW1I7HZCw+jIZT0+C3O3q
 19Br5mZQVnLNv/Z8TRtx63ylbM5sBs3SV6zW+paVFwDdbWUAA2rtyzrpHgYWdnpaitAc
 sf53MwBy3A7lu24gxL1vEaPvospuGucjJA2K6+xO5+9hc1+lAbyWJvp9p8YQLFDkeknr
 p5EpMGUaMFBpiIHB8NuXykEf3Rr5ypyJADDyzfmkrilRipY/lJ4NnQJjDWiA5c01XiwV
 nzfVg31TnKUWVxIW95nQz7c9x3vJ6nUP09z4Kb8mzlvVOQouACRvy6Wpwd6TM3gU58Al
 bYXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1jyHH4S0ZqGSYa8JeLqCuP1RGAdX7mumjjv4TgoI5xc=;
 b=sEgN3Ie2kuwQB1ZYUtdAUOUiC7U7DDzQ+Tqjr8C3vh+pC7Hd2DtKh+N/d5g/V9Kubo
 7vbEUgcrYnexLem5WH/ZM7dGg9DBDvnBv2lw6GVEsOCBe0kysjgKruBmc1n0iAC714IH
 kc7MJcsas6fc+7OuHKcWNpx5sapzIrBy1w6IEyKJE7o6SAtpxJMoDAgVlWsKRwNFF0dW
 nWT3XLn45T7jtXGT5DBrFoWIdbSWFPqJUkOQYa0z7snw/Z+XpRvELRRmPwXDMRovInZh
 CWpxxBajp828stKH7txZelZxorLNugMYNk4WG9n2NlixwatETQiULv9nut8NXdwySENi
 hDQw==
X-Gm-Message-State: APjAAAUv8+F3Z61H5VDWutX6SdvbSCPyMa8gp6omLTfX49r+xF134WpU
 WjY9mS+UBULNFPgw6Z9LBqBX9d8M
X-Google-Smtp-Source: APXvYqxDOQAmtj12hYpx3+QzNtp3vQrLRt47eSsYcucAtV2l9MGzl0p98WwBLMMKQN38ZggFBqwaaQ==
X-Received: by 2002:a17:90a:191a:: with SMTP id
 26mr23957325pjg.111.1579533712936; 
 Mon, 20 Jan 2020 07:21:52 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 m128sm39961663pfm.183.2020.01.20.07.21.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jan 2020 07:21:52 -0800 (PST)
Subject: Re: [PATCH] hw/core/or-irq: Fix incorrect assert forbidding num-lines
 == MAX_OR_LINES
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20200120142235.10432-1-peter.maydell@linaro.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <b9efc6f1-3250-7dee-691c-0454c66ea0ba@roeck-us.net>
Date: Mon, 20 Jan 2020 07:21:51 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200120142235.10432-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/20/20 6:22 AM, Peter Maydell wrote:
> The num-lines property of the TYPE_OR_GATE device sets the number
> of input lines it has. An assert() in or_irq_realize() restricts
> this to the maximum supported by the implementation. However we
> got the condition in the assert wrong: it should be using <=,
> because num-lines == MAX_OR_LINES is permitted, and means that
> all entries from 0 to MAX_OR_LINES-1 in the s->levels[] array
> are used.
> 
> We didn't notice this previously because no user has so far
> needed that many input lines.
> 
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   hw/core/or-irq.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/core/or-irq.c b/hw/core/or-irq.c
> index 18d63831cd3..2be18333811 100644
> --- a/hw/core/or-irq.c
> +++ b/hw/core/or-irq.c
> @@ -58,7 +58,7 @@ static void or_irq_realize(DeviceState *dev, Error **errp)
>   {
>       qemu_or_irq *s = OR_IRQ(dev);
>   
> -    assert(s->num_lines < MAX_OR_LINES);
> +    assert(s->num_lines <= MAX_OR_LINES);
>   
>       qdev_init_gpio_in(dev, or_irq_handler, s->num_lines);
>   }
> 


