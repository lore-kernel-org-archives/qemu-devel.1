Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94A06C433E2
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 12:27:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A9EF206E6
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 12:27:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yFzFYVxh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A9EF206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFGFH-0003Yt-3x
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 08:27:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47630)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kFGEE-0002wT-7D
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 08:26:34 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f]:39325)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kFGEC-0000u3-9L
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 08:26:33 -0400
Received: by mail-ed1-x52f.google.com with SMTP id c10so12610278edk.6
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2020 05:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Cv4Cn0M1qXagRSOgKePGgSRTT6tiF/GSi+0A4QzDuPw=;
 b=yFzFYVxh9u9x/hEZHWCuLOJ7MrLWWWkX9HDFQmcZn5bl0x2v+1dI/PnoXTbdCq4YDc
 fKptRtFP+3ZIqPqOPXB4B1oxy4Ra4W+dg5S5FD2SOaG/4Yy40zC6J3Jd+Zz3c1RgG2Nf
 Z6ujWZvp7+JJj2rjzjfMERVoQYZA/a+xx6Hn+ekSv7aDOkTlxMkdJz07HK+pWZcYG0tg
 tB8CquPJMaJPlegoi78iez9k5uycsaziZSGIFzJuXzDkp05pjdZk4p1l8eENQiSrmpLa
 5ERv0WPQ++A5JwEN6wulgPTbsJ4QTFEkktEYL62O8gMO41XCp2Kk/68dXPPc97/UTFd8
 myOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Cv4Cn0M1qXagRSOgKePGgSRTT6tiF/GSi+0A4QzDuPw=;
 b=JkSJdX1CH67fs2XP6vmH9XUIIG2sHiZahnfIKEhOUKmxvx5fRk7AAK+4cIL6Bu7bAs
 B/gCkHdFrfkJ/4hbfn8JwdO/BYEKT8OxfmR9sHQkVEQcby+Pcnzr1GWdKs3oKqPyXoek
 DjKwoRZmVw9IpdXhp7EfbN/JK8drzT7q4pg+0UeLhz+ufWuDQvL/1iiZWiqWBptBLWFH
 ID+7f+JH0b+0YqEOoVCkXHUNFAm4avBbpteURcAI3Hj5z2Cfc8GplPKntkXulLAg27d5
 W2LW+wHCw5oULqcH5Jmtgg535Itxu9peT4BsDqdj9dSh+PTMn/EjCIf/NtFtCakpDz58
 T4Tw==
X-Gm-Message-State: AOAM531ZSpt64v2TCBQygyhW2E3k9zcBuQP+Vj7bAYUuxnQlnmBCUTGS
 PrvHQVcjuIzGPluFH1XmKpK8yZwlIp5bdLCOKTtnbg==
X-Google-Smtp-Source: ABdhPJxcHYzQ1PjLo7MSRBGtWy3uNvx7XVrNqf50o+/lSCKHw5P6cEGnL4sjqKYH/GowzrR3WiC72KcWnimremNHDVE=
X-Received: by 2002:aa7:dd4b:: with SMTP id o11mr15225149edw.251.1599481590264; 
 Mon, 07 Sep 2020 05:26:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200906201911.11814-1-pbonzini@redhat.com>
In-Reply-To: <20200906201911.11814-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 7 Sep 2020 13:26:19 +0100
Message-ID: <CAFEAcA-uc3QRW8T6nnrPsJuRQeeh--cz8gemr3YuUpAcYEgqpQ@mail.gmail.com>
Subject: Re: [PULL 00/45] Next round of Meson bugfixes and cleanups
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 6 Sep 2020 at 21:21, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The following changes since commit 227de21ed0759e275a469394af72c999d0134bb5:
>
>   Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20200903' into staging (2020-09-05 15:30:41 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to 17701f5a5d5ca20e9af8034b219c9b11c66f325a:
>
>   meson: remove linkage of sdl to baum (2020-09-06 22:07:58 +0200)
>
> ---------------------------------------------------------------

Windows: same mkdir() issue as previous version
OpenBSD: same epoxy/gl.h issue as previous version

all-linux-static config fails to link:

Linking target qemu-aarch64
/usr/bin/ld: cannot find -lepoxy
/usr/bin/ld: cannot find -lgbm
collect2: error: ld returned 1 exit status
Makefile.ninja:710: recipe for target 'qemu-aarch64' failed

thanks
-- PMM

