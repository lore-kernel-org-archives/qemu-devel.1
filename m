Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04E84C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 17:38:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C464620656
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 17:38:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qtmEcpTs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C464620656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsV4O-0001M6-4B
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 13:38:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42988)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jsV3m-0000pI-AU; Mon, 06 Jul 2020 13:37:42 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:36122)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jsV3k-000541-LY; Mon, 06 Jul 2020 13:37:42 -0400
Received: by mail-wr1-x442.google.com with SMTP id k6so42075234wrn.3;
 Mon, 06 Jul 2020 10:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=IN1EoJ1z7gM6HRbBuDTCnQ/pgYx5LdPsdp2Sj7LcVwc=;
 b=qtmEcpTsJpxm1OHn2yMbQeYWs1H3o4azNaeBSDmW/L602jzJL9b4hjMfNqXTQchHWd
 AwxP59r20GEncAK5doJwlCjKxbkMT423/fmDYXDeUsjAe25Yt4M1ynDQxko84rTAIFKc
 Y/kFGu1x919VtabQQRh0ECV20RTtn0pFYwLl4zHjxLl5APTN4gnGyZnGcgTXN/4TPKnH
 mA8LF32KEmynHDE2umVybba7pGhofRkD63Rhhd30jxW7SXRDZTGtevP64TNAwfi9WqPn
 l0IOr1PkL6jy2DmEb1tfhJuI2+7i1l+4ACpS09X5WlkobI+jRzkO5FTBB5lAgDQEtpx3
 CnTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=IN1EoJ1z7gM6HRbBuDTCnQ/pgYx5LdPsdp2Sj7LcVwc=;
 b=nFpfpO/LvOcqEjCMhd6n2ypkDFYjvoV/t82rF/AMg3U1smBrbCGbV73Rqwr5B5pkMl
 pP1+/Wdge0qnckUm3D1CIrw2tfefbVDU8SNU/VJduMv2shwV8VfR30+PnC/N2wEAOk2I
 M0V/6CSiZyr5YIRbjGsE0ncVZFIstA7Ni8ogGddgR768c38ip4qy/SYHWU1wFiddRHuJ
 B+p5yazZhNlucIH4+SO6/MuODCwGxrFIOVuFT42Xco9+7o6DQbCzrH15nGFfRMbcQg7m
 YykgXI3qITNsDS3o5R4q0JULZltDHKm3tyrzDojZhpwuTkQlEfhweSDYGEfITkXoWeXF
 prvw==
X-Gm-Message-State: AOAM530WHAJ5w3aokL1rxV2ehmy8RyunA1Wl06xE/81IhGZ9K0gbzPBj
 2+DPM/em5wqthfRnZPikdYlxgiZM
X-Google-Smtp-Source: ABdhPJw5x94xS8UVvxasRjrIHXiCIeBc9luTcc5or0t4leJF+3Br56PqOhtOOHWsrUJ40OGmpYyYvw==
X-Received: by 2002:adf:ea4f:: with SMTP id j15mr16128394wrn.253.1594057057972; 
 Mon, 06 Jul 2020 10:37:37 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id f197sm180582wme.33.2020.07.06.10.37.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jul 2020 10:37:37 -0700 (PDT)
Subject: Re: [RFC PATCH 0/2] hw/sd: Deprecate the SPI mode and the SPI to SD
 adapter
To: Alistair Francis <alistair23@gmail.com>
References: <20200705220731.28101-1-f4bug@amsat.org>
 <CAKmqyKOR80ORZEdzDzi5YJX7+=fsyL+9_OJwUf-_O_nP9wZ6mA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <23f49280-4055-763b-1721-bcb8d132fb72@amsat.org>
Date: Mon, 6 Jul 2020 19:37:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAKmqyKOR80ORZEdzDzi5YJX7+=fsyL+9_OJwUf-_O_nP9wZ6mA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <huth@tuxfamily.org>,
 Alistair Francis <alistair@alistair23.me>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 libvir-list@redhat.com, qemu-arm <qemu-arm@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/6/20 6:41 PM, Alistair Francis wrote:
> On Sun, Jul 5, 2020 at 3:08 PM Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>>
>> I tried to maintain the SPI mode because it is useful in
>> tiny embedded devices, and thought it would be helpful for
>> the AVR MCUs.
>> As AVR was blocked, I thought it was wise to deprecate the
>> SPI mode as users are interested in the faster MMC mode.
>> Today Thomas surprised me by posting an update of it!
>> https://www.mail-archive.com/qemu-devel@nongnu.org/msg720089.html
>>
>> I'm still posting this as RFC to discuss, but I'm reconsiderating
>> keeping this mode a bit more.
> 
> I think it's worth keeping.
> 
> I'm pretty sure the HiFive Unleashed (sifive_u in QEMU) uses SD over
> SPI. There isn't an upstream model but I think there are out of tree
> patches that hopefully one day will make it upstream.

Glad to hear that! :)

> 
> Alistair
> 
>>
>> Philippe Mathieu-Daudé (2):
>>   hw/sd/ssi-sd: Deprecate the SPI to SD card 'adapter'
>>   hw/sd/sdcard: Deprecate the SPI mode
>>
>>  docs/system/deprecated.rst | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> --
>> 2.21.3
>>
>>
> 

