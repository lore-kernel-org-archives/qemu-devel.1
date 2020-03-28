Return-Path: <SRS0=dICq=5N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6333C43331
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Mar 2020 00:33:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AC102071B
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Mar 2020 00:33:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ER5BmOCX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AC102071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHzPS-0001Ax-MJ
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 20:33:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39905)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jHzOZ-0000Fz-Ht
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 20:32:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jHzOY-0004nB-D1
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 20:32:15 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:33288)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jHzOW-0004jG-Kj
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 20:32:13 -0400
Received: by mail-pg1-x544.google.com with SMTP id d17so5438309pgo.0
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2020 17:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=xoq+fy1AynD8j1oPxoFaudAfYfvYIAAFsUC/RseR08s=;
 b=ER5BmOCXRm1iygxNGlDzDKR5ejDWyJ0vEMJFtqFJsxeL9yH1g9TWb+VK+Hi/z6+lIU
 zHDcumSOHOdjZDQf+vT59eSpjAIDaX/2iW15ZmM4XAanwmEDwzI2rc8OW39dh4mD65Zl
 w33FefIXv3z/z1FD9IqhqsvGQK3lqx2B1vhy7JegvYa82Rgq6o6GcgmlHVlGywIYj19V
 MDTtKzwHM9TC4GIyQJvB0ccySqTxL0BFRerwCMV7Pdf7hzjgdlJA8htV3fDGnF3DAnYG
 DpFGHeNNL1e+DF22LYcDh/vB3HF8hHvQTMsleQ0DBLYL5NEMKwzUUxcuYq4TmwbY/wwm
 TdUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=xoq+fy1AynD8j1oPxoFaudAfYfvYIAAFsUC/RseR08s=;
 b=qnw6tsae4jZHh5rmER6dOqf5Vu48gOaL5v7hFub1lHpQooHsBAl1FiBBvINbx7d8Ur
 atqZsK0IIgujR3m8gHWTmJe/7e1zsBZD/gHjvq3BrP+9wxJXYZI0HJno1KwSnnYZHZTV
 UqUp2V0SVcEbLPMgYkGe5jOqT4qGU5n6wyW6nH5D/VoJf0fEOxG6xcJrs9gt418qn9Hj
 a58DAZ77EsoYz8wWKbrT7E2NsHg4qid/i1Ej5SQsMgLBinJLKWjmH+xx082/s7IksVGK
 Qxus+cW5X2QBeoshF+QPsd9f2qWEuV/ZeAOmvEqk+zmVJga7EzfCBz31OqYqyg7dhN2C
 QOtg==
X-Gm-Message-State: ANhLgQ2LEoaB4dkPhyaBs5n4UHZEbTAZ1LEoo79vB9YfdLFhjhmrxND/
 t/SEhNAoM8NnOZfdfAyFMHt2CA==
X-Google-Smtp-Source: ADFU+vvhdOmlf/9qAGL7fe162ewe6N6EpiqPJtZKBuClzH4WI8LyV8z+opz84ajUpeg4QzR484cSuA==
X-Received: by 2002:a63:c09:: with SMTP id b9mr2039123pgl.222.1585355531276;
 Fri, 27 Mar 2020 17:32:11 -0700 (PDT)
Received: from [192.168.1.11] (174-21-138-234.tukw.qwest.net. [174.21.138.234])
 by smtp.gmail.com with ESMTPSA id 144sm4967418pfx.184.2020.03.27.17.32.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Mar 2020 17:32:10 -0700 (PDT)
Subject: Re: [PATCH v6 25/61] target/riscv: vector single-width averaging add
 and subtract
To: LIU Zhiwei <zhiwei_liu@c-sky.com>, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
References: <20200317150653.9008-1-zhiwei_liu@c-sky.com>
 <20200317150653.9008-26-zhiwei_liu@c-sky.com>
 <0cdf21fd-b1f1-36bf-f156-5a673199fa1f@c-sky.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <5c2f0b77-32fa-76bd-0b0e-4ca91d87f3b6@linaro.org>
Date: Fri, 27 Mar 2020 17:32:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <0cdf21fd-b1f1-36bf-f156-5a673199fa1f@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
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
Cc: guoren@linux.alibaba.com, wenmeng_zhang@c-sky.com, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, wxy194768@alibaba-inc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/18/20 8:46 PM, LIU Zhiwei wrote:
> +static inline int32_t asub32(CPURISCVState *env, int vxrm, int32_t a, int32_t b)
> +{
> +    int64_t res = (int64_t)a - b;
> +    uint8_t round = get_round(vxrm, res, 1);
> +
> +    return (res >> 1) + round;
> +}
> +
> 
> I find a corner case here.  As the spec said in Section 13.2
> 
>   "There can be no overflow in the result".
> 
> If the a is 0x7fffffff,  b is 0x80000000, and the round mode is round to up(rnu),
> then the result is (0x7fffffff - 0x80000000 + 1) >> 1, equals 0x80000000,
> according the v0.7.1

That's why we used int64_t as the intermediate type:

  0x000000007fffffff - 0xffffffff80000000 + 1
= 0x000000007fffffff + 0x0000000080000000 + 1
= 0x00000000ffffffff + 1
= 0x0000000100000000

Shift that right by 1 and you do indeed get 0x80000000.
There's no saturation involved.

For int64_t we computed signed overflow to do the same thing.


r~

