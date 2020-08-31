Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C48F8C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 22:17:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86EB120719
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 22:17:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ov16dezC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86EB120719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCs7T-0001MI-IT
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 18:17:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59168)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCs6d-0000vJ-80
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 18:16:51 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:33453)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCs6b-0008Cx-KM
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 18:16:50 -0400
Received: by mail-pg1-x542.google.com with SMTP id e33so1518317pgm.0
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 15:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=c8+kM8SN1BKNXVYJO6A8yuj4sqCn/fypbT23mX1/nJU=;
 b=ov16dezCCqTXUZW39GOgIGqBVI0JZPwwHie/MT/szqmpHxLoEiQLS9zTPalycLdkSe
 bjC0tc8mkqCMgwyxNgwCHgespS/uOSmFdSXaPdbxYN15PAMdZbROfkrh5h2x/IYGRL5Y
 TidhPIYhdaZRULK8Kw2KQBEPTZ+Wbkvtme+6PgLBFaAVIVsjcUNCa9rrgla6phgugZ6+
 T4vvRT1f/S//QJBhNwSc1V3CuFgyAAZscQBws7Pr5nDFc49XSRPv5zdwAZ3Ht0CO2bvE
 oCfV1XLRnObsWJw7zBdCrQboVD/Mx9fuVJWzZ0GerPLT3rAzJZPwf6IPLa3oZRiqJUU6
 Yq7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=c8+kM8SN1BKNXVYJO6A8yuj4sqCn/fypbT23mX1/nJU=;
 b=G4MXVHTFqK+I0HQqIJaJdG1CaOr72K82D477CHvgj5a0ZwRrSH4vO9JUIIGb712loN
 aT+LEW9NwyB6aCUdklBNkrdlPDgsXPO5qyf842lteiSOX+XEdmICzxlgJQGf6iTMW12L
 pK/n7gL3j9ylkT1utBCZA9d0HPANtAG7H9o/DBG2hRJkrI+QyNfWdmgUamKS9zhQqxB3
 OkNyEdcEEkRyb6AgogoZ3Wvy7Uxkj4JkEag6932kBvptU6OTKakLUR48w+T88yrRoxBS
 Jt+NjFhZpddcXf3FUVZRrQdOaAbtpLCfaZ53nIfbuYJjPM36Ykm64yDon5aYAARofTfe
 YZFw==
X-Gm-Message-State: AOAM532C+WGq7UAB9IZQ/IsvkqQls55u8aHy65Yer2bht5uR69CpP89k
 XGWVGgfjfBUpqc6I2mraFoSQNw==
X-Google-Smtp-Source: ABdhPJwPVdxHLU6zlZTAkkIoACPtcgx7x662ewFO5Fc/5uxWLMgi34Kc0APivJfbvBzoyLyxz4jzBw==
X-Received: by 2002:a63:2a91:: with SMTP id q139mr2902472pgq.391.1598912206507; 
 Mon, 31 Aug 2020 15:16:46 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id h5sm9845152pfk.0.2020.08.31.15.16.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Aug 2020 15:16:45 -0700 (PDT)
Subject: Re: [PATCH v2 62/76] target/microblaze: Tidy mb_cpu_dump_state
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
References: <20200828141929.77854-1-richard.henderson@linaro.org>
 <20200828141929.77854-63-richard.henderson@linaro.org>
 <CAAdtpL5PueR0ezHJ7ATH-qD6K+8OaSGqqd4jBSy+D6+9CCaSaw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <bede313e-37ab-8f66-194c-7efd46fa0954@linaro.org>
Date: Mon, 31 Aug 2020 15:16:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAAdtpL5PueR0ezHJ7ATH-qD6K+8OaSGqqd4jBSy+D6+9CCaSaw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x542.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.13,
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
Cc: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/31/20 2:08 PM, Philippe Mathieu-Daudé wrote:
> Hi Richard, 
> 
> Le ven. 28 août 2020 16:46, Richard Henderson <richard.henderson@linaro.org
> <mailto:richard.henderson@linaro.org>> a écrit :
> 
>     Using lookup_symbol is quite slow; remove that.  Decode the
> 
> 
> Can we add some runtime option to enable its use instead?

We do the lookup with -d in_asm.
Do we really need it with -d cpu as well?

The -d cpu can be called many millions of times more than -d in_asm, and the
two are relatively easy to correlate.


r~

