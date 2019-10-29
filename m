Return-Path: <SRS0=qR42=YW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57EA8CA9EAE
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 08:38:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 213D02067D
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 08:38:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DnbWO9eU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 213D02067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52848 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPN1Q-000139-7w
	for qemu-devel@archiver.kernel.org; Tue, 29 Oct 2019 04:38:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41551)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iPN0k-0000Zj-U0
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 04:37:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iPN0j-0007ro-Ji
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 04:37:54 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:39417)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iPN0j-0007rJ-Cp
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 04:37:53 -0400
Received: by mail-oi1-x244.google.com with SMTP id v138so8249242oif.6
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2019 01:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=yKC5t88eETCtb8kh5uLAsqOlCAzQroOzJCHwfeADAL8=;
 b=DnbWO9eU6znlC7hapMb+zAWkV9U1X7yyJ1CPr4S14bO1txvJzd7AcycKUwn/w9cyME
 EQP9IZM+Of8mxomjJHJ/IaVPi8YWGfDFpiwPGRMgetL39fbQBUomjXmkaY7SH59fzrW9
 s5Lz/kwl4vkdCi9iL2Cc7c5uKGljiC4FgBsSUdhEkSu0NqgFSOwfXj+a7ki+eXCu7XqH
 S9TKdspoPlyt0pSPaBpEQGxOrpyd9cckeIiJJ6PFidnMcHHGOpl9woiH5K5iuD735SUX
 E6iLiDXGvRHyu4+Jzr6NNSXIdbpRYGgXrBNfXBAPZtmbOyz2hfvXwdu+YpKoDW6pwKBy
 +oaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yKC5t88eETCtb8kh5uLAsqOlCAzQroOzJCHwfeADAL8=;
 b=Px7kiFMAZuo+JoqrTH4ObSrfhJF3MN6hFgIHDwE2BmiJR0dEQrsvnLt1eQkDPPGzC7
 qdMwQ82b8/JCWTT9GUmgErlID59Z/8sNA1dIThhBJOJdFN6ni1CVYCDnKrfVQZ4r+DHM
 BE9NzZ6pRb76wnU+2YcZAk6gKejUxORn4N7YiAOyYtUjLeJ7UUVdHhOQ+0qNgba2KjD3
 mT0Z7Onle4mJIYZ3d1hNkUf+tlpH/dt7C3+uFhH2Y0YSaL2eS2Vm7VnaVzf6lswOMicu
 yetzFj4dE0A3aB734quCF5N0WGSY6tfx9m5A+g06pF2woSCsvVEAYyZ5SIusKeg4QeZr
 r9yQ==
X-Gm-Message-State: APjAAAVnL1Fiu3SuOHZVbbK3QUGyUEV1yFIH3VTdcKEZHJAaMyYxy35R
 Z9uuNpzIonPhql+nuYRnaSSheSpqyeCeTJaAjdYrdg==
X-Google-Smtp-Source: APXvYqx1iw+3ztVitlqD0b/yTRh1FoOXy54ULbYMLXWG8QEGCUr8nooeIILhfBvR0m3p2tB2EQijRQBNDj1abNqfDhI=
X-Received: by 2002:aca:2312:: with SMTP id e18mr3051852oie.98.1572338272287; 
 Tue, 29 Oct 2019 01:37:52 -0700 (PDT)
MIME-Version: 1.0
References: <20191028154902.32491-1-palmer@sifive.com>
In-Reply-To: <20191028154902.32491-1-palmer@sifive.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 29 Oct 2019 08:37:53 +0000
Message-ID: <CAFEAcA9S+BhrC4ZJHZHXJ-P0w3QJe90oyJALi14vSWOKk9+0Aw@mail.gmail.com>
Subject: Re: [PULL] RISC-V Patches for the 4.2 Soft Freeze, Part 2
To: Palmer Dabbelt <palmer@sifive.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 28 Oct 2019 at 15:58, Palmer Dabbelt <palmer@sifive.com> wrote:
>
> merged tag 'for_upstream'
> Primary key fingerprint: 0270 606B 6F3C DF3D 0B17  0970 C350 3912 AFBE 8E67
>      Subkey fingerprint: 5D09 FD08 71C8 F85B 94CA  8A0D 281F 0DB8 D28D 5469
> The following changes since commit 9bb73502321d46f4d320fa17aa38201445783fc4:
>
>   Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into staging (2019-10-28 13:32:40 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/palmer-dabbelt/qemu.git tags/riscv-for-master-4.2-sf2
>
> for you to fetch changes up to 9667e53573f907d4fcd6accff1c8fe525544b749:
>
>   target/riscv: PMP violation due to wrong size parameter (2019-10-28 08:46:33 -0700)
>
> ----------------------------------------------------------------
> RISC-V Patches for the 4.2 Soft Freeze, Part 2
>
> This patch set contains a handful of small fixes for RISC-V targets that
> I'd like to target for the 4.2 soft freeze.  They include:
>
> * A fix to allow the debugger to access the state of all privilege
>   modes, as opposed to just the currently executing one.
> * A pair of cleanups to implement cpu_do_transaction_failed.
> * Fixes to the device tree.
> * The addition of various memory regions to make the sifive_u machine
>   more closely match the HiFive Unleashed board.
> * Fixes to our GDB interface to allow CSRs to be accessed.
> * A fix to a memory leak pointed out by coverity.
> * A fix that prevents PMP checks from firing incorrectly.
>
> This passes "make chcek" and boots Open Embedded for me.


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

