Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8962EC00A89
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 15:46:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7E1020936
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 15:46:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZeHiA9xu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7E1020936
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYWbu-0000Xs-M0
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 11:46:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40264)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hskinnemoen@google.com>)
 id 1kYWZ8-00065S-D1
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 11:43:46 -0400
Received: from mail-ua1-x942.google.com ([2607:f8b0:4864:20::942]:36317)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hskinnemoen@google.com>)
 id 1kYWZ4-0002UR-GF
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 11:43:46 -0400
Received: by mail-ua1-x942.google.com with SMTP id v27so1855161uau.3
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 08:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ie4q/AZ9xU5WHtB60yeUPPVLsiUe10Ly8FqHCFyuUbE=;
 b=ZeHiA9xuCRLjr0yZICr9NyhWdm1UDnSgajjLltADsIvH6GOQKVlTvcFVYzD8wllwM5
 MnUDCaeqJ0MN+1Or4Pz570UWBRAnJx5FnDGEEfTR4RG76vOPVmiYWoFyBe+gTUg/c2f8
 PTJNfegAKia9MSSHxeo2f36ukIptT0LRZ04kB+pzKOSEJi/Elq2EVqqDx09K0W8Lhf2U
 zj8+bksriKtuOQkhXHcK0HGPzG82nIZEf63WCHfewkka9Lgy/4nmuQR75sgonxfuy8XU
 ef/ALYLoc2CCEUvty3aNjaYku6WVj9yFRyuRlvSbX7fTlQkdHakHw14dO+KSMcXMWf/j
 OamA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ie4q/AZ9xU5WHtB60yeUPPVLsiUe10Ly8FqHCFyuUbE=;
 b=Ygz5RGH9ysXTCukLKqfYAxtrXWranwPY1tfXaUTNCpRWW9MbEO2uxw1aeTbTn3vZpN
 E0anjfzagyL5SpXTwfkRVaQNM8ugK70WGgK3BXuxxUk9X7lUA5N4tEXjeoNMCxM6azwc
 FXINBzGn7GU3ER+xvR45mrt02S0FrivrMzxnpmHaEGkoTgQFGKLLmIyOOksnr9ss2a2H
 PUnzghCjh0kuJB4aq9cRXVJXlbHRKPN80izIk4fHAd4vJ8B/Sspb0ZW6Hz+dUg2y+Qxk
 qPA+McAVOGHwYpDxYTkm0DTJwr6nAxFZTkcI4yd3e+wmonIsx7/oS1KUQkhTvQwT7/Pp
 1QOw==
X-Gm-Message-State: AOAM53302UAe0iw0p2dLu1WKd3v91+6b/c5b7r1Kix7NUBhuiJ6B+sRU
 jb9ZNQ3TKY2tmEnK4NysAKe3o4eU42JYsLMf5QSPvg==
X-Google-Smtp-Source: ABdhPJxfMSNBnmlNKn9THGrimsVhUk/BPbg07GiARUjHo/e/wruoqwKbxrZprT7Kad4I9koSkR9Nrz5f3B4oUl6IKrM=
X-Received: by 2002:ab0:8b:: with SMTP id 11mr1930000uaj.15.1604072620640;
 Fri, 30 Oct 2020 08:43:40 -0700 (PDT)
MIME-Version: 1.0
References: <20201023210637.351238-1-hskinnemoen@google.com>
 <20201023210637.351238-5-hskinnemoen@google.com>
 <CAFEAcA_w5j47qz+L02H10UbmyxwD4sxHPu8h2mAinME08Mjkqw@mail.gmail.com>
In-Reply-To: <CAFEAcA_w5j47qz+L02H10UbmyxwD4sxHPu8h2mAinME08Mjkqw@mail.gmail.com>
From: Havard Skinnemoen <hskinnemoen@google.com>
Date: Fri, 30 Oct 2020 08:43:29 -0700
Message-ID: <CAFQmdRaWBfRXJptN2xiT6x4_9GGEKivR5CGLkWtiX0vb1AYusQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] hw/misc: Add npcm7xx random number generator
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, 
 IS20 Avi Fishman <Avi.Fishman@nuvoton.com>,
 CS20 KFTing <kfting@nuvoton.com>, 
 Patrick Venture <venture@google.com>, Hao Wu <wuhaotsh@google.com>,
 Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::942;
 envelope-from=hskinnemoen@google.com; helo=mail-ua1-x942.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=unavailable autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Oct 30, 2020 at 6:34 AM Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Fri, 23 Oct 2020 at 22:06, Havard Skinnemoen <hskinnemoen@google.com> wrote:
> >
> > The RNG module returns a byte of randomness when the Data Valid bit is
> > set.
> >
> > This implementation ignores the prescaler setting, and loads a new value
> > into RNGD every time RNGCS is read while the RNG is enabled and random
> > data is available.
> >
> > A qtest featuring some simple randomness tests is included.
> >
> > Reviewed-by: Tyrone Ting <kfting@nuvoton.com>
> > Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> > Signed-off-by: Havard Skinnemoen <hskinnemoen@google.com>
>
> I've just seen some intermittent failures on the rng tests
> in this patch:
>
> PASS 1 qtest-arm/npcm7xx_rng-test /arm/npcm7xx_rng/enable_disable
> PASS 2 qtest-arm/npcm7xx_rng-test /arm/npcm7xx_rng/rosel
> **
> ERROR:../../tests/qtest/npcm7xx_rng-test.c:190:test_continuous_monobit:
> assertion failed (calc_monobit_p(buf, sizeof(buf)) > 0.01):
> (0.00800994233 > 0.01)
>
> (on OSX)
>
> and (on x86-64 Linux):
>
> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> QTEST_QEMU_IMG=./qemu-img G_TEST_DBUS_DAEMON=/home/petmay01/li
> naro/qemu-for-merges/tests/dbus-vmstate-daemon.sh
> QTEST_QEMU_BINARY=./qemu-system-arm tests/qtest/npcm7xx_rng-test --tap
> -k
> PASS 1 qtest-arm/npcm7xx_rng-test /arm/npcm7xx_rng/enable_disable
> PASS 2 qtest-arm/npcm7xx_rng-test /arm/npcm7xx_rng/rosel
> PASS 3 qtest-arm/npcm7xx_rng-test /arm/npcm7xx_rng/continuous/monobit
> **
> ERROR:../../tests/qtest/npcm7xx_rng-test.c:211:test_continuous_runs:
> assertion failed (calc_runs_p(buf.l, sizeof(buf) * BITS_PER_BYTE) >
> 0.01): (0.00198053202 > 0.01)
>
>
> Are these just "we got a bit unlucky in the values we got from
> the RNG" ?

Yes, it looks like the randomness is a little low.

> If so, we probably need to disable these tests from the set
> that we run in "make check" -- we can't really have "there's
> a non-zero chance that the test fails" tests in our CI loop...

Agree. Is there a way to disable the test by default, or should I send
a patch to remove it?

Havard

