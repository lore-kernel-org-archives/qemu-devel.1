Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DEE2C0650F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 16:20:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2006B20B1F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 16:20:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fkFzf+Uf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2006B20B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hufj2-0001AT-GD
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 12:20:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34598)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hufiR-00006B-Fl
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 12:20:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hufiQ-00069N-Ec
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 12:20:07 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:41273)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hufiQ-00067q-78
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 12:20:06 -0400
Received: by mail-pg1-x541.google.com with SMTP id x15so29651253pgg.8
 for <qemu-devel@nongnu.org>; Mon, 05 Aug 2019 09:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ykrIaRRlUHnB3gqql23VpXkEawQrstQbXy+aW/44nx0=;
 b=fkFzf+UfD29kFQ90jG3Lu9pvSmzmfc+DYy7uSFFrAfTzPIccOjGbmpDLERjCn6g5U2
 PFkMhtXbKFxN517tF1X0UnBqEhOzN9T6s0wHwOXDcE9diMtv9gUReZMLBtzSlcUz5yeO
 NfOUYzKFBHPeZ6/EtUAkIFMYuIZX4OfseBL+weuZ3gGcNSgzgerLeZN6n1oD52vp7ed7
 W9sbMcfEKZbC7/YUDd9G6xynA3ECkOBlD9111LDpj3ms1SvcHq4M7BxD2gMvr5yx86o+
 FbZaD83icryONFoWvQslsg5I0uo0mXUDxPcIeNotb0Vs0x94rwK7RBZmmxaSOOWhFY5W
 af3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ykrIaRRlUHnB3gqql23VpXkEawQrstQbXy+aW/44nx0=;
 b=CsE7F7fOTQyVbUgX2DxLZSr8GYPotT9moJ7tVMxt244pijbk7I3WqybTxCG3h+w3nG
 M9EZ4lRm/jIK4kLOMmLWDD7DFg2IbBda3AW3V7n/yajoxJ4Aq2dL9GItnfksqNjfotwX
 dHyczYnLJtFGYgsqrpe2155m3t4n3dYM/UB5u6AdMCl8a1uh+usGSJH7CNXbchGeitHY
 gls5XHO2GXwW3VhIv6pZ3dHo1wsxLLiO2LCteUcj5qXulQud0N0rxQX36lGIf/ZqU0U3
 bI18HdfJgdWSI8DoCz2d0c9qOFOGIsjHehe7004AlAWvyxbM08L6g4hB6mS3jNCB5iqw
 nU3Q==
X-Gm-Message-State: APjAAAXC9eGwonYRqX/j9mvNirS1zP9jPg1WY0rV7CqwvV3EXrKqVIhO
 F4O6M/wZ3BuKKipa8LoSkMljXw==
X-Google-Smtp-Source: APXvYqwxnAP/wIdWlrPGtCX906vb/S6JU6OE9TqI9tn3ncNdhdBNscM88yXdolM/DUxwPlnt+v3qOw==
X-Received: by 2002:a17:90a:e397:: with SMTP id
 b23mr19075732pjz.117.1565022004990; 
 Mon, 05 Aug 2019 09:20:04 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id p23sm89749515pfn.10.2019.08.05.09.20.03
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 05 Aug 2019 09:20:04 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190726175032.6769-1-richard.henderson@linaro.org>
 <20190726175032.6769-15-richard.henderson@linaro.org>
 <CAFEAcA8OC+Rru_qHU+1gQqmzmTY_8F+gtqZ5TyWoQAf60gUD1g@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <51c91e79-5302-3eb6-60ce-e9a620026c54@linaro.org>
Date: Mon, 5 Aug 2019 09:20:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8OC+Rru_qHU+1gQqmzmTY_8F+gtqZ5TyWoQAf60gUD1g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: Re: [Qemu-devel] [PATCH 14/67] target/arm: Convert multiply and
 multiply accumulate
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
Cc: qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/5/19 8:32 AM, Peter Maydell wrote:
>> -/* load a 32-bit value from a register and perform a 64-bit accumulate.  */
>> -static void gen_addq_lo(DisasContext *s, TCGv_i64 val, int rlow)
>> -{
>> -    TCGv_i64 tmp;
>> -    TCGv_i32 tmp2;
>> -
>> -    /* Load value and extend to 64 bits.  */
>> -    tmp = tcg_temp_new_i64();
>> -    tmp2 = load_reg(s, rlow);
>> -    tcg_gen_extu_i32_i64(tmp, tmp2);
>> -    tcg_temp_free_i32(tmp2);
>> -    tcg_gen_add_i64(val, val, tmp);
>> -    tcg_temp_free_i64(tmp);
>> -}
>> -
> 
>> +static bool trans_UMAAL(DisasContext *s, arg_UMAAL *a)
>> +{
>> +    TCGv_i32 t0, t1, t2, zero;
>> +
>> +    if (s->thumb
>> +        ? !arm_dc_feature(s, ARM_FEATURE_THUMB_DSP)
>> +        : !ENABLE_ARCH_6) {
>> +        return false;
>> +    }
>> +
>> +    t0 = load_reg(s, a->rm);
>> +    t1 = load_reg(s, a->rn);
>> +    tcg_gen_mulu2_i32(t0, t1, t0, t1);
>> +    zero = tcg_const_i32(0);
>> +    t2 = load_reg(s, a->ra);
>> +    tcg_gen_add2_i32(t0, t1, t0, t1, t2, zero);
>> +    tcg_temp_free_i32(t2);
>> +    t2 = load_reg(s, a->rd);
>> +    tcg_gen_add2_i32(t0, t1, t0, t1, t2, zero);
>> +    tcg_temp_free_i32(t2);
>> +    tcg_temp_free_i32(zero);
>> +    store_reg(s, a->ra, t0);
>> +    store_reg(s, a->rd, t1);
>> +    return true;
>> +
> 
> Is using mulu2/add2/add2 like this really generating better
> code than the mulu_i64_i32 and 2 64-bit adds that we had before?
> If we're going to change how we're generating code it would be
> nice to at least mention it in the commit message...

I didn't really think about the code generation difference, merely that it
seemed more obvious, given that all of the inputs are i32, and we need i32
outputs.  I assumed it wasn't written like this in the first place because
tcg_gen_mulu2_i32 is relatively new.


r~

