Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E65AC47254
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 14:25:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCE702073B
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 14:25:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="udBIpGEF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCE702073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVyVO-00039j-21
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 10:25:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58496)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jVySU-0006uy-BP
 for qemu-devel@nongnu.org; Tue, 05 May 2020 10:22:06 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:32953)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jVyST-0000Pw-5p
 for qemu-devel@nongnu.org; Tue, 05 May 2020 10:22:05 -0400
Received: by mail-pl1-x643.google.com with SMTP id t7so887435plr.0
 for <qemu-devel@nongnu.org>; Tue, 05 May 2020 07:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=I+PHkLMxuMk+Wdchq0uj0QQeoqRliPkmTbI1x4e+ffY=;
 b=udBIpGEF+ZOtzUKN3ZduY1DY2uNFZRlmlpLwdalWOd3NuK0ERzFIq8lUmdntsgwYzl
 2Tqfr7exmHdSD+Rx67hCPt2t5MPCWEOfg/4PMIOKTtyH4IWvJM0sQTzIikeyB9xx5RK5
 9MMso+wtIBFQt/T2f+iLjjdzeuZJUMhmLXbRZXAy0yJZQU/RLZfYa/cgCWnMkLQgbFHg
 N/TEGm5TIwmKu70ReLMIhUtrwXyctT/rLao2cm+C2VeGoZzzgbZ/ub7KJTtL4zR951P+
 7xcy7A8NF7QgUdJHImZq0Vz+H+/4hVsLSM4Qn5W9ydvJG0ILTdBOS1BMlRflMV9iCieC
 4+AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=I+PHkLMxuMk+Wdchq0uj0QQeoqRliPkmTbI1x4e+ffY=;
 b=Iq5cLi2yo/8b5OaRSvuOx0TJv3qPHdEw+oX0Ed7R9tI9yoIyvvPNPIorSkuNH9K26b
 0C/MxQ7sUA9qNCrXYHuSvp6W3QW5zgTFXJBHFtxMkyt5uNRhIzVjyAU0X4OgH6bBGPGa
 bLVrZMNh2+5OUjTivo9Ryrepx6RjbtIzraoUJF4yBkE9A+YahEMaMMZSQY19/THaduyO
 k4wd1MJ2wkYICOjC23pa2N0axEsdyEhD6YlkA2FQ+7xpT1MlNYFJ6cFlxwUttu93h6GZ
 KSdjeStR5Y1VbeBEnovpyvjN/OLY2SDxLRUQDCNSs3X2oTcwZku3Vx83/pU2VmTJpTJJ
 OOdw==
X-Gm-Message-State: AGi0Pub/JSmy7Eg/57PsCU7Xq+6Wunq8KSdL/wQyeIrBnEBXDWxd965d
 HWjRxg3WgV/AxRGP9Zy9U9+yqg==
X-Google-Smtp-Source: APiQypJHPFtvIw1Axjexfk+BeObCo67HYUDwrZ/EH4PY5HqaoUzZHK4Ey6xWt/uwwO4VbQ/CNZrP3A==
X-Received: by 2002:a17:90a:db91:: with SMTP id
 h17mr3502246pjv.10.1588688523499; 
 Tue, 05 May 2020 07:22:03 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id a200sm2111717pfa.201.2020.05.05.07.22.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 May 2020 07:22:02 -0700 (PDT)
Subject: Re: [PATCH v3 3/3] target/arm: Use clear_vec_high more effectively
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200504192344.13404-1-richard.henderson@linaro.org>
 <20200504192344.13404-4-richard.henderson@linaro.org>
 <aaa3d497-3c54-9acf-7ef1-fc47bd9d699d@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <0b943dee-7275-90ea-2b66-ed5b5246d4be@linaro.org>
Date: Tue, 5 May 2020 07:22:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <aaa3d497-3c54-9acf-7ef1-fc47bd9d699d@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x643.google.com
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
Cc: peter.maydell@linaro.org,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/4/20 11:09 PM, Philippe Mathieu-Daudé wrote:
>> @@ -7111,7 +7121,7 @@ static void disas_simd_zip_trn
>>       }
>>         tcg_resl = tcg_const_i64(0);
>> -    tcg_resh = tcg_const_i64(0);
>> +    tcg_resh = is_q ? tcg_const_i64(0) : NULL;
>>       tcg_res = tcg_temp_new_i64();
>>         for (i = 0; i < elements; i++) {
>> @@ -7162,9 +7172,12 @@ static void disas_simd_zip_trn(DisasContext *s,
>> uint32_t insn)
> 
> More context:
> 
>            ...
>            ofs = i * esize;
>            if (ofs < 64) {
>                tcg_gen_shli_i64(tcg_res, tcg_res, ofs);
>                tcg_gen_or_i64(tcg_resl, tcg_resl, tcg_res);
>            } else {
>                tcg_gen_shli_i64(tcg_res, tcg_res, ofs - 64);
>                tcg_gen_or_i64(tcg_resh, tcg_resh, tcg_res);
> 
>                          here ^^^^^^^^ tcg_resh is NULL too.
> 
>            }
>        }

When is_q is false, the vector length is 64.  Thus that line is not reachable.


r~

