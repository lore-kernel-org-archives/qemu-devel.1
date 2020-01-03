Return-Path: <SRS0=dCqM=2Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DF8EC00523
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 23:06:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E17D721835
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 23:06:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uIsic2Sl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E17D721835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1inW1L-0006eB-1d
	for qemu-devel@archiver.kernel.org; Fri, 03 Jan 2020 18:06:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39670)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1inW0l-0006Cf-Ej
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 18:05:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1inW0k-0002Mh-0Y
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 18:05:43 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:36282)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1inW0j-0002Ih-PE
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 18:05:41 -0500
Received: by mail-pg1-x542.google.com with SMTP id k3so24037474pgc.3
 for <qemu-devel@nongnu.org>; Fri, 03 Jan 2020 15:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=I3cfvt4gXU3UwGUGbZS5OIwd8hrozxLi+qSzb+8T/t8=;
 b=uIsic2SlR5QB/R81WGE6HV08dcAyA4ZdB+rvevEqK7TZZQUEprm9Sn9uKGcw84KvkO
 A8oifRqdhmJT6eKjcZdhX2m/yA6/B8mwpKohwroNEY7P60VRwtqykzwSIislfNh0KPL3
 pHsEZhGKTZQsJOOCvHb3UrG/AdeLhb4TctfarscK2uZlBlMjoXFo4l386/d85U2w/o07
 /vb4jFnGDILjRHfiVJyUT3JX6OWCZwwa8rQJKmxdaqd1VBN8slZv04zyY0S6B4gA+kLw
 CiqqPJCAFdyxCdgO96wbIccC6pc7NFZ9uIBbcW0ZcAV5HEbymWH4BM24ZhuBIqERkU1f
 7Rxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=I3cfvt4gXU3UwGUGbZS5OIwd8hrozxLi+qSzb+8T/t8=;
 b=M8wXa/LfNuqdpZdZ2BMpmYslKkRnP5ROpvX4dr/gIMJZF0J2HvG/5PF5H3kfgdlqA8
 1/Tod7DalyqYwyeNkRfd/cweBRsfWlCANf2ldytidZiiFx+r1+ak8C528fj5iMnc01VE
 pN+sLH546c+mQA79opDdI6gqAKHmaEnJnD5tK3j9KvVUYDvIudSf/wU9uHhjV2dBHRNX
 o6mCZRSUikc516ZYzv0V5oVi7ecYjC98RyR+BFNF0LuYK/iZ7fKQ9sUHNql2/aIQJNEn
 xpWt2IWvTFRgLWDMaYD0jFsE3cUYyTvUrnNuyVH72QL9yfquwDGletjcpfwIGjxDWSWs
 Xx9w==
X-Gm-Message-State: APjAAAWhjgIJP4KW2esbeYcyYksOFyhmOKGy+p2t5KylZ4EgKEYyqQy1
 mZL5XIhozMi2OqEmPzGRJIVitQ==
X-Google-Smtp-Source: APXvYqzf8FkxTwe6nCDc0Xeo3ob8oC/ve2NZVkfCIVuxY2EXGmH1d7jDAAWotIglN98s+MYBR1kbmg==
X-Received: by 2002:a62:a515:: with SMTP id v21mr98123405pfm.128.1578092740523; 
 Fri, 03 Jan 2020 15:05:40 -0800 (PST)
Received: from [10.103.5.8] (59-100-211-22.bri.static-ipl.aapt.com.au.
 [59.100.211.22])
 by smtp.gmail.com with ESMTPSA id c26sm64615241pfj.101.2020.01.03.15.05.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Jan 2020 15:05:39 -0800 (PST)
Subject: Re: [PATCH v3 1/4] RISC-V: add vector extension field in CPURISCVState
To: LIU Zhiwei <zhiwei_liu@c-sky.com>, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
References: <20200103033347.20909-1-zhiwei_liu@c-sky.com>
 <20200103033347.20909-2-zhiwei_liu@c-sky.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f8138b4b-51ef-15f7-c128-f78a46005afa@linaro.org>
Date: Sat, 4 Jan 2020 10:05:32 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200103033347.20909-2-zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
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
Cc: wenmeng_zhang@c-sky.com, qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 wxy194768@alibaba-inc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/3/20 2:33 PM, LIU Zhiwei wrote:
> The 32 vector registers will be viewed as a continuous memory block.
> It avoids the convension between element index and (regno,offset).
> Thus elements can be directly accessed by offset from the first vector
> base address.
> 
> Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
> ---
>  target/riscv/cpu.h | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 0adb307f32..af66674461 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -93,9 +93,23 @@ typedef struct CPURISCVState CPURISCVState;
>  
>  #include "pmp.h"
>  
> +#define RV_VLEN_MAX 4096
> +
>  struct CPURISCVState {
>      target_ulong gpr[32];
>      uint64_t fpr[32]; /* assume both F and D extensions */
> +
> +    /* vector coprocessor state.  */
> +    struct {
> +         uint64_t vreg[32 * RV_VLEN_MAX / 64];

Missing alignment.

> +         target_ulong vxrm;
> +         target_ulong vxsat;
> +         target_ulong vl;
> +         target_ulong vstart;
> +         target_ulong vtype;
> +    } vext;
> +
> +    bool         foflag;

Remove this.  As discussed before, you don't need it.  Faulting behaviour
should be handled with the proper interfaces.


r~

