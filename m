Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83899C433E2
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 16:07:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 439AE2074D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 16:07:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ugvtk8VA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 439AE2074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEEFk-0005Vm-Fj
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 12:07:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33340)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kEEDE-0000o2-HK
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 12:05:16 -0400
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642]:44136)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kEEDC-0002rs-DY
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 12:05:15 -0400
Received: by mail-ej1-x642.google.com with SMTP id a15so9275975ejf.11
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2020 09:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=1mTQlwQyUZEnRTvagM0K10/Nuvnv060MT/Lk904oGY8=;
 b=Ugvtk8VABWUW4eMfPcA1rf6/9wiFw6KbV7gkrPiFhEtvM2e1K+WOfCkHlue73v8+Ea
 m6R32Yc1XWBkrlKnAvgFiZVnrZW4Ttq+KGpbsZDTbRFSezNanFg5dAwh1NT9W6UQ6Smc
 YGSgnNPG3wD3iP/4/Y8kys2CaC/OZD2Vewi7XCQWsV7gcsFQ8g7zd80PRU2mg9hoFgfA
 hf6MQQ/+wQokVWV8x1z7TGAJP5W+Zd8A1kNkXOgR6s+0IkAH6hT1Neelg65XW5S3wbmq
 C9+8cwWINqaeOolBUmSz13HM6AgxtT1OKMfW3jemNuMfa3kzybjDwFWD5O/l1qXKadAh
 ic2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1mTQlwQyUZEnRTvagM0K10/Nuvnv060MT/Lk904oGY8=;
 b=cIu5xXR1CZ5ib5Wk5MwG27MuIiD7Rh+tKX1zh/rbJ1cSgUIEuP0j2HWl2t3TCPcWSn
 mE7mzytZk0kyZUqmDYj4hwvfQ9JyCpDNycXgVw/KbDBvUsAnuDyCpGJQWRdTjz6CQPUp
 mO0PHXJqF123xKMNiL31xHs58bPpq/t37Cq02bJxIQQ8h3YEV5TRs3EUL4uzVlT0Sscx
 +D/7qMvCN4S4mo2TD4OIkw0YuRelg6L+w7f2i4gD0BEm1BrN62OIjo1OnKoOLyR0jy+z
 plY7qD7rkTmkSrGW4Kf62uOYo6vnB9GhDaZruQbaykqObd536NAdOKHZaVP80kZY8cQi
 VCWA==
X-Gm-Message-State: AOAM533uwu1mDQ7kod0+3Oy+6bJtKqJqzCLW/wiX7hf12Fi8UR2AFYdz
 sL4XSrKB7K6srHXtp66wMnNsFDIIzBAkDAfKbkGKoA==
X-Google-Smtp-Source: ABdhPJz3OPvkvLdfscAUJcFk+jQNWlIFON8IPTUrVvGIfyAvLovYT6lCXGyWF7VQp89vnpJP0ul/0Pg7uP2Y/m7i18U=
X-Received: by 2002:a17:907:20d9:: with SMTP id
 qq25mr4065715ejb.382.1599235512635; 
 Fri, 04 Sep 2020 09:05:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200810195019.25427-1-peter.maydell@linaro.org>
 <CAFEAcA9cyKVwONYuzG3oPcQQ9sibpdtetCjcBe3133gd09Aa9w@mail.gmail.com>
 <87d0314nmp.fsf@dusky.pond.sub.org>
 <CAFEAcA9ABUwa_TnyczsO+TtSncX0hHwN7_zgyGGWP6nWtEkdDQ@mail.gmail.com>
 <87eenhzget.fsf@dusky.pond.sub.org>
In-Reply-To: <87eenhzget.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 Sep 2020 17:05:01 +0100
Message-ID: <CAFEAcA_zWkthoVGr+6NbjqsWvrinJ1R6gVaA2HAVauOy8ENGDA@mail.gmail.com>
Subject: Re: [PATCH v5 00/20] Convert QAPI doc comments to generate rST
 instead of texinfo
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::642;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x642.google.com
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 4 Sep 2020 at 16:54, Markus Armbruster <armbru@redhat.com> wrote:
> Initially, the include directive was just that: include another file's
> contents right here.
>
> Back in 2018, we switched from generating monolithic code to generating
> modular code.  What does that mean?
>
> Instead of generating the kitchen sink into a single qapi-types.c, we
> split out the stuff generated for each FOO.json included by
> qapi-schema.json into qapi-types-FOO.c.
>
> Same for qapi-types.h, but with #include stitching that mirrors the
> schema's include directives.  So, if FOO.json includes SUB.json, then
> qapi-types-FOO.h will include qapi-types-SUB.h.
>
> Same for qapi-{commands,events,visit}.{c,h}.
>
> The qapi-schema.json (rather: the file you pass to qapi-gen.py) is the
> main module.
>
> The .json it includes are the sub-modules.
>
> visit_module() lets you see the modules.
>
> visit_include() lets you see the includes.  The same module can be
> included multiple times.  Having to filter that out would be annoying.

I don't think you'd need to filter it out for this use case -- I
assume Sphinx would just ignore the unnecessary extra dependency
information. But if visit_module() does what we want and you
recommend it I'll look at that.

thanks
-- PMM

