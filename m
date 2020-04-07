Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D64ACC2BABC
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 09:12:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2552206F7
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 09:12:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="DhFZdMeS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2552206F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLkH9-0007dK-N5
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 05:12:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52212)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <joel.stan@gmail.com>) id 1jLjrT-0005Pk-Sg
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 04:45:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <joel.stan@gmail.com>) id 1jLjrN-0001IS-CM
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 04:45:35 -0400
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742]:34363)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <joel.stan@gmail.com>) id 1jLjrL-0001Gv-9j
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 04:45:27 -0400
Received: by mail-qk1-x742.google.com with SMTP id i186so863404qke.1
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2020 01:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ydEtRGAkc0YXG55b5Np4abx2y7Vaj86FY6hLk8OgnIY=;
 b=DhFZdMeSFLF8XJhhtq4LoDGLY1AiQG+Wr36CsFlBOyboisz/BMFmEYa9RRfKctWWo6
 wwL1jO3cMFAcr9oNYFm3I2kgdHqoqT6Jp6YO72+mJVShgFuOLf9nVjai1yzzSRlGmt/h
 cVdCvibx0WCksdN3oI6+dUaYyTxlpL6I7tAYo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ydEtRGAkc0YXG55b5Np4abx2y7Vaj86FY6hLk8OgnIY=;
 b=pwXjUnQVlmz8Lg1xpV78/V/00dn6a8q0MeZo2claU86oeTq5+185+X7W+G0XX63vJP
 1fnZPquBq79oSA0vag1/VE7+hDMGiJnbI26G1+Dapko88QYHRK9HEekQ6ClJV5BXrZHB
 uFgH8OyYt5GLZymdy3OOyUG+OP6UP/wXHhjs4nQVZpJxIqhIb7hIlZJMHVugaDOTeTPU
 qdSQ6F0t7Q6Poe7ynDaeoaB2Chs28xdZVahOV9QJKtcZrK8QVtmj8qUYiwR+R2Agwpul
 tMtBwEaA6NUpFB55ecS0licuRVQXOg+2FZxBuQCBwxQTuPFvKf1hobH6Yt8F2hNXot9c
 pgZA==
X-Gm-Message-State: AGi0PuZv5OfzdmXMu4AT0TuRO+rJFfahgt2hZCjACBJoEGMg77hGvsVG
 NKKfPEkTCv7wKGgZ0OzlKdvnbT8IhSFWZ1K6kzI=
X-Google-Smtp-Source: APiQypIcVsd5NL5YR6AIW4PXc2qfRwJHXD1yJGfeQDlfRHahgDiUMKdbq+pJ+dDRdQBKESm0BRWNeZeyGG9j3Uc70I4=
X-Received: by 2002:a37:a84b:: with SMTP id r72mr1098230qke.414.1586249126069; 
 Tue, 07 Apr 2020 01:45:26 -0700 (PDT)
MIME-Version: 1.0
References: <0b02fe788de99120894f87f6d5c60e15d6a75d85.1586213450.git.dirty@apple.com>
 <CAFEAcA9FSVzxwudyaDoCty8B+Up33caM20qytLNO7HAXWmcwtg@mail.gmail.com>
In-Reply-To: <CAFEAcA9FSVzxwudyaDoCty8B+Up33caM20qytLNO7HAXWmcwtg@mail.gmail.com>
From: Joel Stanley <joel@jms.id.au>
Date: Tue, 7 Apr 2020 08:45:14 +0000
Message-ID: <CACPK8Xc3mpoakAqq2_wccCH6_2i+V4NB61CmdxtMecJ4ejzgmQ@mail.gmail.com>
Subject: Re: [PATCH v1] nrf51: Fix last GPIO CNF address
To: Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::742
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
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Cameron Esfahani <dirty@apple.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 7 Apr 2020 at 08:41, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Mon, 6 Apr 2020 at 23:55, Cameron Esfahani <dirty@apple.com> wrote:
> >
> > NRF51_GPIO_REG_CNF_END doesn't actually refer to the start of the last
> > valid CNF register: it's referring to the last byte of the last valid
> > CNF register.
> >
> > This hasn't been a problem up to now, as current implementation in
> > memory.c turns an unaligned 4-byte read from 0x77f to a single byte read
> > and the qtest only looks at the least-significant byte of the register.
> >
> > But, when running with Cedric Le Goater's <clg@kaod.org> pending fix for
> > unaligned accesses in memory.c, the qtest breaks.
>
> Do you have a link to this patch, please? I had a quick search through
> my mailing list articles but couldn't see anything obviously relevant.

There is a reference in this thread:

https://lore.kernel.org/qemu-devel/dd8fc1f7-56d9-4d9f-96a4-0fdcafdc8f55@www.fastmail.com/

The patch is here:

https://lore.kernel.org/qemu-devel/20170630030058.28943-1-andrew@aj.id.au/

