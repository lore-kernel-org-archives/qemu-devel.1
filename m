Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F04DC433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 23:55:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC3CA20659
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 23:55:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VGtAGrQk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC3CA20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtJuY-0006MM-1Z
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 19:55:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39834)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jtJtn-0005qF-7q
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 19:54:47 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:55386)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jtJtk-0004FH-8P
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 19:54:46 -0400
Received: by mail-pj1-x1043.google.com with SMTP id ch3so266027pjb.5
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2020 16:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=4jkspg1PQPwKjqx6El5xsURFzqeD7o0p1MfPqCG92EI=;
 b=VGtAGrQksO42gTjY7c/PM64NV/8iqhrCGTxufc5qV78NMT73C20QW4Ks9JecpZrSyI
 1BAoGC8URAnNTedE/8/eYqAqRsAQoVIrLO4X8EQL9rM1G4F/SVn23CM+3/z4xR6MmknU
 HY+4M1R8kRStsEAPvhmnCD1SJPadQcGqgpK79O68X87eleqlkf5wpecM82OjM4xHs+9a
 XgTLk6aFBQ29vrWdCvi1zrQiaq8XQUn+KP9wDD1iY6l0AMffra1G/ZzEmQFRAcooOWeQ
 9+FjXaijnDBMos04ILVP/2ylleRV68ezEwvPoAAKqOU+sV9i/kPa7Hy8lzrJXzieNIDF
 QYnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4jkspg1PQPwKjqx6El5xsURFzqeD7o0p1MfPqCG92EI=;
 b=Yptq+Ywx8ZYj5bNt+j0kfcRM1tXOYNo3zpKLeBZOeGgovVBYkKXgtbnU5MryAMyP/m
 NWjSqwfzhvhPBMASt+ySI0GfotfgK4e0ik8EyDOpR7zmLk4t5U0rtHkb6N0U6fsnsaT6
 iDmV71aLZIs+6PKh4au3B+g4gXvL7sG6NKJUJ+VIuIzJoouw02ClBoCnLFgfNtKohAjR
 HN9IseqrUDypraGuG3NspadrO35+SYRhNAoFLxhJSBGORyTU/RoZLrSOLInxE+qdJfzb
 9PvG0aFFK011kdgkbRv81jrykHlkmhJ97gvg2wivZpzalvicxLjiMrrX+VrBMOJUvndp
 X6nQ==
X-Gm-Message-State: AOAM533XHbEdKVTcDFjvUpDvqpXMM2ppXIH/w5IzzvtLbmNN8n+Ufc1C
 kLTvxB0zg2XiR5U3/xlCcrUdbA==
X-Google-Smtp-Source: ABdhPJxTnbeCL/2WydQC1WTyMCnAu5vy5y5fCYs3GZgsp93LfOZaLY2suEeLisjyV6xk+IFG+d8LEw==
X-Received: by 2002:a17:90a:254f:: with SMTP id
 j73mr11043270pje.16.1594252482285; 
 Wed, 08 Jul 2020 16:54:42 -0700 (PDT)
Received: from [192.168.7.121] (24-113-145-216.wavecable.com. [24.113.145.216])
 by smtp.gmail.com with ESMTPSA id s10sm545585pjl.41.2020.07.08.16.54.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jul 2020 16:54:41 -0700 (PDT)
Subject: Re: [PATCH v3 01/21] softfloat: make NO_SIGNALING_NANS runtime
 property
To: Max Filippov <jcmvbkbc@gmail.com>, qemu-devel@nongnu.org
References: <20200708222101.24568-1-jcmvbkbc@gmail.com>
 <20200708222101.24568-2-jcmvbkbc@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <fc12955c-6831-ff3a-c6d5-c1165c1ec9aa@linaro.org>
Date: Wed, 8 Jul 2020 16:54:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200708222101.24568-2-jcmvbkbc@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/8/20 3:20 PM, Max Filippov wrote:
> target/xtensa, the only user of NO_SIGNALING_NANS macro has FPU
> implementations with and without the corresponding property. With
> NO_SIGNALING_NANS being a macro they cannot be a part of the same QEMU
> executable.
> Replace macro with new property in float_status to allow cores with
> different FPU implementations coexist.
> 
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: "Alex Bennée" <alex.bennee@linaro.org>
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
> ---
> Changes v1->v2:
> - use inline function for no_signaling_nans property to allow for
>   constant folding on architectures that have this property fixed.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

