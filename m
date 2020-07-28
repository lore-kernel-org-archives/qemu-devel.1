Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33FE0C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 18:27:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07FE020714
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 18:27:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TXoKFSgn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07FE020714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0UJw-0003wP-6O
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 14:27:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42330)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1k0UJ1-0003Ix-Lh; Tue, 28 Jul 2020 14:26:27 -0400
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:41969)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1k0UIz-0003mc-MS; Tue, 28 Jul 2020 14:26:27 -0400
Received: by mail-io1-xd41.google.com with SMTP id g19so9712159ioh.8;
 Tue, 28 Jul 2020 11:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=aS2VsUtNUODPave6ZqshCAXsSfCb+A90xwxLtadL3Vw=;
 b=TXoKFSgn05wYpc2zHYiK+KO+QOPnpYA8fLDAULjKdrN5MK8c2dN8mk2/9BPqloFscP
 ZWRureNpl/+Aq+7MJWCZ1Z6xY4pxMwqc+bLlH1EOYyAx1OsxbBnHr0qbCtW4buw1gzGz
 5IYp5WYVtHMeV63DuqcZpDddkOcxDnzjDwjWmByyryQP/3c8c5UA+NHCvwhQNW5dsBf6
 Zi7ablK4dAzMG4YDeOt5mguKy3V1/oVwHryVjcwmwA68Xv8BGCpBqBak+0vIN8Z4Dhkh
 AY9YHKraiY7L5FtgxBeQtf1EaC4A7LtnQwJqfScfLSmO7iz/ZUX7zCYI4Hp8wj9O6Xla
 ZPNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=aS2VsUtNUODPave6ZqshCAXsSfCb+A90xwxLtadL3Vw=;
 b=m4yjJU0VoBOg6taQWcYdGhkR3RWywwHpdrOZxozk4iEeuH8q1yc60crajfKDY1gpq/
 z4P+GAmaxbERgw0ele/oWp8wr11dZoJZP7l37RqwlTQwE+K2pn0fZmltghAR0wUz2ycu
 4K9XlDnYX8M+0UfzobBfW+5W0PmbTiwPV67kfQYFGrK09T5DZ4FI5tGnSaJodhrLRWVW
 d6W7Q3VA2vi+Rc6ytRenFcUeg9pj9PmtPbwN30rZW3/XbGLyokkIO9uh17YbOZNaAmeD
 dWsuZGzQMXG+4hjxLnbNCd4YLnSeMCuLFnahllOwJUezOxiIuUqlwgVj2IIJblOVEJSU
 NxPQ==
X-Gm-Message-State: AOAM5335/hX1FXHLnApFBPNm42mMdiS2kMjLCB2y5qr8HWzvQ/BFrge4
 UVcMIRQr1dHMLud63gMkdjohHAHs+pruXdJ6DUM=
X-Google-Smtp-Source: ABdhPJytdUEnv1mUnkZgQQgpRuLqZkJM2PnrnxP13pCehnb9WimlPePOSeQc1C9TwgEfEFTB85n1ROQC6WFxTZhWR4E=
X-Received: by 2002:a02:7092:: with SMTP id f140mr34717393jac.8.1595960784333; 
 Tue, 28 Jul 2020 11:26:24 -0700 (PDT)
MIME-Version: 1.0
References: <1594357499-29068-1-git-send-email-bmeng.cn@gmail.com>
 <1594357499-29068-5-git-send-email-bmeng.cn@gmail.com>
 <CAKmqyKM1m2j15ncbcW0rp5fk6FmbJ20uWOYUC40+v9PG=Hu7yQ@mail.gmail.com>
 <CAEUhbmWxCMZG+kdyqeSBrJPRf0Jvb7a4AcADuFXpRwQ7fb8zDA@mail.gmail.com>
 <CAEUhbmVJ94QF3UyEZUwcn-2yS4M3tKR-KOb4xPwSCwf9uRs-ww@mail.gmail.com>
 <CAKmqyKNJA0_5Qsfe6FZXSgNydxSHRXQQtqk8nB6-kR-yNpFHCQ@mail.gmail.com>
 <CAEUhbmXzufivy-7Qm-Nr6j6U9ynGOUgzV7XjXYDL_Ewcm1oj_g@mail.gmail.com>
In-Reply-To: <CAEUhbmXzufivy-7Qm-Nr6j6U9ynGOUgzV7XjXYDL_Ewcm1oj_g@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 28 Jul 2020 11:16:07 -0700
Message-ID: <CAKmqyKN-Ez_fE6oBfczxsGVyyRpeEE8go0pB-C7i6a4SALj8uA@mail.gmail.com>
Subject: Re: [PATCH v4 4/7] hw/riscv: Use pre-built bios image of generic
 platform for virt & sifive_u
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d41;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd41.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Bin Meng <bin.meng@windriver.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>, Anup Patel <anup@brainfault.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jul 28, 2020 at 8:46 AM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> Hi Alistair,
>
> On Tue, Jul 28, 2020 at 11:39 PM Alistair Francis <alistair23@gmail.com> wrote:
> >
> > On Wed, Jul 15, 2020 at 9:55 PM Bin Meng <bmeng.cn@gmail.com> wrote:
> > >
> > > Hi Alistair,
> > >
> > > On Mon, Jul 13, 2020 at 9:53 AM Bin Meng <bmeng.cn@gmail.com> wrote:
> > > >
> > > > On Sun, Jul 12, 2020 at 1:34 AM Alistair Francis <alistair23@gmail.com> wrote:
> > > > >
> > > > > On Thu, Jul 9, 2020 at 10:07 PM Bin Meng <bmeng.cn@gmail.com> wrote:
> > > > > >
> > > > > > From: Bin Meng <bin.meng@windriver.com>
> > > > > >
> > > > > > Update virt and sifive_u machines to use the opensbi fw_dynamic bios
> > > > > > image built for the generic FDT platform.
> > > > > >
> > > > > > Remove the out-of-date no longer used bios images.
> > > > > >
> > > > > > Signed-off-by: Bin Meng <bin.meng@windriver.com>
> > > > > > Reviewed-by: Anup Patel <anup@brainfault.org>
> > > > > > Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> > > > >
> > > > > This patch seems to break 32-bit Linux boots on the sifive_u and virt machines.
> > > > >
> > > >
> > > > It looks only Linux boot on sifive_u is broken. On our side, we have
> > > > been using VxWorks to test 32-bit OpenSBI on sifive_u so this issue
> > > > gets unnoticed. I will take a look.
> > >
> > > I've figured out the issue of 32-bit Linux booting failure on
> > > sifive_u. A patch has been sent to Linux upstream:
> > > http://lists.infradead.org/pipermail/linux-riscv/2020-July/001213.html
> >
> > Thanks for that. What change in QEMU causes this failure though?
> >
>
> There is nothing wrong in QEMU.

There is. This patch causes a regression for 32-bit Linux boot on the
sifive_u. Your v5 has not addressed this.

With this patch, the Linux boot stops here:

OpenSBI v0.8
   ____                    _____ ____ _____
  / __ \                  / ____|  _ \_   _|
 | |  | |_ __   ___ _ __ | (___ | |_) || |
 | |  | | '_ \ / _ \ '_ \ \___ \|  _ < | |
 | |__| | |_) |  __/ | | |____) | |_) || |_
  \____/| .__/ \___|_| |_|_____/|____/_____|
        | |
        |_|

Platform Name       : SiFive HiFive Unleashed A00
Platform Features   : timer,mfdeleg
Platform HART Count : 4
Boot HART ID        : 3
Boot HART ISA       : rv64imafdcsu
BOOT HART Features  : pmp,scounteren,mcounteren
BOOT HART PMP Count : 16
Firmware Base       : 0x80000000
Firmware Size       : 116 KB
Runtime SBI Version : 0.2

MIDELEG : 0x0000000000000222
MEDELEG : 0x000000000000b109
PMP0    : 0x0000000080000000-0x000000008001ffff (A)
PMP1    : 0x0000000000000000-0xffffffffffffffff (A,R,W,X)
[    0.000000] OF: fdt: Ignoring memory range 0x80000000 - 0x80200000
[    0.000000] Linux version 5.3.0 (oe-user@oe-host) (gcc version
9.2.0 (GCC)) #1 SMP Thu Sep 19 18:34:52 UTC 2019
[    0.000000] earlycon: sbi0 at I/O port 0x0 (options '')
[    0.000000] printk: bootconsole [sbi0] enabled
[    0.000000] initrd not found or empty - disabling initrd
[    0.000000] Zone ranges:
[    0.000000]   DMA32    [mem 0x0000000080200000-0x00000000bfffffff]
[    0.000000]   Normal   empty
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000080200000-0x00000000bfffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000080200000-0x00000000bfffffff]
[    0.000000] OF: fdt: Invalid device tree blob header
[    0.000000] software IO TLB: mapped [mem 0xbb1fe000-0xbf1fe000] (64MB)

Without this patch I can boot all the way to looking for a rootFS.

Please don't send new versions of patches without addresses regressions.

Alistair

>
> > There are lots of people not running the latest Linux from master that
> > this will cause breakages for.
>
> It's just that the 32-bit Linux defconfig has never been validated by
> people with 'sifive_u' machine. I bet people only validated the 32-bit
> kernel with the 'virt' machine.
>
> Regards,
> Bin

