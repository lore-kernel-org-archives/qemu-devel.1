Return-Path: <SRS0=E5X6=CV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 351B3C433E2
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2020 13:32:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9332207FB
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2020 13:32:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qtpRewov"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9332207FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kH5e7-0007Al-LO
	for qemu-devel@archiver.kernel.org; Sat, 12 Sep 2020 09:32:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51126)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kH5dS-0006dn-4w; Sat, 12 Sep 2020 09:32:10 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:52293)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kH5dQ-0006hp-76; Sat, 12 Sep 2020 09:32:09 -0400
Received: by mail-wm1-x341.google.com with SMTP id q9so6769691wmj.2;
 Sat, 12 Sep 2020 06:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:from:to:cc:references:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=XJQaMaCmLCQvncVq5hvrfa6umvUKwL4ARCWJF1LRGGk=;
 b=qtpRewovMFHrqN7HW5agKvoBjXLhRQpU80JY7/H1oZ/aO2Jvh3otCVwEypGytRhCgV
 k4u3/BIRh07VzmOElrKaeti3qqukovvIb9FRcTP+vceHFOzqW+JgrbsFEUqthI9EKbOV
 DnA9kWFjyPg1pcqvLC6UIcGOMz77kPrPqgkVfEXaS8i2Q3dnivXPY9z52VBllioqfLgq
 Ibzup0+FhAy7mXmuou4FRKvVlHE9iRgTD0gaJN4LcncG5mh/5yVfjcOpgfSD06EbEk3m
 3kEuHU1Yi4qELGE7w1GkzloS4ovAckgpNnJ1xkstrtVPPQqAQoxVY4cmhisZMw6LLuVr
 n8pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:from:to:cc:references:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=XJQaMaCmLCQvncVq5hvrfa6umvUKwL4ARCWJF1LRGGk=;
 b=onwNMc50Pe4V2rIy3w4Fu+t/6BbXhzo43ygYYa1eiSYJuZOqIrkLFzoOGelnly/tUR
 Ei9oSTse/ILJDQzAKxAfzZNJkxqpfst3tDxCIVxQuER8yN7cnehndLtsNoR33jpZgu1O
 niMmHjXge/dTTAWiCSrRjB56NdgB6MdrMBmuWaSz1C6pShRaEFu0RugMHS3ZfDzDMLuN
 6aInB68ZEhewWpnp055oLWXEGwtsF7386xdlWoTmyzOnOckKxiG6WJT8YwWJ+lBcENnQ
 2QIUT/+k7Vn7L8tge90Polr3nvhZYZDQM/H4LrFWH/9LiCSwy1fR5+VB54sCeAvbLz8S
 RwuQ==
X-Gm-Message-State: AOAM531JI8hN0ugAhv5Avc3JK/Dg9aGGgGQsUxEtwQF9gYiYtuovK9yg
 b+gDTa8BqNYnWi/1bBcJmpM=
X-Google-Smtp-Source: ABdhPJy9d6zeXRCj9Qa2qSbGzpPgnVHjzUCC65Zja+gMUO7odLGAWPAUiYEq+1cS+vzZpUMVgO5nEQ==
X-Received: by 2002:a7b:c5c1:: with SMTP id n1mr6620602wmk.125.1599917526011; 
 Sat, 12 Sep 2020 06:32:06 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id t202sm10448364wmt.14.2020.09.12.06.32.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 12 Sep 2020 06:32:05 -0700 (PDT)
Subject: Re: [PATCH v5 2/7] hw/misc/led: Allow connecting from GPIO output
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <20200910205429.727766-1-f4bug@amsat.org>
 <20200910205429.727766-3-f4bug@amsat.org>
 <071b68a6-58e4-0d68-e056-ee7ae19e2227@linaro.org>
 <db55f80e-ca2d-d432-134b-a05333a7e124@amsat.org>
Autocrypt: addr=f4bug@amsat.org; keydata=
 mQINBDU8rLoBEADb5b5dyglKgWF9uDbIjFXU4gDtcwiga9wJ/wX6xdhBqU8tlQ4BroH7AeRl
 u4zXP0QnBDAG7EetxlQzcfYbPmxFISWjckDBFvDbFsojrZmwF2/LkFSzlvKiN5KLghzzJhLO
 HhjGlF8deEZz/d/G8qzO9mIw8GIBS8uuWh6SIcG/qq7+y+2+aifaj92EdwU79apZepT/U3vN
 YrfcAuo1Ycy7/u0hJ7rlaFUn2Fu5KIgV2O++hHYtCCQfdPBg/+ujTL+U+sCDawCyq+9M5+LJ
 ojCzP9rViLZDd/gS6jX8T48hhidtbtsFRj/e9QpdZgDZfowRMVsRx+TB9yzjFdMO0YaYybXp
 dg/wCUepX5xmDBrle6cZ8VEe00+UQCAU1TY5Hs7QFfBbjgR3k9pgJzVXNUKcJ9DYQP0OBH9P
 ZbZvM0Ut2Bk6bLBO5iCVDOco0alrPkX7iJul2QWBy3Iy9j02GnA5jZ1Xtjr9kpCqQT+sRXso
 Vpm5TPGWaWljIeLWy/qL8drX1eyJzwTB3A36Ck4r3YmjMjfmvltSZB1uAdo1elHTlFEULpU/
 HiwvvqXQ9koB15U154VCuguvx/Qnboz8GFb9Uw8VyawzVxYVNME7xw7CQF8FYxzj6eI7rBf2
 Dj/II6wxWPgDEy3oUzuNOxTB7sT3b/Ym76yOJzWX5BylXQIJ5wARAQABtDFQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoRjRCVUcpIDxmNGJ1Z0BhbXNhdC5vcmc+iQJVBBMBCAA/AhsPBgsJ
 CAcDAgYVCAIJCgsEFgIDAQIeAQIXgBYhBPqr514SkXIh3P1rsuPjLCzercDeBQJd660aBQks
 klzgAAoJEOPjLCzercDe2iMP+gMG2dUf+qHz2uG8nTBGMjgK0aEJrKVPodFA+iedQ5Kp3BMo
 jrTg3/DG1HMYdcvQu/NFLYwamUfUasyor1k+3dB23hY09O4xOsYJBWdilkBGsJTKErUmkUO2
 3J/kawosvYtJJSHUpw3N6mwz/iWnjkT8BPp7fFXSujV63aZWZINueTbK7Y8skFHI0zpype9s
 loU8xc4JBrieGccy3n4E/kogGrTG5jcMTNHZ106DsQkhFnjhWETp6g9xOKrzZQbETeRBOe4P
 sRsY9YSG2Sj+ZqmZePvO8LyzGRjYU7T6Z80S1xV0lH6KTMvq7vvz5rd92f3pL4YrXq+e//HZ
 JsiLen8LH/FRhTsWRgBtNYkOsd5F9NvfJtSM0qbX32cSXMAStDVnS4U+H2vCVCWnfNug2TdY
 7v4NtdpaCi4CBBa3ZtqYVOU05IoLnlx0miKTBMqmI05kpgX98pi2QUPJBYi/+yNu3fjjcuS9
 K5WmpNFTNi6yiBbNjJA5E2qUKbIT/RwQFQvhrxBUcRCuK4x/5uOZrysjFvhtR8YGm08h+8vS
 n0JCnJD5aBhiVdkohEFAz7e5YNrAg6kOA5IVRHB44lTBOatLqz7ntwdGD0rteKuHaUuXpTYy
 CRqCVAKqFJtxhvJvaX0vLS1Z2dwtDwhjfIdgPiKEGOgCNGH7R8l+aaM4OPOd
Message-ID: <db88c517-5762-47e3-310a-089df623d174@amsat.org>
Date: Sat, 12 Sep 2020 15:32:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <db55f80e-ca2d-d432-134b-a05333a7e124@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-1.543,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Andrew Jeffery <andrew@aj.id.au>, qemu-arm@nongnu.org,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Luc Michel <luc.michel@greensocs.com>,
 Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/12/20 10:50 AM, Philippe Mathieu-Daudé wrote:
> Eduardo is already in Cc, adding Markus.
> 
> On 9/12/20 12:44 AM, Richard Henderson wrote:
>> On 9/10/20 1:54 PM, Philippe Mathieu-Daudé wrote:
>>> Some devices expose GPIO lines.
>>>
>>> Add a GPIO qdev input to our LED device, so we can
>>> connect a GPIO output using qdev_connect_gpio_out().
>>>
>>> When used with GPIOs, the intensity can only be either
>>> minium or maximum. This depends of the polarity of the
>>> GPIO (which can be inverted).
>>> Declare the GpioPolarity type to model the polarity.
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>>> ---
>>>  include/hw/misc/led.h  |  8 ++++++++
>>>  include/hw/qdev-core.h |  8 ++++++++
>>>  hw/misc/led.c          | 17 ++++++++++++++++-
>>>  3 files changed, 32 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/include/hw/misc/led.h b/include/hw/misc/led.h
>>> index f5afaa34bfb..71c9b8c59bf 100644
>>> --- a/include/hw/misc/led.h
>>> +++ b/include/hw/misc/led.h
>>> @@ -38,10 +38,16 @@ typedef struct LEDState {
>>>      /* Public */
>>>  
>>>      uint8_t intensity_percent;
>>> +    qemu_irq irq;
>>>  
>>>      /* Properties */
>>>      char *description;
>>>      char *color;
>>> +    /*
>>> +     * When used with GPIO, the intensity at reset is related
>>> +     * to the GPIO polarity.
>>> +     */
>>> +    bool inverted_polarity;
>>
>> Why are you not using the GpioPolarity enum that you added?
> 
> Because it is migrated...

Luc made me realize we don't need to keep the enum in the device
state, a 'is_gpio_polarity_high' boolean is enough, so I don't
need to worry about migrating the enum.

https://www.mail-archive.com/qemu-devel@nongnu.org/msg739790.html

> 
> Using DEFINE_PROP_BOOL() is simpler that adding hardware specific
> enum visitor in hw/core/qdev-properties.c (which is included in
> user-mode builds because pulled by the CPU type).
> 
> A sane cleanup would be to make get_enum(), set_enum()
> and set_default_value_enum() public (prefixed with 'qdev_')
> in include/hw/qdev-properties.h.
> 
> Out of the scope of this series, but might be worth it.
> 
> Eduardo, Markus, what do you think?

This question still stands however :)

> 
> Thanks Richard for reviewing this series!
> 
> Phil.
> 

