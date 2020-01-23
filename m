Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92FDFC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 17:55:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6158B20718
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 17:55:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t3Ynoa5d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6158B20718
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iughM-0002vO-Vv
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 12:55:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35293)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iudci-0002C7-GC
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 09:38:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iudch-0002q4-6I
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 09:38:20 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:44607)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iudcg-0002pX-VT
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 09:38:19 -0500
Received: by mail-oi1-x241.google.com with SMTP id d62so3041071oia.11
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 06:38:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=SxFvWTbqkliLVKhnhsE0xivx5tRZL7ECHFqrg4zoCWs=;
 b=t3Ynoa5doxPYA1MNpIEqUKZpnmEB0pMKb4qWyR8hMx73z+z9UsQ1S8qqNleraxbpsi
 8AzKEaRbKO7Qn3hTuip1cbI0APNndmIGfxe78nsakW9fcveKMo+m0mYB1B/pbOpRtH13
 gt33uImtYAWCWRee0l/vKSuAwE5O1KSPV68q0ODTd4UdqIMHkH74HlafXiJ7Xg7g6OPy
 CcZoWeZ+Gnf4s8tPIC4szRfc0Q1XlOksjwzJLmma5AjDL3RHJOKxW8MqC/sNX1stSCFD
 Ok2nM4vtOG5Z+twN1pyQ+oClZ+NChhkv2HtqrYlXrEE9lb4PP4zD9l4iRW5RVfvqAvVB
 /U0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=SxFvWTbqkliLVKhnhsE0xivx5tRZL7ECHFqrg4zoCWs=;
 b=dTj7ytupuU06V4cHDYrJFoI9QuB8R3ofms6oPUThrmVK2AoZB7f8gauNIUrDnip71W
 Vwze+nhSSvcjCiuKNy3n6D/Dr6wrpVAWNnHJnpvwsxRVFsYxNugXFA8bvV+xbQhxyJUo
 51LVxNh21wGQSkLJaAX0ZSULix9cn2VXo+Cg6WrY9hUGSaeccQNmuZIfVpG6PnCwIvSn
 NCvgrzB9ZGxtNTEPc+sBdyDvpG4/kF5kvBbYI2uuNmaD5H/BgXspEWsgfeN0dvdE8PfM
 X97mTPxZnkclsL+UYfPsTKOqxn0i5w/eU4xmapSkJFAp0M1PzxbEdN0wxCeqgoXscWwW
 UhKw==
X-Gm-Message-State: APjAAAVRBw7HHuQ1pEPU/E4oLdY3pRrFgiPu+Hx1FUljFgHN7aeustgk
 LF/KYJQGbjpDuoAgFqGEkbhmnNUPnz8Voo7o5y9hiQ==
X-Google-Smtp-Source: APXvYqwmRX/ekW9qSc+JUdv/mcFo538k/U4O8bMIa0IjfUSOLLpJybO6Hyc8y5OzKWvvGF7r+igYZ16gv3ircPN0Ibk=
X-Received: by 2002:aca:3182:: with SMTP id
 x124mr10786904oix.170.1579790298104; 
 Thu, 23 Jan 2020 06:38:18 -0800 (PST)
MIME-Version: 1.0
References: <20200121225703.148465-1-palmerdabbelt@google.com>
In-Reply-To: <20200121225703.148465-1-palmerdabbelt@google.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 Jan 2020 14:38:07 +0000
Message-ID: <CAFEAcA9YoAjASu4F1hZRjbq5S+h8GtBUVb9dgecMdaWb9YENEw@mail.gmail.com>
Subject: Re: [PULL] RISC-V Patches for the 5.0 Soft Freeze, Part 1
To: Palmer Dabbelt <palmerdabbelt@google.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
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

On Tue, 21 Jan 2020 at 23:41, Palmer Dabbelt <palmerdabbelt@google.com> wrote:
>
> The following changes since commit 28b58f19d269633b3d14b6aebf1e92b3cd3ab56e:
>
>   ui/gtk: Get display refresh rate with GDK version 3.22 or later (2020-01-16 14:03:45 +0000)
>
> are available in the Git repository at:
>
>   git@github.com:palmer-dabbelt/qemu.git tags/riscv-for-master-5.0-sf1
>
> for you to fetch changes up to 82f014671cf057de51c4a577c9e2ad637dcec6f9:
>
>   target/riscv: update mstatus.SD when FS is set dirty (2020-01-16 10:03:15 -0800)
>
> ----------------------------------------------------------------
> RISC-V Patches for the 5.0 Soft Freeze, Part 1
>
> This patch set contains a handful of collected fixes that I'd like to target
> for the 5.0 soft freeze (I know that's a long way away, I just don't know what
> else to call these):
>
> * A fix for a memory leak initializing the sifive_u board.
> * Fixes to privilege mode emulation related to interrupts and fstatus.
>
> Notably absent is the H extension implementation.  That's pretty much reviewed,
> but not quite ready to go yet and I didn't want to hold back these important
> fixes.  This boots 32-bit and 64-bit Linux (buildroot this time, just for fun)
> and passes "make check".

Hi. This pull request doesn't seem to be signed with the GPG
key that I have on record for you...

thanks
-- PMM

