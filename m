Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C199C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 04:52:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB5562076E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 04:52:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gqQIShTK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB5562076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0e4Y-0002Dc-Uu
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 00:52:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34460)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1k0e3g-0001Cw-7E; Wed, 29 Jul 2020 00:51:16 -0400
Received: from mail-yb1-xb41.google.com ([2607:f8b0:4864:20::b41]:38654)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1k0e3d-0004PN-PQ; Wed, 29 Jul 2020 00:51:15 -0400
Received: by mail-yb1-xb41.google.com with SMTP id d133so9918412ybh.5;
 Tue, 28 Jul 2020 21:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=s60jSJJ/3cxrSnbF5oaXBs/Z8ZYWzPit+/YHasxxZpg=;
 b=gqQIShTKeWIWBE/ohzNWmHqlst3OVqOwNrPH8hsedfHBMYOK+bABndbOtpN6HOLUdN
 MTZlQRxzQNmJbT9ZUSZvPYC96MGvUDRRdozjACTwDhJAwPY9Jqj5nRYJBVlHhoMfGN4L
 1Zr4q0fAVCh9S/GVzVsjVBtyqpx3w5eJAZ4jE1sLkC2FAhl/qGlb4MdTa5PRUYxH8n43
 u/Ak6d5W9foh5DS3wGkV1/7KhfqSldNZp08t2PQakGC5CmwwhDwJVwHSpsbCzpXxmjWf
 dw9TQjTiJ2VssfagEnOSzIC3FbkEopqxzZ4fBXp/GeBtrY0C07hhz6TQtjv6khwUMyfm
 MZww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=s60jSJJ/3cxrSnbF5oaXBs/Z8ZYWzPit+/YHasxxZpg=;
 b=mkbQqWgm4XeAvMiv+KoQuLnk0KlYMu0BoEhVMxbXSA1A0tYw57I/byGwHq2DvG1bTW
 cy+zjUttZgIp7oGmjV4AyhK/+niIaDLcWRVAD1BwongvKYZiAqb9W51JSLj9IXhyv9gz
 faAdtyAfZIQGxga5IftHasZebxT25WkE7MxtXckJuwIQuHZudhkxlH/YbV+T53dABhgK
 knvKJJnoQbVQdaCoBJIsC0BV6bqDi/zyRzFXHIdvkwBcytRzv2v1a6AWfoudeKZnTvxM
 2YZiDduOiFW787j2DYABvd59J4w71DkXLNTMCFv14eZNsCClLEEACE2e/r5xr5Ea+/pj
 OBjw==
X-Gm-Message-State: AOAM531R0OqABE0zhSy99ILDuW6aE9HvuJN0HiJzgiukiAYmt0MUaPMW
 wCbTFpDSTEnY7ySQYzYvBe4RoaPBbGChIHjK3Fo=
X-Google-Smtp-Source: ABdhPJzKf+7JJJj3DqCL2DvrE7utAQ7Am9HgubU5SJYkncird9UI1taBbPeEBaR/g2xopBzBQGTEkXNW3u34sSWqo3I=
X-Received: by 2002:a25:3b0d:: with SMTP id i13mr22763734yba.314.1595998272231; 
 Tue, 28 Jul 2020 21:51:12 -0700 (PDT)
MIME-Version: 1.0
References: <1594357499-29068-1-git-send-email-bmeng.cn@gmail.com>
 <1594357499-29068-5-git-send-email-bmeng.cn@gmail.com>
 <CAKmqyKM1m2j15ncbcW0rp5fk6FmbJ20uWOYUC40+v9PG=Hu7yQ@mail.gmail.com>
 <CAEUhbmWxCMZG+kdyqeSBrJPRf0Jvb7a4AcADuFXpRwQ7fb8zDA@mail.gmail.com>
 <CAEUhbmVJ94QF3UyEZUwcn-2yS4M3tKR-KOb4xPwSCwf9uRs-ww@mail.gmail.com>
 <CAKmqyKNJA0_5Qsfe6FZXSgNydxSHRXQQtqk8nB6-kR-yNpFHCQ@mail.gmail.com>
 <CAEUhbmXzufivy-7Qm-Nr6j6U9ynGOUgzV7XjXYDL_Ewcm1oj_g@mail.gmail.com>
 <CAKmqyKN-Ez_fE6oBfczxsGVyyRpeEE8go0pB-C7i6a4SALj8uA@mail.gmail.com>
In-Reply-To: <CAKmqyKN-Ez_fE6oBfczxsGVyyRpeEE8go0pB-C7i6a4SALj8uA@mail.gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Wed, 29 Jul 2020 12:51:00 +0800
Message-ID: <CAEUhbmX5rcMuD8F30wdgYrvUq6NU84t5o=VkgKqwvwyfmA9e+w@mail.gmail.com>
Subject: Re: [PATCH v4 4/7] hw/riscv: Use pre-built bios image of generic
 platform for virt & sifive_u
To: Alistair Francis <alistair23@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b41;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yb1-xb41.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hi Alistair,

On Wed, Jul 29, 2020 at 2:26 AM Alistair Francis <alistair23@gmail.com> wrote:
>
> On Tue, Jul 28, 2020 at 8:46 AM Bin Meng <bmeng.cn@gmail.com> wrote:
> >
> > Hi Alistair,
> >
> > On Tue, Jul 28, 2020 at 11:39 PM Alistair Francis <alistair23@gmail.com> wrote:
> > >
> > > On Wed, Jul 15, 2020 at 9:55 PM Bin Meng <bmeng.cn@gmail.com> wrote:
> > > >
> > > > Hi Alistair,
> > > >
> > > > On Mon, Jul 13, 2020 at 9:53 AM Bin Meng <bmeng.cn@gmail.com> wrote:
> > > > >
> > > > > On Sun, Jul 12, 2020 at 1:34 AM Alistair Francis <alistair23@gmail.com> wrote:
> > > > > >
> > > > > > On Thu, Jul 9, 2020 at 10:07 PM Bin Meng <bmeng.cn@gmail.com> wrote:
> > > > > > >
> > > > > > > From: Bin Meng <bin.meng@windriver.com>
> > > > > > >
> > > > > > > Update virt and sifive_u machines to use the opensbi fw_dynamic bios
> > > > > > > image built for the generic FDT platform.
> > > > > > >
> > > > > > > Remove the out-of-date no longer used bios images.
> > > > > > >
> > > > > > > Signed-off-by: Bin Meng <bin.meng@windriver.com>
> > > > > > > Reviewed-by: Anup Patel <anup@brainfault.org>
> > > > > > > Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> > > > > >
> > > > > > This patch seems to break 32-bit Linux boots on the sifive_u and virt machines.
> > > > > >
> > > > >
> > > > > It looks only Linux boot on sifive_u is broken. On our side, we have
> > > > > been using VxWorks to test 32-bit OpenSBI on sifive_u so this issue
> > > > > gets unnoticed. I will take a look.
> > > >
> > > > I've figured out the issue of 32-bit Linux booting failure on
> > > > sifive_u. A patch has been sent to Linux upstream:
> > > > http://lists.infradead.org/pipermail/linux-riscv/2020-July/001213.html
> > >
> > > Thanks for that. What change in QEMU causes this failure though?
> > >
> >
> > There is nothing wrong in QEMU.
>
> There is. This patch causes a regression for 32-bit Linux boot on the
> sifive_u. Your v5 has not addressed this.

The 32-bit Linux boot failure was fixed by:
http://lists.infradead.org/pipermail/linux-riscv/2020-July/001213.html

What additional issue did you see?

>
> With this patch, the Linux boot stops here:
>
> OpenSBI v0.8
>    ____                    _____ ____ _____
>   / __ \                  / ____|  _ \_   _|
>  | |  | |_ __   ___ _ __ | (___ | |_) || |
>  | |  | | '_ \ / _ \ '_ \ \___ \|  _ < | |
>  | |__| | |_) |  __/ | | |____) | |_) || |_
>   \____/| .__/ \___|_| |_|_____/|____/_____|
>         | |
>         |_|
>
> Platform Name       : SiFive HiFive Unleashed A00
> Platform Features   : timer,mfdeleg
> Platform HART Count : 4
> Boot HART ID        : 3
> Boot HART ISA       : rv64imafdcsu

This is a 64-bit hardware.

> BOOT HART Features  : pmp,scounteren,mcounteren
> BOOT HART PMP Count : 16
> Firmware Base       : 0x80000000
> Firmware Size       : 116 KB
> Runtime SBI Version : 0.2
>
> MIDELEG : 0x0000000000000222
> MEDELEG : 0x000000000000b109
> PMP0    : 0x0000000080000000-0x000000008001ffff (A)
> PMP1    : 0x0000000000000000-0xffffffffffffffff (A,R,W,X)
> [    0.000000] OF: fdt: Ignoring memory range 0x80000000 - 0x80200000
> [    0.000000] Linux version 5.3.0 (oe-user@oe-host) (gcc version

It seems that you are using quite an old kernel. Can you please try
the latest version?

> 9.2.0 (GCC)) #1 SMP Thu Sep 19 18:34:52 UTC 2019
> [    0.000000] earlycon: sbi0 at I/O port 0x0 (options '')
> [    0.000000] printk: bootconsole [sbi0] enabled
> [    0.000000] initrd not found or empty - disabling initrd
> [    0.000000] Zone ranges:
> [    0.000000]   DMA32    [mem 0x0000000080200000-0x00000000bfffffff]
> [    0.000000]   Normal   empty
> [    0.000000] Movable zone start for each node
> [    0.000000] Early memory node ranges
> [    0.000000]   node   0: [mem 0x0000000080200000-0x00000000bfffffff]
> [    0.000000] Initmem setup node 0 [mem 0x0000000080200000-0x00000000bfffffff]
> [    0.000000] OF: fdt: Invalid device tree blob header
> [    0.000000] software IO TLB: mapped [mem 0xbb1fe000-0xbf1fe000] (64MB)
>
> Without this patch I can boot all the way to looking for a rootFS.
>
> Please don't send new versions of patches without addresses regressions.

The patches were sent after addressing all regressions you reported
(well the 32-bit Linux booting issue is actually not a QEMU
regression, but one that exists in the Linux kernel side for a long
time).

I just tested 64-bit Linux boot on both virt and sifive_u, and they
both can boot all the way to looking for a root fs.

Regards,
Bin

