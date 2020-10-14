Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3024DC433E7
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 18:43:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C60A21D81
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 18:43:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c8/OVvYa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C60A21D81
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSlkA-0000dN-95
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 14:43:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33570)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kSlif-0008VG-UI
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 14:41:49 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d]:37953)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kSlid-0004kU-FZ
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 14:41:49 -0400
Received: by mail-pj1-x102d.google.com with SMTP id u3so249358pjr.3
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2020 11:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=i0vAYObnpIFH4p12o6pJGrseH5Je/UJA9BTxb3ZRME8=;
 b=c8/OVvYakMGe4rmPIMuvQLaksWk1X4XPWEREM15eCaSyXATvd2zr45lm8Hb40xpcuB
 mQOJxye1FsCIrQ45OCXof25odPVF/CUCJGR3Cpl8dUW2GBLAoRycm0yLrXhnZoHhMs87
 +6M5cS02iFcdGHFW0uw9UajEb8p/42G1Svuf5/Iyq+OgQRQjLhxDlBBTAGsBIztWgj75
 n5Z1idodHsYyMCT0XKqPPE+whHRkeRjjtdTy3pk22RvgCG4zP/Rb/slLLHmuhBT0HTma
 Afi5FKS9m9oMpcW1O7bskYe8qj1h/78xre1AT4Ti4VoJLMozNZFOpHlNqcFGJTszGZuA
 0vNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=i0vAYObnpIFH4p12o6pJGrseH5Je/UJA9BTxb3ZRME8=;
 b=dyOzN1id3n4kikCFYAx19QAlf6hwTUGO/xJOA2aXaUf8KzlfUzdJ165ax2NKNOFkpD
 adZKFnN+/3p5Kma24YAqNZZ7f1nTBM79hwOdhgH42b10zNl0NqGfza3Cxo3qHdZ8nBJH
 Rslbz770l01FF509LspPdgtezLQo9zGiN+xa2lwbFDDoJZiznPdmgC1X4grr5kb6Vsjg
 cz/jnGD4W5726gXDJRdSQkwSyq7ugix1Pko53b08nAdp7Aa4G/LX5McdkEn+3Ttwmtbn
 vL24iQqQdWxDZU31TMRYf4PanQ5o/4p+waaIB3YpxWuuVRnVe+L4HX/jToSKOx7Tw5el
 ZduQ==
X-Gm-Message-State: AOAM533kKO2Z94REvBtSYhs2qpos4nLnO0S/v5P+LFP0jnEihNTEo5lD
 wherUfdmv3o1lByeW3oLG9WnHA==
X-Google-Smtp-Source: ABdhPJwlzouQwkpgLuppffpK7HIb87c+D8BnClYecn6cJF3B3RVOAPVimvpu1nIuAr/dy8ne7meBrA==
X-Received: by 2002:a17:902:7c93:b029:d4:e1c3:bde0 with SMTP id
 y19-20020a1709027c93b02900d4e1c3bde0mr359548pll.85.1602700905283; 
 Wed, 14 Oct 2020 11:41:45 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id fy24sm227781pjb.35.2020.10.14.11.41.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Oct 2020 11:41:44 -0700 (PDT)
Subject: Re: [PATCH 3/5] [RISCV_PM] Print new PM CSRs in QEMU logs
To: Alexey Baturo <baturo.alexey@gmail.com>
References: <20201014170159.26932-1-space.monkey.delivers@gmail.com>
 <20201014170159.26932-4-space.monkey.delivers@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <3395cef5-79d4-078a-29ad-48639e4cd56d@linaro.org>
Date: Wed, 14 Oct 2020 11:41:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201014170159.26932-4-space.monkey.delivers@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
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
Cc: "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 space.monkey.delivers@gmail.com, Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/14/20 10:01 AM, Alexey Baturo wrote:
> +    if (riscv_has_ext(env, RVH)) {

RVJ.

> +        qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mmte    ", env->mmte);
> +        qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "upmbase ", env->upmbase);
> +        qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "spmbase ", env->spmbase);
> +        qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mpmbase ", env->mpmbase);
> +        qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "upmmask ", env->upmmask);
> +        qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "spmmask ", env->spmmask);
> +        qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mpmmask ", env->mpmmask);

Probably you only want to dump the set that's current.


r~

