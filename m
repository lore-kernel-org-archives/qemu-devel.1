Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3EA7C17441
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 17:52:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82FA52084E
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 17:52:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DSQ8TIwG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82FA52084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUaKu-00014z-Eq
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 12:52:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35718)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iUaFj-0002hH-H6
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 12:46:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iUaFi-0000AQ-7B
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 12:46:55 -0500
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329]:40122)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iUaFi-0000A6-1q
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 12:46:54 -0500
Received: by mail-ot1-x329.google.com with SMTP id m15so15051476otq.7
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2019 09:46:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=DwwnKtFgLRPfS1qhLF+qtS5qlN0EhsWE9sbB/D7T7vc=;
 b=DSQ8TIwGgDOpWp1cGXPfSGUejwUecF1MB06rMVWF2/JOEpJYXFjLwOerTabIgLYOBu
 kpN/DKsXrAgESpPbOUjvvgb3kCbmHtM2c+hkwP8UFedWWDHff0rAJvUSAyq7ull/CRlQ
 Nx/TeC3TrNyAqXckq+v0lrjeluTcGBnUPkhj6H/qEZrcW3ZLfUlbR85FKZ+u7VsmbiJi
 qS33Iau5cEYwZFYC/y4sQy15gqwz+NkLCWhHnT5a5ayC1/p8QZyXCOXu3yRoswSqIeAC
 /HF0aYnEUpl17yvtg7VWvwlzBlkCkJAmyeC+SLDe6nWhkDCWAiGDhAkfrbl81LVKSHcK
 CpfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=DwwnKtFgLRPfS1qhLF+qtS5qlN0EhsWE9sbB/D7T7vc=;
 b=R294KbXyzZqFKTeH79qF9Oc7mnpRfxAPLi3qRmsckTBPoeOLDYOCujUCWZE8DgbFl0
 9gNh+0Dh57aYg4XZPnPxZ3jOoo3tcSHSFrCiOnoMtJWBRAoC1yOyblaopDlFRW4R/UoB
 gVGYLglINZtyx3pP/OMiLKyhYO0tLjzdQAQKjPJn0raJjd1hvAPnDKW9BAI8Wof1Zf7U
 wpfV3r5WoAHv4/JkiK4YZ0wXowgWRkFvPlDfpNBJE/qsww2P3IJPvZiSgTlRu4jmXD3N
 b7qOpFZ0OiOhpJcVWc7yk/BNHV4otOzJNeQCzJSd4V6gATiiUMTY4/a2wimiadQkEXFy
 Q3TQ==
X-Gm-Message-State: APjAAAUXIK5Mxo2hL1GbYmmL4DLN2TOI3M4N7D4fiKUqB43Nb7n6KaWP
 T6EW8CeoFKnqf2C/3AtQSbjY4xRKSQdRsX4Ib3A84Q==
X-Google-Smtp-Source: APXvYqxGBk4/149CwP8Zv70xBx4xEaCNejnTr1i2d8jWta3ojcfh+jsBvxcYSAU+NV5XWrE+NEUxfV2QFRhc1StkvSs=
X-Received: by 2002:a9d:7f12:: with SMTP id j18mr24815448otq.221.1573580813037; 
 Tue, 12 Nov 2019 09:46:53 -0800 (PST)
MIME-Version: 1.0
References: <20191112160449.29212-1-edgar.iglesias@gmail.com>
In-Reply-To: <20191112160449.29212-1-edgar.iglesias@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 12 Nov 2019 17:46:41 +0000
Message-ID: <CAFEAcA9a12KN3+YNso6i-mPaoMnD8C7RzF8X10=2NMHgLQn5OA@mail.gmail.com>
Subject: Re: [PULL v1 0/3] MicroBlaze fixes
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::329
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
Cc: Edgar Iglesias <edgar.iglesias@xilinx.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 12 Nov 2019 at 16:04, Edgar E. Iglesias
<edgar.iglesias@gmail.com> wrote:
>
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
>
> The following changes since commit 039e285e095c20a88e623b927654b161aaf9d914:
>
>   Merge remote-tracking branch 'remotes/vivier2/tags/trivial-branch-pull-request' into staging (2019-11-12 12:09:19 +0000)
>
> are available in the Git repository at:
>
>   git@github.com:edgarigl/qemu.git tags/edgar/xilinx-next-2019-11-12.for-upstream
>
> for you to fetch changes up to c49a41b0b9e6c77e24ac2be4d95c54d62bc7b092:
>
>   target/microblaze: Plug temp leak around eval_cond_jmp() (2019-11-12 16:35:26 +0100)
>
> ----------------------------------------------------------------
> For upstream
>
> ----------------------------------------------------------------
> Edgar E. Iglesias (3):
>       target/microblaze: Plug temp leaks for loads/stores
>       target/microblaze: Plug temp leaks with delay slot setup
>       target/microblaze: Plug temp leak around eval_cond_jmp()
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

