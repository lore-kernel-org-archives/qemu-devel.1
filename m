Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 287B2C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 17:55:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA9A92070B
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 17:55:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hpHnV+Ls"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA9A92070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k07Lp-0000T3-6M
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 13:55:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54194)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k07L9-0008Nm-Je
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 13:55:07 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:39178)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k07L8-0007Ah-07
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 13:55:07 -0400
Received: by mail-ed1-x542.google.com with SMTP id o10so3118928edh.6
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2020 10:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=06SP/IDbSf0dJbkYRbmzHYhBapz318XpXh3ZSgUWrAE=;
 b=hpHnV+Ls91nvvzYySt98kHHT5RRIq2KH0owxDBUMzpdnSx82NYixTz7P+MRaMckS3u
 tmwQ5WK6mFdEDCMpz/LkHcHaHk7SZ7k7s2/ULzYZloy8b7xFY/Fm9/nVvg0cp92pGJxP
 xWaF2s0leN7nMAhpjiicNW4R0Gm+CwNm/v+pH9OUqqwhNj7w986sml31wmuFPuhzYgxp
 Y0ZV85aVTFiean9p7PaEg+uVYVhevUstT3JiIuAdXq3Fa0bC8pToW1sBvzn7p3QAd8Bg
 X2EJJvETvOyIsNlTMCIIserkWeLkfiyhr0AyFcBiJV8WWMkb6moYuv5Vcc1nkgQQM89K
 5apA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=06SP/IDbSf0dJbkYRbmzHYhBapz318XpXh3ZSgUWrAE=;
 b=LoGPaDxZRxGmPTBk+IByndpDyqWt7TOwP+rHHI9pTkDo+M5L4Y3iMGoqug/W99zIi0
 a2Mxq1fuy7ysEChqTqigo34HHRJprvUr0etqSj7tuq5GwRtaRr4ZoGyYdcL+InKNyZsN
 ZXZyF0DC4VOAGJ9oNkHj9wV1S2mCL4enRdiWjZl7p/SVe3wW5P9I4Y4bYDZNRxu4efbn
 msog8AV23wC2FJWAZ8Jq4DUy3ESAMv4Li8RAqQwBScF2wyWxmOeu9WuWUyD+vegRUUQv
 06gTe6NHtkKpek9B1Um9O9OP0pvDihzQ2N2PHWdxWvn2SEvvUcSJRAOzTqrIOLEI8jWt
 IxJA==
X-Gm-Message-State: AOAM5300kJ+MNSSB9VLmguVrZYba2MvzF2Uuncl5CEmtxzpMiwy+3YLZ
 T/iBKGURciGhdLbfRJt2LJw=
X-Google-Smtp-Source: ABdhPJzyEAoWJJVUvivUdIe1c6e4CtDfVER83Mm7p7RaeELlAxx51Y78HQ74Bp6FAu30b8+opLO5sw==
X-Received: by 2002:aa7:c450:: with SMTP id n16mr21982571edr.53.1595872504455; 
 Mon, 27 Jul 2020 10:55:04 -0700 (PDT)
Received: from [192.168.1.39] (214.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.214])
 by smtp.gmail.com with ESMTPSA id d19sm7326625ejk.47.2020.07.27.10.55.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jul 2020 10:55:03 -0700 (PDT)
Subject: Re: [PATCH v3] hw/core/qdev: Increase qdev_realize() kindness
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20200707033326.19178-1-f4bug@amsat.org>
 <4e472f6a-e6b3-910b-97fe-0526d1f560a1@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <f8505888-abe4-5f55-0ff0-b167064909a8@amsat.org>
Date: Mon, 27 Jul 2020 19:55:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <4e472f6a-e6b3-910b-97fe-0526d1f560a1@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::542;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ed1-x542.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/7/20 11:47 AM, Paolo Bonzini wrote:
> On 07/07/20 05:33, Philippe Mathieu-Daudé wrote:
>> Since commit 510ef98dca5, qdev_realize() aborts if bus-less device
>> is realized on a bus. While commits 514db7710b..007d1dbf72 took
>> care of converting all mainstream uses, QEMU forks weren't. These
>> forks are usually maintained by hobbyist with interest in following
>> mainstream development, but with limited time, so usually rebase
>> from time to time. To avoid them to spend time on debugging and
>> reading git-log history, display a kind hint about what is wrong.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>> Since v2:
>> - scratch __func__ (armbru)
>> - reword to justify this is not an impossible case (armbru)
>> ---
>>  hw/core/qdev.c | 7 +++++--
>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
>> index 2131c7f951..a16f1270f1 100644
>> --- a/hw/core/qdev.c
>> +++ b/hw/core/qdev.c
>> @@ -392,8 +392,11 @@ bool qdev_realize(DeviceState *dev, BusState *bus, Error **errp)
>>  
>>      if (bus) {
>>          qdev_set_parent_bus(dev, bus);
>> -    } else {
>> -        assert(!DEVICE_GET_CLASS(dev)->bus_type);
>> +    } else if (DEVICE_GET_CLASS(dev)->bus_type) {
>> +        error_setg(errp, "Unexpected bus '%s' for bus-less device '%s'",
>> +                   DEVICE_GET_CLASS(dev)->bus_type,
>> +                   object_get_typename(OBJECT(dev)));
>> +        return false;
>>      }
>>  
>>      object_property_set_bool(OBJECT(dev), true, "realized", &err);
>>
> 
> Queued, thanks.

Thanks! I haven't see that and sent a v4 with example included &
typo fixed, if possible can you take it instead?
https://patchew.org/QEMU/20200727175112.6820-1-f4bug@amsat.org/

> 
> Paolo
> 
> 

