Return-Path: <SRS0=Q7uJ=36=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B49AC35254
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 20:03:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D069320838
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 20:03:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o34iiC11"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D069320838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1FH5-0008TH-Vx
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 15:03:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60269)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1j1FDg-0005kK-Dj
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 14:59:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1j1FDe-0000ln-JW
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 14:59:48 -0500
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:41692)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1j1FDe-0000fP-A6; Mon, 10 Feb 2020 14:59:46 -0500
Received: by mail-lj1-x241.google.com with SMTP id h23so8750970ljc.8;
 Mon, 10 Feb 2020 11:59:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Icuuk++aNduIcarR/Zk6fEKxpiChaPqvlsjC4Iz8A2A=;
 b=o34iiC11DFFRJAt0ckd0NNDa67DKFzTRYWMKwbrfOfm0ysjBtax4prqtJ/SYGj/6pm
 Ec4z46oNw+mO/cdnn8WpMsD2+NkwP1qg06rhvq+6fMSBFpPVKZql8RT3naa3Fj4nIhWe
 PHcV1vN1eBVEsrPvOegskYoS9tkTi6XZqwHQtJOXA3ODPTEAKzcGJuYdPZTxRJAgTyr9
 yaFW6CBoufHPnVez/nMX83OkVwz4HLEsaPFnNPhPpCjPpQQqxOoqTe7ko/TZssHnBWEK
 7slNNZJ+R0d/Q3Ecuova+iP2ESDuAgx6LusooylbBbzc3C7AwCLcteFUXo9lHO+Eg0gT
 JOng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Icuuk++aNduIcarR/Zk6fEKxpiChaPqvlsjC4Iz8A2A=;
 b=kNhziSwkPZCa9j0IO+wnxJo3zK+WHMrBq+JkusV/hjdKIR4+0L+8a+8A2cD5IZybu7
 mSjzzyNpRrJ5fXkqNuJdxXuFl8wmoBkczI0ZTZ70/qj5p4W6an2mbwOYfMLeA1alZY0S
 /VPClVZ/C9x8FKVz0jUYq3autDW8H2UCB0pCv/fpBefagq59zavlEfkyPrOEnqsHdKey
 /QmYssXOiESE+NNZ9Y3IGGR19Kx3XavchHtUEYYYRBWDlVtTgYkVNUDKjbU5f2m9Gfqa
 2XmlDm4u+73D8wCAAOJ5kQj+WRyhSESWTd9vPM9/xdsk3fhp3ZtA3Qz0Pu4z9hV5prpy
 dtkg==
X-Gm-Message-State: APjAAAUBtkQZ2jTDyTByc613v0hMyvxa0UZzRWRl4SjI7hYY15sTwqUt
 AZLRmh0L/GoP6tMkJGBWv12L0VG5gqdLjhd+ymA=
X-Google-Smtp-Source: APXvYqwCODtH/HLIsKhXGaHp1iz9FWMT1y3c/t3DV7u/ruWV2twPiwmwpMsA7an9qh3wNL9nv4JDP4KeJ7Ic7Na1Dr4=
X-Received: by 2002:a2e:8119:: with SMTP id d25mr1964626ljg.76.1581364783097; 
 Mon, 10 Feb 2020 11:59:43 -0800 (PST)
MIME-Version: 1.0
References: <cover.1580518859.git.alistair.francis@wdc.com>
 <mhng-f46568ad-b708-4cc5-92ba-d7bd931020ce@palmerdabbelt-glaptop1>
In-Reply-To: <mhng-f46568ad-b708-4cc5-92ba-d7bd931020ce@palmerdabbelt-glaptop1>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 10 Feb 2020 11:52:25 -0800
Message-ID: <CAKmqyKM-vr6No_JZaK0-ySm17U6Ez5xp6zzBHkfhDkJyPnxfqg@mail.gmail.com>
Subject: Re: [PATCH v2 00/35] Add RISC-V Hypervisor Extension v0.5
To: Palmer Dabbelt <palmerdabbelt@google.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::241
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
 Alistair Francis <Alistair.Francis@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Feb 10, 2020 at 10:50 AM Palmer Dabbelt
<palmerdabbelt@google.com> wrote:
>
> On Fri, 31 Jan 2020 17:01:35 PST (-0800), Alistair Francis wrote:
> > This patch series adds the RISC-V Hypervisor extension v0.5. This is the
> > latest draft spec of the Hypervisor extension.
> >
> > The Hypervisor extension is disabled by default, so this series should
> > result in no changes to anyone using QEMU unless they enable the
> > extension. The extention can be enabled with the -cpu property (see
> > below).
> >
> > Testing of this implementation has been done by using the baremetal
> > Xvisor Hypervisor. We are able to run two Linux guests (that's all I
> > have tried) as guests in 64-bit. In 32-bit so far I can only run
> > baremetal guests, but I think this is a baremetal boot loader issue and
> > not an issue in QEMU.
> >
> > The RISC-V KVM implementation was also written using these patches. The
> > KVM implementation is currently under review.
> >
> > At the moment this spec is in a draft state and is subject to change. As
> > QEMU is extreamly useful in early bring up I think it makes sense for
> > QEMU to support non-frozen extensions.
> >
> > Thanks to Anup for doing the initial port of Xvisor. The port is avaliable here:
> > https://github.com/avpatel/xvisor-next and will run on QEMU.
> >
> > Also thanks to Atish for implementing the SBI call support in Xvisor and
> > for lots of help debugging.
> >
> > To run this yourself:
> >  1. Apply this patch series to QEMU. The latest branch can be found here:
> >       https://github.com/alistair23/qemu/tree/mainline/alistair/riscv-hyp-ext-v0.5.next
> >  2. Get the version of OpenSBI that supports the H extension. This can
> >     be found here:
> >       https://github.com/avpatel/opensbi/tree/riscv_hyp_ext_0_5_v1
> >  3. Build the next release of Xvisor. It is available here:
> >       https://github.com/avpatel/xvisor-next
> >  4. Make sure you build the Xvisor tests, see here for details:
> >       https://github.com/avpatel/xvisor-next/tree/master/tests/riscv/virt64/linux
> >  5. Run QEMU:
> >      ./riscv64-softmmu/qemu-system-riscv64 -nographic \
> >        -machine virt -cpu rv64,x-h=true \
> >        -serial mon:stdio -serial null -m 4G \
> >        -device loader,file=vmm.bin,addr=0x80200000 \
> >        -kernel fw_jump.elf \
> >        -initrd vmm-disk-linux.img \
> >        -append "vmm.console=uart@10000000 vmm.bootcmd=\"vfs mount initrd /;vfs run /boot.xscript;vfs cat /system/banner.txt\""
> >
> >    Once you get to the prompt you can start the geust by running:
> >      guest kick guest0
> >    You can then bind to the serial port using:
> >      vserial bind guest0/uart0
> >    Then you can start Linux using:
> >      autoexec
> >
> >  This was all tested with the mainline 5.2/5.3 kernels.
> >
> > There is very early work on a Xen port as well which is avaliable here:
> > https://github.com/alistair23/xen/tree/alistair/riscv-port
> >
> > ToDo/Issues
> >  - Get 32-bit fully working
> >
> > v2:
> >  - Don't use riscv_cpu_set_force_hs_excep() for 2nd stage MMU fauls as
> >    the v0.5 spec has a specific fault
> >  - Address review comments
> >  - Rebase on master
> >  - Remove pointers for mstatus
> >
> > Alistair Francis (35):
> >   target/riscv: Convert MIP CSR to target_ulong
> >   target/riscv: Add the Hypervisor extension
> >   target/riscv: Add the Hypervisor CSRs to CPUState
> >   target/riscv: Add support for the new execption numbers
> >   target/riscv: Rename the H irqs to VS irqs
> >   target/riscv: Add the virtulisation mode
> >   target/riscv: Add the force HS exception mode
> >   target/riscv: Fix CSR perm checking for HS mode
> >   target/riscv: Print priv and virt in disas log
> >   target/riscv: Dump Hypervisor registers if enabled
> >   target/riscv: Add Hypervisor CSR access functions
> >   target/riscv: Add Hypervisor virtual CSRs accesses
> >   target/riscv: Add Hypervisor machine CSRs accesses
> >   target/riscv: Add virtual register swapping function
> >   target/riscv: Set VS bits in mideleg for Hyp extension
> >   target/riscv: Extend the MIE CSR to support virtulisation
> >   target/riscv: Extend the SIP CSR to support virtulisation
> >   target/riscv: Add support for virtual interrupt setting
> >   target/ricsv: Flush the TLB on virtulisation mode changes
> >   target/riscv: Generate illegal instruction on WFI when V=1
> >   target/riscv: Add hypvervisor trap support
> >   target/riscv: Add Hypervisor trap return support
> >   target/riscv: Add hfence instructions
> >   target/riscv: Remove the hret instruction
> >   target/riscv: Only set TB flags with FP status if enabled
> >   target/riscv: Disable guest FP support based on virtual status
> >   target/riscv: Mark both sstatus and msstatus_hs as dirty
> >   target/riscv: Respect MPRV and SPRV for floating point ops
> >   target/riscv: Allow specifying MMU stage
> >   target/riscv: Implement second stage MMU
> >   target/riscv: Raise the new execptions when 2nd stage translation
> >     fails
> >   target/riscv: Set htval and mtval2 on execptions
> >   target/riscv: Add support for the 32-bit MSTATUSH CSR
> >   target/riscv: Add the MSTATUS_MPV_ISSET helper macro
> >   target/riscv: Allow enabling the Hypervisor extension
> >
> >  target/riscv/cpu.c                            |  57 ++-
> >  target/riscv/cpu.h                            |  58 ++-
> >  target/riscv/cpu_bits.h                       | 111 ++--
> >  target/riscv/cpu_helper.c                     | 481 ++++++++++++++++--
> >  target/riscv/csr.c                            | 369 +++++++++++++-
> >  target/riscv/gdbstub.c                        |  11 +-
> >  target/riscv/insn32.decode                    |  22 +-
> >  .../riscv/insn_trans/trans_privileged.inc.c   |  45 +-
> >  target/riscv/op_helper.c                      |  71 ++-
> >  target/riscv/translate.c                      |  34 ++
> >  10 files changed, 1130 insertions(+), 129 deletions(-)
>
> Thanks.  I'm going to send out the current queue, just to make sure it doesn't
> get blocked, and then dig through all this.  It should be essentially ready to
> go, IIRC there were just a few patches that changed enough to warrant a review.

Sounds good.

This series should be pretty straight forward to review. It's very
similar to the previous one.

Alistair

