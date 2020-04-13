Return-Path: <SRS0=kd+i=55=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B390AC2BA19
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 12:14:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B5F2206DA
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 12:14:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QCQYcSTB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B5F2206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jNxyo-0007m9-L1
	for qemu-devel@archiver.kernel.org; Mon, 13 Apr 2020 08:14:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35893)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jNxxw-00074G-RS
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 08:13:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jNxxu-0002Ae-Cq
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 08:13:27 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:45468)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jNxxu-00029I-8Y
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 08:13:26 -0400
Received: by mail-oi1-x243.google.com with SMTP id k133so6460980oih.12
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2020 05:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=olI+YPD6mi92z78Q81KvS8X94md8O4xm5vOjWV+LC/w=;
 b=QCQYcSTBYwnLh2l5hI9KIjwQiuM1IW/dDwF9tlXJcadkbYf2qjwlWeIh7teReG4vXT
 r4SLxb08ABaaYcyQ5ZmnGO5MEwSf2x3GQP8gS/Pg4p4DDF2PYIQGgrbpjsEaMugM1AfJ
 zZ2ql4Kq7gt4599SxhXtmpPb941UsKaOHsfzynIZtp5pIjwSOYVePGRMS9S7vlidjREt
 nG1+MRVfVToa9XYH+MrUiIHGQbbJmGq/zf0e+OIRiZL2Df+MiFlAstXDlkLd3mvImBov
 kRvLL0ODHR9wVstjARejjmQH79JLFriCYgxpyfl9ZgKxiNl2kYFzmVPTFxGi35LjXCik
 bVvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=olI+YPD6mi92z78Q81KvS8X94md8O4xm5vOjWV+LC/w=;
 b=DKkVcZeX7P6WomPz3m61wNG1x9fiFQBSIKdMebb9RTra/8w4EWcAPt/zNPy+jWHbvj
 xZxn08ZfyodTPU3zsL/PcqscqheyRWLJ/3/tdk6wyyCs6CsdZu/bZdNtwGBDXvMWU7zn
 Nv/XHDRCV5yT9LgZUB1VxYOSZeXoSNA42BE08UTvR5m8Bks0cDY7IbQt/+blXcIbsYWe
 2EhAcu2SI5QqGhyE5ydUs+nTdkw0euq+86wTgvzBq7H3HG5lr3EQQnmnRV0eQsF6i5c2
 C0rgkPBIEir+uetlm2KrKDHSR8+9d9XPBeH9TvyYhoVv+JkzijhtfnPCmwRnTdJ/YZ0I
 QjMw==
X-Gm-Message-State: AGi0PuYa+JwaVlJbI+kAoVxAFcjvmVk/krI4FOBTNubJsIqWC9duz59J
 DgTLLi5jeLFwiacA7p1FKo+2FdFAYswyKII/MLnXJAZVvBw=
X-Google-Smtp-Source: APiQypKIH4qKf22X1iODAiPXmUzJh8t+L8giC0GXB1dsd6tyBAdvJ85tXqKAEX8xUHfaoCaxtTJa9/AwE09g42UNunI=
X-Received: by 2002:aca:f3c2:: with SMTP id r185mr523691oih.163.1586780004131; 
 Mon, 13 Apr 2020 05:13:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200319193323.2038-1-peter.maydell@linaro.org>
In-Reply-To: <20200319193323.2038-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 13 Apr 2020 13:13:12 +0100
Message-ID: <CAFEAcA_PJPm+CciSEhXt+JMV+P55EqHYd4S8ehBC6HYqzJ_ZBQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] Automation of Coverity Scan uploads (via Docker)
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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
Cc: Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

What's your view on this series, Paolo? Personally I'd like
to put it into master, because at least then we have something
that we can do Coverity runs on, whereas AIUI at the moment
we don't. But I'd rather not put it in after rc3, which is
tomorrow...

thanks
-- PMM

On Thu, 19 Mar 2020 at 19:33, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> v1 of this series was over a year ago:
> https://patchew.org/QEMU/20181113184641.4492-1-peter.maydell@linaro.org/
>
> I dusted it off and fixed some stuff because Paolo reports that the
> machine he was previously using for uploads can't run the Coverity
> tools any more.
>
> The first four patches are fixes for problems that cause the Coverity
> tool not to be able to scan everything.  The first one in particular
> meant that every compilation unit failed, which would block uploads.
> The other 3 would reduce the scan coverage but weren't fatal.  (The
> only remaining warnings in the log are where Coverity complains about
> asm intrinsics system headers.)
>
> With these scripts you can do an upload with
> COVERITY_TOKEN=nnnnnnnnn ./scripts/coverity-scan/run-coverity-scan --docker
> (where nnnnnnnn is the project's secret token which admins can
> get from the Coverity web UI).
>
> I did in fact do an upload to test it, so the currently visible
> results on the website are the result of a scan on ce73691e258 plus
> this series.
>
> The new upload has +112 defects, which is quite a lot, but I don't
> think it's so many that it is "defects we rejected as false positives
> coming back again"; my guess is a combination of the fixes in the
> first 4 patches increasing coverage plus we haven't run a test in a
> while plus maybe the script has some more config options enabled that
> Paolo's box did not.  (In the web UI defects that were dismissed as
> FPs seem still to be considered present-but-dismissed, so I think
> that's OK.)
>
> Not much has changed since v1; I didn't get very much feedback
> the first time around[*]. Docker still seems to do the "download
> the Coverity tools" part more often than I expect. On the other
> hand "actually automated with a script in the tree" beats "not
> automated and currently broken" so maybe this patchset as it
> stands is good enough, given that basically 1 or 2 people ever
> will be running the script ?
>
> [*] Eric will note that yes, the script still uses set -e.
>
> (Like v1 this doesn't try to tie it into Travis, but we could
> in theory do that some day, or have some other automated once
> a week run of the script.)
>
> thanks
> -- PMM
>
> Peter Maydell (6):
>   osdep.h: Drop no-longer-needed Coverity workarounds
>   thread.h: Fix Coverity version of qemu_cond_timedwait()
>   thread.h: Remove trailing semicolons from Coverity qemu_mutex_lock()
>     etc
>   linux-user/flatload.c: Use "" for include of QEMU header target_flat.h
>   scripts/run-coverity-scan: Script to run Coverity Scan build
>   scripts/coverity-scan: Add Docker support
>
>  include/qemu/osdep.h                       |  14 -
>  include/qemu/thread.h                      |  12 +-
>  linux-user/flatload.c                      |   2 +-
>  MAINTAINERS                                |   5 +
>  scripts/coverity-scan/coverity-scan.docker | 131 +++++++
>  scripts/coverity-scan/run-coverity-scan    | 401 +++++++++++++++++++++
>  6 files changed, 544 insertions(+), 21 deletions(-)
>  create mode 100644 scripts/coverity-scan/coverity-scan.docker
>  create mode 100755 scripts/coverity-scan/run-coverity-scan
>
> --
> 2.20.1

