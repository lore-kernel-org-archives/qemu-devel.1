Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1B14C4332B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 15:19:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C3B920409
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 15:19:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r+RbF6Wl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C3B920409
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEwx9-0007g3-OT
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 11:19:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34080)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <linus.walleij@linaro.org>) id 1jEwwR-0007CB-Jl
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 11:18:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <linus.walleij@linaro.org>) id 1jEwwQ-0005NP-Ax
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 11:18:39 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:38417)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <linus.walleij@linaro.org>)
 id 1jEwwQ-0005Mu-2m
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 11:18:38 -0400
Received: by mail-lj1-x242.google.com with SMTP id w1so2924267ljh.5
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2020 08:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=DaeWC4paZt+okt8puKvfMsZYLYpCKtr88Og+vqz2+d0=;
 b=r+RbF6Wl+QIWtN5XgXv6Wy2ndXU5gukf1+a7pWlNOs5UXvn7YdvBmyG7iFWF9CF4n4
 vgfHfWQevvjEbPyyIS4sx0LC3EN1MjUwlF0qyHp7CCv2/hQP5Z9svKAN5/BVjjc+KWDZ
 /fzZtBSH8s8vEh6tIEXW181elPRKVfIZojEkMLhntKshIWE3NT18Zuyc7vQmkYGgA/Aa
 vZsJo7Zq9QZizRwSmR++Fe+dLqNFtNPcglCy3LBQr8z33Amddo3q87Qy8X0WaByIzVl6
 JsOtm8s3XVSXU2xlr7YxNgQC7oYoSlO4NDtBevbRaVGZ6HpBYe8GNq1cwZ+b3dqDWRVx
 /CDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=DaeWC4paZt+okt8puKvfMsZYLYpCKtr88Og+vqz2+d0=;
 b=QNdZ3vFRCuPjMlpQatMh5Z7Bk5xBa+IaAa6QBfyUeaWC//En9xqw7DJLo7AIP2z3bc
 xQpkyM8bsNxyzOJWHZEEjzT2NQn4G1R5833DbbWDSfg+IJYLpzmzUlkafFL2k39yGhsb
 qsh21mFn1AaMCT6hdspiepm/cMmMr06gU95zPdb5go913YeRT2WMHFnbGjbbeX/nICJ9
 Krm34GaO/zs+ksyTiVegm6H15PNzLJRUVmieqLrtPxJd277kYxeza9coUwQwpwzro4bu
 wrdKafATl/nm0I4y2I3PEVw8lvrCQxjEn3iVj7ySId0Y7CUazBrtojGkJnZeiPPvdSqW
 HqMw==
X-Gm-Message-State: ANhLgQ1MJL6tHrhjh6sFiimCi/H8xso10yUI5RNNXrnS5nQP/DqBXRgm
 EvyV1rzm8s5pYmif8I2KFlnaiOdxS//MHfnR+wI7Tw==
X-Google-Smtp-Source: ADFU+vvPeA7ClISh6i31iBhj6nefmh3Eg2iEFzmPH9zvoxRoXYDbUZ5mYl74GCE7OJXyqnP17DOPXATaVBvt+m4FxYI=
X-Received: by 2002:a2e:9a90:: with SMTP id p16mr2538498lji.277.1584631116087; 
 Thu, 19 Mar 2020 08:18:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200317113153.7945-1-linus.walleij@linaro.org>
 <88FAA4EA-7DAF-478F-8DFE-747FAF4CF818@dilger.ca>
In-Reply-To: <88FAA4EA-7DAF-478F-8DFE-747FAF4CF818@dilger.ca>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 19 Mar 2020 16:18:24 +0100
Message-ID: <CACRpkdbc=7Ozf472HGUZnQgWTJjoXuopts_EWLse__Ho4PZyRw@mail.gmail.com>
Subject: Re: [PATCH] ext4: Give 32bit personalities 32bit hashes
To: Andreas Dilger <adilger@dilger.ca>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::242
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Theodore Ts'o <tytso@mit.edu>,
 Linux API <linux-api@vger.kernel.org>, QEMU Developers <qemu-devel@nongnu.org>,
 stable <stable@vger.kernel.org>, Florian Weimer <fw@deneb.enyo.de>,
 Andy Lutomirski <luto@kernel.org>,
 Linux FS Devel <linux-fsdevel@vger.kernel.org>,
 linux-ext4 <linux-ext4@vger.kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Mar 17, 2020 at 11:29 PM Andreas Dilger <adilger@dilger.ca> wrote:

> That said, I'd think it would be preferable for ease of use and
> compatibility that applications didn't have to be modified
> (e.g. have QEMU or glibc internally set PER_LINUX32 for this
> process before the 32-bit syscall is called, given that it knows
> whether it is emulating a 32-bit runtime or not).

I think the plan is that QEMU set this, either directly when
you run qemu-user or through the binfmt handler.
https://www.kernel.org/doc/html/latest/admin-guide/binfmt-misc.html

IIUC the binfmt handler is invoked when you try to
execute ELF so-and-so-for-arch-so-and-so when you
are not that arch yourself. So that can set up this
personality.

Not that I know how the binfmt handler works, I am just
assuming that thing is some program that can issue
syscalls. It JustWorks for me after installing the QEMU
packages...

The problem still stands that userspace need to somehow
inform kernelspace that 32bit is going on, and this was the
best I could think of.

Yours,
Linus Walleij

