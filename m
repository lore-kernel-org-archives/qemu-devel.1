Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9184AC4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 10:04:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA3A720BED
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 10:04:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QwZml0G1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA3A720BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLkac-000515-KQ
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 06:04:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39164)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kLkZv-0004Z5-7m
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 06:03:47 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a]:41292)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kLkZt-0005av-AJ
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 06:03:46 -0400
Received: by mail-ed1-x52a.google.com with SMTP id ay8so1873212edb.8
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 03:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2TMHjr41SD0NcfeM9OC0TYistsECoemhBMuxxAkHhQI=;
 b=QwZml0G1dt4BDfnei3mMSMT+ImCd7BS+f75ZmZqAM87JHVWHU8gJfIl6vC4o/Ygdd5
 5ZqCGuJwawhWOnLAc7jAi3kdfAtRJB5mhHfMR8+w3dhIAl+KjmVdAucXP00KXZkRoU6Z
 8yx7tvImZPhiR1piWFYOriDfbPNz2sUXo7RoE5w9Zp4ybygD+7+IsJLI8kGyXWYM0Gu5
 ihzogfuahpJ3BlwFLKjoqD5Ylftv9kRZU4ZNuDMWEc31tNKkHLp4jqc0b8Fr3nklmc0S
 dj1C9XiEgGbsKHui+fVPfCQ1Zj/pyX56wK/j5aA7dSwDk2lJqsTaGMr+Ao997pvUZZgC
 lOZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2TMHjr41SD0NcfeM9OC0TYistsECoemhBMuxxAkHhQI=;
 b=XtIAOOg9O7P1v4dA645qFBiPT2KTQG4I9aIllhKfm1U0Y0A32T4C0/qiR4COKrczzf
 6K4e4Us0vIY6qHbCMEepwQjmoyiYxYvN8JogxmcC5Qt2xgK7rxywq3FWtRP7iDeR1I5d
 DjBp7+pQJLO7njw31lfVI2k/NurFYofhtl3/t4e2YMfDo6arlef9Cj+XEdhs0hRUb/0/
 OgQFa+9tjauzwiKiflIOIh+u19TQbibbRsD1tQGDDexAx77z5vaiDDNbhSQznWIxotD3
 9Vym0BgNW1Qs32L5tiphC54bzB4UtEH/iv1V3xtvkFmEt9Oue9OJR1V+5W3QG+VLVPwp
 zD1Q==
X-Gm-Message-State: AOAM533BXaiOkByLlstnK7erLiRmmzBf6bvxplPBEkzoAeck6oVNy62v
 6lXo0HP60k7DM8Gvo2tX5i2+I2/0UkeKgA+KpZgT+w==
X-Google-Smtp-Source: ABdhPJxjcC6HGqEfaAQRAFazr3f6/NB4Th7aK/8TjXBUwlN6F+mMUTpY4Ez45oOVy+K9Wiq97lHaU982RnbYs21SeJA=
X-Received: by 2002:a50:e68a:: with SMTP id z10mr454348edm.100.1601028223618; 
 Fri, 25 Sep 2020 03:03:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200922174741.475876-1-richard.henderson@linaro.org>
In-Reply-To: <20200922174741.475876-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 25 Sep 2020 11:03:32 +0100
Message-ID: <CAFEAcA9u_hj3uAn8qSYPovkH3vcwxxYxcm0cbqUJkDhpP=8VFw@mail.gmail.com>
Subject: Re: [PULL 00/11] capstone + disassembler patch queue
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
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

On Tue, 22 Sep 2020 at 18:47, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The following changes since commit 834b9273d5cdab68180dc8c84d641aaa4344b057:
>
>   Merge remote-tracking branch 'remotes/vivier2/tags/trivial-branch-for-5.2-pull-request' into staging (2020-09-22 15:42:23 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/rth7680/qemu.git tags/pull-cap-20200922
>
> for you to fetch changes up to fcfea6ced053045beb1dc8d22bdeaacc9c03d0b9:
>
>   disas/capstone: Add skipdata hook for s390x (2020-09-22 08:59:28 -0700)
>
> ----------------------------------------------------------------
> Update capstone submodule from v3.0.5 to v5 ("next").
> Convert submodule build to meson.
> Enable capstone disassembly for s390x.
> Code cleanups in disas.c

Fails to build:

Linux qemu01 4.15.0-72-generic s390x
From https://git-us.linaro.org/people/pmaydell/qemu-arm
   8c1c07929f..a53ea1e6f9  staging    -> pmaydell/staging
Fetching submodule capstone
From https://git.qemu.org/git/capstone
   fc236325..4457d451  master     -> origin/master
   02af5976..2f38802e  next       -> origin/next
   d57e7af3..7ca653c7  v4         -> origin/v4
 * [new tag]           4.0.2      -> 4.0.2
make: Entering directory '/home/ubuntu/qemu/build/all'
config-host.mak is out-of-date, running configure
make: *** No rule to make target 'capstone/all', needed by 'Makefile'.  Stop.
make: *** Waiting for unfinished jobs....
  GIT     ui/keycodemapdb tests/fp/berkeley-testfloat-3
tests/fp/berkeley-softfloat-3 meson dtc capstone slirp roms/SLOF
cross containers  no

NOTE: guest cross-compilers enabled: cc cc
make: Leaving directory '/home/ubuntu/qemu/build/all'

thanks
-- PMM

