Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60281C433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 13:59:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1394720C09
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 13:59:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FxpMQWqe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1394720C09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDplg-0001XP-35
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 09:59:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51296)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kDpl4-0000tU-0D
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 09:58:34 -0400
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641]:34572)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kDpl1-0003Hb-UW
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 09:58:33 -0400
Received: by mail-ej1-x641.google.com with SMTP id gr14so2890494ejb.1
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 06:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=TVj+wlp4SSk8evA8tvPi1Miohb6m3ZMNiPPqbtxqqNs=;
 b=FxpMQWqeXLbuho45qTZrscwj5KNo28ve+0ZyoKsOBd3SoEngGNPIyBrQ7njg/BpwIF
 b53vEDNEMjCwJqzwth/GE8M8gf7Uo8wN/mzZI9nqNRHL/plhcm5vVkSUlmX+2XFa1gpq
 pbwMpssGzIIC6fMRyP/uzY9d+ted2dod2Q6oSY3jy7hfridaJUQHEwX5yNOPnlLSLMfL
 GouqkbXeTLNtYcxaMPXGtEyQxOEAfVJnKv5kQSUr4I16cfH3v4SvqvafVqAZTqBYVSpP
 BjUiwYF8QDZufXEti1k216qI6ot9lOojJLlY6CizFwF6ukGWtVMVp9GgOzDw1Z5SyR6A
 A9fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=TVj+wlp4SSk8evA8tvPi1Miohb6m3ZMNiPPqbtxqqNs=;
 b=D5/HhP4+WE2noywGzCT14ps+xxpGCC3B7dUamaDxx6LRQZyGWZTS0sG92WEaan71i2
 4bROeZEKjjXtdEcb31kJNKv4+yq9GE3yGpa2FpFrci88BccW4UuEWRiSKtPHhn8JsMCP
 7+es9J9tU17uGsoc54TTpt2KjmEnpuSD//Gq4TJcKRTCll9KHm5CcwlGlfi7YYdU5mPM
 2ZjUHWj4CTOrjPG51e5iRKjbDTP20I3guooiWlEfLC3qLMWN7X/okbNjooKx8Hj7Pfhp
 29+TOsICF7L+hTH6gW0mgYXywE0IlFxM517h3kf6O3mPo/iqZu3ItcppHfVsBh2CYsOz
 CewA==
X-Gm-Message-State: AOAM5323MHBrA4HQMqgK8duv8MU7Oya10LhSuak9YiooOWYcm+6QrVaz
 huVqca5kPB88COA7rjcw9LbqIrsgEha+Oxc/DN4EFw==
X-Google-Smtp-Source: ABdhPJzmRN0XZKro/MnUZ3P4IyenheHc1KBslpLBdUfdpw1ei39la1PwNIWoSy4DlzdkLwY8M9YpSWNo6qQkoXss6iI=
X-Received: by 2002:a17:906:d8ca:: with SMTP id
 re10mr2229877ejb.382.1599141510098; 
 Thu, 03 Sep 2020 06:58:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200903110831.353476-1-philmd@redhat.com>
 <658fdd16-33da-af3a-6d8d-f7ea1253f061@redhat.com>
In-Reply-To: <658fdd16-33da-af3a-6d8d-f7ea1253f061@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 Sep 2020 14:58:19 +0100
Message-ID: <CAFEAcA8aOzq8UQwKiyuvJokBT9ui6JWxzf=T8=r13Vuu6+_kkQ@mail.gmail.com>
Subject: Re: [RFC PATCH 00/12] hw: Forbid DMA write accesses to MMIO regions
To: Laszlo Ersek <lersek@redhat.com>
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>,
 Qemu-block <qemu-block@nongnu.org>, Li Qiang <liq3ea@163.com>,
 "Emilio G . Cota" <cota@braap.org>, Peter Chubb <peter.chubb@nicta.com.au>,
 Joel Stanley <joel@jms.id.au>, Richard Henderson <rth@twiddle.net>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Robert Foley <robert.foley@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>,
 Beniamino Galvani <b.galvani@gmail.com>, Eric Auger <eric.auger@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>, Jan Kiszka <jan.kiszka@web.de>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>, Tony Nguyen <tony.nguyen@bt.com>,
 Prasad J Pandit <pjp@fedoraproject.org>, Alexander Bulekov <alxndr@bu.edu>,
 Andrew Jeffery <andrew@aj.id.au>, Klaus Jensen <k.jensen@samsung.com>,
 Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>, qemu-ppc <qemu-ppc@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 3 Sep 2020 at 14:37, Laszlo Ersek <lersek@redhat.com> wrote:
> Peter mentions an approach at the end of
> <https://bugs.launchpad.net/qemu/+bug/1886362/comments/5> that I believe
> to understand, but -- according to him -- it seems too much work.

It also would only be effective for MMIO, not for qemu_irq lines...

> I don't think such chains work unto arbitrary depths on physical
> hardware either.

Real hardware by and large doesn't get designed with this kind
of DMA-to-self as a consideration either, but unfortunately it's
not really very useful as a model to base QEMU's behaviour on:

 (1) real hardware is usually massively parallel, so the logic
  that handles incoming MMIO is decoupled anyway from logic
  that does outgoing DMA. (Arguably the "do all DMA in a
  bottom-half" idea is kind of following the hardware design.)
  Similarly simple "raise this outbound signal" logic just
  works as an instantaneous action that causes the device on
  the other end to change its state/do something parallel,
  whereas for QEMU we need to actually call some code in the
  device on the other end and so we serialize this stuff,
  sandwiching a bit of "device B code" in the middle of a
  run of "device A code". So a lot more of this stuff "just
  happens to work" on h/w than we get with QEMU.
 (2) if software running on real h/w does do something silly with
  programming a device to DMA to itself then the worst case is
  generally that they manage to wedge that device (or the whole
  machine, if you're really unlucky), in which case the response
  is "don't do that then". There isn't the same "guest code
  can escape the VM" security boundary that QEMU needs to guard
  against [*].

[*] I do wonder about hardware-device-passthrough setups; I
don't think I would care to pass through an arbitrary device
to an untrusted guest...

thanks
-- PMM

