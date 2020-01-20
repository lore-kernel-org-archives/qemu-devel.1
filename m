Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DC37C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 15:05:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59F1D217F4
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 15:05:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V01x6T8r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59F1D217F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itYcR-000553-Gm
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 10:05:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46491)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groeck7@gmail.com>) id 1itYbM-0004O3-5F
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 10:04:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groeck7@gmail.com>) id 1itYbK-0005Xu-Rw
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 10:04:28 -0500
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:35875)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <groeck7@gmail.com>)
 id 1itYbK-0005Wq-Ke; Mon, 20 Jan 2020 10:04:26 -0500
Received: by mail-pl1-x643.google.com with SMTP id a6so13307755plm.3;
 Mon, 20 Jan 2020 07:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=cYUk/Z+LI4FyIdL08VbriZzU+9iNDeTdDsGeICvgo90=;
 b=V01x6T8r57HynFK1kZrKhycbc0ey8uC8+YsOJeMC8E+cizfNzEdJYLSDYOTvMdBg9o
 4qIdopyrg/SFeI7VcAIHgsAYxe3gC+mlj+UaDwl0H+T6Ge11JROgeZLNFHgfCPXULSCj
 HEEZIoZQdkTnpy5MoVcugA4ylPE9FVz4O5ABC9EDXy8/AWYqw8HEYVFBsH08+J00c4nH
 v9jk7FrrL8iKu15hHos9NonyM/YE3RG0weqxycmJlcna5AOvD9K4jFucpSCgwp7o2zSC
 LuwXWsRpKP3UkVnqSfHVG77PsucHrSmwso53MJXjRrBiHLjm3HcRbjd9DDxsrO4Na0bt
 5m4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=cYUk/Z+LI4FyIdL08VbriZzU+9iNDeTdDsGeICvgo90=;
 b=WmuS1qcDDhV7Q1yxOh8u8eSpdLwm3xM2f5wGv3G3Hm0nXG9hQ2zuCofvADWVcgcSdN
 klFwmHwrCtxyy861Xo7aEbnBIZPp65t3Bij1XWPngUMU5iZdHUIFVvggn98qNufNHxBc
 ldinmGo2n7a5jOydpDM4i4X2o8Y5oi9zziXAq8d0z/gqL4wxYJz5vt+MQEvMfWk2LwQ+
 6FwIcOOR4JAw8Al3nFRIGbAyzUqVT/rPtNLyvvEYRzbfXvcHhGawLQPl6cnHpM2dmtng
 BSVsZbYOa2S9tZ5W2oC8GLYCTyQp6rxXbYRhWSxkMZl6dK4FiyB+IefcSWC/GXWILAdp
 +HnA==
X-Gm-Message-State: APjAAAXicL/SygBptg+dPd0iuy6OynQu30ncX7iqNOCDe7e/gxQCImCH
 SWVT2/FcBYb6x2aEDHptfK9zM/uU
X-Google-Smtp-Source: APXvYqwkqxJkKKpkoycmbjEDIzC6IF5/8ahrvtKfi6GQGv7c5mDJGntbbzWIhKdDvKpGA8ji/GB39w==
X-Received: by 2002:a17:90a:7f01:: with SMTP id
 k1mr23694091pjl.81.1579532665263; 
 Mon, 20 Jan 2020 07:04:25 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 q15sm37952828pgi.55.2020.01.20.07.04.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jan 2020 07:04:23 -0800 (PST)
Subject: Re: [PATCH v2 5/7] hw/char/exynos4210_uart: Implement Rx FIFO level
 triggers and timeouts
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200118164229.22539-1-linux@roeck-us.net>
 <20200118164229.22539-6-linux@roeck-us.net>
 <CAFEAcA9kK7mK=FQRKc0sDL8rZzibYov9Xm__+-MA06ERCotZ1Q@mail.gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <23f499e3-aaf3-c079-b850-04cb4c7e3b5e@roeck-us.net>
Date: Mon, 20 Jan 2020 07:04:22 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9kK7mK=FQRKc0sDL8rZzibYov9Xm__+-MA06ERCotZ1Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::643
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

On 1/20/20 5:58 AM, Peter Maydell wrote:
> On Sat, 18 Jan 2020 at 16:42, Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> The driver already implements a receive FIFO, but it does not
>> handle receive FIFO trigger levels and timeout. Implement the
>> missing functionality.
>>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>> v2: Call exynos4210_uart_rx_timeout_set() from new post_load function
>>      to set the receive timeout timer.
>>      Add timer to vmstate_exynos4210_uart.
>>
>>   hw/char/exynos4210_uart.c | 122 ++++++++++++++++++++++++++++++--------
>>   hw/char/trace-events      |   3 +-
>>   2 files changed, 99 insertions(+), 26 deletions(-)
> 
> Since the timeout value depends on s->wordtime, and
> exynos4210_uart_update_parameters() can change s->wordtime,
> do you need to recalculate the timeout at that point?
> This would correspond to if the guest wrote to the
> UBRDIV/UFRACVAL/ULCON registers, I think. Maybe this comes
> under the heading of "undefined behaviour if the guest does
> this odd thing" ? (The exact behaviour of the h/w is probably
> undocumented and mildly painful to emulate exactly, so it's
> hard to see why QEMU should care about getting it exactly right.)
> 
> I did also wonder whether writing the same value to the UCON
> timeout-interval field repeatedly really does restart the timer
> counting down from 8*(N+1) frames again, but again maybe that's
> just weird for a guest to do.
> 

The datasheet only talks about the number of word times that is set
with the UCON register. It doesn't say what the hardware does
if the word time (baud rate) is changed while data is in the receive
queue. But then data in the receive queue suggests that the remote
end is actively transmitting, and changing the baud rate in that
situation would result in a mess. With that in mind, I don't think
we need to be concerned about an inaccurate word time for a few
milliseconds after a baud-rate change.

I agree that changing the UCON value might not have an impact
on data already in the queue. I'll drop that call - I would guess
that HW doesn't bother recalculating anything when UCON is set
(changed or not), and it doesn't really matter, so why bother
with the extra code.

>> @@ -553,6 +620,7 @@ static const VMStateDescription vmstate_exynos4210_uart = {
>>                          vmstate_exynos4210_uart_fifo, Exynos4210UartFIFO),
>>           VMSTATE_UINT32_ARRAY(reg, Exynos4210UartState,
>>                                EXYNOS4210_UART_REGS_MEM_SIZE / sizeof(uint32_t)),
>> +        VMSTATE_TIMER_PTR(fifo_timeout_timer, Exynos4210UartState),
>>           VMSTATE_END_OF_LIST()
>>       }
>>   };
> 
> Unfortunately you can't simply add entries to a VMStateDescription:
> it breaks migration compatibility.
> 
> The choices here are:
>   * the nicest approach if it works is that in the post_load
> function you just recalculate the timer timeout. Then there's
> no need to migrate the current state of the timer. (In fact
> it looks like your code does do this in post_load.)


Correct, and that was the idea. The rest is just a lack of
understanding, so I'll drop VMSTATE_TIMER_PTR.

Thanks,
Guenter

