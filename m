Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 519B0C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 22:00:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C79E22400
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 22:00:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vvNjGjHv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C79E22400
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUdCO-0007RO-Eg
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 18:00:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51446)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kUdBC-0006Bm-LI
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 17:58:59 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:40787)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kUdBA-0006Sp-R3
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 17:58:58 -0400
Received: by mail-pl1-x644.google.com with SMTP id d23so512866pll.7
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2020 14:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=OkYgEQS0ILd5+XQGaRwPQyjcGWoCtewhGaJE0g9k7LM=;
 b=vvNjGjHvry4A8S2LiR01n1E7Zbm9oHFtmoKzX5JdJiA3ant3PYuxen/Rpe9xUYohTE
 8ZGEYMxHggNAQUqpzNl7lxr2QFVzVF4HtYU2YvO1mZHezLU+GMI7mZtNo0cqkaNjHtss
 u3TMe/wXOCUXkRYPt6+rsh9X4XuAcTqzwDCK7E9ZbYwysm5VvCKXNg37sPdkmaUzEKqO
 GhgJh8lZPEU8fYrElcqfIMeXUmGYY9ULY9Yb3vyLjnyNQNVvbibrZS/Id9/EjV92m3Dc
 /wJ1D/So8hLpBr0dnQGZ8QuCZqD0F72FWxdLP5p2t+YYQ7rHga4aC4KajTlXvWqHOqlT
 57SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=OkYgEQS0ILd5+XQGaRwPQyjcGWoCtewhGaJE0g9k7LM=;
 b=t7fcwxvqYktxUpD4J2oVjw1Tr1GGge+ECzgMV75uizsvN1ASxbUQrCUpabK4vR5dRd
 quaSlgB57AyI5e1leQG/LlRy9YILGnIBlLhVRN3hGAg4g2FZmiGrJ4FdmJ40VoJyY4/s
 8ymJNLBsNw4shGEgQ9A/khHacwk8lewUBxuYy7xEsj15ISu5JxyUFV1m6Uwgye0recOh
 zKrb2aZgyNZZwewsyYFyKMq2fUSKWbZR7JQPg3YjxcfjGNXzMDIVjANpoHjtjj4oqIaS
 BpD/8Twdy8dv8glezYSDsZD9ox2vQrHi74JObqJswSqOqVpb241egAfYNTqIsowlsSw5
 FVwA==
X-Gm-Message-State: AOAM532iZIez/oMAlD+4WrN2pB4LwYuZ1Mg0onbDqDGH/U8f8oEKUAnm
 kLZzcJHsKCYmyHybq6oxciXh6A==
X-Google-Smtp-Source: ABdhPJw6jQj69qQvfEMY8K667aYZqySJO8F7PuuCA6eCA7q3X1uO3aDG/z2Epk+Ws9L0Ck5AIXjA3Q==
X-Received: by 2002:a17:902:64c8:b029:d3:c693:8ce8 with SMTP id
 y8-20020a17090264c8b02900d3c6938ce8mr1794573pli.27.1603144735065; 
 Mon, 19 Oct 2020 14:58:55 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id c10sm645206pfc.196.2020.10.19.14.58.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Oct 2020 14:58:54 -0700 (PDT)
Subject: Re: [PATCH v3 34/81] target/arm: Implement SVE2 WHILERW, WHILEWR
To: LIU Zhiwei <zhiwei_liu@c-sky.com>, qemu-devel@nongnu.org
References: <20200918183751.2787647-1-richard.henderson@linaro.org>
 <20200918183751.2787647-35-richard.henderson@linaro.org>
 <29cce0a5-11f1-b433-021f-12b2e5ada005@c-sky.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <e8f85e38-e227-43eb-fe05-c82636cfa133@linaro.org>
Date: Mon, 19 Oct 2020 14:58:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <29cce0a5-11f1-b433-021f-12b2e5ada005@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x644.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.001,
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/12/20 7:33 PM, LIU Zhiwei wrote:
>> +    if (a->rw) {
>> +        /* WHILERW */
>> +        /* diff = abs(op1 - op0), noting that op0/1 are unsigned. */
>> +        t1 = tcg_temp_new_i64();
>> +        tcg_gen_sub_i64(diff, op0, op1);
>> +        tcg_gen_sub_i64(t1, op1, op0);
>> +        tcg_gen_movcond_i64(TCG_COND_LTU, diff, op0, op1, diff, t1);
> It should be:
> 
> tcg_gen_movcond_i64(TCG_COND_GTU, diff, op0, op1, diff, t1);

Yep.

> 
>> +        tcg_temp_free_i64(t1);
>> +        /* If op1 == op0, diff == 0, and the condition is always true. */
>> +        tcg_gen_movcond_i64(TCG_COND_EQ, diff, op0, op1, tmax, diff);
>> +    } else {
>> +        /* WHILEWR */
>> +        tcg_gen_sub_i64(diff, op1, op0);
>> +        /* If op0 >= op1, diff <= 0, the condition is always true. */
>> +        tcg_gen_movcond_i64(TCG_COND_GEU, diff, op0, op1, tmax, diff);
>> +    }
>> +
>> +    /* Bound to the maximum.  */
>> +    tcg_gen_umin_i64(diff, diff, tmax);
>> +    tcg_temp_free_i64(tmax);
>> +
>> +    /* Since we're bounded, pass as a 32-bit type.  */
>> +    t2 = tcg_temp_new_i32();
>> +    tcg_gen_extrl_i64_i32(t2, diff);
> We should align count down to (1 << esz),
> 
> tcg_gen_andi_i32(t2，~MAKE_64BIT_MASK(0, esz));

Yep, this corresponds to the "DIV (esize DIV 8)" portion of the psuedo code.
But it needs to go earlier, before we compare diff against 0 in the two movcond
above.

Will fix.  Thanks,


r~

