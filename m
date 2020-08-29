Return-Path: <SRS0=OYoK=CH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EF25C433E6
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2020 18:35:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64F9E20714
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2020 18:35:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xnWJsKM3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64F9E20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kC5hR-0006Xd-Kw
	for qemu-devel@archiver.kernel.org; Sat, 29 Aug 2020 14:35:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50016)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kC5gj-0005zZ-G5
 for qemu-devel@nongnu.org; Sat, 29 Aug 2020 14:34:53 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536]:35849)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kC5gf-0004hG-4n
 for qemu-devel@nongnu.org; Sat, 29 Aug 2020 14:34:52 -0400
Received: by mail-pg1-x536.google.com with SMTP id p37so2059553pgl.3
 for <qemu-devel@nongnu.org>; Sat, 29 Aug 2020 11:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=bIK3pDedK2jHWb+EMwthE5gVs/t/Vc27qZvNa0RKVKo=;
 b=xnWJsKM386srnpBoLt1q32CjcIHP0FnqEGcWAbnHvvzCJ6wnXuSik+9juj6FEsGQhP
 dAaREpTEN2+TPf96JsR3h6xcjPNeHjWIRzZGtb8LFQla330wTzSYM9738OAri/mB8Vb4
 MAPDWgdjilzdhSWHFSRYG9RDakmbhwJlfyJTf8nR7Y041nI0k1OD3L6hJeqSYsc1cumL
 P1UeEpgPHGjPgT5Fdx9Xapmrzm7EHFLvXV2EVddPmbTS3XvmuLSyzuFy3nwoldfik9Gk
 LRfLzwXFSGkeuRa3Lk4KXjCEEO01Hik71VGepvdkPZVtPFRhUDeCY/Oo90tnRd4yK2Az
 AWbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=bIK3pDedK2jHWb+EMwthE5gVs/t/Vc27qZvNa0RKVKo=;
 b=Fp7B1vK6BibVkJQL465HDc5mIXczD76S/409sRGDvqdw79nP9RTWSQ5G6IX0n6ci+C
 IeiW/o9b1Lyes3zEet2lP5f6KREhnRWbrw9BGHqyMQmfJCYXOce5uQEFABhfIDLBcNvs
 ke0Q2hNhHAvUFaUoYffoYw47QTThbWOBk2rC/7PsxBp8oc2WsB8YB71eFDkWpbIGtIVS
 I8UIA4VC9EJfWNjTn2p7XUYN7FQHl5S+mbl+lue/WrdZQulWT4q6uWlHCbHYVg6XtvjY
 no20XL628fBYUb9cVNnUs+Kof1iUtUCX/ivA/Jyyv5i+IzuFohQ9uQwN3w9NagpfLl68
 PcmQ==
X-Gm-Message-State: AOAM531K770dDJkg6T98D7pcisC+wgLUSEr/GU320feUtdgrl4ro2BTK
 soyaXQz0hL1QTgRbt1p6cqBGKw==
X-Google-Smtp-Source: ABdhPJxOr+jtXDX8OJnmfCmhqQATgNLnykjttwcDaVFQzOcthkprfdKhUtULiJDGwhjtrcbyRMtghw==
X-Received: by 2002:a63:50c:: with SMTP id 12mr3212665pgf.173.1598726087844;
 Sat, 29 Aug 2020 11:34:47 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id u8sm2647609pju.5.2020.08.29.11.34.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 29 Aug 2020 11:34:47 -0700 (PDT)
Subject: Re: [RFC v4 20/70] target/riscv: rvv-1.0: fix address index overflow
 bug of indexed load/store insns
To: frank.chang@sifive.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
References: <20200817084955.28793-1-frank.chang@sifive.com>
 <20200817084955.28793-21-frank.chang@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <fd619649-3a60-5b6a-eebd-aaf54371b0a8@linaro.org>
Date: Sat, 29 Aug 2020 11:34:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200817084955.28793-21-frank.chang@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x536.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.809,
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
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/17/20 1:49 AM, frank.chang@sifive.com wrote:
> From: Frank Chang <frank.chang@sifive.com>
> 
> Replace ETYPE from signed int to unsigned int to prevent index overflow
> issue, which would lead to wrong index address.
> 
> Signed-off-by: Frank Chang <frank.chang@sifive.com>
> ---
>  target/riscv/vector_helper.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

