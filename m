Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2896C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 16:59:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E9D32065D
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 16:59:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WtBaeGhx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E9D32065D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsqwc-00037Q-Mx
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 12:59:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45088)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jsqvV-0001ek-V0
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 12:58:37 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:45345)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jsqvU-0007mq-Cd
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 12:58:37 -0400
Received: by mail-wr1-x444.google.com with SMTP id s10so45920439wrw.12
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2020 09:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=6+IBb7Xz/4CfcPrvJ+2wUbrJdzt1fxGdFW1XGuzGcuU=;
 b=WtBaeGhx5s7VfF/SYDe8gvVQoL64vHycDiRAvhu8FOjMT1DVOoQrrilL75fzMrvC5t
 wXWaTtrCIKm8h4vuunrn918S04LIrBaosuRyBsrCeA+Q5gt3tGlb4CTq5n5yh0+6Df3k
 DmZkj4dvlus5cdawDu19CfdSESx4tXoP1FBC4oQY5gjyZBrMsQaalX4SdOp6kdxvuKgI
 18Jqtmb4qme2eVN2yZBFfsAmXtP9J2GrXHtmLMJJ5HkTX2dNSk4+FOWcJGckpzzU+oza
 q0xXMuX2XReWPQ3ELpOxvjxF2pt0refv1PsVuuJWTJ0Ns1G8uF/q6Xj/VCpJshYy+fp9
 kg2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6+IBb7Xz/4CfcPrvJ+2wUbrJdzt1fxGdFW1XGuzGcuU=;
 b=txXrE+oe5scbIEVlVIx+5yMbcFumojn+2IWiTPayFjkdi3siuDnzxQq31ldvAvBaQC
 qs7VyCHv59rvL+YTOIDFDC+3rbJvdGMZKyRHQ0tJPVJJjgvaCGbWv8/m8rLNLjak+bJm
 AFysifPY6Bfyp4feXxWM1/2zjDkvnpkm2TWj2Zn0r0Pn6ZHwkR5vMZUrjn7iP07x92ea
 hRpkE258PRycjYSYSDNwyCndJv5iZUgvwlulQ+6hd+Ir9gu2P+L0bKhouF7LRRi1ANT+
 Nw/fKZ910wBaqf+P1fmd6UWlpRgSBwL/6hmccOsi6o00PBSiyx5lpKvchwiAn8QBawUN
 hj1Q==
X-Gm-Message-State: AOAM533j6s0KKGZW637t154x1u/mzRfC0BiQ30Cn0gzqqoRKpILhvYOd
 C9Y7NgFjNkO4aYAMR1J9k5Y=
X-Google-Smtp-Source: ABdhPJxT2r3hlH98LYbHPdGXeYhTAioAsEjZ33Onk1uIuiq4yBTqtOAJmBNGI+V64/h4ZBI4QoY60Q==
X-Received: by 2002:a05:6000:1107:: with SMTP id
 z7mr53845115wrw.355.1594141114212; 
 Tue, 07 Jul 2020 09:58:34 -0700 (PDT)
Received: from [192.168.1.36] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id r28sm1860261wrr.20.2020.07.07.09.58.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jul 2020 09:58:33 -0700 (PDT)
Subject: Re: [RFC PATCH v2 4/4] target/avr/translate: Fix SBRC/SBRS
 instructions
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200707070021.10031-1-f4bug@amsat.org>
 <20200707070021.10031-5-f4bug@amsat.org>
 <9c799b29-baa9-82c1-7329-aa9a3bff4664@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <eea7799a-9959-0fb0-3bc4-001f97cbea50@amsat.org>
Date: Tue, 7 Jul 2020 18:58:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <9c799b29-baa9-82c1-7329-aa9a3bff4664@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Thomas Huth <huth@tuxfamily.org>,
 Joaquin de Andres <me@xcancerberox.com.ar>, Michael Rolnik <mrolnik@gmail.com>,
 Sarah Harris <S.E.Harris@kent.ac.uk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/7/20 6:34 PM, Richard Henderson wrote:
> On 7/7/20 12:00 AM, Philippe Mathieu-Daudé wrote:
>> @@ -1385,7 +1385,7 @@ static bool trans_SBRC(DisasContext *ctx, arg_SBRC *a)
>>  {
>>      TCGv Rr = cpu_r[a->rr];
>>  
>> -    ctx->skip_cond = TCG_COND_EQ;
>> +    ctx->skip_cond = TCG_COND_NE;
>>      ctx->skip_var0 = tcg_temp_new();
>>      ctx->free_skip_var0 = true;
> 
> This is wrong.  The next line is
> 
>>     tcg_gen_andi_tl(ctx->skip_var0, Rr, 1 << a->bit);
> 
> So we compute "var = R & bit", which should be zero for "Skip if Bit in
> Register Clear".  Thus "var EQ 0" is the correct test.

Thanks for verifying. If TCG is correct, then some hardware register
might have a bit flipped.

I couldn't run Sarah's test suite on Fedora 30:

/usr/lib/gcc/avr/9.2.0/../../../../avr/bin/ld: cannot find
crtatmega2560.o: No such file or directory
/usr/lib/gcc/avr/9.2.0/../../../../avr/bin/ld: cannot find -lm
/usr/lib/gcc/avr/9.2.0/../../../../avr/bin/ld: cannot find -lc
/usr/lib/gcc/avr/9.2.0/../../../../avr/bin/ld: cannot find -latmega2560
collect2: error: ld returned 1 exit status

I'll try on some Debian based host.

> 
>> @@ -1401,7 +1401,7 @@ static bool trans_SBRS(DisasContext *ctx, arg_SBRS *a)
>>  {
>>      TCGv Rr = cpu_r[a->rr];
>>  
>> -    ctx->skip_cond = TCG_COND_NE;
>> +    ctx->skip_cond = TCG_COND_EQ;
>>      ctx->skip_var0 = tcg_temp_new();
>>      ctx->free_skip_var0 = true;
> 
> Similarly this is "var NE 0".

