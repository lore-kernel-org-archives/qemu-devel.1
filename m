Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28607C2D0C4
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 22:56:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBF832071E
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 22:56:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C6+puMvg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBF832071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieRxJ-0002wW-0z
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 17:56:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38527)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ieRwf-0002Pl-Uz
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 17:56:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ieRwd-0006lE-PI
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 17:56:01 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:35784)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1ieRwd-0006kp-Ha; Mon, 09 Dec 2019 17:55:59 -0500
Received: by mail-ot1-x342.google.com with SMTP id o9so13801395ote.2;
 Mon, 09 Dec 2019 14:55:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=qNIButN8xfU6H2RHDrQjQv1vuyGbA4BSQ6aIrfPqbsw=;
 b=C6+puMvg8uTrpN6aZTe5Czbi5br2zEL5wFBdFmXLkTwy/1iRH4ljcRtHH3b++xHDgi
 Ec2/57JgGfUzafjvfUcNRrqU82mvkDlljJv0meEJHBZ4jfdgqME7sCPtkCfSmUxDagAs
 vwSxxYkyv3WadPXTzg9sNLm0vfn7hIkeEteWBFZpsNjGMQ/OQ/vukNOkz8f8CNfFOqLK
 7cbdJr0+UjtVYFVFYBxu0KWHq8EfRwf8T1JGxAaOy8R5/mXPYFONlzzkTVrynVxZOjri
 SQnM4exJZHyTAiS2pT+ZpxZFduWTwd6GW+/0uA+v6yOEEpVZ33JIXkAGBC1H5zP3qqvp
 ctjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=qNIButN8xfU6H2RHDrQjQv1vuyGbA4BSQ6aIrfPqbsw=;
 b=YWeSLxW5LBEitiq+4z5yn11Z0qtwZIhJ7XzTzikfWDzOiRqIGmVTt9dWJawVUE0ZUu
 QxL31/HOGh6hXUcLXQi6n99suFn70tWSXKQhrilflH2EQ+ULf5iAhCQ1TwtEagqc9qHR
 D1CMMLwjXJXIBNyjwgxTAsihyVKGw5Ee1NklMPQnt3CP2MWS27nDBGu3yApjHn641Xmf
 DYd+fH+gcUBj7hLJM709kAKdZFbjX6qqD3rpUHyNyqAUQBcdpRXsBenlDymf5KITbWFr
 t636dXc020WrY+l9TFtQ5cLDiItH6zHuT7epQxxt7La7Ce2uz/L72PFrTpdWTxJZyVx/
 0kUQ==
X-Gm-Message-State: APjAAAXxnHuGZoEj0+yT1IIdh45GU5F8agMx1KyCljhrSz00AMxjVLLb
 JDiAvzs492eJkwAGyFqLzCTMj9SaLd0T5KG7FJA=
X-Google-Smtp-Source: APXvYqxMdS9qFHcxLULeHrMk/B6371hsohXuTKKVKsSjGPqlbzInzs/FCnA2nQ5lGRUu0wKPmewNny5RL+8PWKr6Biw=
X-Received: by 2002:a9d:7c8f:: with SMTP id q15mr14354241otn.341.1575932158664; 
 Mon, 09 Dec 2019 14:55:58 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:d21:0:0:0:0:0 with HTTP;
 Mon, 9 Dec 2019 14:55:58 -0800 (PST)
In-Reply-To: <cover.1575914822.git.alistair.francis@wdc.com>
References: <cover.1575914822.git.alistair.francis@wdc.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Mon, 9 Dec 2019 23:55:58 +0100
Message-ID: <CAL1e-=gCcvYeRw0=vpC0QGcO_UzOtKJVLnLkAuETZ+KgoLO-iA@mail.gmail.com>
Subject: Re: [PATCH v1 00/36] Add RISC-V Hypervisor Extension v0.5
To: Alistair Francis <alistair.francis@wdc.com>
Content-Type: multipart/alternative; boundary="00000000000081e4a205994d4c0f"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "palmer@dabbelt.com" <palmer@dabbelt.com>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "alistair23@gmail.com" <alistair23@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000081e4a205994d4c0f
Content-Type: text/plain; charset="UTF-8"

On Monday, December 9, 2019, Alistair Francis <alistair.francis@wdc.com>
wrote:

> This patch series adds the RISC-V Hypervisor extension v0.5. This is the
> latest draft spec of the Hypervisor extension.
>
>
Hi, Alistair,

I have a question for you:

Let's say this series is accepted. And let's say, next year, the draft spec
of RISC-V Hypervisor extension v0.6 is released, and you or somebody else
comes up with series on QEMU support for it, and that series is accepted
too. What would happen afterwards:

A. Both support for v0.5 and v0.6 would continue to coexist perpetually

B. Support for v0.5 would be deprecated according to QEMU deprecation
rules, and in two cycle would disappear

C. Support for v0.5 would abruptly stop existing

D. Something else

?

Thanks,
Aleksandar



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
> Thanks to Anup for doing the initial port of Xvisor. The port is avaliable
> here:
> https://github.com/avpatel/xvisor-next and will run on QEMU.
>
> Also thanks to Atish for implementing the SBI call support in Xvisor and
> for lots of help debugging.
>
> To run this yourself:
>  1. Apply this patch series to QEMU. The latest branch can be found here:
>       https://github.com/alistair23/qemu/tree/mainline/alistair/
> riscv-hyp-ext-v0.5.next
>  2. Get the version of OpenSBI that supports the H extension. This can
>     be found here:
>       https://github.com/avpatel/opensbi/tree/riscv_hyp_ext_0_5_v1
>  3. Build the next release of Xvisor. It is available here:
>       https://github.com/avpatel/xvisor-next
>  4. Make sure you build the Xvisor tests, see here for details:
>       https://github.com/avpatel/xvisor-next/tree/master/tests/
> riscv/virt64/linux
>  5. Run QEMU:
>      ./riscv64-softmmu/qemu-system-riscv64 -nographic \
>        -machine virt -cpu rv64,x-h=true \
>        -serial mon:stdio -serial null -m 4G \
>        -device loader,file=vmm.bin,addr=0x80200000 \
>        -kernel fw_jump.elf \
>        -initrd vmm-disk-linux.img \
>        -append "vmm.console=uart@10000000 vmm.bootcmd=\"vfs mount initrd
> /;vfs run /boot.xscript;vfs cat /system/banner.txt\""
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
>
>
> Alistair Francis (36):
>   target/riscv: Convert MIP CSR to target_ulong
>   target/riscv: Don't set write permissions on dirty PTEs
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
>   target/riscv: Add Hypervisor virtual CSRs accesses
>   target/riscv: Convert mstatus to pointers
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
>   target/riscv: Disable guest FP support based on virtual status
>   target/riscv: Mark both sstatus and vsstatus as dirty
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
>  target/riscv/cpu.c                            |  71 ++-
>  target/riscv/cpu.h                            |  58 +-
>  target/riscv/cpu_bits.h                       | 111 ++--
>  target/riscv/cpu_helper.c                     | 501 +++++++++++++++---
>  target/riscv/csr.c                            | 389 +++++++++++++-
>  target/riscv/gdbstub.c                        |  11 +-
>  target/riscv/insn32.decode                    |  22 +-
>  .../riscv/insn_trans/trans_privileged.inc.c   |  45 +-
>  target/riscv/op_helper.c                      |  81 ++-
>  target/riscv/translate.c                      |  34 ++
>  10 files changed, 1161 insertions(+), 162 deletions(-)
>
> --
> 2.24.0
>
>
>

--00000000000081e4a205994d4c0f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Monday, December 9, 2019, Alistair Francis &lt;<a href=3D"mailto=
:alistair.francis@wdc.com">alistair.francis@wdc.com</a>&gt; wrote:<br><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #cc=
c solid;padding-left:1ex">This patch series adds the RISC-V Hypervisor exte=
nsion v0.5. This is the<br>
latest draft spec of the Hypervisor extension.<br>
<br></blockquote><div><br></div><div>Hi, Alistair,</div><div><br></div><div=
>I have a question for you:</div><div><br></div><div>Let&#39;s say this ser=
ies is accepted. And let&#39;s say, next year, the draft spec of RISC-V Hyp=
ervisor extension v0.6 is released, and you or somebody else comes up with =
series on QEMU support for it, and that series is accepted too. What would =
happen afterwards:</div><div><br></div><div>A. Both support for v0.5 and v0=
.6 would continue to coexist perpetually</div><div><br></div><div>B. Suppor=
t for v0.5 would be deprecated according to QEMU deprecation rules, and in =
two cycle would disappear</div><div><br></div><div>C. Support for v0.5 woul=
d abruptly stop existing</div><div><br></div><div>D. Something else</div><d=
iv><br></div><div>?</div><div><br></div><div>Thanks,</div><div>Aleksandar</=
div><div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
The Hypervisor extension is disabled by default, so this series should<br>
result in no changes to anyone using QEMU unless they enable the<br>
extension. The extention can be enabled with the -cpu property (see<br>
below).<br>
<br>
Testing of this implementation has been done by using the baremetal<br>
Xvisor Hypervisor. We are able to run two Linux guests (that&#39;s all I<br=
>
have tried) as guests in 64-bit. In 32-bit so far I can only run<br>
baremetal guests, but I think this is a baremetal boot loader issue and<br>
not an issue in QEMU.<br>
<br>
The RISC-V KVM implementation was also written using these patches. The<br>
KVM implementation is currently under review.<br>
<br>
At the moment this spec is in a draft state and is subject to change. As<br=
>
QEMU is extreamly useful in early bring up I think it makes sense for<br>
QEMU to support non-frozen extensions.<br>
<br>
Thanks to Anup for doing the initial port of Xvisor. The port is avaliable =
here:<br>
<a href=3D"https://github.com/avpatel/xvisor-next" target=3D"_blank">https:=
//github.com/avpatel/<wbr>xvisor-next</a> and will run on QEMU.<br>
<br>
Also thanks to Atish for implementing the SBI call support in Xvisor and<br=
>
for lots of help debugging.<br>
<br>
To run this yourself:<br>
=C2=A01. Apply this patch series to QEMU. The latest branch can be found he=
re:<br>
=C2=A0 =C2=A0 =C2=A0 <a href=3D"https://github.com/alistair23/qemu/tree/mai=
nline/alistair/riscv-hyp-ext-v0.5.next" target=3D"_blank">https://github.co=
m/alistair23/<wbr>qemu/tree/mainline/alistair/<wbr>riscv-hyp-ext-v0.5.next<=
/a><br>
=C2=A02. Get the version of OpenSBI that supports the H extension. This can=
<br>
=C2=A0 =C2=A0 be found here:<br>
=C2=A0 =C2=A0 =C2=A0 <a href=3D"https://github.com/avpatel/opensbi/tree/ris=
cv_hyp_ext_0_5_v1" target=3D"_blank">https://github.com/avpatel/<wbr>opensb=
i/tree/riscv_hyp_ext_0_<wbr>5_v1</a><br>
=C2=A03. Build the next release of Xvisor. It is available here:<br>
=C2=A0 =C2=A0 =C2=A0 <a href=3D"https://github.com/avpatel/xvisor-next" tar=
get=3D"_blank">https://github.com/avpatel/<wbr>xvisor-next</a><br>
=C2=A04. Make sure you build the Xvisor tests, see here for details:<br>
=C2=A0 =C2=A0 =C2=A0 <a href=3D"https://github.com/avpatel/xvisor-next/tree=
/master/tests/riscv/virt64/linux" target=3D"_blank">https://github.com/avpa=
tel/<wbr>xvisor-next/tree/master/tests/<wbr>riscv/virt64/linux</a><br>
=C2=A05. Run QEMU:<br>
=C2=A0 =C2=A0 =C2=A0./riscv64-softmmu/qemu-system-<wbr>riscv64 -nographic \=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0-machine virt -cpu rv64,x-h=3Dtrue \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0-serial mon:stdio -serial null -m 4G \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0-device loader,file=3Dvmm.bin,addr=3D<wbr>0x8020=
0000 \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0-kernel fw_jump.elf \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0-initrd vmm-disk-linux.img \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0-append &quot;vmm.console=3Duart@10000000 vmm.bo=
otcmd=3D\&quot;vfs mount initrd /;vfs run /boot.xscript;vfs cat /system/ban=
ner.txt\&quot;&quot;<br>
<br>
=C2=A0 =C2=A0Once you get to the prompt you can start the geust by running:=
<br>
=C2=A0 =C2=A0 =C2=A0guest kick guest0<br>
=C2=A0 =C2=A0You can then bind to the serial port using:<br>
=C2=A0 =C2=A0 =C2=A0vserial bind guest0/uart0<br>
=C2=A0 =C2=A0Then you can start Linux using:<br>
=C2=A0 =C2=A0 =C2=A0autoexec<br>
<br>
=C2=A0This was all tested with the mainline 5.2/5.3 kernels.<br>
<br>
There is very early work on a Xen port as well which is avaliable here:<br>
<a href=3D"https://github.com/alistair23/xen/tree/alistair/riscv-port" targ=
et=3D"_blank">https://github.com/alistair23/<wbr>xen/tree/alistair/riscv-po=
rt</a><br>
<br>
ToDo/Issues<br>
=C2=A0- Get 32-bit fully working<br>
<br>
<br>
<br>
Alistair Francis (36):<br>
=C2=A0 target/riscv: Convert MIP CSR to target_ulong<br>
=C2=A0 target/riscv: Don&#39;t set write permissions on dirty PTEs<br>
=C2=A0 target/riscv: Add the Hypervisor extension<br>
=C2=A0 target/riscv: Add the Hypervisor CSRs to CPUState<br>
=C2=A0 target/riscv: Add support for the new execption numbers<br>
=C2=A0 target/riscv: Rename the H irqs to VS irqs<br>
=C2=A0 target/riscv: Add the virtulisation mode<br>
=C2=A0 target/riscv: Add the force HS exception mode<br>
=C2=A0 target/riscv: Fix CSR perm checking for HS mode<br>
=C2=A0 target/riscv: Print priv and virt in disas log<br>
=C2=A0 target/riscv: Dump Hypervisor registers if enabled<br>
=C2=A0 target/riscv: Add Hypervisor CSR access functions<br>
=C2=A0 target/riscv: Add Hypervisor virtual CSRs accesses<br>
=C2=A0 target/riscv: Add Hypervisor virtual CSRs accesses<br>
=C2=A0 target/riscv: Convert mstatus to pointers<br>
=C2=A0 target/riscv: Add virtual register swapping function<br>
=C2=A0 target/riscv: Set VS bits in mideleg for Hyp extension<br>
=C2=A0 target/riscv: Extend the MIE CSR to support virtulisation<br>
=C2=A0 target/riscv: Extend the SIP CSR to support virtulisation<br>
=C2=A0 target/riscv: Add support for virtual interrupt setting<br>
=C2=A0 target/ricsv: Flush the TLB on virtulisation mode changes<br>
=C2=A0 target/riscv: Generate illegal instruction on WFI when V=3D1<br>
=C2=A0 target/riscv: Add hypvervisor trap support<br>
=C2=A0 target/riscv: Add Hypervisor trap return support<br>
=C2=A0 target/riscv: Add hfence instructions<br>
=C2=A0 target/riscv: Remove the hret instruction<br>
=C2=A0 target/riscv: Disable guest FP support based on virtual status<br>
=C2=A0 target/riscv: Mark both sstatus and vsstatus as dirty<br>
=C2=A0 target/riscv: Respect MPRV and SPRV for floating point ops<br>
=C2=A0 target/riscv: Allow specifying MMU stage<br>
=C2=A0 target/riscv: Implement second stage MMU<br>
=C2=A0 target/riscv: Raise the new execptions when 2nd stage translation<br=
>
=C2=A0 =C2=A0 fails<br>
=C2=A0 target/riscv: Set htval and mtval2 on execptions<br>
=C2=A0 target/riscv: Add support for the 32-bit MSTATUSH CSR<br>
=C2=A0 target/riscv: Add the MSTATUS_MPV_ISSET helper macro<br>
=C2=A0 target/riscv: Allow enabling the Hypervisor extension<br>
<br>
=C2=A0target/riscv/cpu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 71 ++-<br>
=C2=A0target/riscv/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 58 +-<br>
=C2=A0target/riscv/cpu_bits.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 111 ++--<br>
=C2=A0target/riscv/cpu_helper.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 501 +++++++++++++++---<br>
=C2=A0target/riscv/csr.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 389 +++++++++++++-<br>
=C2=A0target/riscv/gdbstub.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 11 +-<br>
=C2=A0target/riscv/insn32.decode=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 22 +-<br>
=C2=A0.../riscv/insn_trans/trans_<wbr>privileged.inc.c=C2=A0 =C2=A0|=C2=A0 =
45 +-<br>
=C2=A0target/riscv/op_helper.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 81 ++-<br>
=C2=A0target/riscv/translate.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 34 ++<br>
=C2=A010 files changed, 1161 insertions(+), 162 deletions(-)<br>
<br>
-- <br>
2.24.0<br>
<br>
<br>
</blockquote>

--00000000000081e4a205994d4c0f--

