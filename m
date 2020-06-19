Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E839C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 14:12:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE3AF20776
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 14:12:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aOECG+Ot"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE3AF20776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49058 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmHkV-0003PO-8W
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 10:12:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60734)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jmHjr-0002sg-SH
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 10:11:27 -0400
Received: from mail-oo1-xc42.google.com ([2607:f8b0:4864:20::c42]:45187)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jmHjp-0004Zh-01
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 10:11:27 -0400
Received: by mail-oo1-xc42.google.com with SMTP id k7so1906364ooo.12
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2020 07:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=kxX6D25DP1qhl3L5DvyUmj1JP4N/xtsAYz3XJRknY7Q=;
 b=aOECG+OtyvMfUqaCZiXAHAbVUw8nKcWgoCpNj6pQE29EKxWwkfGuxFAH0xDRhYaUyn
 FOwk9FNq5elBwwGY4qGBwh4qa3PuAKOpXasHuFNpY7bLJkvgCA5IkzHpY5jeWZEmhAat
 8PiHvPejYZGe5DdFkWcU4FNlPw8No3Rm+Fh1in6bMaVvZBuvx271oJIv43ikdpepQA3j
 is3kPYg0bPcB1dZfkAbJP049N88FxOfca0S0O+FHki8ZcnFkly3f+Yr2iPh67H++3bcH
 A1ej5vpR1Y5lekx1RXeVzcH0bIYtRX0kpBb30ng8ZZdQEYfF6THYq4ED+seSeNcc1zOd
 1tTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=kxX6D25DP1qhl3L5DvyUmj1JP4N/xtsAYz3XJRknY7Q=;
 b=fqe0kB0mE1N3PRG8r1j2CFGe6c0cbngy3PISFLkpcpHBgub3VEdiQDgL0UXWBwyFct
 B54fFxbptShqcvz4lpvbUpZbeWPFU4Hl07u6Wmfv/jdp+F2x1a6p0+i7T1pPUzMwcMp0
 ElidyZJ/nn4ircEjseT6D+5CS31tEcxFg/AMUVhSWhz2GP+3tBejATx9C6fzC5UVdz3N
 YgRm24tXBfADxd49MktT5ekoPmprez+9lHbxkMSaLQtMjyUabMidF/b/EfU/27oAfPrT
 975DFT9wKyKUtwWLZVSE8IpdNdoblvfdDTJbD3CsVauieYiwtJVjMvfPG93zx/oHzlkQ
 5mOQ==
X-Gm-Message-State: AOAM530FJi+KHATc5B0nGtkLH3/UDl1CovlGEd4zMhb5X6CH0K4EdGF7
 tsCCePIQhWKsOAhjdq8xg7aMb1UA852tr6Z6ERXvvw==
X-Google-Smtp-Source: ABdhPJyTolq2TxDAu4UCjd3FrSH0q+2R8H786b9bhMjzLIcxYAIaGuFtC2zLSiLwy+hSCzBD4Bg42NSLL5hyFl95qEg=
X-Received: by 2002:a4a:a20b:: with SMTP id m11mr3438334ool.20.1592575882388; 
 Fri, 19 Jun 2020 07:11:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200603011317.473934-1-richard.henderson@linaro.org>
 <20200603011317.473934-38-richard.henderson@linaro.org>
In-Reply-To: <20200603011317.473934-38-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Jun 2020 15:11:11 +0100
Message-ID: <CAFEAcA_X6_UX8a+G08zQG4Vc=6vdRairHCwZ_yWRS1ZZr9_crA@mail.gmail.com>
Subject: Re: [PATCH v7 37/42] target/arm: Implement data cache set allocation
 tags
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c42;
 envelope-from=peter.maydell@linaro.org; helo=mail-oo1-xc42.google.com
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

On Wed, 3 Jun 2020 at 02:14, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> This is DC GVA and DC GZVA, and the tag check for DC ZVA.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

