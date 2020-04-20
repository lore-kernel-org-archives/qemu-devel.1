Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51406C3815B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 18:43:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E6502074F
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 18:43:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BSvqZDAW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E6502074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQbOS-0000HN-8n
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 14:43:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45786 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1jQbML-0007HL-TJ
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 14:41:34 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1jQbMK-00075S-Lj
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 14:41:33 -0400
Received: from mail-il1-x141.google.com ([2607:f8b0:4864:20::141]:44733)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jQbMK-00071s-6b; Mon, 20 Apr 2020 14:41:32 -0400
Received: by mail-il1-x141.google.com with SMTP id s10so10148385iln.11;
 Mon, 20 Apr 2020 11:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=7+YxCbIxn/HBNbX3UwrQogGY+hAgxUxJbHlB4UXB1Xs=;
 b=BSvqZDAWzn0QxfPOaPP7XF+XOx0QsGBZmrPdgzehT7/c3LQ0n0k+D8Tm480F+PYUwn
 7XunO7mQflvIvbuFwfuR0nELqG8rQgR5ycwSxfXdkLVqaZOo9WxJh0lc2iFgI4XLDlbn
 BjSgnqP5TpvL0smEx/26KNC2OiPCRF/uL+961RuthDZRdseQBjo0CrdoxPRWSG1grUjB
 FcUP3odmsrg/iXOpgyMukThocDbFmUn2LEn+wexuxTTu/Q9xj6wPn1LBmlIlhXdUzsoc
 iBF+1Kr3XO6aOtrYRcJkQQYyOC3k//cZtpOTqjqPPECQTeHsHq+F9U1mojX6GjR5onqq
 yNXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7+YxCbIxn/HBNbX3UwrQogGY+hAgxUxJbHlB4UXB1Xs=;
 b=SZ8BxXuZPbEt+dS4SMlx9aztzSdybGHpIhbK/NOG43L5iPLv2ZGCR4pv8S0qEuElTZ
 F3IwjlhyFfUEoJiVQpc9kFHbWTtwj94Q0T2AIDrNZNWw1E2jGvRrAo5XFjZo/tfTE8gC
 jR2ZMmNQkk1Rl6m8qu3UaATgp3ZpBbzbT/VIC+u1JqSI+H1oGBA3sXuwmYsDH16XE7+g
 jCWqd7unBhiB4eEmMaautXmYgknysyPPuFI6xHWsV25ywgtwD/8q1GPgrLxOP1QaUuSM
 Om3LUwNNKfJR3Qp0Oldaconad1U0+vlCRqJeTfccBgpm+hP6dkNNzud/9xgXmFKzuEb4
 OtsQ==
X-Gm-Message-State: AGi0Pub7d92kWDgEUCOqVcNVNesUtGcCo5yJONFOl0bYxNb4CDbMd0At
 udu8l/rZmVk9G4aM9Q/a3RfDZ02qfTJ4FILDGl8=
X-Google-Smtp-Source: APiQypL2ccxq8x6AZ/Ccw3Y1qJioVqkoDBIc5RIFxDL+if36pk0o5hWD2myLzMtt9cAj958ziGZMxAUmfH1hQGDgsLk=
X-Received: by 2002:a92:9a5c:: with SMTP id t89mr17736131ili.267.1587408090528; 
 Mon, 20 Apr 2020 11:41:30 -0700 (PDT)
MIME-Version: 1.0
References: <1587389038-1549-1-git-send-email-bmeng.cn@gmail.com>
In-Reply-To: <1587389038-1549-1-git-send-email-bmeng.cn@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 20 Apr 2020 11:33:03 -0700
Message-ID: <CAKmqyKMzUzHC1FhV6ccjswjRvQH_h6DuUwEWjte4CAEmxPOKDg@mail.gmail.com>
Subject: Re: [PATCH] roms: opensbi: Upgrade from v0.6 to v0.7
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::141;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x141.google.com
X-detected-operating-system: by eggs1p.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::141
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

On Mon, Apr 20, 2020 at 6:25 AM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> Upgrade OpenSBI from v0.6 to v0.7 and the pre-built bios images.
>
> The v0.7 release includes the following commits:
>
> f64f4b9 lib: Add a new platform feature to bringup secondary harts
> b677a9b lib: Implement hart hotplug
> 5b48240 lib: Add possible hart status values
> e3f69fc lib: Implement Hart State Management (HSM) SBI extension
> 6704216 lib: Check MSIP bit after returning from WFI
> 82ae8e8 makefile: Do setup of the install target more flexible
> e1a5b73 platform: sifive: fu540: allow sv32 as an mmu-type
> 8c83fb2 lib: Fix return type of sbi_hsm_hart_started()
> 00d332b include: Move bits related defines and macros to sbi_bitops.h
> a148996 include: sbi_bitops: More useful bit operations
> 4a603eb platform: kendryte/k210: Set per-HART stack size to 8KB
> 678c3c3 include: sbi_scratch: Set per-HART scratch size to 4KB
> 2abc55b lib: Sort build objects in alphabetical order
> 6e87507 platform: ae350: Sort build objects in alphabetical order
> 650c0e5 lib: sbi: Fix coding style issues
> 078686d lib: serial: Fix coding style issues
> 3226bd9 lib: Simple bitmap library
> c741abc include: Simple hartmask library
> d6d7e18 lib: sbi_init: Don't allow HARTID greater than SBI_HARTMASK_MAX_BITS
> a4a6a81 lib: Introduce SBI_TLB_INFO_INIT() helper macro
> d963164 lib: sbi_tlb: Use sbi_hartmask in sbi_tlb_info
> 71d2b83 lib: Move all coldboot wait APIs to sbi_init.c
> 2b945fc lib: sbi_init: Use hartmask for coldboot wait
> 44ce5b9 include: Remove disabled_hart_mask from sbi_platform
> 2db381f lib: Introduce sbi_hsm_hart_started_mask() API
> 61f7768 lib: sbi_ecall_legacy: Use sbi_hsm_hart_started_mask() API
> 466fecb lib: sbi_system: Use sbi_hsm_hart_started_mask() API
> 9aad831 lib: sbi_ipi: Use sbi_hsm_hart_started_mask() API
> eede1aa lib: sbi_hart: Remove HART available mask and related APIs
> 757bb44 docs: Remove out-of-date documentation
> 86d37bb lib: sbi: Fix misaligned trap handling
> ffdc858 platform: ariane-fpga: Change license for ariane-fpga from GPL-2.0 to BSD-2
> 4b2f594 sbi: Add definitions for true/false
> 0cfe49a libfdt: Add INT32_MAX and UINT32_MAX in libfdt_env.h
> baac7e0 libfdt: Upgrade to v1.5.1 release
> f92147c include: Make sbi_hart_id_to_scratch() as macro
> eeae3d9 firmware: fw_base: Optimize _hartid_to_scratch() implementation
> 16e7071 lib: sbi_hsm: Optimize sbi_hsm_hart_get_state() implementation
> 823345e include: Make sbi_current_hartid() as macro in riscv_asm.h
> 9aabba2 Makefile: Fix distclean make target
> 9275ed3 platform: ariane-fpga: Set per-HART stack size to 8KB
> 2343efd platform: Set per-HART stack size to 8KB in the template platform codes
> 72a0628 platform: Use one unified per-HART stack size macro for all platforms
> 327ba36 scripts: Cover sifive/fu540 in the 32-bit build
> 5fbcd62 lib: sbi: Update pmp_get() to return decoded size directly
> dce8846 libfdt: Compile fdt_addresses.c
> fcb1ded lib: utils: Add a fdt_reserved_memory_fixup() helper
> 666be6d platform: Clean up include header files
> 6af5576 lib: utils: Move PLIC DT fix up codes to fdt_helper.c
> e846ce1 platform: andes/ae350: Fix up DT for reserved memory
> 8135520 platform: ariane-fpga: Fix up DT for reserved memory
> c9a5268 platform: qemu/virt: Fix up DT for reserved memory
> 6f9bb83 platform: sifive/fu540: Fix up DT for reserved memory
> 1071f05 platform: sifive/fu540: Remove "stdout-path" fix-up
> dd9439f lib: utils: Add a fdt_cpu_fixup() helper
> 3f1c847 platform: sifive/fu540: Replace cpu0 node fix-up with the new helper
> db6a2b5 lib: utils: Add a general device tree fix-up helper
> 3f8d754 platform: Update to call general DT fix-up helper
> 87a7ef7 lib: sbi_scratch: Introduce HART id to scratch table
> e23d3ba include: Simplify HART id to scratch macro
> 19bd531 lib: sbi_hsm: Simplify hart_get_state() and hart_started() APIs
> 3ebfe0e lib: sbi_tlb: Simplify sbi_tlb_entry_process() function
> 209134d lib: Handle failure of sbi_hartid_to_scratch() API
> bd6ef02 include: sbi_platform: Improve sbi_platform_hart_disabled() API
> c9f60fc lib: sbi_scratch: Don't set hartid_to_scratch table for disabled HART
> 680b098 lib: sbi_hsm: Don't use sbi_platform_hart_count() API
> db187d6 lib: sbi_hsm: Remove scratch parameter from hart_started_mask() API
> 814f38d lib: sbi_hsm: Don't use sbi_platform_hart_disabled() API
> 75eec9d lib: Don't use sbi_platform_hart_count() API
> c51f02c include: sbi_platform: Introduce HART index to HART id table
> 315a877 platform: sifive/fu540: Remove FU540_ENABLED_HART_MASK option
> a0c88dd lib: Fix sbi_ecall_register_extension to prevent extension IDs overlap
> 9a74a64 lib: Check MSIP bit after returning from WFI
> 5968894 platform: Move ariane standalone fpga project to its own project
> ed265b4 platform: fpga/ariane: Remove redundant plic address macros
> fb84879 platform: Add OpenPiton platform support
> d1d6560 platform: fpga/common: Add a fdt parsing helper functions
> 040e4e2 lib: utils: Move fdt fixup helper routines to a different file
> 4c37451 platform: openpiton: Read the device configurations from device tree
> 4d93586 lib: prevent coldboot_lottery from overflowing
> 550ba88 scripts: Extend create-binary-archive.sh for unified binary tar ball
> 160c885 lib: utils: Improve fdt_cpu_fixup() implementation
> 1de66d1 lib: Optimize unpriv load/store implementation
> 626467c lib: Remove scratch parameter from unpriv load/store functions
> cb78a48 lib: sbi_trap: Remove scratch parameter from sbi_trap_redirect()
> d11c79c lib: sbi_emulate_csr: Remove scratch and hartid parameter
> 5a7bd0c lib: sbi_illegal_insn: Remove mcause, scratch and hartid parameters
> fe37d7d lib: sbi_misaligned_ldst: Remove mcause, scratch and hartid parameters
> 7487116 lib: sbi_ecall: Remove mcause, scratch and hartid parameters
> 40b221b lib: sbi_trap: Simplify sbi_trap_handler() API
> 7b211ff include: sbi_platform: Remove priv parameter from hart_start() callback
> 5b6957e include: Use more consistent name for atomic xchg() and cmpxchg()
> dd0f21c lib: sbi_scratch: Introduce sbi_scratch_last_hartid() API
> 54b2779 include: sbi_tlb: Remove scratch parameter from sbi_tlb_request()
> 9e52a45 include: sbi_ipi: Remove scratch parameter from most functions
> ec0d80f include: sbi_system: Remove scratch parameter and redundant functions
> 0a28ea5 include: sbi_timer: Remove scratch parameter from most funcitons
> 648507a include: sbi_console: Remove scratch parameter from sbi_dprintf()
> e5a7f55 platform: thead/c910: Use HSM extension to boot secondary cores
> f281de8 lib: irqchip/plic: Fix maximum priority threshold value
> 6c7922e lib: Support vector extension
> 615587c docs: Update README about supported SBI versions
> 66d0184 lib: Allow overriding SBI implementation ID
> 9f1b72c include: Bump-up version to 0.7
>
> Signed-off-by: Bin Meng <bmeng.cn@gmail.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Can you share a git branch with this patch? From memory these binary
patches don't apply well from emails.

Alistair

