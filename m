Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC7D5C54FCC
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 01:35:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A97D20782
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 01:35:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kp0Jto/+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A97D20782
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQhok-00028W-NW
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 21:35:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60346)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1jQhns-0001T8-Cw
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 21:34:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1jQhni-0000x5-Kf
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 21:34:24 -0400
Received: from mail-yb1-xb43.google.com ([2607:f8b0:4864:20::b43]:33445)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jQhni-0000vF-5b; Mon, 20 Apr 2020 21:34:14 -0400
Received: by mail-yb1-xb43.google.com with SMTP id e17so6524299ybq.0;
 Mon, 20 Apr 2020 18:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=W8ZFHS9omzGT3JRqbPGa8jzkw69mxVTDGVTWbskdKDA=;
 b=kp0Jto/+Ou7WIQkWOWMghZVaPeJPdj84l0IYL8QaPoA84mYU6YTlXW/qppy2Vg/1PK
 YN/H730P1e9yLW8060f1odiPTubMbOvT7l4UJ6z8NDPzob+h0M5XGb3mv7sgzF+Z6Feu
 Vvx/rcdbB3Ar+4C295gyiMrP0NtumX6Ui9vn4zXfZjmYndp952Zes/uUBOIhozY3X/A6
 15wkkZrsdcMbW0oJ/ewqOpaL+GIHq8HcuSge0fkN7Dpfs84/Vq+fy5ExKh1EZJ5pFZLn
 CatXi+yNXaUhQNdcFcEzv32D4kb1/ZVT7iW9rniUJW7w/BTpDTDJyfT3r31pvl7m4xWk
 yRZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=W8ZFHS9omzGT3JRqbPGa8jzkw69mxVTDGVTWbskdKDA=;
 b=s+UQlij8jry+razftrA5YMTa/cSkAQzCD43dC9qxZAb1Nbgt7ezhN5x40sNjPpaQou
 22Q38H3hd1Z+PRShZvm0MCr46/A+RVtdV5oNi1olw3iAbQVHCiMXGmmuyPl2BonIzUwi
 MLm17dsSH4cZ1UdaaRgGE653JzMlc9uGJpcRxS+t6sUm50EqsufNnXVYmt4hmW639hQ7
 kfb2rQ9zAh58bNwiRMV8k0RVTJ+qV0maLFTqc0NkRN92OrW5WxoNgBxbNAuuVF+oQoiF
 VsFdoDQzhbroJV/E+IqlOzEBE4nKv6Pxec/6wmIOnnZonQCJjupVOtEXKkcMKjwndbLU
 hz8g==
X-Gm-Message-State: AGi0PuZ/xs0F0rziPLs1rIyGnjTah27XizKuO/vbBn5fb7JqTC2Louhx
 tR1t0H9DmgObhYe6gQT8AIrNST58HMOoZxftgzE=
X-Google-Smtp-Source: APiQypJq/8MyY9XupCRTIAHjzB4KMbssSiT2I1rvLuiBLHTNGw8nhL5vUBbvQJMnoKqZbLOxwB0Enr3AJaOp3j2sSb4=
X-Received: by 2002:a05:6902:686:: with SMTP id
 i6mr21502902ybt.56.1587432852162; 
 Mon, 20 Apr 2020 18:34:12 -0700 (PDT)
MIME-Version: 1.0
References: <1587389038-1549-1-git-send-email-bmeng.cn@gmail.com>
 <CAKmqyKMzUzHC1FhV6ccjswjRvQH_h6DuUwEWjte4CAEmxPOKDg@mail.gmail.com>
In-Reply-To: <CAKmqyKMzUzHC1FhV6ccjswjRvQH_h6DuUwEWjte4CAEmxPOKDg@mail.gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Tue, 21 Apr 2020 09:34:01 +0800
Message-ID: <CAEUhbmUTEVPF6f91SqrXL-_M-G_Jg2D29cBjbCs1YBGm2fk6QA@mail.gmail.com>
Subject: Re: [PATCH] roms: opensbi: Upgrade from v0.6 to v0.7
To: Alistair Francis <alistair23@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b43;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yb1-xb43.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::b43
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
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Alistair,

On Tue, Apr 21, 2020 at 2:41 AM Alistair Francis <alistair23@gmail.com> wrote:
>
> On Mon, Apr 20, 2020 at 6:25 AM Bin Meng <bmeng.cn@gmail.com> wrote:
> >
> > Upgrade OpenSBI from v0.6 to v0.7 and the pre-built bios images.
> >
> > The v0.7 release includes the following commits:
> >
> > f64f4b9 lib: Add a new platform feature to bringup secondary harts
> > b677a9b lib: Implement hart hotplug
> > 5b48240 lib: Add possible hart status values
> > e3f69fc lib: Implement Hart State Management (HSM) SBI extension
> > 6704216 lib: Check MSIP bit after returning from WFI
> > 82ae8e8 makefile: Do setup of the install target more flexible
> > e1a5b73 platform: sifive: fu540: allow sv32 as an mmu-type
> > 8c83fb2 lib: Fix return type of sbi_hsm_hart_started()
> > 00d332b include: Move bits related defines and macros to sbi_bitops.h
> > a148996 include: sbi_bitops: More useful bit operations
> > 4a603eb platform: kendryte/k210: Set per-HART stack size to 8KB
> > 678c3c3 include: sbi_scratch: Set per-HART scratch size to 4KB
> > 2abc55b lib: Sort build objects in alphabetical order
> > 6e87507 platform: ae350: Sort build objects in alphabetical order
> > 650c0e5 lib: sbi: Fix coding style issues
> > 078686d lib: serial: Fix coding style issues
> > 3226bd9 lib: Simple bitmap library
> > c741abc include: Simple hartmask library
> > d6d7e18 lib: sbi_init: Don't allow HARTID greater than SBI_HARTMASK_MAX_BITS
> > a4a6a81 lib: Introduce SBI_TLB_INFO_INIT() helper macro
> > d963164 lib: sbi_tlb: Use sbi_hartmask in sbi_tlb_info
> > 71d2b83 lib: Move all coldboot wait APIs to sbi_init.c
> > 2b945fc lib: sbi_init: Use hartmask for coldboot wait
> > 44ce5b9 include: Remove disabled_hart_mask from sbi_platform
> > 2db381f lib: Introduce sbi_hsm_hart_started_mask() API
> > 61f7768 lib: sbi_ecall_legacy: Use sbi_hsm_hart_started_mask() API
> > 466fecb lib: sbi_system: Use sbi_hsm_hart_started_mask() API
> > 9aad831 lib: sbi_ipi: Use sbi_hsm_hart_started_mask() API
> > eede1aa lib: sbi_hart: Remove HART available mask and related APIs
> > 757bb44 docs: Remove out-of-date documentation
> > 86d37bb lib: sbi: Fix misaligned trap handling
> > ffdc858 platform: ariane-fpga: Change license for ariane-fpga from GPL-2.0 to BSD-2
> > 4b2f594 sbi: Add definitions for true/false
> > 0cfe49a libfdt: Add INT32_MAX and UINT32_MAX in libfdt_env.h
> > baac7e0 libfdt: Upgrade to v1.5.1 release
> > f92147c include: Make sbi_hart_id_to_scratch() as macro
> > eeae3d9 firmware: fw_base: Optimize _hartid_to_scratch() implementation
> > 16e7071 lib: sbi_hsm: Optimize sbi_hsm_hart_get_state() implementation
> > 823345e include: Make sbi_current_hartid() as macro in riscv_asm.h
> > 9aabba2 Makefile: Fix distclean make target
> > 9275ed3 platform: ariane-fpga: Set per-HART stack size to 8KB
> > 2343efd platform: Set per-HART stack size to 8KB in the template platform codes
> > 72a0628 platform: Use one unified per-HART stack size macro for all platforms
> > 327ba36 scripts: Cover sifive/fu540 in the 32-bit build
> > 5fbcd62 lib: sbi: Update pmp_get() to return decoded size directly
> > dce8846 libfdt: Compile fdt_addresses.c
> > fcb1ded lib: utils: Add a fdt_reserved_memory_fixup() helper
> > 666be6d platform: Clean up include header files
> > 6af5576 lib: utils: Move PLIC DT fix up codes to fdt_helper.c
> > e846ce1 platform: andes/ae350: Fix up DT for reserved memory
> > 8135520 platform: ariane-fpga: Fix up DT for reserved memory
> > c9a5268 platform: qemu/virt: Fix up DT for reserved memory
> > 6f9bb83 platform: sifive/fu540: Fix up DT for reserved memory
> > 1071f05 platform: sifive/fu540: Remove "stdout-path" fix-up
> > dd9439f lib: utils: Add a fdt_cpu_fixup() helper
> > 3f1c847 platform: sifive/fu540: Replace cpu0 node fix-up with the new helper
> > db6a2b5 lib: utils: Add a general device tree fix-up helper
> > 3f8d754 platform: Update to call general DT fix-up helper
> > 87a7ef7 lib: sbi_scratch: Introduce HART id to scratch table
> > e23d3ba include: Simplify HART id to scratch macro
> > 19bd531 lib: sbi_hsm: Simplify hart_get_state() and hart_started() APIs
> > 3ebfe0e lib: sbi_tlb: Simplify sbi_tlb_entry_process() function
> > 209134d lib: Handle failure of sbi_hartid_to_scratch() API
> > bd6ef02 include: sbi_platform: Improve sbi_platform_hart_disabled() API
> > c9f60fc lib: sbi_scratch: Don't set hartid_to_scratch table for disabled HART
> > 680b098 lib: sbi_hsm: Don't use sbi_platform_hart_count() API
> > db187d6 lib: sbi_hsm: Remove scratch parameter from hart_started_mask() API
> > 814f38d lib: sbi_hsm: Don't use sbi_platform_hart_disabled() API
> > 75eec9d lib: Don't use sbi_platform_hart_count() API
> > c51f02c include: sbi_platform: Introduce HART index to HART id table
> > 315a877 platform: sifive/fu540: Remove FU540_ENABLED_HART_MASK option
> > a0c88dd lib: Fix sbi_ecall_register_extension to prevent extension IDs overlap
> > 9a74a64 lib: Check MSIP bit after returning from WFI
> > 5968894 platform: Move ariane standalone fpga project to its own project
> > ed265b4 platform: fpga/ariane: Remove redundant plic address macros
> > fb84879 platform: Add OpenPiton platform support
> > d1d6560 platform: fpga/common: Add a fdt parsing helper functions
> > 040e4e2 lib: utils: Move fdt fixup helper routines to a different file
> > 4c37451 platform: openpiton: Read the device configurations from device tree
> > 4d93586 lib: prevent coldboot_lottery from overflowing
> > 550ba88 scripts: Extend create-binary-archive.sh for unified binary tar ball
> > 160c885 lib: utils: Improve fdt_cpu_fixup() implementation
> > 1de66d1 lib: Optimize unpriv load/store implementation
> > 626467c lib: Remove scratch parameter from unpriv load/store functions
> > cb78a48 lib: sbi_trap: Remove scratch parameter from sbi_trap_redirect()
> > d11c79c lib: sbi_emulate_csr: Remove scratch and hartid parameter
> > 5a7bd0c lib: sbi_illegal_insn: Remove mcause, scratch and hartid parameters
> > fe37d7d lib: sbi_misaligned_ldst: Remove mcause, scratch and hartid parameters
> > 7487116 lib: sbi_ecall: Remove mcause, scratch and hartid parameters
> > 40b221b lib: sbi_trap: Simplify sbi_trap_handler() API
> > 7b211ff include: sbi_platform: Remove priv parameter from hart_start() callback
> > 5b6957e include: Use more consistent name for atomic xchg() and cmpxchg()
> > dd0f21c lib: sbi_scratch: Introduce sbi_scratch_last_hartid() API
> > 54b2779 include: sbi_tlb: Remove scratch parameter from sbi_tlb_request()
> > 9e52a45 include: sbi_ipi: Remove scratch parameter from most functions
> > ec0d80f include: sbi_system: Remove scratch parameter and redundant functions
> > 0a28ea5 include: sbi_timer: Remove scratch parameter from most funcitons
> > 648507a include: sbi_console: Remove scratch parameter from sbi_dprintf()
> > e5a7f55 platform: thead/c910: Use HSM extension to boot secondary cores
> > f281de8 lib: irqchip/plic: Fix maximum priority threshold value
> > 6c7922e lib: Support vector extension
> > 615587c docs: Update README about supported SBI versions
> > 66d0184 lib: Allow overriding SBI implementation ID
> > 9f1b72c include: Bump-up version to 0.7
> >
> > Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
>
> Can you share a git branch with this patch? From memory these binary
> patches don't apply well from emails.

Sure. Please grab the bits from http://github.com/lbmeng/qemu opensbi branch.

You can also use patchwork to help with your custodian work.
http://patchwork.ozlabs.org/project/qemu-devel/patch/1587389038-1549-1-git-send-email-bmeng.cn@gmail.com/

Click on the "mbox" button to download the patch and apply it.

Regards,
Bin

