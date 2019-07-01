Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DA97C5B578
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 21:29:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3819A2064A
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 21:29:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v4EZ0Nbl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3819A2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hi3rc-0004Zy-EE
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 17:29:28 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48693)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hi3Lz-0007Ha-6K
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 16:56:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hi3Ls-0004tP-Hj
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 16:56:42 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:35681)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hi3Lq-0004qG-O1
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 16:56:39 -0400
Received: by mail-ot1-f68.google.com with SMTP id j19so14938155otq.2
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2019 13:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=W8795A1pwOViSCWz1XBqs1T8IqRWO2Ds5kmBMPEZLI4=;
 b=v4EZ0Nbl+SmW3fn/AY9Fg08WXYJ/sMj2juEwN3ISuBZPGAX1wGa6SH6F/VYHlnbEGC
 Clr5wTGQ5aU+0J8ObP9RfaGebhhAC3EB2bRsgXc1Yud0sV1VqvczITQWElDrA2QzRIPa
 cjUu7/Yv9qhe3kqBzOapCiTXzrMmR4MWDkUmlfPiC4Mctl3VXKiCvXGpSRptqRe874hN
 Pd59pRfSAxKAXNVUQs7ykPb7drHrRnYuxUuXIq8G8dIsRkiwEQBhSIzyj+3dJ9JiWm5P
 ZYcBBi0btbIl8Diw5loHeBR12Ggxn4AylD/6RMXycl3hOrKkaY9+dT4wd0I7HGKFj02Z
 Brmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=W8795A1pwOViSCWz1XBqs1T8IqRWO2Ds5kmBMPEZLI4=;
 b=D9g0a6Wdt0kxSaxQtDv4oysrdVwNIOKn6pRuKHz52G1PxJPFx8AozJA3DI6tmJR28C
 hA5m9MwjMMyr1Nj14KIbvz66+B4jk8k9DJfronXzTIUEu0fr3U9GDrpBWF9stEsT2umv
 dqU4Z6yXIjdstVggoPYO/S71p+Z5ytMowzRpZVBF0eOJUe4XV3u7EQzmGbP3/G04FRd2
 qsMEAh+qpoFzImkEXQ/0hI8ATocbzKmUI+8uUjjviD5Cm9UlIc6o6R88aYOwVJ7WUHT9
 byUJfqL1+uaE/WiZZS9/DSGpJw7Kzo59iS8g2UEEhtXtcofK2ahEuChVs4ymLs2E/9Yc
 54NA==
X-Gm-Message-State: APjAAAW5mGxCfklmL8SF1xqyBFR7ctHAm0tGNaaT1tDZXGTjJOd7j0gY
 yCUOr1pIAmtYz5orR3E6tSdMmgzOgAmzJUe5MNYewVQFqbU=
X-Google-Smtp-Source: APXvYqzT7KIi+tGQIrOHSMjSPbaI/TSJJW+3RrUrMt2b8Cyb6jjA/Tl4/JqMlccyz3LWeKBMXwCG81Quj+jm+RrmqvU=
X-Received: by 2002:a9d:7245:: with SMTP id a5mr21354692otk.232.1562000171096; 
 Mon, 01 Jul 2019 09:56:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190628173227.31925-1-palmer@sifive.com>
In-Reply-To: <20190628173227.31925-1-palmer@sifive.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 1 Jul 2019 17:55:59 +0100
Message-ID: <CAFEAcA_C8DM51ac-hOU++OUyMEdSgJQaEMnazsCDn3=Cb2vOqA@mail.gmail.com>
To: Palmer Dabbelt <palmer@sifive.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.210.68
Subject: Re: [Qemu-devel] [PULL] RISC-V Patches for the 4.1 Soft Freeze,
 Part 2 v2
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

On Fri, 28 Jun 2019 at 18:32, Palmer Dabbelt <palmer@sifive.com> wrote:
>
> merged tag 'mips-queue-jun-21-2019'
> The following changes since commit 474f3938d79ab36b9231c9ad3b5a9314c2aeacde:
>
>   Merge remote-tracking branch 'remotes/amarkovic/tags/mips-queue-jun-21-2019' into staging (2019-06-21 15:40:50 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/palmer-dabbelt/qemu.git tags/riscv-for-master-4.1-sf1-v2
>
> for you to fetch changes up to 56bf43fc565a2fa3e0a618ab45e1c82896d0782a:
>
>   hw/riscv: Load OpenSBI as the default firmware (2019-06-28 10:10:30 -0700)
>
> ----------------------------------------------------------------
> RISC-V Patches for the 4.1 Soft Freeze, Part 2 v2
>
> This pull request contains a handful of patches that I'd like to target
> for the 4.1 soft freeze.  There are a handful of new features:
>
> * The -bios option now works sanely, including both a built-in copy of
>   OpenSBI and the ability to load external versions.  Users no longer
>   need to figure out how to build their own firmware.
> * Support for the 1.11.0, the latest privileged specification.
> * Support for reading and writing the PRCI registers.
> * Better control over the ISA of the target machine.
> * Support for the cpu-topology device tree node.
>
> Additionally, there are a handful of bug fixes including:
>
> * Load reservations are now broken by both store conditional and by
>   scheduling, which fixes issues with parallel applications.
> * Various fixes to the PMP implementation.
> * Fixes to the 32-bit linux-user syscall ABI.
> * Various fixes for instruction decodeing.
> * A fix to the PCI device tree "bus-range" property.
>
> This boots 32-bit and 64-bit OpenEmbedded.
>
> Changes since v1 [riscv-for-master-4.1-sf1]:
>
> * Contains a fix to the sifive_u OpenSBI integration.

Hi; I had some comments about the opensbi blobs (and in particular
a question about the licensing), so I'm not going to apply this.
You might want to send a v2 which has everything except the new
blobs, while we figure out what we want to do about them.

thanks
-- PMM

