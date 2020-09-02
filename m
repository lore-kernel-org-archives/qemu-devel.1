Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2DA8C433E7
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 20:20:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4FF320678
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 20:20:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eTIJc5Wa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4FF320678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDZFF-0000kD-Qd
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 16:20:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34194)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kDZEf-0000I4-4h
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 16:20:01 -0400
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641]:36462)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kDZEd-0008G5-8n
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 16:20:00 -0400
Received: by mail-ej1-x641.google.com with SMTP id e23so535922eja.3
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2020 13:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=G+aHCkuNg6HbUIh5qUYqC0kVlMO55qfhIGHJ7WitACA=;
 b=eTIJc5WaTTfjgduhWJqAcjEYTmz4CHTXc1DWZ3HGPMd5pRsduMcLlocm9SvSn+rbbW
 09WsajbZ3rniomNJSwwiDPJ+euHVx9HB5Du1PHxiqVY/8oYIpHdLjV8+9I+bSePaS4GU
 6B4YZtGClv4+mu8YDZW9+dR7w8aWKKpDHfcvXlNIUVrhCZP05mfhFvaPeN1zjR533fkP
 XF2vredlGmIZJiK3OsKnz4xKLxX4/uGmKfPbO3di3ogg7RXqn2WoVgDzdMZwitDyi99a
 LbuHqfpJOalEn6PSYbUhpz9WJd4H6+WQHwVucCvUnSpVlS6B3m4YO4c7hjeUJ6MbwPKi
 6JSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=G+aHCkuNg6HbUIh5qUYqC0kVlMO55qfhIGHJ7WitACA=;
 b=hB0neICR2fYuh++1OgZ/BHgDFaGgGwN7iUxUoXlFmkBbiaFHSVlY6BlU3JP7Sp8/uw
 xQXRHQ7fUaDiL2aPOk1Xx3upsIfBjOZWMzXQ8Du8qMV8nx37pImaQe6180972XYI4ITG
 /WY2Lu4AktcFanHPKFEl+MNWVXAgi+BLirY4TtiwaYxNOBEJGRgA5dggPBXQ3cJAV3zN
 ahfk575cOMmf2esD9/26Nqe8j+G4/kfqmkyqjT8iO3jKFXiPFnoFRR6dqq1icEE1RMVw
 dU3NL9a1lZoUOwErJ+6MNO4gd0Cmv1E8zGhHMbF4O+RZkmC2+mBob1y27vS3hJfiQTD8
 uuiw==
X-Gm-Message-State: AOAM5320k/MHEGocIrMuxavOtUfNwNtJ7tCYtz31T7ucYacienAV/jR8
 3QLJJcCPZsOq+9nPIjBo87mLAYCeFKKRT+PHOLBKYw==
X-Google-Smtp-Source: ABdhPJyvbbHIW0FpdudSBW1la9nhkPPl9NKkIbhJNQhyFpbm8ypaWV32SK/KmaHmCNHbQRA8vV6jWeYIzJRyhSmeQAQ=
X-Received: by 2002:a17:906:24d6:: with SMTP id
 f22mr1733081ejb.85.1599077997348; 
 Wed, 02 Sep 2020 13:19:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200902154932.390595-1-thuth@redhat.com>
In-Reply-To: <20200902154932.390595-1-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 2 Sep 2020 21:19:46 +0100
Message-ID: <CAFEAcA89Pjp_k5pJh26juFDO1a3M8H_s0+5cGBoZq5v7=ZYing@mail.gmail.com>
Subject: Re: [PULL v2 00/15] Cirrus-CI improvements, and other CI-related
 fixes, m68k
To: Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::641;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x641.google.com
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

On Wed, 2 Sep 2020 at 16:49, Thomas Huth <thuth@redhat.com> wrote:
>
>  Hi Peter,
>
> the following changes since commit 887adde81d1f1f3897f1688d37ec6851b4fdad86:
>
>   Merge remote-tracking branch 'remotes/bonzini-gitlab/tags/for-upstream' into staging (2020-09-01 22:50:23 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/huth/qemu.git tags/pull-request-2020-09-02
>
> for you to fetch changes up to 5e560e07ca396e16150740ae3c46b35a85f59ba7:
>
>   gitlab-ci.yml: Set artifacts expiration time (2020-09-02 16:23:55 +0200)
>
> ----------------------------------------------------------------
> * Cirrus-CI improvements and fixes (compile with -Werror & fix for 1h problem)
> * Two build system fixes to fix some failures the CI
> * One m68k QOMification patch
> * Some trivial qtest patches
> * Some small improvements for the Gitlab CI
> ----------------------------------------------------------------

Failures on windows crossbuild and OSX:

Generating qemu-version.h with a meson_exe.py custom command
Generating ar with a custom command
cp: '../../pc-bios/keymaps/ar' and 'pc-bios/keymaps/ar' are the same file
Generating bepo with a custom command
cp: '../../pc-bios/keymaps/bepo' and 'pc-bios/keymaps/bepo' are the same file
Makefile.ninja:5177: recipe for target 'pc-bios/keymaps/ar.stamp' failed
make: *** [pc-bios/keymaps/ar.stamp] Error 1
make: *** Waiting for unfinished jobs....
Makefile.ninja:5179: recipe for target 'pc-bios/keymaps/bepo.stamp' failed
make: *** [pc-bios/keymaps/bepo.stamp] Error 1
Generating cz with a custom command
cp: '../../pc-bios/keymaps/cz' and 'pc-bios/keymaps/cz' are the same file
Makefile.ninja:5181: recipe for target 'pc-bios/keymaps/cz.stamp' failed
make: *** [pc-bios/keymaps/cz.stamp] Error 1
make: Leaving directory '/home/petmay01/qemu-for-merges/build/w64'

On x86 linux a lot of this kind of warning from meson:

../../pc-bios/keymaps/meson.build:58: WARNING: Custom target input
'ar' can't be converted to File object(s).
This will become a hard error in the future.
../../pc-bios/keymaps/meson.build:58: WARNING: Custom target input
'bepo' can't be converted to File object(s).
This will become a hard error in the future.
../../pc-bios/keymaps/meson.build:58: WARNING: Custom target input
'cz' can't be converted to File object(s).
This will become a hard error in the future.

and then a failure later on:

make[1]: Nothing to be done for 'all'.
make: *** No rule to make target '../../pc-bios/keymaps/ar', needed by
'pc-bios/keymaps/ar.stamp'. Stop.
make: *** Waiting for unfinished jobs....

This is the same set of errors I got from when Gerd put
the "meson: fix keymaps witout qemu-keymap" patch in his UI pullreq:
  https://lists.gnu.org/archive/html/qemu-devel/2020-09/msg00149.html
so that seems like the problem.

thanks
-- PMM

