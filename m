Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BF79C47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 17:42:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8D29206D6
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 17:42:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fDXAiJtv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8D29206D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47824 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYCRi-0006Ed-Vx
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 13:42:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36550)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jYCQN-0004lI-S5
 for qemu-devel@nongnu.org; Mon, 11 May 2020 13:41:07 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:45361)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jYCQM-0005Nu-Lr
 for qemu-devel@nongnu.org; Mon, 11 May 2020 13:41:07 -0400
Received: by mail-pf1-x443.google.com with SMTP id w65so5047918pfc.12
 for <qemu-devel@nongnu.org>; Mon, 11 May 2020 10:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=rxhr+5XTCC3+CaV/PdnCJ70aHzTQhCm67LRY7QT9O/c=;
 b=fDXAiJtvyxwaC6ed8yLX1a46kFHpjHtGgPzRsSQgZeW1rnLMBUFKbLRLi9rvk5pws2
 ZI28CmShVLjPxXCwXyWIW8e9NmEAbymJqonugNcUEoXRwBYL4frq6uH4Pi+J1M0Xfa7b
 YhqN/4SZl3VJ7BH/ZvSusaMGEO4jntjftzTOhbc/1mk31LhO14UBjqPGm9SYRmOKhHdl
 zhIuqPhOfdKeazL2nrbcDWDji/ODIMxD6ZQKBOp3s4gTYXpkvhestCKpBIwhfTjLyQvu
 DEc27tWhWCHRjZdIBLjxW4z77KGQ/WTKdQFc9dhoYvXRLjEJnJcTw4YRw1NfeE7AH/6q
 PeHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=rxhr+5XTCC3+CaV/PdnCJ70aHzTQhCm67LRY7QT9O/c=;
 b=hDxTB03UaQfwK5kMYAXGh5bPxuv2jpjhhss2wnsw9rh3L+m6EZUOKoSjmp7/c1mSoS
 dlfKZ04BzLqISIPgfpnYuiP6UVFryMdkbR3Eb5s8QUnCswiw3eB3Rf5D9Wf++Hg6oDZZ
 Uw02/ul7MiLglA+zovd1Ys+9lFVz9zjOg/TBX8zNI82ylsiLArAeHAG8xv6UeAeM8Kh+
 f+2+K0Woh8sk8lh7dTrSUT9bICkvzR0zwpshl/ElyQLHsmrdj2UXJsAVLM7/1iSZ84Q5
 jHGwO+ILFMJE/Xf++9+vmropbxtviByXjHPcetHEpRN5lQZWqS/VPjHmY5cy3MpZ3nqM
 6GIw==
X-Gm-Message-State: AGi0PuYARILet7JNg5RcPHF8H/tKjQgwgSYF2coKX65oVnu1bvQLGdAl
 xUXtIJESxQEtRs+YKE16k8y68Q==
X-Google-Smtp-Source: APiQypLO7cU3w+kenGJPMzVd2x+NqHp2Xj6VLnLbmL2zc9GYZRISKf9lq6ZoBNKiZloylZS6JgG3BQ==
X-Received: by 2002:a63:5a4c:: with SMTP id k12mr15099462pgm.50.1589218861290; 
 Mon, 11 May 2020 10:41:01 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id v133sm9699777pfc.113.2020.05.11.10.40.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 May 2020 10:41:00 -0700 (PDT)
Subject: Re: [RFC PATCH 2/8] riscv: Generate payload scripts
To: LIU Zhiwei <zhiwei_liu@c-sky.com>, peter.maydell@linaro.org
References: <20200430072139.4602-1-zhiwei_liu@c-sky.com>
 <20200430072139.4602-3-zhiwei_liu@c-sky.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <70ed74b9-83bb-c3ae-667a-bd74826acdd4@linaro.org>
Date: Mon, 11 May 2020 10:40:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200430072139.4602-3-zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, wxy194768@alibaba-inc.com,
 wenmeng_zhang@c-sky.com, palmer@dabbelt.com, alistair23@gmail.com,
 alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/30/20 12:21 AM, LIU Zhiwei wrote:
> +    # sequence of li rd, 0x1234567887654321
> +    #
> +    #  0:   002471b7                lui     rd,0x247
> +    #  4:   8ad1819b                addiw   rd,rd,-1875
> +    #  8:   00c19193                slli    rd,rd,0xc
> +    #  c:   f1118193                addi    rd,rd,-239 # 0x246f11
> +    # 10:   00d19193                slli    rd,rd,0xd
> +    # 14:   d9518193                addi    rd,rd,-619
> +    # 18:   00e19193                slli    rd,rd,0xe
> +    # 1c:   32118193                addi    rd,rd,801

You don't really need to use addiw.  Removing that special case would really
simplify this.

> +sub write_memblock_setup()
> +{
> +    # Write code which sets up the memory block for loads and stores.
> +    # We set r0 to point to a block of 16K length
> +    # of random data, aligned to the maximum desired alignment.
> +
> +    my $align = $MAXALIGN;
> +    my $datalen = 16384 + $align;

risu.h:#define MEMBLOCKLEN 8192

Why are you using 16384?

Also, typo -- you're setting r10 not r0, obviously.

The rest looks fine.


r~

