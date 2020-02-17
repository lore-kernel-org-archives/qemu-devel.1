Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AB75C35254
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 13:19:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16A942070B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 13:19:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EIBnl9D2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16A942070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3gIu-00076I-7i
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 08:19:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52777)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j3gHQ-0005sr-Hi
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 08:17:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j3gHP-0003ck-3l
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 08:17:44 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:36055)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j3gHL-0003bX-P7
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 08:17:42 -0500
Received: by mail-ot1-x344.google.com with SMTP id j20so16045869otq.3
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 05:17:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=cHPhOGeNLOf68WPsW2tTD+RWuznlqruVPD4LcxKf4l8=;
 b=EIBnl9D2nlWfWotqf5eHOkemBvjEOyltavxNPHeEcMx+b1BUEEfxrY+iOVww67WBxp
 XW6ZEauNOA2JbYylOjrU+/CUgtQcVHsg3zGJT2egX+QilzaEU2lDXMRXwGhskqxlDHYg
 hSvVyEPOi/tF6nKffVPf35xJPb4ZK5ofFAumYA8hy2xE/A+Aj4+yC12Hh1JQF16RRGVw
 KOTS3W1tg2MyPV4PT2vTMU2+XsGWHwX6ILy+NDZVQmhMcOEJ1v98ow+N7Wfnk34bHLUs
 RSKd9ZLoKehcD2KMEBp9orCir0CbZO8R/EtDbNxN7AlixIZh1YABQL7gM+2wgFZS6Wt5
 PBEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=cHPhOGeNLOf68WPsW2tTD+RWuznlqruVPD4LcxKf4l8=;
 b=RwU8BvUsfeiV2pIxhit8Ajh0lNeZTPHx6BISnCOekvQvbrz3AnHGlomQQRkg8j4hit
 e+v9SeuGcyP73GjQlWsXKBlgkX+t9g0Xrx+V44is3h0grgeDdGXhABYgx0aI3Fe0Nie9
 YRjlv7/WOy+OGp/orUH+0F+ka81KBUNlYRi1bn6H65dJj8HbUkEnrByflyq05YoGoawa
 07aDCBv5TsJtryMf9u5wgFoiT7hA3o2JXKjg9PJIZchrABaLJuHypxnjmIx509YRlcIb
 8QA99BzHqet6lD+xlSNwnpsrdttV8zNrDE52eY67XFovCckof0DiUzwLYQpYtq5x98I/
 cTIA==
X-Gm-Message-State: APjAAAXakZJblCvDbAToykyS1cnuVGHApXQn2kD3oRofQiE/Li1aiHmS
 VVMwG1D/OnKoflBTqDY5ZL7QkAILDvGMDQcOQ43UAw==
X-Google-Smtp-Source: APXvYqyjHiHVJQ7pr191Sy5YGdXNZqcE/Aj1vOU6UDeEdZAQbsEE8gSezSQL+cgZZXfyBgE7Vs8SUg7Axy5ABhfIyiY=
X-Received: by 2002:a05:6830:184:: with SMTP id
 q4mr12236897ota.232.1581945458692; 
 Mon, 17 Feb 2020 05:17:38 -0800 (PST)
MIME-Version: 1.0
References: <20200217093031.678348-1-laurent@vivier.eu>
In-Reply-To: <20200217093031.678348-1-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 17 Feb 2020 13:17:27 +0000
Message-ID: <CAFEAcA9cnyJ6yuRAskTN_RuT1Qa7veZBZ5bNoqt3+-TYrZXz2w@mail.gmail.com>
Subject: Re: [PULL 0/9] Linux user for 5.0 patches
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Riku Voipio <riku.voipio@iki.fi>, QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 17 Feb 2020 at 09:32, Laurent Vivier <laurent@vivier.eu> wrote:
>
> The following changes since commit 971b2a1e5b1a8cc8f597ac5d7016908f9fa880de:
>
>   Merge remote-tracking branch 'remotes/palmer/tags/riscv-for-master-5.0-sf2' into staging (2020-02-14 18:37:11 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/vivier/qemu.git tags/linux-user-for-5.0-pull-request
>
> for you to fetch changes up to 0a80aa55f4485d102567e1db7ab0532ef96d1b96:
>
>   linux-user: xtensa: Remove unused constant TARGET_NR_syscall_count (2020-02-17 10:28:50 +0100)
>
> ----------------------------------------------------------------
> Update syscall numbers to kernel 5.5 level
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

