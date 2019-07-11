Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57766C74A4B
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 11:42:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24B1F208E4
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 11:42:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CEqSRnHZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24B1F208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlXSl-0002rK-UW
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 07:42:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38262)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hlXS0-0002PS-AK
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 07:41:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hlXRw-0008JG-GY
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 07:41:22 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b]:36192)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hlXRu-0008Bf-Di
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 07:41:18 -0400
Received: by mail-ot1-x32b.google.com with SMTP id r6so5517669oti.3
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2019 04:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6/ihvuG+Zz2knpTKa3HCbLWQcxpbQDC96GCD7P4u6Y0=;
 b=CEqSRnHZMl5hYYkCLLgBtdldODBB3zkXuQ6Yh6KWtkBeLP7DZ0TS16tCkKh0zMkNx7
 Un4T4+EpPmz9AnnF+WxFm5fZiHXBFS9E6ibSyI6SEgxMljKWIfGPPw3DPV/9aPsKDPIY
 /Li4JFIA7eb6R4Vf8yVS2ni4/lpQFo0wslGfgWPy9lYAtRTo8AQ9Hq/OIydJW6wXe7Nu
 KcbX+M+KhIVkrsDkCXNn1+n0P2LYyEKkSA/uTh5XlaV2lJhlJIRspUliFdYfloMK381W
 kLRWc++ZLRTDVPT3EDd0ufPxNa5UA3xu5wCAafEquwuU0+DpIXZ1zbXrfEfPBas0pjRJ
 GuMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6/ihvuG+Zz2knpTKa3HCbLWQcxpbQDC96GCD7P4u6Y0=;
 b=PAnRVpTjS9BTLo+7qJcxxTck+niFkHSQKtuZ6+Tz++/ViIqpX+WT4M6uKjwVlZdlEJ
 ee7Xirf4z3iYyRJxV7UiUu16Q/QcdrmLP58gfBbopXscFdgWhu7HM7GYJD9XN4fZ8JLB
 2XElrJqOPGaNBJyEX88Q/9ZZ7Vt/OxeKD72TSd8V688FRrsDZMv0rMvCR5lbU9BotxUn
 8tqFOtmsfnjD6WbReyzhe1Fm3MCQsMkNuW6Nx1NyjxaWZLZENvniyAzVyMgBwvt1jssl
 6ZtwAGKtquy+52JSANpmED1F8B3qlbXL+PN0WRtH9bVMda9ZllqpZIhtPkZgqT3ND0d+
 Xo7g==
X-Gm-Message-State: APjAAAVDfNysDF+FbtnSKghe3IuqjuseTyDoezUQLtPN4L5kHyMyAoqK
 RoeDF1Q0eBWUtdjIrjgIzy6FwHKZuyZ7d2SuFiAkFQ==
X-Google-Smtp-Source: APXvYqy0Tb678D01LSWx+o+6Zw78Scs1IqJfTLAPAlqUyks2As5G9ZCR+avslPTzavnk/DdVd5BXCoKYr+hhEZpqOAY=
X-Received: by 2002:a9d:4d81:: with SMTP id u1mr2847957otk.221.1562845268790; 
 Thu, 11 Jul 2019 04:41:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190711104412.31233-1-quintela@redhat.com>
 <c2bfa537-8a5a-86a1-495c-a6c1d0f85dc5@redhat.com>
 <20190711113404.GK3971@work-vm>
In-Reply-To: <20190711113404.GK3971@work-vm>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 11 Jul 2019 12:40:57 +0100
Message-ID: <CAFEAcA_6-F_8OhX4vw7m1sCPrEZfeVjGP25=Cz7nGJOHSXy1kQ@mail.gmail.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32b
Subject: Re: [Qemu-devel] [PULL 00/19] Migration patches
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 kvm-devel <kvm@vger.kernel.org>, Juan Quintela <quintela@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 11 Jul 2019 at 12:34, Dr. David Alan Gilbert
<dgilbert@redhat.com> wrote:
>
> * Paolo Bonzini (pbonzini@redhat.com) wrote:
> > On 11/07/19 12:43, Juan Quintela wrote:
> > > The following changes since commit 6df2cdf44a82426f7a59dcb03f0dd2181ed7fdfa:
> > >
> > >   Update version for v4.1.0-rc0 release (2019-07-09 17:21:53 +0100)
> > >
> > > are available in the Git repository at:
> > >
> > >   https://github.com/juanquintela/qemu.git tags/migration-pull-request
> > >
> > > for you to fetch changes up to 0b47e79b3d04f500b6f3490628905ec5884133df:
> > >
> > >   migration: allow private destination ram with x-ignore-shared (2019-07-11 12:30:40 +0200)
> >
> > Aren't we in hard freeze already?
>
> They were all sent and review-by long before the freeze.
> This pull got stuck though; the original version of the pull was also
> sent before the freeze but some stuff has got added.

This is the sort of detail which it's useful to include in
the pull request cover letter...

thanks
-- PMM

