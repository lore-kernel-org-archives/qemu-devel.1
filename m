Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7E05C43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 18:18:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A672A2080D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 18:18:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="nyy26ppO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A672A2080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieNc8-0008Ou-Ap
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 13:18:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34345)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=23948302b=alistair.francis@wdc.com>)
 id 1ieNa8-0006SK-9Q
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 13:16:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=23948302b=alistair.francis@wdc.com>)
 id 1ieNa6-00073C-QA
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 13:16:28 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:57622)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=23948302b=alistair.francis@wdc.com>)
 id 1ieNa6-000707-2y; Mon, 09 Dec 2019 13:16:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1575915386; x=1607451386;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=07+2TT8Mqx2a4MyDwcPbMvE1bAlmDWGUW17SRPcc+k8=;
 b=nyy26ppO5e4KeaSQev4lwNqegeyWLvSOFawwLgE6A39eQUZe/36xY5OD
 pc0hHwzxLYdsIkONNFCb2cs+NCxX+8gan/j9z6d7PAo9WRxaPpcCQPlX2
 ft+LTyEl8NhICmSBOd2FITw9lW2iRuLYnxzo0lOVoJWgTyLPJZhIDUrG7
 CHrZbY19QVqCu3C0GYZHR3UQQn/UpO0xfNlA5IIuE4mDhT+1pnsOOzN0V
 58/wVMZAOKztxreTkgeQq1ygzrYdwco8cTE9QhW2UubxIX4/o2b7DxvE4
 bKrhFaphSfv7T/J5oFjYIUjYeFbmh+EECBd4oxCVfh4lJASbKfZ3eKhv4 w==;
IronPort-SDR: 3BzXAH71wiZ43jPdeuonY5znbKDr9MzJBHzFqQjBzp00ebogvaoSbyOu7MfJ0vCrWG0ojEGruA
 X3D9Mal3Zu0IqjS7ahjE+E81/z33UYclOPAwGScSl857+wpvciO6yiiYspUjL7iftAqOklYtMS
 mIRCHP/zMC2TGYBISXPxvfgJgDonilSMXLtYfCETgAkrL2mefktNEUVG7SccX4KUReY4PzBCC/
 u4/a5HMBwR8EInK+PeBhV0nPQyDW6Xk94YoDnil50HfgyojVJjFTXbeUQXGTw5oHikIUY4TpeO
 Dhc=
X-IronPort-AV: E=Sophos;i="5.69,296,1571673600"; d="scan'208";a="129370392"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 10 Dec 2019 02:16:22 +0800
IronPort-SDR: +f4hhphK+ZiVtwQZ58BrdyetXdzcaRNLtmcD4pdVuOj6Gv7xntdTcJ6o1vinLOyD91PhO/597e
 P23GT2v/axDs4HP5rZ+RFe2auMn+lqIrakHiwroPzmnCachrTSFFndBDTXLe7OTC/xm+I95geS
 bZo3HZ/sPPE2n/mcu/TpnanCPue5THJxo0U4glxnDk1MWPNPkovpmzYRCjEXzeqQ1om/fm6ryv
 +NxDVJs6eJoMsu/trGaIRzDi1aOnEPeyZ2pnOaJWJdou80WVsyWgyQy051PRZANRc6ksT0/6UO
 bx+d0XL2LmKr81WnfN2Nmc+P
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Dec 2019 10:10:38 -0800
IronPort-SDR: NgCjCnERLlMjJ4CbnGdpGX6OxuBwnkB0ucx5W7J9bR4wTYq58mjvSz9/n59WmCo1OedkkYYi0f
 DXQy/w4KgnWhFw/1BoDQstwSkMHa7+VNAZF4L9EkX8wZlyybzManmOJQAygSXVhuBeMR+liaHj
 snKCO6l3WN3noFznIxiY9cvr2QFheUsy+zzjzMiGdafXh1MW5CDXf9UK55746aDDj92eH1+in9
 8gt8CcfVBNzp10vka4IQrWqZNXanlhJUveNriLoVjdFXzoB+Y7Ue256J6FdIebLxrrJ4Xg8LgG
 xB4=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.158.235])
 by uls-op-cesaip01.wdc.com with ESMTP; 09 Dec 2019 10:16:22 -0800
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v1 00/36]  Add RISC-V Hypervisor Extension v0.5
Date: Mon,  9 Dec 2019 10:10:40 -0800
Message-Id: <cover.1575914822.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 216.71.153.141
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
Cc: alistair.francis@wdc.com, palmer@dabbelt.com, alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch series adds the RISC-V Hypervisor extension v0.5. This is the
latest draft spec of the Hypervisor extension.

The Hypervisor extension is disabled by default, so this series should
result in no changes to anyone using QEMU unless they enable the
extension. The extention can be enabled with the -cpu property (see
below).

Testing of this implementation has been done by using the baremetal
Xvisor Hypervisor. We are able to run two Linux guests (that's all I
have tried) as guests in 64-bit. In 32-bit so far I can only run
baremetal guests, but I think this is a baremetal boot loader issue and
not an issue in QEMU.

The RISC-V KVM implementation was also written using these patches. The
KVM implementation is currently under review.

At the moment this spec is in a draft state and is subject to change. As
QEMU is extreamly useful in early bring up I think it makes sense for
QEMU to support non-frozen extensions.

Thanks to Anup for doing the initial port of Xvisor. The port is avaliable here:
https://github.com/avpatel/xvisor-next and will run on QEMU.

Also thanks to Atish for implementing the SBI call support in Xvisor and
for lots of help debugging.

To run this yourself:
 1. Apply this patch series to QEMU. The latest branch can be found here:
      https://github.com/alistair23/qemu/tree/mainline/alistair/riscv-hyp-ext-v0.5.next
 2. Get the version of OpenSBI that supports the H extension. This can
    be found here:
      https://github.com/avpatel/opensbi/tree/riscv_hyp_ext_0_5_v1
 3. Build the next release of Xvisor. It is available here:
      https://github.com/avpatel/xvisor-next
 4. Make sure you build the Xvisor tests, see here for details:
      https://github.com/avpatel/xvisor-next/tree/master/tests/riscv/virt64/linux
 5. Run QEMU:
     ./riscv64-softmmu/qemu-system-riscv64 -nographic \
       -machine virt -cpu rv64,x-h=true \
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

 This was all tested with the mainline 5.2/5.3 kernels.

There is very early work on a Xen port as well which is avaliable here:
https://github.com/alistair23/xen/tree/alistair/riscv-port

ToDo/Issues
 - Get 32-bit fully working



Alistair Francis (36):
  target/riscv: Convert MIP CSR to target_ulong
  target/riscv: Don't set write permissions on dirty PTEs
  target/riscv: Add the Hypervisor extension
  target/riscv: Add the Hypervisor CSRs to CPUState
  target/riscv: Add support for the new execption numbers
  target/riscv: Rename the H irqs to VS irqs
  target/riscv: Add the virtulisation mode
  target/riscv: Add the force HS exception mode
  target/riscv: Fix CSR perm checking for HS mode
  target/riscv: Print priv and virt in disas log
  target/riscv: Dump Hypervisor registers if enabled
  target/riscv: Add Hypervisor CSR access functions
  target/riscv: Add Hypervisor virtual CSRs accesses
  target/riscv: Add Hypervisor virtual CSRs accesses
  target/riscv: Convert mstatus to pointers
  target/riscv: Add virtual register swapping function
  target/riscv: Set VS bits in mideleg for Hyp extension
  target/riscv: Extend the MIE CSR to support virtulisation
  target/riscv: Extend the SIP CSR to support virtulisation
  target/riscv: Add support for virtual interrupt setting
  target/ricsv: Flush the TLB on virtulisation mode changes
  target/riscv: Generate illegal instruction on WFI when V=1
  target/riscv: Add hypvervisor trap support
  target/riscv: Add Hypervisor trap return support
  target/riscv: Add hfence instructions
  target/riscv: Remove the hret instruction
  target/riscv: Disable guest FP support based on virtual status
  target/riscv: Mark both sstatus and vsstatus as dirty
  target/riscv: Respect MPRV and SPRV for floating point ops
  target/riscv: Allow specifying MMU stage
  target/riscv: Implement second stage MMU
  target/riscv: Raise the new execptions when 2nd stage translation
    fails
  target/riscv: Set htval and mtval2 on execptions
  target/riscv: Add support for the 32-bit MSTATUSH CSR
  target/riscv: Add the MSTATUS_MPV_ISSET helper macro
  target/riscv: Allow enabling the Hypervisor extension

 target/riscv/cpu.c                            |  71 ++-
 target/riscv/cpu.h                            |  58 +-
 target/riscv/cpu_bits.h                       | 111 ++--
 target/riscv/cpu_helper.c                     | 501 +++++++++++++++---
 target/riscv/csr.c                            | 389 +++++++++++++-
 target/riscv/gdbstub.c                        |  11 +-
 target/riscv/insn32.decode                    |  22 +-
 .../riscv/insn_trans/trans_privileged.inc.c   |  45 +-
 target/riscv/op_helper.c                      |  81 ++-
 target/riscv/translate.c                      |  34 ++
 10 files changed, 1161 insertions(+), 162 deletions(-)

-- 
2.24.0


