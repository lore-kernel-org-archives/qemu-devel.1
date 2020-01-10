Return-Path: <SRS0=GavZ=27=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ACF5C33CA2
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 11:21:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04D8F20721
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 11:21:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ofma9DtH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04D8F20721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44274 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipsLi-0003dl-7F
	for qemu-devel@archiver.kernel.org; Fri, 10 Jan 2020 06:21:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54354)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ipsKo-0002t3-9I
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 06:20:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ipsKn-0007ZU-7a
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 06:20:10 -0500
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330]:42336)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ipsKm-0007UV-2j
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 06:20:09 -0500
Received: by mail-ot1-x330.google.com with SMTP id 66so1578147otd.9
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2020 03:20:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=eiM3+1YOwuiWsggMJZl+NjDL//m/6HDAwVALjt3hjiY=;
 b=ofma9DtHjnwJBqzr9WGIMHx5sih0X3FsDYqVxSrGBcgve68fqJt9BkXA9AyAedbjQz
 nePnOI2rAFkuNkrJ2X8/vdUyUZEyFK30tuyldnT75pfnGWGQNjbKKbmNGLSJvulPR+MN
 HEieuhYtySQJEoceX+NIpG94b78XvUoUUFUWuuC/COzuLKbfmkpL/LQpSS8UkkWg6MPK
 UJ0y5R0tznZ18xQoKLLecBkgsssA+np/0iu9rqNzw/zfjG2U2oU7t/Ya7QOwX8zGCKul
 GDXuLTf4JT1jENJ5J0HBGxg1dLfakX8MFTxjyJUL3xpPvglzNfZVOIx3ckIRU8bshbQ+
 6P0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=eiM3+1YOwuiWsggMJZl+NjDL//m/6HDAwVALjt3hjiY=;
 b=h3jVDbtzGlV7CLa4UaMwtNjx0dgrgVjDdeS68XR3QY4gj+GD84xkxz8NwWNeKzwfRS
 60kBOn3XVdm5jMZ8rDnLuvljOcmA1lfTmOLMv0WWwAGzhLcFEKsKnQc5v3si+gUGrDkC
 WMDeDGbtrM2BDE6MEESX3vvU6w6E4cRuGQ0W2NooUKOp5fU8UPY3NE2HHtC2qttDkfi+
 mGhYSCSQdrqKg/kfRMTvhfTCoNVd/V7w6Hy+Lbpgh2sqsmy9yKyHI+8CNCxVespaXZQQ
 uQIPJhTSiOu8rm5pgxrmAr1BBH9g9LD9PXDa0RLejgJd9Qy1RUuCSoBeIEpjcoiowcht
 tpOA==
X-Gm-Message-State: APjAAAX9IEeBnT2JgX5HXocA6BaCRzDwvv3s5cGRVJMSoBzqBUfVy43Z
 nTaxl9imdWhh+p6I6NEYiwAOF5MD4SD6lXXWmlCnqA==
X-Google-Smtp-Source: APXvYqyqSH9YXDQr/401ZW7dBTVFAUznRd9kz3CycM3T548KFkxTe2E3w+tLhnDp5VTjW8aCK8fFyB755rBCozatNLQ=
X-Received: by 2002:a05:6830:184:: with SMTP id
 q4mr2190399ota.232.1578655205927; 
 Fri, 10 Jan 2020 03:20:05 -0800 (PST)
MIME-Version: 1.0
References: <20200107190802.2257-1-thuth@redhat.com>
In-Reply-To: <20200107190802.2257-1-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 Jan 2020 11:19:55 +0000
Message-ID: <CAFEAcA8QODFux83esDryjEe9yYOejR4TA3UoD_vHURJx-REzAA@mail.gmail.com>
Subject: Re: [PULL 0/8] qtests and docs
To: Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::330
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 7 Jan 2020 at 19:08, Thomas Huth <thuth@redhat.com> wrote:
>
>  Hi!
>
> The following changes since commit f4d8cf148e43d942ef1202071e0cd66ce40322e0:
>
>   Merge remote-tracking branch 'remotes/maxreitz/tags/pull-block-2020-01-06' into staging (2020-01-06 17:44:22 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/huth/qemu.git tags/pull-request-2020-01-07
>
> for you to fetch changes up to 2cf30f8ecb8b64cc5ccaf77244570e7def8075a5:
>
>   docs: build an index page for the HTML docs (2020-01-07 19:48:30 +0100)
>
> ----------------------------------------------------------------
> * Move qtests into a separate directory
> * Build index.html for docs
> ----------------------------------------------------------------

Conflict in tests/Makefile.include, too big for me to easily
see the right resolution. Can you fix up and resend, please?

thanks
-- PMM

