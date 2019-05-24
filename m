Return-Path: <SRS0=E2zY=TZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ED50C282E1
	for <qemu-devel@archiver.kernel.org>; Sat, 25 May 2019 00:08:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B5D920862
	for <qemu-devel@archiver.kernel.org>; Sat, 25 May 2019 00:08:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="bE3R+35R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B5D920862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33536 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUKF3-0006fl-H2
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 20:08:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60425)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=040baf4f1=alistair.francis@wdc.com>)
	id 1hUK4C-0005eB-AN
	for qemu-devel@nongnu.org; Fri, 24 May 2019 19:57:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=040baf4f1=alistair.francis@wdc.com>)
	id 1hUJuU-00048Z-7Z
	for qemu-devel@nongnu.org; Fri, 24 May 2019 19:47:39 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:51624)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=040baf4f1=alistair.francis@wdc.com>)
	id 1hUJuT-00043c-Eg; Fri, 24 May 2019 19:47:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
	d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
	t=1558741658; x=1590277658;
	h=from:to:cc:subject:date:message-id:mime-version:
	content-transfer-encoding;
	bh=Qw+UPGqQAxHksIeRq7lNcj/3djy60ogFXseFGb5WIvg=;
	b=bE3R+35RG5FDGwd3wimNpy6EJpYEY52m1NlvGyVnSG6UZh3hpQxm8Aho
	EcPgXALb48T5Ez3xm+8SaDKWwiAYomsAiyXtzVpUSZR2oXBjWtC/l2r7k
	v8iDRVgpdsFhAy1p/XV7k/2KE0sXap7NKxVHIq+jstBSgNBrhJXNbt7xE
	AU5fdZJfTiM5Ji/0tTYwJxDc3uFbuDOZn/113+CuIIH8J2MXNQ6W3F0AA
	rlNQ2tVGpaWMLlefv8Qq8ZXWowhAbnA9gzMKnuJmD9F/Drs2AQ4mmtkCk
	7RGqHmSHkTTl2XiLjKthyibZ+yQEAs7szrx1ujfcx5j1yODljXK0MHeby g==;
X-IronPort-AV: E=Sophos;i="5.60,508,1549900800"; d="scan'208";a="110307752"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
	([199.255.45.14])
	by ob1.hgst.iphmx.com with ESMTP; 25 May 2019 07:47:30 +0800
IronPort-SDR: z2mfUIA8SQ+HY6M3EqS2vlXFu+fPaMZKrvolXzoVL46UWGqYbXaclXnHEB92DpzyB9pqI0qDsk
	tDYDfpwSBfMO6Gt4QKaJlJqFLgCEQqLEYPpZ/ZIzi+MRBRoshuzFTzcOWMCgPEoW0WUqYLO3TS
	hS0Vyme6xljlVG6IX0kvYun8LEZrVVk93vvfMv/yyra2nKXnFe6vVMX8TgM6BHdMI2Ja9aZLnH
	gJz4SGdwBryRuVOVwZtHXZY45yYJN509zwrNh7Odj9p5z0485Ezj64eHRI94jZDcgk11FzOjwU
	zAcWiodeVfVxW/5BGelhD/6K
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
	by uls-op-cesaep01.wdc.com with ESMTP; 24 May 2019 16:22:48 -0700
IronPort-SDR: q8DGwvUUCG6InrB04CKBRNbjpmvhdrzBI4sIpsd2KbVsLWm72A0FIoZkfA/xXabAFNqwKzqpWx
	PleCp2tR2uhW93ZBqzG54t7HwIxdGvN9iE9YGELSsw4Bc43axLuyQIl099TiTRnSqRv1cIRTBL
	QI3BWg238zhk/yeFZan+LgStDg/3yA0dil/xo7h/oJ2THnQ4D5cp1AQQm9xMKNGJxQq7tA5Ka2
	pqQQktAiY/sjxEQZGxPpHBgKhwI91V9lm3Kpz+ffuIfEYFxqQQXLnDM/I1wVENkoarELjmfZ0Q
	E7E=
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
	risc6-mainframe.int.fusionio.com) ([10.196.157.140])
	by uls-op-cesaip02.wdc.com with ESMTP; 24 May 2019 16:47:29 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Date: Fri, 24 May 2019 16:45:35 -0700
Message-Id: <cover.1558741334.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 216.71.153.144
Subject: [Qemu-devel] [RFC v1 00/23]  Add RISC-V Hypervisor Extension
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
Cc: alistair23@gmail.com, palmer@sifive.com, alistair.francis@wdc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch series adds the RISC-V Hypervisor extension 0.3. This is the
latest draft spec of the Hypervisor extension.

This series applies ontop of the RISC-V tree as it requires the previous
Hypervisor extension patches as well as the CPU parsing patches, both of
which have been accepted to the RISC-V tree. The full Hypervisor support
is avaliable at my GitHub (see below) which includes all required patches.
This series won't apply ontop of master.

The Hypervisor extension is disabled by default, so this series should
result in no changes to anyone using QEMU unless they enable the
extension. The extention can be enabled with the -cpu property (see
below).

At the moment the spec does not include information about the mstatush
register. As it is not in the spec I haven't added it to QEMU. This
means the extension won't work correctly for 32-bit guests. This should
be a small fix to add the CSR once the spec is updated.

All testing of this implementation has been done by using the baremetal
Xvisor Hypervisor. We are able to run two Linux guests (that's all I
have tried) as guests.

At the moment this spec is in a draft state and is subject to change. As
QEMU is extreamly useful in early bring up I think it makes sense for
QEMU to support non-frozen extensions. I would like to decide with this
series how QEMU will handle all future non-frozen extensions. That is a
standard way that QEMU users can test future RISC-V extensions while
still understanding things will change. One idea is just to disable it by
default, another option is to maybe use the Kconfig to make it a compile
time option which developers can use. Should we also display a warning
when running non-frozen extensions?

Thanks to Anup for doing the initial port of Xvisor. The port is avaliable here:
https://github.com/avpatel/xvisor-next and will run on QEMU.

Also thanks to Atish for implementing the SBI call support in Xvisor and
for lots of help debugging.

To run this yourself:
 1. Apply this patch series to QEMU. The latest branch can be found here:
      https://github.com/alistair23/qemu/tree/mainline/alistair/riscv-hyp-work.next
 2. Get the version of OpenSBI that supports the H extenstion. This can
    be found here:
      https://github.com/riscv/opensbi/tree/hyp_ext_changes_v1
 3. Build the next release of Xvisor. It is avaliable here:
      https://github.com/avpatel/xvisor-next
 4. Make sure you build the Xvisor tests, see here for details:
      https://github.com/avpatel/xvisor-next/tree/master/tests/riscv/virt64/linux
 5. Run QEMU:
     ./riscv64-softmmu/qemu-system-riscv64 -nographic \
       -machine virt -cpu rv64,h=true\
       -serial mon:stdio -serial null -m 4G \
       -device loader,file=vmm.bin,addr=0x80200000 \
       -kernel fw_jump.elf \
       -initrd vmm-disk-linux.img \
       -append "vmm.console=uart@10000000 vmm.bootcmd=\"vfs mount initrd /;vfs run /boot.xscript;vfs cat /system/banner.txt\""

   Once you get to the prompt you can start the geust by running:
     guest kick guest0
   You can then bind to the serial port using:
     vserial bind guest0/uart0
   Then you can start Linux using:
     autoexec

 This was all tested with the mainline 5.1 kernel. I don't know if it
 will work on older kernels.

So far all of the QEMU work has been tested on Xvisor.

Known Issues/TODO:
 - Add mstatush to support 32-bit Hypervisors
 - Add support for bsstatus.FS and sstatus.FS from the Hypervisor spec
 - Fix the random hang that sometimes appears when running a Hypervisor guest

There is also on going work from Anup to port KVM.
We have code complete implementation of RISC-V KVM kernel module and
RISC-V KVMTOOL. Currently, we are debugging KVM on QEMU and we will
send-out RFC PATCHES for KVM in June/July 2019.
The KVM RISC-V kernel module is available in riscv_kvm_v1
branch at: https://github.com/avpatel/linux.git
The KVMTOOL RISC-V port is available in riscv_v1 branch of
https://github.com/avpatel/kvmtool.git

There is very early work on a Xen port as well which is avaliable here:
https://github.com/alistair23/xen/tree/alistair/riscv-port

Alistair Francis (23):
  target/riscv: Don't set write permissions on dirty PTEs
  target/riscv: Add the Hypervisor extension
  target/riscv: Add the virtulisation mode
  target/riscv: Add the force HS exception mode
  target/riscv: Add the Hypervisor CSRs to CPUState
  target/riscv: Dump Hypervisor registers if enabled
  target/riscv: Remove strict perm checking for CSR R/W
  target/riscv: Add support for background interrupt setting
  target/riscv: Add Hypervisor CSR access functions
  target/riscv: Add background CSRs accesses
  target/riscv: Add background register swapping function
  target/ricsv: Flush the TLB on virtulisation mode changes
  target/riscv: Generate illegal instruction on WFI when V=1
  riscv: plic: Remove unused interrupt functions
  riscv: plic: Always set sip.SEIP bit for HS
  target/riscv: Add hypvervisor trap support
  target/riscv: Add Hypervisor trap return support
  target/riscv: Add hfence instructions
  target/riscv: Allow specifying MMU stage
  target/riscv: Allow specifying number of MMU stages
  target/riscv: Implement second stage MMU
  target/riscv: Call the second stage MMU in virtualisation mode
  target/riscv: Allow enabling the Hypervisor extension

 hw/riscv/sifive_plic.c                        |  24 +-
 include/hw/riscv/sifive_plic.h                |   3 -
 target/riscv/cpu.c                            |  31 ++
 target/riscv/cpu.h                            |  26 ++
 target/riscv/cpu_bits.h                       |  32 +-
 target/riscv/cpu_helper.c                     | 430 ++++++++++++++++--
 target/riscv/csr.c                            | 194 +++++++-
 target/riscv/insn32.decode                    |  23 +-
 .../riscv/insn_trans/trans_privileged.inc.c   |  40 ++
 target/riscv/op_helper.c                      |  71 ++-
 10 files changed, 782 insertions(+), 92 deletions(-)

-- 
2.21.0


