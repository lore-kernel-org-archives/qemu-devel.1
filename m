Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE884C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 09:31:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CA852078D
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 09:31:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fedJMXmI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CA852078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiab7-0004eO-BA
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 05:31:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52942)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jiaZw-0003v3-H7
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 05:29:56 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:39579)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jiaZv-0001lG-Fz
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 05:29:55 -0400
Received: by mail-ot1-x342.google.com with SMTP id g5so16063158otg.6
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 02:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=7A6hLQ8ehlsRp66h0826blcyvtWm5zs5jiwoD4lK4ak=;
 b=fedJMXmICl7iIW0JqR8CEXeo8aOyCstj1OhecNXd+5uxiIoSGtjpAEfj5hKNirCtX4
 pQwCQF5S553EmSpI7c85QPB0gvtZxebnpGO3N/n7sxgjE8YbAgJzOyJlq0u+Lc79dcze
 ZWrPaRAg2obAh5YKOO/pIBWUDJ4fbTCPSxixGuLV8WRPCoGJiKJBchLCtsuq7OrYtSh8
 go4zUI7xpTP1KV8hLSAufEttoVhLxAIMmuxScnEVJJGFVH85ldRzY2cUv2Ccx3U9r1Te
 REs4gTwGOD2+HAZkPqFYO+ydtKK67rztJihEmcFjXFDxIUr1S6D46OBhwVjY3z05rTi1
 Ew/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7A6hLQ8ehlsRp66h0826blcyvtWm5zs5jiwoD4lK4ak=;
 b=DQWnJA3emqSw6gt/t4WVXyZOojI6TwJ9lEhqZJZ8mrNGUA/Medw7LE7dpUr2dot9lz
 ecgzfUtHlVsHBnQwF4Hs4WSvwmOKKnklhDedcT6wHBwFHOlCLK4mXlKByeeaCQZ2Cp0F
 Um2Y+dIb8hjEMdR7ADynXkh0KV5Srhq6FY5CanROTMGY4I26DhsChkdDNgGnxA3iExU7
 ePzIp7j4mrcfnFHs/m1gcoN/lo6K8AN4l0YXkoqz3hexbKcXnx/wQNUgHQi7Yst/xvzk
 N8u1/LiDNVTX5uDh/4IRn10pzXY05GJtNei759PkC51LANxXZ/4Kkps7QA43ZEl1x8Q0
 /vvA==
X-Gm-Message-State: AOAM5308q7WyZmzuk5UnSRateRvRV8uG26O5PCeRsttPJs/MJ/BLHt8G
 K2ZuDR2zf/0hH6iNEWT6ciHwSyE2TMnfOv3kgahOXg==
X-Google-Smtp-Source: ABdhPJwpgDycGffprIzu70SsKL9C2H2/b9xUmrdkm3eLrtAIgEGgAhVDEmqrNAnLkva5+0VkSl1JPpshlVHOL0Ulm8Y=
X-Received: by 2002:a05:6830:18da:: with SMTP id
 v26mr21436748ote.135.1591694994066; 
 Tue, 09 Jun 2020 02:29:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200608183652.661386-1-richard.henderson@linaro.org>
 <20200608183652.661386-9-richard.henderson@linaro.org>
In-Reply-To: <20200608183652.661386-9-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Jun 2020 10:29:43 +0100
Message-ID: <CAFEAcA8tSKkDQta8X3-cjCAg1eA6iTJy-xaxqOxybJQ0an-KOQ@mail.gmail.com>
Subject: Re: [PATCH v3 8/9] decodetree: Drop check for less than 2 patterns in
 a group
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

On Mon, 8 Jun 2020 at 19:37, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> While it makes little sense for the end product to have a group
> containing only a single pattern, avoiding this case within an
> incremental patch set is troublesome.
>
> Because this is expected to be a transient condition, do not
> bother "optimizing" this case, e.g. by folding away the group.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

That was a simpler fix than I was expecting :-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

