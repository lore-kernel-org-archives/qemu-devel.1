Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F289C43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 14:50:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09F3F24673
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 14:50:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xy26temO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09F3F24673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idEwK-0003Yb-Q1
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 09:50:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36590)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1idEPY-0002fb-Vs
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:16:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1idEPV-00036b-5k
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:16:46 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:44313)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1idEPT-00033x-MP
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:16:44 -0500
Received: by mail-oi1-x241.google.com with SMTP id d62so6240817oia.11
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2019 06:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=cqLL5RtdyUdC5IL64sizJ5FYAyB9GVg7mF4uLUkd2ck=;
 b=Xy26temOiPfQ2BXiKHRPxzyqkQpjxppqbn3sjJYv16iKFhjEPsYYt8zRI2h05x6YML
 bVZndVDyazYL++HHCbYEEZj0Qg9TTZCoyW0R9W5oZYIeEdYGFjmzlyxd0Wpa+OGRxEIJ
 QVDQxRcptCPijJWly9olMZ5/RYUxEUbalUvJQHuJNIkfZhFWAIhaPcr3W0SzZwpRq15n
 uIso3oXeDHzkQykQvo3+RO9mp2S8gFacNrboVx6yt8PAosz9Ixd9fsRMEkmQt/wFiOi2
 0Q0dHSHzUxRJpmtASypxD/e0RJRoapA45E1zoS9XU0TB/S+v6TjI7lcttiF/vqeq7LB4
 0n+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=cqLL5RtdyUdC5IL64sizJ5FYAyB9GVg7mF4uLUkd2ck=;
 b=Bq7a3B2QYRcA9NL7oMVbCQWZbZlcEMH9qH5wVUIlrMkCQRliXt0/aRe2ksSrcddwpn
 dREavoXUKObtEdAfS4VWJAqTBxlcf1Bnclv9WU8srhqKq2MEuyqed4Nx0k8RUkm9doEz
 qLCQ9zxMMqfO/VcteRh70wcKiLHB/39UiHjicp0qoKXM1PSLqVux+w1Q/PDc+vQ+Eya5
 Ou1e+JVX1NRKmDfW/dx06C9l4GbbKQn4JgUEAcoGVlkdY9FGtT/E3lltbySVGCga9fPh
 8M2uEYY0lWtIh5jp8cb18TXa27JnLaJ8MzzT4GH8xEMam1j0cdtnl3lcpOwemyQKCZAy
 Q6SA==
X-Gm-Message-State: APjAAAXcY3/gveUvfnZlJro4ob3+PJwTwqwfSMEiohsTeMwRpx6O40Dp
 CHXiXFg24aGt23C1YAd/Mq/565s+Jh1FVNgDa2NZ/w==
X-Google-Smtp-Source: APXvYqyotJT4TYt3XVxqaLIrZXCcD+9qllLQmnQyva14c9LScCikQTngN9hVk25112Zv7iYftV+AwPk/gnmJhQfTp4o=
X-Received: by 2002:a05:6808:996:: with SMTP id
 a22mr11804663oic.146.1575641800450; 
 Fri, 06 Dec 2019 06:16:40 -0800 (PST)
MIME-Version: 1.0
References: <20191202210947.3603-1-nieklinnenbank@gmail.com>
 <1de57227-8124-4d11-d996-9faf67b3e4f3@redhat.com>
 <CAPan3WrNDoLjmEETAQHa2GmG70yP3TzPnJqzQLK_t+m7CV+ONw@mail.gmail.com>
In-Reply-To: <CAPan3WrNDoLjmEETAQHa2GmG70yP3TzPnJqzQLK_t+m7CV+ONw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Dec 2019 14:16:29 +0000
Message-ID: <CAFEAcA-WxMXs=hsV61_dYVxsc963NvWM7QK4hYqkedx4boCAqw@mail.gmail.com>
Subject: Re: [PATCH 00/10] Add Allwinner H3 SoC and Orange Pi PC Machine
To: Niek Linnenbank <nieklinnenbank@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
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
Cc: Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Niccol=C3=B2_Izzo?= <izzoniccolo@gmail.com>,
 Beniamino Galvani <b.galvani@gmail.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 3 Dec 2019 at 19:32, Niek Linnenbank <nieklinnenbank@gmail.com> wrote:
> Indeed that sounds like an interesting combination. Are there plans to build a multi-arch/single-binary QEMU?

This is in the category of "it would be nice in theory to
support multi-arch guest machines, and we've made some
small steps in that direction and/or tried to keep the
door open for it when designing things, but it would
still be a huge amount of work to actually implement,
so don't hold your breath for it or make anything else
depend on having it happen first"...

thanks
-- PMM

