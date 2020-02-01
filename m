Return-Path: <SRS0=CCzH=3V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDFD2C33CB7
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 01:09:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC8272063A
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 01:09:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="WkNKSfnH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC8272063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixhHs-0002Jp-Kq
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 20:09:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56442)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=2939926b3=alistair.francis@wdc.com>)
 id 1ixhGk-0000X4-UM
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 20:08:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=2939926b3=alistair.francis@wdc.com>)
 id 1ixhGj-00066E-33
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 20:08:18 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:17110)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=2939926b3=alistair.francis@wdc.com>)
 id 1ixhGi-00065K-Cv; Fri, 31 Jan 2020 20:08:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1580519296; x=1612055296;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=qUCuC7wQUFdeApledGSLdeCb96ovq8URU4ip0n2Pe6A=;
 b=WkNKSfnHFzwYcslgZkYXeEmUeE7gf5IeP3TLFMHCEgGoPz7/OWwcIQq8
 HrkF5Oiqql4VhTxJ915LWEuDIninfXejcjgoQeyDiL6g0nRm285rxtFgS
 +cflrQapX7wmlAf+WDV/fq78oMSYzJP+k8NUT7YJ4sGGE9bTXL4LFq3Fw
 5rBbopzvroKhfiVjMrac8J8l4u0K2n/+LfdqDLsyzxBaiDlJUYhdTVAmD
 MPIsHn2HfV0pAa5mTJEwwZuZTDqpC2Ld3j1pVb6BSK6kV79G3YG8hXC7+
 IMT5av2r+KG1un5H+CdNiUCQF74gP+LgdQYYltCYqrdt7nsFHOLbBdR5q w==;
IronPort-SDR: MehpDc4OF0T0NzI0qzcp3YRZfKzHb9+ixVUeiGWoc9f2u/z3qjw1pkwfwbwPqiG6ubX8e1EFYv
 Lrmp2tAZXJbEbV8JIVEJCu4pBodcWKsOI4OitbthfN1+LX0JtPoNf/EypitvKZp92CN2pxrrNN
 GjR5pFzo+b8/dHzhR+WQQx3wSmUSu5HxKUWD35Q42c9JG2Gv3RBwfBF+f5yXpkayj+1L4tVvrE
 3ewErSPV0uU3b2hEX6NVofvazdc+Ql8/e4f0FK3DpyR9vLCXpvOQ00QLdV8jNaDBC13DT5FeuC
 jlc=
X-IronPort-AV: E=Sophos;i="5.70,388,1574092800"; d="scan'208";a="128872395"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 01 Feb 2020 09:08:12 +0800
IronPort-SDR: vTSOtbyVnXP93AcCschsytAhDSrQz2MK0T7crTPLemKSOmmW1b8Q/ZoVkXUR29AA3fExnMmJOc
 jmdiOBJd0Yy3C/gC/MHn/H+YBZcBjJ9Kkqe5nk02i6YxcJmL/4RyD8aZoFnWk9LK/Iwk/b/95+
 W7LMh70V+Pa/YaGSWSxnxaZElVphRIXXIDv+MRMFZlsxbWvE/8gsCbL3HGlsjrYjWauEpRSsWF
 d3ctYbF2hINa6f8p3PWTreN8zy9xKT6SnSPUDbEWqkqYbOFa0KCyPmV0A1cL/sRv+6izv8Opc7
 ID5X6XwRhHh1omYvryGDPqv+
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jan 2020 17:01:21 -0800
IronPort-SDR: tNMk7ya5DtPRGDEg33IB2I7SgTQvRcAKLd340VDDwTu8ZNohNTFOCHxdE8fQsFHdNvZScI3bYG
 a1aOBzpsM8xqX6D6CAc3wUVbMd5hYd1i7TUV0YAd5jFmcCE2QwqR8aX4mOERE1Fv7egsrqHr5V
 ebVuN4ftCGcMR4BQAKPatNlZrwNiGX5PNHcRVETPHabZDjGz8q6ipq7P8DodO1AN3hJi9ukh9/
 Ukfwr1nSYSsGc+10zJnZQG9/Vockdkow5tH7Kg1/3MqQy6ex43aj0+DcTbQzS6ZTlNd9uhETNy
 Yww=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.158.235])
 by uls-op-cesaip01.wdc.com with ESMTP; 31 Jan 2020 17:08:12 -0800
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v2 00/35]  Add RISC-V Hypervisor Extension v0.5
Date: Fri, 31 Jan 2020 17:01:35 -0800
Message-Id: <cover.1580518859.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 216.71.154.42
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

v2:
 - Don't use riscv_cpu_set_force_hs_excep() for 2nd stage MMU fauls as
   the v0.5 spec has a specific fault
 - Address review comments
 - Rebase on master
 - Remove pointers for mstatus

Alistair Francis (35):
  target/riscv: Convert MIP CSR to target_ulong
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
  target/riscv: Add Hypervisor machine CSRs accesses
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
  target/riscv: Only set TB flags with FP status if enabled
  target/riscv: Disable guest FP support based on virtual status
  target/riscv: Mark both sstatus and msstatus_hs as dirty
  target/riscv: Respect MPRV and SPRV for floating point ops
  target/riscv: Allow specifying MMU stage
  target/riscv: Implement second stage MMU
  target/riscv: Raise the new execptions when 2nd stage translation
    fails
  target/riscv: Set htval and mtval2 on execptions
  target/riscv: Add support for the 32-bit MSTATUSH CSR
  target/riscv: Add the MSTATUS_MPV_ISSET helper macro
  target/riscv: Allow enabling the Hypervisor extension

 target/riscv/cpu.c                            |  57 ++-
 target/riscv/cpu.h                            |  58 ++-
 target/riscv/cpu_bits.h                       | 111 ++--
 target/riscv/cpu_helper.c                     | 481 ++++++++++++++++--
 target/riscv/csr.c                            | 369 +++++++++++++-
 target/riscv/gdbstub.c                        |  11 +-
 target/riscv/insn32.decode                    |  22 +-
 .../riscv/insn_trans/trans_privileged.inc.c   |  45 +-
 target/riscv/op_helper.c                      |  71 ++-
 target/riscv/translate.c                      |  34 ++
 10 files changed, 1130 insertions(+), 129 deletions(-)

-- 
2.25.0


