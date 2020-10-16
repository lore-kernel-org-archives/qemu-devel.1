Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4856C433E7
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 23:49:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06C7322201
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 23:49:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GdXGz2Z+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06C7322201
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTZT6-00066H-Mb
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 19:49:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38684)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kTZS7-0005b8-VP
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 19:48:03 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:45198)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kTZS6-0007hU-Aj
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 19:48:03 -0400
Received: by mail-pl1-x644.google.com with SMTP id v12so2067704ply.12
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2020 16:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ZVW7yJ/13kjwcl8Wy0IS9kr1o+xMer4wX7nQcI21J4o=;
 b=GdXGz2Z+VOcN05o17rt9PJJFiF2VGMNIu35mEFneyj/x5vRS5iV2+SjY0meyRqcMEX
 k3BbfR0SfUiPg1SZk5QXP6hnZfzUzYeAf6oQEqdqy3n/XUzl5BvUabBlvudY1kQTQonw
 EZsDoPqA3/Uso6nn9UOIGp75F+ULbTZqKQL4Cbo0NOcU+LHYDEMjjyPBfYlRKV6i5+Lr
 +ykWL9SsVHx97QlCfEudwr/L/FjqpkXYacM7g9fZGjWyCpvgR+/eaXomdQ7X5wX6EXrq
 vh9kP6Pv2xn9osCs4aiEPyf1MhY90lYsupHOPzT2Mg39prSmJmKSOzsJoRDUJ4DOL2pd
 rXlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ZVW7yJ/13kjwcl8Wy0IS9kr1o+xMer4wX7nQcI21J4o=;
 b=tGY9fo86a+EUbsanUZm46AfCCKAPxXBL3s2XfpjeeIrSZ+GEA4pH4Ta5C8uUZX+BPX
 fJ6Gkb5YPAu/BKpT/+pZpS8vKzQysB2ZehPrr+SqTU6xXJwJClFhjkAuZYUirpZ3wFrS
 l9FkUlJzpcOlfP1IwE5mSw6BW6KQ7rlmTyN+KgbtYcRdZbB90cGJqadnocAjPtVY8WR0
 yzvGJIofyWEukY8ZqZZAsqVccbW3FabcIMmJ3RD2qRioF4qcs8nU9LR415ssFr7DGycx
 WVE6n7OF+SgNCAcMO96VauwcIWCFAuJTrXWjlVnwhQOhHVSkOdFTolM/6Ie9VlRWirh1
 0mtg==
X-Gm-Message-State: AOAM531e03QzEuQSc5kh5LmvVFcEkeQk97LPCQB9HuhLD4sPTfP984R5
 teYi6Nr+VdRT4rXcEx4KCGOA0w==
X-Google-Smtp-Source: ABdhPJwdYNfEYRMH75xIVG+RhBiRzP6bpP+bw5QuETN2OCuCyM9NTzb9f53lF8tujIqGINd27FBLYQ==
X-Received: by 2002:a17:902:b107:b029:d2:ab87:c418 with SMTP id
 q7-20020a170902b107b02900d2ab87c418mr6653395plr.40.1602892080647; 
 Fri, 16 Oct 2020 16:48:00 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id t3sm3700794pgm.42.2020.10.16.16.47.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Oct 2020 16:47:59 -0700 (PDT)
Subject: Re: [PATCH v3 5/5] [RISCV_PM] Implement address masking functions
 required for RISC-V Pointer Masking extension
To: Alexey Baturo <baturo.alexey@gmail.com>
References: <20201016221138.10371-1-space.monkey.delivers@gmail.com>
 <20201016221138.10371-6-space.monkey.delivers@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ed0a6658-76a7-d9cc-574e-93b2fb8af6c7@linaro.org>
Date: Fri, 16 Oct 2020 16:47:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201016221138.10371-6-space.monkey.delivers@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x644.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.253,
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
Cc: qemu-riscv@nongnu.org, sagark@eecs.berkeley.edu,
 kbastian@mail.uni-paderborn.de, qemu-devel@nongnu.org,
 space.monkey.delivers@gmail.com, Alistair.Francis@wdc.com,
 kupokupokupopo@gmail.com, palmer@dabbelt.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/16/20 3:11 PM, Alexey Baturo wrote:
> From: Anatoly Parshintsev <kupokupokupopo@gmail.com>
> 
> Signed-off-by: Anatoly Parshintsev <kupokupokupopo@gmail.com>
> ---
>  target/riscv/cpu.h       | 19 +++++++++++++++++++
>  target/riscv/translate.c | 34 ++++++++++++++++++++++++++++++++--
>  2 files changed, 51 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

