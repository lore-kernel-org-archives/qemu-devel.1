Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A055C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 10:07:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11BB722CF8
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 10:07:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k0M6d3gZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11BB722CF8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i55iW-0002rt-6r
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 06:07:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40321)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i55hP-00023o-Ch
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 06:06:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i55hO-0007tX-68
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 06:06:07 -0400
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e]:46002)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i55hO-0007st-0h
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 06:06:06 -0400
Received: by mail-oi1-x22e.google.com with SMTP id v12so12289010oic.12
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2019 03:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=GUr0pyy9DSFTyZB3ue890d8aR4ZcpyIbELHAmQla+Uw=;
 b=k0M6d3gZb/AYU4q5BtDFiIlMm29wofybJkNUD6iX/geexIMr0eK3tGK5z7ztTLug5s
 F9pFCK+pT7j3/61bb2R9qxqyrDo7SYVznL4R6AhDsV3EKLbZA7rtUbXK7O2n8FVOTaJ0
 Q7zydhyF1bGQGMQDjHsK9mHUAGrk7Ur6TRTAT2KCvrhmGxcI+Q5pdqOyTqtAw2HCg+kK
 v7tVNtgIejaHeygnMPYiDyURF7RkFCRCrd6Lclz4KQbyl2XoRr678HVYpwmDa5SeFJBH
 c3jE1KoAvHipCOrrfaSj/oFfLA0UOOhm6nBY+2IlJqk4fFgfJbj8SN0LAtaphGGXpOrC
 MhgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GUr0pyy9DSFTyZB3ue890d8aR4ZcpyIbELHAmQla+Uw=;
 b=Bxp9lM+XvpEb3qe8DtJ7P7eRaQx5ufwXmKf32nU68XE4qUcyzAbRVL5wI4z5Ov9cSK
 aQxYGSbM/mMxX7nzP5DAUxyx+yspmOwwPgM/HdN+3DCwMzYXPSXHzuj1Xog7vxOaC4b8
 scYQpPGPjP4vGaggiWQ1NVPgqFQzHf2k7Gmkq5k2XI0JePVoiU+JojxqICmhE/7WJZDR
 XgdHlXQ9cSKreTgwqCjcE3jpaItsSUd2k7KiVhkk71kP23z3DBOhaokF8aefNN5oXZC8
 xQD8NIZ92OslJucxqj9W1ZGWJKDPuMx49W9xFrHWmzd7j1p+R816fIz2ZUZdyGyb7pZ0
 e3ew==
X-Gm-Message-State: APjAAAWFTD9SsBi8+1N6KV4inF8mNoXqre2BJiUz2z/9cb408UL+Am45
 bOa1ft//q9uOpqa4IV/xO6IVLOG9dBsI+zQmy39bSw==
X-Google-Smtp-Source: APXvYqwI0ljY2LVtBvxQCwjZiCMtN7fH6/qbdjrICggusRFGvT1+DslwBmuEXgeKz80BL/tVEngghcjQv4gjos+qu6w=
X-Received: by 2002:aca:281a:: with SMTP id 26mr4043683oix.163.1567505165088; 
 Tue, 03 Sep 2019 03:06:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190827201639.30368-1-stefanha@redhat.com>
In-Reply-To: <20190827201639.30368-1-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 3 Sep 2019 11:05:54 +0100
Message-ID: <CAFEAcA_2B-c_qsg-c+WiPnjKc5RzucMvBA_W5-L0tjJav4i3QQ@mail.gmail.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22e
Subject: Re: [Qemu-devel] [PULL 00/12] Block patches
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 27 Aug 2019 at 21:16, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> The following changes since commit dac03af5d5482ec7ee9c23db467bb7230b33c0d9:
>
>   Merge remote-tracking branch 'remotes/rth/tags/pull-axp-20190825' into staging (2019-08-27 10:00:51 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/stefanha/qemu.git tags/block-pull-request
>
> for you to fetch changes up to 5396234b96a2ac743f48644529771498e036e698:
>
>   block/qcow2: implement .bdrv_co_pwritev(_compressed)_part (2019-08-27 14:58:42 +0100)
>
> ----------------------------------------------------------------
> Pull request


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

