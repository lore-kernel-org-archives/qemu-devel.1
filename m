Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43B42C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 11:05:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DD7B2080C
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 11:05:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dXSFBhBG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DD7B2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmEq9-000568-Bv
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 07:05:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35918)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jmEos-000443-MW
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 07:04:26 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:38716)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jmEoq-00051Z-9J
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 07:04:26 -0400
Received: by mail-ot1-x342.google.com with SMTP id n70so6961936ota.5
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2020 04:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=00nb53DQBh2iKXbOY7W3WK7e7J38B3c5DAmLhVafIsg=;
 b=dXSFBhBGeQkLCoxEJck8uGJkTaDoBEn6KV+fszx+ma3TQ/C2mP1zmbzoybUntLlEk7
 xF1FSyTd/XaSvjB7TxJ3bvBi1YtJWcfQH2tQ9A6IQcqR0P7ljmddMl3Ph53TyqWOLNdf
 kgqy3I3Z54+VMnH1U127vzccNPYjrjrw/dz6l8CMnGdj0NLoJeoYgPqBQHx99+5D7AOh
 2hMJ/WW+l3xQHz4qmNOYR1ciHM2nLXnGwAe2k6NZLgfvtGhnohMPBMEfjT+bjRcu9Gr6
 NGN5OPmR2tAxKiy9XZlbcwKQu5VZnlVnszlrL3g70gmDkQRlrSky7AHRJr/gJyrnaPQ1
 nb6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=00nb53DQBh2iKXbOY7W3WK7e7J38B3c5DAmLhVafIsg=;
 b=DxUN6NsjKWLUn7oaCiZa6DP68lvB6oKRS3VVatozrPzUXajGYoQ3kosXCeSLwBg8KD
 X8eS4ZC8tJimUYSllXIKjE0pF5dnsNiqHvmKD7JACi5CGBD6UCObXX3YC8p7EGRKtjQc
 7V2Z59rhWN3ndhTME+7K5T9m7LlIobApGEfmGs6YxpmC5fcIa8Rn8X3uhZ9a25dLGHP0
 zb704Fk3PbTC+xpkJRo06ERCejtwUmrO4C49mRjBFFmsNWg4rg1f1XU7jVZEyCjERde3
 BOQcH9JRdAh89lnIDmcKHodoDJaA4L+U6SQXXG9e5IF4g7AHypF138irXQTdd8zZVy99
 b+BQ==
X-Gm-Message-State: AOAM530ZPKcYEp5y58wOO2geoSKvz9WOahMTKa52Av2xtpq/UfGNgmZm
 LZ8G9qstVH7e/LWeOi1yP+UNFaLYCTw7hQiwBHVPXw==
X-Google-Smtp-Source: ABdhPJyZthPcXdUftBP9PYtfR/Wcwboj9fVWaL2jbbi6r+53PtyVh8sDnIjjPIJeP81JLWdxhF2QqpiSuea8uJ/Euo4=
X-Received: by 2002:a05:6830:18da:: with SMTP id
 v26mr2584288ote.135.1592564662926; 
 Fri, 19 Jun 2020 04:04:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200603011317.473934-1-richard.henderson@linaro.org>
 <20200603011317.473934-20-richard.henderson@linaro.org>
In-Reply-To: <20200603011317.473934-20-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Jun 2020 12:04:12 +0100
Message-ID: <CAFEAcA9Tb1X6E-6FnbAEUJM=Jzam6tt5c36-Zm_yWp_=E8Ms6g@mail.gmail.com>
Subject: Re: [PATCH v7 19/42] target/arm: Implement the LDGM, STGM,
 STZGM instructions
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::342;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x342.google.com
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Stephen Long <steplong@quicinc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 3 Jun 2020 at 02:13, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> v3: Require pre-cleaned addresses.
> v6: Check full mte enabled.  Reorg the helpers

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

