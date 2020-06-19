Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20E0BC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 23:34:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF07C2186A
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 23:34:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dJ4OOMgJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF07C2186A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmQWk-0000tU-87
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 19:34:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55980)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jmQW4-0008Vb-TX
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 19:33:48 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:53668)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jmQW2-0000iY-9d
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 19:33:48 -0400
Received: by mail-pj1-x1043.google.com with SMTP id i12so4737422pju.3
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2020 16:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=FXL541S86pY10jik9JK1gqpT2iKiQXGzZHE/V77i8fc=;
 b=dJ4OOMgJo0evDL0D+x1QF+irYV7CJyQBsXTIcW5YvN8e6hCGb3stTZmMpz8zp8ulxp
 uvrOGOU+gYfMAuR8La/8XRoswHmeVnzic6r8/EDnY5olkOzBKH/3HSD9FU/MEEYYWBFN
 8CZhFJHfZFydE8mpf9sntaVwpznrLdso52hXTCwkWmyPAeFp9rCVcFRrbyzlxF12vcLP
 lYdu/FGe4JDJXCpS/YDH4uJiIp4H3ktuJE8lx08lbK67Ag5LAdRjwa+3hLZHMzUcOTEF
 n2Qa/E63QKjQsMVQ80eRaKcaQ+nJCv43/Fc1fdz2Gw6Fb66XFRkizYFd2UMJrrPWbBy2
 awdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=FXL541S86pY10jik9JK1gqpT2iKiQXGzZHE/V77i8fc=;
 b=Fgj/9g1tjxTi/0tZpf8Sw5D2mcdKuJSUdqxlYuY9254AU4lFL35/zZHngE9iyyTZ7w
 VGHFegAkETVaWsmHkUrOdhv9+ihVGzjReqr81dOit66ApFwsXn4GvFR9mkOmwRVmMV46
 4T968+iJ2p722aydaXVZIUFunewqpU7HMl1zWmfAPGmw9ErxR6drb0AUaOwWFsOyCB3Q
 6XybE3bOF7Gf3JcFmM05WhurQBGRbiIx+R7vcmnqkcAUfP0MKZm7m1gerkhovYkNJNiF
 A9O0saypt8mU1cjW01Dmne0xCBgpWhefnGQ1wMI46qQpnl163dq/g5gTIxadgRfAReGA
 6d6A==
X-Gm-Message-State: AOAM5300Pw0bPc2xoyHc0jS4rX7pGTPWL6dogkifXyGTuQESvj5QiSzs
 yCvw4ul94U78h0Va4tjrnBN5UbdqMrw=
X-Google-Smtp-Source: ABdhPJyAssoHGXMc3Dw0BR94Mitsv8GvlUWH5eDGgP6Dwc3Uo5mQPe2mnGuQlXBZ/kQdiU1XugQmLQ==
X-Received: by 2002:a17:902:7d8a:: with SMTP id
 a10mr9794020plm.160.1592609624625; 
 Fri, 19 Jun 2020 16:33:44 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id m14sm5961564pgt.6.2020.06.19.16.33.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Jun 2020 16:33:44 -0700 (PDT)
Subject: Re: [PATCH 11/21] target/arm: Make gen_swap_half() take separate src
 and dest
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200616170844.13318-1-peter.maydell@linaro.org>
 <20200616170844.13318-12-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <298e02b2-e3af-ef31-3d65-7a031cb7df0c@linaro.org>
Date: Fri, 19 Jun 2020 16:33:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200616170844.13318-12-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1043;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1043.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/16/20 10:08 AM, Peter Maydell wrote:
> Make gen_swap_half() take a source and destination TCGv_i32 rather
> than modifying the input TCGv_i32; we're going to want to be able to
> use it with the more flexible function signature, and this also
> brings it into line with other functions like gen_rev16() and
> gen_revsh().
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/translate-neon.inc.c |  2 +-
>  target/arm/translate.c          | 10 +++++-----
>  2 files changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


