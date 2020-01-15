Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06078C32771
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 22:17:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C08262187F
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 22:17:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jla1ex8S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C08262187F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irqyZ-0006Ym-SM
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 17:17:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34648)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1irqxe-0005VN-9k
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 17:16:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1irqxc-00033g-VF
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 17:16:25 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:38612)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1irqxc-000338-Oo
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 17:16:24 -0500
Received: by mail-pf1-x441.google.com with SMTP id x185so9174356pfc.5
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2020 14:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=k5qTG11cijFjDdtVQH/y0HmKwWbcCvaBtfDANdoeBBw=;
 b=jla1ex8SdGGmoRMprgceXvRpAwRSylhng5WaLjcX0B6Lj6R0SkIkazbHXFJjxt7Ru2
 9agZQtRwDQyIEqSEEKJAD9Y1AmqM8UebuCum25XvxNMcHV48we+lVxDHYPahcHXHviNd
 xw/JPyh0qVKJEY9Gff+66cjvTk9frCCkN787v2gbDEVQ5ih6oHNOGpQBhodPkVUIQoHL
 yiZgauH0kev9nGPLuwvekWWVSVGu7qXOUN1Acdg8HqQNaQlnPl9ugULD7fUXVr/DHx6o
 PGGcylp6I/VSfTjR0n9o6i7JZ42XbrWH6A5RPRQDRSRfMrpdRd6h5z9/3LOvRxgg5vFR
 wORg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=k5qTG11cijFjDdtVQH/y0HmKwWbcCvaBtfDANdoeBBw=;
 b=T8WYovNaGYUmycQ5ts/+cS9I5FybjnbWFGts42FQCfKtU2h+dpjIVk6lBHV/LETQql
 FsxzBE6M/M1OlqJKeASoDfFeMVZuUSVFpy48lDBFl2fgWRzk9NmViI1JX9YxVH2UPtUb
 fKlZ69dSKzFmAWfx+u5gfVQX9DXthbf8TQXJJmPhiMat8VZHfVEI98ZyvoscJmvIWOCB
 ecywVCDdS8rL/H9bG7hYLzqKG6WdYJWH8YXjn4VQMH2LMJfaxH8jX01FoZ/3KdJ719XB
 678bQZIk8Z5iz/rrVnn5YE92wNB4iHZNhKL8ohQJo6SWI077mJiKyQ4ym0ZbRbbO4tgM
 tNvg==
X-Gm-Message-State: APjAAAVFhHGhA3LqL1LQhCaP1r9xtroQU63VP3QmsO64WOvnvec5+A6E
 BqZEseaLcDQTewjeL4/JHZ9PvA==
X-Google-Smtp-Source: APXvYqw5hijErwfEPZ+wYjWAVMpXJq6f2iW9FfVWg6uvgv6nSvim2WhuVQeZwThKRBpqQO7FlFvWcA==
X-Received: by 2002:a62:ee11:: with SMTP id e17mr34252560pfi.48.1579126583547; 
 Wed, 15 Jan 2020 14:16:23 -0800 (PST)
Received: from [192.168.3.43] (rrcs-66-91-136-155.west.biz.rr.com.
 [66.91.136.155])
 by smtp.gmail.com with ESMTPSA id j9sm22700317pfn.152.2020.01.15.14.16.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jan 2020 14:16:22 -0800 (PST)
Subject: Re: [PATCH v5 12/22] target/arm: generate xml description of our SVE
 registers
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200114150953.27659-1-alex.bennee@linaro.org>
 <20200114150953.27659-13-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <8b01b9a0-3fcf-2d17-5f20-182cac6329a2@linaro.org>
Date: Wed, 15 Jan 2020 12:16:18 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200114150953.27659-13-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/14/20 5:09 AM, Alex Bennée wrote:
> We also expose a the helpers to read/write the the registers.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
> v2
>   - instead of zNpM expose zN at sve_max_vq width
>   - wrap union in union q(us), d(usf), s(usf), h(usf), b(us)
> v3
>   - add a vg pseudo register for current width
>   - spacing fixes
>   - use switch/case for whole group
>   - drop fpsr_pos marker
>   - remove unused variables
> v4
>   - const-ify vec_lanes
>   - drop vg

Sigh.  This still feels like we're coding to a gdb bug.

I assert that vg (or equivalent information) is required for the job to be done
correctly.  It's a per-core and therefore, for user-space, per-thread quantity.
 We cannot possibly be "changing targets" for the "thread N" command.

I'll give you an
Acked-by: Richard Henderson <richard.henderson@linaro.org>

because I recognize that this is how gdb works today, but I don't like it.


r~

