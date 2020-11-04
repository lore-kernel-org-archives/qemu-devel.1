Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A007C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 11:44:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 942252071A
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 11:44:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rbR6lfRJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 942252071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaHDi-0007d9-K2
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 06:44:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56458)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shorne@gmail.com>) id 1kaHD0-0007E3-JL
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 06:44:10 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:33743)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shorne@gmail.com>) id 1kaHCy-0003in-Iq
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 06:44:10 -0500
Received: by mail-pl1-x641.google.com with SMTP id b19so10186709pld.0
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2020 03:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=dHhzC2eXhzyb/CNEe4KcsADwe2ATb5qQMGgvN5K8Bu8=;
 b=rbR6lfRJKgns311uZ2ZYJD3dOExSznLExopzHFjoGfxuJkWiYJu2+XisxXP1iFPOdF
 Lgrn31odQSSQN8e+uxXKuJiIqNLkT3Pk717flQ8c+BJlrkObC2EtvIfE8wR9vtx2m6Cp
 X7mi+vmdCqmnV4uCiZMEWiTah+gQpBRYMTfamuYa+5FVwSlVxZj/sMKQ++hD/bOL428h
 VU0azytKqShUKUua7mTn/2f6X7BMA5rxFBeC0bpdXZuAx72knJkiE5hcm2igRMHsTAsy
 h03kVTAI83nGBApfYPnVn6B1a6QcJ/inVUzIDA7MxlR99AUia0VpLDij6rmf+wtVv8Hp
 9W0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=dHhzC2eXhzyb/CNEe4KcsADwe2ATb5qQMGgvN5K8Bu8=;
 b=QSSpGG/9rVr3/z7qBe6vefXHucfP8IrhPI4NU8HNEcn8PUJaflOYvCpuepyMxDvCrh
 UNzfNBl4NY27xz3r94AW/FiW8xMuOJh3vOkWMDxfjIGIL2r6AGw+HWEJDDC0oCgmeV4r
 lhZmV3YAZwP+jNZ2tJCmBsGGvNJ2XaZiDrHfyAEDApC5Uj8K0Tb44Siv5Znjxwe2UhBI
 GvMANAuQEWKGvChMidscVCSyRuQ7bL6xXCL5FGwubsgF8HDENtrC3BjTDeUsyDGNjc+G
 rgETI3LhO92vDWxH0iaMNMYr7eHnPIlZjiR9jujfXkpFluI5XStQnDQleHQgU9fTDSEv
 wkQQ==
X-Gm-Message-State: AOAM532o8wpwY0/GD4rkQzqcOV0Ij7NPAVDgqkOPjWpd6Bm0c3RNjeWY
 61gxzApZ1AFCl7sSen9xudI=
X-Google-Smtp-Source: ABdhPJwFosHMvlRgS88mOk24e5fu8fOFMOJ1cC2rbJtLGH6wMOW+HRyk8f6GxR9eBMZZsEtIW3oJhw==
X-Received: by 2002:a17:902:7c02:b029:d4:bf4e:4fc6 with SMTP id
 x2-20020a1709027c02b02900d4bf4e4fc6mr28399318pll.75.1604490247090; 
 Wed, 04 Nov 2020 03:44:07 -0800 (PST)
Received: from localhost (g133.220-213-56.ppp.wakwak.ne.jp. [220.213.56.133])
 by smtp.gmail.com with ESMTPSA id
 gc17sm2021034pjb.47.2020.11.04.03.44.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2020 03:44:06 -0800 (PST)
Date: Wed, 4 Nov 2020 20:44:03 +0900
From: Stafford Horne <shorne@gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] target/openrisc: Remove dead code attempting to check
 "is timer disabled"
Message-ID: <20201104114403.GC3294551@lianli.shorne-pla.net>
References: <20201103114654.18540-1-peter.maydell@linaro.org>
 <20201104071033.GB3294551@lianli.shorne-pla.net>
 <CAFEAcA8mE=iDxyyBHAH2T1fMFK47eo1pkowJLGjBWQO7U5RRRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA8mE=iDxyyBHAH2T1fMFK47eo1pkowJLGjBWQO7U5RRRQ@mail.gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=shorne@gmail.com; helo=mail-pl1-x641.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Wed, Nov 04, 2020 at 10:37:17AM +0000, Peter Maydell wrote:
> On Wed, 4 Nov 2020 at 07:10, Stafford Horne <shorne@gmail.com> wrote:
> >
> > On Tue, Nov 03, 2020 at 11:46:54AM +0000, Peter Maydell wrote:
> > > In the mtspr helper we attempt to check for "is the timer disabled"
> > > with "if (env->ttmr & TIMER_NONE)".  This is wrong because TIMER_NONE
> > > is zero and the condition is always false (Coverity complains about
> > > the dead code.)
> > >
> > > The correct check would be to test whether the TTMR_M field in the
> > > register is equal to TIMER_NONE instead.  However, the
> > > cpu_openrisc_timer_update() function checks whether the timer is
> > > enabled (it looks at cpu->env.is_counting, which is set to 0 via
> > > cpu_openrisc_count_stop() when the TTMR_M field is set to
> > > TIMER_NONE), so there's no need to check for "timer disabled" in the
> > > target/openrisc code.  Instead, simply remove the dead code.
> >
> > Thanks for the patch!
> >
> > I think the check is needed, but it's coded wrong.  The ttmr bits 31,30
> > are the timer mode.  If they are equal to zero (TIMER_NONE) then it means
> > the timer is disabled and we can skip the timer update.
> 
> My analysis is in the commit message -- the timer_update() function
> will just happily do nothing if the timer is disabled. It seemed
> cleaner to me to let the timer function just do the right thing
> rather than having both layers of the code try to figure out if
> there's no action to take.

If that's the case, then definitely remove it.  Sorry, I was just going off the
patch and didn't look into the code.

> > The code should be something like ((env->ttmr >> 30) == TIMER_NONE). But I
> > haven't tested it.
> 
> TIMER_NONE and the other TIMER_* fields are defined as (n << 30),
> and the mask TTMR_M is (3 << 30), so "(env->ttmr & TTMR_M) == TIMER_NONE"
> would be the condition to check if we wanted to do it here. (That
> matches how the code earlier in the function does it.)

Yeah, that is want I would want to do.  As I couldn't remember if there was a
mask variable available I just came up with the shift alternative.  Sorry, I was
in a bit of a hurry.

As for the patch.

Acked-by: Stafford Horne <shorne@gmail.com>

