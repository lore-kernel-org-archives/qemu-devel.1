Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DFE4C433E7
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 07:26:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 601C022244
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 07:26:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ANckZpvS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 601C022244
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55844 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQmnn-0005K8-EP
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 03:26:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36020)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kQmn3-0004uS-3R
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 03:26:09 -0400
Received: from mail-yb1-xb43.google.com ([2607:f8b0:4864:20::b43]:32884)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kQmmx-000650-09
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 03:26:08 -0400
Received: by mail-yb1-xb43.google.com with SMTP id c3so6554517ybl.0
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2020 00:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=vFplZKhhVDbkXyNgMBGgN6B7vlMdbvNAyiPS+SVtwDE=;
 b=ANckZpvSK2nZgCwS1TUnEEDa7pZbWY3L/EwYdcXETD1qu1PUKcVTfjd/ZFjYPaohZu
 6xPzfBCjCydzaT4XfVbLX9T2vXdJb3EvWcDhk69Ua3jizYJIwrVfsUEZXokSRnLuNbIf
 CIiW3BqOgIvkFEVQscrVIMe5cnk6TJ5A3DM2mluqjT9NI5Jvns+FYToPZ6viIwB0iptl
 wteGzru/OYY0/5sDsDavarvd2zsmW1tTSGa7vWzqax/Y86WExTbSrzyCRRfC3hmbkIoM
 sRwg7H2ICAuQ4q8qah2361OAKYnOaglEWHgsCssQvLebMuS/3RzD/tPkUXfkpFI0ewDy
 q62w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=vFplZKhhVDbkXyNgMBGgN6B7vlMdbvNAyiPS+SVtwDE=;
 b=eTh+MtwN/dCkyxKq0ytZqubXdCoclY+nvaf9soacFv1z/Kz9fAx2YvuJCis5+sd14+
 Shwrltcc7zZfQxmKxAY6YU03mLJ0j0gjDoreFkrv2HMXJOKg3k04+cWMCgsH4CyYtx/A
 E9/nMYtuhXO/AGerK6oq5a+DGlFnG2p7DCrXpXKtxMf8JizdOgiQN82QPZtatLEYWBz/
 mIItO8ugYgEh6wzMudevm7/kp2jPSDw1zfJMbpm8GTmL4MJmm/RF0PcHLRDjpDFc+Gvt
 MQrxgN37EVLqMwfs8FHzZXzQDe03+qdmCk7SfzbFNT8ZW0Y+EFj+OXb/+zY8uDBSqAl2
 e6Ow==
X-Gm-Message-State: AOAM53371RK/GPezNStE4Ammyon49Jahp1YD1PDM32ZosC5KxhJM5jN2
 wnbMVGtEn29BixtqhUgrncnf+YDQ7IM9n3sH0NDWJ19Ljzg=
X-Google-Smtp-Source: ABdhPJyFtd79L4a+nLjAYgjgNh6ditJApE8B7IKHjLBUWQaaVQaMTGCx4ugyR0lL+e8i+qGN8q1IEZEomXSz2JhcAWs=
X-Received: by 2002:a25:705:: with SMTP id 5mr16496211ybh.239.1602228361776;
 Fri, 09 Oct 2020 00:26:01 -0700 (PDT)
MIME-Version: 1.0
References: <160208094339.8985.13177411264868514958.malonedeb@wampee.canonical.com>
In-Reply-To: <160208094339.8985.13177411264868514958.malonedeb@wampee.canonical.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Fri, 9 Oct 2020 15:25:50 +0800
Message-ID: <CAEUhbmU3fjgVT3_cLEo6AyDW6KtUgO+tvSX5uEoBu2+1k21Dtg@mail.gmail.com>
Subject: Re: [Bug 1898883] [NEW] qemu-system-riscv64 failed to load binary
 kernel into memory
To: Bug 1898883 <1898883@bugs.launchpad.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b43;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yb1-xb43.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Oct 7, 2020 at 10:37 PM Azuk 443 <1898883@bugs.launchpad.net> wrote=
:
>
> Public bug reported:
>
> QEMU Version: 5.1.0
> Compiled in Ubuntu 20.04 for riscv64, following the guide https://risc-v-=
getting-started-guide.readthedocs.io/en/latest/linux-qemu.html.
>
> In qemu-system-riscv64, code at 0x80000000 will be executed by virtual CP=
U.
> For example, using `qemu-system-riscv64 -nographic -machine virt -bios no=
ne -kernel vmlinux -S -s`, my homebrew kernel(ELF file) will load at 0x8000=
0000. If I strip the kernel using `riscv64-linux-gnu-objcopy -O binary vmli=
nux Image`, qemu-system-riscv64 will not load the binary machine code into =
the riscv64 load address, but `-bios Image` will.

This is not a bug. As you said, please use `-bios Image` for your
special purpose.

>
> In `qemu-system-aarch64` compiled by Ubuntu team, I can use `qemu-
> system-aarch64 -M raspi3 -kernel Image_aarch64 -S -s` to load a specific
> machine code binary into 0x80000. And the elf kernel can be loaded to
> that address, too.
>
> ** Affects: qemu
>      Importance: Undecided
>          Status: New
>

Regards,
Bin

