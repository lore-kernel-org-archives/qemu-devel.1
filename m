Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B912C4727C
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 16:12:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F4024206F7
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 16:12:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="buPPDvSS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F4024206F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNeit-0004bN-Rb
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 12:12:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53740)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kNea0-0002km-OD; Wed, 30 Sep 2020 12:03:44 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:44800)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kNeZy-0002QS-SV; Wed, 30 Sep 2020 12:03:44 -0400
Received: by mail-wr1-x442.google.com with SMTP id s12so2405361wrw.11;
 Wed, 30 Sep 2020 09:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=i5C+7Rqzn0WqSvRSkD6ysP0eb9nCoXsspnqsgMajfAE=;
 b=buPPDvSSTCgDCDk3Tv+m1Lk0IB7mB3tpEl5ADUiFVq/W6K+LROSvgOWthQkgfLej9i
 sVKWSEXfmgDlqOQi0vLfEGLJHfZE/2T+UO9fjSHI/VUe0wllK0q7JBFkTr1UxL/S7cow
 0ws9m352CZKYpF3DRB9NAkBlo7ruaVsPGQa/OGh0T+ncUpVvX3vBoMk6wmS7GMnw0Cvl
 cr24gUj47HTRR2PDcTtnPUuw7vryV17YbXnWmxgc59E/KJqVw1f1ibV38+1DceLYpwFR
 whD8LMtSs+2i6lYVGJOvAC2dhfCpzXm2RabIt1xKUBjeutCHfzNCEyEw/N+VNiM+QWWT
 4EfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=i5C+7Rqzn0WqSvRSkD6ysP0eb9nCoXsspnqsgMajfAE=;
 b=gMOU/+QJGT4x46VXBKDJxB8ZeDPaFEgtcJOI4W/Fd/9fBaeCJR6TfdD3cJNR5p13wR
 patWqruo2gHeZrTlBJ977qYjfrsLqaZIODZHyEKFCTdrbCdPMm9++9JTnRzKbhUF6sh8
 BKxCHDa9Y2TLQG+anHIRq1WB2V0Pu2XjrgE6KUDUH1f4Dvzljw+Wwkrl7XLC5RU3rDo8
 e811VrG4iy4FGkkIEDfoVSGVBsqULcAI1JYOqnLxtAnTWN1H+lm8Y+cHyxq4/fwCH0Il
 jb79chpNwnKsvqMxgFfvJDlZF6BiFnZERSYBGjMWClx5rqRfB3jjql9Os1oTf9gKtGLZ
 iiTw==
X-Gm-Message-State: AOAM533vb8vOMVzDqTk++WADVQRDrlMYZrzrh/8Lz7ZRqN05YgRLJF5Z
 oNZdmtzaLPdMxsezhq5SYTQNRLLPXZE=
X-Google-Smtp-Source: ABdhPJzdczqi5i1omn4hyGtjICaMMyaxjlgIg7Hy4rs137/QhnKMQAgWJeZ3lEUxmhN/fQsAk3jCUA==
X-Received: by 2002:adf:f14f:: with SMTP id y15mr3784050wro.69.1601481820488; 
 Wed, 30 Sep 2020 09:03:40 -0700 (PDT)
Received: from [192.168.1.36] (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id s11sm3585182wrt.43.2020.09.30.09.03.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Sep 2020 09:03:39 -0700 (PDT)
Subject: Re: [PATCH RFC 08/14] m68k/: fix some comment spelling errors
To: Laurent Vivier <laurent@vivier.eu>, zhaolichang <zhaolichang@huawei.com>, 
 qemu-trivial@nongnu.org
References: <20200930095321.2006-1-zhaolichang@huawei.com>
 <20200930095321.2006-9-zhaolichang@huawei.com>
 <a1e3bd75-8eb5-0f7f-7c2f-81e3de0a0114@vivier.eu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <6a8cd8ab-3a8c-bb24-2193-67b0a1cebf16@amsat.org>
Date: Wed, 30 Sep 2020 18:03:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <a1e3bd75-8eb5-0f7f-7c2f-81e3de0a0114@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/30/20 12:26 PM, Laurent Vivier wrote:
> Le 30/09/2020 à 11:53, zhaolichang a écrit :
>> I found that there are many spelling errors in the comments of qemu/target/m68k.
>> I used spellcheck to check the spelling errors and found some errors in the folder.
>>
>> Signed-off-by: zhaolichang <zhaolichang@huawei.com>
>> ---
>>  target/m68k/translate.c | 16 ++++++++--------
>>  1 file changed, 8 insertions(+), 8 deletions(-)
>>
>> diff --git a/target/m68k/translate.c b/target/m68k/translate.c
>> index 3fc67aa..133a404 100644
>> --- a/target/m68k/translate.c
>> +++ b/target/m68k/translate.c
>> @@ -438,7 +438,7 @@ static TCGv gen_addr_index(DisasContext *s, uint16_t ext, TCGv tmp)
>>  }
>>  
>>  /*
>> - * Handle a base + index + displacement effective addresss.
>> + * Handle a base + index + displacement effective address.
>>   * A NULL_QREG base means pc-relative.
>>   */
>>  static TCGv gen_lea_indexed(CPUM68KState *env, DisasContext *s, TCGv base)
>> @@ -1696,7 +1696,7 @@ static void bcd_add(TCGv dest, TCGv src)
>>  
>>      /*
>>       * t1 = (src + 0x066) + dest + X
>> -     *    = result with some possible exceding 0x6
>> +     *    = result with some possible exceeding 0x6
>>       */
>>  
>>      t0 = tcg_const_i32(0x066);
>> @@ -1706,7 +1706,7 @@ static void bcd_add(TCGv dest, TCGv src)
>>      tcg_gen_add_i32(t1, t0, dest);
>>      tcg_gen_add_i32(t1, t1, QREG_CC_X);
>>  
>> -    /* we will remove exceding 0x6 where there is no carry */
>> +    /* we will remove exceeding 0x6 where there is no carry */
>>  
>>      /*
>>       * t0 = (src + 0x0066) ^ dest
>> @@ -1736,7 +1736,7 @@ static void bcd_add(TCGv dest, TCGv src)
>>      tcg_temp_free(t0);
>>  
>>      /*
>> -     * remove the exceding 0x6
>> +     * remove the exceeding 0x6
>>       * for digits that have not generated a carry
>>       */
>>  
>> @@ -2638,7 +2638,7 @@ DISAS_INSN(negx)
>>      gen_flush_flags(s); /* compute old Z */
>>  
>>      /*
>> -     * Perform substract with borrow.
>> +     * Perform subtract with borrow.
>>       * (X, N) =  -(src + X);
>>       */
>>  
>> @@ -2653,7 +2653,7 @@ DISAS_INSN(negx)
>>      /*
>>       * Compute signed-overflow for negation.  The normal formula for
>>       * subtraction is (res ^ src) & (src ^ dest), but with dest==0
>> -     * this simplies to res & src.
>> +     * this simplifies to res & src.
>>       */
>>  
>>      tcg_gen_and_i32(QREG_CC_V, QREG_CC_N, src);
>> @@ -3159,7 +3159,7 @@ static inline void gen_subx(DisasContext *s, TCGv src, TCGv dest, int opsize)
>>      gen_flush_flags(s); /* compute old Z */
>>  
>>      /*
>> -     * Perform substract with borrow.
>> +     * Perform subtract with borrow.
>>       * (X, N) = dest - (src + X);
>>       */
>>  
>> @@ -3169,7 +3169,7 @@ static inline void gen_subx(DisasContext *s, TCGv src, TCGv dest, int opsize)
>>      gen_ext(QREG_CC_N, QREG_CC_N, opsize, 1);
>>      tcg_gen_andi_i32(QREG_CC_X, QREG_CC_X, 1);
>>  
>> -    /* Compute signed-overflow for substract.  */
>> +    /* Compute signed-overflow for subtract.  */
>>  
>>      tcg_gen_xor_i32(QREG_CC_V, QREG_CC_N, dest);
>>      tcg_gen_xor_i32(tmp, dest, src);
>>
> 
> Reviewed-by: Laurent Vivier <laurent@vivier>

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

