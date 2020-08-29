Return-Path: <SRS0=OYoK=CH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AB24C433E7
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2020 19:31:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E14792076D
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2020 19:31:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hBAsDJBm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E14792076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kC6ZW-0006fn-3i
	for qemu-devel@archiver.kernel.org; Sat, 29 Aug 2020 15:31:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57910)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kC6Ys-0006CE-9b
 for qemu-devel@nongnu.org; Sat, 29 Aug 2020 15:30:50 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d]:55985)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kC6Yq-00028f-9V
 for qemu-devel@nongnu.org; Sat, 29 Aug 2020 15:30:49 -0400
Received: by mail-pj1-x102d.google.com with SMTP id 2so1074240pjx.5
 for <qemu-devel@nongnu.org>; Sat, 29 Aug 2020 12:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=7DvoGmbV92m69LLpF0xRzt7J9AAKfT9XpUE3XyAFOno=;
 b=hBAsDJBmF5xA3UCiFf/8X//tyJBbIeIwnjBPzQHLC0XBiHMh0j74e1Uxe9nCrmrqss
 aChlIv1fjkxrezYzD3rKrh8oCAeLROoU7pb92ow03WrH2iwzxnPbsNuELSLunGziv3QR
 RM1SVlG38/3OG0d4wbQUXYb3u2ZfxiimPqrQaWQ58bzvJmyHM9AwecEGgW3bOp2b0aT7
 gFuWnAUKjotrh2lv2pImEHVrtju2KcJUdVjNNOo8jRnZ7CCz5e7i5T4cyKfbuIPBPERk
 LTmfyeN4pYdEVoDi3G5n3Hn0ujd08fcOJaYF551bOtDcochknkkTl6JuGRCaBZp0LMwR
 NR4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=7DvoGmbV92m69LLpF0xRzt7J9AAKfT9XpUE3XyAFOno=;
 b=tzbQ94p5P9h62eGYtYlt2eMD3SwwQF2U4Q/GH/X4Bt4C1ALlwn4cxnHSuZwkAaw7bu
 yTuUybFWnle75TC0A3jl9UkcRmZiu9SrcYVPfjuVi709rv4RFWcVykmBCQadD1GzROHI
 5ty4YAJ7dQCd+4vtRztPCy6J7KBwS/O9mM4MKeqNmDjTt3jDo8Vl60YFdbDfYdU+07ir
 R+LRZiw4ZLXvjIIW/7FeGv97c4sJMtAb8xNHr5foiHWGTnQ89xo44CHNxVwDYE+/Mpn7
 z4qGY1c+BoXuJa5R8j4xNjihUVEmmsk9CUp7eHWx/sRj8xOP7hhCRyDeJDCvSu5mWP+3
 X7FQ==
X-Gm-Message-State: AOAM533VA0zIGre6gcXuJhH3Jb/sEa9gNmanq1Vg3LmQZLfu5o00WEP0
 8gIxg5hhymsmVyBy5/9IABb4Kw==
X-Google-Smtp-Source: ABdhPJzSo2mjPb2Qpo+lrX5ths1i8jPmOxc1yExeJyQAUWeLUCmHpNXVsMazq3Gq6mU7tTg3GgHfkQ==
X-Received: by 2002:a17:90a:4382:: with SMTP id
 r2mr3942886pjg.144.1598729446632; 
 Sat, 29 Aug 2020 12:30:46 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id u21sm2752550pjn.27.2020.08.29.12.30.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 29 Aug 2020 12:30:45 -0700 (PDT)
Subject: Re: [RFC v4 24/70] target/riscv: rvv-1.0: update vext_max_elems() for
 load/store insns
To: frank.chang@sifive.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
References: <20200817084955.28793-1-frank.chang@sifive.com>
 <20200817084955.28793-25-frank.chang@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <8ebe55db-bd59-adf3-8ca7-e2cc2d1e9c3e@linaro.org>
Date: Sat, 29 Aug 2020 12:30:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200817084955.28793-25-frank.chang@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.809,
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
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/17/20 1:49 AM, frank.chang@sifive.com wrote:
> +static uint8_t vext_get_emul(DisasContext *s, uint8_t eew)
> +{
> +    int8_t emul = ctzl(eew) - (s->sew + 3) + s->lmul;
> +    return emul < 0 ? 0 : emul;
> +}

Same comment about EEW being encoded as MemOp to match SEW.


r~

