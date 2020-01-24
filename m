Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D780BC2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 13:23:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1D472075D
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 13:23:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I4ZoS0q4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1D472075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuyw5-0004qH-TF
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 08:23:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60661)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iuyvN-0004RK-5H
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 08:23:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iuyvM-00045u-16
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 08:23:01 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:45238)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iuyvL-00044q-RX
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 08:22:59 -0500
Received: by mail-ot1-x342.google.com with SMTP id 59so1537151otp.12
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2020 05:22:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ZfZNubndxTwD4Z8P2Tco1rSJrq5QdrlRCT/CLQh4dE4=;
 b=I4ZoS0q4pCnJRQsZUdPYyd3lf2TPU4W/U1Htw7LmEib8X67qeZ8QBbFkXzSlIJc9Rs
 I9s+gbvyUCrurSAi6eZm+g67aDzs3tl/71q0d2gyvVHs+OehE2ypaUMUjNmUuqBMMQIr
 I83t46C4fzLD7t15OqmZ+1Xpr8ioDR2nNUCsjjuCxMBcASHe6gAX3hG3n/dtfNtiwPTm
 Ws+wINmTdUT2/028tRJc+dy4dc79MdCl+f0CE90nqwgklVUsEvZafXT8BRbr1BCs9ci/
 5GcUSpWLmejKqERrjQSMv596u23feZ5XFqdQL+PNZEeSBv8HJO5z32eZVW1eu9Itc9jJ
 8mig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZfZNubndxTwD4Z8P2Tco1rSJrq5QdrlRCT/CLQh4dE4=;
 b=GOJFZ2/CWHoZZCuc6LunyRC0fcZ5CcTh3/2ZAXUQWKt9jOd36imE0aZdIP/PSNaBye
 DcEU1T6n0nndmrEC7Q/kZ3GkR5QNtgLf4NrnrsVAinUzhwcSb5NQLc2jyIMDXo5yVSeV
 w21FX3lve6QziU6pY4uLk/e7Q5mXA/qPhRkDbdebA3N2SiAbC/dKAm+Jmub/Ark+ZkGU
 g6W8+Z9R+Y8lA/8IuFzRbXIayHTPchiHTHlPy47icm9TcuLKSr/vE0ndjte4S96RJXRl
 +3d2N5sI0xv3uLV4ii4wYfYqq+SU4HiNj0kchmi672wtHww+vFTs1/PsjzFaDEnMp4P+
 fL6w==
X-Gm-Message-State: APjAAAWJFS6gpPC+UNDMD9iiQG59A1RIM5FXRzyUwLh065EW3Z4/D1p9
 rYmW03kr4O41i4MyO5jkt4KDijnv9WgeQFSOQKK4/w==
X-Google-Smtp-Source: APXvYqwIA+fB1f41fYWZjwTmvfA+wnNJbKU7duh3cS62X45h0e6LDzN73JAFZ8eoQeMzeaCFWThKWq6PsEzYsGWMA9o=
X-Received: by 2002:a05:6830:4a4:: with SMTP id
 l4mr2638018otd.91.1579872178423; 
 Fri, 24 Jan 2020 05:22:58 -0800 (PST)
MIME-Version: 1.0
References: <20200121225703.148465-1-palmerdabbelt@google.com>
In-Reply-To: <20200121225703.148465-1-palmerdabbelt@google.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Jan 2020 13:22:47 +0000
Message-ID: <CAFEAcA_UKdGYLRPQd2rChqG5vJ=OCsjRzGNf1j3VcJznJ4YLxQ@mail.gmail.com>
Subject: Re: [PULL] RISC-V Patches for the 5.0 Soft Freeze, Part 1
To: Palmer Dabbelt <palmerdabbelt@google.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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
>
> ----------------------------------------------------------------
> Pan Nengyuan (1):
>       riscv/sifive_u: fix a memory leak in soc_realize()
>
> ShihPo Hung (3):
>       target/riscv: Fix tb->flags FS status
>       target/riscv: fsd/fsw doesn't dirty FP state
>       target/riscv: update mstatus.SD when FS is set dirty
>
> Yiting Wang (1):
>       riscv: Set xPIE to 1 after xRET
>

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

