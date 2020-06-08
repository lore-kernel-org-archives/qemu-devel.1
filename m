Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BFECC433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 17:30:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DF23206C3
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 17:30:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zg7VS9Hu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DF23206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiLbQ-0002EV-Io
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 13:30:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50814)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jiLa8-0001N7-RO
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 13:29:08 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:34278)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jiLa8-0007Im-1q
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 13:29:08 -0400
Received: by mail-wm1-x341.google.com with SMTP id u26so485706wmn.1
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2020 10:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=F10UTdwUpQwcUEGmI8bNx/iYi7AdqD3Et65iJeDPTzw=;
 b=Zg7VS9HuLnTjHXkYoSQMdQqDPOLrmpmF+NWF6yYQeu4z+5VwjoHvPPkzm8v727XL45
 kQxpG7nab7sx7FEl+bVTklwaOiWEGrEJuj8QhB8zrY7TSTKFGBR7+LvX7gXRBNZj5V2O
 nmS7vGUCxEBdNZb9qxvFmji8R2zqxLFy5HVDndnWnmWqF+zOQTo/ODLW6hE3K3EJ3Z/n
 /Yvti4UxLJ7n+Or7qNct6zbdxXAodWKaapn0sap6DDq/XGo+sFBw7rY4riiEG4xuMUjE
 JLu1zhwg7RKzZGbOLtzCgo3uIRb78POmbTnbPYuhs0QY8EFMCFujHaYgyLGQVOWQ6eWJ
 i6og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=F10UTdwUpQwcUEGmI8bNx/iYi7AdqD3Et65iJeDPTzw=;
 b=oYFqZLYG2YoVcYCmxCLHnm9obisi/jvl+a2fUFDFGaD+ahAP2SdHupnGmY2LWLQKQG
 M247AZC4HW5kL7jyzCpcFVwBmJ8hCebRHWeyDrk2YRA7yjixhWtx1IgKx/5lu1BB/sIt
 GjhZezFm5dx4vBnq0yN2uYb/N3ydRCVbZKTrdUHlxWNm3u1t0Q4D4pr1g5os22cXoGBg
 RyRVrDKBrwzicoKN+4UsVoug8/m11SMDBYv1h9nucGuaBaL49bZUP+PRIJvpEf0zr8wF
 SHmQsRt8odt+czE05mOEgxyRI8yy/4xbCia5H+ezVPFZnAfqm88ASAsWPkuvmjU8fGls
 dJ4g==
X-Gm-Message-State: AOAM5308fj3LZ8tdWmuVSbMWMrqsx8NRI9+FoRBIY+hxo8h/neDFzmFD
 RPeXRWM9ezMTHbjWtG98dJw=
X-Google-Smtp-Source: ABdhPJwVf5KQRHZyonguy7fYXf+NJgEvCHNxzcLAuqqTTtUuEACwIVhzpxos5NBiAoeDvIzOYNqLMg==
X-Received: by 2002:a05:600c:4146:: with SMTP id
 h6mr401205wmm.170.1591637346742; 
 Mon, 08 Jun 2020 10:29:06 -0700 (PDT)
Received: from [192.168.1.38] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id a14sm402784wrv.20.2020.06.08.10.29.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jun 2020 10:29:05 -0700 (PDT)
Subject: Re: [PATCH] linux-user/sparc64: Translate flushw opcode
To: LemonBoy <thatlemon@gmail.com>, qemu-devel@nongnu.org, laurent@vivier.eu, 
 richard.henderson@linaro.org
References: <894ec93e-05dd-2110-a0c2-e0afa2fa6fd5@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <4e18dd0a-8cce-c009-f1f5-4756566b0403@amsat.org>
Date: Mon, 8 Jun 2020 19:29:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <894ec93e-05dd-2110-a0c2-e0afa2fa6fd5@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

Hello Giuseppe,

On 4/10/20 11:14 PM, LemonBoy wrote:
> From 11d0cfe58d12e0f191b435ade88622cfceb2098a Mon Sep 17 00:00:00 2001
> From: LemonBoy <thatlemon@gmail.com>
> Date: Fri, 10 Apr 2020 22:55:26 +0200
> Subject: [PATCH] linux-user/sparc64: Translate flushw opcode
> 
> The ifdef logic should unconditionally compile in the `xop == 0x2b` case
> when targeting sparc64.
> 
> Fix the handling of window spill traps by keeping cansave into account
> when calculating the new CWP.

Thanks for the fix.

Do you mind addressing the comment Richard suggested?

Thanks!

Phil.

> 
> Signed-off-by: Giuseppe Musacchio <thatlemon@gmail.com>
> ---
>  bsd-user/main.c             | 4 +++-
>  linux-user/sparc/cpu_loop.c | 4 +++-
>  target/sparc/translate.c    | 2 ++
>  3 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/bsd-user/main.c b/bsd-user/main.c
> index 770c2b267a..d6b1c997e3 100644
> --- a/bsd-user/main.c
> +++ b/bsd-user/main.c
> @@ -413,7 +413,9 @@ static void save_window(CPUSPARCState *env)
>      save_window_offset(env, cpu_cwp_dec(env, env->cwp - 2));
>      env->wim = new_wim;
>  #else
> -    save_window_offset(env, cpu_cwp_dec(env, env->cwp - 2));
> +    /* cansave is zero if the spill trap handler is triggered by `save` and */
> +    /* nonzero if triggered by a `flushw` */
> +    save_window_offset(env, cpu_cwp_dec(env, env->cwp - env->cansave - 2));
>      env->cansave++;
>      env->canrestore--;
>  #endif
> diff --git a/linux-user/sparc/cpu_loop.c b/linux-user/sparc/cpu_loop.c
> index 7645cc04ca..20a7401126 100644
> --- a/linux-user/sparc/cpu_loop.c
> +++ b/linux-user/sparc/cpu_loop.c
> @@ -69,7 +69,9 @@ static void save_window(CPUSPARCState *env)
>      save_window_offset(env, cpu_cwp_dec(env, env->cwp - 2));
>      env->wim = new_wim;
>  #else
> -    save_window_offset(env, cpu_cwp_dec(env, env->cwp - 2));
> +    /* cansave is zero if the spill trap handler is triggered by `save` and */
> +    /* nonzero if triggered by a `flushw` */
> +    save_window_offset(env, cpu_cwp_dec(env, env->cwp - env->cansave - 2));
>      env->cansave++;
>      env->canrestore--;
>  #endif
> diff --git a/target/sparc/translate.c b/target/sparc/translate.c
> index 9416a551cf..1a4efd4ed6 100644
> --- a/target/sparc/translate.c
> +++ b/target/sparc/translate.c
> @@ -3663,6 +3663,8 @@ static void disas_sparc_insn(DisasContext * dc, unsigned int insn)
>  #endif
>                  gen_store_gpr(dc, rd, cpu_tmp0);
>                  break;
> +#endif
> +#if defined(TARGET_SPARC64) || !defined(CONFIG_USER_ONLY)
>              } else if (xop == 0x2b) { /* rdtbr / V9 flushw */
>  #ifdef TARGET_SPARC64
>                  gen_helper_flushw(cpu_env);
> 


