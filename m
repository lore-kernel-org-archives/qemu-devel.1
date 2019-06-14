Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C0DEC31E44
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 09:06:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D900020866
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 09:06:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L9rdPrOH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D900020866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49462 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbi9w-0005pm-3z
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 05:06:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34396)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hbi8M-0004o9-Ur
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 05:04:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hbi8L-0000md-6u
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 05:04:30 -0400
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334]:41713)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hbi8J-0000kO-A7
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 05:04:28 -0400
Received: by mail-ot1-x334.google.com with SMTP id 107so1943781otj.8
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2019 02:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ttYel+XRkLqNZW5TjPRisoYzQzdRDXKxpjV1BeqHwyI=;
 b=L9rdPrOHj4orJbiiOc9gHzUXMjG5NDTntKYfZRZTyWKbO7TcPHg0Nr+XRQAASAALpy
 emHcPnHqnhjbpE/uGDGarIgyHCsw2vi4fpTWnlQBcIZuThvruEPRWA0W1U1ASD2I8XV1
 VYPsVaeC7cXfXGx/M0eCL7Ss8zZylEQ6gqqUqU0hThhOKfUNIziQ3fpeuevCVQzr0wbe
 d/puctxNSf0DFgZE0yIBi4a30blBaXqOpYq73pIjdnJJJTz/uc2pv6ru5Lr4UjhuxYim
 62kB8KV3dlWSEVF2QjYvxUTix7jiRI3b0odAkfm7+t2KPLNszakJZDRxY1byH8flyEJI
 OBcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ttYel+XRkLqNZW5TjPRisoYzQzdRDXKxpjV1BeqHwyI=;
 b=YZuE2X4fm2Twp37ZbYrI3J/Ztu5nM3LtYy4xMe/P+FryTx5GUQK3NRV9zjMHShPy80
 bBAEj3hrPqDXPq3Uehp7puPFu4cpeJph+EmaXPvURu4w7HZFioTHai+mGIDWr3Y7fbXu
 Scyah6W9MOqQPeLHn/gHUf6Bg6Kp3WENAIMji7qWHzQ0j0vlBczw3hLvZlhvySE7kaLN
 fO5eOTqK2LNHRwFA6WGUz8l+vph3oWAjW0kQplBLy0cyN6VQEhM+L4dvIcY84ykuAkKK
 Hpnp9vmFATktFBslQavnX4utf1td2qVMG6tLK6sSg/wdqr720EeABr86EUnbpaH1qCk5
 cRyg==
X-Gm-Message-State: APjAAAXu5X7GTtvfdKdpVfGAJX+eArpOKZg5EYHCN8btNstzyRI2hI5b
 4v/pUnmhV2fF+R46VEUtGzXDQGew0nb958yBdnq65w==
X-Google-Smtp-Source: APXvYqwxZaypnirmXM0KKN6k7FV20RoU4FCo7QDvD2TxyGTWa7mRIvQ7z9roD70SZxvyC/yrE8Uont+StZx9YC72aFs=
X-Received: by 2002:a9d:d17:: with SMTP id 23mr45792591oti.221.1560503065838; 
 Fri, 14 Jun 2019 02:04:25 -0700 (PDT)
MIME-Version: 1.0
References: <156046151566.26543.17274661862206856605.stgit@gimli.home>
In-Reply-To: <156046151566.26543.17274661862206856605.stgit@gimli.home>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 14 Jun 2019 10:04:14 +0100
Message-ID: <CAFEAcA-iJZmmFSy5Ab7Bh2OZBrZ6xsdD9hnD9cFbShSTA0vD2Q@mail.gmail.com>
To: Alex Williamson <alex.williamson@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::334
Subject: Re: [Qemu-devel] [PULL 0/3] vfio updates 2019-06-13
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

On Thu, 13 Jun 2019 at 22:41, Alex Williamson
<alex.williamson@redhat.com> wrote:
>
> The following changes since commit 650a379d505bf558bcb41124bc6c951a76cbc113:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20190613-1' into staging (2019-06-13 15:16:39 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/awilliam/qemu-vfio.git tags/vfio-updates-20190613.0
>
> for you to fetch changes up to 201a733145751aa691e7e3b9c0f263f0c92db0c5:
>
>   vfio/common: Introduce vfio_set_irq_signaling helper (2019-06-13 09:57:37 -0600)
>
> ----------------------------------------------------------------
> VFIO updates 2019-06-13
>
>  - Hide resizable BAR capability to prevent false guest resizing
>    (Alex Williamson)
>
>  - Allow relocation to fix bogus MSI-X hardware (Alex Williamson)
>
>  - Condense IRQ setup into a common helper (Eric Auger)


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

