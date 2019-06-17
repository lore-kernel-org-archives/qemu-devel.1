Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B096C31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 22:42:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03BCF208C0
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 22:42:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aCDjJxcb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03BCF208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52358 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hd0KF-0007Ey-8T
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 18:42:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36427)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hd0HY-0005NA-CJ
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 18:39:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hd0HW-0004Uv-49
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 18:39:20 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:42637)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hd0HU-0004S3-7O
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 18:39:17 -0400
Received: by mail-pf1-x442.google.com with SMTP id q10so6426055pff.9
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 15:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=8Ib9AHVpoMnLsjFKadmymVirMZiS1xyBiQ4dEr91e28=;
 b=aCDjJxcbhXXUfGDGDHyEy/AAi0c6tLpgrWu3vTNpTdWGRepfseRTMX6AHnFofkr9CD
 kc9ktqdDEfGuOu44uDAF74GCakznV7XLmJJ+utN1K1nByB0er3Hm299NFJYUE2S7/TpZ
 hjezfE2DyVJtMWX9YWMi0j7uiQ1MRSzqJjv6avCUYwNBqWiTkHCAiLa3omKBVSjqWPWR
 ds4cFVOf0f61MiVa6YkUTTP3ZPI66/ASu9v0RFAEfpzOPDHwuvviO8Jbflf8VdQNJuul
 0ElqbNGPm+jmAQJHg4Xt4kndP5FkYUZScQh0dyOSh9GfoUIu/zXqLmHtvcXwjrNl7zrY
 A5LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=8Ib9AHVpoMnLsjFKadmymVirMZiS1xyBiQ4dEr91e28=;
 b=c9H6SU/zQEV/GLfG/5sqs6HEyZ/xWErENDhP64KS6vL/YX81Eqa+4ZfXe4qAx6k3iQ
 ptP+vYf80jhjXf/b06LqAVzr7qRkGc9H67yTJFwW/9vW7iqkci7jng17RFqkbva2IQqs
 tNTR5mQHqPzvFALOXSSfqPFi1WhA3v4XBTjpZ2uEF+ii1tb3WKQNHDjDMQ5kwjkcmpAx
 w4409I9zyHV56wJAB0KmZkwFz9pGL/8dZWH4SbbdARVX4wu3ZOSlHs1ia0vnd7p8KN+R
 +u6ZghDI1yryOtq7+h1bL9Cq4+m8EHRnxuvEG1TReR4XgOzBj65ptWR9RLukurlbVVmz
 GjRw==
X-Gm-Message-State: APjAAAV0qe/S36OTvQOE8fwnAVyGBrdPU66l+4guVSG1TE4fVeNgB1qB
 0WA+TjzPRNRkIbnRaES5Oj80rA==
X-Google-Smtp-Source: APXvYqxJrXMvcpi+oAA/LnQKr48m7ybmO4FVBqqrAQEg/tRBK7dQQ26iHpJsCmKmh2JrUeiO3MFLug==
X-Received: by 2002:a17:90a:dc86:: with SMTP id
 j6mr1391108pjv.141.1560811154821; 
 Mon, 17 Jun 2019 15:39:14 -0700 (PDT)
Received: from [192.168.1.11] (97-113-2-33.tukw.qwest.net. [97.113.2.33])
 by smtp.gmail.com with ESMTPSA id k13sm12765885pgq.45.2019.06.17.15.39.08
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 17 Jun 2019 15:39:14 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190614171200.21078-1-alex.bennee@linaro.org>
 <20190614171200.21078-34-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <98e88256-7a88-b505-9bde-0836cf21c654@linaro.org>
Date: Mon, 17 Jun 2019 15:38:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190614171200.21078-34-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: Re: [Qemu-devel] [PATCH v3 33/50] target/riscv: fetch code with
 translator_ld
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
Cc: "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmer@sifive.com>, "Emilio G. Cota" <cota@braap.org>,
 Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/14/19 10:11 AM, Alex Bennée wrote:
> +++ b/target/riscv/translate.c
> @@ -793,7 +793,7 @@ static void riscv_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
>      DisasContext *ctx = container_of(dcbase, DisasContext, base);
>      CPURISCVState *env = cpu->env_ptr;
>  
> -    ctx->opcode = cpu_ldl_code(env, ctx->base.pc_next);
> +    ctx->opcode = translator_ldl(env, ctx->base.pc_next);

I'll note for the riscv folks that this is an existing bug, reading too much in
the case of an RVC instruction.  This could well matter for the last 2-byte
instruction at the end of a page.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

