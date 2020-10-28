Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71AC7C4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 20:24:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C358247F8
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 20:24:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ViNfM8Zr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C358247F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXrzS-0005BA-Me
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 16:24:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52000)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kXryM-0004jq-5L
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 16:23:07 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633]:46879)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kXryJ-0008Iy-Co
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 16:23:05 -0400
Received: by mail-pl1-x633.google.com with SMTP id p17so164476pli.13
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2020 13:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=+BMLr3lUevhNNmmzRIMsJiTiFeBLrfX7QaMZBYm0J2k=;
 b=ViNfM8Zr53x5U19GXlAjUuyIthK1rnnTc+N/8cY3RZgcD+aMiAE/jaQzZygOqltGKw
 zPFOGiWvn/7/6Xtk3gSOZ24RYYm/AH9vZgFMWLXXTTjO6N6pe/xHGznWK/DimPUHA+ul
 JoN7PdJUn8Fw9HWvqIg/anysJ/0i+dnDPnZ2Jpyy6JQMwUJG5xiWBxvFScP/8WpPmD3j
 P0gQjfoHEhNk3eSp/GuuMlrz9deYkzoBOfd7NNtymjczM8RGAyggPoE7ty4NNXebaDvf
 JJuKMf1CwMWUVvTWcq/WZrD19lpnN/2HkPqwJ0DQgVEYXwrG7/fcRsiSAI6+Wi1M9dXb
 U2wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+BMLr3lUevhNNmmzRIMsJiTiFeBLrfX7QaMZBYm0J2k=;
 b=E40ol+cUmjVt+MndnRltzjieSTNaWHR4HeYIAHgc3F4xXuLMYPCUuKDhj9iSTSpulA
 xIW/qD9bNSJg8C8ruQt16Zr/wwKy3IcqjBLmMa+MhxLHM7t8yYoKcqHsymL2Dy2AtMDx
 Yqtdys1d72xMqlfUGlKmf8n+nSsFKgWq456yNFAjYkbP29tUrg57jSivcv4rhW6nGbil
 +yj6Su7UiVImtP7lDZypVIad2dwKs0HC1AqwxJ2SS+5jUtH4gGg+dv1YIVul0TKWp3Mj
 3Kx1HFC2VcJtEvvnnN/DE/ZZrM/rD+tGPwyl1sTzi1e8OHonUbGYvcAlDKMqdu4Q+a6F
 8bNQ==
X-Gm-Message-State: AOAM530ckY6t2DFcGcgYjU/kSUD3Wl5SC4HTCiElutVz0wyvCQYcp7xo
 QVykljb8tb5KYbca7R90BqKnVg==
X-Google-Smtp-Source: ABdhPJwz2fzPdQ46diuxH4LhSW92DFSUiszFJssx/DxY1ehxl4+MgbqqGq8ob2qmVTY+5P+q2gIM6Q==
X-Received: by 2002:a17:902:b70a:b029:d2:6391:a80f with SMTP id
 d10-20020a170902b70ab02900d26391a80fmr673087pls.0.1603916580748; 
 Wed, 28 Oct 2020 13:23:00 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id i123sm455038pfc.13.2020.10.28.13.22.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Oct 2020 13:22:59 -0700 (PDT)
Subject: Re: [PATCH 05/11] target/arm: Add read/write_neon_element32
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
References: <20201028032703.201526-1-richard.henderson@linaro.org>
 <20201028032703.201526-6-richard.henderson@linaro.org>
Message-ID: <02588cfc-3db6-b9da-82d2-807fc83307dc@linaro.org>
Date: Wed, 28 Oct 2020 13:22:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201028032703.201526-6-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.921,
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/27/20 8:26 PM, Richard Henderson wrote:
> @@ -3871,24 +3923,26 @@ static bool trans_VTRN(DisasContext *s, arg_2misc *a)
>          return true;
>      }
>  
> -    if (a->size == 2) {
> +    tmp = tcg_temp_new_i32();
> +    tmp2 = tcg_temp_new_i32();
> +    if (a->size == MO_32) {
...
>      }
>      return true;

Bah, forgot to free these temps.  Did I configure my first round of testing
without debug enabled?


r~

