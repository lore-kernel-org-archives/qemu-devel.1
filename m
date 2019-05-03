Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE171C43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 18:44:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A70322075E
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 18:44:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iWo6q0xk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A70322075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45929 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMdAo-0008Ti-VQ
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 14:44:43 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52199)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hMd9c-0007fy-6Y
	for qemu-devel@nongnu.org; Fri, 03 May 2019 14:43:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hMd9b-00033E-Bp
	for qemu-devel@nongnu.org; Fri, 03 May 2019 14:43:28 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:46074)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hMd9b-000322-51
	for qemu-devel@nongnu.org; Fri, 03 May 2019 14:43:27 -0400
Received: by mail-pg1-x541.google.com with SMTP id i21so3105335pgi.12
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 11:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=WQKoBhi+QtBwc882BYKvSEthkri+rnXDfG1JusKyUoI=;
	b=iWo6q0xkZAKWlK3cTNAFgdfOoZ8vQZVK6prqUr1VkHNyKXGCJdSXpe3qPyM/rnmJg3
	Cde4cgnhozSzBYDq59yWXuybLCJ7KR77SkyQdPW0HKOW1e92+AQ9gN923hzGem/AvcvC
	Yutg75i+hfp519hMMMEIgqxKPeFdrEkCH2S6+9oKwCY7fgEBNA43Ai4IZ9Y1cwKEVGLI
	rMJ2o5ESfkidmQF2eMporMaQyzlOmjxZZi6i7cofnXhaCMp+ZIg1izjGRvdnuxHBud7+
	bDKLXZV+AAusu/6z9eU1QYUCmxXBot3ViU1U19xWIy87hskmexsDvYiWb/N0phkqR3Ab
	BgbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=WQKoBhi+QtBwc882BYKvSEthkri+rnXDfG1JusKyUoI=;
	b=kVtbEFUxyFaDODIUotY+9PpFotlK1k+4Dl19gW9L0QDIqoEM1oPDL6BIgfhCJKv10B
	yFfWV081PX8W5EnC5lJpVXD2D20ADd8Z38glSSom86UlYspNGPiU309v0lCIte+b2g3f
	rGMZg/7yL44k6enAEsqKFYO4RXOPQQK4dvRHbEcRo7nPvopwoL9fDJeSHJ3Y61hXM90P
	R1QyIfKRiMI3p7Y+D/fx/LnollE15vhrSeKyfiZzPxBt1kD6CQoV3jij/cUVuWS9FOzJ
	H+CY+UHY3jAzOrq0jYMvGkUAdbiizU3RvH4TEGIzS9MD8U29Y61JryLIzy7IE7UlH8Pn
	5e/w==
X-Gm-Message-State: APjAAAWzoqnSWVGzEp14rCfuI6mF8pRYb5je7VB1I6o7lm54QlhMvvuP
	NCl8Q5s8fkoGyNEipmtDMpybVA==
X-Google-Smtp-Source: APXvYqx5Sguh8sVHvFxDzwB8hqHEbiCNS15mek1emblKX+L0vjibnSuQqYa3UTnsxUJgAwhs44igMQ==
X-Received: by 2002:a65:6289:: with SMTP id f9mr12793365pgv.380.1556909005751; 
	Fri, 03 May 2019 11:43:25 -0700 (PDT)
Received: from [192.168.1.11] (97-113-189-189.tukw.qwest.net. [97.113.189.189])
	by smtp.gmail.com with ESMTPSA id q5sm4286206pfb.51.2019.05.03.11.43.24
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 03 May 2019 11:43:25 -0700 (PDT)
To: Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-devel@nongnu.org
References: <20190502143409.59600-1-ysato@users.sourceforge.jp>
	<20190502143409.59600-2-ysato@users.sourceforge.jp>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <3de96999-eba5-fa88-0c4d-a7b27d916081@linaro.org>
Date: Fri, 3 May 2019 11:43:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190502143409.59600-2-ysato@users.sourceforge.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: Re: [Qemu-devel] [PATCH RFC v8 01/12] target/rx: TCG translation
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190503184323.RVcOipkTZJQaBa56FHNY-N8Oj2WdfUwV9jcfZhT0iKQ@z>

On 5/2/19 7:33 AM, Yoshinori Sato wrote:
> +/* conditional branch helper */
> +static void rx_bcnd_main(DisasContext *ctx, int cd, int dst)
> +{
> +    DisasCompare dc;
> +    TCGLabel *t, *done;
> +
> +    switch (cd) {
> +    case 0 ... 13:
> +        dc.temp = tcg_temp_new();
> +        psw_cond(&dc, cd);
> +        t = gen_new_label();
> +        done = gen_new_label();
> +        tcg_gen_brcondi_i32(dc.cond, dc.value, 0, t);
> +        gen_goto_tb(ctx, 0, ctx->base.pc_next);
> +        tcg_gen_br(done);
> +        gen_set_label(t);
> +        gen_goto_tb(ctx, 1, ctx->pc + dst);
> +        gen_set_label(done);
> +        tcg_temp_free(dc.temp);
> +        break;
> +    case 14:
> +        /* always true case */
> +        gen_goto_tb(ctx, 0, ctx->pc + dst);
> +        break;
> +    case 15:
> +        /* always false case */
> +        /* Nothing do */
> +        break;
> +    }
> +    ctx->base.is_jmp = DISAS_JUMP;
> +}

Do not set is_jmp to DISAS_JUMP here.  We have already set is_jmp to
DISAS_NORETURN in gen_goto_tb.  For case 15, we do not need to exit the TB in
order to treat the never-taken branch as a nop.

This assignment means that we will emit *another* exit from the TB in
rx_tr_tb_stop, which will be unreachable code.

This is the only bug I see in this revision.  Thanks for your patience!


r~

