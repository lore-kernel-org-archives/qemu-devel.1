Return-Path: <SRS0=2P1T=2A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB4F5C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 19:07:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEB0B206EC
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 19:07:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cQVdqV15"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEB0B206EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iekqh-00016w-PT
	for qemu-devel@archiver.kernel.org; Tue, 10 Dec 2019 14:07:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48496)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iekpk-0000ZT-GP
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 14:06:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iekpi-0003qg-Sr
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 14:06:08 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:46652)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iekpi-0003qQ-OD; Tue, 10 Dec 2019 14:06:06 -0500
Received: by mail-oi1-x242.google.com with SMTP id a124so10801764oii.13;
 Tue, 10 Dec 2019 11:06:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Ew2Mfv9DJedyehDdcZQsceGBY9fQbZTmHLUbTp5GUW0=;
 b=cQVdqV15i2gy9Tr2QXMYPOQjPtOnKxsIQiNb0YJ7kPZDDbMN0MvS01NIXeWMi/7quG
 LTjhWiHkS+M9Dpw2GFo6G5TRhvP00rn52nS89Jf7T5EKSTwx6arU/2Do+rbtNmQO0Lr6
 1KYTmt6UPqZDQ2d98wBkp7YjhzL+orX+N92RF19mrdvIgOLGqbYe7RQPblK4y5C6VOA7
 XW81Dmg8Cn1FRQuMWrlVgkgISQCav1bsZ30q0C9j6JkD5obQZTXZ5XQH/sA5weX/w0BH
 zOu+T9ejJ1PWrHkkhOhHpQH5dEMpjPJUzOhe2En/Y9sO2sz8cavvXQjE7EhJx53ER0Kf
 7nvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Ew2Mfv9DJedyehDdcZQsceGBY9fQbZTmHLUbTp5GUW0=;
 b=POwU+rG9MojDKTOl4HWCrR2E8w/gYU5jYElQEnem+EkF0ri6FG2L/QEKj4fnCdQzGh
 sXjxPGVzeFhbRyMdIUajLpQBY4K+FUrWL6L6qrE2U5YTL52dEU1yndl7MpXRkYOJTL3g
 fqQqBVmsN/5Y/4YOWKndYoEdvw1tKO6u0QgU37lv0bO9ulSM5u7dkMPCt6eEcF+rayCh
 YzLg+KxufKLLIvA50joYkmQ5mIUTxgEZiq23Sf8mrSsMiZ8pu65s53e/YEcqb0mBN7Dg
 RKhbbWimlnYWhDO093Sqs8TEtGW8gh8VjF1Xtm+45x1VN3hD+XhLnRzDb0E8IJFh3UMS
 QgOA==
X-Gm-Message-State: APjAAAWDgFG92AR3TXSRJk0Qr5qVfCKObVD8xvKnTObOXWMNJ0tX6422
 RBUKZzxIETXg+3uKqnkASoZ1xGSTiv1dOvCDfOQ=
X-Google-Smtp-Source: APXvYqyap1sg5DWdEIwhdLrGmqqIFdytTMDosttLJ8Dps5n+PM+I+1/ib6EiaGOBEAgHv2w/p76khjUubXK9HpcmBEk=
X-Received: by 2002:aca:bd85:: with SMTP id n127mr351654oif.136.1576004765574; 
 Tue, 10 Dec 2019 11:06:05 -0800 (PST)
MIME-Version: 1.0
References: <cover.1575914822.git.alistair.francis@wdc.com>
 <CAL1e-=gCcvYeRw0=vpC0QGcO_UzOtKJVLnLkAuETZ+KgoLO-iA@mail.gmail.com>
 <CAKmqyKMNsxWrSw8Rd1DHAhxk7PnrrD0J-tkNQT4HGKTQ2Q=erA@mail.gmail.com>
In-Reply-To: <CAKmqyKMNsxWrSw8Rd1DHAhxk7PnrrD0J-tkNQT4HGKTQ2Q=erA@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Tue, 10 Dec 2019 20:05:54 +0100
Message-ID: <CAL1e-=iMhjqP5KRNOUsTw174_V265k82kvxr1tYP7k4uX5Kq0g@mail.gmail.com>
Subject: Re: [PATCH v1 00/36] Add RISC-V Hypervisor Extension v0.5
To: Alistair Francis <alistair23@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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
Cc: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "palmer@dabbelt.com" <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Dec 10, 2019 at 1:04 AM Alistair Francis <alistair23@gmail.com> wro=
te:
>
> On Mon, Dec 9, 2019 at 2:55 PM Aleksandar Markovic
> <aleksandar.m.mail@gmail.com> wrote:
> >
> >
> >
> > On Monday, December 9, 2019, Alistair Francis <alistair.francis@wdc.com=
> wrote:
> >>
> >> This patch series adds the RISC-V Hypervisor extension v0.5. This is t=
he
> >> latest draft spec of the Hypervisor extension.
> >>
> >
> > Hi, Alistair,
> >
> > I have a question for you:
> >
> > Let's say this series is accepted. And let's say, next year, the draft =
spec of RISC-V Hypervisor extension v0.6 is released, and you or somebody e=
lse comes up with series on QEMU support for it, and that series is accepte=
d too. What would happen afterwards:
> >
> > A. Both support for v0.5 and v0.6 would continue to coexist perpetually
> >
> > B. Support for v0.5 would be deprecated according to QEMU deprecation r=
ules, and in two cycle would disappear
> >
> > C. Support for v0.5 would abruptly stop existing
>
> My current plan is to upgrade the implementation to the next version
> and drop v0.5 when a new spec release. happens.
>
> The justification for this is that the Hypervisor is a draft
> extension, disabled by default and marked as experimental. Therefore I
> think it's ok to just support the latest version of the spec.
>

OK. Thanks for clarification.

> Alistair
>
> >
> > D. Something else
> >
> > ?
> >
> > Thanks,
> > Aleksandar
> >
> >
> >>
> >> The Hypervisor extension is disabled by default, so this series should
> >> result in no changes to anyone using QEMU unless they enable the
> >> extension. The extention can be enabled with the -cpu property (see
> >> below).
> >>
> >> Testing of this implementation has been done by using the baremetal
> >> Xvisor Hypervisor. We are able to run two Linux guests (that's all I
> >> have tried) as guests in 64-bit. In 32-bit so far I can only run
> >> baremetal guests, but I think this is a baremetal boot loader issue an=
d
> >> not an issue in QEMU.
> >>
> >> The RISC-V KVM implementation was also written using these patches. Th=
e
> >> KVM implementation is currently under review.
> >>
> >> At the moment this spec is in a draft state and is subject to change. =
As
> >> QEMU is extreamly useful in early bring up I think it makes sense for
> >> QEMU to support non-frozen extensions.
> >>
> >> Thanks to Anup for doing the initial port of Xvisor. The port is avali=
able here:
> >> https://github.com/avpatel/xvisor-next and will run on QEMU.
> >>
> >> Also thanks to Atish for implementing the SBI call support in Xvisor a=
nd
> >> for lots of help debugging.
> >>
> >> To run this yourself:
> >>  1. Apply this patch series to QEMU. The latest branch can be found he=
re:
> >>       https://github.com/alistair23/qemu/tree/mainline/alistair/riscv-=
hyp-ext-v0.5.next
> >>  2. Get the version of OpenSBI that supports the H extension. This can
> >>     be found here:
> >>       https://github.com/avpatel/opensbi/tree/riscv_hyp_ext_0_5_v1
> >>  3. Build the next release of Xvisor. It is available here:
> >>       https://github.com/avpatel/xvisor-next
> >>  4. Make sure you build the Xvisor tests, see here for details:
> >>       https://github.com/avpatel/xvisor-next/tree/master/tests/riscv/v=
irt64/linux
> >>  5. Run QEMU:
> >>      ./riscv64-softmmu/qemu-system-riscv64 -nographic \
> >>        -machine virt -cpu rv64,x-h=3Dtrue \
> >>        -serial mon:stdio -serial null -m 4G \
> >>        -device loader,file=3Dvmm.bin,addr=3D0x80200000 \
> >>        -kernel fw_jump.elf \
> >>        -initrd vmm-disk-linux.img \
> >>        -append "vmm.console=3Duart@10000000 vmm.bootcmd=3D\"vfs mount =
initrd /;vfs run /boot.xscript;vfs cat /system/banner.txt\""
> >>
> >>    Once you get to the prompt you can start the geust by running:
> >>      guest kick guest0
> >>    You can then bind to the serial port using:
> >>      vserial bind guest0/uart0
> >>    Then you can start Linux using:
> >>      autoexec
> >>
> >>  This was all tested with the mainline 5.2/5.3 kernels.
> >>
> >> There is very early work on a Xen port as well which is avaliable here=
:
> >> https://github.com/alistair23/xen/tree/alistair/riscv-port
> >>
> >> ToDo/Issues
> >>  - Get 32-bit fully working
> >>
> >>
> >>
> >> Alistair Francis (36):
> >>   target/riscv: Convert MIP CSR to target_ulong
> >>   target/riscv: Don't set write permissions on dirty PTEs
> >>   target/riscv: Add the Hypervisor extension
> >>   target/riscv: Add the Hypervisor CSRs to CPUState
> >>   target/riscv: Add support for the new execption numbers
> >>   target/riscv: Rename the H irqs to VS irqs
> >>   target/riscv: Add the virtulisation mode
> >>   target/riscv: Add the force HS exception mode
> >>   target/riscv: Fix CSR perm checking for HS mode
> >>   target/riscv: Print priv and virt in disas log
> >>   target/riscv: Dump Hypervisor registers if enabled
> >>   target/riscv: Add Hypervisor CSR access functions
> >>   target/riscv: Add Hypervisor virtual CSRs accesses
> >>   target/riscv: Add Hypervisor virtual CSRs accesses
> >>   target/riscv: Convert mstatus to pointers
> >>   target/riscv: Add virtual register swapping function
> >>   target/riscv: Set VS bits in mideleg for Hyp extension
> >>   target/riscv: Extend the MIE CSR to support virtulisation
> >>   target/riscv: Extend the SIP CSR to support virtulisation
> >>   target/riscv: Add support for virtual interrupt setting
> >>   target/ricsv: Flush the TLB on virtulisation mode changes
> >>   target/riscv: Generate illegal instruction on WFI when V=3D1
> >>   target/riscv: Add hypvervisor trap support
> >>   target/riscv: Add Hypervisor trap return support
> >>   target/riscv: Add hfence instructions
> >>   target/riscv: Remove the hret instruction
> >>   target/riscv: Disable guest FP support based on virtual status
> >>   target/riscv: Mark both sstatus and vsstatus as dirty
> >>   target/riscv: Respect MPRV and SPRV for floating point ops
> >>   target/riscv: Allow specifying MMU stage
> >>   target/riscv: Implement second stage MMU
> >>   target/riscv: Raise the new execptions when 2nd stage translation
> >>     fails
> >>   target/riscv: Set htval and mtval2 on execptions
> >>   target/riscv: Add support for the 32-bit MSTATUSH CSR
> >>   target/riscv: Add the MSTATUS_MPV_ISSET helper macro
> >>   target/riscv: Allow enabling the Hypervisor extension
> >>
> >>  target/riscv/cpu.c                            |  71 ++-
> >>  target/riscv/cpu.h                            |  58 +-
> >>  target/riscv/cpu_bits.h                       | 111 ++--
> >>  target/riscv/cpu_helper.c                     | 501 +++++++++++++++--=
-
> >>  target/riscv/csr.c                            | 389 +++++++++++++-
> >>  target/riscv/gdbstub.c                        |  11 +-
> >>  target/riscv/insn32.decode                    |  22 +-
> >>  .../riscv/insn_trans/trans_privileged.inc.c   |  45 +-
> >>  target/riscv/op_helper.c                      |  81 ++-
> >>  target/riscv/translate.c                      |  34 ++
> >>  10 files changed, 1161 insertions(+), 162 deletions(-)
> >>
> >> --
> >> 2.24.0
> >>
> >>

