Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B082C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 14:51:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CDBF207FC
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 14:51:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dsSIUQq5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CDBF207FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2yHO-0000b0-Ln
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 10:51:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53680)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k2yGW-0007z6-Ch
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 10:50:08 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:38993)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k2yGT-0000xO-21
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 10:50:08 -0400
Received: by mail-pf1-x441.google.com with SMTP id z188so12563817pfc.6
 for <qemu-devel@nongnu.org>; Tue, 04 Aug 2020 07:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=u3g8bUxJKgAkATBFWfijZJ6uapdTpyKvTAtXKaUMi2w=;
 b=dsSIUQq5brqYLlo7daCDbSB2hH/FA5DEH5PetwA3nzdt+SgWzRwtgvXsyLcOOEuHxs
 sjMOijdcQImphUOtn5TKGpVxTaB+ZdGxKXOMNHuBgh7g9XcDk8i/Fdw/WNm7EaSHGls/
 +rchmoyScO/O/8/vcb4X+1yVmUzzPtuFBPvEVfZR/nWWVQwneSE4iLX6hPvIMSc+8Fpm
 8qP4Av9kSpnD1f4fJ4cTQs2xOv1dgjKfSg30qaoRthVZyphdouJkW/5402SCoF0HPW6e
 H2du9P33crLMY7iiQA5K9AniUBGnj3UnsK3UUZp5jtI9JSYJODFYZWfmL0reZKQlLtK3
 Y7GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=u3g8bUxJKgAkATBFWfijZJ6uapdTpyKvTAtXKaUMi2w=;
 b=om0LtAMWi2rv3lOyjlTiKz9hjHgglz+O8O3nObmTbVhkElBufjDNfV1WpoEfCTgKxB
 +8wGP6eaAlX9/pY2LAK7c1BfGbTnPSrZ/UQ5u0SFWszypYN1XTaA5A6c3ikB5l1rc2kH
 yoo53dD+q/k1uTTGylf1qNbfQMbCdB1kcMpQz6+G0CCjgJZSIIlrDr4RlnnFdKXSq0mL
 zwJZhj67s/9keGFfCG6C12QzoqNoMCGaqqwCDDgJ7g8JCX9SwI2bynE+m2YMP4mGR64m
 7ucarFAacNZsSPj3XVkiAjFQrH1SLZ1RUUFIO5eQUr93iHyMxOaIQhjWB3+sWSeyRmmh
 0bQA==
X-Gm-Message-State: AOAM531TEdhL20upGqMOcu0wXSXthOv7sLuUWfHjCdWTjUyk0+/a157x
 P+tIUtt0YIwkf+rF1iaWM+qogR3LOgY=
X-Google-Smtp-Source: ABdhPJwy932Y2Bx48JRqQfzy+tGfzgtN64Hl0X0BZ6yvUylah+NRRgAEwPSlNI0R57ANbDqOd4898w==
X-Received: by 2002:a63:6cd:: with SMTP id 196mr19314989pgg.169.1596552602952; 
 Tue, 04 Aug 2020 07:50:02 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id n9sm2942824pjo.53.2020.08.04.07.50.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Aug 2020 07:50:01 -0700 (PDT)
Subject: Re: [PATCH 1/7] target/arm: Pull handling of XScale insns out of
 disas_coproc_insn()
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200803111849.13368-1-peter.maydell@linaro.org>
 <20200803111849.13368-2-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <715e215c-9cad-ae8e-4f90-b81fdf2ad22b@linaro.org>
Date: Tue, 4 Aug 2020 07:49:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200803111849.13368-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/3/20 4:18 AM, Peter Maydell wrote:
> At the moment we check for XScale/iwMMXt insns inside
> disas_coproc_insn(): for CPUs with ARM_FEATURE_XSCALE all copro insns
> with cp 0 or 1 are handled specially.  This works, but is an odd
> place for this check, because disas_coproc_insn() is called from both
> the Arm and Thumb decoders but the XScale case never applies for
> Thumb (all the XScale CPUs were ARMv5, which has only Thumb1, not
> Thumb2 with the 32-bit coprocessor insn encodings).  It also makes it
> awkward to convert the real copro access insns to decodetree.
> 
> Move the identification of XScale out to its own function
> which is only called from disas_arm_insn().
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/translate.c | 44 ++++++++++++++++++++++++++++--------------
>  1 file changed, 29 insertions(+), 15 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

