Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE24BC4332D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 14:01:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA3AF2051A
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 14:01:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA3AF2051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFICt-0006En-QZ
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 10:01:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45224)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jFIBq-0005XL-HJ
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 09:59:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jFIBp-0004cE-4F
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 09:59:58 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:44482)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jFIBp-0004bz-0c
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 09:59:57 -0400
Received: by mail-yb1-f196.google.com with SMTP id g206so2430479ybg.11
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2020 06:59:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=TaTGMu4T2dvHJkz5qPyjWaihpyrmBSGpHF/cokiRi9Q=;
 b=DXP93lVlQGnYNdVoOG8U/B9PSrMGKGx9pZKJwFROA7PQvquk4IoNHyCeYpIJLnlHWU
 MOzLx9BOAqhnJN5tNWdkgiPWmJfPLCB1w4EMsUttTmwjC3fvhYVVgdW6VWjqWvS+hv7v
 bH18A2GFH+3VMMoj8JaQKJM+nOy3TSl2A+2APug9oB3mJt0DuFuVtATO3Q2+ra7OsgT9
 YeZ8OPLc5hU94BvbjSlL80ICP5PGTdTIA2anEcraMAtO8M8qpfGIV4uQV/zLKw04n9zg
 1hClwlL4lf8nbdz9VaiA+otw8zwn9Qf7yb9MsLe7tt7wILHl328eC3hsPCiCD/y0+SkH
 M1KA==
X-Gm-Message-State: ANhLgQ3z4EiZ491IWBe4vmh4r+bP/ZdQV447RcviyXMcl3FP8lJt8yCB
 4w2wzWKKLLEH6+lNo0ziKi7ZMs4sdUJ9eRl0xp0=
X-Google-Smtp-Source: ADFU+vvb3mcnPDKG5X8d7nMVDRPJb8SbFHPJYFVzOUeicgmwFS9ykC4xqO9qgtI/TUFz8t3kSg/gLRhu49MdAt0/W5Q=
X-Received: by 2002:a25:6d54:: with SMTP id i81mr12592046ybc.323.1584712796423; 
 Fri, 20 Mar 2020 06:59:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200320114522.16273-1-alex.bennee@linaro.org>
In-Reply-To: <20200320114522.16273-1-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 20 Mar 2020 14:59:44 +0100
Message-ID: <CAAdtpL4m25LNCM5QnXbMXrMRK81ULOEAe-PVO25ac1=qtpkZ_Q@mail.gmail.com>
Subject: Re: [RFC PATCH for 5.0] configure: disable MTTCG for MIPS guests
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.219.196
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
Cc: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Mar 20, 2020 at 12:45 PM Alex Benn=C3=A9e <alex.bennee@linaro.org> =
wrote:
>
> While debugging check-acceptance failures I found an instability in
> the mips64el test case. Briefly the test case:
>
>   retry.py -n 100 -c -- ./mips64el-softmmu/qemu-system-mips64el \
>     -display none -vga none -serial mon:stdio \
>     -machine malta -kernel ./vmlinux-4.7.0-rc1.I6400 \
>     -cpu I6400 -smp 8 -vga std \
>     -append "printk.time=3D0 clocksource=3DGIC console=3Dtty0 console=3Dt=
tyS0 panic=3D-1" \
>     --no-reboot
>
> Reports about a 9% failure rate:
>
>   Results summary:
>   0: 91 times (91.00%), avg time 5.547 (0.45 varience/0.67 deviation)
>   -6: 9 times (9.00%), avg time 3.394 (0.02 varience/0.13 deviation)
>   Ran command 100 times, 91 passes
>
> When re-run with "--accel tcg,thread=3Dsingle" the instability goes
> away.

I confirm, in my notes I use this option with -smp with the following cpus:
- mips64dspr2
- I6400

>
>   Results summary:
>   0: 100 times (100.00%), avg time 17.318 (249.76 varience/15.80 deviatio=
n)
>   Ran command 100 times, 100 passes
>
> Which seems to indicate there is some aspect of the MIPS MTTCG fixes
> that has been missed. Ideally we would fix that but I'm afraid I don't
> have time to investigate and am not super familiar with the
> architecture anyway.
>
> I've disabled all the mips guests as I assume it's a fundamental
> synchronisation primitive that is broken but I haven't tested them all
> (there are a lot!).
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Cc: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
> Cc: Aurelien Jarno <aurelien@aurel32.net>
> Cc: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
> Cc: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  configure | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/configure b/configure
> index 206d22c5153..002792d21dc 100755
> --- a/configure
> +++ b/configure
> @@ -7832,19 +7832,19 @@ case "$target_name" in
>      echo "TARGET_ABI32=3Dy" >> $config_target_mak
>    ;;
>    mips|mipsel)
> -    mttcg=3D"yes"
> +    mttcg=3D"no"

I am not sure the 32-bit targets are affected.
Maybe we can keep it enabled here?

For code below for 5.0 (64-bit targets):
Acked-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

>      TARGET_ARCH=3Dmips
>      echo "TARGET_ABI_MIPSO32=3Dy" >> $config_target_mak
>    ;;
>    mipsn32|mipsn32el)
> -    mttcg=3D"yes"
> +    mttcg=3D"no"
>      TARGET_ARCH=3Dmips64
>      TARGET_BASE_ARCH=3Dmips
>      echo "TARGET_ABI_MIPSN32=3Dy" >> $config_target_mak
>      echo "TARGET_ABI32=3Dy" >> $config_target_mak
>    ;;
>    mips64|mips64el)
> -    mttcg=3D"yes"
> +    mttcg=3D"no"
>      TARGET_ARCH=3Dmips64
>      TARGET_BASE_ARCH=3Dmips
>      echo "TARGET_ABI_MIPSN64=3Dy" >> $config_target_mak
> --
> 2.20.1
>

