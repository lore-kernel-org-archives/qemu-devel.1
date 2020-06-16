Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D7D6C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 14:01:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F2D720739
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 14:01:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Keay6XJP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F2D720739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlC9M-0000Bh-9W
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 10:01:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53498)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jlC7E-0005cy-8j
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 09:59:04 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:50836)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jlC7C-0003RF-8R
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 09:59:03 -0400
Received: by mail-wm1-x342.google.com with SMTP id l17so3003032wmj.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 06:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=+m1JWSZTqc0nmt1kPMXRJ5akaF/ZeDlKZpTwUu6GkfY=;
 b=Keay6XJP/chiscKztc53kgtzXBDpKCJFaJiRHet2aPwvnZZkoRkHuNwNz7g1yglUIA
 L/TCaJBJ6LGJfGYa1MnGaZid50w9tr1qOYNECydBEture+REjEc+37O8xOv6HCZukFq6
 YoE4UypP7B+cIrQiGuPj8n4KJHqTieybSRO68icK7L1Li//9770mIg3dH8QpU7UQpMIy
 YUY2ey8t7GvZfaeVnl1GUT145/hmVK+tvXv1RnaPurOUovvdO622SN+axXxgghgeU4+n
 an9XzWjyEKEGvp1TIh0AjBG27CbsHNa94WcZZUdET/JBz9DxnAkE400lXTjW1Aq1NVM+
 YO/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=+m1JWSZTqc0nmt1kPMXRJ5akaF/ZeDlKZpTwUu6GkfY=;
 b=iX6rYLfnKuGvpY+ityQla4SIfliY3mSKXv+E5qyjLMo52Xaa59aygu8C25U33+/jwk
 jj7RIMmoTn1yd/l7bmh+ZBG7dGwMYbnQHOHs756Wd78HdIJvTZdZh/kwHe2RgEZFkXfa
 54liEJZOqo4g882CMRn4cCb/xt03spaw2RPQY+5HxrEgEeIiA25dprZU6msBjhOuuSVi
 1xz5p4/XkCYxGr7OCQrfAxAQdIU/xmq4bKfRfhty83PVXiu19eCzRI/eSP5dbaxby0SE
 5Grs3HLO77uhJswT/IxPUMpu+uxd48jmaVRqL9DJy1YL5FZBBe8oXy+5cKDfetx9yS9t
 bnyA==
X-Gm-Message-State: AOAM531m8rX9GePY7qjL4WZcSvdGiO92wmbHKd4phJqTFO7I06LMyH49
 ZjV9w1Kf3E6xRNOysfpR7zCvzA==
X-Google-Smtp-Source: ABdhPJwFUwlsjgigv0+z75mWTnAtIaXDRd4dJvqHemud2LayWVU8oP8tO0kvB2r7uHriZC0V2bSaHQ==
X-Received: by 2002:a1c:2b86:: with SMTP id r128mr3575871wmr.13.1592315940548; 
 Tue, 16 Jun 2020 06:59:00 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id f185sm4259501wmf.43.2020.06.16.06.58.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2020 06:58:59 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 46D0D1FF7E;
 Tue, 16 Jun 2020 14:58:58 +0100 (BST)
References: <20200615180346.3992-1-cfontana@suse.de>
 <20200615180346.3992-4-cfontana@suse.de>
User-agent: mu4e 1.5.3; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Claudio Fontana <cfontana@suse.de>
Subject: Re: [RFC v5 3/4] cpu-timers, icount: new modules
In-reply-to: <20200615180346.3992-4-cfontana@suse.de>
Date: Tue, 16 Jun 2020 14:58:58 +0100
Message-ID: <871rmf1599.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x342.google.com
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, haxm-team@intel.com,
 Marcelo Tosatti <mtosatti@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, Roman Bolshakov <r.bolshakov@yadro.com>,
 Colin Xu <colin.xu@intel.com>, Wenchao Wang <wenchao.wang@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Sunil Muthuswamy <sunilmut@microsoft.com>,
 Philippe =?utf-8?Q?Mathieu-Daud?= =?utf-8?Q?=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Claudio Fontana <cfontana@suse.de> writes:

> refactoring of cpus.c continues with cpu timer state extraction.
>
> cpu-timers: responsible for the cpu timers state, and for access to
> cpu clocks and ticks.
>
> icount: counts the TCG instructions executed. As such it is specific to
> the TCG accelerator. Therefore, it is built only under CONFIG_TCG.
>
> One complication is due to qtest, which misuses icount to warp time
> (qtest_clock_warp). In order to solve this problem, detach instead qtest
> from icount, and use a trivial separate counter for it.
>
> This requires fixing assumptions scattered in the code that
> qtest_enabled() implies icount_enabled().
>
> No functionality change.
>
> Signed-off-by: Claudio Fontana <cfontana@suse.de>
> ---
>  MAINTAINERS                  |   2 +
>  accel/qtest.c                |   6 +-
>  accel/tcg/cpu-exec.c         |  43 ++-
>  accel/tcg/tcg-all.c          |   7 +-
>  accel/tcg/translate-all.c    |   3 +-
>  docs/replay.txt              |   6 +-
>  exec.c                       |   4 -
>  hw/core/ptimer.c             |   8 +-
>  hw/i386/x86.c                |   1 +
>  include/exec/cpu-all.h       |   4 +
>  include/exec/exec-all.h      |   4 +-
>  include/qemu/timer.h         |  22 +-
>  include/sysemu/cpu-timers.h  |  81 +++++
>  include/sysemu/cpus.h        |  12 +-
>  include/sysemu/qtest.h       |   2 +
>  include/sysemu/replay.h      |   4 +-
>  replay/replay.c              |   6 +-
>  softmmu/Makefile.objs        |   2 +
>  softmmu/cpu-timers.c         | 284 ++++++++++++++++
>  softmmu/cpus.c               | 750 +------------------------------------=
------
>  softmmu/icount.c             | 499 ++++++++++++++++++++++++++++
>  softmmu/qtest.c              |  34 +-
>  softmmu/timers-state.h       |  69 ++++
>  softmmu/vl.c                 |   8 +-
>  stubs/Makefile.objs          |   3 +-
>  stubs/clock-warp.c           |   4 +-
>  stubs/cpu-get-clock.c        |   3 +-
>  stubs/cpu-get-icount.c       |  21 --
>  stubs/icount.c               |  22 ++
>  stubs/qemu-timer-notify-cb.c |   8 +
>  stubs/qtest.c                |   5 +
>  target/alpha/translate.c     |   3 +-
>  target/arm/helper.c          |   7 +-
>  target/riscv/csr.c           |   8 +-
>  tests/ptimer-test-stubs.c    |   7 +-
>  tests/test-timed-average.c   |   2 +-
>  util/main-loop.c             |   4 +-
>  util/qemu-timer.c            |  12 +-
>  38 files changed, 1119 insertions(+), 851 deletions(-)

Ooof this seems a little big for comfort but maybe that can't be
avoided. Certainly doesn't seem to break anything:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e

