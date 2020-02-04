Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2AD6C2D0B1
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 13:14:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 867242084E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 13:14:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y85CEj7p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 867242084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyy2U-0005TO-Mw
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 08:14:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42463)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iyy1V-0004es-TR
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 08:13:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iyy1U-0006O7-FR
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 08:13:49 -0500
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329]:36087)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iyy1U-0006Id-8s
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 08:13:48 -0500
Received: by mail-ot1-x329.google.com with SMTP id j20so8572066otq.3
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2020 05:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ioczTrzUy7es6L9+6NxLgeoK51qQNCoCq9U/TQ9Fe3k=;
 b=Y85CEj7pPwUCXBa7YcTInWpiTNyPDZ4aOBZ8Ib41ubLDKePbrKk+Kufk2mJnjAN3rU
 zSdgQtAvYmH6XKGun8xRKyj2zAHgZumP0urU4CecI6FHp4kXgQGNm4GZS2aEwZY9+ZQd
 EqmsQLI+TMg+Y1GUjRKBIRzMukixnET/e57wEo5ZAhebg580CfBKbFrhsrHTvs4G+S4I
 HLF/4ydtUIEcPDslt3Xmy2mfrdeRPiRCOivGawlBximM5zXJY+9nfqW6pZ6ouKzB87cu
 mPZm2ziDg+KgErKaG04zN3/3hYsOjR+zsmZ6Bk0aSuaXnRFCCMiCKU78OiOcWKhAJblK
 rBAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ioczTrzUy7es6L9+6NxLgeoK51qQNCoCq9U/TQ9Fe3k=;
 b=cMBZDhHHzSvg8XihbF6Ac2HMy9yNaQC2qldDEOdZ54GuPpEazWAu8vAuOTZLf0Tt2n
 94Qd8BRFgwkVNFLsVtDEqMMLp4Pn53F5pzIUvjKgbn3EIS1Eht41b5tYUGQzEGpVs7OX
 oj8oqBQGjFbMUHAR/Ud+ODJX5UtQPk0nPbppxFcx6oobFJ9iDpBzVoIGFGtCRdw2LoZO
 q9Yx8v6Rcnpy+/NvEmXNhsVFsVY9Oj8R4gxBrYRQpovtWTqrXOTwfuQ6QTYaFb7GCA/k
 uU/KEeGSfSwA3CuBxnhRBLn0TOFeNcqeKV3Hl9HkvKx1ZC+pqhQoNl1WaqoRqzFE3/gE
 S6Iw==
X-Gm-Message-State: APjAAAVzUTUGtA95OTfsguzo8sZ3FC+IhJzkoiJl5dVI3exfT97tR88W
 duFgHJqtBE001/oRRf1rv69q8oeEJrKPY8FgjzZcLg==
X-Google-Smtp-Source: APXvYqxzzuloH8bI1PGTLH6sv4naqGyPgPEKLLDFbpf0AOvbnM9i/M9br2yCEG8ED4v4+HokPyMQNXWwi3hA8biicCM=
X-Received: by 2002:a05:6830:184:: with SMTP id
 q4mr22357833ota.232.1580822026969; 
 Tue, 04 Feb 2020 05:13:46 -0800 (PST)
MIME-Version: 1.0
References: <mailman.343.1580584897.2411.qemu-devel@nongnu.org>
 <CAKyx-3NZ9Tne+WKkA7wAtyFqZ6roN_gS7rF59ZRjECCkx0qKaQ@mail.gmail.com>
 <CAFEAcA8c6_ESiGCY5somH7LiDYGhW37QCAJDAUZ545b+VDoJSQ@mail.gmail.com>
 <15653420.4VsaQd57cB@silver>
In-Reply-To: <15653420.4VsaQd57cB@silver>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 4 Feb 2020 13:13:35 +0000
Message-ID: <CAFEAcA9VnQCG3r28BOLr_qXLRM2V68r3oK4ZfY9+bVz2j1oSyA@mail.gmail.com>
Subject: Re: [PATCH] ui/cocoa: Drop workarounds for pre-10.12 OSX
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::329
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
Cc: G 3 <programmingkidx@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 4 Feb 2020 at 13:03, Christian Schoenebeck
<qemu_oss@crudebyte.com> wrote:
> Not that I really care, but I also wonder whether that would be an appropriate
> action to remove this code, as it does not seem to impose anything negative to
> retain it.

Dead code is always a maintenance burden, even if it's not a very
large one. It means that somebody reading the code and working
on it has to think "maybe I need to do something to cater for these older
versions in my new feature I'm working on, maybe I need to test on
older versions" when they don't. It makes code harder to read when
it's got a bunch of ifdefs in it.

> > The rationale is in the commit message -- QEMU *already* does not
> > build on 10.11, and it has not done so for more than six months, and
> > none of these Mac users has submitted a patch to try to fix it.
>
> How about handling this with an error message at configure stage instead?
> Removing this code does not increase the chance for somebody going to fix
> pre-10.12 support.

But is anybody actually going to fix pre-10.12 support? They've
had six months so far... If we had a good sized body of developers
taking active care of how well QEMU on OSX works, I would be
entirely happy for them to decide amongst themselves what they
thought was a reasonable version support policy for OSX. But
we just don't.

I wouldn't object to a configure check if anybody wanted to write
a patch to add one.

> > "Last two versions only" is our support policy for OSX for a reason,
> > and the reason is that there just aren't very many people running
> > OSX and actively working on QEMU. Of those, even fewer will
> > be still running OSX versions that are no longer being supported
> > for security fixes by Apple.
>
> Apple currently seems to maintain 4 macOS release branches with security fixes
> (10.15.x, 10.14.x, 10.13.x, 10.12.x):
> https://en.wikipedia.org/wiki/MacOS_Sierra#Release_history

Indeed, and none of those is the 10.11-and-earlier that this patch
drops attempts to cater for. The patch does still keep 10.12 and
10.13 support alive, even though it's not strictly required by
our support policy, because building for those host versions does
in practice still work.

thanks
-- PMM

