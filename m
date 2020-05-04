Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57D93C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 08:01:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 200E120658
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 08:01:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qTITBXLd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 200E120658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVW2P-00008k-7q
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 04:01:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35948)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jVW1V-0007zF-AU; Mon, 04 May 2020 04:00:21 -0400
Received: from mail-yb1-xb42.google.com ([2607:f8b0:4864:20::b42]:36208)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jVW1U-0002uu-7I; Mon, 04 May 2020 04:00:21 -0400
Received: by mail-yb1-xb42.google.com with SMTP id a8so1363767ybs.3;
 Mon, 04 May 2020 01:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=vfxljV0HYNvPqGEZHJ2y4CE9oRdwTmVmCFjGsgW1FtQ=;
 b=qTITBXLdnrZH1ZHYMtG2sMQajDSuN1dazbPqWKkBsOR1CqKnlKzhjcCWW1xK3oZBQm
 +hssiBW1ZH4SiD6x51Pu0mJgRv2aDLlEdHp3Hl/RcV0DMjoBpYH+R078Z14aG6gV3KS3
 7O1zJsvVyCIgvXuo6owH7/FyBnvPkF3wmBRJ2zKtnpZvRRr6IqFxHLYhNs4IvUX4yJG/
 pZs88WzY4YyJ9b4yamIHeUg9a59kXbEmvVZLMOuMayT7KU8T0j88l335yqOJK69yBM6G
 TeZIx//BAfozddyBGsOL1VEAQo/90Ej9S+pMYatrXDqinHS7NqUpnqp2q0AgIB/q8S/U
 yaDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vfxljV0HYNvPqGEZHJ2y4CE9oRdwTmVmCFjGsgW1FtQ=;
 b=fEGV1wGiBRN3zU9pMsvEdpZ23SVxZ7PI2HObXnegVEYvFJvjr/MH2c2/lNq1vbH+eh
 kq2P2HzxBqoa9REaTt9Ug4LN4KRi/1FEPhDiOY5MBzFiByB+1xzWa7K9uM/0z3bsdYCL
 hx0QJbmHpdfns5ZsB0R8PS7VDt6eQNBTKds8ndmqGijwWlCSH7VLSdK0sOJYgj79Ikxm
 bQbyX3vfZCBIMqft3VKr5WVTKxM8+aHUFeDyRCwQsbilbvu+dlAWQzLv8Ep5/CDdyF9v
 ur0p26ddnQxf/GDIseeCKAEvtmhAkuu2iqT9tr5qTDrxUJrYxsPR45XeOtH0ViH8eWT/
 bYyw==
X-Gm-Message-State: AGi0PuYkpkcyg1ijSYNWuJk9AtPOBzzvzUlb2CXOjwmb4MZ9QvVGd+q4
 LG70M9S39LNTQffKgYOWp87RlK387pIt85+jX3A=
X-Google-Smtp-Source: APiQypJtOPL1gcyGW05mg7uMC0bKbFP03+dYPzlo10Kw2RvlbGRs35Qs/r1KR5BHeCrTmO+sbQNLRx45axCJ9XSMEHI=
X-Received: by 2002:a25:abc6:: with SMTP id v64mr11234692ybi.517.1588579218908; 
 Mon, 04 May 2020 01:00:18 -0700 (PDT)
MIME-Version: 1.0
References: <1588348254-7241-1-git-send-email-bmeng.cn@gmail.com>
 <1588348254-7241-2-git-send-email-bmeng.cn@gmail.com>
 <CAAhSdy06i1zb6_aedLn41rWDzrjyTcJ_T954DcwX7k2bM_VcVw@mail.gmail.com>
 <CAEUhbmXMcxZqk4RUjcWMG-5MCd-Z3wPn=ktQnHLA3Rvn01iq+g@mail.gmail.com>
 <CAAhSdy1kWxW6kyQiMd+-9ZkwMr9xFcZurU7HHoRTE0ST9rnq0Q@mail.gmail.com>
In-Reply-To: <CAAhSdy1kWxW6kyQiMd+-9ZkwMr9xFcZurU7HHoRTE0ST9rnq0Q@mail.gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Mon, 4 May 2020 16:00:07 +0800
Message-ID: <CAEUhbmUzPNxHXgNU=nM3C3AdyqwNh4sS9pq02F9vLwipRRWwDA@mail.gmail.com>
Subject: Re: [PATCH 1/5] roms/opensbi: Update to support building bios images
 for generic platform
To: Anup Patel <anup@brainfault.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b42;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yb1-xb42.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 QEMU Developers <qemu-devel@nongnu.org>, Anup Patel <Anup.Patel@wdc.com>,
 Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Anup,

On Mon, May 4, 2020 at 3:52 PM Anup Patel <anup@brainfault.org> wrote:
>
> On Mon, May 4, 2020 at 12:46 PM Bin Meng <bmeng.cn@gmail.com> wrote:
> >
> > Hi Anup,
> >
> > On Sun, May 3, 2020 at 12:38 PM Anup Patel <anup@brainfault.org> wrote:
> > >
> > > On Fri, May 1, 2020 at 9:26 PM Bin Meng <bmeng.cn@gmail.com> wrote:
> > > >
> > > > From: Bin Meng <bin.meng@windriver.com>
> > > >
> > > > The RISC-V generic platform is a flattened device tree (FDT) based
> > > > platform where all platform specific functionality is provided based
> > > > on FDT passed by previous booting stage. The support was added in
> > > > upstream opensbi recently.
> > > >
> > > > Bring the QEMU roms/opensbi submodule to the upstream opensbi commit:
> > > > commit 4f18c6e55049 ("platform: generic: Add Sifive FU540 TLB flush range limit override")
> > > > with the following changes since v0.7 release:
> > > >
> > > >   1bb00ab lib: No need to provide default PMP region using platform callbacks
> > > >   a9eac67 include: sbi_platform: Combine reboot and shutdown into one callback
> > > >   6585fab lib: utils: Add SiFive test device
> > > >   4781545 platform: Add Nuclei UX600 platform
> > > >   3a326af scripts: adapt binary archive script for Nuclei UX600
> > > >   5bdf022 firmware: fw_base: Remove CSR_MTVEC update check
> > > >   e6c1345 lib: utils/serial: Skip baudrate config if input frequency is zero
> > > >   01a8c8e lib: utils: Improve fdt_parse_uart8250() API
> > > >   0a0093b lib: utils: Add fdt_parse_uart8250_node() function
> > > >   243b0d0 lib: utils: Remove redundant clint_ipi_sync() declaration
> > > >   e3ad7c1 lib: utils: Rename fdt_parse_clint() to fdt_parse_compat_addr()
> > > >   a39cd6f lib: utils: Add FDT match table based node lookup
> > > >   dd33b9e lib: utils: Make fdt_get_node_addr_size() public function
> > > >   66185b3 lib: utils: Add fdt_parse_sifive_uart_node() function
> > > >   19e966b lib: utils: Add fdt_parse_hart_id() function
> > > >   44dd7be lib: utils: Add fdt_parse_max_hart_id() API
> > > >   f0eb503 lib: utils: Add fdt_parse_plic_node() function
> > > >   1ac794c include: Add array_size() macro
> > > >   8ff2b94 lib: utils: Add simple FDT timer framework
> > > >   76f0f81 lib: utils: Add simple FDT ipi framework
> > > >   75322a6 lib: utils: Add simple FDT irqchip framework
> > > >   76a8940 lib: utils: Add simple FDT serial framework
> > > >   7cc6fa4 lib: utils: Add simple FDT reset framework
> > > >   4d06353 firmware: fw_base: Introduce optional fw_platform_init()
> > > >   f1aa9e5 platform: Add generic FDT based platform support
> > > >   1f21b99 lib: sbi: Print platform hart count at boot time
> > > >   2ba7087 scripts: Add generic platform to create-binary-archive.sh
> > > >   4f18c6e platform: generic: Add Sifive FU540 TLB flush range limit override
> > > >
> > > > Update our Makefile to build the generic platform instead of building
> > > > virt and sifive_u separately.
> > > >
> > > > Signed-off-by: Bin Meng <bin.meng@windriver.com>
> > > > ---
> > > >
> > > >  roms/Makefile | 30 ++++++++----------------------
> > > >  roms/opensbi  |  2 +-
> > > >  2 files changed, 9 insertions(+), 23 deletions(-)
> > > >
> > > > diff --git a/roms/Makefile b/roms/Makefile
> > > > index f9acf39..cb00628 100644
> > > > --- a/roms/Makefile
> > > > +++ b/roms/Makefile
> > > > @@ -64,10 +64,8 @@ default help:
> > > >         @echo "  u-boot.e500        -- update u-boot.e500"
> > > >         @echo "  u-boot.sam460      -- update u-boot.sam460"
> > > >         @echo "  efi                -- update UEFI (edk2) platform firmware"
> > > > -       @echo "  opensbi32-virt     -- update OpenSBI for 32-bit virt machine"
> > > > -       @echo "  opensbi64-virt     -- update OpenSBI for 64-bit virt machine"
> > > > -       @echo "  opensbi32-sifive_u -- update OpenSBI for 32-bit sifive_u machine"
> > > > -       @echo "  opensbi64-sifive_u -- update OpenSBI for 64-bit sifive_u machine"
> > > > +       @echo "  opensbi32-generic  -- update OpenSBI for 32-bit generic machine"
> > > > +       @echo "  opensbi64-generic  -- update OpenSBI for 64-bit generic machine"
> > > >         @echo "  bios-microvm       -- update bios-microvm.bin (qboot)"
> > > >         @echo "  clean              -- delete the files generated by the previous" \
> > > >                                       "build targets"
> > > > @@ -170,29 +168,17 @@ skiboot:
> > > >  efi: edk2-basetools
> > > >         $(MAKE) -f Makefile.edk2
> > > >
> > > > -opensbi32-virt:
> > > > +opensbi32-generic:
> > > >         $(MAKE) -C opensbi \
> > > >                 CROSS_COMPILE=$(riscv32_cross_prefix) \
> > > > -               PLATFORM="qemu/virt"
> > > > -       cp opensbi/build/platform/qemu/virt/firmware/fw_jump.bin ../pc-bios/opensbi-riscv32-virt-fw_jump.bin
> > > > +               PLATFORM="generic"
> > > > +       cp opensbi/build/platform/generic/firmware/fw_jump.bin ../pc-bios/opensbi-riscv32-generic-fw_jump.bin
> > >
> > > I think you should copy fw_jump.elf as well because QEMU Spike
> > > platform needs it.
> > >
> >
> > I believe we intended only to ship default bios images for virt and
> > sifive_u. Spike bios image was not shipped in previous QEMU version
> > too.
>
> Is there a specific reason for not shipping bios image for Spike machine ?
>

That's only my guess.  Based on what I see from git history, adding
"-bios" support was added via:

commit 5b8a986350a9 ("hw/riscv/spike: Allow loading firmware
separately using -bios option")

with bios image as opensbi-riscv{32,64}-spike-fw_jump.elf, but the
images were not added to QEMU repo.

> There were issues booting Linux on QEMU spike machine which are
> now fixed and available in QEMU master. I think we should certainly
> ship fw_jump.elf for Spike machine. This way we have OpenSBI generic
> firmware available as a bios image for three QEMU machines(virt, sifive_u,
> and spike).
>

If everyone thinks shipping the ELF image is OK, I can do that in v2.

Regards,
Bin

