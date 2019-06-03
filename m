Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0FF8C28CC6
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 09:59:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD21328059
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 09:59:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bSRj9if0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD21328059
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60723 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXjkT-0000yR-Qj
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 05:59:25 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60423)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hXjjK-0000NZ-JT
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 05:58:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hXjjJ-0002xc-Fl
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 05:58:14 -0400
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e]:43678)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hXjjJ-0002wO-7x
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 05:58:13 -0400
Received: by mail-oi1-x22e.google.com with SMTP id w79so3267658oif.10
	for <qemu-devel@nongnu.org>; Mon, 03 Jun 2019 02:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=+DOjZn3DUvPtUwHGROfUP4M41jw+silH6XPJFz8J7To=;
	b=bSRj9if0drPCsAy7f+c6Kn1o3d48ZEib53AX5PEPY+fNWOn+B2INQQzxzR06QLSroP
	Gw6UwLwiDrSfLAVepeXeEIyeg8ywSGu1CWismFEfCGnYIyUG/axFsJc/LAF7DOW+KYHS
	Mgtzg06sova4GFO9waz4TyYEqxPQ6yJXaNUt4kfY/jRSLEIyWn7o4XgYGgXoq8IfBnLW
	BBL00WZ2rUpuzT5/I8W3l2emfbfO0DMhS/8cg1U8/FJ8mE9opXAWqsO2Oat9AcT1sbhj
	eaXkeY7knlqkk7ueRbYNjWp7UV4wq7IjO1P85S0GwsbD/WU2EUbCb8EpdzNJbwm7sNse
	4jXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=+DOjZn3DUvPtUwHGROfUP4M41jw+silH6XPJFz8J7To=;
	b=RToLdNBxyRpOdx796OIuLr/F5nkkx9dkFF5cagd6MNpzZEEcsbP1UpT8JXkp42RhOp
	DXoksXyxjKhXaom8Y+U1dQjPbi9LJcTL/WYKuiT++fYQrL51yHpEgCgopWVzJk6NLA3B
	IwaFSgRVavYX6vkQllXdS+55/AKVYSuISqUR6gq+xmIqV+Bl9WwMSsqjazcbhyCZqjZ3
	mqGvHSEDjg9gl+d5lmZ48BwmqtmqT99nbn3xGhpmWGSuDmqqlblu3BwQ5qZ1ezkkLH20
	4/CYVn+wWcp+pzZwa56O9a5NsVanz0C/Y7/c8tL+1BwcILR8Rtn6edmjMTGvxGyyo6l0
	0iAA==
X-Gm-Message-State: APjAAAWWU9NvaQk2nUM/zEqxAjVqEpIY1uAfUZGbKgVapYmmN2WOu0zw
	vIl+ABObOC6nF08NIbpTbjiNJEwlakvZoTPkH0GjMg==
X-Google-Smtp-Source: APXvYqyyAQFOUiMsIjeMQhUrNphi0PzAS4qskx0EuS0VGk3f8Fcw9BbI7YUycPcKDXsh7BXX5cwZrWySwFfGP40Gm5k=
X-Received: by 2002:aca:845:: with SMTP id 66mr414065oii.163.1559555891977;
	Mon, 03 Jun 2019 02:58:11 -0700 (PDT)
MIME-Version: 1.0
References: <1559413846-4402-1-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1559413846-4402-1-git-send-email-aleksandar.markovic@rt-rk.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 3 Jun 2019 10:58:00 +0100
Message-ID: <CAFEAcA-hG3dkR04=PdvnEEoSrPgiqbUJrWE52hTwvgkzN_eFBw@mail.gmail.com>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::22e
Subject: Re: [Qemu-devel] [PULL 0/8] MIPS queue for June 1st, 2019
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
	Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 1 Jun 2019 at 19:30, Aleksandar Markovic
<aleksandar.markovic@rt-rk.com> wrote:
>
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>
> The following changes since commit 60905286cb5150de854e08279bca7dfc4b549e91:
>
>   Merge remote-tracking branch 'remotes/dgibson/tags/ppc-for-4.1-20190529' into staging (2019-05-30 15:08:00 +0100)
>
> are available in the git repository at:
>
>   https://github.com/AMarkovic/qemu tags/mips-queue-jun-1-2019
>
> for you to fetch changes up to 0df911fd7f482b796c9f10aa8e086fb3fb9f0f18:
>
>   target/mips: Improve performance of certain MSA instructions (2019-06-01 20:20:20 +0200)
>
> ----------------------------------------------------------------
>
> MIPS queue for June 1st, 2019
>
> Notes:
>
>   - two "checkpatch" warnings about updating MAINTAINERS on adding
>       new files can and should be ignored
>   - on my tests system, "make check" test test-util-filemonitor
>       fails with message "Unable to add watch - Unable to watch
>       '/tmp/test-util-filemonitor-0CZP2Z': No space left on device",
>       but this seems to be the test bed issue, present both with and
>       without patches from this pull request
>
> Highlights:
>
>   - improvement of performance of some MSA instructions
>   - addition of support for some MMI instructions
>   - cleanup and improvement of MSA TCG tests
>   - cleanup of source code of some MIPS files
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

