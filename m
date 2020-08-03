Return-Path: <SRS0=TdIk=BN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E447CC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 06:52:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D2DE206E9
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 06:52:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XnwD3XNv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D2DE206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2ULC-00050c-Hq
	for qemu-devel@archiver.kernel.org; Mon, 03 Aug 2020 02:52:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50052)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1k2UJr-000455-Fw; Mon, 03 Aug 2020 02:51:35 -0400
Received: from mail-yb1-xb41.google.com ([2607:f8b0:4864:20::b41]:35936)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1k2UJp-0001Fz-1D; Mon, 03 Aug 2020 02:51:35 -0400
Received: by mail-yb1-xb41.google.com with SMTP id n141so17437186ybf.3;
 Sun, 02 Aug 2020 23:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=0J6c4aFAI+42R8anVtsHXp+lWUTw2bvT8F7DupLc2hg=;
 b=XnwD3XNvGXHx5SVD24BaRrBiFEQLC2BEyH5JRwrbAbvT/Ls3CgxSTwoBZdsShVKsVl
 3Ue5+ucEfVamDId3XruTO54tKPsR6jVWC4gx1F48XpdMkA9Ib5S6YZTF4xtLdp4dogeO
 +ndofBLbWTSvbg50GQuSjPP2PZ9Km/V/IxC2Xbz0KzU0wm1+hjdJZK3dVGGZIiwqAr7Q
 muzr6oRFPLH3R6L6vKsoCBac4vQ6/PLHK6F6bNxC+eICD7GkukRweZv9HMdvmTimYo3m
 hL2tpN0dGEP7RJUrEZP0g39196j4WIwnf6u34i0/Qq2xdCjQrbv2sdhcKbGyKO6fUtY3
 mTuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0J6c4aFAI+42R8anVtsHXp+lWUTw2bvT8F7DupLc2hg=;
 b=gbKwPWsVS/jQYAUhuh4WXcOJ9gF4xm0XzxMX2MTOUZWVhQrRbUmxxF4ND2ewVDyNMa
 mYNrUo/p/sOK1Djp9y2guk1Qt9gOHAYLVEV4ZLeApolD7EkeuHHKHRSiDgETa2OI7T3h
 weMKuge/2cuCnAwjItqKS5+RVLnx7tUGkDUuSKuT3xyri7NswrJnf6TktEbNiXvepFUi
 OOYe33kkuxoYROsP5IypEDGHj79U8cN369l7LIzDfI7AHqOtFqfSMMY8la1OyAgaM0vi
 EpcwJYgfB6mqPv+tRX1k0qP4booYjzZ5J3Wa9z5QT0P3mEFM6J0/eVwtyxvoa6AVYI9W
 38bA==
X-Gm-Message-State: AOAM531be1uItgP9i/42+s8/7gVID81xQs6ngU7ggvnrDFQS0umyko8i
 3GlJF4jJ2RaLuDvUxClpkk122xljqIinPX3oq24=
X-Google-Smtp-Source: ABdhPJxhfC/XNcS5/R9Z5VYN5eIK1On6E1GvI2XdRhoEh8yQfxMcKnZNT/2bYFra14xRBcoWGraB3UKcPQ/tnVqFuqg=
X-Received: by 2002:a25:6b04:: with SMTP id g4mr5898703ybc.387.1596437490951; 
 Sun, 02 Aug 2020 23:51:30 -0700 (PDT)
MIME-Version: 1.0
References: <1594357499-29068-1-git-send-email-bmeng.cn@gmail.com>
 <1594357499-29068-5-git-send-email-bmeng.cn@gmail.com>
 <CAKmqyKM1m2j15ncbcW0rp5fk6FmbJ20uWOYUC40+v9PG=Hu7yQ@mail.gmail.com>
 <CAEUhbmWxCMZG+kdyqeSBrJPRf0Jvb7a4AcADuFXpRwQ7fb8zDA@mail.gmail.com>
 <CAEUhbmVJ94QF3UyEZUwcn-2yS4M3tKR-KOb4xPwSCwf9uRs-ww@mail.gmail.com>
 <CAKmqyKNJA0_5Qsfe6FZXSgNydxSHRXQQtqk8nB6-kR-yNpFHCQ@mail.gmail.com>
 <CAEUhbmXzufivy-7Qm-Nr6j6U9ynGOUgzV7XjXYDL_Ewcm1oj_g@mail.gmail.com>
 <CAKmqyKN-Ez_fE6oBfczxsGVyyRpeEE8go0pB-C7i6a4SALj8uA@mail.gmail.com>
 <CAEUhbmX5rcMuD8F30wdgYrvUq6NU84t5o=VkgKqwvwyfmA9e+w@mail.gmail.com>
 <CAKmqyKNDTOKeb+5h5NuJcYWMRoS24H=ski6Jau84uEEx46Ep9Q@mail.gmail.com>
 <CAEUhbmVK7DMT_MpHtOsS45fZZ58OaAW1a=hWk=4vNY-Ph2XvmA@mail.gmail.com>
In-Reply-To: <CAEUhbmVK7DMT_MpHtOsS45fZZ58OaAW1a=hWk=4vNY-Ph2XvmA@mail.gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Mon, 3 Aug 2020 14:51:19 +0800
Message-ID: <CAEUhbmV7wJ7mBKwv+WbfFDOuPmLDUzua7kdwSWvYengub6jYEw@mail.gmail.com>
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

On Wed, Jul 29, 2020 at 1:10 PM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> Hi Alistair,
>
> On Wed, Jul 29, 2020 at 1:05 PM Alistair Francis <alistair23@gmail.com> wrote:
> >
> > On Tue, Jul 28, 2020 at 9:51 PM Bin Meng <bmeng.cn@gmail.com> wrote:
> > >
> > > Hi Alistair,
> > >
> > > On Wed, Jul 29, 2020 at 2:26 AM Alistair Francis <alistair23@gmail.com> wrote:
> > > >
> > > > On Tue, Jul 28, 2020 at 8:46 AM Bin Meng <bmeng.cn@gmail.com> wrote:
> > > > >
> > > > > Hi Alistair,
> > > > >
> > > > > On Tue, Jul 28, 2020 at 11:39 PM Alistair Francis <alistair23@gmail.com> wrote:
> > > > > >
> > > > > > On Wed, Jul 15, 2020 at 9:55 PM Bin Meng <bmeng.cn@gmail.com> wrote:
> > > > > > >
> > > > > > > Hi Alistair,
> > > > > > >
> > > > > > > On Mon, Jul 13, 2020 at 9:53 AM Bin Meng <bmeng.cn@gmail.com> wrote:
> > > > > > > >
> > > > > > > > On Sun, Jul 12, 2020 at 1:34 AM Alistair Francis <alistair23@gmail.com> wrote:
> > > > > > > > >
> > > > > > > > > On Thu, Jul 9, 2020 at 10:07 PM Bin Meng <bmeng.cn@gmail.com> wrote:
> > > > > > > > > >
> > > > > > > > > > From: Bin Meng <bin.meng@windriver.com>
> > > > > > > > > >
> > > > > > > > > > Update virt and sifive_u machines to use the opensbi fw_dynamic bios
> > > > > > > > > > image built for the generic FDT platform.
> > > > > > > > > >
> > > > > > > > > > Remove the out-of-date no longer used bios images.
> > > > > > > > > >
> > > > > > > > > > Signed-off-by: Bin Meng <bin.meng@windriver.com>
> > > > > > > > > > Reviewed-by: Anup Patel <anup@brainfault.org>
> > > > > > > > > > Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> > > > > > > > >
> > > > > > > > > This patch seems to break 32-bit Linux boots on the sifive_u and virt machines.
> > > > > > > > >
> > > > > > > >
> > > > > > > > It looks only Linux boot on sifive_u is broken. On our side, we have
> > > > > > > > been using VxWorks to test 32-bit OpenSBI on sifive_u so this issue
> > > > > > > > gets unnoticed. I will take a look.
> > > > > > >
> > > > > > > I've figured out the issue of 32-bit Linux booting failure on
> > > > > > > sifive_u. A patch has been sent to Linux upstream:
> > > > > > > http://lists.infradead.org/pipermail/linux-riscv/2020-July/001213.html
> > > > > >
> > > > > > Thanks for that. What change in QEMU causes this failure though?
> > > > > >
> > > > >
> > > > > There is nothing wrong in QEMU.
> > > >
> > > > There is. This patch causes a regression for 32-bit Linux boot on the
> > > > sifive_u. Your v5 has not addressed this.
> > >
> > > The 32-bit Linux boot failure was fixed by:
> > > http://lists.infradead.org/pipermail/linux-riscv/2020-July/001213.html
> > >
> > > What additional issue did you see?
> > >
> > > >
> > > > With this patch, the Linux boot stops here:
> > > >
> > > > OpenSBI v0.8
> > > >    ____                    _____ ____ _____
> > > >   / __ \                  / ____|  _ \_   _|
> > > >  | |  | |_ __   ___ _ __ | (___ | |_) || |
> > > >  | |  | | '_ \ / _ \ '_ \ \___ \|  _ < | |
> > > >  | |__| | |_) |  __/ | | |____) | |_) || |_
> > > >   \____/| .__/ \___|_| |_|_____/|____/_____|
> > > >         | |
> > > >         |_|
> > > >
> > > > Platform Name       : SiFive HiFive Unleashed A00
> > > > Platform Features   : timer,mfdeleg
> > > > Platform HART Count : 4
> > > > Boot HART ID        : 3
> > > > Boot HART ISA       : rv64imafdcsu
> > >
> > > This is a 64-bit hardware.
> >
> > You are right. It's not 32-bit, that was my mistake. I'm used to my
> > first test being 32-bit, but in this case it's not.
> >
> > It looks like this commit instead breaks the sifive_u for 64-bit with
> > the 5.3 kernel.
> >
> > >
> > > > BOOT HART Features  : pmp,scounteren,mcounteren
> > > > BOOT HART PMP Count : 16
> > > > Firmware Base       : 0x80000000
> > > > Firmware Size       : 116 KB
> > > > Runtime SBI Version : 0.2
> > > >
> > > > MIDELEG : 0x0000000000000222
> > > > MEDELEG : 0x000000000000b109
> > > > PMP0    : 0x0000000080000000-0x000000008001ffff (A)
> > > > PMP1    : 0x0000000000000000-0xffffffffffffffff (A,R,W,X)
> > > > [    0.000000] OF: fdt: Ignoring memory range 0x80000000 - 0x80200000
> > > > [    0.000000] Linux version 5.3.0 (oe-user@oe-host) (gcc version
> > >
> > > It seems that you are using quite an old kernel. Can you please try
> > > the latest version?
> >
> > It is an old kernel, but old kernels should still keep working (or we
> > should at least know why they don't)
> >
> > >
> > > > 9.2.0 (GCC)) #1 SMP Thu Sep 19 18:34:52 UTC 2019
> > > > [    0.000000] earlycon: sbi0 at I/O port 0x0 (options '')
> > > > [    0.000000] printk: bootconsole [sbi0] enabled
> > > > [    0.000000] initrd not found or empty - disabling initrd
> > > > [    0.000000] Zone ranges:
> > > > [    0.000000]   DMA32    [mem 0x0000000080200000-0x00000000bfffffff]
> > > > [    0.000000]   Normal   empty
> > > > [    0.000000] Movable zone start for each node
> > > > [    0.000000] Early memory node ranges
> > > > [    0.000000]   node   0: [mem 0x0000000080200000-0x00000000bfffffff]
> > > > [    0.000000] Initmem setup node 0 [mem 0x0000000080200000-0x00000000bfffffff]
> > > > [    0.000000] OF: fdt: Invalid device tree blob header
> > > > [    0.000000] software IO TLB: mapped [mem 0xbb1fe000-0xbf1fe000] (64MB)
> > > >
> > > > Without this patch I can boot all the way to looking for a rootFS.
> > > >
> > > > Please don't send new versions of patches without addresses regressions.
> > >
> > > The patches were sent after addressing all regressions you reported
> > > (well the 32-bit Linux booting issue is actually not a QEMU
> > > regression, but one that exists in the Linux kernel side for a long
> > > time).
> >
> > Yep, that is my mistake. Sorry about the confusion.
> >
> > >
> > > I just tested 64-bit Linux boot on both virt and sifive_u, and they
> > > both can boot all the way to looking for a root fs.
> >
> > Can you test with older kernels?
> >
>
> OK I will investigate.

I've located the commit in the newer Linux kernel that fixed the boot
failure of the 5.3 kernel. See below:

commit 922b0375fc93fb1a20c5617e37c389c26bbccb70
Author: Albert Ou <aou@eecs.berkeley.edu>
Date:   Fri Sep 27 16:14:18 2019 -0700

    riscv: Fix memblock reservation for device tree blob

    This fixes an error with how the FDT blob is reserved in memblock.
    An incorrect physical address calculation exposed the FDT header to
    unintended corruption, which typically manifested with of_fdt_raw_init()
    faulting during late boot after fdt_totalsize() returned a wrong value.
    Systems with smaller physical memory sizes more frequently trigger this
    issue, as the kernel is more likely to allocate from the DMA32 zone
    where bbl places the DTB after the kernel image.

    Commit 671f9a3e2e24 ("RISC-V: Setup initial page tables in two stages")
    changed the mapping of the DTB to reside in the fixmap area.
    Consequently, early_init_fdt_reserve_self() cannot be used anymore in
    setup_bootmem() since it relies on __pa() to derive a physical address,
    which does not work with dtb_early_va that is no longer a valid kernel
    logical address.

    The reserved[0x1] region shows the effect of the pointer underflow
    resulting from the __pa(initial_boot_params) offset subtraction:

    [    0.000000] MEMBLOCK configuration:
    [    0.000000]  memory size = 0x000000001fe00000 reserved size =
0x0000000000a2e514
    [    0.000000]  memory.cnt  = 0x1
    [    0.000000]  memory[0x0]
[0x0000000080200000-0x000000009fffffff], 0x000000001fe00000 bytes
flags: 0x0
    [    0.000000]  reserved.cnt  = 0x2
    [    0.000000]  reserved[0x0]
[0x0000000080200000-0x0000000080c2dfeb], 0x0000000000a2dfec bytes
flags: 0x0
    [    0.000000]  reserved[0x1]
[0xfffffff080100000-0xfffffff080100527], 0x0000000000000528 bytes
flags: 0x0

    With the fix applied:

    [    0.000000] MEMBLOCK configuration:
    [    0.000000]  memory size = 0x000000001fe00000 reserved size =
0x0000000000a2e514
    [    0.000000]  memory.cnt  = 0x1
    [    0.000000]  memory[0x0]
[0x0000000080200000-0x000000009fffffff], 0x000000001fe00000 bytes
flags: 0x0
    [    0.000000]  reserved.cnt  = 0x2
    [    0.000000]  reserved[0x0]
[0x0000000080200000-0x0000000080c2dfeb], 0x0000000000a2dfec bytes
flags: 0x0
    [    0.000000]  reserved[0x1]
[0x0000000080e00000-0x0000000080e00527], 0x0000000000000528 bytes
flags: 0x0

    Fixes: 671f9a3e2e24 ("RISC-V: Setup initial page tables in two stages")
    Signed-off-by: Albert Ou <aou@eecs.berkeley.edu>
    Tested-by: Bin Meng <bmeng.cn@gmail.com>
    Reviewed-by: Anup Patel <anup@brainfault.org>
    Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>

As the commit message says, this commit is a fix to commit
671f9a3e2e24 ("RISC-V: Setup initial page tables in two stages") which
is in the 5.3 kernel:

commit 671f9a3e2e24cdeb2d2856abee7422f093e23e29
Author: Anup Patel <Anup.Patel@wdc.com>
Date:   Fri Jun 28 13:36:21 2019 -0700

    RISC-V: Setup initial page tables in two stages

    Currently, the setup_vm() does initial page table setup in one-shot
    very early before enabling MMU. Due to this, the setup_vm() has to map
    all possible kernel virtual addresses since it does not know size and
    location of RAM. This means we have kernel mappings for non-existent
    RAM and any buggy driver (or kernel) code doing out-of-bound access
    to RAM will not fault and cause underterministic behaviour.

    Further, the setup_vm() creates PMD mappings (i.e. 2M mappings) for
    RV64 systems. This means for PAGE_OFFSET=0xffffffe000000000 (i.e.
    MAXPHYSMEM_128GB=y), the setup_vm() will require 129 pages (i.e.
    516 KB) of memory for initial page tables which is never freed. The
    memory required for initial page tables will further increase if
    we chose a lower value of PAGE_OFFSET (e.g. 0xffffff0000000000)

    This patch implements two-staged initial page table setup, as follows:
    1. Early (i.e. setup_vm()): This stage maps kernel image and DTB in
    a early page table (i.e. early_pg_dir). The early_pg_dir will be used
    only by boot HART so it can be freed as-part of init memory free-up.
    2. Final (i.e. setup_vm_final()): This stage maps all possible RAM
    banks in the final page table (i.e. swapper_pg_dir). The boot HART
    will start using swapper_pg_dir at the end of setup_vm_final(). All
    non-boot HARTs directly use the swapper_pg_dir created by boot HART.

    We have following advantages with this new approach:
    1. Kernel mappings for non-existent RAM don't exists anymore.
    2. Memory consumed by initial page tables is now indpendent of the
    chosen PAGE_OFFSET.
    3. Memory consumed by initial page tables on RV64 system is 2 pages
    (i.e. 8 KB) which has significantly reduced and these pages will be
    freed as-part of the init memory free-up.

    The patch also provides a foundation for implementing strict kernel
    mappings where we protect kernel text and rodata using PTE permissions.

    Suggested-by: Mike Rapoport <rppt@linux.ibm.com>
    Signed-off-by: Anup Patel <anup.patel@wdc.com>
    [paul.walmsley@sifive.com: updated to apply; fixed a checkpatch warning]
    Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>

I cherry-picked 922b0375fc93fb1a20c5617e37c389c26bbccb70 on top of a
5.3 kernel, and with that the kernel boots again with this patch set.

>
> > If we can't support older kernels with the default bios option we at
> > least need to know why and list that in the release notes.
> >

I will include the above findings in my commit message of this series,
mentioning that to test an older kernel like 5.3 version Linux,
922b0375fc93fb1a20c5617e37c389c26bbccb70 should be cherry-picked.

Regards,
Bin

