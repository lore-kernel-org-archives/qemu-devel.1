Return-Path: <SRS0=OYoK=CH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9585C433E6
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2020 20:33:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 502A320776
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2020 20:33:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fyEWRY9l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 502A320776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kC7Xm-0007iJ-BG
	for qemu-devel@archiver.kernel.org; Sat, 29 Aug 2020 16:33:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39406)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kC7XC-0007Fe-Gm
 for qemu-devel@nongnu.org; Sat, 29 Aug 2020 16:33:10 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635]:37747)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kC7X9-0000na-H2
 for qemu-devel@nongnu.org; Sat, 29 Aug 2020 16:33:10 -0400
Received: by mail-pl1-x635.google.com with SMTP id c15so1234561plq.4
 for <qemu-devel@nongnu.org>; Sat, 29 Aug 2020 13:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=bneXAIvgUKA99+pRDoxmvVUuXckT4RdsTwV/ons77qg=;
 b=fyEWRY9l77tmd4vQxkl/BkAk2amfQWFuXfp3By7LYIj+alkYbkVgC87T8HqFx5m9Ko
 1/oK2CecWmeblP5WhJdMFSwh/rN0YRZ8VnkOLXm8HnqH2jx5qVdB6w/4dOsAynSyD35g
 8qG+Y9hGaiGQO2oiyHMFjRzz2ICawmfbty6ZOzqiyNuaFCaSDAiVwXqeuLazsQHwWT+G
 TyC9pav6ofBJCZsSqOlIdar+ojcakbP9qpLaO0u5iPiVQSG/PRhgoxc81CDdnW1AKZKm
 SaMJVvSrNNbJnN8z60D8E/ucqKlig1CwJ4jNbf9/SCyt7rJ8eVp5ASXc+Qso2FxbvT1x
 5ANA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=bneXAIvgUKA99+pRDoxmvVUuXckT4RdsTwV/ons77qg=;
 b=j492I07iFwrkMLZ5tuVnfc6wd/GYhsHs+n2CkEs8/YNzvRo8AY3hOkhUHkywBbyfEx
 hNtcufvcZnNs/cFiv7YjU0XoYg70YYCwENIzSaFXBFIkFBmRoXeOMCKPKX6kudofrcJu
 laXQDNP+8Ik7dgExs0Temecv9VrKrzcHni8ODW6Fuvjfqrg/bbFqwvzFlRcQrkG6j/Se
 qyWuSDFdZJQXBDJBVc5hZkI4yYdX3TapDdmH3BnKbRbJWhrJcC/oluMtNLe3Yu9EcYMb
 lQSK5TsNjLGCVD6LbMpZR/wWePm9LHLIuoHnx1MO4ZWUGNI7fIMOjHFXEkAn5Dp20rDY
 lgxA==
X-Gm-Message-State: AOAM533sj9+EOzgnOips1VLU2bVi1m4vmGweStckTMp2LG7etbNnPG7H
 Fri5nX9Vq4RSRNcOT1BqfaceSg==
X-Google-Smtp-Source: ABdhPJyeqiRZ3fS8WDzlzw9MSRu8hJTJ1aUHnDbCHrOS/E1Wvm6HOYz1IzpVJFu8sr1KyQx26iKqUQ==
X-Received: by 2002:a17:90a:bf8d:: with SMTP id
 d13mr4346326pjs.100.1598733185871; 
 Sat, 29 Aug 2020 13:33:05 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id o15sm776881pgi.74.2020.08.29.13.33.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 29 Aug 2020 13:33:04 -0700 (PDT)
Subject: Re: [RFC v4 53/70] target/riscv: rvv-1.0: floating-point slide
 instructions
To: frank.chang@sifive.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
References: <20200817084955.28793-1-frank.chang@sifive.com>
 <20200817084955.28793-54-frank.chang@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <96b9fa44-5a1b-2ac0-04ae-fa4d2857096e@linaro.org>
Date: Sat, 29 Aug 2020 13:33:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200817084955.28793-54-frank.chang@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.809,
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

On 8/17/20 1:49 AM, frank.chang@sifive.com wrote:
> +DEF_HELPER_6(vfslide1up_vf_h, void, ptr, ptr, i64, ptr, env, i32)
> +DEF_HELPER_6(vfslide1up_vf_w, void, ptr, ptr, i64, ptr, env, i32)
> +DEF_HELPER_6(vfslide1up_vf_d, void, ptr, ptr, i64, ptr, env, i32)
> +DEF_HELPER_6(vfslide1down_vf_h, void, ptr, ptr, i64, ptr, env, i32)
> +DEF_HELPER_6(vfslide1down_vf_w, void, ptr, ptr, i64, ptr, env, i32)
> +DEF_HELPER_6(vfslide1down_vf_d, void, ptr, ptr, i64, ptr, env, i32)

You shouldn't need any new helpers.

The fp scalar argument can be passed to the existing helpers.

The manual doesn't explicitly say, but I assume the fp scalar needs to be
nan-boxed (for sew > flen), or checked (for sew < flen), just like the scalar
move instructions.


r~

