Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55522C388F9
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 17:05:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 953AD22384
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 17:05:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NSeyWbhg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 953AD22384
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVHYV-00009q-EP
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 13:05:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42252)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kVHXS-0007rJ-Dx
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 13:04:38 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:39370)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kVHXQ-0001o8-85
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 13:04:38 -0400
Received: by mail-pg1-x542.google.com with SMTP id o7so1833659pgv.6
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2020 10:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=FZySLE1DeHmDSOzGWeUchw5plzxWugRNguJAN2bX7NU=;
 b=NSeyWbhg95lDWvjLp1a5XO/kUtzALiN9bbpX8An+mOXF9gJ8BN3alT0BVqrsB6JbU3
 T1ZcM8MoP2RU1j69QeaJh8ggQ1oVqhfk7xym23CiUOHZah0tqtVqkJwi17LkYXTa3Wdb
 VKgTd029jz5MfgGv/vSfG+nzuYlo8av5PzjpmY4ZTm/D8fBV16EtX08cUjrfRxG0G1E7
 K17rgjuhmg+AHv1/Zy+r+s37yiNeiLTp86CeJB+WY8MXjv4O7V3zlE8o1VzEbrr49XKJ
 n3R8WSfvECvi2LtvcqQo5EnGIoNZgpzEL5loLESaElIYFsIOSUI+aIMxboc8dBOI0A2B
 h/6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=FZySLE1DeHmDSOzGWeUchw5plzxWugRNguJAN2bX7NU=;
 b=TvhY0R6nEhgfKkWA1tEeXJmF3k6JEAcx9hCmBfz6p6iTFNauSpNWw0rXnCY3DT5G7a
 hQ6DCS+uuhB3d3srVb3492VH32TohRtql1/7GdV93Xt9R2C9KM1ZK4lA2xz7JpT21TcH
 JTJI2ECo2KXHZWEyDXg/23se6mjHHr1x5WhEWhO9UwN4ybrKPYdHNUgVG9aS/lrU4iJY
 S8JjXzyCq+s0hDMlOmqnEVrmgnM3VTAU0Z+eRACSSIr8G9i6j7ik3XYWIzJgV+uG3i/p
 tZ6CZcppc4pql3B4OGKHl4AZtysr9l8D6GKBPdCKrCvWcZSaXHjvBqZ8T9m7QsZYZYx+
 8eIA==
X-Gm-Message-State: AOAM533TPKdHjQxaZEl2xHpVZePh+UK/MzppOjRRGCPwWm07IEhDWtyC
 sjIylgHBF4j1ZDBvEUOXrrq4ew==
X-Google-Smtp-Source: ABdhPJxWEp03z9GnR2oXpZInMi5i7jl3QXwJRFTVT8mtub3oZNUtcifilmBc3Zu0XLRpuhF9pVo32Q==
X-Received: by 2002:a65:4485:: with SMTP id l5mr4257012pgq.121.1603299873714; 
 Wed, 21 Oct 2020 10:04:33 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id e16sm3058332pfh.45.2020.10.21.10.04.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Oct 2020 10:04:32 -0700 (PDT)
Subject: Re: [PATCH v11 00/12] linux-user: User support for AArch64 BTI
To: Peter Maydell <peter.maydell@linaro.org>
References: <20201016184207.786698-1-richard.henderson@linaro.org>
 <CAFEAcA9d7h=LCKP7B3G+Wx5CUr41+bY9ziyycGamL0EsTMgxDQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <dbd4fc09-2637-07ec-3666-276d8b0ed4af@linaro.org>
Date: Wed, 21 Oct 2020 10:04:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9d7h=LCKP7B3G+Wx5CUr41+bY9ziyycGamL0EsTMgxDQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x542.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/20/20 1:09 PM, Peter Maydell wrote:
> On Fri, 16 Oct 2020 at 19:42, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> The kernel abi for this was merged in v5.8, just as the qemu 5.1
>> merge window was closing, so this slipped to the next dev cycle.
>>
>> Changes from v10:
>>   * Include Phil's plug of interp_name memory leak.
>>   * Convert error reporting to Error api.
>>   * Mirror the kernel's code structure for parsing notes
>>     (though Error means that it's not exactly the same).
>>   * Split aarch64 stuff from basic note parsing patch.
>>
>> Changes from v9:
>>   * Split what is now patch 7 into 3 more (pmm).
>>   * All prerequisites are now upstream.
> 
> Unfortunately the bti-2 test dumps core (x86-64 Linux host):

This is odd.  Works on my laptop,

  TEST    pauth-1 on aarch64
  TEST    pauth-2 on aarch64
  TEST    pauth-4 on aarch64
  TEST    pauth-5 on aarch64
  TEST    bti-1 on aarch64
  TEST    bti-2 on aarch64
  TEST    semihosting on aarch64

However, this crashes on an aarch64 host.  Looking at the trace, the compiler
generated bad code -- the difference of two symbols resulted in 0.  So we never
copied the test code to the mmaped page.

I assume your x86_64 build is using the docker images for cross-compile?  I
wonder if my laptop is picking up a local cross-compiler instead.  And then the
aarch64 host compiler has the same problem as the docker version?


r~

