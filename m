Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ECFFC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 12:31:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67D3E20748
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 12:31:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nXZ345GT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67D3E20748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55750 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtsBR-0002AP-MV
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 08:31:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37274)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jtsAW-0001ZV-1m
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 08:30:20 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:39369)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jtsAS-0003y3-65
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 08:30:19 -0400
Received: by mail-oi1-x244.google.com with SMTP id w17so4632599oie.6
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 05:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=w4878pnn0KlQygn2C+Za+LN3dCci4Ne0kcGh5BvUJhc=;
 b=nXZ345GTdNzYPrN1sYKQrO1l0gh359mmidmW1/gGOGXJwRYn07xSJpIjWh7in1u12y
 c7fg3vNZudzXKEcaQKUsIDx/E+1OOXWtQ6DN4JAU6f3PMVlx11ZYnzl70YiO9WDtpU2o
 3cIA1AZXsAH5xD4Pd4AhB+kOMIvTQGtKA66wDh7teujBm+bPkMpUKKBYtkTv3X+yQ8sL
 QiZ3qRJbqjlaOT3xKLqdBHdvql2XEIpJKqyuTIfJNWnv88Dg+I2OXmfTl5wpN2LawEip
 JRX7H1ADteQ4YmANhOHnL+/v5P/IpL9TQrq4SlLBgxrV7WOdltd2LYMC8z4YLp2TtAyO
 WzWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=w4878pnn0KlQygn2C+Za+LN3dCci4Ne0kcGh5BvUJhc=;
 b=JQhwKlEeDkU5dID7fPX607S6ppl6+Sb5vGX5EfAcWwr9Rsebh5XDjon2FCW9B6S0iN
 DdbEHzf4bcqnrcertX95hr+I1peihjVacPKpB+4JK2n+nvP20REyaoANg3vId/ah/88J
 ltWz7JcPzohLh1tzKLDPwQQ+4XVlTCWmHCa1Oa3k+BfYUUQ9hskudYRyGTUIrf/Cb74a
 vVk7PvTkfxCQePatkXdv8IUMZINYVeDjuY8oDi9bE8BP1/SbhB8diPveHwTd54JjS/MM
 7qsOmne/ZnYdBUAmWQxI7ppyGFfSy6bjo4EcYchd2t3P3x5jMpr7geCGoBu0N1hYi8ZC
 zysg==
X-Gm-Message-State: AOAM532djiVeCKmm2Qko/KMvz5IXYkRG+ljr2UIEg2tDoISmojNKA9F4
 t18QF0uLZvL5x9r/g/5vTTRlv/1OubVv+BzGqgrgXA==
X-Google-Smtp-Source: ABdhPJzGgo1AP0eqpYfQt7mlucZUrAden6cYvUL3pZhJgnm29agnhqo2A7vSowIguTPP6vw3itXLPJcTucyB3APdivE=
X-Received: by 2002:aca:54c9:: with SMTP id i192mr3980546oib.163.1594384215011; 
 Fri, 10 Jul 2020 05:30:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200707132116.26207-1-f4bug@amsat.org>
 <20200707132116.26207-3-f4bug@amsat.org>
 <CAKmqyKNY+7tE9tcZm7_Th9qapo1CH0AwNwBf7vaf+7vSqBNtVA@mail.gmail.com>
 <CAFEAcA_ZXgNHMAhBVmjvstyG=PpaHOtcmo=VgvfBQ3Z9VJTk_g@mail.gmail.com>
 <3f1bf3ba-d6c3-a148-9850-076b2caa64d0@amsat.org>
 <CAPan3Wr09ZbbHWO-dhGeK3zhZQv3smrzLpUGMj71NWh0hToZDg@mail.gmail.com>
 <e87550d9-e1cc-cc15-2674-755249e9a965@amsat.org>
 <CAFEAcA8em-bgU2xd8OG+bPLDCSZCF8Y2ay9U57D8p9m1SWO=9g@mail.gmail.com>
 <20200710095827.GD6641@linux.fritz.box>
 <CAFEAcA_+JpRpNSd7SwBD=OcDxqZ1Mf3xTYR2DM0Os_fFZs4VOg@mail.gmail.com>
 <20200710120731.GE6641@linux.fritz.box>
In-Reply-To: <20200710120731.GE6641@linux.fritz.box>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 Jul 2020 13:30:03 +0100
Message-ID: <CAFEAcA_YvGFPS30rtp20PmZ1Df_+BGj-17NOav-utBfPcz5Tvg@mail.gmail.com>
Subject: Re: [PATCH 2/2] hw/sd/sdcard: Do not allow invalid SD card sizes
To: Kevin Wolf <kwolf@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::244;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x244.google.com
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
Cc: Qemu-block <qemu-block@nongnu.org>,
 Alistair Francis <alistair@alistair23.me>,
 Alistair Francis <alistair23@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, Cleber Rosa <crosa@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 10 Jul 2020 at 13:07, Kevin Wolf <kwolf@redhat.com> wrote:
>
> Am 10.07.2020 um 11:59 hat Peter Maydell geschrieben:
> > On Fri, 10 Jul 2020 at 10:58, Kevin Wolf <kwolf@redhat.com> wrote:
> > >
> > > Am 09.07.2020 um 16:15 hat Peter Maydell geschrieben:
> > > > dd/truncate etc won't work if the image file is not raw (eg if
> > > > it's qcow2). The only chance you have of something that's actually
> > > > generic would probably involve "qemu-img resize". But I'm a bit
> > > > wary of having an error message that recommends that, because
> > > > what if we got it wrong?
> > >
> > > What is your concern that we might get wrong? The suggestion is always
> > > extending the size rather than shrinking, so it should be harmless and
> > > easy to undo. (Hm, we should finally make --shrink mandatory for
> > > shrinking. We've printed a deprecation warning for almost three years.)
> >
> > If there's a qemu-img command line that will always only
> > extend the image size and never let the user accidentally
> > shrink it and throw away data, then great. I'd happily
> > recommend that.
>
> I think removing deprecated behaviour is a change that we can still make
> in the early freeze. So if you agree, I'll send a patch that makes
> shrinking an image without --shrink a hard error in 5.1.

Happy to defer to your judgement on that; I agree that removal
of deprecated behaviour is ok at this point in freeze.

-- PMM

