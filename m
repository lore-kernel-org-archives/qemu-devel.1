Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A0AFC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 14:47:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E067920787
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 14:47:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MavUC32T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E067920787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jah2l-0008Pl-50
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 10:47:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44112)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jah2C-0007wZ-BJ
 for qemu-devel@nongnu.org; Mon, 18 May 2020 10:46:28 -0400
Received: from mail-oo1-xc44.google.com ([2607:f8b0:4864:20::c44]:32953)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jah2B-0006OE-9q
 for qemu-devel@nongnu.org; Mon, 18 May 2020 10:46:27 -0400
Received: by mail-oo1-xc44.google.com with SMTP id q6so2087565oot.0
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 07:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Yg5Gk3dDviSnJiLkiL3wJMyhIIyqlq1pt8iO8sb2z3M=;
 b=MavUC32TMJnMXk96KOjxjiFjv9y3DmwRH+8meCFVBlaBfNk/uJn9MMIupggQdUYp/w
 XkyKi4uvlEl6MSzo74ab1mT3A4ogxIosyVyI9AW6SvzdyEtSQoeWMNKsSGnACIwLhzoF
 dWqe86VCKujMrP6so7p6MstMsI1p8e+YicjYqJOGLOcbzmk/bNKIHWJHDwr9pyQRk/fW
 Oamr9u3T5f4FrFzofWqLuVEPqRV7GTJ0BrkgNoMLK5yJ83pHacIthmMpD3ws1eiycO04
 bhI51K7Pgloi1dp18aFintEcGUveQYWaSZzbzK50aZJszWdPubuJe/cYpt4xnk0GOho6
 NGsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Yg5Gk3dDviSnJiLkiL3wJMyhIIyqlq1pt8iO8sb2z3M=;
 b=q6OfDqelPbDw4cwhPJGhWM6d21Qez4WEF3b6IIIulj5Wo+C1zNbyD7QlXq+B+P3cMt
 7BpMZYHyj3PppU4rVRSv9fTfOs3FhsIOeHOUqJu7yCba5UOQZ8uri0uwf4GRQsiA3P9q
 jg6kua+pWaje9/Ue2IHNzXNyjhEVs4DphmVgC7/YPSB19nNoPn7HEVgTYhhWJ82n8Hcb
 u9KQlkpkTpWH//7zu0y0az4NPa5y4HNXY1RdBpvhMEMkBEKChsRqw/CYEmIwKdaM/NUZ
 KK2KHGAYXDrHouAAnemshl0IIX5F05YPh0m16pX/iu0IHMlidLVC0rRAceqUiWJqQPvz
 juWA==
X-Gm-Message-State: AOAM530U0Iry5p+a5ABzPmvEF1vHkRc7HQfa0wLsxV7qlIbnwBwIQCPc
 h0qBOMAjxGVzDAiHC+g9NKMO+C9hnliSckNbKEFn0g==
X-Google-Smtp-Source: ABdhPJzSJUIDY0tuP5fZZX7BjSgprqLVb98gvRNXDQLbiwMH/OXQQO3SZOergSTsIhVECQ8sDRzp7bz04mP5nv3N6oM=
X-Received: by 2002:a4a:3556:: with SMTP id w22mr13049640oog.20.1589813186025; 
 Mon, 18 May 2020 07:46:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200312194219.24406-1-richard.henderson@linaro.org>
In-Reply-To: <20200312194219.24406-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 18 May 2020 15:46:14 +0100
Message-ID: <CAFEAcA-3YYciv1VZZdeYZOZYAgaRrTvPj6kHUbBv06-0otoGdw@mail.gmail.com>
Subject: Re: [PATCH v6 00/42] target/arm: Implement ARMv8.5-MemTag, system mode
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c44;
 envelope-from=peter.maydell@linaro.org; helo=mail-oo1-xc44.google.com
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
Cc: qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 12 Mar 2020 at 19:42, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> I've done quite a lot of reorg since v5, so much so that I've dropped
> most of the review tags that had been given.
>
> There are a couple of major improvements to note:
>
> * The effective ATA bit is in hflags, noting whether access to the
>   allocation tags is enabled by the OS.  This is moderately expensive
>   to compute, so it's better to hold on to that.  This allows trivial
>   inlining of some of the operations.
>
> * Updates for SVE, and thus
>
> Based-on: <20200311064420.30606-1-richard.henderson@linaro.org>
> ("target/arm: sve load/store improvements")

For clarity, given this is now 2 months old I'm just going to drop
it from my to-review queue on the assumption that you'll do a
rebase-and-resend at some point now the prereq patchset is in master.

thanks
-- PMM

