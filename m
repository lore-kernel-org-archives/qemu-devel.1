Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 208F5C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 22:17:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1D3B20709
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 22:17:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QI9pSivF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1D3B20709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZie0-0007X7-0G
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 18:17:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50350)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jZid4-0006QB-L4
 for qemu-devel@nongnu.org; Fri, 15 May 2020 18:16:30 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:45559)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jZid4-0003ON-1G
 for qemu-devel@nongnu.org; Fri, 15 May 2020 18:16:30 -0400
Received: by mail-pl1-x641.google.com with SMTP id u22so1459137plq.12
 for <qemu-devel@nongnu.org>; Fri, 15 May 2020 15:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=ztKdTXaWEcuKjhtsxzmm1tFS6PUpf8Nw0jAd99wSI+o=;
 b=QI9pSivFjeepo/wZiLUOal0JGhSXmUd19QDAPznBzfWimGTcS5yDHtW2G0pdiJNPbb
 nQwPRlaEYgOENFjuu4+OjK6OufcW8kkQULAroUezkTUK4JZbbGKr8IuL2xGAezAF1k4t
 r0iP9vVq1e0D8HeMwFsv6o9JnzQ09ms8qYZGVDZUdF5q8IdP3xJL77wQjHFQ+Rj7QnIT
 12OQ6ryi0p0XfnUN2olR2RAGgv23XKqkkx8QDJmEGv1cFPhKHKN0Y3+IN91jp90qRvp1
 RrmBf70NH9ULcp9r4TaziW7wEuU8J1mLCVNo09vLqeCFeG8/Vwu1PuKM0Cy5OvVfH2pG
 zzjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ztKdTXaWEcuKjhtsxzmm1tFS6PUpf8Nw0jAd99wSI+o=;
 b=L8PgbF7Dm2Ft5Bx0Dmo3E6qJmrbyzY4Az3roDWB6haSJBea9vOACXmR/Bz9uhxB1ly
 g9/S50H6ctLpw1ZUNG26G+dJ4J/Nj17XYEOeUaOETQO1wTZ9WinxHAPeDU8mFgXsQ3au
 GIvAKhoxqVU5366vXQ2dLBekjKtuFXGBBnrIdusAzRx9mU0MMJ8FkJjykcAIiczEDZLN
 WKsW4DMdQLGh23jWwGTn4B7K2P7q4zq3AA5fzcMHOzNsqttBfh0h3bjYwiQjTlpkWg1I
 E9/mhmlRuHfxItgkz7ldhtD4ALBCx09i3Vd/kJivux2orjJvB/9v3imMND4IGLP3Vx/K
 4AGw==
X-Gm-Message-State: AOAM532R1K7+qisqHYZEaLnOyOQ5/YgX2iWmqUA8R1nBiiXO9k5icOT6
 LFWLMj353lLl8KX1W80Ji1DyxMSuQ14=
X-Google-Smtp-Source: ABdhPJyUjwIP2F7ncI0BHM/mQ/Bl/ZrbDbt/IZnpPWUQ7Qgeoeh4K01ipMlFgl++cYCvyc/lICShCw==
X-Received: by 2002:a17:90a:4497:: with SMTP id
 t23mr5800900pjg.88.1589580987966; 
 Fri, 15 May 2020 15:16:27 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id c1sm2478705pgk.76.2020.05.15.15.16.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 May 2020 15:16:27 -0700 (PDT)
Subject: Re: [PATCH 02/10] target/arm: Convert Neon VSHL and VSLI 2-reg-shift
 insn to decodetree
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200515142056.21346-1-peter.maydell@linaro.org>
 <20200515142056.21346-3-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <79286fbc-ef38-69fe-a3e9-e8c013b0dbc6@linaro.org>
Date: Fri, 15 May 2020 15:16:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200515142056.21346-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x641.google.com
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
> Convert the VSHL and VSLI insns from the Neon 2-registers-and-a-shift
> group to decodetree.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/neon-dp.decode       | 27 +++++++++++++++++++++++
>  target/arm/translate-neon.inc.c | 38 +++++++++++++++++++++++++++++++++
>  target/arm/translate.c          | 18 +++++++---------
>  3 files changed, 73 insertions(+), 10 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

