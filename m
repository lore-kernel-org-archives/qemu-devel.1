Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54080C43331
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 15:06:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D80020658
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 15:06:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xcAR/4Ve"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D80020658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIw02-0001v8-8P
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 11:06:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35139)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jIvzG-0001Mw-8M
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 11:06:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jIvzE-0000e3-QA
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 11:06:01 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:44274)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jIvzE-0000cy-CZ
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 11:06:00 -0400
Received: by mail-oi1-x241.google.com with SMTP id v134so15906951oie.11
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2020 08:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=GCMVfMqJHzqzkP2b8N1LosC+C1vgFqYzpfpgZLqC1v8=;
 b=xcAR/4VeZVX1xFt+F2hz0sWSZcKDmizuzYMs8b4JaUSuPgOIw6AODIizjdgGHcaGIa
 KUZcneXcKzrB8kUuIAftqb4XLfI7/6PQ4NPLISL3nFTO8nE9UEILyFpJnRrJRzC+QoBg
 9VMqyxuZLJmaRete/KcZL8fEJyeMBub7kvR+l2Ix57ovg74+s4XeJYKJFEZcvLoPUdcV
 8fdvJQ0YAim6YtJjgKxe9CsEw/BoPe9Vd/8OJ7b49lmNUJJPA/Kw0PsJHal/Mik5Dj2c
 8CgdU0/+u06YwHADXcFhGIucspnyRtFi7KWTQMx+mYeqUL+8+cJHMeBXpI+2FtMKUj2L
 4gkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=GCMVfMqJHzqzkP2b8N1LosC+C1vgFqYzpfpgZLqC1v8=;
 b=JhOEYd8MqTL+bc0TuH/8lJ0kx1l30WRlvlbkQuGuM0o7DiGpwMEFwHJRUolY1XywHE
 XsIBH5OnIRHuoTKOACcznZ1PYfJGBex45hvmcmVm4AxIvqHrTnaxfJXPPuPzBtxyHqjf
 0tsC5/oQ8dKM9ad/94+E2kXf1mJzTw71nfo7rQmqTATfw9qaL7cOL0URft6FmKvdtQXo
 rXVbw02PydJklsLDfYP0Rf9gXI6SVh/IzJSxvhCik9rjr8nj3JvWL3gctIKXN+QSjDwS
 bTejcqiJeCYS6gZOHnYJaqkz2ZnT4ALADAFtkv57uujASh/S8c+XPWUM6EzWVavPWUq8
 4Dnw==
X-Gm-Message-State: ANhLgQ0GVY72eJjEhV118KOyljp2zFXHluAHsomUjmubNE2wfR63IoTY
 /IYsMDbxcLkSVP60MvExGeOGPGTK+e1fSAlYxx6Ezs0sAa8=
X-Google-Smtp-Source: ADFU+vuUhxCu5yGz9mftfuhD6yy8FlURrSrDtBoh/5si1LG5OXvUeYGK+U5V7/J/g1EYYXEBvdx78Dkj95rx8Wo/+B8=
X-Received: by 2002:a05:6808:64c:: with SMTP id
 z12mr7585368oih.146.1585580758935; 
 Mon, 30 Mar 2020 08:05:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200330133648.22297-1-peter.maydell@linaro.org>
In-Reply-To: <20200330133648.22297-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 30 Mar 2020 16:05:47 +0100
Message-ID: <CAFEAcA_K77eCncRWFhoO0bwNrz=KR=5VZy15CpCVW+nv=wAUsg@mail.gmail.com>
Subject: Re: [PULL 0/6] target-arm queue
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 30 Mar 2020 at 14:36, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> A handful of bugfixes before rc1 tomorrow...
>
> thanks
> -- PMM
>
> The following changes since commit f9fe8450fa7cdc6268e05c93fa258f583f4514b7:
>
>   Merge remote-tracking branch 'remotes/vivier2/tags/linux-user-for-5.0-pull-request' into staging (2020-03-30 11:32:01 +0100)
>
> are available in the Git repository at:
>
>   https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20200330
>
> for you to fetch changes up to 88828bf133b64b7a860c166af3423ef1a47c5d3b:
>
>   target/arm: fix incorrect current EL bug in aarch32 exception emulation (2020-03-30 13:55:32 +0100)
>
> ----------------------------------------------------------------
> target-arm queue:
>  * hw/arm/orangepi: check for potential NULL pointer when calling blk_is_available
>  * hw/misc/allwinner-h3-dramc: enforce 64-bit multiply when calculating row mirror address
>  * docs/conf.py: Raise ConfigError for bad Sphinx Python version
>  * hw/arm/xlnx-zynqmp.c: Avoid memory leak in error-return path
>  * hw/arm/xlnx-zynqmp.c: Add missing error-propagation code
>  * target/arm: fix incorrect current EL bug in aarch32 exception emulation
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

