Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57FCCC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 23:52:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D8EA22482
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 23:52:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gBAaFhVD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D8EA22482
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmQoS-00076P-Do
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 19:52:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58810)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jmQnn-0006Zq-Vs
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 19:52:08 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:39999)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jmQnm-0003Ud-Jm
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 19:52:07 -0400
Received: by mail-pf1-x442.google.com with SMTP id s23so5149531pfh.7
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2020 16:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=xRz6Y/zjuBr5hAYlbSqvWITymCDh6v7bthIplErXgp0=;
 b=gBAaFhVD1rSeAE73sbLBss9wIJYLUrXX/HwBQ88CoOPyv0fKlXdiA00/hiOa8QixKq
 zVXy2wT20QX4EMpwDa0YZWoPuA+V5SpaIU7YUdgZPMYW1+jSGW7oOAzyoM+nftqr/U9l
 GKNt4wbtIEIaWaqwDojpvoOaLgDYIw/9n3CRxmNRWKyBmH8iyhw+i87ULyD/DS9GC5UG
 cbkUxWHCAXiBfasvtmG9jnrtKlhTWp3Frzqm0uemf9I6WpxC+9MJx89uILs2Sx5porRZ
 BDo0f8LCk7i6PcLcdQNTBzKwz9lHmTpWO9BPzVxvOgBqC4Cze2FyVrwFHCavQueLK6WB
 lSWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=xRz6Y/zjuBr5hAYlbSqvWITymCDh6v7bthIplErXgp0=;
 b=iDoxt3WPP6gxG1t9m/UGREUx+qG9XtHBMnwrDpt2wsBpYuwnUpeDS3mJ9xwd9QmKGD
 XGyoO7CH9y924C3fCNHmXiQhKJy/oBL0+Y1zhRQPJYeyH79G+ouLIqZDaTLhzYCYUeCd
 Qv1Yrl7PJ7s1azEQsq1/50+i9i505zODK3Bj6GUaQpNAR6m1aHwkizRbXWu09pKaP7H3
 qNBHCuyX/tg4FXydXJpvvwarMTp0RlHbQCzIkvFz8ikHWcWEB9MFq51Y3c56UI4LqBbk
 wm6uOW2yL5NSc92+UKR+DyKxi/eSUXaniBjBfrKRPXzrH8vSoA/qTc/PBdjjOHckwrcJ
 chdw==
X-Gm-Message-State: AOAM530fEJPNPK6Mbj73W3+Z74/JEM6BieRbrOXcLhcyuIG8HvhxpEYu
 2AP8pL1V7T5vgqxOa87eNjUENNr0ynk=
X-Google-Smtp-Source: ABdhPJxdeMUjfNUhJ/8Gf9rchJGbmLtwN6j6au8uztMcc3fRh9BZ/DhhMfdMRzrkIzqqie86g2wz2g==
X-Received: by 2002:a05:6a00:1514:: with SMTP id
 q20mr10402430pfu.243.1592610724838; 
 Fri, 19 Jun 2020 16:52:04 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id d25sm5828143pgn.2.2020.06.19.16.52.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Jun 2020 16:52:04 -0700 (PDT)
Subject: Re: [PATCH 18/21] target/arm: Convert Neon 2-reg-misc VCVT insns to
 decodetree
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200616170844.13318-1-peter.maydell@linaro.org>
 <20200616170844.13318-19-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <732d86fc-f6bd-79bd-f06d-4a51784a240a@linaro.org>
Date: Fri, 19 Jun 2020 16:52:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200616170844.13318-19-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x442.google.com
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
> Convert the VCVT instructions in the 2-reg-misc grouping to
> decodetree.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/neon-dp.decode       |  9 +++++
>  target/arm/translate-neon.inc.c | 70 +++++++++++++++++++++++++++++++++
>  target/arm/translate.c          | 70 ++++-----------------------------
>  3 files changed, 87 insertions(+), 62 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


