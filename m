Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D450C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 15:03:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 687FA20675
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 15:03:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IZiAN2wh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 687FA20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqHmo-0000Rs-N5
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 11:03:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59978)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jqHl1-0007OO-0t
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 11:01:11 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:51671)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jqHku-0003zG-36
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 11:01:10 -0400
Received: by mail-pj1-x1043.google.com with SMTP id l6so6499694pjq.1
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2020 08:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=mlMdpfsudobpLEFcK7g1Am1DrsgPtMirY3X8ftqAplU=;
 b=IZiAN2whM0yLPwX55puOhJ5T5BfOYWE3XxdlW2ymG+71XiVk+0jRlQuTzjWRbJBDTs
 k3s/TRmIypyd52n2BJhXooaLeOA2+S2xGhJe2i0EdJcNE4Bl2WMCwR5LQmUj8Urd2uPD
 BP+ng1dkrTVhqOJPy9ZjfelrnT/hwatnIZowbqaL5lrcelNAHpNUjN9aOQj+AN1gwChP
 pmmfxoRJBL//MA04lR5bsJghmkmGwyzty6/FAk8iIweFSWI4FBBQmd5cAaqFzw4EwtuO
 TTGS5FAgt95YzqHNjkQESvWDaFWDar9UGuXelXvFjllcOZk6EpSkjOjmf5ttCVfE2V5g
 i1rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=mlMdpfsudobpLEFcK7g1Am1DrsgPtMirY3X8ftqAplU=;
 b=kD+LZLvcvVE/eTU6e4ZHcEmrzMSBJ4qyhBryZ2TzCmwbzTORQr3x0oGjyW540ZUWUl
 JygTmt0qhRCKZcdgu31Jjeh3iR9I26BEQ4dXP0HqmOEHJIpegluVpZ+9/HJV+JARAgsu
 /wtdvhfU4y7ISnTWj2zX8QPmv0DIqrWb7tBPgwCqNn5F0q8Xc9lXo8Sk4DMvwOcEKT9M
 LlwkL42K7dY7drNVArY5PCAPfMmSAESJPabgN8fT2V5l1cRKBNAQZm4DiEP4vGt4wuwX
 Ylz2vhODUuYX3zSMXoGJoFYQ5PDYh7VQF7g1iUSC471ChjQ+buMvENasTHbdBWnUwvMy
 50Jw==
X-Gm-Message-State: AOAM531zm2ozRgfuqpgESfB7ZNLyTgmg5cvJI4RcQFkIl2S0dDe5LxiT
 DjvWpgkxT9JO6vGq48308/EhqA==
X-Google-Smtp-Source: ABdhPJxGdbdxEOmMGI2cDd9IMsZb4WuWT5VOIWwtHs6nKXy4BGp2MRyCMBHb/jfJVph6k3aS3ZyS+g==
X-Received: by 2002:a17:90b:3748:: with SMTP id
 ne8mr2212372pjb.7.1593529262228; 
 Tue, 30 Jun 2020 08:01:02 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id m31sm2744103pjb.52.2020.06.30.08.01.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jun 2020 08:01:01 -0700 (PDT)
Subject: Re: [PATCH 2/2] target/riscv: Do amo*.w insns operate with 32 bits
To: LIU Zhiwei <zhiwei_liu@c-sky.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
References: <20200629130731.1080-1-zhiwei_liu@c-sky.com>
 <20200629130731.1080-3-zhiwei_liu@c-sky.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <dcac30bb-4d01-48fa-ee48-0feed464b180@linaro.org>
Date: Tue, 30 Jun 2020 08:00:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200629130731.1080-3-zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1043;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1043.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: palmer@dabbelt.com, wenmeng_zhang@c-sky.com, Alistair.Francis@wdc.com,
 wxy194768@alibaba-inc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/29/20 6:07 AM, LIU Zhiwei wrote:
> +static bool
> +gen_amo_w(DisasContext *ctx, arg_atomic *a,
> +          void(*func)(TCGv, TCGv, TCGv, TCGArg, MemOp),
> +          MemOp mop, bool sign)
>  {
>      TCGv src1 = tcg_temp_new();
>      TCGv src2 = tcg_temp_new();
>  
>      gen_get_gpr(src1, a->rs1);
>      gen_get_gpr(src2, a->rs2);
> +    if (sign) {
> +        tcg_gen_ext32s_tl(src2, src2);
> +    } else {
> +        tcg_gen_ext32u_tl(src2, src2);
> +    }
>  
>      (*func)(src2, src1, src2, ctx->mem_idx, mop);
> -
> +    tcg_gen_ext32s_tl(src2, src2);
>      gen_set_gpr(a->rd, src2);
> +
>      tcg_temp_free(src1);
>      tcg_temp_free(src2);
>      return true;

With the fix to tcg, there should be no change required here, since you're
already passing MO_TESL for signed input.

Note that unsigned comparisions work as expected with sign-extended inputs.
That's what the risc-v isa does, after all.


r~

