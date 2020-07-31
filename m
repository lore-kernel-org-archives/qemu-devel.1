Return-Path: <SRS0=FShu=BK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 924F0C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 15:14:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D19721744
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 15:14:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dyiHvQyH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D19721744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1WkF-0007ZW-J2
	for qemu-devel@archiver.kernel.org; Fri, 31 Jul 2020 11:14:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35088)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k1WjS-00071j-5h
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 11:14:02 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634]:36196)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k1WjP-00055I-GL
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 11:14:01 -0400
Received: by mail-pl1-x634.google.com with SMTP id w19so4624110plq.3
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2020 08:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Ffm5PrqksEbgTX34yqN99Fp2zUkRKm0ERVamtWSCfq4=;
 b=dyiHvQyHLYJpcSrol4DOO2TanBt9FO2oZYI1JCA8r1BTEOrT93LnkESXjFc8SLO1gH
 Bn4VgBuBcKaul1gFQAJBg6z1JXspa2D6tqLjFzDRHtitXha/ZhUMUfLTTDoIOwrmAiEE
 YHJgye/RgzTi04TGLNSDmaClK34VgDZuitMOeqEGzwcbdWwg+iOkkVekBaf3LnjjbEzB
 t8yOTTpHsU+lif+37WAeW8RdM4Ms7yJ20qH9gltDN/Nar53V2aoXsAADsGKX1wujsSmL
 Pr7I65zXKRmauZ5BbZt2fRvTmCQ98U6r/aUaNGSOSvUYSJk6/4NjnkaCOfNmGpT8GWD8
 xd0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Ffm5PrqksEbgTX34yqN99Fp2zUkRKm0ERVamtWSCfq4=;
 b=YuSQTxd4WbY3Cuq7Htz0jOfEL32uhGTq6qHylYgqsvnb7/vr18/fk74ZrpxTjMbmLM
 hpbDZW23kcVx46xJ2VHREoOd17kEDwDBpDxlMecvaRJ2J0xt2+WzE8rXNpBWvP3FC/vs
 GWEmo2EW7iGN6PIuLfBUM+TWqLeOeWiKb12upGBVSq7O2q2vfFuvutaaMJ4LpK70RXnF
 8EJ+F3jHZIAs9ZuZ9V+0x9coTbs0xALZrJn36tlkOMOHqnqAiZjyZba76o3rzduOxOei
 b3YIc7eLLgXwukyfIbNX8CQqn3qwqP1Ltw7I12Qtq6UHf270xAicX+MOFWW8I+jGNdrS
 pQKA==
X-Gm-Message-State: AOAM5307NHGKrE2QaT+XRWZrn00y7pk4PIPsc3Wu3lAxz6Px7fFAIqVQ
 UreYbNzTHtcWkGtzh3297046+A==
X-Google-Smtp-Source: ABdhPJwkS0eOrhYNlrMVNmwllfXIOB6gKwbLfhGyvJbWrJj0bUG9YvQhjQDEqhZn0mbS2nVh9FaaPQ==
X-Received: by 2002:a17:90a:a783:: with SMTP id
 f3mr4449405pjq.142.1596208437755; 
 Fri, 31 Jul 2020 08:13:57 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id z67sm11701637pfc.162.2020.07.31.08.13.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Jul 2020 08:13:57 -0700 (PDT)
Subject: Re: [RFC v2 56/76] target/riscv: rvv-0.9: widening integer reduction
 instructions
To: frank.chang@sifive.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
References: <20200722091641.8834-1-frank.chang@sifive.com>
 <20200722091641.8834-57-frank.chang@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <554ad8ad-6638-7cb3-f06c-110baef2218f@linaro.org>
Date: Fri, 31 Jul 2020 08:13:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200722091641.8834-57-frank.chang@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/22/20 2:16 AM, frank.chang@sifive.com wrote:
>  /* Vector Widening Integer Reduction Instructions */
>  /* signed sum reduction into double-width accumulator */
> -GEN_VEXT_RED(vwredsum_vs_b, int16_t, int8_t, H2, H1, DO_ADD, clearh)
> -GEN_VEXT_RED(vwredsum_vs_h, int32_t, int16_t, H4, H2, DO_ADD, clearl)
> -GEN_VEXT_RED(vwredsum_vs_w, int64_t, int32_t, H8, H4, DO_ADD, clearq)
> +GEN_VEXT_RED(vwredsum_vs_b, int16_t, int8_t,  H2, H1, DO_ADD)
> +GEN_VEXT_RED(vwredsum_vs_h, int32_t, int16_t, H4, H2, DO_ADD)
> +GEN_VEXT_RED(vwredsum_vs_w, int64_t, int32_t, H8, H4, DO_ADD)

This patch can't be split from the previous, because it won't compile.  I'm not
quite sure where we are here with whether the patch is actually required or
not, with respect to VTA.


r~

