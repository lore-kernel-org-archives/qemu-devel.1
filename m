Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58C1FC2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 22:04:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D03D120868
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 22:04:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="YQd24oxG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D03D120868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53586 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZMxr-0007BP-Cb
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 18:03:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47549)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <prvs=0547f94d1=alistair.francis@wdc.com>)
 id 1hZMrq-00041n-Vk
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 17:57:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=0547f94d1=alistair.francis@wdc.com>)
 id 1hZMrp-0001aM-2L
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 17:57:46 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:8430)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=0547f94d1=alistair.francis@wdc.com>)
 id 1hZMrn-0001Pu-VV; Fri, 07 Jun 2019 17:57:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1559944664; x=1591480664;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=JYFIrCWICvqJBGwWqopkXuF4NI80jpg1LcpH7GkVZVo=;
 b=YQd24oxGR2tUaRMr8fWmbJYt2RXAh5IJnqrv94xCCoevbruYcyRzSjWV
 M+FVicrGTwo6/qLkRD2Hr29gICoIn4R/cB0X62bU+s8P/gnIW5pDYxTsv
 lEqtr7YzW4B6jk0Gp3wfiMZoywHVL1Re0e1gt2BdYkSIOu6MML0hyNkIz
 Ld7j/DsczZKd4IXySBMhfcHTzbwx9NTdbY+IiKynGLMAgW21xHu9AV8Hv
 T/Hlwib6Kga/urSuRAkJtkrEaur/1cp+1g9LY5Bm7SMme4eZdYKZmaDll
 xDwfh8OUqNFusFj+2Xq1umfZpZPiLOW+G3av3Tlel3dFA+ht1HQZ5r/N/ w==;
X-IronPort-AV: E=Sophos;i="5.63,564,1557158400"; d="scan'208";a="115014068"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 08 Jun 2019 05:57:29 +0800
IronPort-SDR: yfi6J8oJvIQq1YtJivLcJ1jLAWdZl27HU3cFrOdA6QpkdpLmSizVQsYsVzEf17WT7D7er90Hq+
 OYKn2+ieflOkkRskhEcbqw4XReaT49tCLBehLHkNwo0EbrNONA9joe/FV51bagQKAtqmXgZpfT
 UzGAC2ghZeaTbGELzixQroZkaCuzmW/CAg8lK2eJa50r+C1aMi/pY17ERxtT0tLNUv5nqC03zZ
 x1IRVcNlwTEBbt4ecyNFwV+uUa2Mj/i0I3jF0RPf8cmX+/9BF0bDoEfRMVBqX3/1KLNzSoKPo+
 Lzx0z4ahWx0S3TiSrYg+6Yfh
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP; 07 Jun 2019 14:34:45 -0700
IronPort-SDR: xdndwhHewwFiTFskQzLc9EmpvIF3bV2xA+K4O6KRm/iXrav11NzpCSoziJbihZZ9L6ZGeNwJWu
 H4PkGCDnf6IJx1szCu80mdfwJwy0OzjkJS3Z/VcZwGj62+wDb3viegTcN7MaNkagTZrxlHmWcn
 yHwP0FaBLLiBwwbNzrwDXtgIJ29QPhheh+GZItSnrTSbn2cNX3RxIklGD+yUrxyUFvgvNb+3YH
 F9Eu0vcA9yo4EVXMWJcrHHpMv7Np/kWct73OxDQPYZXXJK05StzVWAqRICliwPXFBt8yizHzve
 zGc=
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.140])
 by uls-op-cesaip02.wdc.com with ESMTP; 07 Jun 2019 14:57:28 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Date: Fri,  7 Jun 2019 14:55:18 -0700
Message-Id: <cover.1559944445.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 216.71.153.141
Subject: [Qemu-devel] [PATCH v1 00/27]  Add RISC-V Hypervisor Extension
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
Cc: alistair23@gmail.com, palmer@sifive.com, alistair.francis@wdc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch series adds the RISC-V Hypervisor extension 0.3. This is the
latest draft spec of the Hypervisor extension.

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
 2. Get the version of OpenSBI that supports the H extension. This can
    be found here:
      https://github.com/riscv/opensbi/tree/hyp_ext_changes_v1
 3. Build the next release of Xvisor. It is available here:
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
 - Fix the random hang that sometimes appears when running a Hypervisor guest (~5%)

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

Changes from RFC:
 - Rebase on latest master
 - Add floating point changes from Hypervisor extension

Alistair Francis (27):
  target/riscv: Don't set write permissions on dirty PTEs
  target/riscv: Add the Hypervisor extension
  target/riscv: Add the virtulisation mode
  target/riscv: Add the force HS exception mode
  target/riscv: Add the Hypervisor CSRs to CPUState
  target/riscv: Dump Hypervisor registers if enabled
  target/riscv: Remove strict perm checking for CSR R/W
  target/riscv: Create function to test if FP is enabled
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
  target/riscv: Disable guest FP support based on backgrond status
  target/riscv: Mark both sstatus and bsstatus as dirty
  target/riscv: Respect MPRV and SPRV for floating point ops
  target/riscv: Allow specifying MMU stage
  target/riscv: Allow specifying number of MMU stages
  target/riscv: Implement second stage MMU
  target/riscv: Call the second stage MMU in virtualisation mode
  target/riscv: Allow enabling the Hypervisor extension

 hw/riscv/sifive_plic.c                        |  24 +-
 include/hw/riscv/sifive_plic.h                |   3 -
 target/riscv/cpu.c                            |  31 ++
 target/riscv/cpu.h                            |  32 +-
 target/riscv/cpu_bits.h                       |  32 +-
 target/riscv/cpu_helper.c                     | 443 ++++++++++++++++--
 target/riscv/csr.c                            | 216 ++++++++-
 target/riscv/insn32.decode                    |  23 +-
 .../riscv/insn_trans/trans_privileged.inc.c   |  40 ++
 target/riscv/op_helper.c                      |  71 ++-
 target/riscv/translate.c                      |  26 +
 11 files changed, 839 insertions(+), 102 deletions(-)

-- 
2.21.0


