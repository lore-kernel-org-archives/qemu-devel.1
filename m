Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01B63C33CAC
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 14:05:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C10FD2051A
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 14:05:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YmparMjj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C10FD2051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iycMK-0006wL-U5
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 09:05:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58967)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iycLY-0005oy-SA
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 09:05:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iycLX-00011x-9g
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 09:05:04 -0500
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230]:45607)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iycLX-000112-56
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 09:05:03 -0500
Received: by mail-oi1-x230.google.com with SMTP id v19so14787745oic.12
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2020 06:05:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=eNIRnxAsC+QgJgvB0Ex1LkJvK8YiwT+xCiZTgixSJjc=;
 b=YmparMjjaNcdfRsnXheQBLnID7tR54ouCOCo+YtHs1RMy+TrxXtT3eWF92ZZ01h9sr
 tmRGyVmIIMKgtPyglRAe0Hv0wvMYy6bxiDq3nW5h15jAs23rRtA36+lyDs646C3Ja1JS
 uP9K/JEihtGcso67kvHyumqg2TfAl766tAAmS55/9N7dCEV+Qrt6JoIYY1SNwltJrFe+
 L0m5p+TZ8SfSRGHHa+31EbvjtG7I6h0f+UtuMZ3HLU1xbSHaAX6atE9TT1NxMJUXK0O7
 Z7PmugX2Lat4Fd7q9+6gogZ0O0Zw/lAs9GtcfSmhbN0kgKAoB5nMY5pdw4To6oB6MKkS
 bOWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=eNIRnxAsC+QgJgvB0Ex1LkJvK8YiwT+xCiZTgixSJjc=;
 b=Jzo2GtnT0lpLiK5AM82zNuY+jeLaJFpYxDvJanf/YSaOrGIT2RMAjWGAjxwQBVTOS6
 PmshBEjKr2y+IndM/ZMUm7o01fwTJbA5Yxqec5m0Yx+XnNC99+3ZbplxfjwswpXvrcqU
 1yzbGFQadDPA3SNnaaxjzO8DWrxdhoMqNWC9SCEW219yySFKeUqFuAr6nwE/r6K4BiyM
 TtCK6qzICK3YlR5QDCWt298RPQjkp1q+hYa/PLKl4xa9mjF4rkVsVfjSKnWKCyAZKTlh
 R7Mwb+vy+u/iNmSIXYES97edJZBXYRUgyeNOHXA6Uy4OSqTiYnjGo6Tc4GJKTCbp3QVV
 3jng==
X-Gm-Message-State: APjAAAV1S5ZPVqmphY0gnwtX0TSATcXVnuxwexM7BB/bWcvDmQQm4Bcy
 20ViOkbyAOq81jjiA19fM8HcmOb/gTcZtMs1J7v4uw==
X-Google-Smtp-Source: APXvYqwa9L+ZMcn83J7IUgI8hJXlzQ9O7n0XMoFlbpBIMWB85rchoNFRUqIk1IdCDXr4ntIZP8qLXfwS00uH6IlR2GU=
X-Received: by 2002:a54:4f16:: with SMTP id e22mr6728332oiy.170.1580738702274; 
 Mon, 03 Feb 2020 06:05:02 -0800 (PST)
MIME-Version: 1.0
References: <20200203123811.8651-1-thuth@redhat.com>
In-Reply-To: <20200203123811.8651-1-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 3 Feb 2020 14:04:51 +0000
Message-ID: <CAFEAcA_1KYRA=87k34zCRLqCf1tWHrULGZPcHeKwJZhDUx0=kw@mail.gmail.com>
Subject: Re: [PULL 00/13] qtests, kconfig and misc patches
To: Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::230
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

On Mon, 3 Feb 2020 at 12:38, Thomas Huth <thuth@redhat.com> wrote:
>
>  Hi Peter,
>
> the following changes since commit 28db64fce555a03b4ca256d5b6f4290abdfbd9e8:
>
>   Merge remote-tracking branch 'remotes/stefanha/tags/tracing-pull-request' into staging (2020-01-31 17:37:00 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/huth/qemu.git tags/pull-request-2020-02-03
>
> for you to fetch changes up to 585c138628bbf22ea8e740b2f4f1a3ed0274ebe8:
>
>   trivial: Remove xenfb_enabled from sysemu.h (2020-02-03 10:33:57 +0100)
>
> ----------------------------------------------------------------
> * Current qtests queue
> * Some Kconfig updates
> * Some trivial clean-ups here and there
> ----------------------------------------------------------------

All the incremental rebuilds failed:

Linux cam-vm-266 4.15.0-70-generic x86_64
From git://git-us.linaro.org/people/pmaydell/qemu-arm
   f31160c7d1..f9e931a1d9  staging    -> pmaydell/staging
make: Entering directory '/home/petmay01/qemu-for-merges/build/w64'
make[1]: Entering directory '/home/petmay01/qemu-for-merges/slirp'
make[1]: Nothing to be done for 'all'.
make[1]: Leaving directory '/home/petmay01/qemu-for-merges/slirp'
  CC      qga/main.o
  CC      stubs/machine-init-done.o
  CC      stubs/replay-user.o
  CC      stubs/semihost.o
  CC      qemu-img.o
  CC      qemu-io.o
  CC      chardev/char.o
make: *** No rule to make target
'/home/petmay01/qemu-for-merges/hw/bt/Kconfig', needed by
'aarch64-softmmu/config-devices.mak'.  Stop.
make: *** Waiting for unfinished jobs....
  CC      chardev/char-mux.o
make: Leaving directory '/home/petmay01/qemu-for-merges/build/w64'

thanks
-- PMM

