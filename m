Return-Path: <SRS0=9/5m=53=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9A3FC2BA19
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Apr 2020 04:17:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 743742078E
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Apr 2020 04:17:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 743742078E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48544 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jN7aM-0001mh-KL
	for qemu-devel@archiver.kernel.org; Sat, 11 Apr 2020 00:17:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47050)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jiangyifei@huawei.com>) id 1jN7ZV-0000BM-DK
 for qemu-devel@nongnu.org; Sat, 11 Apr 2020 00:16:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jiangyifei@huawei.com>) id 1jN7ZU-0006MJ-1B
 for qemu-devel@nongnu.org; Sat, 11 Apr 2020 00:16:45 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3742 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jiangyifei@huawei.com>)
 id 1jN7ZT-0006L9-Mg; Sat, 11 Apr 2020 00:16:43 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 793E4BC62795A0C63134;
 Sat, 11 Apr 2020 12:16:40 +0800 (CST)
Received: from huawei.com (10.173.222.107) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.487.0; Sat, 11 Apr 2020
 12:16:32 +0800
From: Yifei Jiang <jiangyifei@huawei.com>
To: <qemu-devel@nongnu.org>, <qemu-riscv@nongnu.org>
Subject: [PATCH RFC v2 0/9] Add riscv kvm accel support
Date: Sat, 11 Apr 2020 12:14:18 +0800
Message-ID: <20200411041427.14828-1-jiangyifei@huawei.com>
X-Mailer: git-send-email 2.14.1.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Originating-IP: [10.173.222.107]
X-CFilter-Loop: Reflected
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.191
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
Cc: victor.zhangxiaofeng@huawei.com, zhang.zhanghailiang@huawei.com,
 sagark@eecs.berkeley.edu, yinyipeng1@huawei.com,
 kbastian@mail.uni-paderborn.de, anup.patel@wdc.com, Alistair.Francis@wdc.com,
 kvm-riscv@lists.infradead.org, palmer@dabbelt.com,
 Yifei Jiang <jiangyifei@huawei.com>, dengkai1@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series adds both riscv32 and riscv64 kvm support, It is based on
riscv_kvm_master branch at https://github.com/kvm-riscv/linux.

This series depends on above pending changes which haven't yet been
accepted, so this QEMU patch series is blocked until that dependency
has been dealt with, but is worth reviewing anyway.

Several steps to use this:
1. Build emulation
$ ./configure --target-list=3Driscv64-softmmu
$ make -j$(nproc)

2. Build kernel
riscv_kvm_master branch at https://github.com/kvm-riscv/linux

3. Build QEMU VM
I cross built in riscv toolchain.
$ PKG_CONFIG_LIBDIR=3D<toolchain pkgconfig path>
$ export PKG_CONFIG_SYSROOT_DIR=3D<toolchain sysroot path>
$ ./configure --target-list=3Driscv64-softmmu --enable-kvm \
--cross-prefix=3Driscv64-linux-gnu- --disable-libiscsi --disable-glusterf=
s \
--disable-libusb --disable-usb-redir --audio-drv-list=3D --disable-opengl=
 \
--disable-libxml2
$ make -j$(nproc)

4. Start emulation
$ ./qemu-system-riscv64 -M virt -m 4096M -cpu rv64,x-h=3Dtrue -nographic =
\
        -name guest=3Driscv-hyp,debug-threads=3Don \
        -smp 4 \
        -kernel ./fw_jump.elf \
        -device loader,file=3D./Image,addr=3D0x80200000 \
        -drive file=3D./hyp.img,format=3Draw,id=3Dhd0 \
        -device virtio-blk-device,drive=3Dhd0 \
        -append "root=3D/dev/vda rw console=3DttyS0 earlycon=3Dsbi"

5. Start kvm-acceled QEMU VM in emulation
$ ./qemu-system-riscv64 -M virt,accel=3Dkvm -m 1024M -cpu host -nographic=
 \
        -name guest=3Driscv-guset \
         -smp 2 \
        -kernel ./Image \
        -drive file=3D./guest.img,format=3Draw,id=3Dhd0 \
        -device virtio-blk-device,drive=3Dhd0 \
        -append "root=3D/dev/vda rw console=3DttyS0 earlycon=3Dsbi"

Changes since RFC v1
1=E3=80=81Add separate SBI ecall interface header.
2=E3=80=81Add riscv32 kvm accel support.

Yifei Jiang (9):
  linux-header: Update linux/kvm.h
  target/riscv: Add target/riscv/kvm.c to place the public kvm interface
  target/riscv: Implement function kvm_arch_init_vcpu
  target/riscv: Implement kvm_arch_get_registers
  target/riscv: Implement kvm_arch_put_registers
  target/riscv: Support start kernel directly by KVM
  hw/riscv: PLIC update external interrupt by KVM when kvm enabled
  target/riscv: Handler KVM_EXIT_RISCV_SBI exit
  target/riscv: add host cpu type

 configure                          |   1 +
 hw/riscv/sifive_plic.c             |  31 +-
 hw/riscv/virt.c                    |  16 +-
 linux-headers/linux/kvm.h          |   8 +
 target/riscv/Makefile.objs         |   1 +
 target/riscv/cpu.c                 |  10 +
 target/riscv/cpu.h                 |   4 +
 target/riscv/kvm.c                 | 501 +++++++++++++++++++++++++++++
 target/riscv/kvm_riscv.h           |  25 ++
 target/riscv/sbi_ecall_interface.h |  72 +++++
 10 files changed, 657 insertions(+), 12 deletions(-)
 create mode 100644 target/riscv/kvm.c
 create mode 100644 target/riscv/kvm_riscv.h
 create mode 100644 target/riscv/sbi_ecall_interface.h

--=20
2.19.1



