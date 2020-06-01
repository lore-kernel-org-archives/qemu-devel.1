Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B3DAC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 23:33:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39D79206A4
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 23:33:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d5oP0kW2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39D79206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jftwG-0007M1-Ej
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 19:33:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41710)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jftvB-0006Ju-64
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 19:32:45 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:41853)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jftv9-0002Zg-Cb
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 19:32:44 -0400
Received: by mail-pg1-x542.google.com with SMTP id r10so4188991pgv.8
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2020 16:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=3NwXwaOS4bsl4n64jesA4Ntvw9Lu2J0ZgAaVflE9IRY=;
 b=d5oP0kW20S4B7cQ8gpULDFqaqsY6aVZGA8+82sIrRAoVUG9y4GgYqlVck3yPM6lhn7
 tj2q2kJP42IqwceX5xUT5/kSSGVKPeFpCiPm7AUjOJdTL4+i9d+Bttkaquea0m7t4+rb
 9bKMMlJwKR/jfQRKjHVizb/pJQX7VkrI0aGnwI7Gt5mGQHuS1L9Ct9/UnGmrhOiF+dGP
 wwdbEVkim5DZWLw7Yr1vq77KmKd/TIRp2JF9KSYcSM3x0qvqQZ/t1GySPGT56pUHxM8r
 aw2qNVcpAj6oQo0Y28GzhXnpXWhItpw6hLjwug4B72tlV9agIZKGXdBzW0kebxS0kwJB
 Do+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=3NwXwaOS4bsl4n64jesA4Ntvw9Lu2J0ZgAaVflE9IRY=;
 b=ox334IPXFDGUOWZlcPUED2muDHayIZ+F2nSWixKgIIIk15rpovIFRxj8Alk7XV0CpR
 /JRX5jQTaASX25awMDeL+0KF50qDgFhZ3h3FfC6Kh0+2yy2Nz2vVYGGbdY/GirBLrBYy
 dY+gx3Vw9yAex/7tVLJ+Z/vilAfQBwpufsQ+tndcxjqp82/AjHjZBuvRrbR9F9jsS3AH
 258Rfr6Uo5SpsYvtmO21GoU1MGOz80gCvKh54ielAuFg9CFoJK+EdosorV5h+RbdeM1E
 TIbUqlv2sYkRq1QS8pdTE8b+6FcP3BJygC1A7eu5VT+WKtt/zydowZ+xBiUY6RZxfj11
 2mBA==
X-Gm-Message-State: AOAM533n9jZCun6rQFc8FSpBzA6+Wl38SeCJjrW/IOpz2EKKC6FciCQn
 mSTDlo4eos6yBvXlv6E71hFsgV5/Upk=
X-Google-Smtp-Source: ABdhPJwZpI+SacycOQ6MIqBEfSiWb14Ne5GD33mPOLukHNtq8QkxuDqyS1yDjYRvl3lkOBNsnwX/Cw==
X-Received: by 2002:a63:7519:: with SMTP id q25mr20874424pgc.224.1591054361018; 
 Mon, 01 Jun 2020 16:32:41 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id 191sm424256pfy.161.2020.06.01.16.32.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Jun 2020 16:32:40 -0700 (PDT)
Subject: Re: [PATCH v2 9/9] target/arm: Convert Neon
 one-register-and-immediate insns to decodetree
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200522145520.6778-1-peter.maydell@linaro.org>
 <20200522145520.6778-10-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <eb20b110-d91f-21f7-8726-d254a828b0df@linaro.org>
Date: Mon, 1 Jun 2020 16:32:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200522145520.6778-10-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x542.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/22/20 7:55 AM, Peter Maydell wrote:
> Convert the insns in the one-register-and-immediate group to decodetree.
> 
> In the new decode, our asimd_imm_const() function returns a 64-bit value
> rather than a 32-bit one, which means we don't need to treat cmode=14 op=1
> as a special case in the decoder (it is the only encoding where the two
> halves of the 64-bit value are different).
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/neon-dp.decode       |  22 ++++++
>  target/arm/translate-neon.inc.c | 118 ++++++++++++++++++++++++++++++++
>  target/arm/translate.c          | 101 +--------------------------
>  3 files changed, 142 insertions(+), 99 deletions(-)


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

because this is a faithful transliteration of the existing code, but...

> +    switch (cmode) {
> +    case 0: case 1:
> +        /* no-op */
> +        break;
> +    case 2: case 3:
> +        imm <<= 8;
> +        break;
> +    case 4: case 5:
> +        imm <<= 16;
> +        break;
> +    case 6: case 7:
> +        imm <<= 24;
> +        break;
> +    case 8: case 9:
> +        imm |= imm << 16;
> +        break;
> +    case 10: case 11:
> +        imm = (imm << 8) | (imm << 24);
> +        break;

It might be clearer to use dup_const for each case, which would more closely
match the pseudocode.  E.g. here,

    return dup_const(MO_16, imm << 8);

> +        imm |= (imm << 8) | (imm << 16) | (imm << 24);

    return dup_const(MO_8, imm);

Something to remember for a follow-up.

r~

