Return-Path: <SRS0=SwYc=4S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5923C3F2C6
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2020 02:48:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90D40205ED
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2020 02:48:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YVX6FvKe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90D40205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8EeL-0003Cq-Nz
	for qemu-devel@archiver.kernel.org; Sat, 29 Feb 2020 21:48:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52548)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1j8Ede-0002jE-Ex
 for qemu-devel@nongnu.org; Sat, 29 Feb 2020 21:47:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1j8Edd-0004yS-JL
 for qemu-devel@nongnu.org; Sat, 29 Feb 2020 21:47:30 -0500
Received: from mail-yw1-xc41.google.com ([2607:f8b0:4864:20::c41]:34197)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1j8Edd-0004x8-Fn; Sat, 29 Feb 2020 21:47:29 -0500
Received: by mail-yw1-xc41.google.com with SMTP id o186so3275978ywc.1;
 Sat, 29 Feb 2020 18:47:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=8Zk6LwQkCbTAFDgmH20wZ95BD5HxONYhLA94/WbCjM8=;
 b=YVX6FvKepm/Wyeosu5K+zuPCeX79G3t+IFrCyv/FRkNU6GA+wD+xUTQetH38g/WXMv
 orTFocxMJdvK0qLIBwtLnmEetLHHa11RjIU3lx3PLEwbZH68gHaf30S6PLpYjfFYPqG1
 idBJSaAX7nMtN8iQQIjyJCIjAcq8SPvyVF+X8JzhCxVzHRPD7cw5HCSZTvcM1WRXQ59G
 KjLooEO1dCbhEORumVqKemwmVod4bdYH2SUmmegeHVguqvmIkNgV3P+70RSY+DX/EhCz
 q2AkKZk+PeJ5i7vkAZjoP610jaLLfgbHY2yx5AzB3U6po9xCBmo61vWA935iuTet8Y6f
 /7IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=8Zk6LwQkCbTAFDgmH20wZ95BD5HxONYhLA94/WbCjM8=;
 b=tzsGB9qg2nxnXhowZy8uiPSUHgzpST/CGwnigUOpsdxPmRKZlzhYhIESuzJqR7RIgX
 egOE57iTmmWKuVDQifik869wuuOt184QufLhN+WDVw1SvDrOuTxIUulkNgpeldru64/9
 Yb6ZZoppTHT00+L32H8TK93ZVckBOu1QZ09QBx3RYxN42nmUpmISkjPd5DElpeXW3BUz
 x3YdLpfCp7paWb1u/UX5zs64t6fzM6rTY33fMU+haZxrBBtLv1OYBM9YWRzPxjtWtFY1
 0JUfLisl891nSjihD3yEnJP3+KvY5G8G+5qggI/xBj3MkOOQoN6YZO4gLqoklvBBYhDt
 bfDA==
X-Gm-Message-State: APjAAAUkEBiPheP3q5BpQ970UWDY6LW9O4ZFrIl78XcHw3FBtUxR29HP
 zs2Q8xC75C1cF50UwmBdrkPwJmaicU9xrzniG3Y=
X-Google-Smtp-Source: APXvYqyFRbY1N71eVk2i7Ji2mmy17JeWjQVaePJwHgQiLQ17DxKtL+nJrYZW5t5SnlqvuEu1HgbGgUxuUyTNz67+s2I=
X-Received: by 2002:a25:38c2:: with SMTP id
 f185mr10455420yba.490.1583030848577; 
 Sat, 29 Feb 2020 18:47:28 -0800 (PST)
MIME-Version: 1.0
References: <1582551584-20093-1-git-send-email-bmeng.cn@gmail.com>
In-Reply-To: <1582551584-20093-1-git-send-email-bmeng.cn@gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Sun, 1 Mar 2020 10:47:18 +0800
Message-ID: <CAEUhbmVHVcvSJrhAQ3+5KnO8biBNR69AS-x8oRzVA7PKdPRWWg@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] riscv: Upgrade OpenSBI to v0.6 and add 32-bit
 sifive_u bios image
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, 
 Alistair Francis <Alistair.Francis@wdc.com>, 
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>, 
 Sagar Karandikar <sagark@eecs.berkeley.edu>, 
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c41
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Palmer,

On Mon, Feb 24, 2020 at 9:40 PM Bin Meng <bmeng.cn@gmail.com> wrote:
>
>
> This series advances the roms/opensbi submodule to the v0.6 release,
> and builds and captures platform firmware binaries from that release.
>
> A 32-bit sifive_u bios image has also been added, so that we can have
> 32-bit test coverage for SiFive specific drivers that cannot be done
> with the 'virt' machine.
>
> Two GitLab CI jobs are added to build the OpenSBI firmware binaries.
>
> Changes in v2:
> - new patch: Upgrade opensbi from v0.5 to v0.6
> - Update the 32-bit sifive_u bios image to OpenSBI v0.6
> - new patch: Add GitLab jobs to build OpenSBI firmware binaries
>

Would you please take this series for the next PR?

Regards,
Bin

