Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36F89C4CEC9
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 11:03:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC8C521670
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 11:03:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WtV+QdIn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC8C521670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iABGK-0002ZX-Ca
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 07:03:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51518)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iABDY-00016n-4p
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 07:00:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iABDW-0004Cs-NI
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 07:00:19 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e]:42430)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iABDW-0004CZ-Hc
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 07:00:18 -0400
Received: by mail-ot1-x32e.google.com with SMTP id c10so2616501otd.9
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2019 04:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=PPhwDdOT+OVJCD+kgRCLhSfmkL+zUm4pn4WvbG0TCQo=;
 b=WtV+QdIn/WzgyHH25UhIx7JlxkVla3//B3o9AJiktQ7VvKKVpmTkiKlopL1wDC1iKn
 7XZbWzkRW0MeRzWklIV+1prXx7pwLcsha3WMLCDH90YIjBlT352L+W56vZkZ6bkKQCzW
 DBL2twDMreXwy/eahWL27gjsp0cj9Hlqk+CRnDwR7Hc7TgA/gIk8ISJ4x9BoUvyP6E48
 QCHhIyCurRugbe3sRl6WJfve9y+kBuSlbxZ9wgLDYugPA6i3RBZT2FcFvsn1BLjUPF5f
 hvfOumQ8733rQIn7b1KqhHUCMd4aKrHaoqvX+4Iq2t7aSmDSmi1mgC6zos//1xyKcFQI
 /LCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=PPhwDdOT+OVJCD+kgRCLhSfmkL+zUm4pn4WvbG0TCQo=;
 b=ICDHbU81iyyMr3V27qYeJ/F+5pm+JRQZOhUHSzW3sbAHa9UAJvOpamd0jKe/QzOB3G
 FtOpKgP9s1KYGHaEoKlkjyeSQnWzIBVpJUTAvqTiivGqHsk3IvnX1Y+Y6OZTkSJGZMHw
 dnz91itnpRNxKKbT76gb2my5FVJmESomsB+soeFXxref3ve1r106qT3oWg67Wr/7WSs5
 RZp8q1qM3CtzEHOaA3kP9+Is7q/intQSEGws+vHUQVJjz32YKbR0LXgihtlnrCHRv85n
 NkxJJBHXe59qg7/tto3xVK5M3rw4HOPMPMHpMHJcvaz5g9MdbZmMwfP+s6iW84BUd5dj
 EbMw==
X-Gm-Message-State: APjAAAWKVpr2uIkMGvHvzYOw48Hd4hR1hVPsbwnox8bldoLdPEaY/Zu5
 94/FlhfwaFEIfMr9hOWoLxlkjM/8/5PF0Dp1Duuu8ybJwlo=
X-Google-Smtp-Source: APXvYqx6vsm171aWzYz5aUQtT8lHqh1/XQ6OqlgKfvWmk2X8Jfp0QZimNK+1snmiaSiMt4FPCL4Decj9beerXHccDHE=
X-Received: by 2002:a9d:562:: with SMTP id 89mr2246214otw.232.1568718017779;
 Tue, 17 Sep 2019 04:00:17 -0700 (PDT)
MIME-Version: 1.0
References: <1568646858-17065-1-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1568646858-17065-1-git-send-email-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Sep 2019 12:00:07 +0100
Message-ID: <CAFEAcA-1tee9T=gj97kyc=233P4MtYHyEbVp0u2HDA2_DYZ6mA@mail.gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32e
Subject: Re: [Qemu-devel] [PULL v2 00/29] Misc patches for 2019-09-16
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

On Mon, 16 Sep 2019 at 17:19, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The following changes since commit 138985c1ef8b66e4e5b383354e133e05d01d0b5f:
>
>   Merge remote-tracking branch 'remotes/amarkovic/tags/mips-queue-sep-12-2019' into staging (2019-09-13 16:04:46 +0100)
>
> are available in the git repository at:
>
>
>   git://github.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to 149c50cabcc4ea46a460d35fc876346ed441304c:
>
>   hw/i386/pc: Extract the x86 generic fw_cfg code (2019-09-16 17:13:09 +0200)
>
> ----------------------------------------------------------------
> * Fix Patchew CI failures (myself)
> * i386 fw_cfg refactoring (Philippe)
> * pmem bugfix (Stefan)
> * Support for accessing cstate MSRs (Wanpeng)
> * exec.c cleanups (Wei Yang)
> * Improved throttling (Yury)
> * elf-ops.h coverity fix (Stefano)
>

Applied, thanks (since the missing patch from Yury was just the
test case).

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

