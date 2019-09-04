Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89C38C3A5A7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 08:17:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55CEF22CF7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 08:17:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NZyd6wOq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55CEF22CF7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5QTN-0001Ez-CQ
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 04:17:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59643)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i5QSC-0000Lc-Sc
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 04:15:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i5QSB-0005tD-QQ
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 04:15:48 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:46729)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i5QSB-0005t3-Ls
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 04:15:47 -0400
Received: by mail-oi1-x241.google.com with SMTP id t24so15121138oij.13
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2019 01:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=siMdx7oIb4w4/HzCN28oIGpXbSjUOiYzzSNLf+v3JYY=;
 b=NZyd6wOqIr2+6c7gJLrd/ae+ZdY1QofbHcDZZ3zKpV+HUBys67oTxRkDb+bm4n7Trx
 eOwTePO0c8JHvXZIIZ+0jORMyTTp4toJjmG91ahlX9m+L+WVWthopcFc4ylrYvgUprJq
 KILcK19O8ihEP4e6t4vP2ep7pA//NKJK3bIgmU1r2VSqm2OwLdO+mYwVXpy+S5P8YEKn
 W5Wng45sEINqkrXw5X0sepyZ2fgobY2CNLwtpgFfLCQcxJcSjO2FufJP9iwkS9L/t1NA
 6P0DIXic8EJnuAPxtxNXuVpDH//Y3x4negWT30P5xT++pioY3YkScsGXUWsy1XxNfmvN
 we8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=siMdx7oIb4w4/HzCN28oIGpXbSjUOiYzzSNLf+v3JYY=;
 b=FUJ8ohLI2zPXze0jZQOukt+STR+nkHEcSAakKqtpEzrtVASIm2CBuc/IYD4tKU4gf3
 R2uhLpKyYk/OX0JkWLGfURvM6iQSKb9Y+bbeBb4cSnVn6suI/hhkdN8oa8NUCGwcykmX
 +NrDvdB+tIoi1vUnO7i+102czaC18BofK1O8QgkQrGJMZyo4DitTmMkPEAqFQLOxD/V5
 850WuZDa+VOhQukD2vGHd+n4jcMXQjMSeE8MfU+4TEV22hEe1p8pIEfKvaG9uweGD5Xp
 evKQBFEUEtqxrv+ikIk2V3lAdeAV9nZFavdeC7erDzLcGhbO1WlVW8V3PUboC/nWNuTW
 PRRA==
X-Gm-Message-State: APjAAAWB7DZ5+xq82ZZ0YeofQ6jCUKaqfPeh3CncJzsn9drfP4Vd5Og4
 DuT3CyuFT2+u/A0VSkkg9+dJjJApnfaIbNq0tlYjYw==
X-Google-Smtp-Source: APXvYqyVryFJ9by3ESjoMbp4dGrSd54lgUASI9RbewVYarVkFKb8AKdAeDtd9q0ZYDBT+3VqoxHZNgii86wVVj8HR8A=
X-Received: by 2002:aca:4814:: with SMTP id v20mr2483195oia.98.1567584946976; 
 Wed, 04 Sep 2019 01:15:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190903160858.5296-1-richard.henderson@linaro.org>
 <6b27210e-a4b3-a8be-77a1-717e26de1747@ilande.co.uk>
In-Reply-To: <6b27210e-a4b3-a8be-77a1-717e26de1747@ilande.co.uk>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 4 Sep 2019 09:15:36 +0100
Message-ID: <CAFEAcA_FbK-mG0qpeNqCMZekNXf=KBGyH4XK9c0c870WGd2Heg@mail.gmail.com>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
Subject: Re: [Qemu-devel] [PATCH 00/36] tcg patch queue
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 3 Sep 2019 at 18:00, Mark Cave-Ayland
<mark.cave-ayland@ilande.co.uk> wrote:
>
> On 03/09/2019 17:08, Richard Henderson wrote:
>
> > The following changes since commit fec105c2abda8567ec15230429c41429b5ee307c:
> >
> >   Merge remote-tracking branch 'remotes/kraxel/tags/audio-20190828-pull-request' into staging (2019-09-03 14:03:15 +0100)
> >
> > are available in the Git repository at:
> >
> >   https://github.com/rth7680/qemu.git tags/pull-tcg-20190903
> >
> > for you to fetch changes up to c25c283df0f08582df29f1d5d7be1516b851532d:
> >
> >   tcg: Factor out probe_write() logic into probe_access() (2019-09-03 08:34:18 -0700)
> >
> > ----------------------------------------------------------------
> > Allow page table bit to swap endianness.
> > Reorganize watchpoints out of i/o path.
> > Return host address from probe_write / probe_access.

> Is this a pull request rather than just a queue update? I'm just wondering if I
> should wait for this to get merged first before I start testing the
> do_transaction_failed hook patches?

It's a pull -- Richard told me on irc that it was just an error
in the subject line.

thanks
-- PMM

