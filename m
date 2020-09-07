Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91574C433E2
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 20:51:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 011C721897
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 20:51:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pe5yQIbj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 011C721897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFO6T-000160-4b
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 16:51:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43212)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kFO5U-0000L0-9k
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 16:50:04 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636]:39801)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kFO5S-0005ZI-Cs
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 16:50:03 -0400
Received: by mail-ej1-x636.google.com with SMTP id p9so19638162ejf.6
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2020 13:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=laHmblQDtLdloVu+38KrwW0ouMMM2e3QpnZqisrHyAE=;
 b=Pe5yQIbjQTWCeGAQP78DC4wZjwnVSKiLw/uM85bHA5ptQptS4WK7wbRyfSmBnkggi8
 MiVCksvxYYYgfWMQK5e6FNEtavuuOPD32cpO4VD5zKPWQAB1Su2ijRGtTHcVZbTptyAP
 R5IlhctHFB+wjkLEYI6oZKxW5orHihCB8N2M9KsKmhMkNvAKNLdiTgE2hfMkQqMstxjM
 y5ttAZtoVGli7NQ0VwzG2Ta7P1YD0fyPHbiNLKfgX4iCY7EOwtTvv2qoFf+YVF+v3jDC
 IIcun/WCJ/JpYXU59Vnc0jIjTYb+2AyG8vW8MZbSMiGTt5WMfrW3v7SWy03AnrBIKhyA
 X8rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=laHmblQDtLdloVu+38KrwW0ouMMM2e3QpnZqisrHyAE=;
 b=UqSli+tIP60sy2QImRQX4YtyaifvaWcwR3R0W1pywH4v/bPwgnYDot8kYgCQUI/4Ke
 kH6cyFOWSU6b8L9SRwY4WKvrpt6quo0qFRt7YDId8K3e58Q0pnaFbiH9xX3oErxTvB3s
 96Khc0SrS1TbBg7xiMfczEb95ClljNu9MS2DmFTW3qM1OiS980jSbkBLDlfbEWVlStpt
 5XciQ/sFuPi4/ZbVLKyUlstm9rfKwjYmVw1bKKS5pWjS9u9GWQG6wVfCWmdyXn/eF7te
 poEN2hVNvaKxnH7XVhQwq9OwMpGR4aWe1NLSJC8exjTShZ+CtBGRM8e0f8I3VQkLq7ja
 mxaQ==
X-Gm-Message-State: AOAM533WGD37G9XJ02OV4MDTMQrmQ6yayUqo0ibmqLi5Bjf+QIgC8q1T
 QgtQY01XhSB4GKLWYm2wztvhoctoeVJffvh+t5n2iA==
X-Google-Smtp-Source: ABdhPJysCZfjtx8JyyDK9fjt7aVoZWbNyF+8R7LFxl5ALS3r/rZB/XxyEAXQpKlImQ2bLPWGxDL/tO9bT7TG+o3XoaY=
X-Received: by 2002:a17:907:20d9:: with SMTP id
 qq25mr18081389ejb.382.1599511800724; 
 Mon, 07 Sep 2020 13:50:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200907164421.19886-1-pbonzini@redhat.com>
In-Reply-To: <20200907164421.19886-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 7 Sep 2020 21:49:49 +0100
Message-ID: <CAFEAcA9nqA=AdkbGR3eiEC+C9SBVcvNv0mVv7OSizLTGhpHOJw@mail.gmail.com>
Subject: Re: [PULL v2 00/46] Next round of Meson bugfixes and cleanups
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x636.google.com
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

On Mon, 7 Sep 2020 at 17:45, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The following changes since commit 62f9256052df85194faa33137bbe0afb1c95b6e6:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/vga-20200904-pull-request' into staging (2020-09-07 13:27:20 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to cfdedc114244adf488242f547af899bc2fe9f3c0:
>
>   meson: remove linkage of sdl to baum (2020-09-07 18:43:20 +0200)
>
> ----------------------------------------------------------------
> meson related:
> * convert unit tests
> * bugfixes for mtest2make
> * miscellaneous bugfixes
> * dead code removal and configure cleanups
> * oss-fuzz fixes
> * msys fixes

Conflict in tests/Makefile.include, resolution not immediately
obvious -- could you rebase and resend, please?

thanks
-- PMM

