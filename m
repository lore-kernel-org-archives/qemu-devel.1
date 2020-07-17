Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DAF7C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 10:12:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0726120768
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 10:12:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W6ukRsZE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0726120768
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwNM4-00053C-7Z
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 06:12:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33340)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jwNLU-0004Xn-Ah; Fri, 17 Jul 2020 06:12:00 -0400
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642]:41026)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jwNLS-0004YZ-OS; Fri, 17 Jul 2020 06:12:00 -0400
Received: by mail-ej1-x642.google.com with SMTP id dp18so10126962ejc.8;
 Fri, 17 Jul 2020 03:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:from:to:cc:references:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=MiaGGuHRj9CoYm71mUC/aGHvvZl0DNRa+HzlAMs0/3E=;
 b=W6ukRsZEUXKKEomvMA39xFdeOGMqla9Rw+V7x+sqkR9PCxhdFl+bXF8r+MQq+WsYKz
 ruK9Kvx6unQXNre4WueA7rLyBGaWX9qJv3/hIL/ijxWd2UkGpGBmMfCmSxeDtKNqJXPf
 ViYysgcxycyYvz/Ch7aMYOPOwI133oDdY+JYrhda/ZJ5RIijNUMuviSD3B1SzXu7jBFx
 PSiZ0LrnSru6gKd9nwXNLhGioajt1CWh1Sz9QDIyZjNJg6V9u5IbjiPQdmabLVQnkz7e
 W7LI/yTJqB9d1RV3p7OkogrDJbIiwYIKWaWF7ijXfbued3w7b8hOYWaeGF6yWU3Wqnjt
 jzsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:from:to:cc:references:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=MiaGGuHRj9CoYm71mUC/aGHvvZl0DNRa+HzlAMs0/3E=;
 b=BbyhS1cf1YtoWTf6C9U0cBG+WTIv+OCe2uGGW4otB2iu9BOsuuHSPe49w/GCFXuQXb
 1peekIqQm6o1vHVsGnhabFqbYUD2xWNVbSifLhgX5SYYBtFcbyd6Is8M8bDv4D0KV8Me
 FJYZmD1ukpgRQ7/J4pelF1sJxK5bj+y8nMaF+l4XcXqKlk/i59C5XEyi551xP6n+9OGX
 wVLE+zyktRFAvVS2hWqAWIN1r43kj5c5a9IMJNeW8K6Vb1jSF7lmRH4xQmGy2SRQRpA0
 P03yRxl1H371yTLGNviO2D3xP4RlBmKeQ5OluyDORBd86U8qJhY2ia4bxCNR++wGMhLV
 0zaw==
X-Gm-Message-State: AOAM5312ocBblp5JaFq7TsLVHlnafx5//gSNpe3NkI2ZH5nuprc3fNfy
 10NDXHL4fq9fRyuKNld+cr96F4oIuNU=
X-Google-Smtp-Source: ABdhPJzyQeO4XPhIpNev2P0sYU9nbAk/OKPgSK2EGerIioJdzym2EVpBeawyGllAyIktNS39U2yOrA==
X-Received: by 2002:a17:906:80d3:: with SMTP id
 a19mr8222301ejx.217.1594980716674; 
 Fri, 17 Jul 2020 03:11:56 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id se16sm7568384ejb.93.2020.07.17.03.11.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Jul 2020 03:11:56 -0700 (PDT)
Subject: Re: [RFC PATCH-for-5.1 v2] hw/ide: Cancel pending DMA requests before
 setting as inactive
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
References: <20200717075317.5376-1-f4bug@amsat.org>
 <639c1f19-ed12-14cb-72ab-d49e63fb2741@amsat.org>
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
Message-ID: <9e29a292-b9c0-d086-01f0-478cad6e5cf3@amsat.org>
Date: Fri, 17 Jul 2020 12:11:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <639c1f19-ed12-14cb-72ab-d49e63fb2741@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::642;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x642.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Alexander Bulekov <alxndr@bu.edu>, John Snow <jsnow@redhat.com>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/17/20 12:08 PM, Philippe Mathieu-Daudé wrote:
> On 7/17/20 9:53 AM, Philippe Mathieu-Daudé wrote:
>> libFuzzer found a case where requests are queued for later in the
>> AIO context, but a command set the bus inactive, then when finally
>> the requests are processed by the DMA it aborts because it is
>> inactive:
>>
>>  include/hw/ide/pci.h:59: IDEState *bmdma_active_if(BMDMAState *): Assertion `bmdma->bus->retry_unit != (uint8_t)-1' failed.
>>
>> Reproducer available on the BugLink.
>>
>> Fix by draining the pending DMA requests before inactivating the bus.
>>
> 

Sorry I also forgot:

Reported-by: Alexander Bulekov <alxndr@bu.edu>

> Fixes: 8ccad811e6 ("use AIO for DMA transfers - enabled DMA for CDROMs")
> 
>> BugLink: https://bugs.launchpad.net/qemu/+bug/1887303
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>> RFC because I don't have much clue about block drive and IDE,
>> so block-team please be very careful while reviewing this bug.
>> ---
>>  hw/ide/core.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/ide/core.c b/hw/ide/core.c
>> index d997a78e47..f7affafb0c 100644
>> --- a/hw/ide/core.c
>> +++ b/hw/ide/core.c
>> @@ -804,7 +804,7 @@ void dma_buf_commit(IDEState *s, uint32_t tx_bytes)
>>  
>>  void ide_set_inactive(IDEState *s, bool more)
>>  {
>> -    s->bus->dma->aiocb = NULL;
>> +    ide_cancel_dma_sync(s);
>>      ide_clear_retry(s);
>>      if (s->bus->dma->ops->set_inactive) {
>>          s->bus->dma->ops->set_inactive(s->bus->dma, more);
>>
> 

