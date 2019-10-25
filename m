Return-Path: <SRS0=l02z=YT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FC89CA9EA0
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 00:38:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13DD9205ED
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 00:38:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="AUR7iKrg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13DD9205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iOA62-0000a3-96
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 20:38:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49416)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=194c68654=alistair.francis@wdc.com>)
 id 1iO902-00045k-Px
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 19:28:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=194c68654=alistair.francis@wdc.com>)
 id 1iO900-0003rl-NR
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 19:28:06 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:10389)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=194c68654=alistair.francis@wdc.com>)
 id 1iO900-0003r5-F8; Fri, 25 Oct 2019 19:28:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1572046084; x=1603582084;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=41zeTDbMQl1S5vK2k2iJfTuCR/ToqwyzJWCA9Vw+0P8=;
 b=AUR7iKrgYHQBaK/bbvnaLyc5Bc6AcFXyK5MMksD+/nQ8cbxya59lwZiD
 gDp3fnJt6RMEq3GhuJnR6u/Xt7FffOJZDVp/JTOhOvjfkyhKECI2g96yA
 JMQgG8girCmBuaKGmLCTfRp1jbf08GaeL/6FHYfSLo821L5gj3im0WWvK
 0CtvQHgCY5wXJuq9syTY4KfxrnEKcvMHlDxAx4H8y6zSuHbjA1ZZf5heB
 f+arEA8GS4VNkjAPlHBKLzQrRqegBJ75+QLUGufr+80eI/1UkxVZ7ia55
 V1R5ve7dxDQhtVsbViFATreSV1yvfRuYu8eJ3FDLuxKE3AyM/4vSL3xCI g==;
IronPort-SDR: D2nr/BOPwf3h7W0Rwqc/3b/K9RAQFN2M1vU1WpAnWYh0dy0W6naOPvShqPB4Xt8u+xNxHY5rg6
 kW310pQJPzWjxUJZxU26bqs0ZxnxPXCV4zCuz4TpZCBk9663R/1CZOh+0e7xzQfaVdGr42qVQW
 ztPL30BHanEil11ua75Yh36+uMybEex8+voRsbMriSnpeN3xcpNHXeasibSusOAMcu9L8JNxaR
 uNr3C8FDddXEub7/WE3iEPuQ9BVzHX8tX8rYIElB2T5kKaXKz2o7ET6tp7JjAqcs1qbjpzX1xS
 1XE=
X-IronPort-AV: E=Sophos;i="5.68,230,1569254400"; d="scan'208";a="228520349"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 26 Oct 2019 07:28:01 +0800
IronPort-SDR: DhiC2rE16RWoXozisbz0QxZc2dBVyMVSOZEN9e442iHWKNeoQq29nLJaEvMrK0YsnujzBGl9W5
 kqFQPelFrqD1biV+I9vHD5lZABft+KzdRMSWLnNzS0tbR+eM+yXqLKmcRu/yu/URb+xAdBWsgc
 6ycBhqX5t95EwYrnfvJGPunY8cLF1p9gcbx4DBmCG9nYVltJ96pzlnTSaloiHvn9m2uZb4TAh0
 4tyaEVI4+s8GBkGikjbUmwZOrK3op8TbBUCw11Zat0v6RS/Icdm9KXwk0K2mwRsFrHOQ3NscYD
 dnqY70JcxXANZnx2MnKj4M3K
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Oct 2019 16:23:27 -0700
IronPort-SDR: 4tCbvVmhDNCsRugLcgi228z+JvFg7ZY9QJC7QfPq35VHWepgOpl3Nao0mSWXwNSQ96YbN/4PMu
 WkzV7R0SrVAT0f7m/qgPSmitcC1R7UYrxG6yD0vsYk3dopl/d+TfPD8e4gOX9a8tEu1xsqqwuG
 1+lJua2yXSkzrhuH48ub0Ul8orPbl211A7Y5e1ux2SJ7m18pKzvDLhUWuZ9lCa8aw3JOgulPMW
 dPVhr0eXXxhXsciUDG8NzXjUO45gknMeOwAspjg6huhoJlyZw00T5RpOZR50Fp682Gr5Cnaw4m
 iAY=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.58])
 by uls-op-cesaip02.wdc.com with ESMTP; 25 Oct 2019 16:28:02 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v2 00/27]  Add RISC-V Hypervisor Extension v0.4
Date: Fri, 25 Oct 2019 16:23:06 -0700
Message-Id: <cover.1572045716.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 68.232.141.245
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


This patch series adds the RISC-V Hypervisor extension v0.4. This is the
latest draft spec of the Hypervisor extension.

The Hypervisor extension is disabled by default, so this series should
result in no changes to anyone using QEMU unless they enable the
extension. The extention can be enabled with the -cpu property (see
below).

At the moment the spec does not include information about the mstatush
register. Although this information has since been merged into the
master spec. As it is only adding support for 32-bit I have added this
register to this series.

Testing of this implementation has been done by using the baremetal
Xvisor Hypervisor. We are able to run two Linux guests (that's all I
have tried) as guests in 64-bit. In 32-bit so far I can only run
baremetal guests, but I think this is a baremetal boot loader issue and
not an issue in QEMU.

The RISC-V KVM implementation was also written using these patches. The
KVM implementation is currently under review.

These patches result in a reproducable race when booting a SMP Linux
guest inside a SMP Linux KVM host. This will need to be fixed.

At the moment this spec is in a draft state and is subject to change. As
QEMU is extreamly useful in early bring up I think it makes sense for
QEMU to support non-frozen extensions.

Thanks to Anup for doing the initial port of Xvisor. The port is avaliable here:
https://github.com/avpatel/xvisor-next and will run on QEMU.

Also thanks to Atish for implementing the SBI call support in Xvisor and
for lots of help debugging.

To run this yourself:
 1. Apply this patch series to QEMU. The latest branch can be found here:
      https://github.com/alistair23/qemu/tree/mainline/alistair/riscv-hyp-ext-v0.4.next
 2. Get the version of OpenSBI that supports the H extension. This can
    be found here:
      https://github.com/riscv/opensbi/tree/hyp_ext_changes_v1
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

This series is based on Palmers for-master branch:
https://github.com/palmer-dabbelt/qemu/commits/for-master

v2:
 - Rebase on for-master
 - Consolidate patches requested by Palmer
 - Other updates based on feedback


Alistair Francis (27):
  target/riscv: Don't set write permissions on dirty PTEs
  target/riscv: Add the Hypervisor extension
  target/riscv: Add the virtulisation mode
  target/riscv: Add the force HS exception mode
  target/riscv: Fix CSR perm checking for HS mode
  target/riscv: Add the Hypervisor CSRs to CPUState
  target/riscv: Print priv and virt in disas log
  target/riscv: Dump Hypervisor registers if enabled
  target/riscv: Add Hypervisor CSR access functions
  target/riscv: Add Hypervisor virtual CSRs accesses
  target/riscv: Convert mie and mstatus to pointers
  target/riscv: Add virtual register swapping function
  target/riscv: Add support for virtual interrupt setting
  target/ricsv: Flush the TLB on virtulisation mode changes
  target/riscv: Generate illegal instruction on WFI when V=1
  riscv: plic: Always set sip.SEIP bit for HS
  target/riscv: Add hypvervisor trap support
  target/riscv: Add Hypervisor trap return support
  target/riscv: Add hfence instructions
  target/riscv: Disable guest FP support based on virtual status
  target/riscv: Mark both sstatus and vsstatus as dirty
  target/riscv: Respect MPRV and SPRV for floating point ops
  target/riscv: Allow specifying MMU stage
  target/riscv: Implement second stage MMU
  target/riscv: Add support for the 32-bit MSTATUSH CSR
  target/riscv: Add the MSTATUS_MPV_ISSET helper macro
  target/riscv: Allow enabling the Hypervisor extension

 hw/riscv/sifive_plic.c                        |  12 +-
 target/riscv/cpu.c                            |  61 ++-
 target/riscv/cpu.h                            |  55 +-
 target/riscv/cpu_bits.h                       |  45 +-
 target/riscv/cpu_helper.c                     | 481 ++++++++++++++++--
 target/riscv/csr.c                            | 262 +++++++++-
 target/riscv/insn32.decode                    |  23 +-
 .../riscv/insn_trans/trans_privileged.inc.c   |  40 ++
 target/riscv/op_helper.c                      |  81 ++-
 target/riscv/translate.c                      |  34 ++
 10 files changed, 988 insertions(+), 106 deletions(-)

-- 
2.23.0


