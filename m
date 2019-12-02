Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62DDDC432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 16:17:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CDD42053B
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 16:17:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ocOh/xxR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CDD42053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iboOY-0006Y7-Bf
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 11:17:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54080)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iboMT-0005NA-RC
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 11:15:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iboMR-00074w-LM
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 11:15:45 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:45968)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iboMR-00074d-FE
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 11:15:43 -0500
Received: by mail-ot1-x343.google.com with SMTP id 59so791244otp.12
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2019 08:15:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2AOcNssktF6gqXIaJlj3n809rn2H9KnsBb75pdyNby8=;
 b=ocOh/xxRNzw6zKBgd02/XoLOKsbxhHZ5tT8Ut+vEoZPVBs+ZEXOVhITid5vNQCTnRP
 xNtYagt0E3VAlYf+ZMZ3rSUtBZpq74xQK9qZYMDC7uP5f8/zklCeSnIqmr1966DtQK2E
 o38GKC+euhBuz7F7Pb1qKmhaAz5F9FQN5CPyGUADiGGTNStNhNSfYGMrUWAs/sU7xadj
 SulcHUHvyRVGlhbhcIN0v3/VQGFQ1Rv/poXe4y8TgwJP5ACyGBaukoaRJr+WOgIKVGDK
 GK5BL4Du5S9/QuwhbOptqXCLnuR9vMS4zwr3yFBgm3dV87Ok9/sYBRha5zW4vtg2Hgcy
 GIRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2AOcNssktF6gqXIaJlj3n809rn2H9KnsBb75pdyNby8=;
 b=kzX1qgIt57WmAEMgukv8OwyMNLyzHHLGjO2WyUc+hze9a7g6NU4vz5HW5hYgCNv7/3
 9HjqqcnbPFljKVkXdfzZX9ztyFqTkNlSNmeY+flyjMiCD6rTC9w+6BTuyUrQ64xDrOMP
 cAveqWiOiGuSx5FkfOU4gz7S0HVGBegYkc/pLLOGOVUmPcpCBYF3LD65eefoltXnUYjj
 w30p9JJ17BlrCXMXN9Koh4knbbdYTAYVVfli5kkBoPgY64ab+kCYZ9gtA5gyVWZxchd8
 Jht+rmwao1k+EybsjA5SUKWBcgxV52p6vqMOh1GAGCLKuSHAQBch/kYy5by3UU4109YM
 OMQQ==
X-Gm-Message-State: APjAAAWZ7BlP5jr5Yf7Ku2J29idH1Wy0xjRZMlKhNCFhURJPERCfJil+
 b7c9uAo5Zzpt6fKmRQoRn6pBPMhswfOFIWv/jCwDpw==
X-Google-Smtp-Source: APXvYqyvXIJYH8yj1inwPmL1uryBhuLkH68iQRRUo/FEj8QNkmJcNorE1yzSQcoNSxQZw3mhynxyAyro7tZpADOJxzo=
X-Received: by 2002:a9d:6357:: with SMTP id y23mr22242219otk.91.1575303342083; 
 Mon, 02 Dec 2019 08:15:42 -0800 (PST)
MIME-Version: 1.0
References: <20190904125531.27545-1-damien.hedde@greensocs.com>
In-Reply-To: <20190904125531.27545-1-damien.hedde@greensocs.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 2 Dec 2019 16:15:30 +0000
Message-ID: <CAFEAcA98rt6nRDSrwk8XRbaBT67LZXvF=XEV13dtJBp4fPUscw@mail.gmail.com>
Subject: Re: [PATCH v6 0/9] Clock framework API
To: Damien Hedde <damien.hedde@greensocs.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Mark Burton <mark.burton@greensocs.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 4 Sep 2019 at 13:56, Damien Hedde <damien.hedde@greensocs.com> wrote:
>
> This series aims to add a way to model clock distribution in qemu. This allows
> to model the clock tree of a platform allowing us to inspect clock
> configuration and detect problems such as disabled clock or bad configured
> pll.
>
> The added clock api is very similar the the gpio api for devices. We can add
> input and output and connect them together.
>
> Very few changes since v5 in the core patches: we were waiting for multi phase
> ability to allow proper initialization of the clock tree. So this is almost a
> simple rebase on top of the current "Multi-phase reset mechanism" series.
> Based-on: <20190821163341.16309-1-damien.hedde@greensocs.com>

I've now gone through and given review comments on the patchset.
I don't think there was anything particularly major -- overall
I like the structure and API (and also the documentation!).

The one topic I think we could do with discussing is whether
a simple uint64_t giving the frequency of the clock in Hz is
the right representation. In particular in your patch 9 the
board has a clock frequency that's not a nice integer number
of Hz. I think Philippe also mentioned on irc some board where
the UART clock ends up at a weird frequency. Since the
representation of the frequency is baked into the migration
format it's going to be easier to get it right first rather
than trying to change it later.

So what should the representation be? Some random thoughts:

1) ptimer internally uses a 'period plus fraction' representation:
 int64_t period is the integer part of the period in nanoseconds,
 uint32_t period_frac is the fractional part of the period
(if you like you can think of this as "96-bit integer
period measured in units of one-2^32nd of a nanosecond").
However its only public interfaces for setting the frequency
are (a) set the frequency in Hz (uint32_t) or (b) set
the period in nanoseconds (int64_t); the period_frac part
is used to handle frequencies which don't work out to
a nice whole number of nanoseconds per cycle.

2) I hear that SystemC uses "value plus a time unit", with
the smallest unit being a picosecond. (I think SystemC
also lets you specify the duty cycle, but we definitely
don't want to get into that!)

3) QEMUTimers are basically just nanosecond timers

4) The MAME emulator seems to work with periods of
96-bit attoseconds (represented internally by a
32-bit count of seconds plus a 64-bit count of
attoseconds). One attosecond is 1e-18 seconds.

Does anybody else have experience with other modelling
or emulator technology and how it represents clocks ?

I feel we should at least be able to represent clocks
with the same accuracy that ptimer has.

thanks
-- PMM

