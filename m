Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1BBEC10F0E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 20:17:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 674C52084F
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 20:17:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aVIbn/1k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 674C52084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48637 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDxBe-000510-NA
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 16:17:42 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49319)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hDxAh-0004et-MJ
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 16:16:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hDxAg-0004YM-RC
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 16:16:43 -0400
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235]:41878)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hDxAg-0004XM-C2
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 16:16:42 -0400
Received: by mail-oi1-x235.google.com with SMTP id v7so14712630oie.8
	for <qemu-devel@nongnu.org>; Tue, 09 Apr 2019 13:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=dzC1zUL9bD20DVNFfjt4NxJfVGAOOETwbh/7fLoljA0=;
	b=aVIbn/1ksCB27Ah5o42+uf3ndU7EYVQKgVfRot8qtP1x7EW+OY9U0JRIJNjeko4TgG
	RdhsPvRBOI55nbSoely+LndzUOOxz+48h9B4BxMnL5ko7vyjyRU1ms/j/e+EJdw9+kty
	JeG5Wlz9iovt2TUdnvEbMOUy1if/GYqeY0Dxp3uY7aFUea7MgwSPkcnGyvKmznYKY4+2
	SZxhMm+ZeacK9UfMNiohxAke56oVhJvrzq8GaFnSk4h420134OlUKeDiBfXa0rj2+Z2x
	g7CI3QylEAwfLVGZuQ6/RGzpvvaBudQrHb7O3h3YhR1El0yfrR9WQa8qKm+HIVAuWkMd
	HvrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=dzC1zUL9bD20DVNFfjt4NxJfVGAOOETwbh/7fLoljA0=;
	b=Vyqr7TdkPNqzeigKTotJ30ag7bQj6V27JVI64bbJTHYiu9nf7yjterBSwmV+A9Lxx6
	9NBBGl+JFSKmbSSPW7anIJTdePGF5uFx98Ty8b1Go7AVmvig5Y5f+NzkQAUDtD4utaCq
	Xu3NOHsBJKLfnBftTyrX5TLKmLeGmSHt0wMgmixZHMkO7nZeDsh0FWa7tQ7Nqdmm75O2
	S1oLXni6K/BQWkF6pfRn3OQAk7NqBgglz73O2ZrEV0nbUxeoIyQO5DC3jfgKlhnxDV8i
	3YXc1nm5oU4k+pvIVXcwSS0KJpYTVVO8++/qfKEbXAU3LfsnIHLKJ5PWmOfQfsadsUIx
	DdIQ==
X-Gm-Message-State: APjAAAXJ81tet25F3hqRYVGNI9EbqVLhWA5lLTbPUkkL/EuaFELdKoeb
	O+MqI/2W32or8wSsZFjdoIhaKEnwjRD9sp+KvzxpAQ==
X-Google-Smtp-Source: APXvYqxJ+KEIrOJuaRqVEQJzCjqi24TdKWA6I/DJ+RW2Z8YkqfMS5viDSqNRFojhhePlW5RsO0+/yz8KD4TheSvHyqY=
X-Received: by 2002:aca:c7d3:: with SMTP id x202mr141838oif.48.1554841000755; 
	Tue, 09 Apr 2019 13:16:40 -0700 (PDT)
MIME-Version: 1.0
References: <154907151753.31178.12938166708527410326.malonedeb@gac.canonical.com>
	<155481790266.8592.9119116041656314996.malone@wampee.canonical.com>
	<CAAedzxqBuP98u=YkrK7NU7p7eECODcxHcvspTc09c0+FHFxNnA@mail.gmail.com>
In-Reply-To: <CAAedzxqBuP98u=YkrK7NU7p7eECODcxHcvspTc09c0+FHFxNnA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 10 Apr 2019 03:16:29 +0700
Message-ID:
 <CAFEAcA9X+srbS8gFm-D3KwHZ=PBjTeswkJb3nRK+Hp4geD9-Bg@mail.gmail.com>
To: Bug 1814352 <1814352@bugs.launchpad.net>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::235
Subject: Re: [Qemu-devel] [Bug 1814352] Re: SIOCGIFNAME takes a struct ifreq
 not an integer
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190409201629.1lcG7vteuEtmu9YIplKGPpvlmcoWUjQ7ho_Jr3ylz3o@z>

On Wed, 10 Apr 2019 at 01:26, Erik Kline <1814352@bugs.launchpad.net> wrote:
> Sure.  Looking at HEAD, and even the surrounding the lines, I think I
> should have tried STRUCT_short_ifreq instead of STRUCT_int_ifreq, though
> I'm not sure what the real difference would be.

The multiple STRUCT_*_ifreq are working around the fact that
our MK_STRUCT infrastructure can't handle unions. The struct
ifreq is a char array followed by a union whose members are
various different types. You should use the STRUCT_*_ifreq
corresponding to whatever type the union field used by this
particular ioctl is. For SIOCGIFNAME the ifr_ifindex is read,
and that's an int, so you want STRUCT_int_ifreq. (If you used
the 'short' version by mistake this would probably break for the
case of big-endian guest and little-endian host or vice-versa
because we'd swap the wrong amount of data.)

thanks
-- PMM

