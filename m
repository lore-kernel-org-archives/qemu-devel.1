Return-Path: <SRS0=e36u=CI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2439BC433E2
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2020 00:21:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D426120776
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2020 00:21:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bxMEdMct"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D426120776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCB6c-0000Bq-2S
	for qemu-devel@archiver.kernel.org; Sat, 29 Aug 2020 20:21:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39650)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCB62-0008Ah-8P
 for qemu-devel@nongnu.org; Sat, 29 Aug 2020 20:21:22 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e]:38240)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCB60-00072D-H2
 for qemu-devel@nongnu.org; Sat, 29 Aug 2020 20:21:21 -0400
Received: by mail-pf1-x42e.google.com with SMTP id d22so2588261pfn.5
 for <qemu-devel@nongnu.org>; Sat, 29 Aug 2020 17:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=A6BgnbRA18vSipqCY1DV5sZr4jMt6bV5kGzEujduOq8=;
 b=bxMEdMctn9mOWkPtwwHykgdKtqQzVTeYO7i2UEeTxKWxXNESugkuLgLPECacOUnZjk
 DtbriCr2YDjICfmeBn3tAca6TNWQ1OGx0NFN6V7nDai26TVHM21u5jTmoYw6hRlp0FG7
 YK8uHDGwPyFkFSveVWcak3hmSOQZCVuHJshpd/uTk2u5uvPom+4D28luc6TO2l3XSoWo
 cdfjwqxhKqDWDBp2zUv/quOQ4Sy1rG8AeS/a2jL86Zkili2zIeAc53LyUHIrPe5rWyX0
 8pwUZlUdKdDhwWzXtOYRQoY/Qq8j2KfzX1l4sTKxUTQGGmoLcn8F1P2EJh/rrZB8lh0W
 5QGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=A6BgnbRA18vSipqCY1DV5sZr4jMt6bV5kGzEujduOq8=;
 b=DIst91URivwx5mAZp0osMzo3STMNQ9DsegZ4mlHHJGMDvy42rDNZ604qr8uq4hpvPp
 jBtcI5blrVkmGaptcG/3ccR6xxhyu3yGFebK+JG98HOCshfNUT7PbtEUuf8zPaKC4qXK
 CkZptHu0f8StgAhHH9dJsvgJRmt6lKIiK9Cedo+Zdm5KbOYEeLthWjAhbqjomI4glhKj
 PtRiv5c2GJNcmSJW1yvZRKrY48C4mzPxJSo1skFJGnTgWrKKoN2EfElzqmZc0nDQbTmW
 5ZZam3xXcLTJY9vYAqQwI3LIzpvkL8Q82Szqlr7IDPUudd/7R3tuhmJUVDJDqDeLs8Pd
 cl4A==
X-Gm-Message-State: AOAM532DIlWhwQbUFMqA3kw/ksEVntBCAiAvXLiSLNajyzCJSOr3LR32
 0zqTp3pygtBWodBp8lYe91YtcA==
X-Google-Smtp-Source: ABdhPJwqgecP7V83yziwpHMydnflL+GkoWkJdb9poz5w8uTZWWPPwgd4rjFi1ChBc73N3tIXWXi4vw==
X-Received: by 2002:a63:2bd1:: with SMTP id r200mr3819095pgr.20.1598746878847; 
 Sat, 29 Aug 2020 17:21:18 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id s8sm3817897pfc.167.2020.08.29.17.21.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 29 Aug 2020 17:21:18 -0700 (PDT)
Subject: Re: [RFC v4 66/70] target/riscv: rvv-1.0: narrowing
 floating-point/integer type-convert
To: frank.chang@sifive.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
References: <20200817084955.28793-1-frank.chang@sifive.com>
 <20200817084955.28793-67-frank.chang@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a2de75c0-67ab-3079-4ef9-459c2e0a04ab@linaro.org>
Date: Sat, 29 Aug 2020 17:21:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200817084955.28793-67-frank.chang@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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
> +DEF_HELPER_5(vfncvt_rod_f_f_w_h, void, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_5(vfncvt_rod_f_f_w_w, void, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_5(vfncvt_rtz_xu_f_w_b, void, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_5(vfncvt_rtz_xu_f_w_h, void, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_5(vfncvt_rtz_xu_f_w_w, void, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_5(vfncvt_rtz_x_f_w_b, void, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_5(vfncvt_rtz_x_f_w_h, void, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_5(vfncvt_rtz_x_f_w_w, void, ptr, ptr, ptr, env, i32)

These helpers are redundant with the ones that don't specify rounding mode,
because you already handled that in the translator.


r~

