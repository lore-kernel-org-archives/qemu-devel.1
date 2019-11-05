Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60AD0C17461
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 13:24:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29C8721D71
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 13:24:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mgZQGYry"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29C8721D71
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRyoe-00088i-7D
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 08:24:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38589)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iRyne-0007Sm-DY
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 08:23:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iRynd-0007Ye-1U
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 08:23:10 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:37855)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iRync-0007YP-QT
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 08:23:08 -0500
Received: by mail-wm1-x342.google.com with SMTP id q130so20082076wme.2
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2019 05:23:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=UTaNuOgzsBVdk2dZNgcC7BNPN8xKTEkTurCsXFNrD54=;
 b=mgZQGYryGouxzm1GOgUQTQMdQi0LwHmJHGgvlq65oaqtBMnVXMqHZpLugiJDEbc1uI
 hWbfz6WEXon3fInJKE6dI9fiEGyNZ8Y2MW9fn8gLw3lG/49XkazmSU58+jRO3MOzYnKd
 jbLzCRVuKLUPGGCrCuZA83HocLKy9WEuB8pROdeYKKkiBOh1xmBK2hleohnIFVBC6Ath
 D2EX/FQcCfgRJaw3gegsC+guKHj6GJheSo31bzAhB48TcZ0H/iKx1WDu/IUt3ybT4Rzn
 5/MD4cjj0Vv3QOfxy3O7lEw09cw01wemq0rFBiewH+42DwQdTuLpa8xW3cJDFmpX9/bo
 76Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=UTaNuOgzsBVdk2dZNgcC7BNPN8xKTEkTurCsXFNrD54=;
 b=oOTvkVK1X18st56y5JgWg7EU5WCTYv6IhXVdKFmLmACmiFOlxEdanSTWOoIRaQ060p
 BXJULhynp+LlZZjueAO+K1nnL6e/1ZI26b6zJXLBizcBZcHBmBA5E/3HOnxhIpQFdi77
 EPDMCk0X/+G6B5ws8fMestZX0jqShwCSdbrwc7JiWtwuACuQDBanOu1R3QfoU3Y0I78A
 hqIjJsuE9QCz99sXTkRWPKaKRx9t9+rZfCOtOblieWfsRm/DEz7MdeXlMAe8E2sdERQL
 HDPKzhLJqpyKb8eS0hAejsLXWht9CaXNVek87+c6QnD+mUr1iboMYpZQObgHtJyHjPoP
 9M6w==
X-Gm-Message-State: APjAAAWiat5k/iobQWsQgMWUkpcjM6MtCB1JzjDJbemPahiU7Kew9apr
 vt5J298v+IRTtOziAUpIP2F27g==
X-Google-Smtp-Source: APXvYqxJRXpHlMazdvqEbpG15sA6bO87AT9+dmtlMtn7Oy8lB0E7PfCeEj4RARVxJwWA8hotHou/Lg==
X-Received: by 2002:a7b:c762:: with SMTP id x2mr2154967wmk.128.1572960187051; 
 Tue, 05 Nov 2019 05:23:07 -0800 (PST)
Received: from [192.168.8.102] (228.red-2-141-116.dynamicip.rima-tde.net.
 [2.141.116.228])
 by smtp.gmail.com with ESMTPSA id d13sm18547821wrq.51.2019.11.05.05.23.05
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 05 Nov 2019 05:23:06 -0800 (PST)
Subject: Re: [PATCH v35 05/13] target/avr: Add instruction translation -
 Arithmetic and Logic Instructions
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 Michael Rolnik <mrolnik@gmail.com>
References: <20191029212430.20617-1-mrolnik@gmail.com>
 <20191029212430.20617-6-mrolnik@gmail.com>
 <CAL1e-=gKGJC4X9aNtj1SL7+s5UryNtEF81YcG4kvhjPNP247Kw@mail.gmail.com>
 <CAL1e-=gXr5KJ7W3_bnuBaupuz6jYr0LnAX7FXJ8+F8rJ=ARKxw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <14d51697-9415-14b9-8f92-3ae3de2fca58@linaro.org>
Date: Tue, 5 Nov 2019 14:23:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAL1e-=gXr5KJ7W3_bnuBaupuz6jYr0LnAX7FXJ8+F8rJ=ARKxw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: "dovgaluk@ispras.ru" <dovgaluk@ispras.ru>,
 "thuth@redhat.com" <thuth@redhat.com>, "philmd@redhat.com" <philmd@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "imammedo@redhat.com" <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/5/19 10:46 AM, Aleksandar Markovic wrote:
> 
> 
> On Tuesday, November 5, 2019, Aleksandar Markovic <aleksandar.m.mail@gmail.com
> <mailto:aleksandar.m.mail@gmail.com>> wrote:
> 
> 
>         +
>         +/*
>         + *  This instruction performs 8-bit x 8-bit -> 16-bit signed
>         multiplication
>         + *  and shifts the result one bit left.
>         + */
>         +static bool trans_FMULSU(DisasContext *ctx, arg_FMULSU *a)
>         +{
>         +    if (!avr_have_feature(ctx, AVR_FEATURE_MUL)) {
>         +        return true;
>         +    }
>         +
>         +    TCGv R0 = cpu_r[0];
>         +    TCGv R1 = cpu_r[1];
>         +    TCGv Rd = cpu_r[a->rd];
>         +    TCGv Rr = cpu_r[a->rr];
>         +    TCGv R = tcg_temp_new_i32();
>         +    TCGv t0 = tcg_temp_new_i32();
>         +
>         +    tcg_gen_ext8s_tl(t0, Rd); /* make Rd full 32 bit signed */
>         +    tcg_gen_mul_tl(R, t0, Rr); /* R = Rd * Rr */
>         +    tcg_gen_andi_tl(R, R, 0xffff); /* make it 16 bits */
>         +
>         +    tcg_gen_shri_tl(cpu_Cf, R, 15); /* Cf = R(15) */
>         +    tcg_gen_setcondi_tl(TCG_COND_EQ, cpu_Zf, R, 0); /* Zf = R == 0 */
>         +
>         +    tcg_gen_shli_tl(R, R, 1);
>         +
>         +    tcg_gen_andi_tl(R0, R, 0xff);
>         +    tcg_gen_shri_tl(R1, R, 8);
>         +    tcg_gen_andi_tl(R1, R1, 0xff);
>         +
>         +    tcg_temp_free_i32(t0);
>         +    tcg_temp_free_i32(R);
>         +
>         +    return true;
>         +}
>         +
> 
> 
>     Hi, Michael.
> 
>     The way I understand the spec is that a->rd and a->rd must be between 16
>     and 23:
> 
>     https://www.microchip.com/webdoc/avrassembler/avrassembler.wb_FMULSU.html
>     <https://www.microchip.com/webdoc/avrassembler/avrassembler.wb_FMULSU.html>
> 
>     Is my interpretation right? If yes, where is the corresponding part in the
>     implementation?
> 
> 
> Or, perhaps,
> 
> TCGv Rd = cpu_r[a->rd];
> 
> should be
> 
> TCGv Rd = cpu_r[a->rd + 16];
>  
> (and the same for rs)

This happens during decode:

+%rd_b           4:3                         !function=to_B
+%rr_b           0:3                         !function=to_B
+@fmul           .... .... . ... . ...       &rd_rr      rd=%rd_b rr=%rr_b
+FMUL            0000 0011 0 ... 1 ...       @fmul
+FMULS           0000 0011 1 ... 0 ...       @fmul
+FMULSU          0000 0011 1 ... 1 ...       @fmul

This means that a->rd = to_B(extract32(insn, 4, 3)), and

> +static int to_B(DisasContext *ctx, int indx) { return 16 + (indx % 8); }

et voila.


r~

