Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7267DC2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 10:38:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5BD42072C
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 10:38:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uM1ecasq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5BD42072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaGBn-0000K6-Jg
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 05:38:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43734)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kaGAZ-0008Ah-1X
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 05:37:35 -0500
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644]:37688)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kaGAX-0004A1-At
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 05:37:34 -0500
Received: by mail-ej1-x644.google.com with SMTP id gn41so11764488ejc.4
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2020 02:37:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=HY8LN1nFdn/W7/Buh8tGg1saXl3RnhE4y4gxmZS7Oks=;
 b=uM1ecasqYIirp0Vq3+Qi8C/Ailkx5eSgLmFDgY4RURHiPKWcDtPh1xY5hCng2IuR9q
 9SVx6I1TZ8nq8t1V2m64BBui5ExWHI1FwJ3+9As/SH6Fhs64GHDGfmAG8gp3q+Ju7F6O
 UtLa5H2JBCfsvP9df/BuMqbLc5+rm5zViEUkoC5I2GbOdrVdE4M0p5ZdBvCkSOxFsJ0I
 ic6VAUljj70qTChIplNDi4k0yBqG0q34X3wEPLzlfONgsV5gg7TeMHo18ahnqbuTyb5g
 5EYtmn4a5GCydzyv6Eaq66Y5siwSDtY7TMcVfPCrdKie0Gd69ob/cMMMf7D8dNbmGzsS
 c0wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=HY8LN1nFdn/W7/Buh8tGg1saXl3RnhE4y4gxmZS7Oks=;
 b=DYp8irT87Ae6BSiJSMxV0x5jTKfSXgfQ7uMlo27Ss3+VxeR0LTyqtFAR5cvIb1Yy5E
 6+locGi3k/OV14IvQw2uzFuGaphrMP2TXod68umrjnGwfdmZapBUA9F85Y0rlXNEwRSV
 9GktICJ+pvm8GV7apDZ8ZTXHuNk36qPCiddrnyxF150yjmmxxDqY0tnvZE3AEfI2M0we
 /iX7naARaALu/gq3xxSM1MYiQyCuBwcH3d2Yjw17AEW547C9QQWPgJVLXX1da+Yhps9K
 z0rUwFh3oShvmUSEu4H547UjsvKTYxRJ7wYOVIbRtBq6xyWi9p1KtCNObOLNKjngpxPS
 WVjg==
X-Gm-Message-State: AOAM530nvhe9H7hvvZwn8awkVZ9u7s9j16RpA/CXZovL1XdWMDuu/a2y
 BqsniTxMiiRcl+lEqGsFb7aovdWijw8j1wWnXVvE2Q==
X-Google-Smtp-Source: ABdhPJwnEsGq3E3evHE9RDHpC+to4mh83YNye+rh+AlnSD/ULh/AXUcXvI3Z5C+CSeNstNJ/JSAfOmyGqFrNyofYvmY=
X-Received: by 2002:a17:906:6896:: with SMTP id
 n22mr6197134ejr.56.1604486248411; 
 Wed, 04 Nov 2020 02:37:28 -0800 (PST)
MIME-Version: 1.0
References: <20201103114654.18540-1-peter.maydell@linaro.org>
 <20201104071033.GB3294551@lianli.shorne-pla.net>
In-Reply-To: <20201104071033.GB3294551@lianli.shorne-pla.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 4 Nov 2020 10:37:17 +0000
Message-ID: <CAFEAcA8mE=iDxyyBHAH2T1fMFK47eo1pkowJLGjBWQO7U5RRRQ@mail.gmail.com>
Subject: Re: [PATCH] target/openrisc: Remove dead code attempting to check "is
 timer disabled"
To: Stafford Horne <shorne@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::644;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x644.google.com
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

On Wed, 4 Nov 2020 at 07:10, Stafford Horne <shorne@gmail.com> wrote:
>
> On Tue, Nov 03, 2020 at 11:46:54AM +0000, Peter Maydell wrote:
> > In the mtspr helper we attempt to check for "is the timer disabled"
> > with "if (env->ttmr & TIMER_NONE)".  This is wrong because TIMER_NONE
> > is zero and the condition is always false (Coverity complains about
> > the dead code.)
> >
> > The correct check would be to test whether the TTMR_M field in the
> > register is equal to TIMER_NONE instead.  However, the
> > cpu_openrisc_timer_update() function checks whether the timer is
> > enabled (it looks at cpu->env.is_counting, which is set to 0 via
> > cpu_openrisc_count_stop() when the TTMR_M field is set to
> > TIMER_NONE), so there's no need to check for "timer disabled" in the
> > target/openrisc code.  Instead, simply remove the dead code.
>
> Thanks for the patch!
>
> I think the check is needed, but it's coded wrong.  The ttmr bits 31,30
> are the timer mode.  If they are equal to zero (TIMER_NONE) then it means
> the timer is disabled and we can skip the timer update.

My analysis is in the commit message -- the timer_update() function
will just happily do nothing if the timer is disabled. It seemed
cleaner to me to let the timer function just do the right thing
rather than having both layers of the code try to figure out if
there's no action to take.

> The code should be something like ((env->ttmr >> 30) == TIMER_NONE). But I
> haven't tested it.

TIMER_NONE and the other TIMER_* fields are defined as (n << 30),
and the mask TTMR_M is (3 << 30), so "(env->ttmr & TTMR_M) == TIMER_NONE"
would be the condition to check if we wanted to do it here. (That
matches how the code earlier in the function does it.)

thanks
-- PMM

