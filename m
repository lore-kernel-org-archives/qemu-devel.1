Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4A2EC10F14
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 11:54:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACB572171F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 11:54:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P7HnDagJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACB572171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34761 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEukr-00024D-Qr
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 07:54:01 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60027)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hEujx-0001dK-7h
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 07:53:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hEujw-0007iU-8V
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 07:53:05 -0400
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233]:44956)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hEuju-0007g0-8Y
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 07:53:02 -0400
Received: by mail-oi1-x233.google.com with SMTP id i21so7664835oib.11
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 04:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=C5nRiY3g2w+Ns811rzbDVM3FlZ5SR/EHAZPNFjhL//c=;
	b=P7HnDagJTns/lRRldQiN9/MjNdOiue5s5OUmM20WDWyBMez5zuBairFA+nWV+gDq2D
	ysqgJtUwnhHcT7zs1dNDDWFBuQx+djru1LJHbl9zPWpu5xrQMZlk3jSLTsXhdl4COboj
	pIaVpPcOiAcKehYAaognzi3Vxwh//4T9XQNlD7XyZ+7MbbRxNOH6CLAdhP1hvJZcnehG
	emtCxc1+C+sQ1aKMu3Oj6/3itgP07WBKew5PeXp4MaWr9H8BHQ8MEJeQTa7ns7K5NtBE
	SCz8CK30HXc8OIMIdUk+KE0wPisqN7XaUmudg5qXw95PZXOYiTtIsjzERpfb/06rEgIT
	g9DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=C5nRiY3g2w+Ns811rzbDVM3FlZ5SR/EHAZPNFjhL//c=;
	b=uaLVeWubdTRAoRrLq6bDc7uyaF2hS1KQ8qEaP6MJ+U0c4akUft97ZOVHXGnRdWNnoj
	4fvtufpGrQVhSEMa4U5yrYFj6ukd9RNhPRFydtsHXDybpZbTTg23ixwBvv3s5vVrGX4b
	1t21dSA6oDnOA6UuCGoEYtoHzvJfzJndTZ/QSbfaqZC2qIDNiUp4IBZIIeofBrMjGe0v
	UrKEsA71TJhsjofRw7yoBLmhi6CyrAPYa2DrjqPN1w7YFP8AeHrYrBSRbjvBTo8DRGhv
	F6MoOlnHbup0wJhni2PGeYKSzvbQJBiT64bdTi/6tzxacNm0SkLBPHl8q+wOhUaHOx+Q
	3B4A==
X-Gm-Message-State: APjAAAWV4XeOnCdgoca4+2LHvmI8pU0wLlYrIlfxGUN4T9FyHM8gMXEi
	wZhbou78WX19en+zbtCQs9Y1zyIwuQc2GQH0HzZYQg==
X-Google-Smtp-Source: APXvYqy4lerzuP2KQTbJC4cwXwyI1BNBBT0bUwjsondBe4a3+RGwELqoi1qZuf6xnl5FL+YJKz8GTAP//RAC/v/02Mc=
X-Received: by 2002:aca:4c88:: with SMTP id z130mr9834346oia.170.1555069979489;
	Fri, 12 Apr 2019 04:52:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190412113730.28828-1-otubo@redhat.com>
In-Reply-To: <20190412113730.28828-1-otubo@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 12 Apr 2019 12:52:48 +0100
Message-ID:
 <CAFEAcA9k=rnQtJXsQ7D4EM6HeSnpJEyBHMTRp4SFb0_G7r+7uA@mail.gmail.com>
To: Eduardo Otubo <otubo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::233
Subject: Re: [Qemu-devel] [PULL 0/1] seccomp branch queue
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Helge Deller <deller@gmx.de>,
	QEMU Developers <qemu-devel@nongnu.org>,
	=?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190412115248.Xbog8WW9dA-F1-B-eIM10ZwcQVNzGtttxcnJrJ1Y5X4@z>

On Fri, 12 Apr 2019 at 12:37, Eduardo Otubo <otubo@redhat.com> wrote:
>
> The following changes since commit 532cc6da74ec25b5ba6893b5757c977d54582949:
>
>   Update version for v4.0.0-rc3 release (2019-04-10 15:38:59 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/otubo/qemu.git tags/pull-seccomp-20190412
>
> for you to fetch changes up to ee352b53b3e49ba9621149f9de7279a5cadd606c:
>
>   configure: Relax check for libseccomp (2019-04-12 13:30:40 +0200)
>
> ----------------------------------------------------------------
> pull-seccomp-20190412
>
> ----------------------------------------------------------------
> Helge Deller (1):
>       configure: Relax check for libseccomp

Is this really release critical? If you're sending pull
requests for rc3/rc4 it is extremely helpful if you can
give the justification for why they need to go into this
release. (As it happens we're going to need an rc4, but
I want to keep the set of changes in it to a minimum.)

thanks
-- PMM

