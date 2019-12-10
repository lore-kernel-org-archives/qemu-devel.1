Return-Path: <SRS0=2P1T=2A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66CE6C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 00:05:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2996620726
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 00:05:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G0y0y9RZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2996620726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieT27-0000nS-76
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 19:05:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49978)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1ieT0t-0008Ls-JX
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 19:04:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1ieT0r-0000Zr-OL
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 19:04:27 -0500
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:38728)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1ieT0r-0000Yt-Cd; Mon, 09 Dec 2019 19:04:25 -0500
Received: by mail-lj1-x241.google.com with SMTP id k8so17705769ljh.5;
 Mon, 09 Dec 2019 16:04:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=+dtnDuNmjvxUOCf48+ZEEghPbyDR8jR5qVlyRqMdXZk=;
 b=G0y0y9RZbMVoprxNMjuNSRiwvdDveIWCCCD6k4K3/dreFnKI2VYNwa64OCJxiGaR5h
 uAUYhF7H8+pn24TZ+AqkYh+7BISJig5xPFJvuoY/ApdYOSZ+SJd/MkOTYJK7NhrJEDeh
 XOMGupjdbSYsLZCUGkfzyITZ/RfCsqXMeE4pbuw413C8VFHl2O+l41uSnngiTURv5Bj6
 hRuwl6iqUYdTchtLbfMpK8BiQStr+ZjzKYjuKEBIcK8EhdSb6IsDZhaQZtWxrbMTS/fZ
 Wc+isZCqilbhfN3tjzE4R5NqUkoC/xS+BPz+CkNe/bgfG4bZgTsZ+r1YoJW4Kwzn7q5R
 atdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=+dtnDuNmjvxUOCf48+ZEEghPbyDR8jR5qVlyRqMdXZk=;
 b=OlyBvrvg1S6wc64k0+hjSOKjf0bQ66jaIf09BllHc4/9dlckyA9ckJgeilJ47ntS2W
 poLR/5NDE/mZM4Qbsj+kCxFbUb4jaKU9+Xncqe9LiioEmT6XefLL7lZpCf3STTaOpIDD
 XWyjeHTjdMgSQNCUA5oCbafbiIdjU89i5/bg40M3JrgVui3Y+Pha7xbjqHp9kwni8H0G
 bOTEw6VHtIm3A+u+xeiD57uKP/+jJTlLR/Uffnmk87Y55gzLAE+KTnDM5VSZc3EhOFWP
 290YQXq9lnOnCY+T2MhQ0dCnFHQtP0hRWjoXcIvr40DStS2z+kanf+rYE2Jit8Y8YJU6
 Pnrw==
X-Gm-Message-State: APjAAAVZRLA6fUy1nE1nLf0aGrGEhXYZbgSFQs+DCE5dl/BhkGV4c2GF
 OeyvE5yzzYxgh8KDbYDWdYRLKH5dLbrDpPvq4VU=
X-Google-Smtp-Source: APXvYqxMaxkST12VkWoLbLw54v+Q/jw3PYarYLhhLjjNC/IycAInb6wobS1+MhF0jXuyjN0BODthGFGJWMEJF39HfCQ=
X-Received: by 2002:a2e:924e:: with SMTP id v14mr2633016ljg.7.1575936259613;
 Mon, 09 Dec 2019 16:04:19 -0800 (PST)
MIME-Version: 1.0
References: <cover.1575914822.git.alistair.francis@wdc.com>
 <CAL1e-=gCcvYeRw0=vpC0QGcO_UzOtKJVLnLkAuETZ+KgoLO-iA@mail.gmail.com>
In-Reply-To: <CAL1e-=gCcvYeRw0=vpC0QGcO_UzOtKJVLnLkAuETZ+KgoLO-iA@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 9 Dec 2019 16:03:53 -0800
Message-ID: <CAKmqyKMNsxWrSw8Rd1DHAhxk7PnrrD0J-tkNQT4HGKTQ2Q=erA@mail.gmail.com>
Subject: Re: [PATCH v1 00/36] Add RISC-V Hypervisor Extension v0.5
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "palmer@dabbelt.com" <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Dec 9, 2019 at 2:55 PM Aleksandar Markovic
<aleksandar.m.mail@gmail.com> wrote:
>
>
>
> On Monday, December 9, 2019, Alistair Francis <alistair.francis@wdc.com> =
wrote:
>>
>> This patch series adds the RISC-V Hypervisor extension v0.5. This is the
>> latest draft spec of the Hypervisor extension.
>>
>
> Hi, Alistair,
>
> I have a question for you:
>
> Let's say this series is accepted. And let's say, next year, the draft sp=
ec of RISC-V Hypervisor extension v0.6 is released, and you or somebody els=
e comes up with series on QEMU support for it, and that series is accepted =
too. What would happen afterwards:
>
> A. Both support for v0.5 and v0.6 would continue to coexist perpetually
>
> B. Support for v0.5 would be deprecated according to QEMU deprecation rul=
es, and in two cycle would disappear
>
> C. Support for v0.5 would abruptly stop existing

My current plan is to upgrade the implementation to the next version
and drop v0.5 when a new spec release. happens.

The justification for this is that the Hypervisor is a draft
extension, disabled by default and marked as experimental. Therefore I
think it's ok to just support the latest version of the spec.

Alistair

>
> D. Something else
>
> ?
>
> Thanks,
> Aleksandar
>
>
>>
>> The Hypervisor extension is disabled by default, so this series should
>> result in no changes to anyone using QEMU unless they enable the
>> extension. The extention can be enabled with the -cpu property (see
>> below).
>>
>> Testing of this implementation has been done by using the baremetal
>> Xvisor Hypervisor. We are able to run two Linux guests (that's all I
>> have tried) as guests in 64-bit. In 32-bit so far I can only run
>> baremetal guests, but I think this is a baremetal boot loader issue and
>> not an issue in QEMU.
>>
>> The RISC-V KVM implementation was also written using these patches. The
>> KVM implementation is currently under review.
>>
>> At the moment this spec is in a draft state and is subject to change. As
>> QEMU is extreamly useful in early bring up I think it makes sense for
>> QEMU to support non-frozen extensions.
>>
>> Thanks to Anup for doing the initial port of Xvisor. The port is avaliab=
le here:
>> https://github.com/avpatel/xvisor-next and will run on QEMU.
>>
>> Also thanks to Atish for implementing the SBI call support in Xvisor and
>> for lots of help debugging.
>>
>> To run this yourself:
>>  1. Apply this patch series to QEMU. The latest branch can be found here=
:
>>       https://github.com/alistair23/qemu/tree/mainline/alistair/riscv-hy=
p-ext-v0.5.next
>>  2. Get the version of OpenSBI that supports the H extension. This can
>>     be found here:
>>       https://github.com/avpatel/opensbi/tree/riscv_hyp_ext_0_5_v1
>>  3. Build the next release of Xvisor. It is available here:
>>       https://github.com/avpatel/xvisor-next
>>  4. Make sure you build the Xvisor tests, see here for details:
>>       https://github.com/avpatel/xvisor-next/tree/master/tests/riscv/vir=
t64/linux
>>  5. Run QEMU:
>>      ./riscv64-softmmu/qemu-system-riscv64 -nographic \
>>        -machine virt -cpu rv64,x-h=3Dtrue \
>>        -serial mon:stdio -serial null -m 4G \
>>        -device loader,file=3Dvmm.bin,addr=3D0x80200000 \
>>        -kernel fw_jump.elf \
>>        -initrd vmm-disk-linux.img \
>>        -append "vmm.console=3Duart@10000000 vmm.bootcmd=3D\"vfs mount in=
itrd /;vfs run /boot.xscript;vfs cat /system/banner.txt\""
>>
>>    Once you get to the prompt you can start the geust by running:
>>      guest kick guest0
>>    You can then bind to the serial port using:
>>      vserial bind guest0/uart0
>>    Then you can start Linux using:
>>      autoexec
>>
>>  This was all tested with the mainline 5.2/5.3 kernels.
>>
>> There is very early work on a Xen port as well which is avaliable here:
>> https://github.com/alistair23/xen/tree/alistair/riscv-port
>>
>> ToDo/Issues
>>  - Get 32-bit fully working
>>
>>
>>
>> Alistair Francis (36):
>>   target/riscv: Convert MIP CSR to target_ulong
>>   target/riscv: Don't set write permissions on dirty PTEs
>>   target/riscv: Add the Hypervisor extension
>>   target/riscv: Add the Hypervisor CSRs to CPUState
>>   target/riscv: Add support for the new execption numbers
>>   target/riscv: Rename the H irqs to VS irqs
>>   target/riscv: Add the virtulisation mode
>>   target/riscv: Add the force HS exception mode
>>   target/riscv: Fix CSR perm checking for HS mode
>>   target/riscv: Print priv and virt in disas log
>>   target/riscv: Dump Hypervisor registers if enabled
>>   target/riscv: Add Hypervisor CSR access functions
>>   target/riscv: Add Hypervisor virtual CSRs accesses
>>   target/riscv: Add Hypervisor virtual CSRs accesses
>>   target/riscv: Convert mstatus to pointers
>>   target/riscv: Add virtual register swapping function
>>   target/riscv: Set VS bits in mideleg for Hyp extension
>>   target/riscv: Extend the MIE CSR to support virtulisation
>>   target/riscv: Extend the SIP CSR to support virtulisation
>>   target/riscv: Add support for virtual interrupt setting
>>   target/ricsv: Flush the TLB on virtulisation mode changes
>>   target/riscv: Generate illegal instruction on WFI when V=3D1
>>   target/riscv: Add hypvervisor trap support
>>   target/riscv: Add Hypervisor trap return support
>>   target/riscv: Add hfence instructions
>>   target/riscv: Remove the hret instruction
>>   target/riscv: Disable guest FP support based on virtual status
>>   target/riscv: Mark both sstatus and vsstatus as dirty
>>   target/riscv: Respect MPRV and SPRV for floating point ops
>>   target/riscv: Allow specifying MMU stage
>>   target/riscv: Implement second stage MMU
>>   target/riscv: Raise the new execptions when 2nd stage translation
>>     fails
>>   target/riscv: Set htval and mtval2 on execptions
>>   target/riscv: Add support for the 32-bit MSTATUSH CSR
>>   target/riscv: Add the MSTATUS_MPV_ISSET helper macro
>>   target/riscv: Allow enabling the Hypervisor extension
>>
>>  target/riscv/cpu.c                            |  71 ++-
>>  target/riscv/cpu.h                            |  58 +-
>>  target/riscv/cpu_bits.h                       | 111 ++--
>>  target/riscv/cpu_helper.c                     | 501 +++++++++++++++---
>>  target/riscv/csr.c                            | 389 +++++++++++++-
>>  target/riscv/gdbstub.c                        |  11 +-
>>  target/riscv/insn32.decode                    |  22 +-
>>  .../riscv/insn_trans/trans_privileged.inc.c   |  45 +-
>>  target/riscv/op_helper.c                      |  81 ++-
>>  target/riscv/translate.c                      |  34 ++
>>  10 files changed, 1161 insertions(+), 162 deletions(-)
>>
>> --
>> 2.24.0
>>
>>

