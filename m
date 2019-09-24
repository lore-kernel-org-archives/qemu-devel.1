Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 856C6C432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 09:43:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FDEB2146E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 09:43:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OETQ8pce"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FDEB2146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iChLx-0006A2-E8
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 05:43:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55983)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iChL1-0005FQ-SG
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 05:42:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iChKz-0000pY-SM
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 05:42:27 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:40207)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iChKy-0000p6-6F
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 05:42:25 -0400
Received: by mail-ot1-x344.google.com with SMTP id y39so895805ota.7
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 02:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=cnAncg5xcYVP1+ycJjXSP0cv8GqoSd2D/1n+EMJyTyc=;
 b=OETQ8pceIAqHlzu7h8mkYSCJ1AEkjBcAQnnJY/pS5LHnP52AcMDPp9TGhr2frFDFOi
 jb3I1mEE86hQSbrf5Dfsbo93y8NorEE6xRdhavAb3Zzgzb4bweesVYaKex4Y+3ktvdpX
 wX8bVUlvcwOKu6gV5jdQTe872m1ESMSFepTzk5f1Hgx7IMyd/STQwR0LKtE5ixwoRmYh
 JL4LvuRj1ab7oTi+mo8NKptFfhQ5lrHR5nlJrg5ttw+V54tnPHWiArZfCnB00al3VDec
 9paESACf/2Sasa2qyaaGtkFphtsSDLjl7SvSV+GhkFrakRW1/R57+DvBiREzoB7x7nQ8
 Am8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=cnAncg5xcYVP1+ycJjXSP0cv8GqoSd2D/1n+EMJyTyc=;
 b=sHM4vLYIv7bPHi2KLJH+4dnU78p+Gln7gvPb906o5xdDJSE35y+8sU6bPks8kDbOfp
 6N/VPJ3aBbuI3hFLcBzSxS+sNdIpt+jSr0e9yJIw4RSNoyfd9H4xVnMrCo9cRWVCsb91
 EsD9euRtc5ztnfIkcxlun5tnwp2GIPyVDZr5X+BSRFLoAn+chKuKdlhbwNCL4nS3DT9l
 vfpyN0EfUEiUVj4+9p1Jf/h+H4kAIUN0jX83zIN7++VOwbNZ1vlMgF1y77H5MdyqoT/V
 Xl3dV6c2B/r0paGaa61KgoLPdjTO4PmChw8BTtWJSkO8Ywo4cU0mMDuVOFGaCXaVuNsy
 YNIQ==
X-Gm-Message-State: APjAAAU4eaGcHulHu7gDEoD8gkbLLu+plun5umCbzP4T+nQfpP7eHId3
 Pu+cuoL7r1CKcjSIbdk8lWAgN3Ov4+uZQxvr9nAG8Q==
X-Google-Smtp-Source: APXvYqxqBu9iTZpMgjiGF1whr52DTFH7V1C5n8JNL5EAB1GYrnoOVzId1XmJlqDZuzTyaddQ5l9ZKoDQ/U58ZxkujTg=
X-Received: by 2002:a9d:562:: with SMTP id 89mr1131804otw.232.1569318143210;
 Tue, 24 Sep 2019 02:42:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190921150420.30743-1-thuth@redhat.com>
 <20190921150420.30743-4-thuth@redhat.com>
 <CAFEAcA_6UxMBeyOMM0iT5cnCQEpWXfRO2XMuV9ez_0Su2osXNg@mail.gmail.com>
 <0389e9dc-7f78-5b27-4764-51f0bdef5bef@redhat.com>
 <CAFEAcA8XSQs=fw839O4+tTUqy-DpNh-jdHxQsfYQxm-nTbvH4Q@mail.gmail.com>
 <88bcb5b7-4f91-1cc2-39a1-bd919608737e@redhat.com>
 <CAFEAcA_QAtK3GmyZoR7swNKwdxkXWZCzdK0G6Sk6OU_tQ9FV2A@mail.gmail.com>
 <3a21d31e-fe74-9e0f-fe8d-f9c00a184fe3@redhat.com>
In-Reply-To: <3a21d31e-fe74-9e0f-fe8d-f9c00a184fe3@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Sep 2019 10:42:11 +0100
Message-ID: <CAFEAcA-ThXGZKr8--YZGUPiw4MaMVqMxKODhVepXCgjxox6ZQg@mail.gmail.com>
Subject: Re: [PATCH 3/4] hw/arm: Move armv7m_nvic.c to hw/arm/ and always
 enable it for arm builds
To: Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 24 Sep 2019 at 05:44, Thomas Huth <thuth@redhat.com> wrote:
>
> On 23/09/2019 20.50, Peter Maydell wrote:
> > On Mon, 23 Sep 2019 at 19:36, Thomas Huth <thuth@redhat.com> wrote:
> >> Just try to change "obj-$(CONFIG_ARM_V7M) += armv7m_nvic.o" into
> >> "obj-y += armv7m_nvic.o" in hw/int/Makefile.objs, and you'll see it break:
> >>
> >>   CC      alpha-softmmu/hw/intc/armv7m_nvic.o
> >> In file included from include/hw/intc/armv7m_nvic.h:13,
> >>                  from hw/intc/armv7m_nvic.c:19:
> >> target/arm/cpu.h:1416: error: "FPCR_DZE" redefined [-Werror]
> >>  #define FPCR_DZE    (1 << 9)    /* Divide by Zero exception trap enable */
> >
> > Sure, so don't define CONFIG_ARM_V7M in a default-config for
> > a non-Arm architecture. Then you get the behaviour you want:
> > the file is compiled only for the arm targets.
>
> Sigh, the point of this series is that it should also possible to
> compile *without* CONFIG_ARM_V7M in default-configs if you want (and
> yes, there are people out there who want to be able to compile a
> minimalistic QEMU). It's currently not possible to disable this switch.
> But ok, if you're not really interested in providing a possibility to
> make qemu-system-arm a little bit more flexible in this regard, never
> mind, I'll look into other issues instead.

No, I'm happy that we should be able to compile without CONFIG_ARM_V7M
selected. I'm just confused about why you think this requires that
we move this file out of hw/intc.

Case 1: arm target, CONFIG_ARM_V7M=y (presumably in a Kconfig world
this is set by default if the user doesn't flip that switch):
obj-$(CONFIG_ARM_V7M) expands to obj-y, file compiled, OK
Case 2: arm target, CONFIG_ARM_V7M=n set by user via Kconfig:
obj-$(CONFIG_ARM_V7M) expands to obj-n, file not compiled, which is
also what we want Case 3: not an arm target, CONFIG_ARM_V7M will be
either 'n' (or empty?) and is not settable by user: expands to obj-n
again, which is also what we want

Is there some Kconfig restriction I'm not aware of that
messes things up?

thanks
-- PMM

