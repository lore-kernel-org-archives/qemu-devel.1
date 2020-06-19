Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 061DEC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 23:47:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C57E6224D1
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 23:47:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WW+w5RjZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C57E6224D1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmQjS-00034u-1w
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 19:47:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58188)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jmQiS-0002J9-AO
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 19:46:36 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:44318)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jmQiQ-0002nt-Tw
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 19:46:36 -0400
Received: by mail-pl1-x643.google.com with SMTP id bh7so4576718plb.11
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2020 16:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=patXfXvHSAhs4OxUEourPY4HPPp/uRhGUONW69Dqhp4=;
 b=WW+w5RjZkeGRuC1coSjBBgv7+fdjOz3W1o2IrEsfbogvXQR1JwQElbmNwka6PLBFCh
 mcl1Wj41UaJDCIkx6akkF/jUZ3Grbt2fYckMs3YW2cJOlTllcMZ3NQrKUjlPpSpculBC
 ia2ZCFXQRCY02HwXkil3+aqgwCyDNea0l4jOzCefDqiIfto/+Is5HYWIJs325KgMILr4
 zQYtEN0yoIR2x2d3WEIjuY+SchfCnCJSD3/C4Rcm7k5MzjW0Zm2G7zUJZUGo940vh99A
 SGPaHEnjU+JlbRMHrA55niVaK1XztaFBajBL8K4s4KwMQ/fT+LVtaQflAXg1x9T0eny6
 WdKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=patXfXvHSAhs4OxUEourPY4HPPp/uRhGUONW69Dqhp4=;
 b=Y0z0F0behNAuZklNM2o6NMUHyNkH7LCTOR4pTC41wjl87r0tVCdybRD3pT5GzW1ecN
 ibz7MBkwTNxkECHLz+FZVFgUofPIewYGwBVh+za2p1brgpMb5L+6XPOc1Q0UyCwiBxQ2
 onkGqyPJVUETUp21TZiRZWl8Oc2uDmgMs+hjngdQOoxYA2G/KjYHXhyBV8r/nMMrr4I2
 qNfpXDa6lZQgsenMXkKBrUHI5TZ948eu3eBes7jcI81/Fe7BokaYfdeGl05JZCPbG/ag
 no8Dsasp91svTt/V8+di0Dz4kO/8nRmCX7JBaPV/EDwX903nmjm3Fn8jGL/AvBZ/XZH3
 8Ljw==
X-Gm-Message-State: AOAM531dCRPR+Vau1IcXRc6WM1/Jz1hUwi0PbmYZIJsIOKpGc6AAnRZU
 MwePauakVu4uN4I3gKn5nTn9w+YxmtU=
X-Google-Smtp-Source: ABdhPJyjNpgqq/p7cqRqos3uIy+YWn8TzE3AhhF39+CXZzzEhFFnZRy1aTywTvdoN1BYHATMbzsKuw==
X-Received: by 2002:a17:90a:336b:: with SMTP id
 m98mr5854357pjb.38.1592610393216; 
 Fri, 19 Jun 2020 16:46:33 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id j130sm6911972pfd.94.2020.06.19.16.46.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Jun 2020 16:46:32 -0700 (PDT)
Subject: Re: [PATCH 16/21] target/arm: Convert Neon 2-reg-misc
 fp-compare-with-zero insns to decodetree
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200616170844.13318-1-peter.maydell@linaro.org>
 <20200616170844.13318-17-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <96abc864-e978-4a88-3be4-cfe6c94510db@linaro.org>
Date: Fri, 19 Jun 2020 16:46:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200616170844.13318-17-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x643.google.com
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
> Convert the fp-compare-with-zero insns in the Neon 2-reg-misc group to
> decodetree.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/neon-dp.decode       |  6 ++++
>  target/arm/translate-neon.inc.c | 28 ++++++++++++++++++
>  target/arm/translate.c          | 50 ++++-----------------------------
>  3 files changed, 39 insertions(+), 45 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


