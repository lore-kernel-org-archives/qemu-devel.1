Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6DA6C433E1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 14:21:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95F2E2074A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 14:21:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uWxs7Vte"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95F2E2074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38572 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtXR0-0004Yx-PD
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 10:21:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51714)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jtXKh-0003io-I7
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 10:15:27 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:41239)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jtXKf-0001db-W8
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 10:15:27 -0400
Received: by mail-oi1-x243.google.com with SMTP id y22so1965706oie.8
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2020 07:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=lNNjQi8b+t/1qYv7bRluAnLmEcCT/Chis9UZJWOYFX8=;
 b=uWxs7Vte4OkImDsgBeKOHyi52hKkCtZkfFsqs51U7einmtgmNsZ9XeoRLE4BW7EXSb
 hiDS8uTdTNA0RAyVquNzJUFatISVlnFAuXSMqVGWBWgQ9Rns95MooPBEJwGit4724z2a
 8BPeCYVoJ19SKKTOp9t9vxX7N0n4cO6xWMnok1syiSHdIiVqwzyIPxkrf0cSxvbTUAPs
 hGouMIqj7Z/WUj8wgHvoTGM1McxMLXLeGjKA95eLK1oQjvzY8uGtVxcEu2gVOcg8FYSx
 7Pn3p0EGn8fZXmCp+ChUKPbs6+5fW6xBsAo0nHiXzJaEkY1Xv4hY0hwbC2tfdIUrRP/9
 wgAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=lNNjQi8b+t/1qYv7bRluAnLmEcCT/Chis9UZJWOYFX8=;
 b=ponjY/tFMJmk4yOeCqn7h95ets6dWc5IP1PqbskvVkmCgLtUMFWA7wqNXz9vh8HiDR
 1KWFIfwoE0Ee86g7rIYKn1213WpPqlTA8b1pQK1/oY3rxaK0jo+hVAxGtWj5TBMUXiVZ
 6eN2tb78yUGIw6Lco30f/rM5X1ryRL8U4v1kn+fKpmYj7ZIL57aSunEUg8wM+wa8crmv
 7Ubd47fWnmGFapNQvptn0B/v8s7MhPbNaw5yrgewLVCjBlpTGrYPYrxPJ3EvPjBotMGm
 c4SSKsxDAnWQN2+mqEmr76yIR2UKJ+l5OIhZ3osn/VdE5mJ96a15UjnGNwhNSCvlntvA
 1a2g==
X-Gm-Message-State: AOAM530YQDQlfoo91ybgIRFqqNbWPw/Pdb9GRqn7UAj/rOGZE0ta/r2M
 7GBq5HYmXCwbSwiANh2KzTOMa0ttGlCh/ClMJJEzww==
X-Google-Smtp-Source: ABdhPJzunFtHfvk67GEEnuqTBu8yTB5v6but9+Rajnh0I2FwwV7930mGdeNm07BPDDWROeVdOGphTrU9T+gzPTWN9hI=
X-Received: by 2002:aca:54c9:: with SMTP id i192mr150802oib.163.1594304123770; 
 Thu, 09 Jul 2020 07:15:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200707132116.26207-1-f4bug@amsat.org>
 <20200707132116.26207-3-f4bug@amsat.org>
 <CAKmqyKNY+7tE9tcZm7_Th9qapo1CH0AwNwBf7vaf+7vSqBNtVA@mail.gmail.com>
 <CAFEAcA_ZXgNHMAhBVmjvstyG=PpaHOtcmo=VgvfBQ3Z9VJTk_g@mail.gmail.com>
 <3f1bf3ba-d6c3-a148-9850-076b2caa64d0@amsat.org>
 <CAPan3Wr09ZbbHWO-dhGeK3zhZQv3smrzLpUGMj71NWh0hToZDg@mail.gmail.com>
 <e87550d9-e1cc-cc15-2674-755249e9a965@amsat.org>
In-Reply-To: <e87550d9-e1cc-cc15-2674-755249e9a965@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 9 Jul 2020 15:15:12 +0100
Message-ID: <CAFEAcA8em-bgU2xd8OG+bPLDCSZCF8Y2ay9U57D8p9m1SWO=9g@mail.gmail.com>
Subject: Re: [PATCH 2/2] hw/sd/sdcard: Do not allow invalid SD card sizes
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::243;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x243.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Alistair Francis <alistair23@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 9 Jul 2020 at 14:56, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> =
wrote:
>
> On 7/7/20 10:29 PM, Niek Linnenbank wrote:
> > So I manually copy & pasted the change into hw/sd/sd.c to test it.
> > It looks like the check works, but my concern is that with this change,
> > we will be getting this error on 'off-the-shelf' images as well.
> > For example, the latest Raspbian image size also isn't a power of two:
> >
> > $ ./arm-softmmu/qemu-system-arm -M raspi2 -sd
> > ~/Downloads/2020-05-27-raspios-buster-lite-armhf.img -nographic
> > WARNING: Image format was not specified for
> > '/home/me/Downloads/2020-05-27-raspios-buster-lite-armhf.img' and
> > probing guessed raw.
> >          Automatically detecting the format is dangerous for raw images=
,
> > write operations on block 0 will be restricted.
> >          Specify the 'raw' format explicitly to remove the restrictions=
.
> > qemu-system-arm: Invalid SD card size: 1.73 GiB (expecting at least 2 G=
iB)
> >
> > If we do decide that the change is needed, I would like to propose that
> > we also give the user some instructions
> > on how to fix it, maybe some 'dd' command?
>
> On POSIX we can suggest to use 'truncate -s 2G' from coreutils.
> This is not in the default Darwin packages.
> On Windows I have no clue.

dd/truncate etc won't work if the image file is not raw (eg if
it's qcow2). The only chance you have of something that's actually
generic would probably involve "qemu-img resize". But I'm a bit
wary of having an error message that recommends that, because
what if we got it wrong?

thanks
-- PMM

