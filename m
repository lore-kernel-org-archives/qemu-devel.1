Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BB92C3A5A1
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 12:14:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46BE321848
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 12:14:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ox394B3J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46BE321848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0lyx-0008Pl-Fs
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 08:14:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42821)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i0ly9-0007CW-0Q
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 08:13:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i0ly7-0006I3-KT
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 08:13:32 -0400
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332]:40927)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i0ly7-0006HO-El
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 08:13:31 -0400
Received: by mail-ot1-x332.google.com with SMTP id c34so5210369otb.7
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2019 05:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/mkSP4L3OnAKmS0vMJbq/AuYXl4VbpgLC67Rnq0+IP4=;
 b=Ox394B3JZfL63P/s+d3fzZg2JAFQ4jyBKcDBJpwUWXgmRM5aqiFPV6tLaAuLhj4DBi
 o/wzKdXOrtfbIzaY7/Q8QtLm0yieSHcDiIu0Ls9RyahZFPQGWxuxfpSm9wCa0MT7f1s3
 0s/naZF4oZEKvXyMzbIVjS9YTr774yPiX+IS7yegNJZspZvcOrxP14mUGb8/PRorxVaR
 Uk8Z3f24yewo04tKKDUqzT/SoD/WjNdUNCMYBj/uM4iKTjua+50qFHlzI44kzGPoGwHl
 vzrPediDmUUUe0/I+9SHAAWPtxrk/6caKA0Bv2xISDdmBnTHXD7CAQIYdh4eG7hhF83Y
 mzag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/mkSP4L3OnAKmS0vMJbq/AuYXl4VbpgLC67Rnq0+IP4=;
 b=kVX6M5OVHG61JMMK32ou4qc9qE0laPvvYo0mYTzRI0wwhp3gIovb4zug06uYL5rUW0
 Gm4h0cDmO1rhOVrKUt2ygViLQSxI+Yx3vUIhlo5ukAiHzuhwMWCwaL9SZt697S+BhncE
 vWDKJtZcmMZyzzP6xwslNQRiJITGeh2VnGLNFfvI90TINx6sisMDO9OPHe4FA57hJ8j8
 uu10xeIIS3x/VeooQVX3C/G86AGvH+GGDD+XNFCU75AVkMAwget0vK6bzOVsjYvm7LDH
 9K7U1bL1cx8xbxBkPUo6dTRi8Z7ZT4zqvUyGt+dIPraQ61P3oEQUtPnv1OOHqOpslc+P
 4mag==
X-Gm-Message-State: APjAAAWbx96VZYcD+bJujxWvIyWUdrEujW2+5yOLqceZJguU6ezNmFrc
 0U1DHQQ8F8SD9t6wGcorgYw8Y0xqVejltRAnojRNxA==
X-Google-Smtp-Source: APXvYqxRh42ZOPwsfIv1rTpbRKX7++snPy7FJa2zztyyJZHtyCi4YI88jMROngrbDP7kZY6CgHwlE3qUfp7Se617iaU=
X-Received: by 2002:a05:6830:1015:: with SMTP id
 a21mr26256694otp.232.1566476010135; 
 Thu, 22 Aug 2019 05:13:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190821160803.10026-1-armbru@redhat.com>
In-Reply-To: <20190821160803.10026-1-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Aug 2019 13:13:19 +0100
Message-ID: <CAFEAcA-Uo7uTrSuGSaBnBP3jKCoXxWicjMPB7Eny9HRU2nzKpw@mail.gmail.com>
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::332
Subject: Re: [Qemu-devel] [PULL 0/4] Monitor patches for 2019-08-21
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

On Wed, 21 Aug 2019 at 17:11, Markus Armbruster <armbru@redhat.com> wrote:
>
> The following changes since commit 17dc57990320edaad52ac9ea808be9719c91cea6:
>
>   Merge remote-tracking branch 'remotes/huth-gitlab/tags/pull-request-2019-08-20' into staging (2019-08-20 14:14:20 +0100)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/armbru.git tags/pull-monitor-2019-08-21
>
> for you to fetch changes up to eb707eac58dfc2d17281f67dde40cab3b8b26cc0:
>
>   monitor/qmp: Update comment for commit 4eaca8de268 (2019-08-21 17:33:38 +0200)
>
> ----------------------------------------------------------------
> Monitor patches for 2019-08-21
>
> ----------------------------------------------------------------
> Markus Armbruster (4):
>       hw/core: Move cpu.c, cpu.h from qom/ to hw/core/
>       qapi: Move query-target from misc.json to machine.json
>       qdev: Collect HMP handlers command handlers in qdev-monitor.c
>       monitor/qmp: Update comment for commit 4eaca8de268
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

