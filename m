Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF949C04EBF
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 14:36:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A11E2207FD
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 14:36:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j+cR5590"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A11E2207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCPS9-00013D-Fh
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 10:36:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39426)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iCPQV-000827-Lt
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 10:34:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iCPQU-0002WH-CV
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 10:34:55 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:34579)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iCPQU-0002VO-6u
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 10:34:54 -0400
Received: by mail-ot1-x342.google.com with SMTP id m19so10457440otp.1
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2019 07:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=XCwfNWL7UcYDB2Dq+mmue0+8MPtgEhYVpIx7xNcCp5Y=;
 b=j+cR5590GUzaDHfDhu4SZ3KPBQb8VIS411ScmP+uO2pWl5sS9q1a51XmHUtoKAxi9Z
 rCLb2F2X7XUbdnIHk/Qrc58HwXb787oicTFGeruwtqVjsjLtSS4pWwnpnz0UJbC1REMR
 i7kVWVFMASIuxHskWEKU5Zjkr/cdlVXxDm4mbr1aJ50ZpOkj/VN6PfELCvNxtX4vL7kQ
 qdfHZ2a7LwX8XsV5gQwN/yeWviiAZFR18TsLzjPZDafwLi5tCYEg7WnXAgfC7447Ko4i
 yX7YUr7Nbph7KISKwPJTvBAfwaZtb4wbxs5/sNQg64k9MVn+oOjX/QjCd4Qe4cobwtvb
 sghQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=XCwfNWL7UcYDB2Dq+mmue0+8MPtgEhYVpIx7xNcCp5Y=;
 b=dbPETdukbUl1/LApnsrxROrjG8z+Hqd3FvbwHQaIjB9bNVGGbhaksZg7xRVvmqiIm6
 +IiHcC5+X5TpVrZ1Hz9Idm95WI1hVIBU6Q6Kvh7E2BzLfKxbJSvrb2NixSMbXfpOegHl
 gklBSe7sASf+R+g9vGEHwgSAu6EN/ZdWUNf5zBVnAhifVFvhtSZhaNgISyfvdgndwIoU
 ptWyBdtdbvFzor2GxSNM45sNeLW+xtrqit6Xz9ELPrk+hm6D065Eu37ylesy30QsFbp1
 ryozq1SrdFJylejh/Qp+9qAHUANw68QT9utSzfvPPJ83Zwg8CDxLw9Ex6mxclj9eAKsI
 dG7g==
X-Gm-Message-State: APjAAAVrgZZbD1BIWALJeEfFnmRe7L0kNI8GzDP5h7Ytwzq9Sv+n6jMN
 gzFIs16oOyvaqd9PWsvFuc46l0kq8dUmjk8epz5jaQ==
X-Google-Smtp-Source: APXvYqxzrD9CWMWt2y+gyFQcu4YtV0Gq6R9+32LUeDMmBUkPLWQUhz3R37EUOKD8Yj+8NIaSn/95HGmGKQJ7YBSmAEw=
X-Received: by 2002:a9d:562:: with SMTP id 89mr112556otw.232.1569249293223;
 Mon, 23 Sep 2019 07:34:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190921150420.30743-1-thuth@redhat.com>
 <20190921150420.30743-3-thuth@redhat.com>
In-Reply-To: <20190921150420.30743-3-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Sep 2019 15:34:42 +0100
Message-ID: <CAFEAcA9KbQF071ZWXm4Y2GcoxfksKLTH8OvcUJqkfY79_oNnMA@mail.gmail.com>
Subject: Re: [PATCH 2/4] target/arm: Move cortex-m related functions to new
 file v7m.c
To: Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 21 Sep 2019 at 16:04, Thomas Huth <thuth@redhat.com> wrote:
>
> We are going to make CONFIG_ARM_V7M optional, so the related cortex-m
> CPUs should only be created if the switch is enabled. This can best
> be done if the code resides in a separate file, thus move the related
> functions to a new file v7m.c which only gets compiled if CONFIG_ARM_V7M
> is enabled.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  target/arm/Makefile.objs |   1 +
>  target/arm/cpu.c         | 146 -----------------------------
>  target/arm/v7m.c         | 193 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 194 insertions(+), 146 deletions(-)
>  create mode 100644 target/arm/v7m.c

Calling the new file something with 'cpu' in it would help
to convey that it does the same kinds of things as
cpu.c and cpu64.c. Maybe cpu-m.c or cpu-v7m.c ?

thanks
-- PMM

