Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45C68C3B1B1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 17:58:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15FBE24654
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 17:58:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jpjoXt4r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15FBE24654
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2fEM-00035y-9v
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 12:58:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57214)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j2fD2-0000wQ-F3
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 12:57:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j2fD1-00079g-6S
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 12:57:00 -0500
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e]:36943)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j2fD1-00078c-1V
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 12:56:59 -0500
Received: by mail-oi1-x22e.google.com with SMTP id q84so10226109oic.4
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2020 09:56:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=l3UhXmIAe9c3bylhBbfFxpG7Gv6aXN1yo2OcAKmBhqE=;
 b=jpjoXt4rHsFlyuX1UBPgA2NvRAGxSWbt7S5KGnBGUcMHICHA9DLDquh8PrkPh54ooP
 ByxOIfu/kbqBpLmEkwDl5EXi1QKc6gpycISYYqv9GzY1VGIVDpWhzTYrQFn7z+rwoKzf
 onelGdD8GSZqzlZQzmHJKxL2MH1G9WYJapjF5468p8l5GWr7nyihbLln0lp9bCS4TEfV
 mA8CxfnXU5qhZTvR5yPPfbV+BRCwefLzBdDmm679Kdw5Z8WvSXGSchVHVbyWkPN2Y9Mh
 63YFpTG1t38uXz47yLwy5f/UDn3fmoJZ+uNEVFaIDBk8kXU4nvyCIMuRC3ujSrQiImNj
 DM+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=l3UhXmIAe9c3bylhBbfFxpG7Gv6aXN1yo2OcAKmBhqE=;
 b=LcNsTbEfiLJ0JKCvSQu3bPmh7XQOayKIhpkMzrrEkPLcv+yy/y1KjnWypraDa+mVwT
 1OY/E4BiJ5HQ0k62G8zit3aEWVv5JK4jEKFcvp5q7gj9qz+I1UBwaYmsTVPkho9KYnC+
 AP/XQp0JwpA/O30c0oUkL+aSa3DI/hCOzWM3RYvTTqkcX8dq/lYSpTM7xxFWSgrACYcz
 /g81bwRR1h5t2Cp+5DzoQyy7Xhe6IcK4UjVBgTGZWMfQcrjO4rcNJlsW7YxyUGHJmKCe
 L6bCEUBOgt+8XQOOkReFro1oyUhlHij/svwXiSZ1iBOzrOERc/FuvQCBp5SvAB8C1TC+
 Pw7w==
X-Gm-Message-State: APjAAAXxP3/5e94bxapWVMS9EZABdiFXcsdV63R/CzCC0s718d76xABH
 +EonAnWAQOfWGlspi0FASJrWdBtFsSCzu0Yaoz6mdw==
X-Google-Smtp-Source: APXvYqxEoDbaQ99nMVo6OnlbdcI87eCeU6WaTo1fa862cqnDSRbHEVcYK8cRnjTahZlDROhEFeRxl7ZMJqAIxzLMpAI=
X-Received: by 2002:a05:6808:289:: with SMTP id
 z9mr2629887oic.48.1581703018100; 
 Fri, 14 Feb 2020 09:56:58 -0800 (PST)
MIME-Version: 1.0
References: <20200213122108.965455-1-laurent@vivier.eu>
In-Reply-To: <20200213122108.965455-1-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 14 Feb 2020 17:56:47 +0000
Message-ID: <CAFEAcA9gd2nvyCK1vh3kpKV26WFTEjiK-mE-UDO=3hGPegpSfg@mail.gmail.com>
Subject: Re: [PULL 0/5] Linux user for 5.0 patches
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
Cc: Riku Voipio <riku.voipio@iki.fi>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 13 Feb 2020 at 12:22, Laurent Vivier <laurent@vivier.eu> wrote:
>
> The following changes since commit e18e5501d8ac692d32657a3e1ef545b14e72b730:
>
>   Merge remote-tracking branch 'remotes/dgilbert-gitlab/tags/pull-virtiofs-20200210' into staging (2020-02-10 18:09:14 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/vivier/qemu.git tags/linux-user-for-5.0-pull-request
>
> for you to fetch changes up to 6d485a55d0cd8fbb8b4337b298f79ddb0c2a5511:
>
>   linux-user: implement TARGET_SO_PEERSEC (2020-02-12 18:56:45 +0100)
>
> ----------------------------------------------------------------
> Implement TARGET_SO_PEERSEC
> Fix rt signals management
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

