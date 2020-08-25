Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62FB7C433E3
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 19:20:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DFFC2071E
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 19:20:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DvdWsGDx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DFFC2071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAeUE-0004QH-Fg
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 15:20:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38496)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAeTO-0003y4-Tr
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 15:19:10 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:56029)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAeTN-0005fS-Dj
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 15:19:10 -0400
Received: by mail-pj1-x1042.google.com with SMTP id 2so23829pjx.5
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 12:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=c2VdGFzmRtGow0aBim4Sh2NURb0XzVioVRQ+zIi1w0Q=;
 b=DvdWsGDxdws5oVtThYe6uUxK7FYiyu94b0I+aeCNyt3mitKVFL050LDNCBgbf251kp
 aGyKR13ETtzRPTXVVpDc/Wh/QY/TMQv04pk/gbCArsHPgn4h0SsK1c4gJkQ3vxifZ+VK
 G0HW2ICTqd73+9MVnPtB2lfOk9DRVQ94DIdPCICa6GRTtcq5wZQuH5DcNcBGCPEmMiR2
 iMQfpn4kygISXJToGqS1o1mLWFacCRHrXQqCtsHz4NFdIPZ4OssEDOiLHJjHL41kRYxB
 WUzMzgOyb76QADznM3gI2auH2ynMkNU2lNOSFgJ/6H0coa4UvyIeIBDxmSrPS3SfWFL/
 WJyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=c2VdGFzmRtGow0aBim4Sh2NURb0XzVioVRQ+zIi1w0Q=;
 b=hGvd0LRed3V/2a4yXUhsFqUrmVUrv0yOqmKdqT2gxeexLZUDiQgjeburTKtCv7j4cP
 NxcmrZUOSAiQVA1uD3zxBA2vKCC0PVMG2x6jCxru1U5Jbs/PGkmQluedJvhrVI7k0Ikj
 sHz9C2E/rkbm/DXkTRVoOigw+EOY3s10vS2lXQfXua+CGX8RSBdd2Tki5S3h5XPyuAxD
 wz+olYtk+GMOjeAdzxc8GPhW6WOxB9ibBpLErpHiygKEz1p2Ro5k7BosU55IM6Pdq6/I
 wmwQ0cGI7+T0nlIz73TdYyy8cP8Vn/GaUexiZOfITWjpnKgGrDdQLAmI366JGPpzjiKU
 uTpw==
X-Gm-Message-State: AOAM530h85OPEWUFjVA+mh2vDKvTG942JvPFtGMXYgbVOvkJNCCp9Dn3
 lbFISjht8CF3K6O3cCXoECH+jAF/cUfJRw==
X-Google-Smtp-Source: ABdhPJyR4V6HnWeDuI+E2VQMG9SxrOmw/vahS3INaRh9z8KAabxWUlDj62rXFtkYSuuUlTaJqUPKWw==
X-Received: by 2002:a17:90a:c505:: with SMTP id
 k5mr2663566pjt.188.1598383147406; 
 Tue, 25 Aug 2020 12:19:07 -0700 (PDT)
Received: from [192.168.81.79]
 (h216-228-167-147.bendor.dedicated.static.tds.net. [216.228.167.147])
 by smtp.gmail.com with ESMTPSA id y7sm6589095pgk.73.2020.08.25.12.19.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Aug 2020 12:19:06 -0700 (PDT)
Subject: Re: [PATCH 17/22] target/arm: Implement VFP fp16 VSEL
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200824142934.20850-1-peter.maydell@linaro.org>
 <20200824142934.20850-18-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <2d03cf07-b844-6049-ecb4-32b52a8a34f2@linaro.org>
Date: Tue, 25 Aug 2020 12:19:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200824142934.20850-18-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1042.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.602,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 8/24/20 7:29 AM, Peter Maydell wrote:
> @@ -307,6 +311,10 @@ static bool trans_VSEL(DisasContext *s, arg_VSEL *a)
>              tcg_temp_free_i32(tmp);
>              break;
>          }
> +        /* For fp16 the top half is always zeroes */
> +        if (sz == 1) {
> +            tcg_gen_andi_i32(dest, dest, 0xffff);
> +        }

I suppose that'll do.  In theory we could avoid this by using the correct
zero-extending loads above, but that's a nasty world, neon_load_foo, and it
doesn't sport 16-bit variants atm.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


