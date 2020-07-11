Return-Path: <SRS0=vx8y=AW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39504C433E2
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 18:34:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 086EF20725
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 18:34:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dpRVPyNi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 086EF20725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juKK3-0004R4-Ag
	for qemu-devel@archiver.kernel.org; Sat, 11 Jul 2020 14:34:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48714)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1juKJT-0003v7-K1
 for qemu-devel@nongnu.org; Sat, 11 Jul 2020 14:33:27 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:36773)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1juKJQ-0008Br-5W
 for qemu-devel@nongnu.org; Sat, 11 Jul 2020 14:33:26 -0400
Received: by mail-ot1-x341.google.com with SMTP id 72so6602924otc.3
 for <qemu-devel@nongnu.org>; Sat, 11 Jul 2020 11:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+aYABooH1OESbaFVdKpN9uc4H4yGymKyz0M2s5rGCSQ=;
 b=dpRVPyNi2j324OhciYBIvF09TmZgPkdr0anKtdgtCUpx1tmiuKPe4ZXwBnAiF86m3M
 RXBBENJ2NrLt3wQ5EIJoOuFVCy/Nl0A9OmLI6pDjnl/iLAQ3Eq1xy+5SV4TMEAR2FN6b
 VCjc1yQ39ZEH870XHMlwGS8aBmQ9p+4PJmXArtBu6hkmOFpa/KXQQTt/LLobtzqvFnug
 7UKErtBINJel63cOQ1bWgAWpHqkrn3L92KWEUlRhIAnuURlEmxMUKr9kNWyQDwh4phkw
 dJsPxGMLW1PhOPW6CjzFeNrtxyO8C7uzE6LKSKOS9AR2tSf0RV5zV+6x6wQATjnSQnfZ
 auwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+aYABooH1OESbaFVdKpN9uc4H4yGymKyz0M2s5rGCSQ=;
 b=biVgCCRoL+aqucehfvyfQi7Gr3HNUBpBhesC4tZj00Tpmel2qkojRo1a/g0FH7qXyO
 GxKf0yTn3Eh9m6C7GriyH0ZC1SAU5K7pFwZl4iMSMMfCL5RUI0muUCEEPR2kg9CmodrH
 hMNVsyFak1TisNZQ+Q8MJWX2kBkiTJ98Q+TMhnN8vnQwCJoAm11jQFWJ8N+knlBo7a1j
 5W8GdF0m9HVnjwjsVX4P4ckJ8mmODIomaOwRWgJodQ78f3VFj20SRNHvyjnRnh4f8kKU
 LoNLna6rR+ApuL8dyZe6YChtsyT21v+o4R/Z4CrzvC+EgD74S8cMLnSdpZjFZTBZMYWK
 yyIA==
X-Gm-Message-State: AOAM530WVI4J27QTPZmRLLKEDGqRudBry+1TNr99gB2y47Mg9bQlJsq3
 EP4Iv0XDHn3oMx3wnlmMjn85lmVAvz/ZIM/zVlnf2A==
X-Google-Smtp-Source: ABdhPJwkZYPghvqttfzUmMpvQcujg3Xzp4BwWqFj57l1QjKmrVt4antSXsKGi2j+z4KvTuXVZK8weAkRUx9HeX7j50M=
X-Received: by 2002:a05:6830:10ce:: with SMTP id
 z14mr56355260oto.135.1594492403004; 
 Sat, 11 Jul 2020 11:33:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200628214230.2592-1-peter.maydell@linaro.org>
In-Reply-To: <20200628214230.2592-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 11 Jul 2020 19:33:12 +0100
Message-ID: <CAFEAcA_yJZ7TF=xq-q6kpdX965iOZOS6B9kh16EM9Z0zCkVXdA@mail.gmail.com>
Subject: Re: [PATCH 0/2] hw/arm/palm.c: Fix Coverity issue CID 1421944
To: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::341;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 28 Jun 2020 at 22:42, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> As for spitz and tosa, fix the Coverity issue CID 1421944 which
> points out that memory returned from qemu_allocate_irqs() is leaked
> by encapsulating the GPIO handling into a simple device.
> As with the other series, detabify the file first.
>
> thanks
> -- PMM
>
> Peter Maydell (2):
>   hw/arm/palm.c: Detabify
>   hw/arm/palm.c: Encapsulate misc GPIO handling in a device
>
>  hw/arm/palm.c | 111 ++++++++++++++++++++++++++++++++++----------------
>  1 file changed, 77 insertions(+), 34 deletions(-)
>

ping for code review, anybody?

thanks
-- PMM

