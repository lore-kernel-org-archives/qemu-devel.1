Return-Path: <SRS0=VLgg=X4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 636FBC32792
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 12:40:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E68720862
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 12:40:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y+/oYOBZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E68720862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iG0P7-0001Q6-Cj
	for qemu-devel@archiver.kernel.org; Thu, 03 Oct 2019 08:40:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45931)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iG0MP-0006tk-7v
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 08:37:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iG0MN-0005yd-L6
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 08:37:32 -0400
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e]:41892)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iG0MN-0005yJ-CI
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 08:37:31 -0400
Received: by mail-oi1-x22e.google.com with SMTP id w65so2406849oiw.8
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2019 05:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=0v+4JkKw7MrRnCAHBJnNveESM+njLQT6Mp5SQ1rrJHg=;
 b=y+/oYOBZSmaXhNSap1f3HLVtyPQZBM/XUTvIP2Yd+MbMpLF5VO7RB67GzB7g1ei9Zj
 19MzHrqW/dcmySVjLrhXOsbz9n6jNCWNUdY5fQmcWCSHRNtn/LC/yLDtdp4Vp+LywpFu
 AjcBFWr6BiyIaijy3iyz17DNPNIdW5oDivJYN3yHyza7KhA1ZJXjt46poT93+ecfhcSM
 vaq8KmPZRanaYSkA0tH2oj8EgB++EOaOFjPcNWhVMf/6mlo2CJPKADbQ7kZetGpuGI4i
 ORsvHh3T+2NnTdAueAbQxSi9vcmZ1gaItECQEXvOP9C+hHpu+Lfd8qeMdY4UoDqZyTRf
 Nmhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0v+4JkKw7MrRnCAHBJnNveESM+njLQT6Mp5SQ1rrJHg=;
 b=NcAA5NtqeLPwu698l6UQeOG8DAQWqw8XbzpDnoGahcXEDtir7x2G6GdPGDMgY53Byp
 E0O7uG4ISJwJp80TK4L2i2LPq9nPriyU6S2lEMJDb+ytUqG9dHlFAHFh/8pAogBcuRHC
 NlsZ0dSzB8/1KjpBlz7jp01yaktpsfjClhODs/I1FjAIrgGwUEpQ9eDGK7Ojskv8jEyK
 LVzxugS2HmC+8dr5UROXs4sbG38Pcp296QD2PfX4ilT+i8ZGL6EPulY/IW/dyL4LvZ0q
 tgGi95EmDVtr9IsuM4rFr5jY/6DDM/wzHil7TVYh6xh9iUJPiib1SyYo4vaX+OMEmvVO
 4vHg==
X-Gm-Message-State: APjAAAXEaQsHLxfSGM4CnH9LOS2zz5LLRHQk0TiKaaMY5D5xm6VzS9Qd
 aEcVatvsp52P5XNF0iLen+lBRCc8wIQ55je7orxxoGyYOUQ=
X-Google-Smtp-Source: APXvYqweaBS03CAUGfr0mveX33i3ZH/EN3mZsgpYBU20eSejQGGyUlCxLt+wUBwHPCfFDdejcP3LLHUI46jDZLxARCk=
X-Received: by 2002:aca:b48a:: with SMTP id d132mr2714239oif.98.1570106250252; 
 Thu, 03 Oct 2019 05:37:30 -0700 (PDT)
MIME-Version: 1.0
References: <1569942944-10381-1-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1569942944-10381-1-git-send-email-aleksandar.markovic@rt-rk.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 Oct 2019 13:37:19 +0100
Message-ID: <CAFEAcA9Hzq0NKoU5e_NdLXH0xvmaXeJAx3aAfVFXZeUqmP8sag@mail.gmail.com>
Subject: Re: [PULL 00/18] MIPS queue for October 1st, 2019
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22e
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
 Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 1 Oct 2019 at 16:15, Aleksandar Markovic
<aleksandar.markovic@rt-rk.com> wrote:
>
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>
> The following changes since commit 95e9d74fe4281f7ad79a5a7511400541729aa44a:
>
>   Merge remote-tracking branch 'remotes/borntraeger/tags/s390x-20190930' into staging (2019-09-30 14:21:56 +0100)
>
> are available in the git repository at:
>
>   https://github.com/AMarkovic/qemu tags/mips-queue-oct-01-2019
>
> for you to fetch changes up to 0a1bb9127ba66c093d5af395ea2630b06b929011:
>
>   target/mips: msa: Move helpers for <AND|NOR|OR|XOR>.V (2019-10-01 16:58:45 +0200)
>
> ----------------------------------------------------------------
>
> MIPS queue for October 1st, 2019
>
> Highlights:
>
>   - mostly cleanups related to "checkpatch.pl -f"
>   - slight optimization of handling of some MSA instructions
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

