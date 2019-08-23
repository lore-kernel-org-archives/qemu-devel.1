Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA785C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 23:48:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8FC621848
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 23:48:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="H1A4damP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8FC621848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1JI6-0006Xw-P8
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 19:48:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49261)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=1314b2cac=alistair.francis@wdc.com>)
 id 1i1JBa-0000XG-7N
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 19:41:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=1314b2cac=alistair.francis@wdc.com>)
 id 1i1JBX-0008SR-JZ
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 19:41:36 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:59157)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=1314b2cac=alistair.francis@wdc.com>)
 id 1i1JBW-0008Ru-Sp; Fri, 23 Aug 2019 19:41:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1566603695; x=1598139695;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=GE6cyfiPQ8ij6f/GTVVW73hSQl5FAWm0COq6xqIFylM=;
 b=H1A4damPdQQu3d38oheAT4pn+B5Y4MDnZrWSxGCxMYd9NZ7c+CxkzSc5
 55YMnachQZX1lVqx+pbNGFFu9FpjqlI7f3KXFqQYhx8rOlcDnXTFkJN5s
 01hpKPXHPIHZbo6v5Pyp9CY69rp+AYh7I8PNm7S850+HnVG9jyMLzXLWG
 KdPQb2uIWagzIhRW39T56O/QXyJqmu+5l2HhuaYo7oGTDYIemdE4EBNor
 RmCsFX57Ncr7La+rDhGW/GVBlwJq5rOfyJsk+SW9ZTLn3D5Ep5HSR6KYq
 LjK3a+W2cVczUFzwIgZEwj8xqSXHkEISQKVs43aBvBivm1/JWyGeZGVtr Q==;
IronPort-SDR: hhdpuWe62E4WiGe8O/YOO6SAGZ3XNaHUh5plY8KROon18ngtuIVo04qBGIsrMzhyRxjIlBiLZS
 n1CIVWr/P93suHfMXjXJrPzKHbVmojvya0F8ZkDNHMBkb5XC4DJ2nt6v5xvoMReb0CqQZWsABu
 OAW4QdqndJI45I3JfoD9VZhucSPV8GwaJwzedF0kCWJ1T5sYVxpbYr9LNDNWXcDjd+qvj0kDz8
 /wJ9Thz+oY1oIJZALaJ9E9r4+PwQxD7cuAUqUkn4JMwBToEkNUuL4rLnmgD9DYZK4yA2WfiBr/
 /hU=
X-IronPort-AV: E=Sophos;i="5.64,422,1559491200"; d="scan'208";a="121144248"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 24 Aug 2019 07:41:30 +0800
IronPort-SDR: eGi3qoIlxSUuui4tvnBX+oaJZClz0V7fiD3eEmpWJj7j20NakWThEIuh8xl6wlBc0oNgCz6b3d
 zjZK3MLKi7Ps7oQZe6Az2v1FcoQqm9s7exz+3TVWkfvUVJq9HwtnbWEAaxfdOF6Io1s9VAZBSt
 pGYSj0uyrycSnyjXRgVQo5MeO0AOZy/j9HcBwGgABoEEz0KFEg5Jo2rEYOGGuAvkPVuiseSRk7
 JL7SB3gZC1UQg21Z4I6R6pyMzfLKLqesWfKVuIzw30I/XYSLMx9u3NaJXMs+c//JgDx7QAIBOt
 hKU33X0g63Lge3/Pm4xKcwoN
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Aug 2019 16:38:47 -0700
IronPort-SDR: O2qbGz7oUXVRSsP/ZbUlhjydkAC/7CWERQlCF2Okuhjo0bIDDN5CvDLaJe9LQZF1Q7iNUnjNPo
 Z/Og+B/kdts6+Y3LCOv7tqbpQbBt2jhI0t6yjdXIMPzQHoibLIdrBreFi1ijkEHyTSMeNbJz4S
 rC5l2bhdENGFiuJY9ZLTmGZi+ETewwqQVClvxyDJAJr66hwPPCE/1tyxcx2/gk6XOz52putFFB
 UxJ2hkMPq3eVI5A0D0zrYH1xKX7EyWe3IPQWSUh4LO448zzlXmBa86qU1zIj7flgUhumFMYZtf
 q3s=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.58])
 by uls-op-cesaip01.wdc.com with ESMTP; 23 Aug 2019 16:41:30 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Date: Fri, 23 Aug 2019 16:37:49 -0700
Message-Id: <cover.1566603412.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 216.71.153.141
Subject: [Qemu-devel] [PATCH v1 00/28] Add RISC-V Hypervisor Extension v0.4
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
Cc: alistair23@gmail.com, Anup.Patel@wdc.com, palmer@sifive.com,
 alistair.francis@wdc.com, Atish.Patra@wdc.com
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
       -machine virt -cpu rv64,x-h=true\
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
 - Fix KVM SMP race condition

Based-on: cover.1566573576.git.alistair.francis@wdc.com



Alistair Francis (28):
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
  target/riscv: Add background register swapping function
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
  target/riscv: Allow specifying number of MMU stages
  target/riscv: Implement second stage MMU
  target/riscv: Call the second stage MMU in virtualisation mode
  target/riscv: Add support for the 32-bit MSTATUSH CSR
  target/riscv: Add the MSTATUS_MPV_ISSET helper macro
  target/riscv: Allow enabling the Hypervisor extension

 hw/riscv/sifive_plic.c                        |  12 +-
 target/riscv/cpu.c                            |  61 ++-
 target/riscv/cpu.h                            |  68 ++-
 target/riscv/cpu_bits.h                       |  48 +-
 target/riscv/cpu_helper.c                     | 485 ++++++++++++++++--
 target/riscv/csr.c                            | 252 ++++++++-
 target/riscv/insn32.decode                    |  23 +-
 .../riscv/insn_trans/trans_privileged.inc.c   |  40 ++
 target/riscv/op_helper.c                      |  81 ++-
 target/riscv/translate.c                      |  34 ++
 10 files changed, 998 insertions(+), 106 deletions(-)

-- 
2.22.0


