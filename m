Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA501C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 15:18:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8347A2075F
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 15:18:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZStz4k4B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8347A2075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k59Zf-0008J0-NX
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 11:18:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46892)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k59Yq-0007cZ-7e
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 11:18:04 -0400
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329]:36382)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k59Yn-0005lO-Ov
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 11:18:03 -0400
Received: by mail-ot1-x329.google.com with SMTP id x24so7573157otp.3
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2020 08:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=i7q/EFMUvqvHIl7gQi5ilXK7AThLhz2BP27d8baBcdU=;
 b=ZStz4k4BWxLy48XHPg9JAk2YtTH6n7stHwBQy/vQkyMNwykhL8aHwR5CCAsA8+SEmC
 cjIfKfMDF2d8+y+/dcS74J0uJ1w0fE4SYEiXRrrsnX6vJxgc/dPwjSzkRawbdlDPUQ4h
 /SlEh8IqmlMBj5ILbKNEwZQ9Tmbk+9SNsxFcKU7qHh+D47iKGFKhly7+ZMcphlKA149W
 aqRqJlciSuAIqwsnxf56hOl8zFJtOT1pQvw5Xt+feTvHuWkPex/HZIDbrjwrJCd5gvJl
 +lDk0WcRmBodno4knWw2loGnJPVUob5p0g2YzS1YrEfXJCuhVyojChHpZyL0kTp1yb5W
 IsVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=i7q/EFMUvqvHIl7gQi5ilXK7AThLhz2BP27d8baBcdU=;
 b=FVqX7N6+xFTCUhPEUHE10XnuY0Xq+gZElSyNgYe5Dp18md3Tk96LvfIMUZS3IzFj8H
 STjbNNaJ+5cTGVlesznsbMfJkA9ef6LiAW08LoavimiahdaMTYDRQp3McAh20emVV02H
 Fc/zhvjgkbKEUS2RnSSd981e3ImCBZIR0O1Ejcgtj+mp3G6YfZU5kPSnKf+mURfQkU6v
 jfda9tYDIIo2zBVA0tGzbqnxmAYztNZDcBEzsK1UHJ00I0H8cigRM8Fs7aaZsIQII6lF
 UtjOHK5woob4iP2bWwetcPmmDHG0y/BmwvmlCzTcnnC+QFliVd74oxY9PuGMsPNvEIDW
 Hx4g==
X-Gm-Message-State: AOAM530sSQEiYMf1X96iMx29f4GyKP5WEqxXzx6LUPy01JAitYUqCBRa
 7P1epw1/uWTL9VkvhJSUuGpliOXOfLTpI97SK6P7zg==
X-Google-Smtp-Source: ABdhPJy1CCVuMVnO2C8tbmmzs3npsw4FNgAs/rplWD+Be6r+jXMEzYom9KbetxRpJ94a4eFxzgrzwrkUKs71aX4qOLQ=
X-Received: by 2002:a9d:6f8f:: with SMTP id h15mr1124587otq.221.1597072680314; 
 Mon, 10 Aug 2020 08:18:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200810132441.16551-1-deller@gmx.de>
In-Reply-To: <20200810132441.16551-1-deller@gmx.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 10 Aug 2020 16:17:49 +0100
Message-ID: <CAFEAcA-Z30LLsUJ0ijUG2b+1n+AdXhzPx-6BANup9FtFWJP_jQ@mail.gmail.com>
Subject: Re: [PULL v2 00/12] target-hppa fixes pull request v2
To: Helge Deller <deller@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x329.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 10 Aug 2020 at 14:24, Helge Deller <deller@gmx.de> wrote:
>
> Please pull from
>     https://github.com/hdeller/qemu-hppa.git target-hppa
> to fix those bugs in target-hppa:
>
> * Fix the SeaBIOS-hppa firmware build with gcc-10 on Debian
>
> * Fix the SeaBIOS-hppa firmware to boot NetBSD again
>
> * Fix many artist framebuffer out-of-bounds accesses as found by Alexander Bulekov
>
> * Fix artist memory access bugs due to commit 5d971f9e6725 ("memory: Revert
>   "memory: accept mismatching sizes in memory_region_access_valid")
>
> * Fix various artist screen updates when running dtwm on HP-UX
>
> In addition the SeaBIOS-hppa firmware now includes a version check to prevent
> starting when it's incompatible to the emulated qemu hardware.

We're currently in the final stages of freeze for 5.1.
I'm not taking anything except point fixes for absolutely
release critical bugs until after 5.1 is out. I'll come
back and apply this for 5.2 after that.

thanks
-- PMM

