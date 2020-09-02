Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95FD2C433E7
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 20:49:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AF02207EA
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 20:49:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XKFjCWvx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AF02207EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDZh6-0000cD-IF
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 16:49:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40610)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kDZdJ-0007IE-SX
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 16:45:29 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:33411)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kDZdF-00033y-KE
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 16:45:29 -0400
Received: by mail-pg1-x541.google.com with SMTP id e33so307986pgm.0
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2020 13:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=336XEXY67JuVQPWDpM8H3z5SXbE8DIazk9nwvjIKD1o=;
 b=XKFjCWvxiz8QbN/2FjtEc9VjPsxXgqiAvsogkbLFKKOX06B/mW1jsLZuF9v4pBSdKr
 KOjXhoc+4PkDX26X2EdBailV9fTKeEi50NpeN+9yZwm4Nuskn80sh+lYli1JV6p7SgzH
 5qdoLE7hg1WQ6KQcWi/d5o+nfwjKPjE61d4TzHAXymDCaGfD7oSwj7xA25N2+nz+vAV+
 /FSDS764rzgbEiNPk8BQusbTCyCO+xGQC7Wk6aKeUgzvIe7ve5KPyhU0eUZ9+wdqEmnK
 z+TyendoZOM8ACOKSHyHeTof5u6CSqB90C1HPZ/O/pWv5mDyWANGy4UlLKcBngE+tQxg
 C+Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=336XEXY67JuVQPWDpM8H3z5SXbE8DIazk9nwvjIKD1o=;
 b=VbubEXO9oDiqYyZLUsd6dMuHE1lpafu3nBeQPyWJ8pKvJ3wIXNn2EPiYhx8QSCh1UW
 EjhiT+TfQuigW8c0E2zN17cAlfAC9Y9/k04Gjv7a7U3XwCBvCuTJ+gbo7Zy9mwrQ7KNG
 JXYuVhuacBBVIUQRYS1wGOt3oIVHS7htZ2s7IQbB/Wi1Zf49Hv5zeaSAjn0n/IyVQgzY
 MnL0f4FA9l9TeU4BaVPtZ61GzkWKMQim964f471UtFmjEGOUgPyintnFPka6dwt2s+0D
 bxosFp9OzydNcr50NpClTA9MxL8pApu+nHHTExsm5AXKK6FIMKzVTjtchpNaFmVnKPXt
 KTXQ==
X-Gm-Message-State: AOAM532oixiqdyRD0SYw56uCeWI1lJoVwdM+H825ZOiGw2JY1wFZBULs
 pu+uJwAy24IjrelkrimZCuZtPdxFtUadjA==
X-Google-Smtp-Source: ABdhPJyx2L0az0K0P81v0QS1y5vw8rYL7s4FdiXrsMIxT0Fu2eMSAG3yo8PrZ4y/1zK63Mv6UdeFEA==
X-Received: by 2002:a17:902:fe94:: with SMTP id
 x20mr205920plm.117.1599079521310; 
 Wed, 02 Sep 2020 13:45:21 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id jz6sm285961pjb.22.2020.09.02.13.45.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Sep 2020 13:45:20 -0700 (PDT)
Subject: Re: [PATCH v3 7/8] hw/display/artist: Fix artist screen resolution
To: Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org
References: <20200902193456.29844-1-deller@gmx.de>
 <20200902193456.29844-8-deller@gmx.de>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <9dea1e42-6a0d-37d0-07c8-c02f1fa0e2b3@linaro.org>
Date: Wed, 2 Sep 2020 13:45:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200902193456.29844-8-deller@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::541;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x541.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.324,
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
Cc: Sven Schnelle <svens@stackframe.org>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/2/20 12:34 PM, Helge Deller wrote:
> Artist screen size is limited to 2048 x 2048 pixels and x/y coordination
> addressing needs to be done by OS via an uint32 value which is based on
> a 2048 byte line length, independend of the real screen size.
> 
> Since HP-UX seems to ideally need at least 640 pixels in width, this
> patch ensures that the screen size stays between 640x480 and 2048x2048
> pixels and fixes some pixel glitches were visible before on STI text
> consoles due to the 2048 line length limitation.
> 
> Cc: Sven Schnelle <svens@stackframe.org>
> Signed-off-by: Helge Deller <deller@gmx.de>
> ---
>  hw/display/artist.c | 37 +++++++++++++++++++++++--------------
>  1 file changed, 23 insertions(+), 14 deletions(-)

You did nothing to address my comments here.


r~

