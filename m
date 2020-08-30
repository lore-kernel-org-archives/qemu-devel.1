Return-Path: <SRS0=e36u=CI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2BD8C433E2
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2020 00:15:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FF2E206D8
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2020 00:15:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pLSSmpnE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FF2E206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCB0U-0005B1-Pt
	for qemu-devel@archiver.kernel.org; Sat, 29 Aug 2020 20:15:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38572)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCAzs-0004hR-U1
 for qemu-devel@nongnu.org; Sat, 29 Aug 2020 20:15:00 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532]:44199)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCAzr-0006Is-7u
 for qemu-devel@nongnu.org; Sat, 29 Aug 2020 20:15:00 -0400
Received: by mail-pg1-x532.google.com with SMTP id m34so2279066pgl.11
 for <qemu-devel@nongnu.org>; Sat, 29 Aug 2020 17:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=s3HSpAreezfoFBiffbGQoeWj4dJLtxR5T02v3WHo61Q=;
 b=pLSSmpnE79qYu8XHlGFgiznWuugc83pH7ddnSXHmkeXyGwp7K3eGaa1O9Urpedel12
 xL4nx32Nq6vjDCE5ERIlJLzVIwp6dim5/JUpDN/oLfvSCxVak4JNfO5Zdc2OhiJjYJAE
 LsABs0bfoVkI8iDXqk/bMgR7vGbmUymvX/whyN9s3DEL2J3o6/5m2uBqgtiXeBRbvhDp
 0cOarJrbQZa6pgmlbO4VvERGidzuvWHtXyHf38c0j33N4LhqEbYoKcxuqpnO9hN0rbY4
 yMwgxNjqBPwIWxOmUs3XXZysjCX+46EKxHf8NRzwwISVlc34I16MTeoWlLuXL5gDJ8gL
 lKhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=s3HSpAreezfoFBiffbGQoeWj4dJLtxR5T02v3WHo61Q=;
 b=jR2GthBMhO314oN1AU6EGBMJbMnVzh4eCfk8WQXRVeVdrlYjoCpIbrnN28jLaQRnvH
 HE14ibDyz0ansUBQymwE65KLztaqYYHbdAB/JXExPQuWabAnd8zJWLusd2h+iHnmdZNi
 VDJXQFBuyuGSRt6NFSRqGteodYrMeE9kTNJ9wRzmBN+U3s+GQjlwshOZM1KcLPZMy8ew
 dTgmmzNT3UxmLsjCvuY3F8bvs8i7L2TAitIgc5CsDtz7gG4Ptu5fJ4/gUKyzEflWcbwf
 yT3zMKismtQAdEyWDGAFl/zS1ufCAjwisyNU9lcit5MOa/XigZ5/qTazX0Ho/tnmpKJf
 p2xw==
X-Gm-Message-State: AOAM531kTwaEPy+sfLSZBXUj4I9EEzv6PU1C0rgvuUYLb7URVoabyyir
 Irb+7g+7ruGRzdiaX2Khf8Jysw==
X-Google-Smtp-Source: ABdhPJyyDXp2Nafuh2I5NEcW9aVpt7m9HIWKjMafqqXFL5dGM2yFQjnEzv0z/XnY9L68YHzxblXblw==
X-Received: by 2002:aa7:96cf:: with SMTP id h15mr4377631pfq.294.1598746497675; 
 Sat, 29 Aug 2020 17:14:57 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id r91sm3037749pja.56.2020.08.29.17.14.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 29 Aug 2020 17:14:56 -0700 (PDT)
Subject: Re: [RFC v4 64/70] target/riscv: rvv-1.0: widening
 floating-point/integer type-convert
To: frank.chang@sifive.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
References: <20200817084955.28793-1-frank.chang@sifive.com>
 <20200817084955.28793-65-frank.chang@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <432875a6-295d-6c1e-18fe-2db968fada70@linaro.org>
Date: Sat, 29 Aug 2020 17:14:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200817084955.28793-65-frank.chang@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x532.google.com
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
> @@ -995,12 +995,18 @@ DEF_HELPER_5(vfwcvt_xu_f_v_h, void, ptr, ptr, ptr, env, i32)
>  DEF_HELPER_5(vfwcvt_xu_f_v_w, void, ptr, ptr, ptr, env, i32)
>  DEF_HELPER_5(vfwcvt_x_f_v_h, void, ptr, ptr, ptr, env, i32)
>  DEF_HELPER_5(vfwcvt_x_f_v_w, void, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_5(vfwcvt_f_xu_v_b, void, ptr, ptr, ptr, env, i32)
>  DEF_HELPER_5(vfwcvt_f_xu_v_h, void, ptr, ptr, ptr, env, i32)
>  DEF_HELPER_5(vfwcvt_f_xu_v_w, void, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_5(vfwcvt_f_x_v_b, void, ptr, ptr, ptr, env, i32)
>  DEF_HELPER_5(vfwcvt_f_x_v_h, void, ptr, ptr, ptr, env, i32)
>  DEF_HELPER_5(vfwcvt_f_x_v_w, void, ptr, ptr, ptr, env, i32)
>  DEF_HELPER_5(vfwcvt_f_f_v_h, void, ptr, ptr, ptr, env, i32)
>  DEF_HELPER_5(vfwcvt_f_f_v_w, void, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_5(vfwcvt_rtz_xu_f_v_h, void, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_5(vfwcvt_rtz_xu_f_v_w, void, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_5(vfwcvt_rtz_x_f_v_h, void, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_5(vfwcvt_rtz_x_f_v_w, void, ptr, ptr, ptr, env, i32)

Similarly, these last 4 helpers are not required.


r~

