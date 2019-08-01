Return-Path: <SRS0=TBk9=V5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 096C1C19759
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 19:25:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C806520838
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 19:25:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c1jQmrlM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C806520838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htGhk-0001Kp-42
	for qemu-devel@archiver.kernel.org; Thu, 01 Aug 2019 15:25:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43795)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1htGh1-0000mt-I2
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 15:24:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1htGh0-0000AI-Fd
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 15:24:51 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:35017)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1htGh0-00009m-80
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 15:24:50 -0400
Received: by mail-pl1-x642.google.com with SMTP id w24so32633438plp.2
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2019 12:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=XQoEyo+/Me95+3+iIxHAckcaZ8Df5JAWHiZ0Zwa0Wng=;
 b=c1jQmrlM4HRNfXibtVBfrkBki4PjaeElKIyS7uLqz/W0oOiICAgc5Z9TxVvq68I3X3
 VvsbPfld/nwnPHjodErSdtwNZ6VR9MnYodlpk0P9tuse7OB3VRHu/IwlF7zFyeIrhzGK
 6TImGA+AQDqdbw/s79W2GQF5aH/LkYD5obeY9tiVBPElMi5ZqtQ46x9o0mdg0Sd6Aurv
 wZlJNWvJrjmWNY/QxRSdk2idWGKG3HBQdOXOhpPsmFeW+wAWDK/IL2tw6DHK/yLs07Fh
 IFaL9NSBCIBCMdz+jaawH173aE0un2/clXioLnf/jRZNPNJs1xIzi2geB9vW3JQ2ccIV
 wsQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=XQoEyo+/Me95+3+iIxHAckcaZ8Df5JAWHiZ0Zwa0Wng=;
 b=DZvSCPt16ENvZlH4kMFk8jMZX3rJNpUw5SY6MU3zWLXHwih8CutArmZoy9rC0Agbvu
 2KrUACe7/AVv8jxz7rFfBSDp6ePf1HeiwerGKFO1xqDXVMjOeXa65KwsdUCfiGjmLvM8
 rC/XNR6FROtAQyVos18JrYGh1lDGt5W7/9XT88JmaMOhcyRoEnb8SMOxJDGtR40DI9I0
 t4pHgyqcqanKPrAqQhCQZsYefpT5nksnFa5JTQT/yowj9SCnkxZbg/IJJILO2TY6nu3z
 JdMBcYGJ9LR/As8yzuscBNfrO+J0f7wONIK561jf/PDHHsRCY3+Gnd8BaPwbi2W7eCgp
 xdxQ==
X-Gm-Message-State: APjAAAWZ9iupLkZBFDODA2dX8URIE5VlXYGiKHv718dSrDeX8rhG6WFx
 7ehMdqydsdqbMaxAo+lVHKJHTg==
X-Google-Smtp-Source: APXvYqwhdEPgYVAlWeNChuS1DwEEN3RqNeO1e3uXgguNCHm4tiZwx2mSH5o4zMu0NiyK+AntZicZOA==
X-Received: by 2002:a17:902:28c9:: with SMTP id
 f67mr88834107plb.19.1564687488905; 
 Thu, 01 Aug 2019 12:24:48 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id l189sm87775103pfl.7.2019.08.01.12.24.47
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 01 Aug 2019 12:24:48 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190731160719.11396-1-alex.bennee@linaro.org>
 <20190731160719.11396-31-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <a52579c0-fe8e-6e81-0660-8d575302cc70@linaro.org>
Date: Thu, 1 Aug 2019 12:24:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190731160719.11396-31-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
Subject: Re: [Qemu-devel] [PATCH v4 30/54] translator: add translator_ld{ub,
 sw, uw, l, q}
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, bobby.prani@gmail.com, cota@braap.org,
 aaron@os.amperecomputing.com, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/31/19 9:06 AM, Alex Bennée wrote:
> +#ifdef CONFIG_USER_ONLY
> +
> +#define DO_LOAD(type, name, shift)               \
> +    set_helper_retaddr(1);                       \
> +    ret = name ## _p(g2h(pc));                   \
> +    clear_helper_retaddr();
> +
> +#else
> +
> +#define DO_LOAD(type, name, shift)                   \
> +    int mmu_idx = cpu_mmu_index(env, true);          \
> +    TCGMemOpIdx oi = make_memop_idx(shift, mmu_idx); \
> +    ret = helper_ret_ ## name ## _cmmu(env, pc, oi, 0);

Why are you only using the out-of-line slowpath functions?
Seems like the rest of the fastpath should be included too.


r~

