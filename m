Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24A09C4CECF
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 18:48:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E536220820
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 18:48:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n0Nyo+WZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E536220820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCTO5-0000zX-Or
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 14:48:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53218)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iCTLf-0007yi-0e
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 14:46:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iCTLd-000782-LY
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 14:46:10 -0400
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334]:33195)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iCTLd-00077i-DW
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 14:46:09 -0400
Received: by mail-ot1-x334.google.com with SMTP id g25so13112319otl.0
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2019 11:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=KMDbN0XbMZ7rBzqGtCLrNofny0/zzxmpSX7mG9zel2s=;
 b=n0Nyo+WZNw/mDwitZSaK52HIQin/uriYLSURUSM1D+n1wEAy2xWLkjembti1ZGPtD2
 /GCtzsNFv4ZF2Yz8/XOxeUJ/eROmeLY00rwYCf7d7Bw06od+MHUbevwBfAGJkU8YvwBh
 SrjJBuaS8/khFc0T5h1Oj2yfqdh1ZRneXY1arTQACqmr0HKTDXjA18UOoK29lV247389
 cqj0iIbw1uaHZFH9HRTYijKcYn6VEZgA7SCIq4/y6MxC1m1SYxV21+M9ngy9v9v2ntvf
 97ITlESQW6xcXUls0HKXgZLZ26ApS60aD6N9XfHxzaVHJzb9rdQrKm2EE/pEZSqzxsmt
 +DQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=KMDbN0XbMZ7rBzqGtCLrNofny0/zzxmpSX7mG9zel2s=;
 b=aMqM35SIY715SIxeDanYRdEV8dCUqxaEiaNIuJ6omsECXZgzytWgjNTRJBImCI+dPy
 4sdutHXBzm8DuusDLwnPpGCnyZDW5K+xgTjzHlc3dDivbvayG/cVheRHOgmBhOc6aakR
 Ue7xg+TOnENa/lcOa+9urC4CWrtfz57hjP5m49v//7xzHYc+rBjl/grV7uiXbYx9xGLI
 hBXzwRHi0jYuSU+wxXOZtt9xCW93wzL2/ZHmEKXf+Rh1gDRtg9i2KsmBToSJDi1LY6UG
 HdYTeT6KQYY3G+4H0en5Ml/YCAZaQNOlYTwJYWqsjmsqEZNDaki6JBTEP21dMzZA4E3+
 spyQ==
X-Gm-Message-State: APjAAAU09wHt+lqu0qO+pRyjqj8v7WrU+EadBtwMfGV1zcQf2qxDjGB8
 KP+yZgPYQV5QMLNAawXTlvP78H1XxAsgF2TwrdEDPg==
X-Google-Smtp-Source: APXvYqyErsDcJeigQN1ipLpkCtJOicIb01dvc/BXC8I3y8hc1RtVU4HxH4ViH2Sl920eZ2YK62faInd/4dfoH0/TG+g=
X-Received: by 2002:a9d:562:: with SMTP id 89mr1156080otw.232.1569264368542;
 Mon, 23 Sep 2019 11:46:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190921150420.30743-1-thuth@redhat.com>
 <20190921150420.30743-3-thuth@redhat.com>
 <bd6efd14-9200-98e2-4f76-dda101f85274@redhat.com>
 <8585b93b-e239-829b-d634-b89941f27aed@redhat.com>
In-Reply-To: <8585b93b-e239-829b-d634-b89941f27aed@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Sep 2019 19:45:57 +0100
Message-ID: <CAFEAcA9k59CRG23qP-o5PF0mdXvXpszhuxx+GpbpWO+hFdHOOA@mail.gmail.com>
Subject: Re: [PATCH 2/4] target/arm: Move cortex-m related functions to new
 file v7m.c
To: Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::334
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
Cc: Auger Eric <eric.auger@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 23 Sep 2019 at 19:09, Thomas Huth <thuth@redhat.com> wrote:
> However, there's one thing I currently don't quite understand in this
> code (since I'm not an ARM guy, sorry) : There are references to "v8" in
> m_helper.c, too. Is that related to a separate CPU type, ie. should the
> v8 code also be available when CONFIG_ARM_V7M is disabled? Or can the
> code in m_helper.c be disabled completely if CONFIG_ARM_V7M is not set?

QEMU's naming conventions here is a bit confusing, for
historical reasons.

Architecturally what we have is:
 * "M-profile" -- this is the flavour of Arm architecture for
microcontrollers; it has some big differences from A and R
profile (eg the exception mechanism is different and it has
a built-in NVIC interrupt controller). All the Cortex-M<anything>
CPUs are M-profile
 * "Arm-v7M" -- this is the v7 flavour of the M-profile
architecture, eg Cortex-M3.
 * "Arm-v6M" -- this looks like it ought to mean "v6 flavour
of M-profile", but if you look at what features it has it's
more like "cut down version of v7M" (fewer instructions, cut
down exception model, etc, but some things which on A-profile
don't appear until v7A are present in v6M). Cortex-M0 and -M1.
 * "Arm-v8M" -- v8 flavour of M-profile. The big change here
is support for TrustZone. Cortex-M33. v8M comes in two
sub-profiles: "mainline", which has all the features like v7M,
and "baseline", which is cut-down in the same way v6M is a
cut-down v7M.

In QEMU, we implemented Cortex-M3 first, and then added -M0 and
-M33 later. So mostly our function naming convention uses
"v7m" when it means "any M-profile"; a few v8M-specific
functions use a "v8m" prefix. Everything in m_helper.c is
M-profile specific; most of it is used by all M-profile cores,
and a few bits are v8M-only or v7M-and-v8M-mainline only.

From a CONFIG switch point of view I don't think it's
worth being able to #ifdef out the various flavours of
M-profile individually.

thanks
-- PMM

