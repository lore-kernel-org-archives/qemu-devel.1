Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E425BC432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 11:13:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF0C222365
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 11:13:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yfw64s/3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF0C222365
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXNvA-00036h-NT
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 06:13:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35114)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iXNj6-0001Ut-JO
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 06:00:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iXNj4-0002VF-8M
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 06:00:48 -0500
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c]:35799)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iXNj2-0002SU-Fy
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 06:00:44 -0500
Received: by mail-ot1-x32c.google.com with SMTP id c14so13830850oth.2
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2019 03:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=BPAwEzze4OWX7mp2hHZZcLfvaH/xWZaeP3L1aoPNkT0=;
 b=yfw64s/3sBjEgbJRHwYYRTRTPTPRybOs/Sy8WFPLJDjCwONhJWA7Kfa9LzxvuXJ4Ul
 kT4ujVBFPK7VsZbNfMeB2jZvZDZWUva20bIaSeAsmTTijmRBIhEFCQr6AVi0Lj0PI+f2
 /gsQk4jexfFA7JBq8L2gdWB+PW5wICTPZh0EdfsceMt8/FKbA7GxVBpOi53aOijeHg42
 XLtlXboEuyeyK1PoWUs2/YU0r0H+2K9nADB3et1V3v7XFK5sEOq1mkBrm2bVJtm95NcW
 oGepOIVCpoI9QfLGbPiGpkM3AfK/Xtcv+DO6p/mN0H8rA5hyfJYjcN/DHH+wN121RuZo
 yHqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=BPAwEzze4OWX7mp2hHZZcLfvaH/xWZaeP3L1aoPNkT0=;
 b=f7mQt6dSlrzxjiNbW7Z+EOdnVbbaRfOwusphxcP74kMAzKy7c/xS2I5py2EzxqzAP5
 jLCsEhmnFhugEn5DUKbSPBXule9gB3FcKvqIdvHSEQs1zSEScEGrK4tbBGT3+CszUzPO
 XhUmqvQVDKYc3swKqzn/hQLb0PRPb5S9ApZV1f1BnVyKV7Y28/zHi2w9Z0IGsDGwnaS6
 JAB0x/uEXIDqaFd+bgzJmI6BYL/cgD4JL7y0XkIHDnk9gHJRJWfoCpyPyiD5BztdeHgT
 FUCNv8EeCtXIOU/0O6eKLn9Ws6ZChTe9cFzMtDoakjL2B++orhbN7nctfOBPk9kyUeKA
 q2Vg==
X-Gm-Message-State: APjAAAWkr+WVDNT9hNuyiPf3fulKSlf/yN/bu5RoEdCeE2zOayZC/EhP
 u8GnhjRnXGlOZq0aj3Ma2/9NDIUwNf6rOWuovHiiKA==
X-Google-Smtp-Source: APXvYqzIQBOHMIMFZkpmut8f8tHDbBukVB7hPJNZvz2eaqGjaQ8oS+UEUmG2b5MrgrkkDGKOKqfndsZkQiUy6nTcmtg=
X-Received: by 2002:a9d:68cc:: with SMTP id i12mr1389747oto.97.1574247643268; 
 Wed, 20 Nov 2019 03:00:43 -0800 (PST)
MIME-Version: 1.0
References: <1574190388-12605-1-git-send-email-tsimpson@quicinc.com>
 <CAFEAcA8AeTgY+3GaN9ZUi-5XtX5jxhqpdOhr3ixYwouWhQOQ5g@mail.gmail.com>
 <e4a52719-fc16-f94a-fb8d-1a4d9e683ce0@vivier.eu>
 <CAFEAcA-tVh9AMucDL4hgQ3ngFZwu4AThcGyhwjVa-LbG8o8-Lg@mail.gmail.com>
 <05b5c1b4-d1dd-7b82-cdf3-a1425edae499@vivier.eu>
In-Reply-To: <05b5c1b4-d1dd-7b82-cdf3-a1425edae499@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 20 Nov 2019 11:00:32 +0000
Message-ID: <CAFEAcA-mUps0qe9Ak6VjceZBAe=x9cQ3YPhhT9Qmg-c_XpqcDQ@mail.gmail.com>
Subject: Re: [PATCH] Hexagon: Swap SIGRGMAX-1 and SIGRTMIN+1
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32c
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
Cc: Taylor Simpson <tsimpson@quicinc.com>, Riku Voipio <riku.voipio@iki.fi>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 20 Nov 2019 at 10:54, Laurent Vivier <laurent@vivier.eu> wrote:
> I understand your point, and I agree, but not allowing this will block
> the merge of the hexagon target, and I don't see any fix for the
> underlying problem coming soon.
>
> Other targets work without this change, and adding this change breaks
> some user space applications (like go), whereas adding this change for
> hexagon target only will improve the situation for it (with no
> regression, as it doesn't work at all for the moment)

I care more that we should fix things correctly and maintain the
consistency of how our architectures behave than that we are
able to quickly land a target for a fairly minor architecture,
to be honest. If we land hexagon with hacks and workarounds
then we're potentially stuck with that behaviour.

thanks
-- PMM

