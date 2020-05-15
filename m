Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44ECEC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 22:35:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 107B220709
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 22:35:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O7YCYvm0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 107B220709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZiv2-0004qF-87
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 18:35:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52666)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jZitj-0003jN-Rk
 for qemu-devel@nongnu.org; Fri, 15 May 2020 18:33:43 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:33286)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jZiti-0000uM-T7
 for qemu-devel@nongnu.org; Fri, 15 May 2020 18:33:43 -0400
Received: by mail-pj1-x1042.google.com with SMTP id z15so4587459pjb.0
 for <qemu-devel@nongnu.org>; Fri, 15 May 2020 15:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=C3jzRQ2lc33ZEkCVnum/KVNJe2dNst6uUm3942B3BRY=;
 b=O7YCYvm0lEYetispI6xcgl2mp9kAhFCIIu38f08Lj+pdXnHCxbVCjU9vjFuDFHuLc3
 1jx3fo/4S8bo9X3Bqi5up09KIa3ziOgiTke58fgA/JNvj8sFQc0DyuFAFBc5MxWD1Xoy
 XOr2rDsa5fA/UbMbFHObV+WHez2pAXUi9uXpnkCY+8LF+ZELjg0DUizcY+EUDahmL+gX
 Sg0W4IWu60kSyh9/1xjW8DpwmQvQZKmOAnicZMEP2LVgbefM3Z+yMb3Nzp1fwWy3/YN2
 BTif71vjiV9iLnOs0lJmxF0AUDxdCMK0hEa6geDV2Aroitack9rdUfKGzqDv4JhtUqJY
 8Xkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=C3jzRQ2lc33ZEkCVnum/KVNJe2dNst6uUm3942B3BRY=;
 b=QsmWc3K+ASak38+iyCcsYxTJLrQZa9FW6qqEZ01DDgjehU40/57Ktzi7WYd3wf4OdG
 F0qhyCy/KPb/84IsGNfEw4/0I2URD26UeU+TOndf4K9oVZ1ldSfMwMlXE8skip2IUP0v
 54Qa5rijGY7Myg57JdXz6Oe1lMS6btGPQ9Ui7U/OzRpEwuFGPTFqTdzTN1Izq/PTnRmu
 a9rHsh7f1539ayzdsok88NVmG/MQNtCBwm+6gb86Jf/9xShK2CFJ0WvTdn6IulqO3RiK
 6csuo7Gbj2b21qo6Th2YVUgQgaM1UCBPNT4c758tNGobePb4BmCJPgcvhuzS4Afnw5Wo
 qKAg==
X-Gm-Message-State: AOAM533XX5x23S6AfH8BiwNH3TU/W/4WZ6ym1Ro3L4w60Ml+Vi8jfkC2
 z5/FAA6ILSN9tY5/ugiRR3FNIQ8unhA=
X-Google-Smtp-Source: ABdhPJziMTnEfodLRK88FCbptt3+OZwzf3y+Fpv5gVL9Dzmv7OukDPhZJBoI+CWPqay7XujwUf2L2Q==
X-Received: by 2002:a17:902:301:: with SMTP id 1mr5590450pld.65.1589582021025; 
 Fri, 15 May 2020 15:33:41 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id 140sm2730923pfw.96.2020.05.15.15.33.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 May 2020 15:33:40 -0700 (PDT)
Subject: Re: [PATCH 03/10] target/arm: Convert Neon VSHR 2-reg-shift insns to
 decodetree
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200515142056.21346-1-peter.maydell@linaro.org>
 <20200515142056.21346-4-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <64785172-4e44-24a9-f965-fcff3f61d364@linaro.org>
Date: Fri, 15 May 2020 15:33:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200515142056.21346-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1042.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/15/20 7:20 AM, Peter Maydell wrote:
> Convert the VSHR 2-reg-shift insns to decodetree.
> 
> Note that unlike the legacy decoder, we present the right shift
> amount to the trans_ function as a positive integer.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/neon-dp.decode       | 24 +++++++++++++++++++
>  target/arm/translate-neon.inc.c | 41 +++++++++++++++++++++++++++++++++
>  target/arm/translate.c          | 21 +----------------
>  3 files changed, 66 insertions(+), 20 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

