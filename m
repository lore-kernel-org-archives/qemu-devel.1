Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7BFEC4CECD
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 09:22:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82A9221852
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 09:22:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H3Oqir+k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82A9221852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iA9gg-0003Sx-3Y
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 05:22:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34384)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iA9eh-0001RX-2E
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 05:20:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iA9ef-0004Qx-Px
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 05:20:14 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:35942)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iA9ef-0004Pc-H6
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 05:20:13 -0400
Received: by mail-ot1-x343.google.com with SMTP id 67so2421882oto.3
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2019 02:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=JjBfFcw5tD/UTq1bHWyYBBS9dtPrW0QCzf0mCbScn4c=;
 b=H3Oqir+kaeOxnuCD4zGlZQzCykc3tZBdwG0EqnQqOnEb2gC9MPZVRAhzczNpkUxGlj
 j/1dHWF1UI2/gLLwPtOWtZkAMET6VXUaV4iV1RhJEdCcN06rJ3hV9ezyfWAsNroo+RJh
 ufovvZSDUJo7nMXouwzFVRq5Z3BBjEN7jStdOziPY2ySzV/KVJGbLDNCCTgARlLDWgpx
 GJLikjRvYNnivAOpd/FFj4oMetfaRolWIokQzTDG+MtxNbZv9H/s2SYjZbar2LiDg1lF
 OHFoZ38FD3altESlJGWD84KKozG2hwDo9ubLgYlpViX+VuydML288+lN6D2BG8TLpXjV
 FEPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=JjBfFcw5tD/UTq1bHWyYBBS9dtPrW0QCzf0mCbScn4c=;
 b=LxbBmokKDkD4h1Op8tY1z67crI8wG6nxi8xWM+ovP6MtMP2l5/QC+T/3O9cLcuBYoE
 5EDcsr2eTJ9o63TXruPFyseHz++clEAFKLg83bJGYjbDyeqGpm8cKr61ZNcLk+ecnKlM
 hwE8yK/g8WNwkScbnN42xymQRrGwcncS7wxi8+dps3D5w/jLKWHYprG8/ZLn0YoiaW8v
 EtvHXQu3g+R9MN/8A1PZoVSLXAT3XnsB2A2s9eNdum29B6v4Ub8vsKBP9e/0S4AHYHq6
 qFthWO2ZKnoM6t3PjRPfjtAXFdXBaTjq40v52hyGObOa/vKmio+vQ5iQbEr/KiJVqFgv
 GYsA==
X-Gm-Message-State: APjAAAXNn+GRRxvmCewUOA7Y5PU3DUdZZZD7fOeYS9IJk+tayWbFI+aq
 ddXjB3Pf85RRcg3F+4zAmbfjfmzYPtpxAmTkM3fUSA==
X-Google-Smtp-Source: APXvYqxFENI7t4VacsEtyZR/hAmXpmStwgzAuZ5XkzZAtmnz50Dvq4apjUz6w4YcDdkaTHoNzO1glj1Coh2kTNIQ8W4=
X-Received: by 2002:a05:6830:1357:: with SMTP id
 r23mr1911939otq.91.1568712011792; 
 Tue, 17 Sep 2019 02:20:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190916142246.31474-1-mreitz@redhat.com>
In-Reply-To: <20190916142246.31474-1-mreitz@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Sep 2019 10:20:00 +0100
Message-ID: <CAFEAcA8zGPxs1DJQ_ERyP3Yr7soDc9aTDNkqK9=x=MXnKGnnCg@mail.gmail.com>
To: Max Reitz <mreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: Re: [Qemu-devel] [PULL 00/16] Block patches
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
Cc: Kevin Wolf <kwolf@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 16 Sep 2019 at 15:22, Max Reitz <mreitz@redhat.com> wrote:
>
> The following changes since commit dd25f97c66a75d1508f1d4c6478ed2c95bec428f:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20190913' into staging (2019-09-16 10:15:15 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/XanClic/qemu.git tags/pull-block-2019-09-16
>
> for you to fetch changes up to 1825cc0783ccf0ec5d9f0b225a99b340bdd4c68f:
>
>   qemu-iotests: Add test for bz #1745922 (2019-09-16 15:37:12 +0200)
>
> ----------------------------------------------------------------
> Block patches:
> - Fix for block jobs when used with I/O threads
> - Fix for a corruption when using qcow2's LUKS encryption mode
> - cURL fix
> - check-block.sh cleanups (for make check)
> - Refactoring
>
> ----------------------------------------------------------------



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

