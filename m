Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15943C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 21:05:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 631DA208D5
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 21:05:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n+5bCzX3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 631DA208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSRUR-0001Kb-GG
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 17:05:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35944)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kSRQk-00077u-BU
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 17:01:58 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:35024)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kSRQi-0004ip-Py
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 17:01:58 -0400
Received: by mail-pl1-x641.google.com with SMTP id 1so559485ple.2
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2020 14:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Ga4I9OYNBnZa92Yj0J1iTWKYRoX+Gn4YsWG55dsQZCc=;
 b=n+5bCzX3CzK3AOk+gct66uIE7AcAIOfdFt7ZZgQnHv+n7GDnbEcBRspHNGJqUSjhGF
 3fotr2Dro/IfaQkt+J7TAFv38QrXX7Ox4uimbEvjYsetXeAd2YHCiTBLY0inPWSq4DsG
 CKPQlGqW7pvu/KSitA0lK3rlPdPVNHlzSciQLhMNrKTvdaa6t/4DZEqOU/lzJ4T3eQD7
 A/mJP9DCebMLk4fU4FxEXlhoFGQy0Tqkc3HInXQigAbK3aOGj9O0mJz3QHYii1v/yyGS
 DxS2DYRtHXD+0LUOzAghQ3mt5GwfaGGxqkg984TO+HwG33btsn4lZPa4wakH9HeuIejU
 fc9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Ga4I9OYNBnZa92Yj0J1iTWKYRoX+Gn4YsWG55dsQZCc=;
 b=DaWC9ZGfBybKFHvzOVsFqR5ZoFb9gJSCAdySnFEk0Z9q97QgE4eCbODAUQvXuNljF+
 XbdDE9Cb/SCqa3SdXD6gjh5jGlQkxZBR+5c25r4Ssrw3Yf889Yy9BV0nrVb3EimlivO4
 pG6ZHc0zOCv345piJAJigT+Al6KaGaisDQPEsdKLxJypBfPDld2buYcZ9niVkYGT94w9
 SuzgS1HfRdwPj1HRhIogr//bLilNBLJV01JjG3m0NmAYnPktiDodzMNCHpzMppWDmfTi
 acZOFdbzx0Fj7BIVNr/YoRVcFjXxQenvGyuaqL+syMON1k4EycQH13DbzlZXplzB5uDh
 e33g==
X-Gm-Message-State: AOAM531YeQDpurm/I0oZQYgFzrqGs+8XoaZ+iknz6GR6UStGicVvgIex
 TGQ+ezL8tlU+YrfxKstxf7wGVRGMnqegvg==
X-Google-Smtp-Source: ABdhPJwOzZ5wVuzu37xivFNwht6hrywmjXqrjXa0FukAJg/M8QeRXVUSAPYhB0aI817TaBqpRqYWKA==
X-Received: by 2002:a17:90a:e088:: with SMTP id
 q8mr238320pjy.172.1602622914801; 
 Tue, 13 Oct 2020 14:01:54 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id t13sm595762pfc.1.2020.10.13.14.01.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2020 14:01:53 -0700 (PDT)
Subject: Re: [PATCH 09/10] target/arm: Implement FPSCR.LTPSIZE for M-profile
 LOB extension
To: Peter Maydell <peter.maydell@linaro.org>
References: <20201012153746.9996-1-peter.maydell@linaro.org>
 <20201012153746.9996-10-peter.maydell@linaro.org>
 <dbba485a-b69e-9138-5db4-d146ceec3c3a@linaro.org>
 <CAFEAcA_v3f4meMrENphpXSHNz=dNBQDE0LA=_3DMjxvSKL6wnQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b64525f5-e5ba-7c36-f672-c0a560473e0b@linaro.org>
Date: Tue, 13 Oct 2020 14:01:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_v3f4meMrENphpXSHNz=dNBQDE0LA=_3DMjxvSKL6wnQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x641.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.001,
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/13/20 1:38 PM, Peter Maydell wrote:
>  * has short-vector support (eg Cortex-A9)
>  * v8A, can implement FPSCR.{Stride,Len} as RAZ/WI
>  * no short-vector support, Stride/Len can be written
>    but the only effect is that some insns must UNDEF
>    (eg Cortex-A7)

Yep.

The other thing I wondered is if it was worthwhile to go ahead and split out
ltpsize now, even with MTE not implemented.

Eventually the conditions here would look like

    if (m-profile) {
        if (mte) {
            ltpsize = [18:16];
        }
    } else {
        if (!v8) {
            vec_len = [18:16];
            vec_stride = [22:20];
        }
    }

but for now you could leave out the assignment to ltpsize and just leave it
initialized to 4 since reset.


r~

