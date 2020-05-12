Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E0C8C54E4A
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 13:55:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7A78206F5
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 13:55:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M5HPlZBO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7A78206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55274 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYVNQ-0000UL-Io
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 09:55:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51274)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jYVMK-0007TM-3t
 for qemu-devel@nongnu.org; Tue, 12 May 2020 09:54:12 -0400
Received: from mail-oo1-xc43.google.com ([2607:f8b0:4864:20::c43]:40776)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jYVMJ-0005rM-BX
 for qemu-devel@nongnu.org; Tue, 12 May 2020 09:54:11 -0400
Received: by mail-oo1-xc43.google.com with SMTP id r1so2719165oog.7
 for <qemu-devel@nongnu.org>; Tue, 12 May 2020 06:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ui3PJ6FVNtODBG0tqhc0V/U8Dj5w00XU9KyvsbFnbP8=;
 b=M5HPlZBOLuU3TcaJrWw79tWmf9EroBzEdHPLPzSarBqLi9VQpirZdGFC71P/eP3oaW
 CNtwZ9e9VC3WpbhqWB43aNSbHn69LYu3VsyV3iPh377vh7Uc3m0hgF2CAnbYSEsK1rEg
 l5j4b/iLddVqFn2Yq/85enanmIQfk8Pc9gVQVYNKML9e41zllqC4jeItsKN1lCmxpMBd
 pNx0OG8yuS/GNZNaI/TMnNyb7k3Q1FJ0IpV/IiSxjD7VFi9fW4xgwBepsAv/VkpOXAQD
 ouIU1W2SvG/vIoN7inh/Zep6NXwDm/bwOJ12gjuTEieqDtX2IDxMIw4MzuUs+L43W16A
 v/Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ui3PJ6FVNtODBG0tqhc0V/U8Dj5w00XU9KyvsbFnbP8=;
 b=oCgZkQihjAANmzw9tpHF0sjb1XWuOMOa9bTscLWLW65biyWoWTmo9GFgack4VXhoRW
 nqqGiE6Q0PrbbbqYUZFdgkBlIonbWwBcbULIPAJwoK+FhRN+WsDvcN1htQn9DNJYyI5O
 Jw0A0cJLlaMkyWDmcPgcb3XAMskItr8a2Y9lKcwvRviOzViDczoAZslqV80PQ0w9/384
 oyLNa7RmVPJacJkUYXoeKV55YhczBISib95FvozSolXwos45ySVKRDZm1LqrZ63BBM6L
 G0GxA9FUmQuwpAG+D4tAMS3HamEDXhLQkbjEJAQzCzKB2qNxV/1mg7uHuyKe5oP7rcKV
 X52w==
X-Gm-Message-State: AGi0PuYkYSU6AWwKrCF8ff+D+zc5EgOwnwtgDmUCDIXhUcQcT7g3HiGL
 Z64vfA+V2XZQ/j2le3LkDGnOOjD5r4y2tcbfZSab4qrk+gQ=
X-Google-Smtp-Source: APiQypKfrtlI2MK9TDUCpQxj7id8/5GK3Gb2bz+dG9fy3tRUupGGQmZmsDT6DOqM9WwrrhFTHS9tRCAlhP5yRcrSivQ=
X-Received: by 2002:a4a:3556:: with SMTP id w22mr12230137oog.20.1589291650188; 
 Tue, 12 May 2020 06:54:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200508152200.6547-1-richard.henderson@linaro.org>
 <20200508152200.6547-5-richard.henderson@linaro.org>
In-Reply-To: <20200508152200.6547-5-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 12 May 2020 14:53:58 +0100
Message-ID: <CAFEAcA8C-mROvWCp6KwUGUPFz7pGkZX8Q3LFx7+ESxqterBe8g@mail.gmail.com>
Subject: Re: [PATCH v3 04/16] target/arm: Remove unnecessary range check for
 VSHL
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c43;
 envelope-from=peter.maydell@linaro.org; helo=mail-oo1-xc43.google.com
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 8 May 2020 at 16:22, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> In 1dc8425e551, while converting to gvec, I added an extra range check
> against the shift count.  This was unnecessary because the encoding of
> the shift count produces 0 to the element size - 1.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/translate.c | 12 ++----------
>  1 file changed, 2 insertions(+), 10 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

