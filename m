Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80787C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 18:01:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 438AF2084D
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 18:01:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v1wdUZAf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 438AF2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyJ40-0002ZX-Eg
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 14:01:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60048)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jyJ2g-0001Wn-18
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 14:00:34 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632]:34327)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jyJ2e-0002YH-2k
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 14:00:33 -0400
Received: by mail-pl1-x632.google.com with SMTP id o1so1386683plk.1
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 11:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=5n2fCFqddpQ+teBXgKuSxKVIND558u1pltuSIXE1Cpw=;
 b=v1wdUZAfB5aJI68f/JvMtz/fG3lpLMdmB4sWqm3dA6i2O/2uNm00w76Btux9GQqOki
 gyvPfaZY0EflfyzxK6p1Bb/CkBqHntka4GYhFyoF+fPWum4/P/ex8Ums/1rtLie1h6Vm
 7zqM8/g/rGaqyOK0ceAh88TNm6APzOhZYa8hkJ5HFm9BMPrUhgsAwOwFPe4FXXWJWqr+
 lJAmTyiJrz33fvnTDssDMUTwJWO+Q4F092X+HWySEQzcgxemTsU+pspG8uMcWEOG8oSo
 XZZwUF3K8L3QEmLzQg+h377Vp6lPfNHGbrx7tjXqBv6xan1M6ElZEDPE55Z5RU2/nDR4
 GRFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5n2fCFqddpQ+teBXgKuSxKVIND558u1pltuSIXE1Cpw=;
 b=BHiUfg6hvFRe5+UOISiO6qkxM+PFUEAeJhc20r9/Z7Nd1mVm1f78sLCU7L7iJIX6cM
 gfpM099Ldt6km6cSe7U/kOOWkZBc4edKLK9FTPBDrdA2cQOnkzCWiP1/OoDCSotXUAen
 DvWvFD3KfGfQoiMrVnFwnTeK12BHJLWAfIoNXt9SGceVAChazVGtl0Yr/B3avdLlp/6u
 ixJzH1RXJ0okGGgRQoDiFDQBi4KUs/kfYhdTK7MCSE8JVy2r4pariSVonyQOn4RObhY7
 nTQWKni1ahVyvcPMi6va+Ppwc9HhJKBg2/6xJGsOCemrr4L6V0wKlAwvOPY6EWg4MHuv
 kywg==
X-Gm-Message-State: AOAM532GylKXSqTWD/zC2ViahAlsz1iujXbkGmRIPg/wloym+vWELUBv
 iwMrkk/SWaerqKeojqs62p1ymg==
X-Google-Smtp-Source: ABdhPJxYCdeT/WMIz458kfVHPLhyQHkDZQArmYpeW8U1towrVbYODQmAGY452od3A3kONhg4CIBezQ==
X-Received: by 2002:a17:90a:db0b:: with SMTP id
 g11mr552552pjv.11.1595440829447; 
 Wed, 22 Jul 2020 11:00:29 -0700 (PDT)
Received: from [192.168.1.11] (216-160-65-90.tukw.qwest.net. [216.160.65.90])
 by smtp.gmail.com with ESMTPSA id
 w18sm256605pgj.31.2020.07.22.11.00.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Jul 2020 11:00:28 -0700 (PDT)
Subject: Re: [RFC v2 16/76] target/riscv: rvv-0.9: add VMA and VTA
To: frank.chang@sifive.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
References: <20200722091641.8834-1-frank.chang@sifive.com>
 <20200722091641.8834-17-frank.chang@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <05c8267d-f22b-6714-8806-92edf228091e@linaro.org>
Date: Wed, 22 Jul 2020 11:00:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200722091641.8834-17-frank.chang@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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
Cc: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, LIU Zhiwei <zhiwei_liu@c-sky.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/22/20 2:15 AM, frank.chang@sifive.com wrote:
> -static void vext_clear(void *tail, uint32_t cnt, uint32_t tot)
> +static void vext_clear(void *tail, uint32_t vta, uint32_t cnt, uint32_t tot)
>  {
> +    if (vta == 0) {
> +        /* tail element undisturbed */
> +        return;
> +    }
> +
>      /*
> +     * Tail element agnostic.
>       * Split the remaining range to two parts.
>       * The first part is in the last uint64_t unit.
>       * The second part start from the next uint64_t unit.
> @@ -152,41 +168,50 @@ static void vext_clear(void *tail, uint32_t cnt, uint32_t tot)
>      if (cnt % 8) {
>          part1 = 8 - (cnt % 8);
>          part2 = tot - cnt - part1;
> -        memset((void *)((uintptr_t)tail & ~(7ULL)), 0, part1);
> -        memset((void *)(((uintptr_t)tail + 8) & ~(7ULL)), 0, part2);
> +        memset((void *)((uintptr_t)tail & ~(7ULL)), 1, part1);
> +        memset((void *)(((uintptr_t)tail + 8) & ~(7ULL)), 1, part2);
>      } else {
> -        memset(tail, 0, part2);
> +        memset(tail, 1, part2);
>      }
>  }

"1s" surely means all bits set to 1, not each byte to 1.

Is there any reason to do anything with VTA/VMA at all?  One alternative for
"agnostic" is to leave the values undisturbed.  So the quickest thing for qemu
to do is remove all of this code.  Then we don't have to pass the values in
translate either.

Which is exactly what is recommended in the 4th paragraph of the notes
following the VTA/VMA description.


r~

