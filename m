Return-Path: <SRS0=5EQe=UZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBF1CC48BD3
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 18:42:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6A1620663
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 18:42:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jy/AlKv8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6A1620663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgCro-0003nI-12
	for qemu-devel@archiver.kernel.org; Wed, 26 Jun 2019 14:42:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44253)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hgCfd-0001aL-HP
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 14:29:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hgCfb-00083d-GQ
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 14:29:25 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:43719)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hgCfZ-00080X-QI
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 14:29:21 -0400
Received: by mail-wr1-x442.google.com with SMTP id p13so3852209wru.10
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2019 11:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=xOZcadB5JBrL4YNeHrB2j2WnVJKKBRMPVf+Uhla9LtI=;
 b=Jy/AlKv85FwKt7qMSacreQfttl9Ma2Xl48dyd6q36MqZzf8+VqIbKwZUIRCWWPrq4C
 vEfEB7J1ep9TEdKNWe7k7Gf+bV2QP7CFbqneaWFyhn6zFk9wQcVs1FIXKDkD20xhVVeC
 Xx9V/TnAU8yZYiowWLwk+IyvC/BzVo15ddC3WzqmYrkAkgKliLyijkPExmH7IWKRedVf
 gdHzIrEnfo9PkJUnOgNcJ37jNBLeOzSyEBvstPpxEaOPt9AyEwo04n8kcp/iZ7R+O49y
 WowlYtc9NhDQ/5LqlIpErPRUuAM8wNWWDDo/qVIyNFNIAdPgA8ltQ77PVnIfZqU34j1u
 YlGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=xOZcadB5JBrL4YNeHrB2j2WnVJKKBRMPVf+Uhla9LtI=;
 b=D3aXG6FuFrPcxtrBX9qEhO6OFysQNBF2NNOKkz/Pc/VtNEH9jK6pSFGuFAArPL83hP
 M2Nc+kMoyJdDc2FMeWnsYtR9wzIAp1TyXio9sUpTMeR3F6g+yxps9l4E+/464cubyClu
 2afr5sxi0lmqnsor53ue2RZOEa5+IvtMxdiXgckLeYjcHM3KzEZDKSYUJ9R46K682h7m
 jXRa+fERYCZgfDeYSoTgl8xMGFOOxeyirvp5eAfUhKfLkJb3pHQxwHwmO/6Gn73Cvm25
 JbyiM7vuzTqpjm07Gz6/NyuVqj8jUeqWjdcvwDoZdaRSO0ixIlndQKJCdcJiQEuKt9AM
 DcRQ==
X-Gm-Message-State: APjAAAVNgdJqkbFlZUeK2MBiVTys9FZGy1TCLL5yfTEp9wROTMQaEiLO
 ZQPvNNRTTzEUUDX6cWLKtBLPkg==
X-Google-Smtp-Source: APXvYqwj3J9vldM1OJeSEG7ifv5wKdjnSe88Xy2fxkZHAOT9aPQ9AjDraZUgro41FEFa9opqJuw/GQ==
X-Received: by 2002:a5d:4090:: with SMTP id o16mr4924537wrp.292.1561573758852; 
 Wed, 26 Jun 2019 11:29:18 -0700 (PDT)
Received: from [192.168.2.137] (93-34-153-63.ip50.fastwebnet.it.
 [93.34.153.63])
 by smtp.gmail.com with ESMTPSA id a81sm3478214wmh.3.2019.06.26.11.29.17
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 26 Jun 2019 11:29:18 -0700 (PDT)
To: David Gibson <david@gibson.dropbear.id.au>
References: <20190519041522.12327-1-richard.henderson@linaro.org>
 <8f28d008-2608-a579-7505-4546b08deb41@linaro.org>
 <085d6881-f518-9888-a13e-081cdc09de46@ilande.co.uk>
 <0b9f4772-37f6-1453-e4ea-5ad9d0f52a5b@ilande.co.uk>
 <acc57487-c8a0-9380-bc2a-4de22541eabf@ilande.co.uk>
 <CAL1e-=iavFqEeFuNm2efVM7mu5OaABBVo90wqJEhmoWa4DQv=Q@mail.gmail.com>
 <ffae3651-5daf-e008-6562-2de09d82ace9@linaro.org>
 <b8aab3f4-e3eb-a137-62b4-ba5ac1a2ad8f@ilande.co.uk>
 <68facefc-b801-4902-11c0-4542662bfc4e@linaro.org>
 <20190626083344.GC2410@umbus.BigPond>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <7dde0d63-955b-017e-2af0-93d39d8bf31c@linaro.org>
Date: Wed, 26 Jun 2019 17:25:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190626083344.GC2410@umbus.BigPond>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: Re: [Qemu-devel] [PATCH v4 0/7] tcg/ppc: Add vector opcodes
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
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 Howard Spoelstra <hsp.cat7@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/26/19 10:33 AM, David Gibson wrote:
>>> out of curiosity: is your Power9 system BE or LE?
>>
>> The Power9 is LE.
> 
> It's the kernel determines endianness, not the system.

Yes.  Lazy verbiage on my part -- I did mean "The Power9 that I have access to
is configured as LE".


r~

