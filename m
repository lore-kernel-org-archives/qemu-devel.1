Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF24EC43463
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 21:33:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DA52206DC
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 21:33:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O+oDDJbD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DA52206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJ1WV-0007pU-8W
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 17:32:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51084)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kJ1TZ-0006iM-Pw
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 17:29:57 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:44704)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kJ1TX-0001h3-VJ
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 17:29:57 -0400
Received: by mail-pl1-x641.google.com with SMTP id j7so1800062plk.11
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2020 14:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=qJ9OIxhxzIwuoipzpq9nuTHhp5mEcbjsqaxxM8y0LNk=;
 b=O+oDDJbDAG3/jsrBvfU46MHaY7YagMPnNHj+e2ojEaDd259BEO6AF4GU9djGAj48o+
 rfHXDg+ih5lCan0Jm57iJOHtC11OeDcn4yO29ejPUOFm6TEx7XTkp6IPu5cp83Hji0G/
 sbk4MLQI7x12xg+JqLqPzKfhBHLCuiQxOhcyBGd4rXWsnMiW8LsQjSVbvxLWWubvpkhR
 bXFn++dN+wxH0Xereet/mroCli885GBUCTNgEXWjOWm6E58ARjCET7L0N8xGbVXXwrpp
 fK9DLRtX5KCEIrAqOTggWnB5w9UZ8JgL13Hho5wPSAPH5Q+9eD3DTEhuK8RU1FfB6jQx
 NDpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qJ9OIxhxzIwuoipzpq9nuTHhp5mEcbjsqaxxM8y0LNk=;
 b=S9dc7kfHBoLBy8l1BRWVRSDI0GuZnJb7lf1XdZUfyEZDKrkarokP/BtmMYfiC+4c6r
 zU0DJ2EwqMg24UpoOIuGBicRU73ULw/kuQ6W2DiXdudAkEgg5UiXDoPgWbJX1mISUG8w
 bzrhG4grAiuyuwjBsfwqJX67m7ehbpujOJwLIN7z/Vo/2xTujgcsuaB8RBZZBjacRIvg
 uI/i6ftrfuXYYOeoJ6EgS2qU4he+dnPHV4mjhj/9ibLQ0Iu/CpLnY+PGDusdtd9wU7B8
 EUYZGtsopCTgPCfP+VO6+eKK0tSIX7ocPqBbvz/3ruZJ4L9QmTdhFbd3hCQHrrTcOLs8
 NSEw==
X-Gm-Message-State: AOAM532BdgK1tw1EXUtK1jbYTlT//8bH84JKDkffmap5eeGXig6r92TX
 lnQuU/TlbN7n/C4NQvJIxPyrBg==
X-Google-Smtp-Source: ABdhPJwOs4uEtPu4GBW9RMGscfwdBmkUKfMyASrsx1IUHt6+w5gYY8nhnnFIsBW6s+7fHeTvy4/yPw==
X-Received: by 2002:a17:902:525:b029:d1:920c:c200 with SMTP id
 34-20020a1709020525b02900d1920cc200mr30515256plf.25.1600378194339; 
 Thu, 17 Sep 2020 14:29:54 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id x3sm567453pgg.54.2020.09.17.14.29.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Sep 2020 14:29:53 -0700 (PDT)
Subject: Re: [PATCH 4/4] qemu/bswap: Let cpu_to_endian() functions handle
 constant expressions
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200917163106.49351-1-philmd@redhat.com>
 <20200917163106.49351-5-philmd@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <96c305c2-886b-3d83-82ad-83c49c60ee26@linaro.org>
Date: Thu, 17 Sep 2020 14:29:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200917163106.49351-5-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x641.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/17/20 9:31 AM, Philippe Mathieu-Daudé wrote:
> cpu_to_endian() and endian_to_cpu() can be extended to handle
> constant expressions. That way the programmer doesn't need to
> remember the const_X() API exists.
> 
> Suggested-by: Stefan Hajnoczi <stefanha@gmail.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  include/qemu/bswap.h | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/include/qemu/bswap.h b/include/qemu/bswap.h
> index de256cea3ab..8827e4760b9 100644
> --- a/include/qemu/bswap.h
> +++ b/include/qemu/bswap.h
> @@ -191,12 +191,16 @@ static inline void bswap64s(uint64_t *s)
>  #define CPU_CONVERT(endian, size, type)\
>  static inline type endian ## size ## _to_cpu(type v)\
>  {\
> -    return glue(endian, _bswap)(v, size);\
> +    return __builtin_constant_p(v) ?\
> +           const_ ## endian ## size(v) :\
> +           glue(endian, _bswap)(v, size);\
>  }\
>  \
>  static inline type cpu_to_ ## endian ## size(type v)\
>  {\
> -    return glue(endian, _bswap)(v, size);\
> +    return __builtin_constant_p(v) ?\
> +           const_ ## endian ## size(v) :\
> +           glue(endian, _bswap)(v, size);\
>  }\
>  \
>  static inline void endian ## size ## _to_cpus(type *p)\
> 

How does this actually affect code generation?

If it does, then that's a mistake in our definition of bswap{16,32,64}(), which
should have been able to fold constants just fine.

Looking at all of that CONFIG_MACHINE_BSWAP_H stuff, I think we should just
ditch it all in favour of __builin_bswap*.  The final piece, __builtin_bswap16,
came in at ac868f29d7e8 in gcc-4.8.


r~

