Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F06EAC54E8D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 13:56:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9347206CC
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 13:56:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mpfdlUal"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9347206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYVOz-0002lk-U5
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 09:56:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51508)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jYVOI-000229-E6
 for qemu-devel@nongnu.org; Tue, 12 May 2020 09:56:14 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:43525)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jYVOH-0006By-MY
 for qemu-devel@nongnu.org; Tue, 12 May 2020 09:56:14 -0400
Received: by mail-ot1-x341.google.com with SMTP id a68so2030894otb.10
 for <qemu-devel@nongnu.org>; Tue, 12 May 2020 06:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=RfalNbvMq8wOSnIr4yvFrtBszh8MUQgiZbNl4UOHkts=;
 b=mpfdlUaljVfsxm35WjdDLEtlK+uUpczztxj59dwepgVTJZOfKA0cM0gYSlZZg9bK3L
 YKv1VzOi17E8yRGAQ2ir+FVIDWsQPx8QByZVBVEfQQ9EbcaHk8SBN/d7fanLaUvwasGB
 wW5xQb/eP9Hr+FY+g3gWquUc0wo9NeL1DEn1OVg7UEykKsnKwgHyon+qULTeIOr/oqoJ
 zqrAhpwUU/Z/GrwT2iXsfeGiuR3dg+myv3JzIzR9KVdZJc+jZcVqm8D9qtlvC0j7Sn04
 3mDOHzLDS0Yjr6BiQVoG7cAf4GUeJuTGImfEZ6EZdW+6AN/LHdrE5pcXT6Wyxrdq+jYt
 CnLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=RfalNbvMq8wOSnIr4yvFrtBszh8MUQgiZbNl4UOHkts=;
 b=FKMHBOSt3s3uxUyKZASKZnnHy9SVUPcrx5rWU6GMw92e0qfWkFvyac6ZiDdci2T7QT
 uvdThqU3zSMWNEDsJaISW3ho5dfDb7Xool7AqqOjTRFMgqWCtGO9fUpIX8EpHDTWpPvE
 hxiMUx/q97uB9dNkLTnYHaTjL1Jhu5Fo4uwgQWFXHpJoZtETpcpDMFdhqG1ao1Uh8kjY
 rr75GhFTbsbVI4h4GRmri6aZnwAwc0z1b58XG37D05snv89TmBmBk/vpc3l/mfj3zx5m
 C/6PgkxVzws4j1vtUmXBwYljjsm5StYcrW+NCHPdOJNBuVsB8bHueaJoj7L8aHmf49Ft
 Axvw==
X-Gm-Message-State: AGi0PuaFWai+aCvi7PaJN1/xjKxkKTXCdbZ/dUvzBTA+sxjojmGXgOMA
 ubvGCebJApj3FJaZuCqrz4KLvYu2bIPg9FMAh0p4qg==
X-Google-Smtp-Source: APiQypI/kF/yds36gp9ZcU00LKibJWat0FIL+rx/2MgockR3jkDdXvOkHhJ2Q8h+FNzqGaxhmveH83g9DRz5Fu5bQ+w=
X-Received: by 2002:a05:6830:1e4e:: with SMTP id
 e14mr16526749otj.91.1589291772410; 
 Tue, 12 May 2020 06:56:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200508152200.6547-1-richard.henderson@linaro.org>
 <20200508152200.6547-6-richard.henderson@linaro.org>
In-Reply-To: <20200508152200.6547-6-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 12 May 2020 14:56:01 +0100
Message-ID: <CAFEAcA-3Hs9P-R8hQPDoh2z8=OMEgs=EaSpHCYBVH-1m1_jSLQ@mail.gmail.com>
Subject: Re: [PATCH v3 05/16] target/arm: Tidy handle_vec_simd_shri
To: Richard Henderson <richard.henderson@linaro.org>
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
> Now that we've converted all cases to gvec, there is quite a bit
> of dead code at the end of the function.  Remove it.
>
> Sink the call to gen_gvec_fn2i to the end, loading a function
> pointer within the switch statement.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/translate-a64.c | 56 ++++++++++----------------------------
>  1 file changed, 14 insertions(+), 42 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

