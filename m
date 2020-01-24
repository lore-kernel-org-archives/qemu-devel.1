Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B08DC2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 12:49:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E91C62075D
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 12:49:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xu9Mytq1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E91C62075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuyPJ-0006RQ-2Z
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 07:49:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53417)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iuyOO-0005Ye-JL
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 07:48:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iuyON-0007X2-AF
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 07:48:56 -0500
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e]:44980)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iuyON-0007Um-3v
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 07:48:55 -0500
Received: by mail-oi1-x22e.google.com with SMTP id d62so1682279oia.11
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2020 04:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=vJHGn4EXEJMZH9lXoT5+6wx0R5q+sH9HaA4vwBzEB74=;
 b=xu9Mytq15cxXhQVUUEIpah7p1aFMhCWTbWJddlfyUexH3W+f6dv4MsLQEO+J46PdYc
 otcXrpdsR3M9sggMXtkxCicePPYG7iW6+7saxaIcEOYcjsNBXKLaTzICtoZfM4F500nX
 Dpw1Q/qFQbI43+h8XXutgAQmHdMLXU3HTs5zBbzaT7JrcQYfcHl0zbsaJg/I6d/4CPcu
 sMPh6YT99Jkzurg2N0bXjVe8e5n85jR87UjAFOPTsbtdd9kapafvr8SslzrDm1q2tHhy
 6F3nqsILxelbXDDz55gbr697+1ehXnJxNzsIDFowUx+7+3Wdg4GvKFvvRUGOVLh44Fyk
 82bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vJHGn4EXEJMZH9lXoT5+6wx0R5q+sH9HaA4vwBzEB74=;
 b=quH62e8p1HAexzrUPl5CG5+YSvlRX3+tPlS/R1/JOURkEoI1DYJ9m9c6nc9ufI6Zce
 e4DFaWcV8i+gK9qEXig/0/gzJKhj6UHZyqTBizhWnMSqi4G0KuUcRCLmREbarhGpzXvu
 r9/qYpeoRzirU8Y54X5j5ss2RDI4BUyuuL/hRv5vFJaOlQjJMWl/D3WoM1FXRw2mLI65
 VbcNqnkK8JBRqjdeur5A7qW0wJY0LMwZ0E+BmNnIqvJO6OwsDNeW1l9LHJdLog4ERUHG
 q53+R9L4CRdaWhdVvyU7LFGdCfdh2zqPLnFPv//M6SsTvpa/iTH72oe39Gtl27Wf/8Pw
 hq3g==
X-Gm-Message-State: APjAAAUmMKZBy6DyPCuHPzEdb2zlDgnSwEGZ3lpbWMI2j8tRXZEbsNbW
 TZezXep/10WyzlgNg+Qq7dlnp6WP2o/blFOTakjIaTWu08Q=
X-Google-Smtp-Source: APXvYqyfV2SyyB3paicc23mPdlnc2ox+8zS/aP6DK7I8iBOpwF90B5/IdQsq1JUGNeYngDD17/CGhCb++ogWGNwEYXw=
X-Received: by 2002:aca:570d:: with SMTP id l13mr1841263oib.146.1579870134025; 
 Fri, 24 Jan 2020 04:48:54 -0800 (PST)
MIME-Version: 1.0
References: <20200107132715.722101-1-laurent@vivier.eu>
 <20200107132715.722101-3-laurent@vivier.eu>
In-Reply-To: <20200107132715.722101-3-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Jan 2020 12:48:43 +0000
Message-ID: <CAFEAcA9pizjyZbNB1mhUTn40nRpzHw=GLMWRtYhra5G-ijDmSA@mail.gmail.com>
Subject: Re: [PULL 2/4] q800: add a block backend to the PRAM
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22e
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

On Tue, 7 Jan 2020 at 14:40, Laurent Vivier <laurent@vivier.eu> wrote:
>
> This allows to save and restore the content of the PRAM.
> It may be useful if we want to check the configuration or to change it.
>
> The backend is added using mtd interface, for instance:
>
>     ... -drive file=pram.img,format=raw,if=mtd ...
>
> where pram.img is the file where the data will be stored, its size must
> be 256 bytes.
>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> Message-Id: <20191219201439.84804-3-laurent@vivier.eu>
> +static void pram_update(MacVIAState *m)
> +{
> +    if (m->blk) {
> +        blk_pwrite(m->blk, 0, m->mos6522_via1.PRAM,
> +                   sizeof(m->mos6522_via1.PRAM), 0);
> +    }
> +}

Hi -- Coverity warns (CID 1412799) that this isn't checking
the return value from blk_pwrite().

thanks
-- PMM

