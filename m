Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12F8AC3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 08:18:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2575206B9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 08:18:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="Er8v3Ldq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2575206B9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVWIu-0007ao-SL
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 04:18:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37788)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anup@brainfault.org>)
 id 1jVWHp-0005Wv-V0
 for qemu-devel@nongnu.org; Mon, 04 May 2020 04:17:14 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:55927)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <anup@brainfault.org>)
 id 1jVWHo-0001Lg-16
 for qemu-devel@nongnu.org; Mon, 04 May 2020 04:17:13 -0400
Received: by mail-wm1-x343.google.com with SMTP id e26so7399654wmk.5
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 01:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=brainfault-org.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=n0CV4M0fC3At38gNfQP9r3hs8pChcXMWBv3hvNFAMUk=;
 b=Er8v3Ldql/t9DPVnGG6KYYGpIYgd4iQCycubya1KZSm/Vx2T7ctouz9j3tlmLhyDiy
 1Mta0l592PF+5fPcLixvV5se1JVTvrq6+1KN4x9eRd238ozNl4HVy0dOK0A97eWY+3H7
 1jYNH7NbGVsFpI8q4I+Bkv27/bbczOKoROW1y2Xdu8+wLHaetXA+HBHw+uDEfIMBV63k
 pEVLM0BZQgmdDxV2hxOuHgK7Qy0DRynOvLKb0MXRf2Nuy2jHjQuDu9nJY0htYFxXvO7c
 aDlRPmSXOXSMPhN1SlwUQ8jp3w0EdI+JFsuQGdoqfl0SiL6HX612m+rHnngJkop5vVVQ
 sZUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=n0CV4M0fC3At38gNfQP9r3hs8pChcXMWBv3hvNFAMUk=;
 b=WUmCSiv2aDJe9/ImkgSq5Nz41PAuOBTSRh/xRFwLUazyIrKLc51tY7mP4YiFzVe9Ue
 H6fg9yjb4spH9AA3CT58+5DhqPHShbKXloJM33CZo746FDa3E97iKd52828pu1Ui0YJR
 IwcndnwiyfqevFNF/gMplvauR1NtxttuFKrxeZ8TUYm0F6JoxZ5ZBc7P5N7j0EHz7L5i
 SQbyBoAfhFcCR9hns9q/7oSN8rsvgaa7busLCdJUZ/+nrgYuPNwRUJoy6ihG8e2Th2wM
 0II+Pt3ehMF9BUYPrRKzi/+cyAeA3CJIxqSy7epyN2kvf2Rh8O1/2sOlbkYw5ndjAXNT
 SWgQ==
X-Gm-Message-State: AGi0PuaCfGKZL24G95E4TcKTp5KuA/P8nKZv+Mxee5RTzXjOPgy6Xe4W
 hEYI+X5ayrF+ieooqHGIXKfdZPFS2BmNv98v90JYcw==
X-Google-Smtp-Source: APiQypLxyxyX8DUUcCln0bv4BJk8h9q8NDNst5LFgX1p1Av3vZw9Rejr/dHqQcPDBj9ZnEPSenV9fFoBuGwv6b19qqI=
X-Received: by 2002:a1c:9d0d:: with SMTP id g13mr13884913wme.102.1588580230415; 
 Mon, 04 May 2020 01:17:10 -0700 (PDT)
MIME-Version: 1.0
References: <1588348254-7241-1-git-send-email-bmeng.cn@gmail.com>
 <1588348254-7241-2-git-send-email-bmeng.cn@gmail.com>
 <CAAhSdy06i1zb6_aedLn41rWDzrjyTcJ_T954DcwX7k2bM_VcVw@mail.gmail.com>
 <CAEUhbmXMcxZqk4RUjcWMG-5MCd-Z3wPn=ktQnHLA3Rvn01iq+g@mail.gmail.com>
 <CAAhSdy1kWxW6kyQiMd+-9ZkwMr9xFcZurU7HHoRTE0ST9rnq0Q@mail.gmail.com>
 <CAEUhbmUzPNxHXgNU=nM3C3AdyqwNh4sS9pq02F9vLwipRRWwDA@mail.gmail.com>
 <CAEUhbmWD_L_dJZ3hVZrw08ycCaLr3UDTRRA9JreJfqZHpPntmQ@mail.gmail.com>
In-Reply-To: <CAEUhbmWD_L_dJZ3hVZrw08ycCaLr3UDTRRA9JreJfqZHpPntmQ@mail.gmail.com>
From: Anup Patel <anup@brainfault.org>
Date: Mon, 4 May 2020 13:46:58 +0530
Message-ID: <CAAhSdy3=uhOvwfDZTW-7GDMss1wNeuVVWs-1iw2xZ+Af1V=8Nw@mail.gmail.com>
Subject: Re: [PATCH 1/5] roms/opensbi: Update to support building bios images
 for generic platform
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: none client-ip=2a00:1450:4864:20::343;
 envelope-from=anup@brainfault.org; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
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

On Mon, May 4, 2020 at 1:35 PM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> On Mon, May 4, 2020 at 4:00 PM Bin Meng <bmeng.cn@gmail.com> wrote:
> >
> > Hi Anup,
> >
> > On Mon, May 4, 2020 at 3:52 PM Anup Patel <anup@brainfault.org> wrote:
> > >
> > > On Mon, May 4, 2020 at 12:46 PM Bin Meng <bmeng.cn@gmail.com> wrote:
> > > >
> > > > Hi Anup,
> > > >
> > > > On Sun, May 3, 2020 at 12:38 PM Anup Patel <anup@brainfault.org> wrote:
> > > > >
> > > > > On Fri, May 1, 2020 at 9:26 PM Bin Meng <bmeng.cn@gmail.com> wrote:
> > > > > >
> > > > > > From: Bin Meng <bin.meng@windriver.com>
> > > > > >
> > > > > > The RISC-V generic platform is a flattened device tree (FDT) based
> > > > > > platform where all platform specific functionality is provided based
> > > > > > on FDT passed by previous booting stage. The support was added in
> > > > > > upstream opensbi recently.
> > > > > >
> > > > > > Bring the QEMU roms/opensbi submodule to the upstream opensbi commit:
> > > > > > commit 4f18c6e55049 ("platform: generic: Add Sifive FU540 TLB flush range limit override")
> > > > > > with the following changes since v0.7 release:
> > > > > >
> > > > > >   1bb00ab lib: No need to provide default PMP region using platform callbacks
> > > > > >   a9eac67 include: sbi_platform: Combine reboot and shutdown into one callback
> > > > > >   6585fab lib: utils: Add SiFive test device
> > > > > >   4781545 platform: Add Nuclei UX600 platform
> > > > > >   3a326af scripts: adapt binary archive script for Nuclei UX600
> > > > > >   5bdf022 firmware: fw_base: Remove CSR_MTVEC update check
> > > > > >   e6c1345 lib: utils/serial: Skip baudrate config if input frequency is zero
> > > > > >   01a8c8e lib: utils: Improve fdt_parse_uart8250() API
> > > > > >   0a0093b lib: utils: Add fdt_parse_uart8250_node() function
> > > > > >   243b0d0 lib: utils: Remove redundant clint_ipi_sync() declaration
> > > > > >   e3ad7c1 lib: utils: Rename fdt_parse_clint() to fdt_parse_compat_addr()
> > > > > >   a39cd6f lib: utils: Add FDT match table based node lookup
> > > > > >   dd33b9e lib: utils: Make fdt_get_node_addr_size() public function
> > > > > >   66185b3 lib: utils: Add fdt_parse_sifive_uart_node() function
> > > > > >   19e966b lib: utils: Add fdt_parse_hart_id() function
> > > > > >   44dd7be lib: utils: Add fdt_parse_max_hart_id() API
> > > > > >   f0eb503 lib: utils: Add fdt_parse_plic_node() function
> > > > > >   1ac794c include: Add array_size() macro
> > > > > >   8ff2b94 lib: utils: Add simple FDT timer framework
> > > > > >   76f0f81 lib: utils: Add simple FDT ipi framework
> > > > > >   75322a6 lib: utils: Add simple FDT irqchip framework
> > > > > >   76a8940 lib: utils: Add simple FDT serial framework
> > > > > >   7cc6fa4 lib: utils: Add simple FDT reset framework
> > > > > >   4d06353 firmware: fw_base: Introduce optional fw_platform_init()
> > > > > >   f1aa9e5 platform: Add generic FDT based platform support
> > > > > >   1f21b99 lib: sbi: Print platform hart count at boot time
> > > > > >   2ba7087 scripts: Add generic platform to create-binary-archive.sh
> > > > > >   4f18c6e platform: generic: Add Sifive FU540 TLB flush range limit override
> > > > > >
> > > > > > Update our Makefile to build the generic platform instead of building
> > > > > > virt and sifive_u separately.
> > > > > >
> > > > > > Signed-off-by: Bin Meng <bin.meng@windriver.com>
> > > > > > ---
> > > > > >
> > > > > >  roms/Makefile | 30 ++++++++----------------------
> > > > > >  roms/opensbi  |  2 +-
> > > > > >  2 files changed, 9 insertions(+), 23 deletions(-)
> > > > > >
> > > > > > diff --git a/roms/Makefile b/roms/Makefile
> > > > > > index f9acf39..cb00628 100644
> > > > > > --- a/roms/Makefile
> > > > > > +++ b/roms/Makefile
> > > > > > @@ -64,10 +64,8 @@ default help:
> > > > > >         @echo "  u-boot.e500        -- update u-boot.e500"
> > > > > >         @echo "  u-boot.sam460      -- update u-boot.sam460"
> > > > > >         @echo "  efi                -- update UEFI (edk2) platform firmware"
> > > > > > -       @echo "  opensbi32-virt     -- update OpenSBI for 32-bit virt machine"
> > > > > > -       @echo "  opensbi64-virt     -- update OpenSBI for 64-bit virt machine"
> > > > > > -       @echo "  opensbi32-sifive_u -- update OpenSBI for 32-bit sifive_u machine"
> > > > > > -       @echo "  opensbi64-sifive_u -- update OpenSBI for 64-bit sifive_u machine"
> > > > > > +       @echo "  opensbi32-generic  -- update OpenSBI for 32-bit generic machine"
> > > > > > +       @echo "  opensbi64-generic  -- update OpenSBI for 64-bit generic machine"
> > > > > >         @echo "  bios-microvm       -- update bios-microvm.bin (qboot)"
> > > > > >         @echo "  clean              -- delete the files generated by the previous" \
> > > > > >                                       "build targets"
> > > > > > @@ -170,29 +168,17 @@ skiboot:
> > > > > >  efi: edk2-basetools
> > > > > >         $(MAKE) -f Makefile.edk2
> > > > > >
> > > > > > -opensbi32-virt:
> > > > > > +opensbi32-generic:
> > > > > >         $(MAKE) -C opensbi \
> > > > > >                 CROSS_COMPILE=$(riscv32_cross_prefix) \
> > > > > > -               PLATFORM="qemu/virt"
> > > > > > -       cp opensbi/build/platform/qemu/virt/firmware/fw_jump.bin ../pc-bios/opensbi-riscv32-virt-fw_jump.bin
> > > > > > +               PLATFORM="generic"
> > > > > > +       cp opensbi/build/platform/generic/firmware/fw_jump.bin ../pc-bios/opensbi-riscv32-generic-fw_jump.bin
> > > > >
> > > > > I think you should copy fw_jump.elf as well because QEMU Spike
> > > > > platform needs it.
> > > > >
> > > >
> > > > I believe we intended only to ship default bios images for virt and
> > > > sifive_u. Spike bios image was not shipped in previous QEMU version
> > > > too.
> > >
> > > Is there a specific reason for not shipping bios image for Spike machine ?
> > >
> >
> > That's only my guess.  Based on what I see from git history, adding
> > "-bios" support was added via:
> >
> > commit 5b8a986350a9 ("hw/riscv/spike: Allow loading firmware
> > separately using -bios option")
> >
> > with bios image as opensbi-riscv{32,64}-spike-fw_jump.elf, but the
> > images were not added to QEMU repo.
> >
> > > There were issues booting Linux on QEMU spike machine which are
> > > now fixed and available in QEMU master. I think we should certainly
> > > ship fw_jump.elf for Spike machine. This way we have OpenSBI generic
> > > firmware available as a bios image for three QEMU machines(virt, sifive_u,
> > > and spike).
> > >
> >
> > If everyone thinks shipping the ELF image is OK, I can do that in v2.
>
> One additional note, that's why patch 5 in this series for. Without
> the default bios image being shipped in QEMU, QEMU testing will
> complain.
>
> So in the future, when we have more QEMU RISC-V machines added, if
> they are not using the generic firmware, do we want to ship all of
> these different firmware images in QEMU?

This would be a QEMU RISC-V policy decision which Palmer or Alistair
can decide.

IMHO, we can insist that newer QEMU RISC-V machines work fine with
OpenSBI generic firmwares so that we don't increase the number of bios
images shipped for QEMU RISC-V.

Regards,
Anup

