Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AA96C31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 16:57:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B9B420652
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 16:57:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hcxD+5Mr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B9B420652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49746 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcux0-0004Ct-Ia
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 12:57:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58874)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hcuqd-0005c7-J3
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 12:51:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hcuqc-0005Dj-Ho
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 12:51:11 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:44038)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hcuqc-0005B3-6y
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 12:51:10 -0400
Received: by mail-pg1-x544.google.com with SMTP id n2so6127194pgp.11
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 09:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=6/HsInHIQ/Gxj1pg16SAz9Ev7OYfVZs1+akPoxG1yOI=;
 b=hcxD+5MrGPh3LZJq6Lyxr/sUDtt2li9IcfZZUR+C4IwbpMYH8N6d8yy8+zjn1DmBZc
 UJhwywZKG4ddcsrE1ffAiNDrDT7164iHnu20sXFJ31ix9m8AaV/14gszPvwFYr6hDrt2
 cnSVgRV4FOoBskqZ+mcCuBCpqf+0WNvHmsKiqO31zyIx6xfEfl014Lm8ocR0A3MuAUfX
 yDc8nwE0ltT+7rDBLLRFOErQDzZK77G0IjzcEHxtI1DcaCNj4FYyli0uSqmxWUV0tnYb
 aUUxTdX90V440097kCmvXonAqbgoS4TYD9PP5XZvOg0X3nAOIabk70MrBdwgSJ/xHbFJ
 8qiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6/HsInHIQ/Gxj1pg16SAz9Ev7OYfVZs1+akPoxG1yOI=;
 b=B72uYRT9EQBNNi72XRo/mZJc9xdZpOlUjkN5vjBteKIFnQ8FVOhEKeFCio3f9KXCMB
 gvVVp9vWJwUBSz/Hqa1snPLJiFd/hCnoiDtYW97HshJH3hyfOhz9syd3UwV+pRiPNCen
 R9LacaJRecxnBLW/d8jCmLbBEKvDIo57RpZTAEkNH8N1y7Y9f84m1f7PJs/UL3az2LWR
 QkyDZbvtElhshoyObSty+/TqiZwwEbiU9IF44J7k6cHkMnTcDCm9LikzpmwoRopLe94B
 C5hovOUgQolDWUOF7TXSJ00a8hb7OVuH1qqdWM9s9bW5e4GdDouWRYDtG3IVcPS8k+Bs
 NX5Q==
X-Gm-Message-State: APjAAAXpwC4qEX6BNPEHmHHwx+xuGA9eJ+ElaLQ1fE3UD1rLGAn0zROA
 wRlKGweedd1brB9ygLIj7ECt8w==
X-Google-Smtp-Source: APXvYqzarw64KGgrWBALcdo1a0FkXzR3yOWnZ1B8ZdTwNN1QklCB9OuiWdAoxU58JNRmrw8W4g0spw==
X-Received: by 2002:a17:90a:7107:: with SMTP id
 h7mr26613540pjk.38.1560790268783; 
 Mon, 17 Jun 2019 09:51:08 -0700 (PDT)
Received: from [192.168.1.11] (97-113-2-33.tukw.qwest.net. [97.113.2.33])
 by smtp.gmail.com with ESMTPSA id e127sm12807955pfe.98.2019.06.17.09.51.07
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 17 Jun 2019 09:51:08 -0700 (PDT)
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-devel@nongnu.org
References: <20190617143533.15013-1-kbastian@mail.uni-paderborn.de>
 <20190617143533.15013-4-kbastian@mail.uni-paderborn.de>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <f20e8434-f716-85df-faa0-5447fec6fdf0@linaro.org>
Date: Mon, 17 Jun 2019 09:51:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190617143533.15013-4-kbastian@mail.uni-paderborn.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
Subject: Re: [Qemu-devel] [PATCH 3/3] target/tricore: Use translate_loop
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
Cc: david.brenken@efs-auto.de
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/17/19 7:35 AM, Bastian Koppelmann wrote:
> +static void tricore_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
> +{
> +    DisasContext *ctx = container_of(dcbase, DisasContext, base);
> +    CPUTriCoreState *env = cpu->env_ptr;
> +
> +    ctx->opcode = cpu_ldl_code(env, ctx->base.pc_next);
> +    decode_opc(ctx);

I'll note that there's an existing bug here, always reading 4 bytes with ldl.
You need to load 2 bytes, look at the low bit as in decode_opc.  If 16-bit,
read nothing more; if 32-bit, read 2 more bytes.


r~

