Return-Path: <SRS0=dICq=5N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59AAEC43331
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Mar 2020 01:10:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 241CA206F6
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Mar 2020 01:10:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jJufVgUZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 241CA206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHzzC-00037l-BH
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 21:10:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44964)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jHzyA-0002YN-CV
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 21:09:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jHzy9-0006fj-0q
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 21:09:01 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:42260)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jHzy8-0006eq-G3
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 21:09:00 -0400
Received: by mail-pg1-x544.google.com with SMTP id h8so5462945pgs.9
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2020 18:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=MlrU39JFmvSLKpFknjZBRcdhWX+jJ8k81TrxhR433Vo=;
 b=jJufVgUZ4m+1ERwU2sZAiayF2IHkiQ0pKuDfRfzDBZg0UanAIps5+CLIRWG5bSHbY8
 vuw+3oKueHqPTH3wux3l53Fb9/1+iGz9V8I8GDHE4qu7gybAL8JzC2Jt4jWpWNHvZ3Uj
 gXoY6KQIR3ez0OReEr7yF2KX2RTfOPDKrLmlGXzM7YA5RUaZwc5UKCLq+IhUtW71jtVF
 uv86TUAvjnToG02K5opLAjHox53ORXwTrRHmP7UJ5rBqi29OV/tt92Li2w057vlhfgk5
 sq+5s1b4wnmIbJxMOqQU7P85TnZlBuaPPNSuCQfn9eWzTNCiGJTqGk+YOi1CkTA3lCt6
 0K/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=MlrU39JFmvSLKpFknjZBRcdhWX+jJ8k81TrxhR433Vo=;
 b=NDLabVjMsEHxczAXk5lU2XUzH4Ix2SYHOshqb7tw4LbbQNSo6qd2Sf6zuB83KHokps
 3KrLhB3Hfqs9iJHbXoJZxVDKhzeGEa3amdYxJ81MzWR45gIHfvJXvmoz7/q5Yyo/bEW/
 UQZk3ol0qMdAeG0JKKhCbT9SAHHk0twd7ugXNWrWr+9WaI6gJTqEa6j5X0maabkbR3fL
 gJ9GzqWBxc9T3asuGC4Ss6a5Ktx/AZTYdL6oikV7uF9FSGfuAtuT1v5+tRH9s9f5zwLi
 gi0JlZRIJ6l0EGf15+U5FKTNWEm3+3eXYTyjTN3ydbTdUW2aZzdfRl/B48Ql5RmxDBYj
 OKPw==
X-Gm-Message-State: ANhLgQ3JV90GesXAGO/mZn2LR/1r2SKQeSk7OUSMoa0h5LCbMDEc3rem
 AnERk2GhFj0mQE78nqU6IdgC4g==
X-Google-Smtp-Source: ADFU+vuyuWpwSRlfbpe1Fvd4/bQwRfuroaLnZgiTgUoSuorAgk/1YDX6SPySe8ZQnYewX4DHAjDq+w==
X-Received: by 2002:a65:494f:: with SMTP id q15mr2045593pgs.383.1585357739038; 
 Fri, 27 Mar 2020 18:08:59 -0700 (PDT)
Received: from [192.168.1.11] (174-21-138-234.tukw.qwest.net. [174.21.138.234])
 by smtp.gmail.com with ESMTPSA id p22sm4766006pgn.73.2020.03.27.18.08.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Mar 2020 18:08:58 -0700 (PDT)
Subject: Re: [PATCH v6 26/61] target/riscv: vector single-width fractional
 multiply with rounding and saturation
To: LIU Zhiwei <zhiwei_liu@c-sky.com>, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
References: <20200317150653.9008-1-zhiwei_liu@c-sky.com>
 <20200317150653.9008-27-zhiwei_liu@c-sky.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <9f5fd1a3-f32f-9779-6d5c-abdedc10fd2d@linaro.org>
Date: Fri, 27 Mar 2020 18:08:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200317150653.9008-27-zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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

On 3/17/20 8:06 AM, LIU Zhiwei wrote:
> +static int64_t vsmul64(CPURISCVState *env, int vxrm, int64_t a, int64_t b)
> +{
> +    uint8_t round;
> +    uint64_t hi_64, lo_64, Hi62;
> +    uint8_t hi62, hi63, lo63;
> +
> +    muls64(&lo_64, &hi_64, a, b);
> +    hi62 = extract64(hi_64, 62, 1);
> +    lo63 = extract64(lo_64, 63, 1);
> +    hi63 = extract64(hi_64, 63, 1);
> +    Hi62 = extract64(hi_64, 0, 62);

This seems like way more work than necessary.

> +    if (hi62 != hi63) {
> +        env->vxsat = 0x1;
> +        return INT64_MAX;
> +    }

This can only happen for a == b == INT64_MIN.
Perhaps just test exactly that and move it above the multiply?

> +    round = get_round(vxrm, lo_64, 63);
> +    if (round && (Hi62 == 0x3fffffff) && lo63) {
> +        env->vxsat = 0x1;
> +        return hi62 ? INT64_MIN : INT64_MAX;
> +    } else {
> +        if (lo63 && round) {
> +            return (hi_64 + 1) << 1;
> +        } else {
> +            return (hi_64 << 1) | lo63 | round;
> +        }
> +    }

  /* Cannot overflow, as there are always
     2 sign bits after multiply. */
  ret = (hi_64 << 1) | (lo_64 >> 63);
  if (round) {
      if (ret == INT64_MAX) {
          env->vxsat = 1;
      } else {
          ret += 1;
      }
  }
  return ret;


r~

