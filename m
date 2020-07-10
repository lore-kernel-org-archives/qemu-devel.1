Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92D0AC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 10:30:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 622112076A
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 10:30:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZDRb8wUM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 622112076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtqIT-0004t1-Fh
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 06:30:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59818)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jtqHn-0004LD-MU
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 06:29:43 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:34090)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jtqHm-0003ew-0i
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 06:29:43 -0400
Received: by mail-oi1-x243.google.com with SMTP id e4so4420727oib.1
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 03:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=YT1yL2dvNdbVLoHbR0MSMr6nlgNGNCdBLleRjwQF+Ic=;
 b=ZDRb8wUM3DAH2UY6cjsKL7IdByg5mowIGPjQ07Sozdz23x7Ep1F+o37kzru5oMBh+R
 /QksWO98Pm7yzLuteTdUg9ym5eHa4Irgyps+/eoZdSm2RMIAQjAaYWhVi0xUeWoi892y
 AW7c5qTAhii7BqCihQVkZljDRAtAI437hC6B9afVeWgCnSqUG4dArBS4FxCSIqs8UxVP
 fYskULQf4usMoYQ7FL5OihO7eiLv7GHG/1hl/9LDKTai4aOCmXdaOs6NMriSHZdoPKsU
 gnzfTF5ewhM0tt8pclOecB9blphHZ4d+sp5MSLq37DdcX8DqlUnzOtlCrfh+qmNoUenD
 ZmXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=YT1yL2dvNdbVLoHbR0MSMr6nlgNGNCdBLleRjwQF+Ic=;
 b=QyJeb0/3K7pSo8l2gD+eVqVjxLdK+VcNIW0TCFQDJNw1+Yvertqih+3iCb6zQ/c6VR
 ICfvxXq74Y95aTsjrA2HPZBTqbf2EdISUx/+VK8IzWt21d3dSVNZxJ6UXN1D/rueKzB8
 QKZUefCDLA1y6iH8ztHEcKtRhiXW/M3uKulhxvP9FkRxrgxNYVYiNp2Wt6U56pFlSV+h
 wcv0EpTwr2R6shJdmA/LCPfH3apiP/sYR8yfrLgTTj0wZ0hiNq/+8X1CAFfAXWI97WYK
 QBh/8GXjKB3G9YIDvJfGLb4Y+i3he7OaE84wt4ULhZzH8krtIb1KQqSST23vubtH5hOx
 YZ/w==
X-Gm-Message-State: AOAM533LngUbxU0/Oz3Rk5DSPfrBQcvYResHpoi1stEPdEaWYbU471OP
 PtNAZJz3U0OaLCAoM3O8WIPO1WhBhuF8L45ONx/UmA==
X-Google-Smtp-Source: ABdhPJy/UB0vPry1wOEmmAucIQgXsYsY5UudbamO9fDCtiJG55fUsW5mI3cg0V0d0JUQuiEJFkKVjL3dumwGnKj9yM8=
X-Received: by 2002:aca:54c9:: with SMTP id i192mr3642157oib.163.1594376980287; 
 Fri, 10 Jul 2020 03:29:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200707152024.459718-1-stefanha@redhat.com>
In-Reply-To: <20200707152024.459718-1-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 Jul 2020 11:29:27 +0100
Message-ID: <CAFEAcA9+Q40=3oxZFV+XDjEu13RzQk+aDZf3rSG2guCeqLJw+Q@mail.gmail.com>
Subject: Re: [PULL 0/1] Tracing patches
To: Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::243;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x243.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 7 Jul 2020 at 16:20, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> The following changes since commit 7623b5ba017f61de5d7c2bba12c6feb3d55091b1:
>
>   Merge remote-tracking branch 'remotes/vivier2/tags/linux-user-for-5.1-pull-request' into staging (2020-07-06 11:40:10 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/stefanha/qemu.git tags/tracing-pull-request
>
> for you to fetch changes up to 27e08bab94f7c6ebe0b75938c98c394c969e3fd8:
>
>   tracetool: work around ust <sys/sdt.h> include conflict (2020-07-07 16:07:14 +0100)
>
> ----------------------------------------------------------------
> Pull request
>
> Fix for a LTTng Userspace Tracer header problem.
>
> ----------------------------------------------------------------
>
> Stefan Hajnoczi (1):
>   tracetool: work around ust <sys/sdt.h> include conflict
>
>  scripts/tracetool/backend/dtrace.py | 6 ++++++
>  1 file changed, 6 insertions(+)


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

