Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B780C282E1
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 23:59:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FF1520674
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 23:59:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BIptT/b5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FF1520674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33363 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUK5Y-0006eJ-BD
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 19:59:04 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hUK3j-0005Im-LY
	for qemu-devel@nongnu.org; Fri, 24 May 2019 19:57:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hUJxn-00077j-94
	for qemu-devel@nongnu.org; Fri, 24 May 2019 19:51:05 -0400
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:35677)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1hUJxl-00072F-Aq; Fri, 24 May 2019 19:51:03 -0400
Received: by mail-lf1-x144.google.com with SMTP id c17so8302770lfi.2;
	Fri, 24 May 2019 16:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=j+HvD6J2CQkTJW83AP1VhzckRtl5qvaf4UrqX6hfIIY=;
	b=BIptT/b5XP2joQqheGYKoD056GkElMnALkPtgtd8EO9hrsfph32fdAqupkqSqtTjoc
	V8sfBHjofxLiKJGc3+Reqtz9TswL2nZsrx8IpsxvVG62KO2HBJ6IVtmFydXneGG+1ZSj
	apsKTOSQZE16v/n4JDGs6zXBt3r9xz1/N6xT6oKs92eK0+Y8bm66VxnqECcJdNq0q7M6
	A6/GWZYrsOA4/Ub6lcJjj9ct1p+obnxzgmytwB17yQsI2KOdbetY+XNGAeJBxG6Lq268
	9qOZH/B/IS5148GDJo2+57dbiSLRRBoDlKUJ4zWWqTbW/Dew6HnAf2jeUBhw917P7V33
	FQ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=j+HvD6J2CQkTJW83AP1VhzckRtl5qvaf4UrqX6hfIIY=;
	b=WdjidoiNU/N+nweRQj8o4RAWBooEedYK+b0WtIKh4qyPqoht34Atx0cMWwavsb3LkA
	e6YV/DvKUffur+D3EXdCs4h7WoLtQZ4j7OqpHXBaJxqhLxI0dz7jDKVIy/67uxvsxTi0
	X0H8uy2pYaohxDFmV9ql3Or/JAq01HrY5POBWVQUf3qFo4pdk1kTKhnAs0F1abRb0stw
	tOApXrXH9eIACWHOPjBIwa8xX3NAtYE8kYsVCeMR/8pi9CvtkCLMHwGRe1yDw7G+NXhQ
	q6gjWYPe1xOfwEXyNvfXfGfbo6aepL8R5VuX1gzormBjwE6DGdVCPqUVcsYT0qjr2Jmb
	2M5Q==
X-Gm-Message-State: APjAAAWMLpQSa70Gq6MzK17OkWWc3Y6iogCUOIidkffpDsj2Iv8+3DOU
	WTHNHK1C0rQskLryWz0/TU1mvVP9xM8XvOM5F0A=
X-Google-Smtp-Source: APXvYqyNI9wgIxmri3ZSnts/NaVvhAOg3PT5sDLgZMzdu2E6h+XAQpqiT52deDeomYZR3vt8dYmt84jrVxv/It9HbzU=
X-Received: by 2002:ac2:4576:: with SMTP id k22mr3295183lfm.156.1558741854512; 
	Fri, 24 May 2019 16:50:54 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1558741334.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1558741334.git.alistair.francis@wdc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 24 May 2019 16:50:28 -0700
Message-ID: <CAKmqyKOEbM+defS=7PjxTsAxaes-hq+sQKAg7p1QRWvMCrgwbA@mail.gmail.com>
To: Alistair Francis <alistair.francis@wdc.com>,
	Atish Patra <Atish.Patra@wdc.com>, Anup.Patel@wdc.com
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::144
Subject: Re: [Qemu-devel] [RFC v1 00/23] Add RISC-V Hypervisor Extension
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Palmer Dabbelt <palmer@sifive.com>,
	"open list:RISC-V" <qemu-riscv@nongnu.org>,
	"qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, May 24, 2019 at 4:47 PM Alistair Francis
<alistair.francis@wdc.com> wrote:
>
> This patch series adds the RISC-V Hypervisor extension 0.3. This is the
> latest draft spec of the Hypervisor extension.

Argh! I forgot to CC Atish and Anup, they are CCed now.

Just an FYI I will be on vacation next week, so any replys to this
series might be a little delayed.

Alistair

>
> This series applies ontop of the RISC-V tree as it requires the previous
> Hypervisor extension patches as well as the CPU parsing patches, both of
> which have been accepted to the RISC-V tree. The full Hypervisor support
> is avaliable at my GitHub (see below) which includes all required patches.
> This series won't apply ontop of master.
>
> The Hypervisor extension is disabled by default, so this series should
> result in no changes to anyone using QEMU unless they enable the
> extension. The extention can be enabled with the -cpu property (see
> below).
>
> At the moment the spec does not include information about the mstatush
> register. As it is not in the spec I haven't added it to QEMU. This
> means the extension won't work correctly for 32-bit guests. This should
> be a small fix to add the CSR once the spec is updated.
>
> All testing of this implementation has been done by using the baremetal
> Xvisor Hypervisor. We are able to run two Linux guests (that's all I
> have tried) as guests.
>
> At the moment this spec is in a draft state and is subject to change. As
> QEMU is extreamly useful in early bring up I think it makes sense for
> QEMU to support non-frozen extensions. I would like to decide with this
> series how QEMU will handle all future non-frozen extensions. That is a
> standard way that QEMU users can test future RISC-V extensions while
> still understanding things will change. One idea is just to disable it by
> default, another option is to maybe use the Kconfig to make it a compile
> time option which developers can use. Should we also display a warning
> when running non-frozen extensions?
>
> Thanks to Anup for doing the initial port of Xvisor. The port is avaliable here:
> https://github.com/avpatel/xvisor-next and will run on QEMU.
>
> Also thanks to Atish for implementing the SBI call support in Xvisor and
> for lots of help debugging.
>
> To run this yourself:
>  1. Apply this patch series to QEMU. The latest branch can be found here:
>       https://github.com/alistair23/qemu/tree/mainline/alistair/riscv-hyp-work.next
>  2. Get the version of OpenSBI that supports the H extenstion. This can
>     be found here:
>       https://github.com/riscv/opensbi/tree/hyp_ext_changes_v1
>  3. Build the next release of Xvisor. It is avaliable here:
>       https://github.com/avpatel/xvisor-next
>  4. Make sure you build the Xvisor tests, see here for details:
>       https://github.com/avpatel/xvisor-next/tree/master/tests/riscv/virt64/linux
>  5. Run QEMU:
>      ./riscv64-softmmu/qemu-system-riscv64 -nographic \
>        -machine virt -cpu rv64,h=true\
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
>  This was all tested with the mainline 5.1 kernel. I don't know if it
>  will work on older kernels.
>
> So far all of the QEMU work has been tested on Xvisor.
>
> Known Issues/TODO:
>  - Add mstatush to support 32-bit Hypervisors
>  - Add support for bsstatus.FS and sstatus.FS from the Hypervisor spec
>  - Fix the random hang that sometimes appears when running a Hypervisor guest
>
> There is also on going work from Anup to port KVM.
> We have code complete implementation of RISC-V KVM kernel module and
> RISC-V KVMTOOL. Currently, we are debugging KVM on QEMU and we will
> send-out RFC PATCHES for KVM in June/July 2019.
> The KVM RISC-V kernel module is available in riscv_kvm_v1
> branch at: https://github.com/avpatel/linux.git
> The KVMTOOL RISC-V port is available in riscv_v1 branch of
> https://github.com/avpatel/kvmtool.git
>
> There is very early work on a Xen port as well which is avaliable here:
> https://github.com/alistair23/xen/tree/alistair/riscv-port
>
> Alistair Francis (23):
>   target/riscv: Don't set write permissions on dirty PTEs
>   target/riscv: Add the Hypervisor extension
>   target/riscv: Add the virtulisation mode
>   target/riscv: Add the force HS exception mode
>   target/riscv: Add the Hypervisor CSRs to CPUState
>   target/riscv: Dump Hypervisor registers if enabled
>   target/riscv: Remove strict perm checking for CSR R/W
>   target/riscv: Add support for background interrupt setting
>   target/riscv: Add Hypervisor CSR access functions
>   target/riscv: Add background CSRs accesses
>   target/riscv: Add background register swapping function
>   target/ricsv: Flush the TLB on virtulisation mode changes
>   target/riscv: Generate illegal instruction on WFI when V=1
>   riscv: plic: Remove unused interrupt functions
>   riscv: plic: Always set sip.SEIP bit for HS
>   target/riscv: Add hypvervisor trap support
>   target/riscv: Add Hypervisor trap return support
>   target/riscv: Add hfence instructions
>   target/riscv: Allow specifying MMU stage
>   target/riscv: Allow specifying number of MMU stages
>   target/riscv: Implement second stage MMU
>   target/riscv: Call the second stage MMU in virtualisation mode
>   target/riscv: Allow enabling the Hypervisor extension
>
>  hw/riscv/sifive_plic.c                        |  24 +-
>  include/hw/riscv/sifive_plic.h                |   3 -
>  target/riscv/cpu.c                            |  31 ++
>  target/riscv/cpu.h                            |  26 ++
>  target/riscv/cpu_bits.h                       |  32 +-
>  target/riscv/cpu_helper.c                     | 430 ++++++++++++++++--
>  target/riscv/csr.c                            | 194 +++++++-
>  target/riscv/insn32.decode                    |  23 +-
>  .../riscv/insn_trans/trans_privileged.inc.c   |  40 ++
>  target/riscv/op_helper.c                      |  71 ++-
>  10 files changed, 782 insertions(+), 92 deletions(-)
>
> --
> 2.21.0
>

