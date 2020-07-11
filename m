Return-Path: <SRS0=vx8y=AW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F09FC433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 19:31:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54DE620720
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 19:31:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yl2KexIG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54DE620720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juLDL-0008Nn-L1
	for qemu-devel@archiver.kernel.org; Sat, 11 Jul 2020 15:31:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56242)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1juLCg-0007mv-Au
 for qemu-devel@nongnu.org; Sat, 11 Jul 2020 15:30:30 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:33286)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1juLCc-0005SW-D7
 for qemu-devel@nongnu.org; Sat, 11 Jul 2020 15:30:30 -0400
Received: by mail-pf1-x442.google.com with SMTP id m9so4058370pfh.0
 for <qemu-devel@nongnu.org>; Sat, 11 Jul 2020 12:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ADqhXlBAKOY1A6rUObovQLsndeam+0jy3VqgCTTXjgA=;
 b=yl2KexIGCkF5uTK47FyKzjNwxvzkxDP5JkACYb6IwxkFV+783DAzhZuUw8UW59LE4x
 qhGaUk9jfmXNcDVqt2wAgA6RyUVIsTWToWRuZCvC6NDLLzYFPUx0xiFWawGnOXiEz54L
 LixeS+DDw9YTzhIgLBrZpiFoX9u3TVXlGr3IdrK3SQ7YRCOZHl/gTUqDlTzF7SBwjD+e
 SY68VtYk/sX4sQm4eSmaSlv7/eKaAddNogpeqRhVdxsn4SMwI1318raBR5vrBc/tZUH7
 oDtTMyGDQER6bkgenZmaf6FJA5y+eemb991eFavkKjeNbzTx57ggNCo1lMkn+/OekJ/v
 btqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ADqhXlBAKOY1A6rUObovQLsndeam+0jy3VqgCTTXjgA=;
 b=peUANI9OY7mQbIZseVwtCx4qNUhYwg9rlS9MtyqVeqhotGK9t34Y5NZvCnJLex5+rY
 I9jNd7LSSkkjOfRt4Ie6KtiXMbmcD/wNBxXQqUySPobXnQC5VquS3Uji//yhNoMuokX9
 jOXQOibBMVp3Nu2XyG37QDZdEAWWTrxhDYjgo/Ea2rtC8oWhfnUZlPEbin26cO24/IM/
 /+ygYxk2jXrTTFaSCSaMFFsgCwDIM9Fp05PNH1tkgTzPKup1ZtjQjAB3x5U9neOcXzE4
 az9NLn3HkSudhJF7eiyduzFFwjtnPYYc8ZB9K42MlYvqyqG2b3yvjwGVBOT36zRg5H6i
 ITTA==
X-Gm-Message-State: AOAM530fKc0EG4O19vSDXz1YEwtqlsTXevuqWp2XSd0eZfGG90mFUIfu
 OehF2RLpYZQj7Cy4yunNo0VXOQ==
X-Google-Smtp-Source: ABdhPJzK+0wFtaYy+JA65T/EDeiaxSIU0H6mvHsc1u74TKLCQxXHKDcTgRChYAgU5djsGduECkcyLg==
X-Received: by 2002:a63:b50e:: with SMTP id y14mr31977543pge.416.1594495823820; 
 Sat, 11 Jul 2020 12:30:23 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id j3sm9359026pfe.102.2020.07.11.12.30.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 11 Jul 2020 12:30:23 -0700 (PDT)
Subject: Re: [PATCH v2 06/17] linux-user: Do not use guest_addr_valid for
 h2g_valid
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200605041733.415188-1-richard.henderson@linaro.org>
 <20200605041733.415188-7-richard.henderson@linaro.org>
 <CAFEAcA_ca4vAxB-2qfsXVUNPUdyFTJQtcBdkegn4ub8SOiR2TA@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <d6c82116-8b33-716f-e76b-ecad2f24267d@linaro.org>
Date: Sat, 11 Jul 2020 12:30:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_ca4vAxB-2qfsXVUNPUdyFTJQtcBdkegn4ub8SOiR2TA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Stephen Long <steplong@quicinc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/25/20 9:34 AM, Peter Maydell wrote:
> On Fri, 5 Jun 2020 at 05:17, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> This is the only use of guest_addr_valid that does not begin
>> with a guest address, but a host address being transformed to
>> a guest address.
>>
>> We will shortly adjust guest_addr_valid to handle guest memory
>> tags, and the host address should not be subjected to that.
>>
>> Move h2g_valid adjacent to the other h2g macros.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>  include/exec/cpu_ldst.h | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
>> index c14a48f65e..3930362e20 100644
>> --- a/include/exec/cpu_ldst.h
>> +++ b/include/exec/cpu_ldst.h
>> @@ -77,15 +77,16 @@ typedef uint64_t abi_ptr;
>>  #else
>>  #define guest_addr_valid(x) ((x) <= GUEST_ADDR_MAX)
>>  #endif
>> -#define h2g_valid(x) guest_addr_valid((unsigned long)(x) - guest_base)
>>
>>  static inline int guest_range_valid(unsigned long start, unsigned long len)
>>  {
>>      return len - 1 <= GUEST_ADDR_MAX && start <= GUEST_ADDR_MAX - len + 1;
>>  }
>>
>> +#define h2g_valid(x)  ((uintptr_t)(x) - guest_base <= GUEST_ADDR_MAX)
> 
> The old implementation returns true for
> HOST_LONG_BITS <= TARGET_VIRT_ADDR_SPACE_BITS
> (because there's a different definition of guest_addr_valid() there)
> but this one does a range check even in that case.

It's part and parcel with patch 1, wherein we are in fact attempting to limit
the guest address space to GUEST_ADDR_MAX.

That's why I put patch 1 first, so the behaviour change happens there.

>>  #define h2g_nocheck(x) ({ \
>> -    unsigned long __ret = (unsigned long)(x) - guest_base; \
>> +    uintptr_t __ret = (uintptr_t)(x) - guest_base; \
>>      (abi_ptr)__ret; \
>>  })
> 
> Why the type change? This seems unrelated.

Dropped.  Though at some point we should purge unsigned long, as there is
always a clearer type to use.


r~

