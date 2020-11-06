Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01884C55178
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 11:08:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3559820735
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 11:08:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NdygL/XG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3559820735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kazb7-0005s5-TK
	for qemu-devel@archiver.kernel.org; Fri, 06 Nov 2020 06:08:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57404)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kaza5-0005Jl-N0
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 06:06:57 -0500
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643]:44506)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kaza1-0006Mu-V7
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 06:06:57 -0500
Received: by mail-ej1-x643.google.com with SMTP id o23so1322268ejn.11
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2020 03:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=wzNB+ZPocv9izgv7Ouydj5ESivB9v3PlCDHixLFnuFw=;
 b=NdygL/XGN3m10gVgEIHeQSmqjGw2XEJr3pMPqegqWtVhhTf2MkXRkDiC/oRJpwuwrs
 gMWYeR5BxgsTr/WWsntxQeiVVxARDRWgOiKvB4hcV5Z0oZ+gl2pCn+b5DRNQZOO+eq3I
 AXxarTODhQWdJPhHfcRnhQMHEAqwgDYd+ACAls1IgxwHQQBOnw3gWc0fGsx6Sjw+gm9D
 bZUgMqE+4gwdfDWb9Okmh1TKNpZQQJV3SblzD81/3jMz1XWjkcU6U4cD2NuuLKvRjTNT
 o9+fw1b0ke7PA/06Ln9zWLxQsuuGGf3g+AVKk8cLPStLS9C+12sPclRH+cujI9jnUwwG
 KlNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wzNB+ZPocv9izgv7Ouydj5ESivB9v3PlCDHixLFnuFw=;
 b=MUoaeL2/GAngejK0kJXwqLoDgjWl3hb2wDtOGFekdhxmM5n1/bNAeZR998CzsREhf3
 DXtaFf1JRe1Wjxc0JsobS8bnDTDre1S2YEOiJOBTIFZp+AYhbNhHGX70PLbLq3Ytx82/
 9WQa7QG2hMm4ekYKhr3WENEKjG3b169Nyb1ze6gwDeqkjP5AVxknuHAuAIxvaI9erAyq
 oVCAJMitPCm1HU04UdhqnUnpNIgJY/jM40G9iA9eEYyMmBw4I9UXxLn3eAv3fzkDsPxR
 Yj/sqhcNwi3VQdgOsS2t2Vf5zBJCHWDmftniQ9dkeINeyvc9iTJ+bnWe96glUz5cnfc2
 jxmA==
X-Gm-Message-State: AOAM533ggGx30YuzsS/VHOpmoThfF3pxpm/LoHYEFYjiqOs4w8iJZafY
 NSnGWUUx3EQp2A3mGi4H4q4476zxzTy0bPeBMa3WvA==
X-Google-Smtp-Source: ABdhPJxWPr7GuyFAJQ/616aUYX8SRB/mnXCCpp5+x+aNoevjdh+JYCas5GZ332uTeyCf0joqIWo35vQtvvTu3R+Pw0U=
X-Received: by 2002:a17:906:7254:: with SMTP id
 n20mr1404024ejk.382.1604660809325; 
 Fri, 06 Nov 2020 03:06:49 -0800 (PST)
MIME-Version: 1.0
References: <20201105154208.12442-1-ganqixin@huawei.com>
In-Reply-To: <20201105154208.12442-1-ganqixin@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Nov 2020 11:06:37 +0000
Message-ID: <CAFEAcA9QMBqF0Bm44q4m1d=QaPVBJodH9rwuYhGx5H6zy6ULcg@mail.gmail.com>
Subject: Re: [PATCH] scripts/checkpatch.pl: Modify the line length limit of
 the code
To: Gan Qixin <ganqixin@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::643;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x643.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 zhanghailiang <zhang.zhanghailiang@huawei.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, QEMU Trivial <qemu-trivial@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 "Chenqun \(kuhn\)" <kuhn.chenqun@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 6 Nov 2020 at 06:15, Gan Qixin <ganqixin@huawei.com> wrote:
>
> Modify the rule that limit the length of lines according to the following ideas:
>
> --add a variable max_line_length to indicate the limit of line length and set it to 100 by default
> --when the line length exceeds max_line_length, output warning information instead of error
> --if/while/etc brace do not go on next line whether the line length exceeds max_line_length or not
>
> Signed-off-by: Gan Qixin <ganqixin@huawei.com>
> ---
>  scripts/checkpatch.pl | 18 +++++-------------
>  1 file changed, 5 insertions(+), 13 deletions(-)

For the code changes
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

but we also need to update our coding style documentation
to match. I'll send out a patch with some proposed text.

Side note: the kernel version of this checkpatch change
(kernel commit bdc48fa11e46f867) suppresses all line-length
warnings for the "--file" use case. Do we care about that?

thanks
-- PMM

