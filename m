Return-Path: <SRS0=xv8e=AB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12A9CC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2020 17:32:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D295823D6A
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2020 17:32:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XhNowU49"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D295823D6A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmhLx-0001SX-TK
	for qemu-devel@archiver.kernel.org; Sat, 20 Jun 2020 13:32:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52814)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jmhKw-000133-5Z
 for qemu-devel@nongnu.org; Sat, 20 Jun 2020 13:31:26 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:33651)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jmhKu-0005Nu-Eg
 for qemu-devel@nongnu.org; Sat, 20 Jun 2020 13:31:25 -0400
Received: by mail-pj1-x1044.google.com with SMTP id b7so5376816pju.0
 for <qemu-devel@nongnu.org>; Sat, 20 Jun 2020 10:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=h8w0zeD+2iRu42vrg2ySPNA/mgdJAEaqa20flumzPNw=;
 b=XhNowU49PWXaPQD5cg3QNLsDMGhALqs9tKMkdfAY4UmdX4TD6gLt5et6OKpZ3m6RI2
 YHUT9yyw+mMbca/dHEcvmnpR6GuQaXTwv8nFClotUw5Et8XfrWTV6DsLKXGLTjk77TE4
 B35zGF2leFv89u8Xfqwj+BjdhtfY8Y5f53TiKQKNGDkDhbbDqba5U6NKp90xucAHNxvw
 3rBLM+GGy3ydLpIJjvxtqyiS6Do/ZeMbi1Q9Zf6QjTK+NDgRkF7moGwwkpvrsgjk1TT3
 7ywJ2gR1cPE/8HvDIBwpwdYLwp08w1rLATCIih3OZDa0t9TIUUO2DU7X352hoUXTZUgy
 IusA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=h8w0zeD+2iRu42vrg2ySPNA/mgdJAEaqa20flumzPNw=;
 b=ugzma+iZo6Ltzjx6gBpdnPfN93mOsEOr0IbxPPyQnpPCIk/b20w9V2yVBCT6dwnQRb
 X6lsYPobikgrmgOQeGrHe9xmrntfaR3umEfuUrfOu9L7uCXgJFAuUF/Vj2WFHBZ+Kuay
 aKApFBLhnw9C1fG1r5nhK3oLInnYzuXJ8JiY5GtLgt7k7exnOJ2MHAhAyyQUkMaJvlv+
 VbIDyaqz4S0oJachRpHz5pXM9/krOIXpBWkmxaOlYfj+djiAyjptCR53sVunhpf/NVlm
 FpGdZx9SPZ7kF9Qp1f1FedR9zjZ21LxbtO+vdAYwMxu6HY/x1TufrMXnqMwgP/9IxqpN
 wVjg==
X-Gm-Message-State: AOAM533i9cAuUx4o8Xslj+CZp8yt5b1EBoYSwd/1ADRP52b2+1zSH0G3
 eQPHzMkQm8VuIhh+1tyTurPW8g==
X-Google-Smtp-Source: ABdhPJzBtNymeY6/FBOlOO5aYD2BZNLHn7Tnc9u5jEAMhXNVtfsBem2yYvVLx4H/tV+1P3sE0GBomA==
X-Received: by 2002:a17:902:7297:: with SMTP id
 d23mr13159592pll.282.1592674282789; 
 Sat, 20 Jun 2020 10:31:22 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id c2sm7508909pgk.77.2020.06.20.10.31.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 20 Jun 2020 10:31:21 -0700 (PDT)
Subject: Re: [PATCH rc1 12/15] hw/rx: Register R5F562N7 and R5F562N8 MCUs
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Richard Henderson <rth@twiddle.net>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-devel@nongnu.org
References: <20200617191519.14842-1-f4bug@amsat.org>
 <20200617191519.14842-13-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <424fef31-e380-14c1-1432-4a9a17c85ab7@linaro.org>
Date: Sat, 20 Jun 2020 10:31:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200617191519.14842-13-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1044;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1044.google.com
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
Cc: Magnus Damm <magnus.damm@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/17/20 12:15 PM, Philippe Mathieu-Daudé wrote:
> +    /* XTAL range: 8-14 MHz */
> +    if (s->xtal_freq_hz < 8e6 || s->xtal_freq_hz > 14e6) {
> +        error_setg(errp, "\"xtal-frequency-hz\" property in incorrect range.");
> +        return;
> +    }
> +    /* Use a 4x fixed multiplier */
> +    s->pclk_freq_hz = 4 * s->xtal_freq_hz;
> +    /* PCLK range: 8-50 MHz */
> +    assert(s->pclk_freq_hz <= 50e6);

It's just startup, so it's not vital, but forcing floating-point comparisons
just because the notation is shorter isn't ideal.

Perhaps just a local "const uint32_t MHz = 10000000;", and some multiplies.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

