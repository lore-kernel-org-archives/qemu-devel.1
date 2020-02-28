Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53E04C3F2D4
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 18:55:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 291AB2072D
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 18:55:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jXTMPorO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 291AB2072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7knm-0005Ny-8L
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 13:55:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35695)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j7kn9-0004m9-04
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 13:55:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j7kn8-0004BL-2B
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 13:55:18 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:38295)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j7kn7-0004As-S1
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 13:55:18 -0500
Received: by mail-pg1-x542.google.com with SMTP id d6so1970246pgn.5
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 10:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=CaNPjxUdILAEisvzy2n3Tjs7R7KHUIriO4+JEcz7vKg=;
 b=jXTMPorOB5hKigES85YgOZpw8J+NV9/oFFNkrXp54XyhQ/F8OJKSQyD1iU9Knsr1aY
 1CQBE8kYC6s25TNsO3C4Q9ozFd1/EDgqVmQEn7pnpSgP9weuvIyaXLUIGR9+QhRwFdhS
 v7xX83g3LHrlQQpHT/WP2bSOOcIvcsqerP70uk50OSXpljTblM1d5JqN4ydqSmzrpRhG
 eBc+Yk06rYuB7F2eIvSrnb8Cs8bTCSYGrKj6yokpCabKpoAySn529gkI8xIJ+qXhIbWB
 wA4LlvRfOEs3OhckC8Rc+Oju5Aqd1YCt2FuGQ8TNYz9PB6Bp37WC6LXdrasDqlvgQfE7
 IxMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=CaNPjxUdILAEisvzy2n3Tjs7R7KHUIriO4+JEcz7vKg=;
 b=uL9lNPJuF8QybsME8kRGaCfQ+V11+fihN+KgEMtx1oDoN8G+XszY02ACoLZTECsFr7
 GjizLTxrTfbWNLuXgSogVbqkG+WeyIp3UMaW5mMvriTE4Go/IpUVqS6kAEpqBPpktD7x
 sFbOA+fqXVQ/K1xvnzeoe3arXw5WRWpQclQbfyB/hG+RiJkJQ++4z+05ICJKeM+hYeyR
 QI/bMS40/TFlmaaUgGJxSKpKQHRi/un4FrTvvgmjE2G0RML0rF45xCqE1+mtCXYtfoHY
 Am3eIjp05Gaor4e6OwHrjTgAFTQMXf5wp1Jmd08L7jEOHlAyPxJxahu2WDxk7PcKWh8K
 L9Eg==
X-Gm-Message-State: APjAAAVvk1RmDtPmM9eY8XbyC2BZhEI/Y8ff04QsWCuLLKcigDnKnWki
 OfIEIAi/jaudrj3OmXH/F6V2vQ==
X-Google-Smtp-Source: APXvYqyEWGlZXoG8kXmEe1cIRtMQFGzxvglz80WsvkmFEcloTrUkWE/UWdLCgQSGSOoV4C769nV5vw==
X-Received: by 2002:a65:404d:: with SMTP id h13mr5740036pgp.156.1582916116608; 
 Fri, 28 Feb 2020 10:55:16 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 q6sm11724367pfh.127.2020.02.28.10.55.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Feb 2020 10:55:15 -0800 (PST)
Subject: Re: [PATCH v4 1/7] target/arm: Improve masking of HCR RES0 bits
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200225180831.26078-1-richard.henderson@linaro.org>
 <20200225180831.26078-2-richard.henderson@linaro.org>
 <CAFEAcA8ipK0nZioEgbNq5B1L-tqA+rzn-C2yyfet4_4yNVnYqA@mail.gmail.com>
 <e4a70637-f4b7-eaa7-237a-57053c5a63cc@linaro.org>
 <CAFEAcA-8a4eQXf+LRS3KLURyyEPpPm9uh6q6r6D-1-sh3t8Pdw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <5c484ae5-b4da-8eae-c10a-547c670c89e5@linaro.org>
Date: Fri, 28 Feb 2020 10:55:14 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-8a4eQXf+LRS3KLURyyEPpPm9uh6q6r6D-1-sh3t8Pdw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/28/20 9:34 AM, Peter Maydell wrote:
> One of us is miscounting, and I don't *think* it's me...
> 
> bits 63..0:  ff80ff8c90000000
> bits 63..32: ff80ff8c
> bits 64..48: ff80
> 
> bit 48 looks like it's 0 to me.

Oops, yes, it's me.

> You could refine the valid mask as the & of the bits which we
> do want to exist in aarch32, rather than &~ of the reserved bits:
> 
>  valid_mask &= TTLBIS | TOCU | TICAB | ...
> 
> ?

Yes, that's a good idea.


r~

