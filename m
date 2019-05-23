Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42242C04AAC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 08:30:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9996A20862
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 08:30:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9996A20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59771 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTj7X-0006XM-PO
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 04:30:39 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47554)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hTj2S-0002Bo-KJ
	for qemu-devel@nongnu.org; Thu, 23 May 2019 04:25:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hTitB-0000vU-T1
	for qemu-devel@nongnu.org; Thu, 23 May 2019 04:16:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59422)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hTitA-0000ua-OD
	for qemu-devel@nongnu.org; Thu, 23 May 2019 04:15:49 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EA124309B153;
	Thu, 23 May 2019 08:15:42 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-28.ams2.redhat.com
	[10.36.116.28])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id D74D067667;
	Thu, 23 May 2019 08:15:41 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id F04C21132B3B; Thu, 23 May 2019 10:15:38 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 23 May 2019 10:15:37 +0200
Message-Id: <20190523081538.2291-7-armbru@redhat.com>
In-Reply-To: <20190523081538.2291-1-armbru@redhat.com>
References: <20190523081538.2291-1-armbru@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.49]);
	Thu, 23 May 2019 08:15:42 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [RFC v4 6/7] tests: Don't limit check-headers to
 include/
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
Cc: peter.maydell@linaro.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 accel/tcg/atomic_template.h                | 3 +++
 accel/tcg/tcg-runtime.h                    | 3 +++
 accel/tcg/translate-all.h                  | 4 ++++
 audio/audio_int.h                          | 2 ++
 audio/audio_template.h                     | 2 ++
 audio/audio_win_int.h                      | 2 ++
 audio/dsound_template.h                    | 3 +++
 audio/mixeng_template.h                    | 2 ++
 audio/rate_template.h                      | 2 ++
 block/crypto.h                             | 2 ++
 block/qcow2.h                              | 2 ++
 block/vhdx.h                               | 2 ++
 bsd-user/i386/target_signal.h              | 3 +++
 bsd-user/i386/target_syscall.h             | 2 ++
 bsd-user/qemu.h                            | 4 ++++
 bsd-user/sparc/target_signal.h             | 3 +++
 bsd-user/sparc/target_syscall.h            | 2 ++
 bsd-user/sparc64/target_signal.h           | 3 +++
 bsd-user/sparc64/target_syscall.h          | 2 ++
 bsd-user/syscall_defs.h                    | 2 ++
 bsd-user/x86_64/target_signal.h            | 3 +++
 bsd-user/x86_64/target_syscall.h           | 2 ++
 contrib/ivshmem-client/ivshmem-client.h    | 2 ++
 contrib/ivshmem-server/ivshmem-server.h    | 2 ++
 contrib/libvhost-user/libvhost-user-glib.h | 2 ++
 contrib/libvhost-user/libvhost-user.h      | 2 ++
 contrib/rdmacm-mux/rdmacm-mux.h            | 2 ++
 crypto/afalgpriv.h                         | 2 ++
 crypto/cipherpriv.h                        | 2 ++
 crypto/hashpriv.h                          | 2 ++
 crypto/hmacpriv.h                          | 2 ++
 disas/nanomips.h                           | 2 ++
 fpu/softfloat-specialize.h                 | 3 +++
 fsdev/file-op-9p.h                         | 2 ++
 fsdev/qemu-fsdev.h                         | 3 +++
 hw/9pfs/9p-local.h                         | 2 ++
 hw/9pfs/9p-proxy.h                         | 2 ++
 hw/9pfs/9p-synth.h                         | 2 ++
 hw/9pfs/9p-util.h                          | 2 ++
 hw/9pfs/9p-xattr.h                         | 2 ++
 hw/9pfs/9p.h                               | 2 ++
 hw/9pfs/coth.h                             | 2 ++
 hw/9pfs/virtio-9p.h                        | 2 ++
 hw/9pfs/xen-9pfs.h                         | 3 ++-
 hw/arm/smmu-internal.h                     | 2 ++
 hw/arm/smmuv3-internal.h                   | 2 ++
 hw/audio/hda-codec-common.h                | 3 ++-
 hw/audio/lm4549.h                          | 2 ++
 hw/block/dataplane/xen-block.h             | 2 ++
 hw/block/nvme.h                            | 2 ++
 hw/block/xen_blkif.h                       | 2 ++
 hw/cris/boot.h                             | 2 ++
 hw/display/ati_int.h                       | 2 ++
 hw/display/cirrus_vga_internal.h           | 2 ++
 hw/display/cirrus_vga_rop.h                | 2 ++
 hw/display/cirrus_vga_rop2.h               | 2 ++
 hw/display/framebuffer.h                   | 2 ++
 hw/display/milkymist-vgafb_template.h      | 3 ++-
 hw/display/omap_lcd_template.h             | 3 +++
 hw/display/pl110_template.h                | 2 ++
 hw/display/pxa2xx_template.h               | 2 ++
 hw/display/qxl.h                           | 4 ++++
 hw/display/sm501_template.h                | 2 ++
 hw/display/tc6393xb_template.h             | 2 ++
 hw/display/vga-helpers.h                   | 2 ++
 hw/display/vga_int.h                       | 2 ++
 hw/ide/ahci_internal.h                     | 2 ++
 hw/input/adb-internal.h                    | 2 ++
 hw/lm32/lm32.h                             | 2 ++
 hw/lm32/lm32_hwsetup.h                     | 3 +++
 hw/lm32/milkymist-hw.h                     | 2 ++
 hw/microblaze/boot.h                       | 2 ++
 hw/net/can/can_sja1000.h                   | 3 +++
 hw/net/e1000e_core.h                       | 2 ++
 hw/net/e1000x_common.h                     | 2 ++
 hw/net/pcnet.h                             | 2 ++
 hw/net/rocker/rocker_desc.h                | 2 ++
 hw/net/rocker/rocker_fp.h                  | 2 ++
 hw/net/rocker/rocker_of_dpa.h              | 2 ++
 hw/net/rocker/rocker_tlv.h                 | 2 ++
 hw/net/rocker/rocker_world.h               | 2 ++
 hw/net/vmware_utils.h                      | 2 ++
 hw/net/vmxnet3_defs.h                      | 3 ++-
 hw/nios2/boot.h                            | 3 +++
 hw/ppc/ppc405.h                            | 2 ++
 hw/ppc/ppc440.h                            | 2 ++
 hw/rdma/rdma_backend.h                     | 2 ++
 hw/rdma/rdma_backend_defs.h                | 2 ++
 hw/rdma/rdma_rm.h                          | 2 ++
 hw/rdma/rdma_rm_defs.h                     | 2 ++
 hw/rdma/vmw/pvrdma.h                       | 2 ++
 hw/rdma/vmw/pvrdma_dev_ring.h              | 2 ++
 hw/rdma/vmw/pvrdma_qp_ops.h                | 2 ++
 hw/s390x/ccw-device.h                      | 3 +++
 hw/s390x/ipl.h                             | 3 +++
 hw/s390x/s390-pci-bus.h                    | 3 +++
 hw/s390x/s390-pci-inst.h                   | 3 +++
 hw/s390x/s390-virtio-hcall.h               | 2 ++
 hw/s390x/virtio-ccw.h                      | 3 +++
 hw/scsi/mptsas.h                           | 2 ++
 hw/scsi/viosrp.h                           | 3 +++
 hw/sd/sdhci-internal.h                     | 3 +++
 hw/timer/m48t59-internal.h                 | 2 ++
 hw/tpm/tpm_ioctl.h                         | 2 ++
 hw/usb/desc.h                              | 2 ++
 hw/usb/hcd-ohci.h                          | 2 ++
 hw/usb/hcd-xhci.h                          | 2 ++
 hw/usb/quirks.h                            | 2 ++
 hw/vfio/pci.h                              | 3 +++
 hw/xen/xen_pt.h                            | 2 ++
 hw/xtensa/bootparam.h                      | 2 ++
 hw/xtensa/xtensa_memory.h                  | 3 +++
 linux-user/aarch64/target_cpu.h            | 3 +++
 linux-user/aarch64/target_fcntl.h          | 3 +++
 linux-user/aarch64/target_signal.h         | 2 ++
 linux-user/aarch64/target_structs.h        | 3 +++
 linux-user/aarch64/target_syscall.h        | 3 +++
 linux-user/aarch64/termbits.h              | 2 ++
 linux-user/alpha/target_cpu.h              | 3 +++
 linux-user/alpha/target_fcntl.h            | 3 +++
 linux-user/alpha/target_signal.h           | 2 ++
 linux-user/alpha/target_structs.h          | 3 +++
 linux-user/alpha/target_syscall.h          | 2 ++
 linux-user/alpha/termbits.h                | 2 ++
 linux-user/arm/nwfpe/fpa11.h               | 3 +++
 linux-user/arm/nwfpe/fpopcode.h            | 2 ++
 linux-user/arm/target_cpu.h                | 3 +++
 linux-user/arm/target_fcntl.h              | 3 +++
 linux-user/arm/target_signal.h             | 2 ++
 linux-user/arm/target_structs.h            | 3 +++
 linux-user/arm/target_syscall.h            | 3 +++
 linux-user/arm/termbits.h                  | 2 ++
 linux-user/cpu_loop-common.h               | 3 +++
 linux-user/cris/target_cpu.h               | 3 +++
 linux-user/cris/target_fcntl.h             | 3 +++
 linux-user/cris/target_signal.h            | 2 ++
 linux-user/cris/target_structs.h           | 3 +++
 linux-user/cris/termbits.h                 | 2 ++
 linux-user/fd-trans.h                      | 2 ++
 linux-user/flat.h                          | 2 ++
 linux-user/generic/fcntl.h                 | 3 +++
 linux-user/host/aarch64/hostdep.h          | 2 ++
 linux-user/host/arm/hostdep.h              | 2 ++
 linux-user/host/i386/hostdep.h             | 2 ++
 linux-user/host/ppc64/hostdep.h            | 2 ++
 linux-user/host/riscv64/hostdep.h          | 2 ++
 linux-user/host/s390x/hostdep.h            | 2 ++
 linux-user/host/x86_64/hostdep.h           | 2 ++
 linux-user/hppa/target_cpu.h               | 3 +++
 linux-user/hppa/target_fcntl.h             | 3 +++
 linux-user/hppa/target_signal.h            | 2 ++
 linux-user/hppa/target_structs.h           | 3 +++
 linux-user/hppa/target_syscall.h           | 2 ++
 linux-user/hppa/termbits.h                 | 2 ++
 linux-user/i386/target_cpu.h               | 3 +++
 linux-user/i386/target_fcntl.h             | 3 +++
 linux-user/i386/target_signal.h            | 2 ++
 linux-user/i386/target_structs.h           | 3 +++
 linux-user/i386/target_syscall.h           | 2 ++
 linux-user/i386/termbits.h                 | 2 ++
 linux-user/ioctls.h                        | 2 ++
 linux-user/linux_loop.h                    | 2 ++
 linux-user/m68k/target_cpu.h               | 2 ++
 linux-user/m68k/target_elf.h               | 2 ++
 linux-user/m68k/target_fcntl.h             | 3 +++
 linux-user/m68k/target_signal.h            | 2 ++
 linux-user/m68k/target_structs.h           | 3 +++
 linux-user/m68k/target_syscall.h           | 2 ++
 linux-user/m68k/termbits.h                 | 2 ++
 linux-user/microblaze/target_cpu.h         | 3 +++
 linux-user/microblaze/target_fcntl.h       | 3 +++
 linux-user/microblaze/target_signal.h      | 2 ++
 linux-user/microblaze/target_structs.h     | 3 +++
 linux-user/microblaze/termbits.h           | 2 ++
 linux-user/mips/target_cpu.h               | 3 +++
 linux-user/mips/target_elf.h               | 2 ++
 linux-user/mips/target_fcntl.h             | 3 +++
 linux-user/mips/target_signal.h            | 3 +++
 linux-user/mips/target_structs.h           | 3 +++
 linux-user/mips/target_syscall.h           | 2 ++
 linux-user/mips/termbits.h                 | 2 ++
 linux-user/mips64/syscall_nr.h             | 2 ++
 linux-user/mips64/target_cpu.h             | 3 +++
 linux-user/mips64/target_elf.h             | 2 ++
 linux-user/mips64/target_fcntl.h           | 3 +++
 linux-user/mips64/target_signal.h          | 2 ++
 linux-user/mips64/target_structs.h         | 2 ++
 linux-user/mips64/target_syscall.h         | 2 ++
 linux-user/mips64/termbits.h               | 2 ++
 linux-user/nios2/target_cpu.h              | 2 ++
 linux-user/nios2/target_fcntl.h            | 3 +++
 linux-user/nios2/target_signal.h           | 2 ++
 linux-user/nios2/target_structs.h          | 3 +++
 linux-user/nios2/termbits.h                | 2 ++
 linux-user/openrisc/target_cpu.h           | 2 ++
 linux-user/openrisc/target_fcntl.h         | 3 +++
 linux-user/openrisc/target_signal.h        | 2 ++
 linux-user/openrisc/target_structs.h       | 3 +++
 linux-user/openrisc/target_syscall.h       | 3 +++
 linux-user/openrisc/termbits.h             | 2 ++
 linux-user/ppc/syscall_nr.h                | 3 +++
 linux-user/ppc/target_cpu.h                | 4 ++++
 linux-user/ppc/target_elf.h                | 2 ++
 linux-user/ppc/target_fcntl.h              | 3 +++
 linux-user/ppc/target_signal.h             | 3 +++
 linux-user/ppc/target_structs.h            | 3 +++
 linux-user/ppc/target_syscall.h            | 3 +++
 linux-user/ppc/termbits.h                  | 2 ++
 linux-user/qemu.h                          | 2 ++
 linux-user/riscv/target_cpu.h              | 2 ++
 linux-user/riscv/target_fcntl.h            | 3 +++
 linux-user/riscv/target_signal.h           | 2 ++
 linux-user/riscv/target_structs.h          | 3 +++
 linux-user/riscv/target_syscall.h          | 2 ++
 linux-user/riscv/termbits.h                | 2 ++
 linux-user/s390x/syscall_nr.h              | 2 ++
 linux-user/s390x/target_cpu.h              | 3 +++
 linux-user/s390x/target_fcntl.h            | 3 +++
 linux-user/s390x/target_signal.h           | 2 ++
 linux-user/s390x/target_structs.h          | 3 +++
 linux-user/s390x/target_syscall.h          | 2 ++
 linux-user/s390x/termbits.h                | 2 ++
 linux-user/sh4/target_cpu.h                | 3 +++
 linux-user/sh4/target_fcntl.h              | 3 +++
 linux-user/sh4/target_signal.h             | 2 ++
 linux-user/sh4/target_structs.h            | 3 +++
 linux-user/sh4/target_syscall.h            | 2 ++
 linux-user/sh4/termbits.h                  | 2 ++
 linux-user/signal-common.h                 | 3 +++
 linux-user/socket.h                        | 2 ++
 linux-user/sparc/target_cpu.h              | 4 ++++
 linux-user/sparc/target_elf.h              | 2 ++
 linux-user/sparc/target_fcntl.h            | 3 +++
 linux-user/sparc/target_signal.h           | 2 ++
 linux-user/sparc/target_structs.h          | 3 +++
 linux-user/sparc/target_syscall.h          | 2 ++
 linux-user/sparc/termbits.h                | 2 ++
 linux-user/sparc64/target_cpu.h            | 3 +++
 linux-user/sparc64/target_fcntl.h          | 3 +++
 linux-user/sparc64/target_signal.h         | 2 ++
 linux-user/sparc64/target_structs.h        | 3 +++
 linux-user/sparc64/target_syscall.h        | 3 +++
 linux-user/sparc64/termbits.h              | 2 ++
 linux-user/syscall_defs.h                  | 2 ++
 linux-user/syscall_types.h                 | 2 ++
 linux-user/tilegx/target_cpu.h             | 3 +++
 linux-user/tilegx/target_fcntl.h           | 3 +++
 linux-user/tilegx/target_signal.h          | 2 ++
 linux-user/tilegx/target_structs.h         | 3 +++
 linux-user/tilegx/target_syscall.h         | 2 ++
 linux-user/uname.h                         | 2 ++
 linux-user/x86_64/target_cpu.h             | 3 +++
 linux-user/x86_64/target_fcntl.h           | 3 +++
 linux-user/x86_64/target_signal.h          | 2 ++
 linux-user/x86_64/target_structs.h         | 3 +++
 linux-user/x86_64/target_syscall.h         | 2 ++
 linux-user/x86_64/termbits.h               | 2 ++
 linux-user/xtensa/target_cpu.h             | 3 +++
 linux-user/xtensa/target_elf.h             | 2 ++
 linux-user/xtensa/target_fcntl.h           | 3 +++
 linux-user/xtensa/target_signal.h          | 2 ++
 linux-user/xtensa/target_structs.h         | 3 +++
 linux-user/xtensa/target_syscall.h         | 2 ++
 linux-user/xtensa/termbits.h               | 2 ++
 migration/postcopy-ram.h                   | 3 +++
 migration/qemu-file.h                      | 2 ++
 net/colo-compare.h                         | 2 ++
 qemu-options-wrapper.h                     | 1 +
 qga/guest-agent-core.h                     | 3 +++
 qga/service-win32.h                        | 2 ++
 qga/vss-win32.h                            | 2 ++
 qga/vss-win32/install.h                    | 2 ++
 qga/vss-win32/requester.h                  | 2 ++
 qga/vss-win32/vss-common.h                 | 2 ++
 replay/replay-internal.h                   | 2 ++
 replication.h                              | 2 ++
 target/alpha/cpu.h                         | 3 +++
 target/alpha/helper.h                      | 2 ++
 target/arm/arm-powerctl.h                  | 3 +++
 target/arm/arm_ldst.h                      | 3 +++
 target/arm/cpu.h                           | 3 +++
 target/arm/helper-a64.h                    | 3 +++
 target/arm/helper-sve.h                    | 2 ++
 target/arm/helper.h                        | 3 +++
 target/arm/internals.h                     | 2 ++
 target/arm/kvm-consts.h                    | 4 ++++
 target/arm/kvm_arm.h                       | 3 +++
 target/arm/op_addsub.h                     | 2 ++
 target/arm/translate-a64.h                 | 2 ++
 target/arm/translate.h                     | 3 +++
 target/cris/cpu.h                          | 3 +++
 target/cris/helper.h                       | 2 ++
 target/cris/mmu.h                          | 2 ++
 target/hppa/cpu.h                          | 3 +++
 target/hppa/helper.h                       | 2 ++
 target/i386/cc_helper_template.h           | 2 ++
 target/i386/cpu-qom.h                      | 3 +++
 target/i386/cpu.h                          | 3 +++
 target/i386/hax-i386.h                     | 3 +++
 target/i386/hax-posix.h                    | 2 ++
 target/i386/hax-windows.h                  | 2 ++
 target/i386/helper.h                       | 3 +++
 target/i386/hvf/hvf-i386.h                 | 3 +++
 target/i386/hvf/vmcs.h                     | 2 ++
 target/i386/hvf/vmx.h                      | 2 ++
 target/i386/hvf/x86.h                      | 2 ++
 target/i386/hvf/x86_decode.h               | 3 +++
 target/i386/hvf/x86_descr.h                | 2 ++
 target/i386/hvf/x86_emu.h                  | 3 +++
 target/i386/hvf/x86_flags.h                | 3 +++
 target/i386/hvf/x86_mmu.h                  | 2 ++
 target/i386/hvf/x86_task.h                 | 2 ++
 target/i386/hvf/x86hvf.h                   | 4 ++++
 target/i386/hyperv.h                       | 3 +++
 target/i386/kvm_i386.h                     | 3 +++
 target/i386/ops_sse.h                      | 3 +++
 target/i386/ops_sse_header.h               | 4 ++++
 target/i386/sev_i386.h                     | 3 +++
 target/i386/shift_helper_template.h        | 2 ++
 target/i386/whp-dispatch.h                 | 2 ++
 target/lm32/cpu.h                          | 3 +++
 target/lm32/helper.h                       | 2 ++
 target/m68k/cpu.h                          | 3 +++
 target/m68k/helper.h                       | 3 +++
 target/m68k/softfloat.h                    | 2 ++
 target/m68k/softfloat_fpsp_tables.h        | 2 ++
 target/microblaze/cpu.h                    | 3 +++
 target/microblaze/helper.h                 | 2 ++
 target/microblaze/mmu.h                    | 2 ++
 target/mips/cpu-qom.h                      | 3 +++
 target/mips/cpu.h                          | 3 +++
 target/mips/helper.h                       | 3 +++
 target/mips/internal.h                     | 3 +++
 target/mips/kvm_mips.h                     | 2 ++
 target/mips/mips-defs.h                    | 2 ++
 target/moxie/cpu.h                         | 3 +++
 target/moxie/helper.h                      | 2 ++
 target/moxie/machine.h                     | 2 ++
 target/moxie/mmu.h                         | 2 ++
 target/nios2/cpu.h                         | 3 +++
 target/nios2/helper.h                      | 2 ++
 target/nios2/mmu.h                         | 2 ++
 target/openrisc/cpu.h                      | 3 +++
 target/openrisc/exception.h                | 3 +++
 target/openrisc/helper.h                   | 2 ++
 target/ppc/cpu-models.h                    | 3 +++
 target/ppc/cpu-qom.h                       | 3 +++
 target/ppc/cpu.h                           | 3 +++
 target/ppc/helper.h                        | 3 +++
 target/ppc/helper_regs.h                   | 3 +++
 target/ppc/internal.h                      | 3 +++
 target/ppc/kvm_ppc.h                       | 3 +++
 target/ppc/mmu-book3s-v3.h                 | 3 +++
 target/ppc/mmu-hash32.h                    | 2 ++
 target/ppc/mmu-hash64.h                    | 3 +++
 target/ppc/mmu-radix64.h                   | 3 +++
 target/riscv/cpu.h                         | 3 +++
 target/riscv/helper.h                      | 2 ++
 target/riscv/instmap.h                     | 2 ++
 target/riscv/pmp.h                         | 2 ++
 target/s390x/cpu.h                         | 2 ++
 target/s390x/cpu_features.h                | 2 ++
 target/s390x/cpu_models.h                  | 2 ++
 target/s390x/helper.h                      | 2 ++
 target/s390x/internal.h                    | 2 ++
 target/s390x/tcg_s390x.h                   | 2 ++
 target/sh4/cpu.h                           | 3 +++
 target/sh4/helper.h                        | 2 ++
 target/sparc/cpu-qom.h                     | 3 +++
 target/sparc/cpu.h                         | 3 +++
 target/sparc/helper.h                      | 3 +++
 target/tilegx/cpu.h                        | 3 +++
 target/tilegx/helper.h                     | 2 ++
 target/tricore/cpu.h                       | 3 +++
 target/tricore/helper.h                    | 2 ++
 target/tricore/tricore-defs.h              | 2 ++
 target/tricore/tricore-opcodes.h           | 2 ++
 target/unicore32/cpu.h                     | 3 +++
 target/unicore32/helper.h                  | 2 ++
 target/xtensa/cpu.h                        | 3 +++
 target/xtensa/helper.h                     | 2 ++
 target/xtensa/overlay_tool.h               | 3 +++
 target/xtensa/xtensa-isa-internal.h        | 2 ++
 tcg/aarch64/tcg-target.h                   | 2 ++
 tcg/aarch64/tcg-target.opc.h               | 3 +++
 tcg/arm/tcg-target.h                       | 2 ++
 tcg/i386/tcg-target.h                      | 3 +++
 tcg/i386/tcg-target.opc.h                  | 2 ++
 tcg/mips/tcg-target.h                      | 2 ++
 tcg/ppc/tcg-target.h                       | 2 ++
 tcg/riscv/tcg-target.h                     | 3 +++
 tcg/s390/tcg-target.h                      | 3 +++
 tcg/tcg-gvec-desc.h                        | 2 ++
 tcg/tcg-op-gvec.h                          | 2 ++
 tcg/tcg-op.h                               | 2 ++
 tcg/tcg-opc.h                              | 4 ++++
 tcg/tcg.h                                  | 2 ++
 tcg/tci/tcg-target.h                       | 2 ++
 tests/check-headers.mak                    | 7 ++++---
 tests/crypto-tls-x509-helpers.h            | 2 ++
 tests/fp/platform.h                        | 3 +++
 tests/libqos/virtio-9p.h                   | 2 ++
 tests/libqos/virtio-balloon.h              | 2 ++
 tests/libqos/virtio-blk.h                  | 2 ++
 tests/libqos/virtio-net.h                  | 2 ++
 tests/libqos/virtio-rng.h                  | 2 ++
 tests/libqos/virtio-scsi.h                 | 2 ++
 tests/libqos/virtio-serial.h               | 2 ++
 tests/migration/Makefile                   | 2 ++
 tests/migration/aarch64/a-b-kernel.h       | 3 +++
 tests/migration/i386/a-b-bootblock.h       | 3 +++
 tests/migration/s390x/a-b-bios.h           | 2 ++
 tests/ptimer-test.h                        | 2 ++
 tests/socket-helpers.h                     | 3 ++-
 tests/tpm-emu.h                            | 2 ++
 tests/tpm-tests.h                          | 2 ++
 tests/tpm-util.h                           | 2 ++
 trace/control-internal.h                   | 2 ++
 trace/mem-internal.h                       | 2 ++
 trace/mem.h                                | 2 ++
 ui/curses_keys.h                           | 2 ++
 ui/vgafont.h                               | 2 ++
 ui/vnc-auth-sasl.h                         | 2 ++
 ui/vnc-auth-vencrypt.h                     | 2 ++
 ui/vnc-enc-hextile-template.h              | 2 ++
 ui/vnc-jobs.h                              | 2 ++
 ui/vnc-ws.h                                | 2 ++
 ui/vnc.h                                   | 2 ++
 ui/vnc_keysym.h                            | 1 +
 ui/x_keymap.h                              | 2 ++
 util/qemu-thread-common.h                  | 2 ++
 win_dump.h                                 | 2 ++
 432 files changed, 1035 insertions(+), 8 deletions(-)

diff --git a/accel/tcg/atomic_template.h b/accel/tcg/atomic_template.h
index 685602b076..352da0c745 100644
--- a/accel/tcg/atomic_template.h
+++ b/accel/tcg/atomic_template.h
@@ -18,6 +18,9 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #include "trace/mem.h"
 
 #if DATA_SIZE == 16
diff --git a/accel/tcg/tcg-runtime.h b/accel/tcg/tcg-runtime.h
index 6d73dc2d65..d85b2e8c0f 100644
--- a/accel/tcg/tcg-runtime.h
+++ b/accel/tcg/tcg-runtime.h
@@ -1,3 +1,6 @@
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 DEF_HELPER_FLAGS_2(div_i32, TCG_CALL_NO_RWG_SE, s32, s32, s32)
 DEF_HELPER_FLAGS_2(rem_i32, TCG_CALL_NO_RWG_SE, s32, s32, s32)
 DEF_HELPER_FLAGS_2(divu_i32, TCG_CALL_NO_RWG_SE, i32, i32, i32)
diff --git a/accel/tcg/translate-all.h b/accel/tcg/translate-all.h
index 64f5fd9a05..16572e7c20 100644
--- a/accel/tcg/translate-all.h
+++ b/accel/tcg/translate-all.h
@@ -16,6 +16,10 @@
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
+
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef TRANSLATE_ALL_H
 #define TRANSLATE_ALL_H
 
diff --git a/audio/audio_int.h b/audio/audio_int.h
index 3f14842709..2b69ee6d81 100644
--- a/audio/audio_int.h
+++ b/audio/audio_int.h
@@ -22,6 +22,8 @@
  * THE SOFTWARE.
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef QEMU_AUDIO_INT_H
 #define QEMU_AUDIO_INT_H
 
diff --git a/audio/audio_template.h b/audio/audio_template.h
index 1232bb54db..6f954ddd28 100644
--- a/audio/audio_template.h
+++ b/audio/audio_template.h
@@ -22,6 +22,8 @@
  * THE SOFTWARE.
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifdef DAC
 #define NAME "playback"
 #define HWBUF hw->mix_buf
diff --git a/audio/audio_win_int.h b/audio/audio_win_int.h
index fa5b3cb802..5716458c14 100644
--- a/audio/audio_win_int.h
+++ b/audio/audio_win_int.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef AUDIO_WIN_INT_H
 #define AUDIO_WIN_INT_H
 
diff --git a/audio/dsound_template.h b/audio/dsound_template.h
index 8ece870c9e..af7712ca0e 100644
--- a/audio/dsound_template.h
+++ b/audio/dsound_template.h
@@ -21,6 +21,9 @@
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  * THE SOFTWARE.
  */
+
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifdef DSBTYPE_IN
 #define NAME "capture buffer"
 #define NAME2 "DirectSoundCapture"
diff --git a/audio/mixeng_template.h b/audio/mixeng_template.h
index 77cc89b9e8..7db272d1a6 100644
--- a/audio/mixeng_template.h
+++ b/audio/mixeng_template.h
@@ -22,6 +22,8 @@
  * THE SOFTWARE.
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 /*
  * Tusen tack till Mike Nordell
  * dec++'ified by Dscho
diff --git a/audio/rate_template.h b/audio/rate_template.h
index 6e93588877..10ebdfe217 100644
--- a/audio/rate_template.h
+++ b/audio/rate_template.h
@@ -23,6 +23,8 @@
  * THE SOFTWARE.
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 /*
  * Processed signed long samples from ibuf to obuf.
  * Return number of samples processed.
diff --git a/block/crypto.h b/block/crypto.h
index b935695e79..08b6d2d238 100644
--- a/block/crypto.h
+++ b/block/crypto.h
@@ -18,6 +18,8 @@
  *
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef BLOCK_CRYPTO_H
 #define BLOCK_CRYPTO_H
 
diff --git a/block/qcow2.h b/block/qcow2.h
index 8d92ef1fee..d6c8f9df8e 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -22,6 +22,8 @@
  * THE SOFTWARE.
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef BLOCK_QCOW2_H
 #define BLOCK_QCOW2_H
 
diff --git a/block/vhdx.h b/block/vhdx.h
index 0b74924cee..d2636f8ce3 100644
--- a/block/vhdx.h
+++ b/block/vhdx.h
@@ -15,6 +15,8 @@
  *
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef BLOCK_VHDX_H
 #define BLOCK_VHDX_H
 #include "qemu/units.h"
diff --git a/bsd-user/i386/target_signal.h b/bsd-user/i386/target_signal.h
index 2ef36d1f98..978b64c960 100644
--- a/bsd-user/i386/target_signal.h
+++ b/bsd-user/i386/target_signal.h
@@ -1,3 +1,6 @@
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef TARGET_SIGNAL_H
 #define TARGET_SIGNAL_H
 
diff --git a/bsd-user/i386/target_syscall.h b/bsd-user/i386/target_syscall.h
index 8f201386af..d53cb69e06 100644
--- a/bsd-user/i386/target_syscall.h
+++ b/bsd-user/i386/target_syscall.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef TARGET_SYSCALL_H
 #define TARGET_SYSCALL_H
 
diff --git a/bsd-user/qemu.h b/bsd-user/qemu.h
index 09e8aed9c7..7e6dac6ce3 100644
--- a/bsd-user/qemu.h
+++ b/bsd-user/qemu.h
@@ -14,6 +14,10 @@
  *  You should have received a copy of the GNU General Public License
  *  along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
+
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef QEMU_H
 #define QEMU_H
 
diff --git a/bsd-user/sparc/target_signal.h b/bsd-user/sparc/target_signal.h
index 5b2abba40f..c62e6464ba 100644
--- a/bsd-user/sparc/target_signal.h
+++ b/bsd-user/sparc/target_signal.h
@@ -1,3 +1,6 @@
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef TARGET_SIGNAL_H
 #define TARGET_SIGNAL_H
 
diff --git a/bsd-user/sparc/target_syscall.h b/bsd-user/sparc/target_syscall.h
index dfdf9f82f5..5df900abb4 100644
--- a/bsd-user/sparc/target_syscall.h
+++ b/bsd-user/sparc/target_syscall.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef TARGET_SYSCALL_H
 #define TARGET_SYSCALL_H
 
diff --git a/bsd-user/sparc64/target_signal.h b/bsd-user/sparc64/target_signal.h
index 5b2abba40f..c62e6464ba 100644
--- a/bsd-user/sparc64/target_signal.h
+++ b/bsd-user/sparc64/target_signal.h
@@ -1,3 +1,6 @@
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef TARGET_SIGNAL_H
 #define TARGET_SIGNAL_H
 
diff --git a/bsd-user/sparc64/target_syscall.h b/bsd-user/sparc64/target_syscall.h
index 3a9f4c2ef9..bb8247dc6f 100644
--- a/bsd-user/sparc64/target_syscall.h
+++ b/bsd-user/sparc64/target_syscall.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef TARGET_SYSCALL_H
 #define TARGET_SYSCALL_H
 
diff --git a/bsd-user/syscall_defs.h b/bsd-user/syscall_defs.h
index 207ddeecbf..f3d18c4d8a 100644
--- a/bsd-user/syscall_defs.h
+++ b/bsd-user/syscall_defs.h
@@ -37,6 +37,8 @@
  *      @(#)signal.h    8.2 (Berkeley) 1/21/94
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #define TARGET_NSIG     32              /* counting 0; could be 33 (mask is 1-32) */
 
 #define TARGET_SIGHUP  1       /* hangup */
diff --git a/bsd-user/x86_64/target_signal.h b/bsd-user/x86_64/target_signal.h
index 659cd401b8..a8f190a14a 100644
--- a/bsd-user/x86_64/target_signal.h
+++ b/bsd-user/x86_64/target_signal.h
@@ -1,3 +1,6 @@
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef TARGET_SIGNAL_H
 #define TARGET_SIGNAL_H
 
diff --git a/bsd-user/x86_64/target_syscall.h b/bsd-user/x86_64/target_syscall.h
index a5d779884f..1f1b760ac7 100644
--- a/bsd-user/x86_64/target_syscall.h
+++ b/bsd-user/x86_64/target_syscall.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef TARGET_SYSCALL_H
 #define TARGET_SYSCALL_H
 
diff --git a/contrib/ivshmem-client/ivshmem-client.h b/contrib/ivshmem-client/ivshmem-client.h
index fe3cc4a03d..f969003650 100644
--- a/contrib/ivshmem-client/ivshmem-client.h
+++ b/contrib/ivshmem-client/ivshmem-client.h
@@ -6,6 +6,8 @@
  * top-level directory.
  */
 
+/* FIXME Does not pass make check-headers without CONFIG_POSIX, yet! */
+
 #ifndef IVSHMEM_CLIENT_H
 #define IVSHMEM_CLIENT_H
 
diff --git a/contrib/ivshmem-server/ivshmem-server.h b/contrib/ivshmem-server/ivshmem-server.h
index d870adb6a0..760a51087a 100644
--- a/contrib/ivshmem-server/ivshmem-server.h
+++ b/contrib/ivshmem-server/ivshmem-server.h
@@ -6,6 +6,8 @@
  * top-level directory.
  */
 
+/* FIXME Does not pass make check-headers without CONFIG_POSIX, yet! */
+
 #ifndef IVSHMEM_SERVER_H
 #define IVSHMEM_SERVER_H
 
diff --git a/contrib/libvhost-user/libvhost-user-glib.h b/contrib/libvhost-user/libvhost-user-glib.h
index d3200f3afc..70987a892c 100644
--- a/contrib/libvhost-user/libvhost-user-glib.h
+++ b/contrib/libvhost-user/libvhost-user-glib.h
@@ -12,6 +12,8 @@
  * later.  See the COPYING file in the top-level directory.
  */
 
+/* FIXME Does not pass make check-headers without CONFIG_LINUX, yet! */
+
 #ifndef LIBVHOST_USER_GLIB_H
 #define LIBVHOST_USER_GLIB_H
 
diff --git a/contrib/libvhost-user/libvhost-user.h b/contrib/libvhost-user/libvhost-user.h
index 78b33306e8..0cf7a20f28 100644
--- a/contrib/libvhost-user/libvhost-user.h
+++ b/contrib/libvhost-user/libvhost-user.h
@@ -11,6 +11,8 @@
  * later.  See the COPYING file in the top-level directory.
  */
 
+/* FIXME Does not pass make check-headers without CONFIG_LINUX, yet! */
+
 #ifndef LIBVHOST_USER_H
 #define LIBVHOST_USER_H
 
diff --git a/contrib/rdmacm-mux/rdmacm-mux.h b/contrib/rdmacm-mux/rdmacm-mux.h
index 07a4722913..d460e792e6 100644
--- a/contrib/rdmacm-mux/rdmacm-mux.h
+++ b/contrib/rdmacm-mux/rdmacm-mux.h
@@ -13,6 +13,8 @@
  *
  */
 
+/* FIXME Does not pass make check-headers without CONFIG_RDMA, yet! */
+
 #ifndef RDMACM_MUX_H
 #define RDMACM_MUX_H
 
diff --git a/crypto/afalgpriv.h b/crypto/afalgpriv.h
index f6550b5c51..93986694da 100644
--- a/crypto/afalgpriv.h
+++ b/crypto/afalgpriv.h
@@ -11,6 +11,8 @@
  * top-level directory.
  */
 
+/* FIXME Does not pass make check-headers without CONFIG_LINUX, yet! */
+
 #ifndef QCRYPTO_AFALGPRIV_H
 #define QCRYPTO_AFALGPRIV_H
 
diff --git a/crypto/cipherpriv.h b/crypto/cipherpriv.h
index 0823239f41..dca21620ee 100644
--- a/crypto/cipherpriv.h
+++ b/crypto/cipherpriv.h
@@ -12,6 +12,8 @@
  *
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef QCRYPTO_CIPHERPRIV_H
 #define QCRYPTO_CIPHERPRIV_H
 
diff --git a/crypto/hashpriv.h b/crypto/hashpriv.h
index cee26ccb47..7eba2105af 100644
--- a/crypto/hashpriv.h
+++ b/crypto/hashpriv.h
@@ -12,6 +12,8 @@
  *
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef QCRYPTO_HASHPRIV_H
 #define QCRYPTO_HASHPRIV_H
 
diff --git a/crypto/hmacpriv.h b/crypto/hmacpriv.h
index 4387ca2587..64c44098e4 100644
--- a/crypto/hmacpriv.h
+++ b/crypto/hmacpriv.h
@@ -12,6 +12,8 @@
  *
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef QCRYPTO_HMACPRIV_H
 #define QCRYPTO_HMACPRIV_H
 
diff --git a/disas/nanomips.h b/disas/nanomips.h
index a0a2225301..e77c98f98b 100644
--- a/disas/nanomips.h
+++ b/disas/nanomips.h
@@ -20,6 +20,8 @@
  *
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef DISAS_NANOMIPS_H
 #define DISAS_NANOMIPS_H
 
diff --git a/fpu/softfloat-specialize.h b/fpu/softfloat-specialize.h
index 7b8895726c..f42c3ab6cf 100644
--- a/fpu/softfloat-specialize.h
+++ b/fpu/softfloat-specialize.h
@@ -79,6 +79,9 @@ this code that are retained.
  * version 2 or later. See the COPYING file in the top-level directory.
  */
 
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 /* Define for architectures which deviate from IEEE in not supporting
  * signaling NaNs (so all NaNs are treated as quiet).
  */
diff --git a/fsdev/file-op-9p.h b/fsdev/file-op-9p.h
index c757c8099f..96d9561309 100644
--- a/fsdev/file-op-9p.h
+++ b/fsdev/file-op-9p.h
@@ -11,6 +11,8 @@
  *
  */
 
+/* FIXME Does not pass make check-headers without CONFIG_LINUX, yet! */
+
 #ifndef FILE_OP_9P_H
 #define FILE_OP_9P_H
 
diff --git a/fsdev/qemu-fsdev.h b/fsdev/qemu-fsdev.h
index 52a5397770..38399ad6bc 100644
--- a/fsdev/qemu-fsdev.h
+++ b/fsdev/qemu-fsdev.h
@@ -10,6 +10,9 @@
  * the COPYING file in the top-level directory.
  *
  */
+
+/* FIXME Does not pass make check-headers without CONFIG_LINUX, yet! */
+
 #ifndef QEMU_FSDEV_H
 #define QEMU_FSDEV_H
 #include "file-op-9p.h"
diff --git a/hw/9pfs/9p-local.h b/hw/9pfs/9p-local.h
index 32c72749d9..2664aecce5 100644
--- a/hw/9pfs/9p-local.h
+++ b/hw/9pfs/9p-local.h
@@ -10,6 +10,8 @@
  * See the COPYING file in the top-level directory.
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef QEMU_9P_LOCAL_H
 #define QEMU_9P_LOCAL_H
 
diff --git a/hw/9pfs/9p-proxy.h b/hw/9pfs/9p-proxy.h
index b84301d001..4f0560fcaf 100644
--- a/hw/9pfs/9p-proxy.h
+++ b/hw/9pfs/9p-proxy.h
@@ -10,6 +10,8 @@
  * the COPYING file in the top-level directory.
  */
 
+/* FIXME Does not pass make check-headers without CONFIG_LINUX, yet! */
+
 #ifndef QEMU_9P_PROXY_H
 #define QEMU_9P_PROXY_H
 
diff --git a/hw/9pfs/9p-synth.h b/hw/9pfs/9p-synth.h
index af7a993a1e..178139f26a 100644
--- a/hw/9pfs/9p-synth.h
+++ b/hw/9pfs/9p-synth.h
@@ -11,6 +11,8 @@
  *
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef QEMU_9P_SYNTH_H
 #define QEMU_9P_SYNTH_H
 
diff --git a/hw/9pfs/9p-util.h b/hw/9pfs/9p-util.h
index 79ed6b233e..ca19b25461 100644
--- a/hw/9pfs/9p-util.h
+++ b/hw/9pfs/9p-util.h
@@ -10,6 +10,8 @@
  * See the COPYING file in the top-level directory.
  */
 
+/* FIXME Does not pass make check-headers without CONFIG_LINUX, yet! */
+
 #ifndef QEMU_9P_UTIL_H
 #define QEMU_9P_UTIL_H
 
diff --git a/hw/9pfs/9p-xattr.h b/hw/9pfs/9p-xattr.h
index 35bcd24f77..c7403ac54e 100644
--- a/hw/9pfs/9p-xattr.h
+++ b/hw/9pfs/9p-xattr.h
@@ -11,6 +11,8 @@
  *
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef QEMU_9P_XATTR_H
 #define QEMU_9P_XATTR_H
 
diff --git a/hw/9pfs/9p.h b/hw/9pfs/9p.h
index 8883761b2c..300718cee7 100644
--- a/hw/9pfs/9p.h
+++ b/hw/9pfs/9p.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers without CONFIG_LINUX, yet! */
+
 #ifndef QEMU_9P_H
 #define QEMU_9P_H
 
diff --git a/hw/9pfs/coth.h b/hw/9pfs/coth.h
index 19e4d9287e..7f56e18f73 100644
--- a/hw/9pfs/coth.h
+++ b/hw/9pfs/coth.h
@@ -12,6 +12,8 @@
  *
  */
 
+/* FIXME Does not pass make check-headers without CONFIG_LINUX, yet! */
+
 #ifndef QEMU_9P_COTH_H
 #define QEMU_9P_COTH_H
 
diff --git a/hw/9pfs/virtio-9p.h b/hw/9pfs/virtio-9p.h
index e763da2c02..0978048254 100644
--- a/hw/9pfs/virtio-9p.h
+++ b/hw/9pfs/virtio-9p.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers without CONFIG_LINUX, yet! */
+
 #ifndef QEMU_VIRTIO_9P_H
 #define QEMU_VIRTIO_9P_H
 
diff --git a/hw/9pfs/xen-9pfs.h b/hw/9pfs/xen-9pfs.h
index 2d6ef7828c..3c40c10ef1 100644
--- a/hw/9pfs/xen-9pfs.h
+++ b/hw/9pfs/xen-9pfs.h
@@ -8,9 +8,10 @@
  *
  * This work is licensed under the terms of the GNU GPL version 2 or
  * later. See the COPYING file in the top-level directory.
- *
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #include <xen/io/protocols.h>
 #include "hw/xen/io/ring.h"
 
diff --git a/hw/arm/smmu-internal.h b/hw/arm/smmu-internal.h
index 7794d6d394..97a88d0375 100644
--- a/hw/arm/smmu-internal.h
+++ b/hw/arm/smmu-internal.h
@@ -18,6 +18,8 @@
  * with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef HW_ARM_SMMU_INTERNAL_H
 #define HW_ARM_SMMU_INTERNAL_H
 
diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
index b160289cd1..7d74cd3cb8 100644
--- a/hw/arm/smmuv3-internal.h
+++ b/hw/arm/smmuv3-internal.h
@@ -18,6 +18,8 @@
  * with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef HW_ARM_SMMUV3_INTERNAL_H
 #define HW_ARM_SMMUV3_INTERNAL_H
 
diff --git a/hw/audio/hda-codec-common.h b/hw/audio/hda-codec-common.h
index b4fdb51e8b..9702bf070e 100644
--- a/hw/audio/hda-codec-common.h
+++ b/hw/audio/hda-codec-common.h
@@ -20,10 +20,11 @@
  * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 /*
  * HDA codec descriptions
  */
-
 #ifdef HDA_MIXER
 #define QEMU_HDA_ID_OUTPUT  ((QEMU_HDA_ID_VENDOR << 16) | 0x12)
 #define QEMU_HDA_ID_DUPLEX  ((QEMU_HDA_ID_VENDOR << 16) | 0x22)
diff --git a/hw/audio/lm4549.h b/hw/audio/lm4549.h
index 74c3ee8934..e3e996b7cd 100644
--- a/hw/audio/lm4549.h
+++ b/hw/audio/lm4549.h
@@ -9,6 +9,8 @@
  * *****************************************************************
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef HW_LM4549_H
 #define HW_LM4549_H
 
diff --git a/hw/block/dataplane/xen-block.h b/hw/block/dataplane/xen-block.h
index d6fa6d26dd..85b19ba0f7 100644
--- a/hw/block/dataplane/xen-block.h
+++ b/hw/block/dataplane/xen-block.h
@@ -5,6 +5,8 @@
  * See the COPYING file in the top-level directory.
  */
 
+/* FIXME Does not pass make check-headers without CONFIG_XEN, yet! */
+
 #ifndef HW_BLOCK_DATAPLANE_XEN_BLOCK_H
 #define HW_BLOCK_DATAPLANE_XEN_BLOCK_H
 
diff --git a/hw/block/nvme.h b/hw/block/nvme.h
index 56c9d4b4b1..4a096b8c5d 100644
--- a/hw/block/nvme.h
+++ b/hw/block/nvme.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef HW_NVME_H
 #define HW_NVME_H
 #include "block/nvme.h"
diff --git a/hw/block/xen_blkif.h b/hw/block/xen_blkif.h
index a353693ea0..6d3d13c7e4 100644
--- a/hw/block/xen_blkif.h
+++ b/hw/block/xen_blkif.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef XEN_BLKIF_H
 #define XEN_BLKIF_H
 
diff --git a/hw/cris/boot.h b/hw/cris/boot.h
index 218854e5d1..db8f68d8a1 100644
--- a/hw/cris/boot.h
+++ b/hw/cris/boot.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef HW_CRIS_BOOT_H
 #define HW_CRIS_BOOT_H
 
diff --git a/hw/display/ati_int.h b/hw/display/ati_int.h
index 2f426064cf..9f49dd796e 100644
--- a/hw/display/ati_int.h
+++ b/hw/display/ati_int.h
@@ -6,6 +6,8 @@
  * This work is licensed under the GNU GPL license version 2 or later.
  */
 
+/* FIXME Does not pass make check-headers without system emulation, yet! */
+
 #ifndef ATI_INT_H
 #define ATI_INT_H
 
diff --git a/hw/display/cirrus_vga_internal.h b/hw/display/cirrus_vga_internal.h
index a78ebbd920..11985bb195 100644
--- a/hw/display/cirrus_vga_internal.h
+++ b/hw/display/cirrus_vga_internal.h
@@ -23,6 +23,8 @@
  * THE SOFTWARE.
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef CIRRUS_VGA_INTERNAL_H
 #define CIRRUS_VGA_INTERNAL_H
 
diff --git a/hw/display/cirrus_vga_rop.h b/hw/display/cirrus_vga_rop.h
index 0841b9efa9..b81b6acee6 100644
--- a/hw/display/cirrus_vga_rop.h
+++ b/hw/display/cirrus_vga_rop.h
@@ -22,6 +22,8 @@
  * THE SOFTWARE.
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 static inline void glue(rop_8_, ROP_NAME)(CirrusVGAState *s,
                                           uint32_t dstaddr, uint8_t src)
 {
diff --git a/hw/display/cirrus_vga_rop2.h b/hw/display/cirrus_vga_rop2.h
index b208b7348a..90724073bb 100644
--- a/hw/display/cirrus_vga_rop2.h
+++ b/hw/display/cirrus_vga_rop2.h
@@ -22,6 +22,8 @@
  * THE SOFTWARE.
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #if DEPTH == 8
 #define PUTPIXEL(s, a, c)    ROP_OP(s, a, c)
 #elif DEPTH == 16
diff --git a/hw/display/framebuffer.h b/hw/display/framebuffer.h
index 38fa0dcec6..b2e98b7cb1 100644
--- a/hw/display/framebuffer.h
+++ b/hw/display/framebuffer.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef QEMU_FRAMEBUFFER_H
 #define QEMU_FRAMEBUFFER_H
 
diff --git a/hw/display/milkymist-vgafb_template.h b/hw/display/milkymist-vgafb_template.h
index 48837809eb..6c1b899eac 100644
--- a/hw/display/milkymist-vgafb_template.h
+++ b/hw/display/milkymist-vgafb_template.h
@@ -15,9 +15,10 @@
  *
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
- *
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #if BITS == 8
 #define COPY_PIXEL(to, r, g, b)                    \
     do {                                           \
diff --git a/hw/display/omap_lcd_template.h b/hw/display/omap_lcd_template.h
index 1025ff3825..f3d5cdce3e 100644
--- a/hw/display/omap_lcd_template.h
+++ b/hw/display/omap_lcd_template.h
@@ -27,6 +27,9 @@
  * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #if DEPTH == 32
 # define BPP 4
 # define PIXEL_TYPE uint32_t
diff --git a/hw/display/pl110_template.h b/hw/display/pl110_template.h
index 36ba791c6f..79dc2929dc 100644
--- a/hw/display/pl110_template.h
+++ b/hw/display/pl110_template.h
@@ -9,6 +9,8 @@
  * Framebuffer format conversion routines.
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef ORDER
 
 #if BITS == 8
diff --git a/hw/display/pxa2xx_template.h b/hw/display/pxa2xx_template.h
index c64eebc4b6..fef72eb23f 100644
--- a/hw/display/pxa2xx_template.h
+++ b/hw/display/pxa2xx_template.h
@@ -9,6 +9,8 @@
  * Framebuffer format conversion routines.
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 # define SKIP_PIXEL(to)		to += deststep
 #if BITS == 8
 # define COPY_PIXEL(to, from)  do { *to = from; SKIP_PIXEL(to); } while (0)
diff --git a/hw/display/qxl.h b/hw/display/qxl.h
index 6f9d1f21fa..2044df2fa7 100644
--- a/hw/display/qxl.h
+++ b/hw/display/qxl.h
@@ -1,3 +1,7 @@
+/* FIXME Does not pass make check-headers without system emulation, yet! */
+/* FIXME Does not pass make check-headers without CONFIG_SPICE, yet! */
+
+
 #ifndef HW_QXL_H
 #define HW_QXL_H
 
diff --git a/hw/display/sm501_template.h b/hw/display/sm501_template.h
index a60abad019..3377c97fe7 100644
--- a/hw/display/sm501_template.h
+++ b/hw/display/sm501_template.h
@@ -22,6 +22,8 @@
  * THE SOFTWARE.
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #if DEPTH == 8
 #define BPP 1
 #define PIXEL_TYPE uint8_t
diff --git a/hw/display/tc6393xb_template.h b/hw/display/tc6393xb_template.h
index 78629c07f9..927282cf5c 100644
--- a/hw/display/tc6393xb_template.h
+++ b/hw/display/tc6393xb_template.h
@@ -21,6 +21,8 @@
  * with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #if BITS == 8
 # define SET_PIXEL(addr, color)  (*(uint8_t *)addr = color)
 #elif BITS == 15 || BITS == 16
diff --git a/hw/display/vga-helpers.h b/hw/display/vga-helpers.h
index 5a752b3f9e..9951dc4a1c 100644
--- a/hw/display/vga-helpers.h
+++ b/hw/display/vga-helpers.h
@@ -22,6 +22,8 @@
  * THE SOFTWARE.
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 static inline void vga_draw_glyph_line(uint8_t *d, uint32_t font_data,
                                        uint32_t xorcol, uint32_t bgcol)
 {
diff --git a/hw/display/vga_int.h b/hw/display/vga_int.h
index 55c418eab5..8a21a5a473 100644
--- a/hw/display/vga_int.h
+++ b/hw/display/vga_int.h
@@ -22,6 +22,8 @@
  * THE SOFTWARE.
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef HW_VGA_INT_H
 #define HW_VGA_INT_H
 
diff --git a/hw/ide/ahci_internal.h b/hw/ide/ahci_internal.h
index 95ecddcd3c..8a387812ce 100644
--- a/hw/ide/ahci_internal.h
+++ b/hw/ide/ahci_internal.h
@@ -21,6 +21,8 @@
  *
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef HW_IDE_AHCI_INTERNAL_H
 #define HW_IDE_AHCI_INTERNAL_H
 
diff --git a/hw/input/adb-internal.h b/hw/input/adb-internal.h
index 2a779b8a0a..97d7521fa1 100644
--- a/hw/input/adb-internal.h
+++ b/hw/input/adb-internal.h
@@ -22,6 +22,8 @@
  * THE SOFTWARE.
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 /* ADB commands */
 
 #define ADB_BUSRESET            0x00
diff --git a/hw/lm32/lm32.h b/hw/lm32/lm32.h
index d1514a61b3..b718b26c15 100644
--- a/hw/lm32/lm32.h
+++ b/hw/lm32/lm32.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef HW_LM32_H
 #define HW_LM32_H
 
diff --git a/hw/lm32/lm32_hwsetup.h b/hw/lm32/lm32_hwsetup.h
index a01f6bc5df..d1891f1795 100644
--- a/hw/lm32/lm32_hwsetup.h
+++ b/hw/lm32/lm32_hwsetup.h
@@ -22,6 +22,9 @@
  * in the Theobroma's uClinux port.
  */
 
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef QEMU_HW_LM32_HWSETUP_H
 #define QEMU_HW_LM32_HWSETUP_H
 
diff --git a/hw/lm32/milkymist-hw.h b/hw/lm32/milkymist-hw.h
index 976cf9254d..9081e4d71e 100644
--- a/hw/lm32/milkymist-hw.h
+++ b/hw/lm32/milkymist-hw.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef QEMU_HW_MILKYMIST_HW_H
 #define QEMU_HW_MILKYMIST_HW_H
 
diff --git a/hw/microblaze/boot.h b/hw/microblaze/boot.h
index dd1090d8b5..53200eb0f8 100644
--- a/hw/microblaze/boot.h
+++ b/hw/microblaze/boot.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef MICROBLAZE_BOOT_H
 #define MICROBLAZE_BOOT_H
 
diff --git a/hw/net/can/can_sja1000.h b/hw/net/can/can_sja1000.h
index 4731cbbd2a..0788d1e0f4 100644
--- a/hw/net/can/can_sja1000.h
+++ b/hw/net/can/can_sja1000.h
@@ -24,6 +24,9 @@
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  * THE SOFTWARE.
  */
+
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef HW_CAN_SJA1000_H
 #define HW_CAN_SJA1000_H
 
diff --git a/hw/net/e1000e_core.h b/hw/net/e1000e_core.h
index 63a15510cc..52c709ae61 100644
--- a/hw/net/e1000e_core.h
+++ b/hw/net/e1000e_core.h
@@ -33,6 +33,8 @@
 * License along with this library; if not, see <http://www.gnu.org/licenses/>.
 */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #define E1000E_PHY_PAGE_SIZE    (0x20)
 #define E1000E_PHY_PAGES        (0x07)
 #define E1000E_MAC_SIZE         (0x8000)
diff --git a/hw/net/e1000x_common.h b/hw/net/e1000x_common.h
index 0268884e72..b0bc7a2dd3 100644
--- a/hw/net/e1000x_common.h
+++ b/hw/net/e1000x_common.h
@@ -22,6 +22,8 @@
 * License along with this library; if not, see <http://www.gnu.org/licenses/>.
 */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #include "e1000_regs.h"
 
 #define defreg(x)   x = (E1000_##x >> 2)
diff --git a/hw/net/pcnet.h b/hw/net/pcnet.h
index 40831a7845..906247b7c1 100644
--- a/hw/net/pcnet.h
+++ b/hw/net/pcnet.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef HW_PCNET_H
 #define HW_PCNET_H
 
diff --git a/hw/net/rocker/rocker_desc.h b/hw/net/rocker/rocker_desc.h
index 1dec335614..6480ff46b3 100644
--- a/hw/net/rocker/rocker_desc.h
+++ b/hw/net/rocker/rocker_desc.h
@@ -14,6 +14,8 @@
  * GNU General Public License for more details.
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef ROCKER_DESC_H
 #define ROCKER_DESC_H
 
diff --git a/hw/net/rocker/rocker_fp.h b/hw/net/rocker/rocker_fp.h
index dbe1dd329a..8d80234c9d 100644
--- a/hw/net/rocker/rocker_fp.h
+++ b/hw/net/rocker/rocker_fp.h
@@ -14,6 +14,8 @@
  * GNU General Public License for more details.
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef ROCKER_FP_H
 #define ROCKER_FP_H
 
diff --git a/hw/net/rocker/rocker_of_dpa.h b/hw/net/rocker/rocker_of_dpa.h
index 01c7a97d0d..d88d2df33d 100644
--- a/hw/net/rocker/rocker_of_dpa.h
+++ b/hw/net/rocker/rocker_of_dpa.h
@@ -14,6 +14,8 @@
  * GNU General Public License for more details.
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef ROCKER_OF_DPA_H
 #define ROCKER_OF_DPA_H
 
diff --git a/hw/net/rocker/rocker_tlv.h b/hw/net/rocker/rocker_tlv.h
index dd28d08443..938a9e7545 100644
--- a/hw/net/rocker/rocker_tlv.h
+++ b/hw/net/rocker/rocker_tlv.h
@@ -14,6 +14,8 @@
  * GNU General Public License for more details.
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef ROCKER_TLV_H
 #define ROCKER_TLV_H
 
diff --git a/hw/net/rocker/rocker_world.h b/hw/net/rocker/rocker_world.h
index 44f1fe3e19..0af3ff8bfe 100644
--- a/hw/net/rocker/rocker_world.h
+++ b/hw/net/rocker/rocker_world.h
@@ -14,6 +14,8 @@
  * GNU General Public License for more details.
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef ROCKER_WORLD_H
 #define ROCKER_WORLD_H
 
diff --git a/hw/net/vmware_utils.h b/hw/net/vmware_utils.h
index 6b1e251595..7860f22e47 100644
--- a/hw/net/vmware_utils.h
+++ b/hw/net/vmware_utils.h
@@ -14,6 +14,8 @@
  *
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef VMWARE_UTILS_H
 #define VMWARE_UTILS_H
 
diff --git a/hw/net/vmxnet3_defs.h b/hw/net/vmxnet3_defs.h
index 6c19d29b12..76411bb79e 100644
--- a/hw/net/vmxnet3_defs.h
+++ b/hw/net/vmxnet3_defs.h
@@ -12,9 +12,10 @@
  *
  * This work is licensed under the terms of the GNU GPL, version 2.
  * See the COPYING file in the top-level directory.
- *
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #include "net/net.h"
 #include "hw/net/vmxnet3.h"
 
diff --git a/hw/nios2/boot.h b/hw/nios2/boot.h
index 3116753818..e3a4da0d1e 100644
--- a/hw/nios2/boot.h
+++ b/hw/nios2/boot.h
@@ -1,3 +1,6 @@
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef NIOS2_BOOT_H
 #define NIOS2_BOOT_H
 
diff --git a/hw/ppc/ppc405.h b/hw/ppc/ppc405.h
index 7ed25cfa1b..fe74289d4a 100644
--- a/hw/ppc/ppc405.h
+++ b/hw/ppc/ppc405.h
@@ -22,6 +22,8 @@
  * THE SOFTWARE.
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef PPC405_H
 #define PPC405_H
 
diff --git a/hw/ppc/ppc440.h b/hw/ppc/ppc440.h
index 7cef936125..e1093ad4b5 100644
--- a/hw/ppc/ppc440.h
+++ b/hw/ppc/ppc440.h
@@ -8,6 +8,8 @@
  *
  */
 
+/* NOTE: May only be included into target-dependent code */
+
 #ifndef PPC440_H
 #define PPC440_H
 
diff --git a/hw/rdma/rdma_backend.h b/hw/rdma/rdma_backend.h
index 7c1a19a2b5..4ed78b9829 100644
--- a/hw/rdma/rdma_backend.h
+++ b/hw/rdma/rdma_backend.h
@@ -13,6 +13,8 @@
  *
  */
 
+/* FIXME Does not pass make check-headers without CONFIG_RDMA, yet! */
+
 #ifndef RDMA_BACKEND_H
 #define RDMA_BACKEND_H
 
diff --git a/hw/rdma/rdma_backend_defs.h b/hw/rdma/rdma_backend_defs.h
index 0b55be3503..14a5e05d83 100644
--- a/hw/rdma/rdma_backend_defs.h
+++ b/hw/rdma/rdma_backend_defs.h
@@ -13,6 +13,8 @@
  *
  */
 
+/* FIXME Does not pass make check-headers without CONFIG_RDMA, yet! */
+
 #ifndef RDMA_BACKEND_DEFS_H
 #define RDMA_BACKEND_DEFS_H
 
diff --git a/hw/rdma/rdma_rm.h b/hw/rdma/rdma_rm.h
index e8639909cd..ef932ce262 100644
--- a/hw/rdma/rdma_rm.h
+++ b/hw/rdma/rdma_rm.h
@@ -13,6 +13,8 @@
  *
  */
 
+/* FIXME Does not pass make check-headers without CONFIG_RDMA, yet! */
+
 #ifndef RDMA_RM_H
 #define RDMA_RM_H
 
diff --git a/hw/rdma/rdma_rm_defs.h b/hw/rdma/rdma_rm_defs.h
index 534f2f74d3..72c000cc8e 100644
--- a/hw/rdma/rdma_rm_defs.h
+++ b/hw/rdma/rdma_rm_defs.h
@@ -13,6 +13,8 @@
  *
  */
 
+/* FIXME Does not pass make check-headers without CONFIG_RDMA, yet! */
+
 #ifndef RDMA_RM_DEFS_H
 #define RDMA_RM_DEFS_H
 
diff --git a/hw/rdma/vmw/pvrdma.h b/hw/rdma/vmw/pvrdma.h
index a8a04a253c..004e5a727c 100644
--- a/hw/rdma/vmw/pvrdma.h
+++ b/hw/rdma/vmw/pvrdma.h
@@ -13,6 +13,8 @@
  *
  */
 
+/* FIXME Does not pass make check-headers without CONFIG_RDMA, yet! */
+
 #ifndef PVRDMA_PVRDMA_H
 #define PVRDMA_PVRDMA_H
 
diff --git a/hw/rdma/vmw/pvrdma_dev_ring.h b/hw/rdma/vmw/pvrdma_dev_ring.h
index 5f2a0cf9b9..df108b0fa6 100644
--- a/hw/rdma/vmw/pvrdma_dev_ring.h
+++ b/hw/rdma/vmw/pvrdma_dev_ring.h
@@ -13,6 +13,8 @@
  *
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef PVRDMA_DEV_RING_H
 #define PVRDMA_DEV_RING_H
 
diff --git a/hw/rdma/vmw/pvrdma_qp_ops.h b/hw/rdma/vmw/pvrdma_qp_ops.h
index bf2b15c5ce..40160f8b5e 100644
--- a/hw/rdma/vmw/pvrdma_qp_ops.h
+++ b/hw/rdma/vmw/pvrdma_qp_ops.h
@@ -13,6 +13,8 @@
  *
  */
 
+/* FIXME Does not pass make check-headers without CONFIG_RDMA, yet! */
+
 #ifndef PVRDMA_QP_OPS_H
 #define PVRDMA_QP_OPS_H
 
diff --git a/hw/s390x/ccw-device.h b/hw/s390x/ccw-device.h
index 4e6af287e7..356ce0e5ce 100644
--- a/hw/s390x/ccw-device.h
+++ b/hw/s390x/ccw-device.h
@@ -9,6 +9,9 @@
  * directory.
  */
 
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef HW_S390X_CCW_DEVICE_H
 #define HW_S390X_CCW_DEVICE_H
 #include "qom/object.h"
diff --git a/hw/s390x/ipl.h b/hw/s390x/ipl.h
index b3a07a12d8..562ebf2988 100644
--- a/hw/s390x/ipl.h
+++ b/hw/s390x/ipl.h
@@ -9,6 +9,9 @@
  * directory.
  */
 
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef HW_S390_IPL_H
 #define HW_S390_IPL_H
 
diff --git a/hw/s390x/s390-pci-bus.h b/hw/s390x/s390-pci-bus.h
index 550f3cc5e9..81e5231b67 100644
--- a/hw/s390x/s390-pci-bus.h
+++ b/hw/s390x/s390-pci-bus.h
@@ -11,6 +11,9 @@
  * directory.
  */
 
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef HW_S390_PCI_BUS_H
 #define HW_S390_PCI_BUS_H
 
diff --git a/hw/s390x/s390-pci-inst.h b/hw/s390x/s390-pci-inst.h
index fa3bf8b5aa..55afaae949 100644
--- a/hw/s390x/s390-pci-inst.h
+++ b/hw/s390x/s390-pci-inst.h
@@ -11,6 +11,9 @@
  * directory.
  */
 
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef HW_S390_PCI_INST_H
 #define HW_S390_PCI_INST_H
 
diff --git a/hw/s390x/s390-virtio-hcall.h b/hw/s390x/s390-virtio-hcall.h
index 9800c4b351..0d66be3785 100644
--- a/hw/s390x/s390-virtio-hcall.h
+++ b/hw/s390x/s390-virtio-hcall.h
@@ -9,6 +9,8 @@
  * directory.
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef HW_S390_VIRTIO_HCALL_H
 #define HW_S390_VIRTIO_HCALL_H
 
diff --git a/hw/s390x/virtio-ccw.h b/hw/s390x/virtio-ccw.h
index 3453aa1f98..ad1dd19250 100644
--- a/hw/s390x/virtio-ccw.h
+++ b/hw/s390x/virtio-ccw.h
@@ -10,6 +10,9 @@
  * directory.
  */
 
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef HW_S390X_VIRTIO_CCW_H
 #define HW_S390X_VIRTIO_CCW_H
 
diff --git a/hw/scsi/mptsas.h b/hw/scsi/mptsas.h
index 0436a33911..a7a8d67cb3 100644
--- a/hw/scsi/mptsas.h
+++ b/hw/scsi/mptsas.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef MPTSAS_H
 #define MPTSAS_H
 
diff --git a/hw/scsi/viosrp.h b/hw/scsi/viosrp.h
index d8e365db1e..05fe773721 100644
--- a/hw/scsi/viosrp.h
+++ b/hw/scsi/viosrp.h
@@ -31,6 +31,9 @@
 /* of Linux and other operating systems (AIX, OS/400) that talk this protocol*/
 /* between logical partitions                                                */
 /*****************************************************************************/
+
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef PPC_VIOSRP_H
 #define PPC_VIOSRP_H
 
diff --git a/hw/sd/sdhci-internal.h b/hw/sd/sdhci-internal.h
index 34141400f8..c09f4164f6 100644
--- a/hw/sd/sdhci-internal.h
+++ b/hw/sd/sdhci-internal.h
@@ -21,6 +21,9 @@
  * You should have received a copy of the GNU General Public License along
  * with this program; if not, see <http://www.gnu.org/licenses/>.
  */
+
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef SDHCI_INTERNAL_H
 #define SDHCI_INTERNAL_H
 
diff --git a/hw/timer/m48t59-internal.h b/hw/timer/m48t59-internal.h
index 4d4f2a6fed..b158660fbf 100644
--- a/hw/timer/m48t59-internal.h
+++ b/hw/timer/m48t59-internal.h
@@ -23,6 +23,8 @@
  * THE SOFTWARE.
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef HW_M48T59_INTERNAL_H
 #define HW_M48T59_INTERNAL_H
 
diff --git a/hw/tpm/tpm_ioctl.h b/hw/tpm/tpm_ioctl.h
index f5f5c553a9..d9f1fed0fa 100644
--- a/hw/tpm/tpm_ioctl.h
+++ b/hw/tpm/tpm_ioctl.h
@@ -6,6 +6,8 @@
  * This file is licensed under the terms of the 3-clause BSD license
  */
 
+/* FIXME Does not pass make check-headers without CONFIG_POSIX, yet! */
+
 #ifndef TPM_IOCTL_H
 #define TPM_IOCTL_H
 
diff --git a/hw/usb/desc.h b/hw/usb/desc.h
index 4d81c68e0e..b6663f3abd 100644
--- a/hw/usb/desc.h
+++ b/hw/usb/desc.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef QEMU_HW_USB_DESC_H
 #define QEMU_HW_USB_DESC_H
 
diff --git a/hw/usb/hcd-ohci.h b/hw/usb/hcd-ohci.h
index 16e3f1e13a..d18f97bcab 100644
--- a/hw/usb/hcd-ohci.h
+++ b/hw/usb/hcd-ohci.h
@@ -18,6 +18,8 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef HCD_OHCI_H
 #define HCD_OHCI_H
 
diff --git a/hw/usb/hcd-xhci.h b/hw/usb/hcd-xhci.h
index 240caa4e51..c1cfc1f02e 100644
--- a/hw/usb/hcd-xhci.h
+++ b/hw/usb/hcd-xhci.h
@@ -19,6 +19,8 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #define TYPE_XHCI "base-xhci"
 #define TYPE_NEC_XHCI "nec-usb-xhci"
 #define TYPE_QEMU_XHCI "qemu-xhci"
diff --git a/hw/usb/quirks.h b/hw/usb/quirks.h
index 8dc6065527..4ee621068c 100644
--- a/hw/usb/quirks.h
+++ b/hw/usb/quirks.h
@@ -12,6 +12,8 @@
  * (at your option) any later version.
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 /* 1 on 1 copy of linux/drivers/usb/serial/ftdi_sio_ids.h */
 #include "quirks-ftdi-ids.h"
 /* 1 on 1 copy of linux/drivers/usb/serial/pl2303.h */
diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index cfcd1a81b8..bb1088c2e7 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -9,6 +9,9 @@
  * This work is licensed under the terms of the GNU GPL, version 2.  See
  * the COPYING file in the top-level directory.
  */
+
+/* FIXME Does not pass make check-headers without system emulation, yet! */
+
 #ifndef HW_VFIO_VFIO_PCI_H
 #define HW_VFIO_VFIO_PCI_H
 
diff --git a/hw/xen/xen_pt.h b/hw/xen/xen_pt.h
index dbee3308fd..a759ccfc52 100644
--- a/hw/xen/xen_pt.h
+++ b/hw/xen/xen_pt.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers without CONFIG_XEN, yet! */
+
 #ifndef XEN_PT_H
 #define XEN_PT_H
 
diff --git a/hw/xtensa/bootparam.h b/hw/xtensa/bootparam.h
index ade7891ec5..e7a446a331 100644
--- a/hw/xtensa/bootparam.h
+++ b/hw/xtensa/bootparam.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef HW_XTENSA_BOOTPARAM_H
 #define HW_XTENSA_BOOTPARAM_H
 
diff --git a/hw/xtensa/xtensa_memory.h b/hw/xtensa/xtensa_memory.h
index 89125c4a0d..e0d34de2fa 100644
--- a/hw/xtensa/xtensa_memory.h
+++ b/hw/xtensa/xtensa_memory.h
@@ -25,6 +25,9 @@
  * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef XTENSA_MEMORY_H
 #define XTENSA_MEMORY_H
 
diff --git a/linux-user/aarch64/target_cpu.h b/linux-user/aarch64/target_cpu.h
index a021c95fa4..05f13afef2 100644
--- a/linux-user/aarch64/target_cpu.h
+++ b/linux-user/aarch64/target_cpu.h
@@ -16,6 +16,9 @@
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
+
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef AARCH64_TARGET_CPU_H
 #define AARCH64_TARGET_CPU_H
 
diff --git a/linux-user/aarch64/target_fcntl.h b/linux-user/aarch64/target_fcntl.h
index efdf6e5f05..f9f9a3f78e 100644
--- a/linux-user/aarch64/target_fcntl.h
+++ b/linux-user/aarch64/target_fcntl.h
@@ -5,6 +5,9 @@
  * later version. See the COPYING file in the top-level directory.
  */
 
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef AARCH64_TARGET_FCNTL_H
 #define AARCH64_TARGET_FCNTL_H
 
diff --git a/linux-user/aarch64/target_signal.h b/linux-user/aarch64/target_signal.h
index ddd73169f0..cf6e667724 100644
--- a/linux-user/aarch64/target_signal.h
+++ b/linux-user/aarch64/target_signal.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef AARCH64_TARGET_SIGNAL_H
 #define AARCH64_TARGET_SIGNAL_H
 
diff --git a/linux-user/aarch64/target_structs.h b/linux-user/aarch64/target_structs.h
index a4998a7491..50d147721c 100644
--- a/linux-user/aarch64/target_structs.h
+++ b/linux-user/aarch64/target_structs.h
@@ -16,6 +16,9 @@
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
+
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef AARCH64_TARGET_STRUCTS_H
 #define AARCH64_TARGET_STRUCTS_H
 
diff --git a/linux-user/aarch64/target_syscall.h b/linux-user/aarch64/target_syscall.h
index b595e5da82..f7e43e03ef 100644
--- a/linux-user/aarch64/target_syscall.h
+++ b/linux-user/aarch64/target_syscall.h
@@ -1,3 +1,6 @@
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef AARCH64_TARGET_SYSCALL_H
 #define AARCH64_TARGET_SYSCALL_H
 
diff --git a/linux-user/aarch64/termbits.h b/linux-user/aarch64/termbits.h
index f9f80f0f37..31cfbd45f7 100644
--- a/linux-user/aarch64/termbits.h
+++ b/linux-user/aarch64/termbits.h
@@ -1,6 +1,8 @@
 /* from asm/termbits.h */
 /* NOTE: exactly the same as i386 */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #define TARGET_NCCS 19
 
 struct target_termios {
diff --git a/linux-user/alpha/target_cpu.h b/linux-user/alpha/target_cpu.h
index ac4d255ae7..54697f55ad 100644
--- a/linux-user/alpha/target_cpu.h
+++ b/linux-user/alpha/target_cpu.h
@@ -16,6 +16,9 @@
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
+
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef ALPHA_TARGET_CPU_H
 #define ALPHA_TARGET_CPU_H
 
diff --git a/linux-user/alpha/target_fcntl.h b/linux-user/alpha/target_fcntl.h
index 2617e73472..d39352b45f 100644
--- a/linux-user/alpha/target_fcntl.h
+++ b/linux-user/alpha/target_fcntl.h
@@ -5,6 +5,9 @@
  * later version. See the COPYING file in the top-level directory.
  */
 
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef ALPHA_TARGET_FCNTL_H
 #define ALPHA_TARGET_FCNTL_H
 
diff --git a/linux-user/alpha/target_signal.h b/linux-user/alpha/target_signal.h
index cd63d59fde..05dcb138b1 100644
--- a/linux-user/alpha/target_signal.h
+++ b/linux-user/alpha/target_signal.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef ALPHA_TARGET_SIGNAL_H
 #define ALPHA_TARGET_SIGNAL_H
 
diff --git a/linux-user/alpha/target_structs.h b/linux-user/alpha/target_structs.h
index db2bfe2876..5f57bfb815 100644
--- a/linux-user/alpha/target_structs.h
+++ b/linux-user/alpha/target_structs.h
@@ -16,6 +16,9 @@
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
+
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef ALPHA_TARGET_STRUCTS_H
 #define ALPHA_TARGET_STRUCTS_H
 
diff --git a/linux-user/alpha/target_syscall.h b/linux-user/alpha/target_syscall.h
index 3426cc5b4e..3f49f36247 100644
--- a/linux-user/alpha/target_syscall.h
+++ b/linux-user/alpha/target_syscall.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef ALPHA_TARGET_SYSCALL_H
 #define ALPHA_TARGET_SYSCALL_H
 
diff --git a/linux-user/alpha/termbits.h b/linux-user/alpha/termbits.h
index 139bc87fa6..dfac5d2fec 100644
--- a/linux-user/alpha/termbits.h
+++ b/linux-user/alpha/termbits.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers, yet! */
+
 typedef unsigned char	target_cc_t;
 typedef unsigned int	target_speed_t;
 typedef unsigned int	target_tcflag_t;
diff --git a/linux-user/arm/nwfpe/fpa11.h b/linux-user/arm/nwfpe/fpa11.h
index d459c5da02..beffc90bca 100644
--- a/linux-user/arm/nwfpe/fpa11.h
+++ b/linux-user/arm/nwfpe/fpa11.h
@@ -18,6 +18,9 @@
     along with this program; if not, see <http://www.gnu.org/licenses/>.
 */
 
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef FPA11_H
 #define FPA11_H
 
diff --git a/linux-user/arm/nwfpe/fpopcode.h b/linux-user/arm/nwfpe/fpopcode.h
index 06cd909850..e628a5b6c9 100644
--- a/linux-user/arm/nwfpe/fpopcode.h
+++ b/linux-user/arm/nwfpe/fpopcode.h
@@ -18,6 +18,8 @@
     along with this program; if not, see <http://www.gnu.org/licenses/>.
 */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef FPOPCODE_H
 #define FPOPCODE_H
 
diff --git a/linux-user/arm/target_cpu.h b/linux-user/arm/target_cpu.h
index 8a3764919a..d30f855647 100644
--- a/linux-user/arm/target_cpu.h
+++ b/linux-user/arm/target_cpu.h
@@ -16,6 +16,9 @@
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
+
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef ARM_TARGET_CPU_H
 #define ARM_TARGET_CPU_H
 
diff --git a/linux-user/arm/target_fcntl.h b/linux-user/arm/target_fcntl.h
index c8ff6b2505..4f469543c5 100644
--- a/linux-user/arm/target_fcntl.h
+++ b/linux-user/arm/target_fcntl.h
@@ -5,6 +5,9 @@
  * later version. See the COPYING file in the top-level directory.
  */
 
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef ARM_TARGET_FCNTL_H
 #define ARM_TARGET_FCNTL_H
 
diff --git a/linux-user/arm/target_signal.h b/linux-user/arm/target_signal.h
index ea123c40f3..e94a0b8c81 100644
--- a/linux-user/arm/target_signal.h
+++ b/linux-user/arm/target_signal.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef ARM_TARGET_SIGNAL_H
 #define ARM_TARGET_SIGNAL_H
 
diff --git a/linux-user/arm/target_structs.h b/linux-user/arm/target_structs.h
index 9a3dbce03d..a7db138167 100644
--- a/linux-user/arm/target_structs.h
+++ b/linux-user/arm/target_structs.h
@@ -16,6 +16,9 @@
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
+
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef ARM_TARGET_STRUCTS_H
 #define ARM_TARGET_STRUCTS_H
 
diff --git a/linux-user/arm/target_syscall.h b/linux-user/arm/target_syscall.h
index afc0772e19..beadaaac33 100644
--- a/linux-user/arm/target_syscall.h
+++ b/linux-user/arm/target_syscall.h
@@ -1,3 +1,6 @@
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef ARM_TARGET_SYSCALL_H
 #define ARM_TARGET_SYSCALL_H
 
diff --git a/linux-user/arm/termbits.h b/linux-user/arm/termbits.h
index a61e138ec4..8bc288b38c 100644
--- a/linux-user/arm/termbits.h
+++ b/linux-user/arm/termbits.h
@@ -1,6 +1,8 @@
 /* from asm/termbits.h */
 /* NOTE: exactly the same as i386 */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #define TARGET_NCCS 19
 
 struct target_termios {
diff --git a/linux-user/cpu_loop-common.h b/linux-user/cpu_loop-common.h
index c1d554a249..0c7eab2e03 100644
--- a/linux-user/cpu_loop-common.h
+++ b/linux-user/cpu_loop-common.h
@@ -17,6 +17,9 @@
  *  along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef CPU_LOOP_COMMON_H
 #define CPU_LOOP_COMMON_H
 
diff --git a/linux-user/cris/target_cpu.h b/linux-user/cris/target_cpu.h
index 2309343979..2c9aba607d 100644
--- a/linux-user/cris/target_cpu.h
+++ b/linux-user/cris/target_cpu.h
@@ -17,6 +17,9 @@
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
+
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef CRIS_TARGET_CPU_H
 #define CRIS_TARGET_CPU_H
 
diff --git a/linux-user/cris/target_fcntl.h b/linux-user/cris/target_fcntl.h
index df0aceea34..b9133be2f0 100644
--- a/linux-user/cris/target_fcntl.h
+++ b/linux-user/cris/target_fcntl.h
@@ -5,6 +5,9 @@
  * later version. See the COPYING file in the top-level directory.
  */
 
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef CRIS_TARGET_FCNTL_H
 #define CRIS_TARGET_FCNTL_H
 #include "../generic/fcntl.h"
diff --git a/linux-user/cris/target_signal.h b/linux-user/cris/target_signal.h
index 1cb5548f85..125db32d96 100644
--- a/linux-user/cris/target_signal.h
+++ b/linux-user/cris/target_signal.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef CRIS_TARGET_SIGNAL_H
 #define CRIS_TARGET_SIGNAL_H
 
diff --git a/linux-user/cris/target_structs.h b/linux-user/cris/target_structs.h
index 76f965325c..5d0dfbe975 100644
--- a/linux-user/cris/target_structs.h
+++ b/linux-user/cris/target_structs.h
@@ -16,6 +16,9 @@
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
+
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef CRIS_TARGET_STRUCTS_H
 #define CRIS_TARGET_STRUCTS_H
 
diff --git a/linux-user/cris/termbits.h b/linux-user/cris/termbits.h
index c825cd2f5e..e0adbcbea3 100644
--- a/linux-user/cris/termbits.h
+++ b/linux-user/cris/termbits.h
@@ -1,5 +1,7 @@
 /* from asm/termbits.h */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #define TARGET_NCCS 19
 
 struct target_termios {
diff --git a/linux-user/fd-trans.h b/linux-user/fd-trans.h
index a3fcdaabc7..033308d47b 100644
--- a/linux-user/fd-trans.h
+++ b/linux-user/fd-trans.h
@@ -13,6 +13,8 @@
  *  along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef FD_TRANS_H
 #define FD_TRANS_H
 
diff --git a/linux-user/flat.h b/linux-user/flat.h
index 6f2d0c4b2d..473fa61311 100644
--- a/linux-user/flat.h
+++ b/linux-user/flat.h
@@ -7,6 +7,8 @@
  * support uClinux flat-format executables.
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #define	FLAT_VERSION			0x00000004L
 
 #ifdef CONFIG_BINFMT_SHARED_FLAT
diff --git a/linux-user/generic/fcntl.h b/linux-user/generic/fcntl.h
index a775a491e9..e7bae5e8a6 100644
--- a/linux-user/generic/fcntl.h
+++ b/linux-user/generic/fcntl.h
@@ -5,6 +5,9 @@
  * later version. See the COPYING file in the top-level directory.
  */
 
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef GENERIC_FCNTL_H
 #define GENERIC_FCNTL_H
 
diff --git a/linux-user/host/aarch64/hostdep.h b/linux-user/host/aarch64/hostdep.h
index a8d41a21ad..e3ff0f7a73 100644
--- a/linux-user/host/aarch64/hostdep.h
+++ b/linux-user/host/aarch64/hostdep.h
@@ -9,6 +9,8 @@
  * See the COPYING file in the top-level directory.
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef AARCH64_HOSTDEP_H
 #define AARCH64_HOSTDEP_H
 
diff --git a/linux-user/host/arm/hostdep.h b/linux-user/host/arm/hostdep.h
index 9276fe6ceb..651aa7da54 100644
--- a/linux-user/host/arm/hostdep.h
+++ b/linux-user/host/arm/hostdep.h
@@ -9,6 +9,8 @@
  * See the COPYING file in the top-level directory.
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef ARM_HOSTDEP_H
 #define ARM_HOSTDEP_H
 
diff --git a/linux-user/host/i386/hostdep.h b/linux-user/host/i386/hostdep.h
index 073be74d87..3f5ab0163a 100644
--- a/linux-user/host/i386/hostdep.h
+++ b/linux-user/host/i386/hostdep.h
@@ -9,6 +9,8 @@
  * See the COPYING file in the top-level directory.
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef I386_HOSTDEP_H
 #define I386_HOSTDEP_H
 
diff --git a/linux-user/host/ppc64/hostdep.h b/linux-user/host/ppc64/hostdep.h
index 98979ad917..422c391c04 100644
--- a/linux-user/host/ppc64/hostdep.h
+++ b/linux-user/host/ppc64/hostdep.h
@@ -9,6 +9,8 @@
  * See the COPYING file in the top-level directory.
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef PPC64_HOSTDEP_H
 #define PPC64_HOSTDEP_H
 
diff --git a/linux-user/host/riscv64/hostdep.h b/linux-user/host/riscv64/hostdep.h
index 865f0fb9ff..18ed7677ba 100644
--- a/linux-user/host/riscv64/hostdep.h
+++ b/linux-user/host/riscv64/hostdep.h
@@ -5,6 +5,8 @@
  * See the COPYING file in the top-level directory.
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef RISCV64_HOSTDEP_H
 #define RISCV64_HOSTDEP_H
 
diff --git a/linux-user/host/s390x/hostdep.h b/linux-user/host/s390x/hostdep.h
index 4f0171f36f..81a702b931 100644
--- a/linux-user/host/s390x/hostdep.h
+++ b/linux-user/host/s390x/hostdep.h
@@ -9,6 +9,8 @@
  * See the COPYING file in the top-level directory.
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef S390X_HOSTDEP_H
 #define S390X_HOSTDEP_H
 
diff --git a/linux-user/host/x86_64/hostdep.h b/linux-user/host/x86_64/hostdep.h
index a4fefb5114..6bf3c930ce 100644
--- a/linux-user/host/x86_64/hostdep.h
+++ b/linux-user/host/x86_64/hostdep.h
@@ -9,6 +9,8 @@
  * See the COPYING file in the top-level directory.
  */
 
+/* FIXME Does not pass make check-headers without CONFIG_LINUX, yet! */
+
 #ifndef X86_64_HOSTDEP_H
 #define X86_64_HOSTDEP_H
 
diff --git a/linux-user/hppa/target_cpu.h b/linux-user/hppa/target_cpu.h
index 1c539bdbd6..75f4ef1d77 100644
--- a/linux-user/hppa/target_cpu.h
+++ b/linux-user/hppa/target_cpu.h
@@ -16,6 +16,9 @@
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
+
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef HPPA_TARGET_CPU_H
 #define HPPA_TARGET_CPU_H
 
diff --git a/linux-user/hppa/target_fcntl.h b/linux-user/hppa/target_fcntl.h
index bd966a59b8..525e0a274c 100644
--- a/linux-user/hppa/target_fcntl.h
+++ b/linux-user/hppa/target_fcntl.h
@@ -5,6 +5,9 @@
  * later version. See the COPYING file in the top-level directory.
  */
 
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef HPPA_TARGET_FCNTL_H
 #define HPPA_TARGET_FCNTL_H
 
diff --git a/linux-user/hppa/target_signal.h b/linux-user/hppa/target_signal.h
index ba159ff8d0..ba1e803d7f 100644
--- a/linux-user/hppa/target_signal.h
+++ b/linux-user/hppa/target_signal.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef HPPA_TARGET_SIGNAL_H
 #define HPPA_TARGET_SIGNAL_H
 
diff --git a/linux-user/hppa/target_structs.h b/linux-user/hppa/target_structs.h
index b560b1872b..53a0fd586f 100644
--- a/linux-user/hppa/target_structs.h
+++ b/linux-user/hppa/target_structs.h
@@ -16,6 +16,9 @@
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
+
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef HPPA_TARGET_STRUCTS_H
 #define HPPA_TARGET_STRUCTS_H
 
diff --git a/linux-user/hppa/target_syscall.h b/linux-user/hppa/target_syscall.h
index e2f366839d..1c75d62e70 100644
--- a/linux-user/hppa/target_syscall.h
+++ b/linux-user/hppa/target_syscall.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef HPPA_TARGET_SYSCALL_H
 #define HPPA_TARGET_SYSCALL_H
 
diff --git a/linux-user/hppa/termbits.h b/linux-user/hppa/termbits.h
index ad51c9c911..79e01c81bc 100644
--- a/linux-user/hppa/termbits.h
+++ b/linux-user/hppa/termbits.h
@@ -1,5 +1,7 @@
 /* from asm/termbits.h */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #define TARGET_NCCS 19
 
 struct target_termios {
diff --git a/linux-user/i386/target_cpu.h b/linux-user/i386/target_cpu.h
index ece04d0966..d012c441e6 100644
--- a/linux-user/i386/target_cpu.h
+++ b/linux-user/i386/target_cpu.h
@@ -17,6 +17,9 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef I386_TARGET_CPU_H
 #define I386_TARGET_CPU_H
 
diff --git a/linux-user/i386/target_fcntl.h b/linux-user/i386/target_fcntl.h
index 4819743dae..6b3fa9f6ee 100644
--- a/linux-user/i386/target_fcntl.h
+++ b/linux-user/i386/target_fcntl.h
@@ -5,6 +5,9 @@
  * later version. See the COPYING file in the top-level directory.
  */
 
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef I386_TARGET_FCNTL_H
 #define I386_TARGET_FCNTL_H
 #include "../generic/fcntl.h"
diff --git a/linux-user/i386/target_signal.h b/linux-user/i386/target_signal.h
index f55e78fd33..50aae79efb 100644
--- a/linux-user/i386/target_signal.h
+++ b/linux-user/i386/target_signal.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef I386_TARGET_SIGNAL_H
 #define I386_TARGET_SIGNAL_H
 
diff --git a/linux-user/i386/target_structs.h b/linux-user/i386/target_structs.h
index 25388a7fd2..23ed22dfd9 100644
--- a/linux-user/i386/target_structs.h
+++ b/linux-user/i386/target_structs.h
@@ -16,6 +16,9 @@
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
+
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef I386_TARGET_STRUCTS_H
 #define I386_TARGET_STRUCTS_H
 
diff --git a/linux-user/i386/target_syscall.h b/linux-user/i386/target_syscall.h
index 2854758134..69c30140dc 100644
--- a/linux-user/i386/target_syscall.h
+++ b/linux-user/i386/target_syscall.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef I386_TARGET_SYSCALL_H
 #define I386_TARGET_SYSCALL_H
 
diff --git a/linux-user/i386/termbits.h b/linux-user/i386/termbits.h
index 32dd0dde5d..c847ccbc4e 100644
--- a/linux-user/i386/termbits.h
+++ b/linux-user/i386/termbits.h
@@ -1,5 +1,7 @@
 /* from asm/termbits.h */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #define TARGET_NCCS 19
 
 struct target_termios {
diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
index 37501f575c..7064c71980 100644
--- a/linux-user/ioctls.h
+++ b/linux-user/ioctls.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers, yet! */
+
      /* emulated ioctl list */
 
      IOCTL(TCGETS, IOC_R, MK_PTR(MK_STRUCT(STRUCT_termios)))
diff --git a/linux-user/linux_loop.h b/linux-user/linux_loop.h
index c69fea11e4..26974c9afd 100644
--- a/linux-user/linux_loop.h
+++ b/linux-user/linux_loop.h
@@ -2,6 +2,8 @@
  * and subsequently updated to match newer additions to the API.
  */
 
+/* FIXME Does not pass make check-headers without CONFIG_LINUX, yet! */
+
 #ifndef LINUX_LOOP_H
 #define LINUX_LOOP_H
 
diff --git a/linux-user/m68k/target_cpu.h b/linux-user/m68k/target_cpu.h
index 7a26f3c3fc..414b3cbfde 100644
--- a/linux-user/m68k/target_cpu.h
+++ b/linux-user/m68k/target_cpu.h
@@ -18,6 +18,8 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef M68K_TARGET_CPU_H
 #define M68K_TARGET_CPU_H
 
diff --git a/linux-user/m68k/target_elf.h b/linux-user/m68k/target_elf.h
index 998fe0fe2f..20700e4d43 100644
--- a/linux-user/m68k/target_elf.h
+++ b/linux-user/m68k/target_elf.h
@@ -5,6 +5,8 @@
  * later version. See the COPYING file in the top-level directory.
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef M68K_TARGET_ELF_H
 #define M68K_TARGET_ELF_H
 static inline const char *cpu_get_model(uint32_t eflags)
diff --git a/linux-user/m68k/target_fcntl.h b/linux-user/m68k/target_fcntl.h
index 068bc3243e..a6a544300f 100644
--- a/linux-user/m68k/target_fcntl.h
+++ b/linux-user/m68k/target_fcntl.h
@@ -5,6 +5,9 @@
  * later version. See the COPYING file in the top-level directory.
  */
 
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef M68K_TARGET_FCNTL_H
 #define M68K_TARGET_FCNTL_H
 
diff --git a/linux-user/m68k/target_signal.h b/linux-user/m68k/target_signal.h
index 314e808844..5a5aa55c8e 100644
--- a/linux-user/m68k/target_signal.h
+++ b/linux-user/m68k/target_signal.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef M68K_TARGET_SIGNAL_H
 #define M68K_TARGET_SIGNAL_H
 
diff --git a/linux-user/m68k/target_structs.h b/linux-user/m68k/target_structs.h
index e373d481e1..382318c087 100644
--- a/linux-user/m68k/target_structs.h
+++ b/linux-user/m68k/target_structs.h
@@ -16,6 +16,9 @@
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
+
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef M68K_TARGET_STRUCTS_H
 #define M68K_TARGET_STRUCTS_H
 
diff --git a/linux-user/m68k/target_syscall.h b/linux-user/m68k/target_syscall.h
index 632ee4fcf8..501fdd7489 100644
--- a/linux-user/m68k/target_syscall.h
+++ b/linux-user/m68k/target_syscall.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef M68K_TARGET_SYSCALL_H
 #define M68K_TARGET_SYSCALL_H
 
diff --git a/linux-user/m68k/termbits.h b/linux-user/m68k/termbits.h
index 9df58dc5cb..ca9148d96f 100644
--- a/linux-user/m68k/termbits.h
+++ b/linux-user/m68k/termbits.h
@@ -1,6 +1,8 @@
 /* from asm/termbits.h */
 /* NOTE: exactly the same as i386 */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #define TARGET_NCCS 19
 
 struct target_termios {
diff --git a/linux-user/microblaze/target_cpu.h b/linux-user/microblaze/target_cpu.h
index 73e139938c..22596fbc5e 100644
--- a/linux-user/microblaze/target_cpu.h
+++ b/linux-user/microblaze/target_cpu.h
@@ -16,6 +16,9 @@
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
+
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef MICROBLAZE_TARGET_CPU_H
 #define MICROBLAZE_TARGET_CPU_H
 
diff --git a/linux-user/microblaze/target_fcntl.h b/linux-user/microblaze/target_fcntl.h
index 45402275ff..4fb61f8fbf 100644
--- a/linux-user/microblaze/target_fcntl.h
+++ b/linux-user/microblaze/target_fcntl.h
@@ -5,6 +5,9 @@
  * later version. See the COPYING file in the top-level directory.
  */
 
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef MICROBLAZE_TARGET_FCNTL_H
 #define MICROBLAZE_TARGET_FCNTL_H
 #include "../generic/fcntl.h"
diff --git a/linux-user/microblaze/target_signal.h b/linux-user/microblaze/target_signal.h
index 35efd5e928..42c9330027 100644
--- a/linux-user/microblaze/target_signal.h
+++ b/linux-user/microblaze/target_signal.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef MICROBLAZE_TARGET_SIGNAL_H
 #define MICROBLAZE_TARGET_SIGNAL_H
 
diff --git a/linux-user/microblaze/target_structs.h b/linux-user/microblaze/target_structs.h
index 70dbdb6101..4ff62a6c66 100644
--- a/linux-user/microblaze/target_structs.h
+++ b/linux-user/microblaze/target_structs.h
@@ -16,6 +16,9 @@
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
+
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef MICROBLAZE_TARGET_STRUCTS_H
 #define MICROBLAZE_TARGET_STRUCTS_H
 
diff --git a/linux-user/microblaze/termbits.h b/linux-user/microblaze/termbits.h
index c825cd2f5e..e0adbcbea3 100644
--- a/linux-user/microblaze/termbits.h
+++ b/linux-user/microblaze/termbits.h
@@ -1,5 +1,7 @@
 /* from asm/termbits.h */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #define TARGET_NCCS 19
 
 struct target_termios {
diff --git a/linux-user/mips/target_cpu.h b/linux-user/mips/target_cpu.h
index 02cf5eeff7..6b65b4e0b8 100644
--- a/linux-user/mips/target_cpu.h
+++ b/linux-user/mips/target_cpu.h
@@ -16,6 +16,9 @@
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
+
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef MIPS_TARGET_CPU_H
 #define MIPS_TARGET_CPU_H
 
diff --git a/linux-user/mips/target_elf.h b/linux-user/mips/target_elf.h
index a98c9bd6ad..2d5f74622e 100644
--- a/linux-user/mips/target_elf.h
+++ b/linux-user/mips/target_elf.h
@@ -5,6 +5,8 @@
  * later version. See the COPYING file in the top-level directory.
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef MIPS_TARGET_ELF_H
 #define MIPS_TARGET_ELF_H
 static inline const char *cpu_get_model(uint32_t eflags)
diff --git a/linux-user/mips/target_fcntl.h b/linux-user/mips/target_fcntl.h
index 000527cc95..da6960a7f9 100644
--- a/linux-user/mips/target_fcntl.h
+++ b/linux-user/mips/target_fcntl.h
@@ -5,6 +5,9 @@
  * later version. See the COPYING file in the top-level directory.
  */
 
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef MIPS_TARGET_FCNTL_H
 #define MIPS_TARGET_FCNTL_H
 
diff --git a/linux-user/mips/target_signal.h b/linux-user/mips/target_signal.h
index 66e1ad44a6..db7793b655 100644
--- a/linux-user/mips/target_signal.h
+++ b/linux-user/mips/target_signal.h
@@ -1,3 +1,6 @@
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef MIPS_TARGET_SIGNAL_H
 #define MIPS_TARGET_SIGNAL_H
 
diff --git a/linux-user/mips/target_structs.h b/linux-user/mips/target_structs.h
index 909ba89708..54b52dc7e9 100644
--- a/linux-user/mips/target_structs.h
+++ b/linux-user/mips/target_structs.h
@@ -16,6 +16,9 @@
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
+
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef MIPS_TARGET_STRUCTS_H
 #define MIPS_TARGET_STRUCTS_H
 
diff --git a/linux-user/mips/target_syscall.h b/linux-user/mips/target_syscall.h
index d5509a34a7..3b170bd55c 100644
--- a/linux-user/mips/target_syscall.h
+++ b/linux-user/mips/target_syscall.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef MIPS_TARGET_SYSCALL_H
 #define MIPS_TARGET_SYSCALL_H
 
diff --git a/linux-user/mips/termbits.h b/linux-user/mips/termbits.h
index 49a72c5539..52e8c50b9c 100644
--- a/linux-user/mips/termbits.h
+++ b/linux-user/mips/termbits.h
@@ -1,5 +1,7 @@
 /* from asm/termbits.h */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #define TARGET_NCCS 23
 
 struct target_termios {
diff --git a/linux-user/mips64/syscall_nr.h b/linux-user/mips64/syscall_nr.h
index ff218a9bf2..00baedafd2 100644
--- a/linux-user/mips64/syscall_nr.h
+++ b/linux-user/mips64/syscall_nr.h
@@ -1,3 +1,5 @@
+/* NOTE: May only be included into target-dependent code */
+
 #ifdef TARGET_ABI32
 /*
  * Linux N32 syscalls are in the range from 6000 to 6999.
diff --git a/linux-user/mips64/target_cpu.h b/linux-user/mips64/target_cpu.h
index f16991b4ef..147298dfba 100644
--- a/linux-user/mips64/target_cpu.h
+++ b/linux-user/mips64/target_cpu.h
@@ -16,4 +16,7 @@
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
+
+/* FIXME Does not pass make check-headers, yet! */
+
 #include "../mips/target_cpu.h"
diff --git a/linux-user/mips64/target_elf.h b/linux-user/mips64/target_elf.h
index ec55d8542a..35314aea5a 100644
--- a/linux-user/mips64/target_elf.h
+++ b/linux-user/mips64/target_elf.h
@@ -5,6 +5,8 @@
  * later version. See the COPYING file in the top-level directory.
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef MIPS64_TARGET_ELF_H
 #define MIPS64_TARGET_ELF_H
 static inline const char *cpu_get_model(uint32_t eflags)
diff --git a/linux-user/mips64/target_fcntl.h b/linux-user/mips64/target_fcntl.h
index a511bc0e6c..32a53ad84a 100644
--- a/linux-user/mips64/target_fcntl.h
+++ b/linux-user/mips64/target_fcntl.h
@@ -1 +1,4 @@
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #include "../mips/target_fcntl.h"
diff --git a/linux-user/mips64/target_signal.h b/linux-user/mips64/target_signal.h
index 753e91fbd6..145e604c0a 100644
--- a/linux-user/mips64/target_signal.h
+++ b/linux-user/mips64/target_signal.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef MIPS64_TARGET_SIGNAL_H
 #define MIPS64_TARGET_SIGNAL_H
 
diff --git a/linux-user/mips64/target_structs.h b/linux-user/mips64/target_structs.h
index a4f619e732..7fe2baa0c6 100644
--- a/linux-user/mips64/target_structs.h
+++ b/linux-user/mips64/target_structs.h
@@ -1,2 +1,4 @@
+/* FIXME Does not pass make check-headers, yet! */
+
 #include "../mips/target_structs.h"
 
diff --git a/linux-user/mips64/target_syscall.h b/linux-user/mips64/target_syscall.h
index 8ccc46822c..7c3541a7ba 100644
--- a/linux-user/mips64/target_syscall.h
+++ b/linux-user/mips64/target_syscall.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef MIPS64_TARGET_SYSCALL_H
 #define MIPS64_TARGET_SYSCALL_H
 
diff --git a/linux-user/mips64/termbits.h b/linux-user/mips64/termbits.h
index d0a271e1d4..5ebeca4615 100644
--- a/linux-user/mips64/termbits.h
+++ b/linux-user/mips64/termbits.h
@@ -1,2 +1,4 @@
+/* FIXME Does not pass make check-headers, yet! */
+
 #include "../mips/termbits.h"
 
diff --git a/linux-user/nios2/target_cpu.h b/linux-user/nios2/target_cpu.h
index 5596c05c9c..8f1684c66a 100644
--- a/linux-user/nios2/target_cpu.h
+++ b/linux-user/nios2/target_cpu.h
@@ -17,6 +17,8 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef NIOS2_TARGET_CPU_H
 #define NIOS2_TARGET_CPU_H
 
diff --git a/linux-user/nios2/target_fcntl.h b/linux-user/nios2/target_fcntl.h
index 714583215d..2dd93b5c35 100644
--- a/linux-user/nios2/target_fcntl.h
+++ b/linux-user/nios2/target_fcntl.h
@@ -5,6 +5,9 @@
  * later version. See the COPYING file in the top-level directory.
  */
 
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef NIOS2_TARGET_FCNTL_H
 #define NIOS2_TARGET_FCNTL_H
 #include "../generic/fcntl.h"
diff --git a/linux-user/nios2/target_signal.h b/linux-user/nios2/target_signal.h
index fe48721b3d..c1f738de74 100644
--- a/linux-user/nios2/target_signal.h
+++ b/linux-user/nios2/target_signal.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef NIOS2_TARGET_SIGNAL_H
 #define NIOS2_TARGET_SIGNAL_H
 
diff --git a/linux-user/nios2/target_structs.h b/linux-user/nios2/target_structs.h
index 7145251706..321e19e00c 100644
--- a/linux-user/nios2/target_structs.h
+++ b/linux-user/nios2/target_structs.h
@@ -16,6 +16,9 @@
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
+
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef NIOS2_TARGET_STRUCTS_H
 #define NIOS2_TARGET_STRUCTS_H
 
diff --git a/linux-user/nios2/termbits.h b/linux-user/nios2/termbits.h
index f9f80f0f37..31cfbd45f7 100644
--- a/linux-user/nios2/termbits.h
+++ b/linux-user/nios2/termbits.h
@@ -1,6 +1,8 @@
 /* from asm/termbits.h */
 /* NOTE: exactly the same as i386 */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #define TARGET_NCCS 19
 
 struct target_termios {
diff --git a/linux-user/openrisc/target_cpu.h b/linux-user/openrisc/target_cpu.h
index 32ff135089..0df79d5b57 100644
--- a/linux-user/openrisc/target_cpu.h
+++ b/linux-user/openrisc/target_cpu.h
@@ -17,6 +17,8 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef OPENRISC_TARGET_CPU_H
 #define OPENRISC_TARGET_CPU_H
 
diff --git a/linux-user/openrisc/target_fcntl.h b/linux-user/openrisc/target_fcntl.h
index ea31bf8b70..b060418765 100644
--- a/linux-user/openrisc/target_fcntl.h
+++ b/linux-user/openrisc/target_fcntl.h
@@ -5,6 +5,9 @@
  * later version. See the COPYING file in the top-level directory.
  */
 
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef OPENRISC_TARGET_FCNTL_H
 #define OPENRISC_TARGET_FCNTL_H
 #include "../generic/fcntl.h"
diff --git a/linux-user/openrisc/target_signal.h b/linux-user/openrisc/target_signal.h
index 8283eaf544..b246e36c35 100644
--- a/linux-user/openrisc/target_signal.h
+++ b/linux-user/openrisc/target_signal.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef OPENRISC_TARGET_SIGNAL_H
 #define OPENRISC_TARGET_SIGNAL_H
 
diff --git a/linux-user/openrisc/target_structs.h b/linux-user/openrisc/target_structs.h
index e98e2bc799..143c8ed08b 100644
--- a/linux-user/openrisc/target_structs.h
+++ b/linux-user/openrisc/target_structs.h
@@ -16,6 +16,9 @@
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
+
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef OPENRISC_TARGET_STRUCTS_H
 #define OPENRISC_TARGET_STRUCTS_H
 
diff --git a/linux-user/openrisc/target_syscall.h b/linux-user/openrisc/target_syscall.h
index d586d2a018..ec88f20bac 100644
--- a/linux-user/openrisc/target_syscall.h
+++ b/linux-user/openrisc/target_syscall.h
@@ -1,3 +1,6 @@
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef OPENRISC_TARGET_SYSCALL_H
 #define OPENRISC_TARGET_SYSCALL_H
 
diff --git a/linux-user/openrisc/termbits.h b/linux-user/openrisc/termbits.h
index 231a49806b..596907f739 100644
--- a/linux-user/openrisc/termbits.h
+++ b/linux-user/openrisc/termbits.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers, yet! */
+
 typedef unsigned char   target_openrisc_cc;        /*cc_t*/
 typedef unsigned int    target_openrisc_speed;     /*speed_t*/
 typedef unsigned int    target_openrisc_tcflag;    /*tcflag_t*/
diff --git a/linux-user/ppc/syscall_nr.h b/linux-user/ppc/syscall_nr.h
index afa36544f1..ce3b7d0f18 100644
--- a/linux-user/ppc/syscall_nr.h
+++ b/linux-user/ppc/syscall_nr.h
@@ -1,6 +1,9 @@
 /*
  * This file contains the system call numbers.
  */
+
+/* NOTE: May only be included into target-dependent code */
+
 #define TARGET_NR_restart_syscall          0
 #define TARGET_NR_exit                     1
 #define TARGET_NR_fork                     2
diff --git a/linux-user/ppc/target_cpu.h b/linux-user/ppc/target_cpu.h
index c4641834e7..89024759a6 100644
--- a/linux-user/ppc/target_cpu.h
+++ b/linux-user/ppc/target_cpu.h
@@ -16,6 +16,10 @@
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
+
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef PPC_TARGET_CPU_H
 #define PPC_TARGET_CPU_H
 
diff --git a/linux-user/ppc/target_elf.h b/linux-user/ppc/target_elf.h
index 576a5b9959..a5d4999c06 100644
--- a/linux-user/ppc/target_elf.h
+++ b/linux-user/ppc/target_elf.h
@@ -5,6 +5,8 @@
  * later version. See the COPYING file in the top-level directory.
  */
 
+/* NOTE: May only be included into target-dependent code */
+
 #ifndef PPC_TARGET_ELF_H
 #define PPC_TARGET_ELF_H
 static inline const char *cpu_get_model(uint32_t eflags)
diff --git a/linux-user/ppc/target_fcntl.h b/linux-user/ppc/target_fcntl.h
index d74ab710cf..b11e87c035 100644
--- a/linux-user/ppc/target_fcntl.h
+++ b/linux-user/ppc/target_fcntl.h
@@ -5,6 +5,9 @@
  * later version. See the COPYING file in the top-level directory.
  */
 
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef PPC_TARGET_FCNTL_H
 #define PPC_TARGET_FCNTL_H
 
diff --git a/linux-user/ppc/target_signal.h b/linux-user/ppc/target_signal.h
index 4453e2e7ef..2b0add1585 100644
--- a/linux-user/ppc/target_signal.h
+++ b/linux-user/ppc/target_signal.h
@@ -1,3 +1,6 @@
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef PPC_TARGET_SIGNAL_H
 #define PPC_TARGET_SIGNAL_H
 
diff --git a/linux-user/ppc/target_structs.h b/linux-user/ppc/target_structs.h
index 6b1f5791a9..0cb7145b8a 100644
--- a/linux-user/ppc/target_structs.h
+++ b/linux-user/ppc/target_structs.h
@@ -16,6 +16,9 @@
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
+
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef PPC_TARGET_STRUCTS_H
 #define PPC_TARGET_STRUCTS_H
 
diff --git a/linux-user/ppc/target_syscall.h b/linux-user/ppc/target_syscall.h
index afc0570410..0a0b88fd6c 100644
--- a/linux-user/ppc/target_syscall.h
+++ b/linux-user/ppc/target_syscall.h
@@ -17,6 +17,9 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef PPC_TARGET_SYSCALL_H
 #define PPC_TARGET_SYSCALL_H
 
diff --git a/linux-user/ppc/termbits.h b/linux-user/ppc/termbits.h
index a5b1bb783b..742a4a9424 100644
--- a/linux-user/ppc/termbits.h
+++ b/linux-user/ppc/termbits.h
@@ -1,5 +1,7 @@
 /* from asm/termbits.h */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #define TARGET_NCCS 19
 
 struct target_termios {
diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index ef400cb78a..7518fe666b 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef QEMU_H
 #define QEMU_H
 
diff --git a/linux-user/riscv/target_cpu.h b/linux-user/riscv/target_cpu.h
index 90f9a4171e..86facc5e3a 100644
--- a/linux-user/riscv/target_cpu.h
+++ b/linux-user/riscv/target_cpu.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef RISCV_TARGET_CPU_H
 #define RISCV_TARGET_CPU_H
 
diff --git a/linux-user/riscv/target_fcntl.h b/linux-user/riscv/target_fcntl.h
index 9c3d0fbe2b..a830bf536a 100644
--- a/linux-user/riscv/target_fcntl.h
+++ b/linux-user/riscv/target_fcntl.h
@@ -5,6 +5,9 @@
  * later version. See the COPYING file in the top-level directory.
  */
 
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef RISCV_TARGET_FCNTL_H
 #define RISCV_TARGET_FCNTL_H
 #include "../generic/fcntl.h"
diff --git a/linux-user/riscv/target_signal.h b/linux-user/riscv/target_signal.h
index f113ba9a55..d4e14a3074 100644
--- a/linux-user/riscv/target_signal.h
+++ b/linux-user/riscv/target_signal.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef RISCV_TARGET_SIGNAL_H
 #define RISCV_TARGET_SIGNAL_H
 
diff --git a/linux-user/riscv/target_structs.h b/linux-user/riscv/target_structs.h
index ea3e5ed17e..7d8dff7a33 100644
--- a/linux-user/riscv/target_structs.h
+++ b/linux-user/riscv/target_structs.h
@@ -4,6 +4,9 @@
  * This is a copy of ../aarch64/target_structs.h atm.
  *
  */
+
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef RISCV_TARGET_STRUCTS_H
 #define RISCV_TARGET_STRUCTS_H
 
diff --git a/linux-user/riscv/target_syscall.h b/linux-user/riscv/target_syscall.h
index ee81d8bc88..6374d09839 100644
--- a/linux-user/riscv/target_syscall.h
+++ b/linux-user/riscv/target_syscall.h
@@ -5,6 +5,8 @@
  * Reference: linux/arch/riscv/include/uapi/asm/ptrace.h
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 struct target_pt_regs {
     abi_long sepc;
     abi_long ra;
diff --git a/linux-user/riscv/termbits.h b/linux-user/riscv/termbits.h
index 7e4e230588..62784abfc3 100644
--- a/linux-user/riscv/termbits.h
+++ b/linux-user/riscv/termbits.h
@@ -1,6 +1,8 @@
 /* from asm/termbits.h */
 /* NOTE: exactly the same as i386 */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #define TARGET_NCCS 19
 
 struct target_termios {
diff --git a/linux-user/s390x/syscall_nr.h b/linux-user/s390x/syscall_nr.h
index 1a66c5561d..dea18ec37a 100644
--- a/linux-user/s390x/syscall_nr.h
+++ b/linux-user/s390x/syscall_nr.h
@@ -2,6 +2,8 @@
  * This file contains the system call numbers.
  */
 
+/* NOTE: May only be included into target-dependent code */
+
 #define TARGET_NR_exit                 1
 #define TARGET_NR_fork                 2
 #define TARGET_NR_read                 3
diff --git a/linux-user/s390x/target_cpu.h b/linux-user/s390x/target_cpu.h
index aa181ceaee..f10770c33e 100644
--- a/linux-user/s390x/target_cpu.h
+++ b/linux-user/s390x/target_cpu.h
@@ -16,6 +16,9 @@
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
+
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef S390X_TARGET_CPU_H
 #define S390X_TARGET_CPU_H
 
diff --git a/linux-user/s390x/target_fcntl.h b/linux-user/s390x/target_fcntl.h
index 36dc50fba0..bd918aafac 100644
--- a/linux-user/s390x/target_fcntl.h
+++ b/linux-user/s390x/target_fcntl.h
@@ -5,6 +5,9 @@
  * later version. See the COPYING file in the top-level directory.
  */
 
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef S390X_TARGET_FCNTL_H
 #define S390X_TARGET_FCNTL_H
 #include "../generic/fcntl.h"
diff --git a/linux-user/s390x/target_signal.h b/linux-user/s390x/target_signal.h
index b58bc7c20f..a4c6bebe2c 100644
--- a/linux-user/s390x/target_signal.h
+++ b/linux-user/s390x/target_signal.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef S390X_TARGET_SIGNAL_H
 #define S390X_TARGET_SIGNAL_H
 
diff --git a/linux-user/s390x/target_structs.h b/linux-user/s390x/target_structs.h
index cadff6db3d..1d8f975361 100644
--- a/linux-user/s390x/target_structs.h
+++ b/linux-user/s390x/target_structs.h
@@ -16,6 +16,9 @@
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
+
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef S390X_TARGET_STRUCTS_H
 #define S390X_TARGET_STRUCTS_H
 
diff --git a/linux-user/s390x/target_syscall.h b/linux-user/s390x/target_syscall.h
index 8d4f609eaa..c52471ef21 100644
--- a/linux-user/s390x/target_syscall.h
+++ b/linux-user/s390x/target_syscall.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef S390X_TARGET_SYSCALL_H
 #define S390X_TARGET_SYSCALL_H
 
diff --git a/linux-user/s390x/termbits.h b/linux-user/s390x/termbits.h
index 8bcca89cd7..2c2a3d6972 100644
--- a/linux-user/s390x/termbits.h
+++ b/linux-user/s390x/termbits.h
@@ -6,6 +6,8 @@
  *  Derived from "include/asm-i386/termbits.h"
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #define TARGET_NCCS 19
 struct target_termios {
     unsigned int c_iflag;		/* input mode flags */
diff --git a/linux-user/sh4/target_cpu.h b/linux-user/sh4/target_cpu.h
index b0be9a2c1b..8e90aa30b3 100644
--- a/linux-user/sh4/target_cpu.h
+++ b/linux-user/sh4/target_cpu.h
@@ -16,6 +16,9 @@
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
+
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef SH4_TARGET_CPU_H
 #define SH4_TARGET_CPU_H
 
diff --git a/linux-user/sh4/target_fcntl.h b/linux-user/sh4/target_fcntl.h
index 2622d95539..478ea0ec76 100644
--- a/linux-user/sh4/target_fcntl.h
+++ b/linux-user/sh4/target_fcntl.h
@@ -5,6 +5,9 @@
  * later version. See the COPYING file in the top-level directory.
  */
 
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef SH4_TARGET_FCNTL_H
 #define SH4_TARGET_FCNTL_H
 #include "../generic/fcntl.h"
diff --git a/linux-user/sh4/target_signal.h b/linux-user/sh4/target_signal.h
index 434970a990..ca9b216491 100644
--- a/linux-user/sh4/target_signal.h
+++ b/linux-user/sh4/target_signal.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef SH4_TARGET_SIGNAL_H
 #define SH4_TARGET_SIGNAL_H
 
diff --git a/linux-user/sh4/target_structs.h b/linux-user/sh4/target_structs.h
index 00ac39478b..e4fcfe6f46 100644
--- a/linux-user/sh4/target_structs.h
+++ b/linux-user/sh4/target_structs.h
@@ -16,6 +16,9 @@
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
+
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef SH4_TARGET_STRUCTS_H
 #define SH4_TARGET_STRUCTS_H
 
diff --git a/linux-user/sh4/target_syscall.h b/linux-user/sh4/target_syscall.h
index 2b5f75be13..39e11cdc5b 100644
--- a/linux-user/sh4/target_syscall.h
+++ b/linux-user/sh4/target_syscall.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef SH4_TARGET_SYSCALL_H
 #define SH4_TARGET_SYSCALL_H
 
diff --git a/linux-user/sh4/termbits.h b/linux-user/sh4/termbits.h
index 5723ed7752..c3a18d954a 100644
--- a/linux-user/sh4/termbits.h
+++ b/linux-user/sh4/termbits.h
@@ -1,5 +1,7 @@
 /* from asm/termbits.h */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #define TARGET_NCCS 19
 
 struct target_termios {
diff --git a/linux-user/signal-common.h b/linux-user/signal-common.h
index 51030a9306..68e8bc35fe 100644
--- a/linux-user/signal-common.h
+++ b/linux-user/signal-common.h
@@ -17,6 +17,9 @@
  *  along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef SIGNAL_COMMON_H
 #define SIGNAL_COMMON_H
 extern struct target_sigaltstack target_sigaltstack_used;
diff --git a/linux-user/socket.h b/linux-user/socket.h
index 4c0b5c2dfa..3de90d7c6c 100644
--- a/linux-user/socket.h
+++ b/linux-user/socket.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers, yet! */
+
 #include "sockbits.h"
 
 #ifndef TARGET_ARCH_HAS_SOCKET_TYPES
diff --git a/linux-user/sparc/target_cpu.h b/linux-user/sparc/target_cpu.h
index 1ffc0ae9f2..436bfce0d4 100644
--- a/linux-user/sparc/target_cpu.h
+++ b/linux-user/sparc/target_cpu.h
@@ -17,6 +17,10 @@
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
+
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef SPARC_TARGET_CPU_H
 #define SPARC_TARGET_CPU_H
 
diff --git a/linux-user/sparc/target_elf.h b/linux-user/sparc/target_elf.h
index a510ceb612..58f6c395a9 100644
--- a/linux-user/sparc/target_elf.h
+++ b/linux-user/sparc/target_elf.h
@@ -5,6 +5,8 @@
  * later version. See the COPYING file in the top-level directory.
  */
 
+/* NOTE: May only be included into target-dependent code */
+
 #ifndef SPARC_TARGET_ELF_H
 #define SPARC_TARGET_ELF_H
 static inline const char *cpu_get_model(uint32_t eflags)
diff --git a/linux-user/sparc/target_fcntl.h b/linux-user/sparc/target_fcntl.h
index c2532989e5..d6afb73fae 100644
--- a/linux-user/sparc/target_fcntl.h
+++ b/linux-user/sparc/target_fcntl.h
@@ -5,6 +5,9 @@
  * later version. See the COPYING file in the top-level directory.
  */
 
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef SPARC_TARGET_FCNTL_H
 #define SPARC_TARGET_FCNTL_H
 
diff --git a/linux-user/sparc/target_signal.h b/linux-user/sparc/target_signal.h
index 5cc40327d2..2a435f3250 100644
--- a/linux-user/sparc/target_signal.h
+++ b/linux-user/sparc/target_signal.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef SPARC_TARGET_SIGNAL_H
 #define SPARC_TARGET_SIGNAL_H
 
diff --git a/linux-user/sparc/target_structs.h b/linux-user/sparc/target_structs.h
index ee24c3b5fc..3a20ea7afe 100644
--- a/linux-user/sparc/target_structs.h
+++ b/linux-user/sparc/target_structs.h
@@ -16,6 +16,9 @@
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
+
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef SPARC_TARGET_STRUCTS_H
 #define SPARC_TARGET_STRUCTS_H
 
diff --git a/linux-user/sparc/target_syscall.h b/linux-user/sparc/target_syscall.h
index b9160a771b..cf03c33413 100644
--- a/linux-user/sparc/target_syscall.h
+++ b/linux-user/sparc/target_syscall.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef SPARC_TARGET_SYSCALL_H
 #define SPARC_TARGET_SYSCALL_H
 
diff --git a/linux-user/sparc/termbits.h b/linux-user/sparc/termbits.h
index 113d6dfbdb..60f347a049 100644
--- a/linux-user/sparc/termbits.h
+++ b/linux-user/sparc/termbits.h
@@ -1,5 +1,7 @@
 /* from asm/termbits.h */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #define TARGET_NCCS 19
 
 struct target_termios {
diff --git a/linux-user/sparc64/target_cpu.h b/linux-user/sparc64/target_cpu.h
index b22263d2db..e7a25b4b46 100644
--- a/linux-user/sparc64/target_cpu.h
+++ b/linux-user/sparc64/target_cpu.h
@@ -1 +1,4 @@
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #include "../sparc/target_cpu.h"
diff --git a/linux-user/sparc64/target_fcntl.h b/linux-user/sparc64/target_fcntl.h
index 053c774257..3cad57fdc4 100644
--- a/linux-user/sparc64/target_fcntl.h
+++ b/linux-user/sparc64/target_fcntl.h
@@ -1 +1,4 @@
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #include "../sparc/target_fcntl.h"
diff --git a/linux-user/sparc64/target_signal.h b/linux-user/sparc64/target_signal.h
index 6a7d57d024..f6ec4304e1 100644
--- a/linux-user/sparc64/target_signal.h
+++ b/linux-user/sparc64/target_signal.h
@@ -1 +1,3 @@
+/* FIXME Does not pass make check-headers, yet! */
+
 #include "../sparc/target_signal.h"
diff --git a/linux-user/sparc64/target_structs.h b/linux-user/sparc64/target_structs.h
index 1808132b18..c13fa84c12 100644
--- a/linux-user/sparc64/target_structs.h
+++ b/linux-user/sparc64/target_structs.h
@@ -16,6 +16,9 @@
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
+
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef SPARC64_TARGET_STRUCTS_H
 #define SPARC64_TARGET_STRUCTS_H
 
diff --git a/linux-user/sparc64/target_syscall.h b/linux-user/sparc64/target_syscall.h
index 3073a23e03..e5f9a07a68 100644
--- a/linux-user/sparc64/target_syscall.h
+++ b/linux-user/sparc64/target_syscall.h
@@ -1,3 +1,6 @@
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef SPARC64_TARGET_SYSCALL_H
 #define SPARC64_TARGET_SYSCALL_H
 
diff --git a/linux-user/sparc64/termbits.h b/linux-user/sparc64/termbits.h
index 113d6dfbdb..60f347a049 100644
--- a/linux-user/sparc64/termbits.h
+++ b/linux-user/sparc64/termbits.h
@@ -1,5 +1,7 @@
 /* from asm/termbits.h */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #define TARGET_NCCS 19
 
 struct target_termios {
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 1f5b2d18db..edc43ede91 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -4,6 +4,8 @@
    most of them stay the same, so we handle it by putting ifdefs if
    necessary */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef SYSCALL_DEFS_H
 #define SYSCALL_DEFS_H
 
diff --git a/linux-user/syscall_types.h b/linux-user/syscall_types.h
index b98a23b0f1..3388bdc8de 100644
--- a/linux-user/syscall_types.h
+++ b/linux-user/syscall_types.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers, yet! */
+
 STRUCT_SPECIAL(termios)
 
 STRUCT(winsize,
diff --git a/linux-user/tilegx/target_cpu.h b/linux-user/tilegx/target_cpu.h
index d1aa5824f2..0576da5ec5 100644
--- a/linux-user/tilegx/target_cpu.h
+++ b/linux-user/tilegx/target_cpu.h
@@ -16,6 +16,9 @@
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
+
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef TILEGX_TARGET_CPU_H
 #define TILEGX_TARGET_CPU_H
 
diff --git a/linux-user/tilegx/target_fcntl.h b/linux-user/tilegx/target_fcntl.h
index 5ed7438459..f8b93fcaf7 100644
--- a/linux-user/tilegx/target_fcntl.h
+++ b/linux-user/tilegx/target_fcntl.h
@@ -5,6 +5,9 @@
  * later version. See the COPYING file in the top-level directory.
  */
 
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef TILEGX_TARGET_FCNTL_H
 #define TILEGX_TARGET_FCNTL_H
 #include "../generic/fcntl.h"
diff --git a/linux-user/tilegx/target_signal.h b/linux-user/tilegx/target_signal.h
index 655be13009..9527ef265c 100644
--- a/linux-user/tilegx/target_signal.h
+++ b/linux-user/tilegx/target_signal.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef TILEGX_TARGET_SIGNAL_H
 #define TILEGX_TARGET_SIGNAL_H
 
diff --git a/linux-user/tilegx/target_structs.h b/linux-user/tilegx/target_structs.h
index de8b1f2f45..aa4556ae6f 100644
--- a/linux-user/tilegx/target_structs.h
+++ b/linux-user/tilegx/target_structs.h
@@ -16,6 +16,9 @@
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
+
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef TILEGX_TARGET_STRUCTS_H
 #define TILEGX_TARGET_STRUCTS_H
 
diff --git a/linux-user/tilegx/target_syscall.h b/linux-user/tilegx/target_syscall.h
index d731acdafa..453c1501b4 100644
--- a/linux-user/tilegx/target_syscall.h
+++ b/linux-user/tilegx/target_syscall.h
@@ -1,3 +1,5 @@
+/* NOTE: May only be included into target-dependent code */
+
 #ifndef TILEGX_TARGET_SYSCALL_H
 #define TILEGX_TARGET_SYSCALL_H
 
diff --git a/linux-user/uname.h b/linux-user/uname.h
index 4503094211..e0f4dc920f 100644
--- a/linux-user/uname.h
+++ b/linux-user/uname.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers without CONFIG_LINUX, yet! */
+
 #ifndef UNAME_H
 #define UNAME_H
 
diff --git a/linux-user/x86_64/target_cpu.h b/linux-user/x86_64/target_cpu.h
index 9ec7cbb7a4..3d451086d8 100644
--- a/linux-user/x86_64/target_cpu.h
+++ b/linux-user/x86_64/target_cpu.h
@@ -1 +1,4 @@
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #include "../i386/target_cpu.h"
diff --git a/linux-user/x86_64/target_fcntl.h b/linux-user/x86_64/target_fcntl.h
index 3c7238e56b..102c4938fa 100644
--- a/linux-user/x86_64/target_fcntl.h
+++ b/linux-user/x86_64/target_fcntl.h
@@ -5,6 +5,9 @@
  * later version. See the COPYING file in the top-level directory.
  */
 
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef X86_64_TARGET_FCNTL_H
 #define X86_64_TARGET_FCNTL_H
 #include "../generic/fcntl.h"
diff --git a/linux-user/x86_64/target_signal.h b/linux-user/x86_64/target_signal.h
index 4c4380f7b9..5607f4c301 100644
--- a/linux-user/x86_64/target_signal.h
+++ b/linux-user/x86_64/target_signal.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef X86_64_TARGET_SIGNAL_H
 #define X86_64_TARGET_SIGNAL_H
 
diff --git a/linux-user/x86_64/target_structs.h b/linux-user/x86_64/target_structs.h
index b6e82a822c..2a1c29f91b 100644
--- a/linux-user/x86_64/target_structs.h
+++ b/linux-user/x86_64/target_structs.h
@@ -16,6 +16,9 @@
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
+
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef X86_64_TARGET_STRUCTS_H
 #define X86_64_TARGET_STRUCTS_H
 
diff --git a/linux-user/x86_64/target_syscall.h b/linux-user/x86_64/target_syscall.h
index 5e221e1d9d..f44d3d999a 100644
--- a/linux-user/x86_64/target_syscall.h
+++ b/linux-user/x86_64/target_syscall.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef X86_64_TARGET_SYSCALL_H
 #define X86_64_TARGET_SYSCALL_H
 
diff --git a/linux-user/x86_64/termbits.h b/linux-user/x86_64/termbits.h
index f5776a8aa6..b51885c130 100644
--- a/linux-user/x86_64/termbits.h
+++ b/linux-user/x86_64/termbits.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers, yet! */
+
 #define TARGET_NCCS 19
 
 typedef unsigned char	target_cc_t;
diff --git a/linux-user/xtensa/target_cpu.h b/linux-user/xtensa/target_cpu.h
index e31efe3ea0..935702c66b 100644
--- a/linux-user/xtensa/target_cpu.h
+++ b/linux-user/xtensa/target_cpu.h
@@ -1,6 +1,9 @@
 /*
  * Xtensa-specific CPU ABI and functions for linux-user
  */
+
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef XTENSA_TARGET_CPU_H
 #define XTENSA_TARGET_CPU_H
 
diff --git a/linux-user/xtensa/target_elf.h b/linux-user/xtensa/target_elf.h
index a9a3fabd89..a23e73cd77 100644
--- a/linux-user/xtensa/target_elf.h
+++ b/linux-user/xtensa/target_elf.h
@@ -5,6 +5,8 @@
  * later version. See the COPYING file in the top-level directory.
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef XTENSA_TARGET_ELF_H
 #define XTENSA_TARGET_ELF_H
 
diff --git a/linux-user/xtensa/target_fcntl.h b/linux-user/xtensa/target_fcntl.h
index dc1ca7eaa5..42f5e904c5 100644
--- a/linux-user/xtensa/target_fcntl.h
+++ b/linux-user/xtensa/target_fcntl.h
@@ -5,6 +5,9 @@
  * later version. See the COPYING file in the top-level directory.
  */
 
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef XTENSA_TARGET_FCNTL_H
 #define XTENSA_TARGET_FCNTL_H
 #include "../generic/fcntl.h"
diff --git a/linux-user/xtensa/target_signal.h b/linux-user/xtensa/target_signal.h
index c60bf656f6..1abcf6fbb3 100644
--- a/linux-user/xtensa/target_signal.h
+++ b/linux-user/xtensa/target_signal.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef XTENSA_TARGET_SIGNAL_H
 #define XTENSA_TARGET_SIGNAL_H
 
diff --git a/linux-user/xtensa/target_structs.h b/linux-user/xtensa/target_structs.h
index 9cde6844b8..ce34cdfca9 100644
--- a/linux-user/xtensa/target_structs.h
+++ b/linux-user/xtensa/target_structs.h
@@ -1,3 +1,6 @@
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef XTENSA_TARGET_STRUCTS_H
 #define XTENSA_TARGET_STRUCTS_H
 
diff --git a/linux-user/xtensa/target_syscall.h b/linux-user/xtensa/target_syscall.h
index 3866dad849..3ef626ee48 100644
--- a/linux-user/xtensa/target_syscall.h
+++ b/linux-user/xtensa/target_syscall.h
@@ -1,3 +1,5 @@
+/* NOTE: May only be included into target-dependent code */
+
 #ifndef XTENSA_TARGET_SYSCALL_H
 #define XTENSA_TARGET_SYSCALL_H
 
diff --git a/linux-user/xtensa/termbits.h b/linux-user/xtensa/termbits.h
index d1e09e61a6..6a8eadad8c 100644
--- a/linux-user/xtensa/termbits.h
+++ b/linux-user/xtensa/termbits.h
@@ -10,6 +10,8 @@
  * Copyright (C) 2001 - 2005 Tensilica Inc.
  */
 
+/* FIXME Does not pass make check-headers without CONFIG_LINUX, yet! */
+
 #ifndef XTENSA_TERMBITS_H
 #define XTENSA_TERMBITS_H
 
diff --git a/migration/postcopy-ram.h b/migration/postcopy-ram.h
index 9d55536fd1..a8729631f4 100644
--- a/migration/postcopy-ram.h
+++ b/migration/postcopy-ram.h
@@ -10,6 +10,9 @@
  * See the COPYING file in the top-level directory.
  *
  */
+
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef QEMU_POSTCOPY_RAM_H
 #define QEMU_POSTCOPY_RAM_H
 
diff --git a/migration/qemu-file.h b/migration/qemu-file.h
index 13baf896bd..1107d9dbc3 100644
--- a/migration/qemu-file.h
+++ b/migration/qemu-file.h
@@ -22,6 +22,8 @@
  * THE SOFTWARE.
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef MIGRATION_QEMU_FILE_H
 #define MIGRATION_QEMU_FILE_H
 
diff --git a/net/colo-compare.h b/net/colo-compare.h
index 22ddd512e2..1ad6583dd0 100644
--- a/net/colo-compare.h
+++ b/net/colo-compare.h
@@ -14,6 +14,8 @@
  * later.  See the COPYING file in the top-level directory.
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef QEMU_COLO_COMPARE_H
 #define QEMU_COLO_COMPARE_H
 
diff --git a/qemu-options-wrapper.h b/qemu-options-wrapper.h
index 6f548e3922..ee72bbc004 100644
--- a/qemu-options-wrapper.h
+++ b/qemu-options-wrapper.h
@@ -1,3 +1,4 @@
+/* FIXME Does not pass make check-headers, yet! */
 
 #if defined(QEMU_OPTIONS_GENERATE_ENUM)
 
diff --git a/qga/guest-agent-core.h b/qga/guest-agent-core.h
index 60eae16f27..6cf8c288e8 100644
--- a/qga/guest-agent-core.h
+++ b/qga/guest-agent-core.h
@@ -10,6 +10,9 @@
  * This work is licensed under the terms of the GNU GPL, version 2 or later.
  * See the COPYING file in the top-level directory.
  */
+
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef GUEST_AGENT_CORE_H
 #define GUEST_AGENT_CORE_H
 
diff --git a/qga/service-win32.h b/qga/service-win32.h
index 7b16d69b57..125eb4d235 100644
--- a/qga/service-win32.h
+++ b/qga/service-win32.h
@@ -11,6 +11,8 @@
  * See the COPYING file in the top-level directory.
  */
 
+/* FIXME Does not pass make check-headers without CONFIG_WIN32, yet! */
+
 #ifndef QGA_SERVICE_WIN32_H
 #define QGA_SERVICE_WIN32_H
 
diff --git a/qga/vss-win32.h b/qga/vss-win32.h
index ce2abe5a72..deede5290c 100644
--- a/qga/vss-win32.h
+++ b/qga/vss-win32.h
@@ -10,6 +10,8 @@
  * See the COPYING file in the top-level directory.
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef VSS_WIN32_H
 #define VSS_WIN32_H
 
diff --git a/qga/vss-win32/install.h b/qga/vss-win32/install.h
index 35364afdea..d90ae63c21 100644
--- a/qga/vss-win32/install.h
+++ b/qga/vss-win32/install.h
@@ -10,6 +10,8 @@
  * See the COPYING file in the top-level directory.
  */
 
+/* FIXME Does not pass make check-headers without CONFIG_WIN32, yet! */
+
 #ifndef INSTALL_H
 #define INSTALL_H
 
diff --git a/qga/vss-win32/requester.h b/qga/vss-win32/requester.h
index 5a8e8faf0c..ffbaa3476f 100644
--- a/qga/vss-win32/requester.h
+++ b/qga/vss-win32/requester.h
@@ -10,6 +10,8 @@
  * See the COPYING file in the top-level directory.
  */
 
+/* FIXME Does not pass make check-headers without CONFIG_WIN32, yet! */
+
 #ifndef VSS_WIN32_REQUESTER_H
 #define VSS_WIN32_REQUESTER_H
 
diff --git a/qga/vss-win32/vss-common.h b/qga/vss-win32/vss-common.h
index 61c170b52e..938e176311 100644
--- a/qga/vss-win32/vss-common.h
+++ b/qga/vss-win32/vss-common.h
@@ -10,6 +10,8 @@
  * See the COPYING file in the top-level directory.
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef VSS_COMMON_H
 #define VSS_COMMON_H
 
diff --git a/replay/replay-internal.h b/replay/replay-internal.h
index af6f4d55d4..7380321c8c 100644
--- a/replay/replay-internal.h
+++ b/replay/replay-internal.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef REPLAY_INTERNAL_H
 #define REPLAY_INTERNAL_H
 
diff --git a/replication.h b/replication.h
index 4c8354de23..0a8cc2be7c 100644
--- a/replication.h
+++ b/replication.h
@@ -12,6 +12,8 @@
  * See the COPYING file in the top-level directory.
  */
 
+/* FIXME Does not pass make check-headers without CONFIG_REPLICATION, yet! */
+
 #ifndef REPLICATION_H
 #define REPLICATION_H
 
diff --git a/target/alpha/cpu.h b/target/alpha/cpu.h
index ba6bc31b15..72f4dc2f07 100644
--- a/target/alpha/cpu.h
+++ b/target/alpha/cpu.h
@@ -17,6 +17,9 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef ALPHA_CPU_H
 #define ALPHA_CPU_H
 
diff --git a/target/alpha/helper.h b/target/alpha/helper.h
index d60f208703..ee5fcfc058 100644
--- a/target/alpha/helper.h
+++ b/target/alpha/helper.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers, yet! */
+
 DEF_HELPER_3(excp, noreturn, env, int, int)
 DEF_HELPER_FLAGS_1(load_pcc, TCG_CALL_NO_RWG_SE, i64, env)
 
diff --git a/target/arm/arm-powerctl.h b/target/arm/arm-powerctl.h
index 37c8a04f0a..7dfca71a04 100644
--- a/target/arm/arm-powerctl.h
+++ b/target/arm/arm-powerctl.h
@@ -8,6 +8,9 @@
  *
  */
 
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef QEMU_ARM_POWERCTL_H
 #define QEMU_ARM_POWERCTL_H
 
diff --git a/target/arm/arm_ldst.h b/target/arm/arm_ldst.h
index 5e0ac8bef0..94fba8c712 100644
--- a/target/arm/arm_ldst.h
+++ b/target/arm/arm_ldst.h
@@ -17,6 +17,9 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef ARM_LDST_H
 #define ARM_LDST_H
 
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 733b840a71..07500d3d60 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -17,6 +17,9 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef ARM_CPU_H
 #define ARM_CPU_H
 
diff --git a/target/arm/helper-a64.h b/target/arm/helper-a64.h
index a915c1247f..8ff3d5e30c 100644
--- a/target/arm/helper-a64.h
+++ b/target/arm/helper-a64.h
@@ -16,6 +16,9 @@
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
+
+/* FIXME Does not pass make check-headers, yet! */
+
 DEF_HELPER_FLAGS_2(udiv64, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 DEF_HELPER_FLAGS_2(sdiv64, TCG_CALL_NO_RWG_SE, s64, s64, s64)
 DEF_HELPER_FLAGS_1(rbit64, TCG_CALL_NO_RWG_SE, i64, i64)
diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index 9e79182ab4..f14b1a0d16 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -17,6 +17,8 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 DEF_HELPER_FLAGS_2(sve_predtest1, TCG_CALL_NO_WG, i32, i64, i64)
 DEF_HELPER_FLAGS_3(sve_predtest, TCG_CALL_NO_WG, i32, ptr, ptr, i32)
 
diff --git a/target/arm/helper.h b/target/arm/helper.h
index 132aa1682e..b7f4346a5a 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -1,3 +1,6 @@
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 DEF_HELPER_FLAGS_1(sxtb16, TCG_CALL_NO_RWG_SE, i32, i32)
 DEF_HELPER_FLAGS_1(uxtb16, TCG_CALL_NO_RWG_SE, i32, i32)
 
diff --git a/target/arm/internals.h b/target/arm/internals.h
index 5a02f458f3..d9eac9cec0 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -22,6 +22,8 @@
  * private to it and not required by the rest of QEMU.
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef TARGET_ARM_INTERNALS_H
 #define TARGET_ARM_INTERNALS_H
 
diff --git a/target/arm/kvm-consts.h b/target/arm/kvm-consts.h
index aad28258a3..f850f8af4c 100644
--- a/target/arm/kvm-consts.h
+++ b/target/arm/kvm-consts.h
@@ -11,6 +11,10 @@
  * This work is licensed under the terms of the GNU GPL, version 2 or later.
  * See the COPYING file in the top-level directory.
  */
+
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef ARM_KVM_CONSTS_H
 #define ARM_KVM_CONSTS_H
 
diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index 2a07333c61..c9da9d9bb2 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -8,6 +8,9 @@
  *
  */
 
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef QEMU_KVM_ARM_H
 #define QEMU_KVM_ARM_H
 
diff --git a/target/arm/op_addsub.h b/target/arm/op_addsub.h
index ca4a1893c3..6ad54b477f 100644
--- a/target/arm/op_addsub.h
+++ b/target/arm/op_addsub.h
@@ -7,6 +7,8 @@
  * This code is licensed under the GPL.
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifdef ARITH_GE
 #define GE_ARG , void *gep
 #define DECLARE_GE uint32_t ge = 0
diff --git a/target/arm/translate-a64.h b/target/arm/translate-a64.h
index 63d958cf50..50ab289596 100644
--- a/target/arm/translate-a64.h
+++ b/target/arm/translate-a64.h
@@ -15,6 +15,8 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef TARGET_ARM_TRANSLATE_A64_H
 #define TARGET_ARM_TRANSLATE_A64_H
 
diff --git a/target/arm/translate.h b/target/arm/translate.h
index c2348def0d..a586575e56 100644
--- a/target/arm/translate.h
+++ b/target/arm/translate.h
@@ -1,3 +1,6 @@
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef TARGET_ARM_TRANSLATE_H
 #define TARGET_ARM_TRANSLATE_H
 
diff --git a/target/cris/cpu.h b/target/cris/cpu.h
index 857de79e24..71c3052362 100644
--- a/target/cris/cpu.h
+++ b/target/cris/cpu.h
@@ -18,6 +18,9 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef CRIS_CPU_H
 #define CRIS_CPU_H
 
diff --git a/target/cris/helper.h b/target/cris/helper.h
index 20d21c4358..a0dc20b129 100644
--- a/target/cris/helper.h
+++ b/target/cris/helper.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers, yet! */
+
 DEF_HELPER_2(raise_exception, void, env, i32)
 DEF_HELPER_2(tlb_flush_pid, void, env, i32)
 DEF_HELPER_2(spc_write, void, env, i32)
diff --git a/target/cris/mmu.h b/target/cris/mmu.h
index 0217f476de..b37942fce6 100644
--- a/target/cris/mmu.h
+++ b/target/cris/mmu.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers, yet! */
+
 #define CRIS_MMU_ERR_EXEC  0
 #define CRIS_MMU_ERR_READ  1
 #define CRIS_MMU_ERR_WRITE 2
diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index c1e0215e66..ca10301b72 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -17,6 +17,9 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef HPPA_CPU_H
 #define HPPA_CPU_H
 
diff --git a/target/hppa/helper.h b/target/hppa/helper.h
index 38d834ef6b..629b614de3 100644
--- a/target/hppa/helper.h
+++ b/target/hppa/helper.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers, yet! */
+
 #if TARGET_REGISTER_BITS == 64
 # define dh_alias_tr     i64
 # define dh_is_64bit_tr  1
diff --git a/target/i386/cc_helper_template.h b/target/i386/cc_helper_template.h
index 607311f195..5df5549743 100644
--- a/target/i386/cc_helper_template.h
+++ b/target/i386/cc_helper_template.h
@@ -17,6 +17,8 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #define DATA_BITS (1 << (3 + SHIFT))
 
 #if DATA_BITS == 8
diff --git a/target/i386/cpu-qom.h b/target/i386/cpu-qom.h
index 22f95eb3a4..04f706580c 100644
--- a/target/i386/cpu-qom.h
+++ b/target/i386/cpu-qom.h
@@ -17,6 +17,9 @@
  * License along with this library; if not, see
  * <http://www.gnu.org/licenses/lgpl-2.1.html>
  */
+
+/* NOTE: May only be included into target-dependent code */
+
 #ifndef QEMU_I386_CPU_QOM_H
 #define QEMU_I386_CPU_QOM_H
 
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index fce6660bac..f612681331 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -18,6 +18,9 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef I386_CPU_H
 #define I386_CPU_H
 
diff --git a/target/i386/hax-i386.h b/target/i386/hax-i386.h
index 54e9d8b057..f0c15ed071 100644
--- a/target/i386/hax-i386.h
+++ b/target/i386/hax-i386.h
@@ -10,6 +10,9 @@
  *
  */
 
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef HAX_I386_H
 #define HAX_I386_H
 
diff --git a/target/i386/hax-posix.h b/target/i386/hax-posix.h
index fb7c64426d..0554858cc4 100644
--- a/target/i386/hax-posix.h
+++ b/target/i386/hax-posix.h
@@ -12,6 +12,8 @@
  *
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef TARGET_I386_HAX_POSIX_H
 #define TARGET_I386_HAX_POSIX_H
 
diff --git a/target/i386/hax-windows.h b/target/i386/hax-windows.h
index 12cbd813dc..34cfab38f4 100644
--- a/target/i386/hax-windows.h
+++ b/target/i386/hax-windows.h
@@ -17,6 +17,8 @@
  *
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef TARGET_I386_HAX_WINDOWS_H
 #define TARGET_I386_HAX_WINDOWS_H
 
diff --git a/target/i386/helper.h b/target/i386/helper.h
index 6fb8fb9b74..fc02e2a156 100644
--- a/target/i386/helper.h
+++ b/target/i386/helper.h
@@ -1,3 +1,6 @@
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 DEF_HELPER_FLAGS_4(cc_compute_all, TCG_CALL_NO_RWG_SE, tl, tl, tl, tl, int)
 DEF_HELPER_FLAGS_4(cc_compute_c, TCG_CALL_NO_RWG_SE, tl, tl, tl, tl, int)
 
diff --git a/target/i386/hvf/hvf-i386.h b/target/i386/hvf/hvf-i386.h
index 15ee4835cf..db4ec6b847 100644
--- a/target/i386/hvf/hvf-i386.h
+++ b/target/i386/hvf/hvf-i386.h
@@ -13,6 +13,9 @@
  *
  */
 
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef HVF_I386_H
 #define HVF_I386_H
 
diff --git a/target/i386/hvf/vmcs.h b/target/i386/hvf/vmcs.h
index 42de7ebc3a..d8c84eaf4a 100644
--- a/target/i386/hvf/vmcs.h
+++ b/target/i386/hvf/vmcs.h
@@ -26,6 +26,8 @@
  * $FreeBSD$
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef VMCS_H
 #define VMCS_H
 
diff --git a/target/i386/hvf/vmx.h b/target/i386/hvf/vmx.h
index 5dc52ecad6..a8680fd11a 100644
--- a/target/i386/hvf/vmx.h
+++ b/target/i386/hvf/vmx.h
@@ -22,6 +22,8 @@
  * https://github.com/mist64/hvdos
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef VMX_H
 #define VMX_H
 
diff --git a/target/i386/hvf/x86.h b/target/i386/hvf/x86.h
index c95d5b2116..7de21f208b 100644
--- a/target/i386/hvf/x86.h
+++ b/target/i386/hvf/x86.h
@@ -16,6 +16,8 @@
  * License along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef HVF_X86_H
 #define HVF_X86_H
 
diff --git a/target/i386/hvf/x86_decode.h b/target/i386/hvf/x86_decode.h
index bc574a7a44..f43028d9e8 100644
--- a/target/i386/hvf/x86_decode.h
+++ b/target/i386/hvf/x86_decode.h
@@ -15,6 +15,9 @@
  * License along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef HVF_X86_DECODE_H
 #define HVF_X86_DECODE_H
 
diff --git a/target/i386/hvf/x86_descr.h b/target/i386/hvf/x86_descr.h
index 049ef9a417..2258033958 100644
--- a/target/i386/hvf/x86_descr.h
+++ b/target/i386/hvf/x86_descr.h
@@ -16,6 +16,8 @@
  * License along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef HVF_X86_DESCR_H
 #define HVF_X86_DESCR_H
 
diff --git a/target/i386/hvf/x86_emu.h b/target/i386/hvf/x86_emu.h
index f92a9c54b5..cbceaf88a4 100644
--- a/target/i386/hvf/x86_emu.h
+++ b/target/i386/hvf/x86_emu.h
@@ -16,6 +16,9 @@
  * License along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef X86_EMU_H
 #define X86_EMU_H
 
diff --git a/target/i386/hvf/x86_flags.h b/target/i386/hvf/x86_flags.h
index 785e80cfca..e303651dc4 100644
--- a/target/i386/hvf/x86_flags.h
+++ b/target/i386/hvf/x86_flags.h
@@ -21,6 +21,9 @@
  * x86 eflags functions
  */
 
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef X86_FLAGS_H
 #define X86_FLAGS_H
 
diff --git a/target/i386/hvf/x86_mmu.h b/target/i386/hvf/x86_mmu.h
index cd6e137e79..4a20cccaa0 100644
--- a/target/i386/hvf/x86_mmu.h
+++ b/target/i386/hvf/x86_mmu.h
@@ -16,6 +16,8 @@
  * License along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef X86_MMU_H
 #define X86_MMU_H
 
diff --git a/target/i386/hvf/x86_task.h b/target/i386/hvf/x86_task.h
index 4eaa61a7de..8b3b8a0f4a 100644
--- a/target/i386/hvf/x86_task.h
+++ b/target/i386/hvf/x86_task.h
@@ -12,6 +12,8 @@
  * with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef HVF_X86_TASK_H
 #define HVF_X86_TASK_H
 
diff --git a/target/i386/hvf/x86hvf.h b/target/i386/hvf/x86hvf.h
index 79539f7282..88c78d83b2 100644
--- a/target/i386/hvf/x86hvf.h
+++ b/target/i386/hvf/x86hvf.h
@@ -15,6 +15,10 @@
  * You should have received a copy of the GNU Lesser General Public
  * License along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
+
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef X86HVF_H
 #define X86HVF_H
 #include "cpu.h"
diff --git a/target/i386/hyperv.h b/target/i386/hyperv.h
index 67543296c3..437f3a7f9c 100644
--- a/target/i386/hyperv.h
+++ b/target/i386/hyperv.h
@@ -11,6 +11,9 @@
  *
  */
 
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef TARGET_I386_HYPERV_H
 #define TARGET_I386_HYPERV_H
 
diff --git a/target/i386/kvm_i386.h b/target/i386/kvm_i386.h
index 3057ba4f7d..c8d13334c3 100644
--- a/target/i386/kvm_i386.h
+++ b/target/i386/kvm_i386.h
@@ -8,6 +8,9 @@
  *
  */
 
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef QEMU_KVM_I386_H
 #define QEMU_KVM_I386_H
 
diff --git a/target/i386/ops_sse.h b/target/i386/ops_sse.h
index ed05989768..d4492c8564 100644
--- a/target/i386/ops_sse.h
+++ b/target/i386/ops_sse.h
@@ -18,6 +18,9 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #include "crypto/aes.h"
 
 #if SHIFT == 0
diff --git a/target/i386/ops_sse_header.h b/target/i386/ops_sse_header.h
index 094aafc573..407500d4f3 100644
--- a/target/i386/ops_sse_header.h
+++ b/target/i386/ops_sse_header.h
@@ -16,6 +16,10 @@
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
+
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #if SHIFT == 0
 #define Reg MMXReg
 #define SUFFIX _mmx
diff --git a/target/i386/sev_i386.h b/target/i386/sev_i386.h
index c0f9373beb..2d9119e58c 100644
--- a/target/i386/sev_i386.h
+++ b/target/i386/sev_i386.h
@@ -11,6 +11,9 @@
  *
  */
 
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef QEMU_SEV_I386_H
 #define QEMU_SEV_I386_H
 
diff --git a/target/i386/shift_helper_template.h b/target/i386/shift_helper_template.h
index cf91a2d284..be7e1352ed 100644
--- a/target/i386/shift_helper_template.h
+++ b/target/i386/shift_helper_template.h
@@ -17,6 +17,8 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #define DATA_BITS (1 << (3 + SHIFT))
 #define SHIFT_MASK (DATA_BITS - 1)
 #if DATA_BITS <= 32
diff --git a/target/i386/whp-dispatch.h b/target/i386/whp-dispatch.h
index a23fb33a29..79f2fec9b1 100644
--- a/target/i386/whp-dispatch.h
+++ b/target/i386/whp-dispatch.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers, yet! */
+
 #include <windows.h>
 
 #include <WinHvPlatform.h>
diff --git a/target/lm32/cpu.h b/target/lm32/cpu.h
index d224d4426e..1cbbef3dc6 100644
--- a/target/lm32/cpu.h
+++ b/target/lm32/cpu.h
@@ -17,6 +17,9 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef LM32_CPU_H
 #define LM32_CPU_H
 
diff --git a/target/lm32/helper.h b/target/lm32/helper.h
index 445578c439..ba7ce5a53b 100644
--- a/target/lm32/helper.h
+++ b/target/lm32/helper.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers, yet! */
+
 DEF_HELPER_2(raise_exception, void, env, i32)
 DEF_HELPER_1(hlt, void, env)
 DEF_HELPER_3(wcsr_bp, void, env, i32, i32)
diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index 9deff9e234..62702232fa 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -18,6 +18,9 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef M68K_CPU_H
 #define M68K_CPU_H
 
diff --git a/target/m68k/helper.h b/target/m68k/helper.h
index feee7be626..cbfb184ff9 100644
--- a/target/m68k/helper.h
+++ b/target/m68k/helper.h
@@ -1,3 +1,6 @@
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 DEF_HELPER_1(bitrev, i32, i32)
 DEF_HELPER_1(ff1, i32, i32)
 DEF_HELPER_FLAGS_2(sats, TCG_CALL_NO_RWG_SE, i32, i32, i32)
diff --git a/target/m68k/softfloat.h b/target/m68k/softfloat.h
index 602661d5a8..c37f2d368c 100644
--- a/target/m68k/softfloat.h
+++ b/target/m68k/softfloat.h
@@ -18,6 +18,8 @@
  * version 2 or later. See the COPYING file in the top-level directory.
  */
 
+/* NOTE: May only be included into target-dependent code */
+
 #ifndef TARGET_M68K_SOFTFLOAT_H
 #define TARGET_M68K_SOFTFLOAT_H
 #include "fpu/softfloat.h"
diff --git a/target/m68k/softfloat_fpsp_tables.h b/target/m68k/softfloat_fpsp_tables.h
index 3f1419ee6e..6435e54401 100644
--- a/target/m68k/softfloat_fpsp_tables.h
+++ b/target/m68k/softfloat_fpsp_tables.h
@@ -18,6 +18,8 @@
  * version 2 or later. See the COPYING file in the top-level directory.
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef TARGET_M68K_SOFTFLOAT_FPSP_TABLES_H
 #define TARGET_M68K_SOFTFLOAT_FPSP_TABLES_H
 
diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index 7a9fb8f4aa..903e489f89 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -17,6 +17,9 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef MICROBLAZE_CPU_H
 #define MICROBLAZE_CPU_H
 
diff --git a/target/microblaze/helper.h b/target/microblaze/helper.h
index 2f8bdea22b..7f1ab95158 100644
--- a/target/microblaze/helper.h
+++ b/target/microblaze/helper.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers, yet! */
+
 DEF_HELPER_2(raise_exception, void, env, i32)
 DEF_HELPER_1(debug, void, env)
 DEF_HELPER_FLAGS_3(carry, TCG_CALL_NO_RWG_SE, i32, i32, i32, i32)
diff --git a/target/microblaze/mmu.h b/target/microblaze/mmu.h
index a4272b6356..e0585b3d66 100644
--- a/target/microblaze/mmu.h
+++ b/target/microblaze/mmu.h
@@ -17,6 +17,8 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #define MMU_R_PID    0
 #define MMU_R_ZPR    1
 #define MMU_R_TLBX   2
diff --git a/target/mips/cpu-qom.h b/target/mips/cpu-qom.h
index ee58606afe..a1157d3758 100644
--- a/target/mips/cpu-qom.h
+++ b/target/mips/cpu-qom.h
@@ -17,6 +17,9 @@
  * License along with this library; if not, see
  * <http://www.gnu.org/licenses/lgpl-2.1.html>
  */
+
+/* NOTE: May only be included into target-dependent code */
+
 #ifndef QEMU_MIPS_CPU_QOM_H
 #define QEMU_MIPS_CPU_QOM_H
 
diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 1f41cf66d5..9ea41fd007 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -1,3 +1,6 @@
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef MIPS_CPU_H
 #define MIPS_CPU_H
 
diff --git a/target/mips/helper.h b/target/mips/helper.h
index a6d687e340..6c00b93c97 100644
--- a/target/mips/helper.h
+++ b/target/mips/helper.h
@@ -1,3 +1,6 @@
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 DEF_HELPER_3(raise_exception_err, noreturn, env, i32, int)
 DEF_HELPER_2(raise_exception, noreturn, env, i32)
 DEF_HELPER_1(raise_exception_debug, noreturn, env)
diff --git a/target/mips/internal.h b/target/mips/internal.h
index b2b41a51ab..3a26d1b85a 100644
--- a/target/mips/internal.h
+++ b/target/mips/internal.h
@@ -4,6 +4,9 @@
  * See the COPYING file in the top-level directory.
  */
 
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef MIPS_INTERNAL_H
 #define MIPS_INTERNAL_H
 
diff --git a/target/mips/kvm_mips.h b/target/mips/kvm_mips.h
index ae957f37f0..cea59e3566 100644
--- a/target/mips/kvm_mips.h
+++ b/target/mips/kvm_mips.h
@@ -9,6 +9,8 @@
  * Authors: Sanjay Lal <sanjayl@kymasys.com>
 */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef KVM_MIPS_H
 #define KVM_MIPS_H
 
diff --git a/target/mips/mips-defs.h b/target/mips/mips-defs.h
index dbdb4b2b2d..fad47c1fe9 100644
--- a/target/mips/mips-defs.h
+++ b/target/mips/mips-defs.h
@@ -1,3 +1,5 @@
+/* NOTE: May only be included into target-dependent code */
+
 #ifndef QEMU_MIPS_DEFS_H
 #define QEMU_MIPS_DEFS_H
 
diff --git a/target/moxie/cpu.h b/target/moxie/cpu.h
index a63a96bc05..393726e395 100644
--- a/target/moxie/cpu.h
+++ b/target/moxie/cpu.h
@@ -17,6 +17,9 @@
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef MOXIE_CPU_H
 #define MOXIE_CPU_H
 
diff --git a/target/moxie/helper.h b/target/moxie/helper.h
index d94ef7a17e..88d974480e 100644
--- a/target/moxie/helper.h
+++ b/target/moxie/helper.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers, yet! */
+
 DEF_HELPER_2(raise_exception, void, env, int)
 DEF_HELPER_1(debug, void, env)
 
diff --git a/target/moxie/machine.h b/target/moxie/machine.h
index a1b72907ae..e8ab248984 100644
--- a/target/moxie/machine.h
+++ b/target/moxie/machine.h
@@ -1 +1,3 @@
+/* FIXME Does not pass make check-headers, yet! */
+
 extern const VMStateDescription vmstate_moxie_cpu;
diff --git a/target/moxie/mmu.h b/target/moxie/mmu.h
index 284a44d18e..874d4a4b30 100644
--- a/target/moxie/mmu.h
+++ b/target/moxie/mmu.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers, yet! */
+
 #define MOXIE_MMU_ERR_EXEC  0
 #define MOXIE_MMU_ERR_READ  1
 #define MOXIE_MMU_ERR_WRITE 2
diff --git a/target/nios2/cpu.h b/target/nios2/cpu.h
index 35d3886dc2..d17a66734d 100644
--- a/target/nios2/cpu.h
+++ b/target/nios2/cpu.h
@@ -18,6 +18,9 @@
  * <http://www.gnu.org/licenses/lgpl-2.1.html>
  */
 
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef NIOS2_CPU_H
 #define NIOS2_CPU_H
 
diff --git a/target/nios2/helper.h b/target/nios2/helper.h
index b0cb9146a5..697822c728 100644
--- a/target/nios2/helper.h
+++ b/target/nios2/helper.h
@@ -18,6 +18,8 @@
  * <http://www.gnu.org/licenses/lgpl-2.1.html>
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 DEF_HELPER_2(raise_exception, void, env, i32)
 
 #if !defined(CONFIG_USER_ONLY)
diff --git a/target/nios2/mmu.h b/target/nios2/mmu.h
index 4f46fbb82e..ef7ce93500 100644
--- a/target/nios2/mmu.h
+++ b/target/nios2/mmu.h
@@ -18,6 +18,8 @@
  * <http://www.gnu.org/licenses/lgpl-2.1.html>
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef NIOS2_MMU_H
 #define NIOS2_MMU_H
 
diff --git a/target/openrisc/cpu.h b/target/openrisc/cpu.h
index 9473d94d0c..f7e506f406 100644
--- a/target/openrisc/cpu.h
+++ b/target/openrisc/cpu.h
@@ -17,6 +17,9 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef OPENRISC_CPU_H
 #define OPENRISC_CPU_H
 
diff --git a/target/openrisc/exception.h b/target/openrisc/exception.h
index c9c4e471d2..43267b5337 100644
--- a/target/openrisc/exception.h
+++ b/target/openrisc/exception.h
@@ -17,6 +17,9 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef TARGET_OPENRISC_EXCEPTION_H
 #define TARGET_OPENRISC_EXCEPTION_H
 
diff --git a/target/openrisc/helper.h b/target/openrisc/helper.h
index 96d79a8113..5da784bfed 100644
--- a/target/openrisc/helper.h
+++ b/target/openrisc/helper.h
@@ -17,6 +17,8 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 /* exception */
 DEF_HELPER_FLAGS_2(exception, TCG_CALL_NO_WG, void, env, i32)
 DEF_HELPER_FLAGS_1(ove_cy, TCG_CALL_NO_WG, void, env)
diff --git a/target/ppc/cpu-models.h b/target/ppc/cpu-models.h
index 4fdb73034d..87def9e8ae 100644
--- a/target/ppc/cpu-models.h
+++ b/target/ppc/cpu-models.h
@@ -18,6 +18,9 @@
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
+
+/* NOTE: May only be included into target-dependent code */
+
 #ifndef TARGET_PPC_CPU_MODELS_H
 #define TARGET_PPC_CPU_MODELS_H
 
diff --git a/target/ppc/cpu-qom.h b/target/ppc/cpu-qom.h
index be9b4c30c3..4fae18b691 100644
--- a/target/ppc/cpu-qom.h
+++ b/target/ppc/cpu-qom.h
@@ -17,6 +17,9 @@
  * License along with this library; if not, see
  * <http://www.gnu.org/licenses/lgpl-2.1.html>
  */
+
+/* NOTE: May only be included into target-dependent code */
+
 #ifndef QEMU_PPC_CPU_QOM_H
 #define QEMU_PPC_CPU_QOM_H
 
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index d7f23ad5e0..79c163eeb8 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -17,6 +17,9 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef PPC_CPU_H
 #define PPC_CPU_H
 
diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 638a6e99c4..6a86305870 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -1,3 +1,6 @@
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 DEF_HELPER_FLAGS_3(raise_exception_err, TCG_CALL_NO_WG, void, env, i32, i32)
 DEF_HELPER_FLAGS_2(raise_exception, TCG_CALL_NO_WG, void, env, i32)
 DEF_HELPER_FLAGS_4(tw, TCG_CALL_NO_WG, void, env, tl, tl, i32)
diff --git a/target/ppc/helper_regs.h b/target/ppc/helper_regs.h
index 922da76c6c..7c2cd5b10c 100644
--- a/target/ppc/helper_regs.h
+++ b/target/ppc/helper_regs.h
@@ -17,6 +17,9 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef HELPER_REGS_H
 #define HELPER_REGS_H
 
diff --git a/target/ppc/internal.h b/target/ppc/internal.h
index fb6f64ed1e..ebf411eb47 100644
--- a/target/ppc/internal.h
+++ b/target/ppc/internal.h
@@ -15,6 +15,9 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef PPC_INTERNAL_H
 #define PPC_INTERNAL_H
 
diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
index 22385134b4..2a70446c22 100644
--- a/target/ppc/kvm_ppc.h
+++ b/target/ppc/kvm_ppc.h
@@ -6,6 +6,9 @@
  *
  */
 
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef KVM_PPC_H
 #define KVM_PPC_H
 
diff --git a/target/ppc/mmu-book3s-v3.h b/target/ppc/mmu-book3s-v3.h
index 0f3c9d09c6..f72db5eed2 100644
--- a/target/ppc/mmu-book3s-v3.h
+++ b/target/ppc/mmu-book3s-v3.h
@@ -17,6 +17,9 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef PPC_MMU_BOOK3S_V3_H
 #define PPC_MMU_BOOK3S_V3_H
 
diff --git a/target/ppc/mmu-hash32.h b/target/ppc/mmu-hash32.h
index 898021f0d8..00452b4981 100644
--- a/target/ppc/mmu-hash32.h
+++ b/target/ppc/mmu-hash32.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef MMU_HASH32_H
 #define MMU_HASH32_H
 
diff --git a/target/ppc/mmu-hash64.h b/target/ppc/mmu-hash64.h
index 87729d48b3..8c8497410d 100644
--- a/target/ppc/mmu-hash64.h
+++ b/target/ppc/mmu-hash64.h
@@ -1,3 +1,6 @@
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef MMU_HASH64_H
 #define MMU_HASH64_H
 
diff --git a/target/ppc/mmu-radix64.h b/target/ppc/mmu-radix64.h
index 96228546aa..b066bee6a6 100644
--- a/target/ppc/mmu-radix64.h
+++ b/target/ppc/mmu-radix64.h
@@ -1,3 +1,6 @@
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef MMU_RADIX64_H
 #define MMU_RADIX64_H
 
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index c17184f4e4..68a01848d6 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -17,6 +17,9 @@
  * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef RISCV_CPU_H
 #define RISCV_CPU_H
 
diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index debb22a480..fafa499429 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers, yet! */
+
 /* Exceptions */
 DEF_HELPER_2(raise_exception, noreturn, env, i32)
 
diff --git a/target/riscv/instmap.h b/target/riscv/instmap.h
index 58baa1ba1f..a4d05f2990 100644
--- a/target/riscv/instmap.h
+++ b/target/riscv/instmap.h
@@ -16,6 +16,8 @@
  * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #define MASK_OP_MAJOR(op)  (op & 0x7F)
 enum {
     /* rv32i, rv64i, rv32m */
diff --git a/target/riscv/pmp.h b/target/riscv/pmp.h
index 66790950eb..c778a6ba55 100644
--- a/target/riscv/pmp.h
+++ b/target/riscv/pmp.h
@@ -19,6 +19,8 @@
  * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef RISCV_PMP_H
 #define RISCV_PMP_H
 
diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 7305cacc7b..ae2fa10a05 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -18,6 +18,8 @@
  * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef S390X_CPU_H
 #define S390X_CPU_H
 
diff --git a/target/s390x/cpu_features.h b/target/s390x/cpu_features.h
index da695a8346..4d2f33dc52 100644
--- a/target/s390x/cpu_features.h
+++ b/target/s390x/cpu_features.h
@@ -11,6 +11,8 @@
  * directory.
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef TARGET_S390X_CPU_FEATURES_H
 #define TARGET_S390X_CPU_FEATURES_H
 
diff --git a/target/s390x/cpu_models.h b/target/s390x/cpu_models.h
index 174a99e561..fdf37abe67 100644
--- a/target/s390x/cpu_models.h
+++ b/target/s390x/cpu_models.h
@@ -10,6 +10,8 @@
  * directory.
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef TARGET_S390X_CPU_MODELS_H
 #define TARGET_S390X_CPU_MODELS_H
 
diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index 7755a96c33..3617126823 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers, yet! */
+
 DEF_HELPER_2(exception, noreturn, env, i32)
 DEF_HELPER_2(data_exception, noreturn, env, i32)
 DEF_HELPER_FLAGS_4(nc, TCG_CALL_NO_WG, i32, env, i32, i64, i64)
diff --git a/target/s390x/internal.h b/target/s390x/internal.h
index 9893fc094b..dac290f6f9 100644
--- a/target/s390x/internal.h
+++ b/target/s390x/internal.h
@@ -7,6 +7,8 @@
  * See the COPYING file in the top-level directory.
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef S390X_INTERNAL_H
 #define S390X_INTERNAL_H
 
diff --git a/target/s390x/tcg_s390x.h b/target/s390x/tcg_s390x.h
index ab2c4ba703..cd30791f30 100644
--- a/target/s390x/tcg_s390x.h
+++ b/target/s390x/tcg_s390x.h
@@ -10,6 +10,8 @@
  * See the COPYING file in the top-level directory.
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef TCG_S390X_H
 #define TCG_S390X_H
 
diff --git a/target/sh4/cpu.h b/target/sh4/cpu.h
index 547194aac7..5e0a5de2fe 100644
--- a/target/sh4/cpu.h
+++ b/target/sh4/cpu.h
@@ -17,6 +17,9 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef SH4_CPU_H
 #define SH4_CPU_H
 
diff --git a/target/sh4/helper.h b/target/sh4/helper.h
index 1e768fcbc7..ddb86b21fc 100644
--- a/target/sh4/helper.h
+++ b/target/sh4/helper.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers, yet! */
+
 DEF_HELPER_1(ldtlb, void, env)
 DEF_HELPER_1(raise_illegal_instruction, noreturn, env)
 DEF_HELPER_1(raise_slot_illegal_instruction, noreturn, env)
diff --git a/target/sparc/cpu-qom.h b/target/sparc/cpu-qom.h
index af6d57a9e0..d3b42092a7 100644
--- a/target/sparc/cpu-qom.h
+++ b/target/sparc/cpu-qom.h
@@ -17,6 +17,9 @@
  * License along with this library; if not, see
  * <http://www.gnu.org/licenses/lgpl-2.1.html>
  */
+
+/* NOTE: May only be included into target-dependent code */
+
 #ifndef QEMU_SPARC_CPU_QOM_H
 #define QEMU_SPARC_CPU_QOM_H
 
diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index f31e8535df..2aa36fceef 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -1,3 +1,6 @@
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef SPARC_CPU_H
 #define SPARC_CPU_H
 
diff --git a/target/sparc/helper.h b/target/sparc/helper.h
index b8f1e78c75..025f583cfc 100644
--- a/target/sparc/helper.h
+++ b/target/sparc/helper.h
@@ -1,3 +1,6 @@
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef TARGET_SPARC64
 DEF_HELPER_1(rett, void, env)
 DEF_HELPER_2(wrpsr, void, env, tl)
diff --git a/target/tilegx/cpu.h b/target/tilegx/cpu.h
index 238f8d36d7..6dafca1426 100644
--- a/target/tilegx/cpu.h
+++ b/target/tilegx/cpu.h
@@ -17,6 +17,9 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef TILEGX_CPU_H
 #define TILEGX_CPU_H
 
diff --git a/target/tilegx/helper.h b/target/tilegx/helper.h
index 16745c266f..2b5172ebc3 100644
--- a/target/tilegx/helper.h
+++ b/target/tilegx/helper.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers, yet! */
+
 DEF_HELPER_2(exception, noreturn, env, i32)
 DEF_HELPER_1(ext01_ics, void, env)
 DEF_HELPER_FLAGS_1(revbits, TCG_CALL_NO_RWG_SE, i64, i64)
diff --git a/target/tricore/cpu.h b/target/tricore/cpu.h
index 287f4328a3..7c0da95bec 100644
--- a/target/tricore/cpu.h
+++ b/target/tricore/cpu.h
@@ -17,6 +17,9 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef TRICORE_CPU_H
 #define TRICORE_CPU_H
 
diff --git a/target/tricore/helper.h b/target/tricore/helper.h
index f60e81096b..678e1c3700 100644
--- a/target/tricore/helper.h
+++ b/target/tricore/helper.h
@@ -15,6 +15,8 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 /* Arithmetic */
 DEF_HELPER_3(add_ssov, i32, env, i32, i32)
 DEF_HELPER_3(add64_ssov, i64, env, i64, i64)
diff --git a/target/tricore/tricore-defs.h b/target/tricore/tricore-defs.h
index e871aa1c6b..13880da779 100644
--- a/target/tricore/tricore-defs.h
+++ b/target/tricore/tricore-defs.h
@@ -15,6 +15,8 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
+/* NOTE: May only be included into target-dependent code */
+
 #ifndef QEMU_TRICORE_DEFS_H
 #define QEMU_TRICORE_DEFS_H
 
diff --git a/target/tricore/tricore-opcodes.h b/target/tricore/tricore-opcodes.h
index 40bc121ba4..17c48480d5 100644
--- a/target/tricore/tricore-opcodes.h
+++ b/target/tricore/tricore-opcodes.h
@@ -15,6 +15,8 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 /*
  * Opcode Masks for Tricore
  * Format MASK_OP_InstrFormatName_Field
diff --git a/target/unicore32/cpu.h b/target/unicore32/cpu.h
index f052ee08bf..ab33f17ad1 100644
--- a/target/unicore32/cpu.h
+++ b/target/unicore32/cpu.h
@@ -9,6 +9,9 @@
  * later version. See the COPYING file in the top-level directory.
  */
 
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef UNICORE32_CPU_H
 #define UNICORE32_CPU_H
 
diff --git a/target/unicore32/helper.h b/target/unicore32/helper.h
index a4a5d45d1d..eb59028a8a 100644
--- a/target/unicore32/helper.h
+++ b/target/unicore32/helper.h
@@ -7,6 +7,8 @@
  * later version. See the COPYING file in the top-level directory.
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef CONFIG_USER_ONLY
 DEF_HELPER_4(cp0_set, void, env, i32, i32, i32)
 DEF_HELPER_3(cp0_get, i32, env, i32, i32)
diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index a0df46f73b..594c66b1a1 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -25,6 +25,9 @@
  * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef XTENSA_CPU_H
 #define XTENSA_CPU_H
 
diff --git a/target/xtensa/helper.h b/target/xtensa/helper.h
index 8532de0b35..952b771c9a 100644
--- a/target/xtensa/helper.h
+++ b/target/xtensa/helper.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers, yet! */
+
 DEF_HELPER_2(exception, noreturn, env, i32)
 DEF_HELPER_3(exception_cause, noreturn, env, i32, i32)
 DEF_HELPER_4(exception_cause_vaddr, noreturn, env, i32, i32, i32)
diff --git a/target/xtensa/overlay_tool.h b/target/xtensa/overlay_tool.h
index f0cc33adfe..0024e8f04a 100644
--- a/target/xtensa/overlay_tool.h
+++ b/target/xtensa/overlay_tool.h
@@ -25,6 +25,9 @@
  * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #define XTREG(idx, ofs, bi, sz, al, no, fl, cp, typ, grp, name, \
               a1, a2, a3, a4, a5, a6) { \
     .targno = (no), \
diff --git a/target/xtensa/xtensa-isa-internal.h b/target/xtensa/xtensa-isa-internal.h
index 40dd8bac96..c0520902f2 100644
--- a/target/xtensa/xtensa-isa-internal.h
+++ b/target/xtensa/xtensa-isa-internal.h
@@ -22,6 +22,8 @@
  * SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef XTENSA_ISA_INTERNAL_H
 #define XTENSA_ISA_INTERNAL_H
 
diff --git a/tcg/aarch64/tcg-target.h b/tcg/aarch64/tcg-target.h
index e43554c3c7..ea959961fb 100644
--- a/tcg/aarch64/tcg-target.h
+++ b/tcg/aarch64/tcg-target.h
@@ -10,6 +10,8 @@
  * See the COPYING file in the top-level directory for details.
  */
 
+/* NOTE: May only be included into target-dependent code */
+
 #ifndef AARCH64_TCG_TARGET_H
 #define AARCH64_TCG_TARGET_H
 
diff --git a/tcg/aarch64/tcg-target.opc.h b/tcg/aarch64/tcg-target.opc.h
index 59e1d3f7f7..01e40e217a 100644
--- a/tcg/aarch64/tcg-target.opc.h
+++ b/tcg/aarch64/tcg-target.opc.h
@@ -2,4 +2,7 @@
    emitted by tcg_expand_vec_op.  For those familiar with GCC internals,
    consider these to be UNSPEC with names.  */
 
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 DEF(aa64_sshl_vec, 1, 2, 0, IMPLVEC)
diff --git a/tcg/arm/tcg-target.h b/tcg/arm/tcg-target.h
index 17e771374d..af08634eff 100644
--- a/tcg/arm/tcg-target.h
+++ b/tcg/arm/tcg-target.h
@@ -23,6 +23,8 @@
  * THE SOFTWARE.
  */
 
+/* NOTE: May only be included into target-dependent code */
+
 #ifndef ARM_TCG_TARGET_H
 #define ARM_TCG_TARGET_H
 
diff --git a/tcg/i386/tcg-target.h b/tcg/i386/tcg-target.h
index 66f16fbe3c..9f36696298 100644
--- a/tcg/i386/tcg-target.h
+++ b/tcg/i386/tcg-target.h
@@ -22,6 +22,9 @@
  * THE SOFTWARE.
  */
 
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef I386_TCG_TARGET_H
 #define I386_TCG_TARGET_H
 
diff --git a/tcg/i386/tcg-target.opc.h b/tcg/i386/tcg-target.opc.h
index e5fa88ba25..1a0c0ec764 100644
--- a/tcg/i386/tcg-target.opc.h
+++ b/tcg/i386/tcg-target.opc.h
@@ -2,6 +2,8 @@
    emitted by tcg_expand_vec_op.  For those familiar with GCC internals,
    consider these to be UNSPEC with names.  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 DEF(x86_shufps_vec, 1, 2, 1, IMPLVEC)
 DEF(x86_vpblendvb_vec, 1, 3, 0, IMPLVEC)
 DEF(x86_blend_vec, 1, 2, 1, IMPLVEC)
diff --git a/tcg/mips/tcg-target.h b/tcg/mips/tcg-target.h
index c6b091d849..2b8baa569e 100644
--- a/tcg/mips/tcg-target.h
+++ b/tcg/mips/tcg-target.h
@@ -24,6 +24,8 @@
  * THE SOFTWARE.
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef MIPS_TCG_TARGET_H
 #define MIPS_TCG_TARGET_H
 
diff --git a/tcg/ppc/tcg-target.h b/tcg/ppc/tcg-target.h
index 7627fb62d3..a1696b9f4a 100644
--- a/tcg/ppc/tcg-target.h
+++ b/tcg/ppc/tcg-target.h
@@ -22,6 +22,8 @@
  * THE SOFTWARE.
  */
 
+/* NOTE: May only be included into target-dependent code */
+
 #ifndef PPC_TCG_TARGET_H
 #define PPC_TCG_TARGET_H
 
diff --git a/tcg/riscv/tcg-target.h b/tcg/riscv/tcg-target.h
index 032439d806..8a7e3e5e2c 100644
--- a/tcg/riscv/tcg-target.h
+++ b/tcg/riscv/tcg-target.h
@@ -22,6 +22,9 @@
  * THE SOFTWARE.
  */
 
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef RISCV_TCG_TARGET_H
 #define RISCV_TCG_TARGET_H
 
diff --git a/tcg/s390/tcg-target.h b/tcg/s390/tcg-target.h
index 07accabbd1..6169500167 100644
--- a/tcg/s390/tcg-target.h
+++ b/tcg/s390/tcg-target.h
@@ -22,6 +22,9 @@
  * THE SOFTWARE.
  */
 
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef S390_TCG_TARGET_H
 #define S390_TCG_TARGET_H
 
diff --git a/tcg/tcg-gvec-desc.h b/tcg/tcg-gvec-desc.h
index 2dda7d6ba1..cd8c6f79ca 100644
--- a/tcg/tcg-gvec-desc.h
+++ b/tcg/tcg-gvec-desc.h
@@ -17,6 +17,8 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 /* ??? These bit widths are set for ARM SVE, maxing out at 256 byte vectors. */
 #define SIMD_OPRSZ_SHIFT   0
 #define SIMD_OPRSZ_BITS    5
diff --git a/tcg/tcg-op-gvec.h b/tcg/tcg-op-gvec.h
index 52a398c190..5af2fb7e10 100644
--- a/tcg/tcg-op-gvec.h
+++ b/tcg/tcg-op-gvec.h
@@ -17,6 +17,8 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 /*
  * "Generic" vectors.  All operands are given as offsets from ENV,
  * and therefore cannot also be allocated via tcg_global_mem_new_*.
diff --git a/tcg/tcg-op.h b/tcg/tcg-op.h
index 660fe205d0..2ab3b95803 100644
--- a/tcg/tcg-op.h
+++ b/tcg/tcg-op.h
@@ -22,6 +22,8 @@
  * THE SOFTWARE.
  */
 
+/* NOTE: May only be included into target-dependent code */
+
 #ifndef TCG_TCG_OP_H
 #define TCG_TCG_OP_H
 
diff --git a/tcg/tcg-opc.h b/tcg/tcg-opc.h
index 4a2dd116eb..567dee2a14 100644
--- a/tcg/tcg-opc.h
+++ b/tcg/tcg-opc.h
@@ -22,11 +22,15 @@
  * THE SOFTWARE.
  */
 
+/* NOTE: May only be included into target-dependent code */
+/* FIXME Does not pass make check-headers, yet! */
+
 /*
  * DEF(name, oargs, iargs, cargs, flags)
  */
 
 /* predefined ops */
+
 DEF(discard, 1, 0, 0, TCG_OPF_NOT_PRESENT)
 DEF(set_label, 0, 0, 1, TCG_OPF_BB_END | TCG_OPF_NOT_PRESENT)
 
diff --git a/tcg/tcg.h b/tcg/tcg.h
index 0e01a70d66..39e27e6440 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -22,6 +22,8 @@
  * THE SOFTWARE.
  */
 
+/* NOTE: May only be included into target-dependent code */
+
 #ifndef TCG_H
 #define TCG_H
 
diff --git a/tcg/tci/tcg-target.h b/tcg/tci/tcg-target.h
index 8b90ab71cb..4212c274fb 100644
--- a/tcg/tci/tcg-target.h
+++ b/tcg/tci/tcg-target.h
@@ -37,6 +37,8 @@
  * Therefore, we need both 32 and 64 bit virtual machines (interpreter).
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef TCG_TARGET_H
 #define TCG_TARGET_H
 
diff --git a/tests/check-headers.mak b/tests/check-headers.mak
index 1facce517e..589c62d66b 100644
--- a/tests/check-headers.mak
+++ b/tests/check-headers.mak
@@ -10,8 +10,6 @@ excluded-headers := $(filter disas/libvixl/vixl/% include/standard-headers/% lin
 # Funny stuff we don't want to mess with:
 excluded-headers += $(filter tests/multiboot/% tests/tcg/% tests/uefi-test-tools/%, $(src-headers))
 excluded-headers += scripts/cocci-macro-file.h
-# Exclude all but include/ for now:
-excluded-headers += $(filter-out include/%, $(src-headers))
 
 # Headers that require -DNEED_CPU_H etc.
 target-header-comment := NOTE: May only be included into target-dependent code
@@ -21,11 +19,14 @@ target-headers := $(shell cd $(SRC_PATH) && egrep -l '$(target-header-comment)'
 bad-header-without-linux$(CONFIG_LINUX) := | without CONFIG_LINUX
 bad-header-without-opengl$(CONFIG_OPENGL) := | without CONFIG_OPENGL
 bad-header-without-posix$(CONFIG_POSIX) := | without CONFIG_POSIX
+bad-header-without-rdma$(CONFIG_RDMA) := | without CONFIG_RDMA
+bad-header-without-replication$(CONFIG_REPLICATION) := | without CONFIG_REPLICATION
 bad-header-without-spice$(CONFIG_SPICE) := | without CONFIG_SPICE
 bad-header-without-system-emu$(TARGET_DIRS) := | without system emulation
 bad-header-without-win32$(CONFIG_WIN32) := | without CONFIG_WIN32
+bad-header-without-x11$(CONFIG_X11) := | without CONFIG_X11
 bad-header-without-xen$(CONFIG_XEN) := | without CONFIG_XEN
-bad-header-comment := FIXME Does not pass make check-headers($(bad-header-without-linux)$(bad-header-without-opengl)$(bad-header-without-posix)$(bad-header-without-spice)$(bad-header-without-system-emu)$(bad-header-without-win32)$(bad-header-without-xen)), yet!
+bad-header-comment := FIXME Does not pass make check-headers($(bad-header-without-linux)$(bad-header-without-opengl)$(bad-header-without-posix)$(bad-header-without-rdma)$(bad-header-without-replication)$(bad-header-without-spice)$(bad-header-without-system-emu)$(bad-header-without-win32)$(bad-header-without-x11)$(bad-header-without-xen)), yet!
 bad-headers := $(shell cd $(SRC_PATH) && egrep -l '$(bad-header-comment)' $(src-headers))
 bad-target-headers := $(filter $(target-headers), $(bad-headers))
 
diff --git a/tests/crypto-tls-x509-helpers.h b/tests/crypto-tls-x509-helpers.h
index 88c30d7c94..2985347330 100644
--- a/tests/crypto-tls-x509-helpers.h
+++ b/tests/crypto-tls-x509-helpers.h
@@ -18,6 +18,8 @@
  * Author: Daniel P. Berrange <berrange@redhat.com>
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #include <gnutls/gnutls.h>
 #include <gnutls/x509.h>
 
diff --git a/tests/fp/platform.h b/tests/fp/platform.h
index c20ba70baa..4fe3f9d7de 100644
--- a/tests/fp/platform.h
+++ b/tests/fp/platform.h
@@ -29,6 +29,9 @@
  * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
  * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
+
+/* FIXME Does not pass make check-headers without CONFIG_POSIX, yet! */
+
 #include "config-host.h"
 
 #ifndef HOST_WORDS_BIGENDIAN
diff --git a/tests/libqos/virtio-9p.h b/tests/libqos/virtio-9p.h
index dba22772b5..e4e19c43a4 100644
--- a/tests/libqos/virtio-9p.h
+++ b/tests/libqos/virtio-9p.h
@@ -16,6 +16,8 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #include "libqos/qgraph.h"
 #include "libqos/virtio.h"
 #include "libqos/virtio-pci.h"
diff --git a/tests/libqos/virtio-balloon.h b/tests/libqos/virtio-balloon.h
index e8066c42bb..122e18437b 100644
--- a/tests/libqos/virtio-balloon.h
+++ b/tests/libqos/virtio-balloon.h
@@ -16,6 +16,8 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #include "libqos/qgraph.h"
 #include "libqos/virtio.h"
 #include "libqos/virtio-pci.h"
diff --git a/tests/libqos/virtio-blk.h b/tests/libqos/virtio-blk.h
index dc258496ba..ab585bbacb 100644
--- a/tests/libqos/virtio-blk.h
+++ b/tests/libqos/virtio-blk.h
@@ -16,6 +16,8 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #include "libqos/qgraph.h"
 #include "libqos/virtio.h"
 #include "libqos/virtio-pci.h"
diff --git a/tests/libqos/virtio-net.h b/tests/libqos/virtio-net.h
index 28238a1b20..cc3af6056a 100644
--- a/tests/libqos/virtio-net.h
+++ b/tests/libqos/virtio-net.h
@@ -16,6 +16,8 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #include "libqos/qgraph.h"
 #include "libqos/virtio.h"
 #include "libqos/virtio-pci.h"
diff --git a/tests/libqos/virtio-rng.h b/tests/libqos/virtio-rng.h
index fbba988875..1d36c9728a 100644
--- a/tests/libqos/virtio-rng.h
+++ b/tests/libqos/virtio-rng.h
@@ -16,6 +16,8 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #include "libqos/qgraph.h"
 #include "libqos/virtio.h"
 #include "libqos/virtio-pci.h"
diff --git a/tests/libqos/virtio-scsi.h b/tests/libqos/virtio-scsi.h
index 17a47beddc..d0dffb7530 100644
--- a/tests/libqos/virtio-scsi.h
+++ b/tests/libqos/virtio-scsi.h
@@ -16,6 +16,8 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #include "libqos/qgraph.h"
 #include "libqos/virtio.h"
 #include "libqos/virtio-pci.h"
diff --git a/tests/libqos/virtio-serial.h b/tests/libqos/virtio-serial.h
index b7e2a5d178..d8829d7246 100644
--- a/tests/libqos/virtio-serial.h
+++ b/tests/libqos/virtio-serial.h
@@ -16,6 +16,8 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #include "libqos/qgraph.h"
 #include "libqos/virtio.h"
 #include "libqos/virtio-pci.h"
diff --git a/tests/migration/Makefile b/tests/migration/Makefile
index 13e99b1692..4a2015a6d4 100644
--- a/tests/migration/Makefile
+++ b/tests/migration/Makefile
@@ -28,6 +28,8 @@ override define __note
  * inside tests/migration to update, and then remember to send both
  * the header and the assembler differences in your patch submission.
  */
+
+/* FIXME Does not pass make check-headers, yet! */
 endef
 export __note
 
diff --git a/tests/migration/aarch64/a-b-kernel.h b/tests/migration/aarch64/a-b-kernel.h
index 0a9b01137e..8539ee862c 100644
--- a/tests/migration/aarch64/a-b-kernel.h
+++ b/tests/migration/aarch64/a-b-kernel.h
@@ -3,6 +3,9 @@
  * inside tests/migration to update, and then remember to send both
  * the header and the assembler differences in your patch submission.
  */
+
+/* FIXME Does not pass make check-headers, yet! */
+
 unsigned char aarch64_kernel[] = {
   0x00, 0x10, 0x38, 0xd5, 0x00, 0xf8, 0x7f, 0x92, 0x00, 0x10, 0x18, 0xd5,
   0xdf, 0x3f, 0x03, 0xd5, 0x00, 0x02, 0xa8, 0xd2, 0x01, 0xc8, 0xa8, 0xd2,
diff --git a/tests/migration/i386/a-b-bootblock.h b/tests/migration/i386/a-b-bootblock.h
index 7d459d4fde..a2f48f18c6 100644
--- a/tests/migration/i386/a-b-bootblock.h
+++ b/tests/migration/i386/a-b-bootblock.h
@@ -3,6 +3,9 @@
  * inside tests/migration to update, and then remember to send both
  * the header and the assembler differences in your patch submission.
  */
+
+/* FIXME Does not pass make check-headers, yet! */
+
 unsigned char x86_bootsect[] = {
   0xfa, 0x0f, 0x01, 0x16, 0x74, 0x7c, 0x66, 0xb8, 0x01, 0x00, 0x00, 0x00,
   0x0f, 0x22, 0xc0, 0x66, 0xea, 0x20, 0x7c, 0x00, 0x00, 0x08, 0x00, 0x00,
diff --git a/tests/migration/s390x/a-b-bios.h b/tests/migration/s390x/a-b-bios.h
index e722dc7c40..7156b709e2 100644
--- a/tests/migration/s390x/a-b-bios.h
+++ b/tests/migration/s390x/a-b-bios.h
@@ -3,6 +3,8 @@
  * inside tests/migration to update, and then remember to send both
  * the header and the assembler differences in your patch submission.
  */
+/* FIXME Does not pass make check-headers, yet! */
+
 unsigned char s390x_elf[] = {
   0x7f, 0x45, 0x4c, 0x46, 0x02, 0x02, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00,
   0x00, 0x00, 0x00, 0x00, 0x00, 0x03, 0x00, 0x16, 0x00, 0x00, 0x00, 0x01,
diff --git a/tests/ptimer-test.h b/tests/ptimer-test.h
index 09ac56da9e..fcfdefb3be 100644
--- a/tests/ptimer-test.h
+++ b/tests/ptimer-test.h
@@ -8,6 +8,8 @@
  *
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef PTIMER_TEST_H
 #define PTIMER_TEST_H
 
diff --git a/tests/socket-helpers.h b/tests/socket-helpers.h
index 1c07d6d656..fc50331ff0 100644
--- a/tests/socket-helpers.h
+++ b/tests/socket-helpers.h
@@ -15,9 +15,10 @@
  *
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, see <http://www.gnu.org/licenses/>.
- *
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 /*
  * @hostname: a DNS name or numeric IP address
  *
diff --git a/tests/tpm-emu.h b/tests/tpm-emu.h
index a4f1d64226..752c6c1199 100644
--- a/tests/tpm-emu.h
+++ b/tests/tpm-emu.h
@@ -10,6 +10,8 @@
  * See the COPYING file in the top-level directory.
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef TESTS_TPM_EMU_H
 #define TESTS_TPM_EMU_H
 
diff --git a/tests/tpm-tests.h b/tests/tpm-tests.h
index b97688fe75..e2f2efc50d 100644
--- a/tests/tpm-tests.h
+++ b/tests/tpm-tests.h
@@ -10,6 +10,8 @@
  * See the COPYING file in the top-level directory.
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef TESTS_TPM_TESTS_H
 #define TESTS_TPM_TESTS_H
 
diff --git a/tests/tpm-util.h b/tests/tpm-util.h
index 5755698ad2..af8886a731 100644
--- a/tests/tpm-util.h
+++ b/tests/tpm-util.h
@@ -10,6 +10,8 @@
  * See the COPYING file in the top-level directory.
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef TESTS_TPM_UTIL_H
 #define TESTS_TPM_UTIL_H
 
diff --git a/trace/control-internal.h b/trace/control-internal.h
index c7fbe2d3bf..947303ceaf 100644
--- a/trace/control-internal.h
+++ b/trace/control-internal.h
@@ -7,6 +7,8 @@
  * See the COPYING file in the top-level directory.
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef TRACE__CONTROL_INTERNAL_H
 #define TRACE__CONTROL_INTERNAL_H
 
diff --git a/trace/mem-internal.h b/trace/mem-internal.h
index f6efaf6d6b..fbd7ce2fcb 100644
--- a/trace/mem-internal.h
+++ b/trace/mem-internal.h
@@ -7,6 +7,8 @@
  * See the COPYING file in the top-level directory.
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef TRACE__MEM_INTERNAL_H
 #define TRACE__MEM_INTERNAL_H
 
diff --git a/trace/mem.h b/trace/mem.h
index 2b58196e53..67adedaea5 100644
--- a/trace/mem.h
+++ b/trace/mem.h
@@ -7,6 +7,8 @@
  * See the COPYING file in the top-level directory.
  */
 
+/* NOTE: May only be included into target-dependent code */
+
 #ifndef TRACE__MEM_H
 #define TRACE__MEM_H
 
diff --git a/ui/curses_keys.h b/ui/curses_keys.h
index 71e04acdc7..d8d4972761 100644
--- a/ui/curses_keys.h
+++ b/ui/curses_keys.h
@@ -22,6 +22,8 @@
  * THE SOFTWARE.
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef QEMU_CURSES_KEYS_H
 #define QEMU_CURSES_KEYS_H
 
diff --git a/ui/vgafont.h b/ui/vgafont.h
index 3606dd7338..6e49e8af9f 100644
--- a/ui/vgafont.h
+++ b/ui/vgafont.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers, yet! */
+
 static const uint8_t vgafont16[256 * 16] = {
 
 	/* 0 0x00 '^@' */
diff --git a/ui/vnc-auth-sasl.h b/ui/vnc-auth-sasl.h
index fb55fe04ca..9d8c2a9d70 100644
--- a/ui/vnc-auth-sasl.h
+++ b/ui/vnc-auth-sasl.h
@@ -22,6 +22,8 @@
  * THE SOFTWARE.
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef QEMU_VNC_AUTH_SASL_H
 #define QEMU_VNC_AUTH_SASL_H
 
diff --git a/ui/vnc-auth-vencrypt.h b/ui/vnc-auth-vencrypt.h
index 1e35406664..5c2e746e76 100644
--- a/ui/vnc-auth-vencrypt.h
+++ b/ui/vnc-auth-vencrypt.h
@@ -24,6 +24,8 @@
  * THE SOFTWARE.
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef QEMU_VNC_AUTH_VENCRYPT_H
 #define QEMU_VNC_AUTH_VENCRYPT_H
 
diff --git a/ui/vnc-enc-hextile-template.h b/ui/vnc-enc-hextile-template.h
index 0c56262aff..2db61b9962 100644
--- a/ui/vnc-enc-hextile-template.h
+++ b/ui/vnc-enc-hextile-template.h
@@ -1,3 +1,5 @@
+/* FIXME Does not pass make check-headers, yet! */
+
 #define CONCAT_I(a, b) a ## b
 #define CONCAT(a, b) CONCAT_I(a, b)
 #define pixel_t CONCAT(uint, CONCAT(BPP, _t))
diff --git a/ui/vnc-jobs.h b/ui/vnc-jobs.h
index 59f66bcc35..2e0ef21633 100644
--- a/ui/vnc-jobs.h
+++ b/ui/vnc-jobs.h
@@ -27,6 +27,8 @@
  * THE SOFTWARE.
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef VNC_JOBS_H
 #define VNC_JOBS_H
 
diff --git a/ui/vnc-ws.h b/ui/vnc-ws.h
index 396cacfcb0..d31c72f20b 100644
--- a/ui/vnc-ws.h
+++ b/ui/vnc-ws.h
@@ -18,6 +18,8 @@
  * along with this software; if not, see <http://www.gnu.org/licenses/>.
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef QEMU_UI_VNC_WS_H
 #define QEMU_UI_VNC_WS_H
 
diff --git a/ui/vnc.h b/ui/vnc.h
index ee3da08f4a..e79b313704 100644
--- a/ui/vnc.h
+++ b/ui/vnc.h
@@ -24,6 +24,8 @@
  * THE SOFTWARE.
  */
 
+/* FIXME Does not pass make check-headers without system emulation, yet! */
+
 #ifndef QEMU_VNC_H
 #define QEMU_VNC_H
 
diff --git a/ui/vnc_keysym.h b/ui/vnc_keysym.h
index e8a2ec73c5..fd80f1a749 100644
--- a/ui/vnc_keysym.h
+++ b/ui/vnc_keysym.h
@@ -1,3 +1,4 @@
+/* FIXME Does not pass make check-headers, yet! */
 
 #include "keymaps.h"
 
diff --git a/ui/x_keymap.h b/ui/x_keymap.h
index 0395e335ff..78c0f580ce 100644
--- a/ui/x_keymap.h
+++ b/ui/x_keymap.h
@@ -22,6 +22,8 @@
  * THE SOFTWARE.
  */
 
+/* FIXME Does not pass make check-headers without CONFIG_X11, yet! */
+
 #ifndef QEMU_X_KEYMAP_H
 #define QEMU_X_KEYMAP_H
 
diff --git a/util/qemu-thread-common.h b/util/qemu-thread-common.h
index 2af6b12085..606fbf6c20 100644
--- a/util/qemu-thread-common.h
+++ b/util/qemu-thread-common.h
@@ -10,6 +10,8 @@
  * See the COPYING file in the top-level directory.
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef QEMU_THREAD_COMMON_H
 #define QEMU_THREAD_COMMON_H
 
diff --git a/win_dump.h b/win_dump.h
index b8c25348f4..7d65125b04 100644
--- a/win_dump.h
+++ b/win_dump.h
@@ -8,6 +8,8 @@
  *
  */
 
+/* FIXME Does not pass make check-headers, yet! */
+
 #ifndef WIN_DUMP_H
 #define WIN_DUMP_H
 
-- 
2.17.2


