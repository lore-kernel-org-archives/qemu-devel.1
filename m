Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2462CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 12:10:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DB0E20856
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 12:10:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vrV2F/c/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DB0E20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNbwh-00044V-UT
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 08:10:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58667)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iNapo-0003Jr-Kp
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 06:59:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iNapm-0003SD-FX
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 06:59:16 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:35014)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iNapm-0003Rp-9j
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 06:59:14 -0400
Received: by mail-ot1-x344.google.com with SMTP id z6so20271135otb.2
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 03:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=f1rIXJ4RgBb8yXtWhv7cc8+mFfq8pUHr3wHZ+izWI3k=;
 b=vrV2F/c/denb9Jgmjf14SYAgCscNAjn5QT4zBUY6jgEY0cri/J7tpcvrufiFnB0P5V
 g7Gh0mSZHYf7kdUdemVGkpgn/YESi+85pcvwsufNhoOsBV5wbQ+Ae4gFP4aSRRKXY0b8
 X3qO3ISiq+BSPLW0ANywiCDDf77eb4g1rDjupEanDqr8/aI1FBZ1iEBNkRVv5bWZOhWH
 fyJuhqP7ubGeLKu9QGSZmENjHR8C5OH0uOhGixQZYfOaj3+OyCvQHdVF7cmZfZj5huMg
 y533KU0kOf78XuT006xKicvT4qzypcohPxxk8iLRQ+a5BlycC/abZC/7NL7mzjfpwvIL
 VhGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=f1rIXJ4RgBb8yXtWhv7cc8+mFfq8pUHr3wHZ+izWI3k=;
 b=Sg9YE4e7VuHSOQ70ZlmmIYztrsblXGiSroNgDiU7YsP25n99KDpYVNi0JV80eVDIqU
 lU1Y0SRDVHfaVLHKostywpdNeP009XfLoBkrawf9/6AGevOU2eQIFfCZDZ9x/2a1y6fv
 PTViFsbLpyr3sQYut3EWAmAXfo8bf15J/1W6d3DszAsbyig0bEJwcysyVr32YATJ1vyR
 6mOOHSw1MrUahLy9trkU6VXynOyJTdtom6tKcTcoTt9+FrkKBs6dQg+qJ7wIUaAqrwWs
 MegMmQEESjLdQxxOg+Ml03wYBYQvpC0Mp+oHRyt+i4jzp5HhPXxLuAnDZiHbnJsnfGRE
 cU0A==
X-Gm-Message-State: APjAAAXCOOeCFO/BcdftPrOkn7O//9TsQIBki2V7JJPGnC0c2/9/0p9r
 zqkkrgItf1fWpCr5vS8cN4/kHkK1885uGjv10V3YEg==
X-Google-Smtp-Source: APXvYqy01hY1quFy05q+pDPf8igsMV537m8x5ge+fMZ/zLbJRMyFQkkCszmH0iiOGXa2Zp+6Id78W9QFtep8A916A4I=
X-Received: by 2002:a9d:398a:: with SMTP id y10mr10539950otb.97.1571914753323; 
 Thu, 24 Oct 2019 03:59:13 -0700 (PDT)
MIME-Version: 1.0
References: <20191023130455.1347-1-clg@kaod.org>
In-Reply-To: <20191023130455.1347-1-clg@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 24 Oct 2019 11:59:02 +0100
Message-ID: <CAFEAcA85+1ccLRy8RNxh2yri85-ZTJd-uSpGwRgWda7F0vnA2A@mail.gmail.com>
Subject: Re: [PATCH 0/2] hw/gpio: Fix property accessors of the AST2600 GPIO
 1.8V model
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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
Cc: Andrew Jeffery <andrew@aj.id.au>, Rashmica Gupta <rashmica.g@gmail.com>,
 qemu-arm <qemu-arm@nongnu.org>, Joel Stanley <joel@jms.id.au>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 23 Oct 2019 at 14:05, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> Hello,
>
> The property names of AST2600 GPIO 1.8V model are one character bigger
> than the names of the other ASPEED GPIO model. This change increases
> the string buffer size by one and parses the property name with a
> better pattern.
>
> This fixes the QOM test of the ast2600-evb machine under :
>
>   Apple LLVM version 10.0.0 (clang-1000.10.44.4)
>   Target: x86_64-apple-darwin17.7.0
>   Thread model: posix
>   InstalledDir: /Library/Developer/CommandLineTools/usr/bin
>
> And all tests for the AST2600 EVB machine should now pass !

Aha, thanks for finding this bug. In theory the compiler
could have caught it, but it looks like this isn't one of
the things -Wformat/-Wformat-security check for.

Applied to target-arm.next.

thanks
-- PMM

