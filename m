Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C298DC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 03:33:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E3F7206DC
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 03:33:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VeUPsdHJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E3F7206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jggd0-0003q7-S0
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 23:33:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50072)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jggbO-00029i-MG
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 23:31:34 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:44381)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jggbN-0001lU-Jo
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 23:31:34 -0400
Received: by mail-pg1-x541.google.com with SMTP id p30so2885851pgl.11
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2020 20:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=C0JzT8yHVfGrQdMTy4VeGO2ZN5h2IrtHRVZLo1LCzzQ=;
 b=VeUPsdHJtfPDQ6KriduKThLC9QtNAthfXWhpnlF8u/TAPAGFoVQKiGjfBBx5sKrW3d
 vT3hOE4gitVL4F20Uq/Dadso5ISiVsK0yP9avSiYRhP2Xleyv5fDpS48v3r48a8jfydu
 Pstq719Qm2vmcCDOQ1POeUmbj1BsAk5bzyuhT1quAtfBnqPem2jPx1d+r0v9cE7ZaLVf
 xVonDaXxQaAhOuCoMRycPFs+JsEqQRUOUhh6Crc0Z1lqMk4eyZ6B1MzNsrrphxJ4yCL1
 7p8VHv2AsxJDasyprFXwnisMtiN9dqquaMpdNd4maDAy1BJTQToDCD3bX3NmxIh9GYXD
 XcNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=C0JzT8yHVfGrQdMTy4VeGO2ZN5h2IrtHRVZLo1LCzzQ=;
 b=aFBUfRLr/lcr9+wn4YGAHd1HROwESh3lZGbBWUzM0fdGN37ht1XvGmf7mqHBJC2yXt
 hSOvEcUWYsFbyAf6cVE+blOLtCZpThJG+j2zrmnEZC+FVWT0ejdiIDYFxSxo08PrYEpp
 XbxOkDumVBOegu8de2aePdPw/K5M64CG17m+qszhJGd+UHSu52GRsXkVBFYvnq6jRkE+
 7W0sKGBcwlBinowJgm2Y5MxossWIE7064U/zy4BvQa52/n4jimk+0h2hc5eXM0PqQTWt
 +kNnxAu3iva9Ye4ZSRSqu4f4G66Xu5XrWRxx99v8t6FZCwKNYJNARh7O/vu1hMSvPuR+
 VEsg==
X-Gm-Message-State: AOAM532NNRBlx01Tz/7jzC3bvRF9n+Br0ffw3ILjlCxzvraZSHRrehpg
 yNunM5A4BLzFu1+OE0l5WjljnA==
X-Google-Smtp-Source: ABdhPJzGVaICKEYS8tJduSXlwBdokeh9cNGdjSLnnqLUYoOKMmt4fgOFSA2Hj781GhfBmud7686vog==
X-Received: by 2002:aa7:84cf:: with SMTP id x15mr2201718pfn.214.1591241491563; 
 Wed, 03 Jun 2020 20:31:31 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id q6sm78002pff.79.2020.06.03.20.31.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jun 2020 20:31:30 -0700 (PDT)
Subject: Re: [PATCH v4] tcg: Sanitize shift constants on ppc64le so that shift
 operations with large constants don't generate invalid instructions.
To: agrecascino123@gmail.com, qemu-devel@nongnu.org
References: <20200604015027.8075-1-agrecascino123@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <3e3791fc-ef38-b785-943a-8ee575fc0677@linaro.org>
Date: Wed, 3 Jun 2020 20:31:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200604015027.8075-1-agrecascino123@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::541;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x541.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: "Catherine A. Frederick" <chocola@animebitch.es>, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/3/20 6:50 PM, agrecascino123@gmail.com wrote:
>  static inline void tcg_out_shri64(TCGContext *s, TCGReg dst, TCGReg src, int c)
>  {
> +    tcg_debug_assert((c < 64) && (c >= 0));
>      tcg_out_rld(s, RLDICL, dst, src, 64 - c, c);
>  }
>  
> @@ -2610,21 +2614,33 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, const TCGArg *args,
>  
>      case INDEX_op_shl_i32:
>          if (const_args[2]) {
> -            tcg_out_shli32(s, args[0], args[1], args[2]);
> +            /*
> +             * Limit shift immediate to prevent illegal instruction
> +             * from bitmask corruption
> +             */
> +            tcg_out_shli32(s, args[0], args[1], args[2] & 31);

Why are you duplicating these?

I suggested masking, and now you are, but you're also retaining the assert.
What's the point?  Just mask, IMO.

>      case INDEX_op_sar_i64:
>          if (const_args[2]) {
> -            int sh = SH(args[2] & 0x1f) | (((args[2] >> 5) & 1) << 1);
> +            /*
> +             * Same for SRADI, except there's no function
> +             * to call into.
> +             */
> +            int sh = SH(((args[2] & 63) & 0x1f)
> +                        | ((((args[2] & 63) >> 5) & 1) << 1));

As for this, there's zero point.  We are already masking.  You can see it right
there.


r~

