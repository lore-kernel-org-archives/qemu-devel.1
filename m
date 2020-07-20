Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5190EC433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 17:49:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27CB620709
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 17:49:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lrcb76eg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27CB620709
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42516 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxZup-000520-Bw
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 13:49:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53390)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jxZu9-0004Tb-AA; Mon, 20 Jul 2020 13:48:45 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:52199)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jxZu7-00078l-Kb; Mon, 20 Jul 2020 13:48:45 -0400
Received: by mail-wm1-x343.google.com with SMTP id 22so355777wmg.1;
 Mon, 20 Jul 2020 10:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=XNh1PO5kcqzpMNMOPoj7ZQMIDMEvxXcc7xfkMeNGXsM=;
 b=lrcb76egCL9OyKm/no66LLsJuMt9MQ3AyKEdWPTxcIJuE6yR5ls2CBXCgyXf64XJnx
 g+cE8KJwXPvZBn3LQ0dPD39ek0EMK+1rY5uxNC+FA49ENbp+9QthA44bz7sWjJrVvdCF
 DGcmkZ6QPRBRrLCmoVs2zwyQK2i09r0TjjoYQbsy8pr7wodhJBSqhlZU55lCAeTq5WPg
 s+2OAbyiDYEMWOQ+IWANxgPGrXvPt8nRaF6nCEsX5T1m5Wuq3B4G/QDXlBW7g/jiTpoN
 Mn9IKkhqOWaAiTrolOKxSbGyY+GHcJvfOZ0Ybiu7bjxK2Ovm6moAkaOKg04bWdfR81XE
 k39Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=XNh1PO5kcqzpMNMOPoj7ZQMIDMEvxXcc7xfkMeNGXsM=;
 b=X1H9xxp4tlDqLKilgnk6sp2hXJNQKjwpwz/HKfRxNuq7pJOU4pgfdEwTdVy2SF5gm/
 KqwRk3/LpmNobOnxXnSozKrNLXAxuYX/IvAqW+iHqi/xjXaN9IVz4HV2mu2VDcGW0G+Q
 NUoS88imTrh5QW8tZcuxf5c9HyDA0X9wV04XpUwtYs3NRa52pXT1HZIsMuovzZYqL3CO
 0sDYHroWcpPo+q0zDrUxoWgUnMrAVoftUC5Chn6D56/D5lgq6+pVpbK6IAAOcZJwqVvi
 qTHBtGmvG60le+LSAc18g2UFR1tK3wFDMwDgn1m4p02MwTs0JVuFRgnSQ+oO06vsrKaN
 3wZw==
X-Gm-Message-State: AOAM531qC9Adx2mV/NBv4V3oAgIDLXmeobImdFkJk54/WTVqlydoXCrD
 vfoFxmeUDx1NBH2UWO/Lk/sed1EAL60=
X-Google-Smtp-Source: ABdhPJxkciZR738Hn/yzfyBd/Ao3poG3+5nLb4WKTuyTVbHKVCteuvF3hZWHDvgAzBmLgzxKeSi0pw==
X-Received: by 2002:a7b:c936:: with SMTP id h22mr411726wml.114.1595267321507; 
 Mon, 20 Jul 2020 10:48:41 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id g18sm9459264wru.27.2020.07.20.10.48.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jul 2020 10:48:40 -0700 (PDT)
Subject: Re: [PATCH for-5.1] target/hppa: Free some temps in do_sub
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200720174039.517902-1-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <ed792cb4-ae52-47b2-df34-68cbd31cd48e@amsat.org>
Date: Mon, 20 Jul 2020 19:48:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200720174039.517902-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: deller@gmx.de, svens@stackframe.org, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/20/20 7:40 PM, Richard Henderson wrote:
> Two temps allocated but not freed.  Do enough subtractions
> within a single TB and one can run out of temps entirely.
> 
> Cc: qemu-stable@nongnu.org

Fixes: b2167459ae ("target-hppa: Implement basic arithmetic")

> Buglink: https://bugs.launchpad.net/qemu/+bug/1880287
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  target/hppa/translate.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/target/hppa/translate.c b/target/hppa/translate.c
> index 52d7bea1ea..4bd22d4820 100644
> --- a/target/hppa/translate.c
> +++ b/target/hppa/translate.c
> @@ -1294,6 +1294,8 @@ static void do_sub(DisasContext *ctx, unsigned rt, TCGv_reg in1,
>      save_or_nullify(ctx, cpu_psw_cb_msb, cb_msb);
>      save_gpr(ctx, rt, dest);
>      tcg_temp_free(dest);
> +    tcg_temp_free(cb);
> +    tcg_temp_free(cb_msb);
>  
>      /* Install the new nullification.  */
>      cond_free(&ctx->null_cond);
> 


