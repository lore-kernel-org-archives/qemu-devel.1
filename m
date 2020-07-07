Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A96BAC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 02:09:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74C992070C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 02:09:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R/HpK3Vc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74C992070C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsd2m-00070i-P5
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 22:09:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54866)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jsd2A-00064y-D0
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 22:08:34 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:55977)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jsd28-0005ga-KM
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 22:08:34 -0400
Received: by mail-wm1-x342.google.com with SMTP id g75so41319259wme.5
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2020 19:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=mDcH6VoquFxrN55+jeRO1Hkb2P20kDXO0Hhj0jRCs1Q=;
 b=R/HpK3VcXFE5WwsoGvXwzCs7U+7AVtoe/I3PHycbsXcJAUkDmoP4pSYfuEts2DffFz
 2mJgFfta/873onnpFivAGbQ8jsRo/Phb5NxwexnC5dYyK5rgjgBl7z3B6xgjMpP1pTja
 yR7rNIQ0q4oAoJQdOhiJhCjrODhlbOogy0jgfKUdsz7Cf4hBuWkPN5xcbIPxTF2fMioB
 RS+v/BBGFh1Tqa4dyrd3CmbQlM6PCiIn4TMQQCm+Knouyk9WbtH4mYMbUXga1fvTNYwa
 5eDHsF1Hdevq8V7NcP2X6mN/nqgssjenP/5xecwceu7rSYIq/RKMfEgHrMS4ZTe4AJbw
 pJ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=mDcH6VoquFxrN55+jeRO1Hkb2P20kDXO0Hhj0jRCs1Q=;
 b=b4i861319cz+DJX2PuFGmt2Hz8ooy4nVNmP0c4SQL7AqgoagcMNkuNcstsI05K7JNp
 z0P2TTKcLSEvE62CZWiH7kYqjVR9zCXDFDlbpFL3DWHzkzwzlS3xU9f2d16s0xCFjORH
 7qPHrU50evjtQ7UqTSoNSy1OnbrzxjDocjcnPwgn9v9GReswvIl3/sAbPhYRtT6nhIs/
 hN7UaQOQ09C5dnmt2GyL2RiiIpq4vdQDa7YkfDhlRgPgr6+ek51rxr2sjQEnLeQYHyMz
 vlY8zpK76pXCComs8OuU/sUr/cg72U0zrL5ZZLz03lm3JYyAI7VklYprnRw8kihZcqrx
 fydw==
X-Gm-Message-State: AOAM531d8Gh27wxoaQr8xfuvoGNzZkAm+lwQ4Dd4PiqxySoEahR9n+Gm
 k5TsnZfRoz3RyjR8yx8585k=
X-Google-Smtp-Source: ABdhPJzQwrvQBlcD/jrf3wd6FgO891+xRIJQQX3Ic2E4q2XhUYRMLP1mJzv+gEA8RHoYo21Ji9xGPg==
X-Received: by 2002:a1c:a589:: with SMTP id o131mr1634755wme.12.1594087710626; 
 Mon, 06 Jul 2020 19:08:30 -0700 (PDT)
Received: from [192.168.1.36] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id d18sm27251016wrj.8.2020.07.06.19.08.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jul 2020 19:08:29 -0700 (PDT)
Subject: Re: [PATCH] target/arm: Fix mtedesc for do_mem_zpz
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200706202345.193676-1-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <d86be7e0-d73a-f10b-94be-1fb17a938563@amsat.org>
Date: Tue, 7 Jul 2020 04:08:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200706202345.193676-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

On 7/6/20 10:23 PM, Richard Henderson wrote:
> The mtedesc that was contructed was not actually passed in.

Typo "constructed".

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> Found by Coverity (CID 1429996).
> 
> Fixes: d28d12f008e
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/translate-sve.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
> index 08f0fd15b2..88a2fb271d 100644
> --- a/target/arm/translate-sve.c
> +++ b/target/arm/translate-sve.c
> @@ -5275,7 +5275,7 @@ static void do_mem_zpz(DisasContext *s, int zt, int pg, int zm,
>          desc = FIELD_DP32(desc, MTEDESC, ESIZE, 1 << msz);
>          desc <<= SVE_MTEDESC_SHIFT;
>      }
> -    desc = simd_desc(vsz, vsz, scale);
> +    desc = simd_desc(vsz, vsz, desc | scale);
>      t_desc = tcg_const_i32(desc);
>  
>      tcg_gen_addi_ptr(t_pg, cpu_env, pred_full_reg_offset(s, pg));
> 


