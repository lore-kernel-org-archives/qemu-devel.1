Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58E29C34022
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 19:12:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A83E20836
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 19:12:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WzhdNYuU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A83E20836
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3lom-0002EU-CS
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 14:12:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52466)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmerdabbelt@google.com>) id 1j3lnu-0001ND-L2
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 14:11:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmerdabbelt@google.com>) id 1j3lnt-0007pI-3r
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 14:11:38 -0500
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:40279)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmerdabbelt@google.com>)
 id 1j3lns-0007om-UU
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 14:11:37 -0500
Received: by mail-pl1-x643.google.com with SMTP id y1so7089458plp.7
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 11:11:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:from:subject:in-reply-to:cc:to:message-id:mime-version
 :content-transfer-encoding;
 bh=l12nx0w7M+17//J/u69F9B6Eg5xA68JW3fr5sl7ZlGw=;
 b=WzhdNYuUkALfhEi9Z9hyB1tkkG8CWJsv9GjsOKmoc8GUFJyt91GbskN7iQptIysdYt
 NdXeqkcbd6yrSlSO3WITklPje3t99uyyZUjY5ORswIzFa8IcuBaL6y2UXUmMzZI3H1G6
 3HPYJMW/Yw+JwW8G4LDSKv8sHf6dHcu0k/JI4BankB4pbAwb5yq815jHHx45Qg7UQk//
 x16kTAcPe4lt1fTz8mywQCFYt31jgNeNY7SSeZWF6MbBTzBknFqx8Jaxjvz5HnIs6S85
 iQ3vXr1yVJoaPPBFfhy+DF13Ys6W9uavUpfqlqEdWe1IRaqHxHRdW417gLuQsLZ3kTvh
 j3QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:in-reply-to:cc:to:message-id
 :mime-version:content-transfer-encoding;
 bh=l12nx0w7M+17//J/u69F9B6Eg5xA68JW3fr5sl7ZlGw=;
 b=VnAJ6OPZ5y48cuUIHFZ6IR4JJVOwI+6PQOrB2fdh+MAe47y0uvVvnpo7ezx/hlYdGi
 F/S5ghdtWc9IAu4sd7wuf9knNrVHgGLAS6/u0GYKGjY/hkV+FmVdj8RUa4qsEmL1A8+y
 wpNxD1NE1W1PQ8D3VUqJ6BraWN94AxkazLUEzmDjG+jr59OsrZ8ahCKRqpqpA5jkvpWp
 DrBMixsi0kNm5uSK43W/pX1usmMw/LXky/wishrRKdMq3jZyFVUGQZ28ZGE5gYPiy9bP
 DATxcFwTc6ANwHILahrlGcKVJWiaBbMooQ8r3DGOqZ2HfuzrbjLSWtPuAHPctHSvXB+G
 yNxg==
X-Gm-Message-State: APjAAAUI/JmEt4OMWmghyGm29jtuf2WwQJ3KXG59sbvmwjL+KtNW9kRB
 er7dbh2dJbQO299puhA8fmon/X8sci0=
X-Google-Smtp-Source: APXvYqyKMu5tZFh1dngC9RqZBEA+se2/Exol3iikas2Y0OSZK3FD/G4diJ+/N4WfQ6VpRLuu+g6YQA==
X-Received: by 2002:a17:902:8e84:: with SMTP id
 bg4mr16666802plb.11.1581966695313; 
 Mon, 17 Feb 2020 11:11:35 -0800 (PST)
Received: from localhost ([2620:0:1000:2514:23a5:d584:6a92:3e3c])
 by smtp.gmail.com with ESMTPSA id 76sm1186941pfx.97.2020.02.17.11.11.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2020 11:11:34 -0800 (PST)
Date: Mon, 17 Feb 2020 11:11:34 -0800 (PST)
X-Google-Original-Date: Mon, 17 Feb 2020 11:11:27 PST (-0800)
From: Palmer Dabbelt <palmerdabbelt@google.com>
X-Google-Original-From: Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH v2 00/35]  Add RISC-V Hypervisor Extension v0.5
In-Reply-To: <cover.1580518859.git.alistair.francis@wdc.com>
CC: qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 Alistair Francis <Alistair.Francis@wdc.com>, alistair23@gmail.com
To: Alistair Francis <Alistair.Francis@wdc.com>
Message-ID: <mhng-e63de11d-bdf1-4863-86df-b9beb15ad68b@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::643
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

On Fri, 31 Jan 2020 17:01:35 PST (-0800), Alistair Francis wrote:
> This patch series adds the RISC-V Hypervisor extension v0.5. This is the
> latest draft spec of the Hypervisor extension.
>
> The Hypervisor extension is disabled by default, so this series should
> result in no changes to anyone using QEMU unless they enable the
> extension. The extention can be enabled with the -cpu property (see
> below).
>
> Testing of this implementation has been done by using the baremetal
> Xvisor Hypervisor. We are able to run two Linux guests (that's all I
> have tried) as guests in 64-bit. In 32-bit so far I can only run
> baremetal guests, but I think this is a baremetal boot loader issue and
> not an issue in QEMU.
>
> The RISC-V KVM implementation was also written using these patches. The
> KVM implementation is currently under review.
>
> At the moment this spec is in a draft state and is subject to change. As
> QEMU is extreamly useful in early bring up I think it makes sense for
> QEMU to support non-frozen extensions.
>
> Thanks to Anup for doing the initial port of Xvisor. The port is avaliable here:
> https://github.com/avpatel/xvisor-next and will run on QEMU.
>
> Also thanks to Atish for implementing the SBI call support in Xvisor and
> for lots of help debugging.
>
> To run this yourself:
>  1. Apply this patch series to QEMU. The latest branch can be found here:
>       https://github.com/alistair23/qemu/tree/mainline/alistair/riscv-hyp-ext-v0.5.next
>  2. Get the version of OpenSBI that supports the H extension. This can
>     be found here:
>       https://github.com/avpatel/opensbi/tree/riscv_hyp_ext_0_5_v1
>  3. Build the next release of Xvisor. It is available here:
>       https://github.com/avpatel/xvisor-next
>  4. Make sure you build the Xvisor tests, see here for details:
>       https://github.com/avpatel/xvisor-next/tree/master/tests/riscv/virt64/linux
>  5. Run QEMU:
>      ./riscv64-softmmu/qemu-system-riscv64 -nographic \
>        -machine virt -cpu rv64,x-h=true \
>        -serial mon:stdio -serial null -m 4G \
>        -device loader,file=vmm.bin,addr=0x80200000 \
>        -kernel fw_jump.elf \
>        -initrd vmm-disk-linux.img \
>        -append "vmm.console=uart@10000000 vmm.bootcmd=\"vfs mount initrd /;vfs run /boot.xscript;vfs cat /system/banner.txt\""
>
>    Once you get to the prompt you can start the geust by running:
>      guest kick guest0
>    You can then bind to the serial port using:
>      vserial bind guest0/uart0
>    Then you can start Linux using:
>      autoexec
>
>  This was all tested with the mainline 5.2/5.3 kernels.
>
> There is very early work on a Xen port as well which is avaliable here:
> https://github.com/alistair23/xen/tree/alistair/riscv-port
>
> ToDo/Issues
>  - Get 32-bit fully working
>
> v2:
>  - Don't use riscv_cpu_set_force_hs_excep() for 2nd stage MMU fauls as
>    the v0.5 spec has a specific fault
>  - Address review comments
>  - Rebase on master
>  - Remove pointers for mstatus
>
> Alistair Francis (35):
>   target/riscv: Convert MIP CSR to target_ulong
>   target/riscv: Add the Hypervisor extension
>   target/riscv: Add the Hypervisor CSRs to CPUState
>   target/riscv: Add support for the new execption numbers
>   target/riscv: Rename the H irqs to VS irqs
>   target/riscv: Add the virtulisation mode
>   target/riscv: Add the force HS exception mode
>   target/riscv: Fix CSR perm checking for HS mode
>   target/riscv: Print priv and virt in disas log
>   target/riscv: Dump Hypervisor registers if enabled
>   target/riscv: Add Hypervisor CSR access functions
>   target/riscv: Add Hypervisor virtual CSRs accesses
>   target/riscv: Add Hypervisor machine CSRs accesses
>   target/riscv: Add virtual register swapping function
>   target/riscv: Set VS bits in mideleg for Hyp extension
>   target/riscv: Extend the MIE CSR to support virtulisation
>   target/riscv: Extend the SIP CSR to support virtulisation
>   target/riscv: Add support for virtual interrupt setting
>   target/ricsv: Flush the TLB on virtulisation mode changes
>   target/riscv: Generate illegal instruction on WFI when V=1
>   target/riscv: Add hypvervisor trap support
>   target/riscv: Add Hypervisor trap return support
>   target/riscv: Add hfence instructions
>   target/riscv: Remove the hret instruction
>   target/riscv: Only set TB flags with FP status if enabled
>   target/riscv: Disable guest FP support based on virtual status
>   target/riscv: Mark both sstatus and msstatus_hs as dirty
>   target/riscv: Respect MPRV and SPRV for floating point ops
>   target/riscv: Allow specifying MMU stage
>   target/riscv: Implement second stage MMU
>   target/riscv: Raise the new execptions when 2nd stage translation
>     fails
>   target/riscv: Set htval and mtval2 on execptions
>   target/riscv: Add support for the 32-bit MSTATUSH CSR
>   target/riscv: Add the MSTATUS_MPV_ISSET helper macro
>   target/riscv: Allow enabling the Hypervisor extension
>
>  target/riscv/cpu.c                            |  57 ++-
>  target/riscv/cpu.h                            |  58 ++-
>  target/riscv/cpu_bits.h                       | 111 ++--
>  target/riscv/cpu_helper.c                     | 481 ++++++++++++++++--
>  target/riscv/csr.c                            | 369 +++++++++++++-
>  target/riscv/gdbstub.c                        |  11 +-
>  target/riscv/insn32.decode                    |  22 +-
>  .../riscv/insn_trans/trans_privileged.inc.c   |  45 +-
>  target/riscv/op_helper.c                      |  71 ++-
>  target/riscv/translate.c                      |  34 ++
>  10 files changed, 1130 insertions(+), 129 deletions(-)

OK, so everything should be reviewed and on for-master now.  I'll include it as
part of my next PR.

Thanks!

