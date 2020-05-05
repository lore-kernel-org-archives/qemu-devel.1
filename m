Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 801CFC47257
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 14:49:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F3D2206B9
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 14:49:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sP+gEJDo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F3D2206B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVysk-00033I-Da
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 10:49:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36172)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jVyrJ-0001cQ-4D
 for qemu-devel@nongnu.org; Tue, 05 May 2020 10:47:45 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e]:37338)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jVyrH-0006M7-NI
 for qemu-devel@nongnu.org; Tue, 05 May 2020 10:47:44 -0400
Received: by mail-ot1-x32e.google.com with SMTP id z17so1856365oto.4
 for <qemu-devel@nongnu.org>; Tue, 05 May 2020 07:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=s7mRA5n+wgQvl27+I+P286HANZt/7d7231ndilgUj48=;
 b=sP+gEJDod+gaYZxN0u8Jv7VhcyZfAhBhSfqpGvL5G0niA8MRPsP7jXMeFiMkDgBS93
 z63Z5eLkzH0Ld+ePvKCDGz88L7Q2zG6wVRwuAjUbQHEpfBw8rr4s1HtZ01U8EiW0PlWs
 a9Y+U4XL8qyY+LC5cmAib0ttaJntGEeEPwtkGstyzbr68hHRDxi9A6pgL/SkSdbktp4F
 8I6F+d5aqQM/Vtnf9fNW5Bfvi2bHHkp/3oRxToIDKpxnV5vNj4yrqSmhp4+gzKI7b94G
 kKGmDohPffzDD4HOTRkOHFYfLiQBES+6w8W6hahkpi8xEq1YEt85R3sj8kKuQLKLkUKQ
 Nd5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=s7mRA5n+wgQvl27+I+P286HANZt/7d7231ndilgUj48=;
 b=pIyVZskJjWD9Zaqn7i1pYw5UKoE9mGTzI2Vpod4DWs9s7UUinrdoeDdfjGBTU6SSCg
 V4wrxAhE8IgIHSPZz5W9Pe9pD8WgxvqMLV8FI8i9c7xOBrv2VH9Ap7Rp1l6cE0TpIgPp
 Ocaa5PQfzLA3OnCVJYn6DS6aO5tzkB5IJG/+F6QYdXtIhl0sp0Boo47clmM3mhAQF1ae
 ASa2h9gqRXjEE+faR+hACiYNk8uwlVeq8ytu0hxDrj/kO/fjMUWpTzXIq039LvtFLyjm
 4nv2qv0plBS+M/iCHsoWlI2AUNqvA5TrxJQBjP6BRYebm4Tbgncj/omrIfbMiEVxXakz
 Bd1g==
X-Gm-Message-State: AGi0PubxjhqLqhub+vNcmQuYU+wEDcGD2D7h0iCDyVZnWzxI9xS7bBCD
 mkazto2CMn6cIW229W4+asV7d0PoBUvjVFdOdGYNhw==
X-Google-Smtp-Source: APiQypJ1XEPRkmsrNbs7XruGeJ8gGgwZMrHw5yzQLoZRUKieatfyj4q7M1XjFkCurIgs73f/srSjA+U8svkqU2qQZyA=
X-Received: by 2002:a05:6830:1e4e:: with SMTP id
 e14mr2475635otj.91.1588690062012; 
 Tue, 05 May 2020 07:47:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200504155956.380695-1-laurent@vivier.eu>
In-Reply-To: <20200504155956.380695-1-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 May 2020 15:47:30 +0100
Message-ID: <CAFEAcA-Tu7BfvCgJW79fBAg2vS391FMwp=qPziJnWeLWhC6HXQ@mail.gmail.com>
Subject: Re: [PULL v2 00/19] Trivial branch for 5.1 patches
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x32e.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Michael Tokarev <mjt@tls.msk.ru>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 4 May 2020 at 17:02, Laurent Vivier <laurent@vivier.eu> wrote:
>
> The following changes since commit 2ef486e76d64436be90f7359a3071fb2a56ce835:
>
>   Merge remote-tracking branch 'remotes/marcel/tags/rdma-pull-request' into s=
> taging (2020-05-03 14:12:56 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/vivier/qemu.git tags/trivial-branch-for-5.1-pull-request
>
> for you to fetch changes up to e702fba83108519618046a2a09235a62e3a81595:
>
>   hw/timer/pxa2xx_timer: Add assertion to silent static analyzer warning (202=
> 0-05-04 14:43:24 +0200)
>
> ----------------------------------------------------------------
> trivial patches (20200504)
>
> Silent static analyzer warning
> Remove dead assignments
> Support -chardev serial on macOS
> Update MAINTAINERS
> Some cosmetic changes
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

