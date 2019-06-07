Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D48CC2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 17:36:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 284F620868
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 17:36:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 284F620868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49840 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZImf-0007gE-Bl
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 13:36:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53460)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hZH0O-0003ZL-Cp
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 11:42:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hZGlr-0000VX-Ao
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 11:27:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34899)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hZGlq-000866-51
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 11:27:11 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B61F43005628
 for <qemu-devel@nongnu.org>; Fri,  7 Jun 2019 15:26:50 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-148.ams2.redhat.com
 [10.36.116.148])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 74DF4891DA
 for <qemu-devel@nongnu.org>; Fri,  7 Jun 2019 15:26:48 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0779811385FA; Fri,  7 Jun 2019 17:26:47 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri,  7 Jun 2019 17:26:38 +0200
Message-Id: <20190607152646.4822-5-armbru@redhat.com>
In-Reply-To: <20190607152646.4822-1-armbru@redhat.com>
References: <20190607152646.4822-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Fri, 07 Jun 2019 15:26:50 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 04/12] Include qemu-common.h exactly where needed
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

No header includes qemu-common.h after this commit, as prescribed by
qemu-common.h's file comment.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20190523143508.25387-5-armbru@redhat.com>
[Rebased with conflicts resolved automatically, except for
include/hw/arm/xlnx-zynqmp.h hw/arm/nrf51_soc.c hw/arm/msf2-soc.c
block/qcow2-refcount.c block/qcow2-cluster.c block/qcow2-cache.c]
---
 accel/kvm/kvm-all.c                      | 1 -
 accel/stubs/hax-stub.c                   | 1 -
 accel/stubs/hvf-stub.c                   | 1 -
 accel/stubs/kvm-stub.c                   | 1 -
 accel/stubs/whpx-stub.c                  | 1 -
 accel/tcg/cpu-exec.c                     | 2 ++
 accel/tcg/translate-all.c                | 1 +
 accel/tcg/translator.c                   | 1 -
 accel/tcg/user-exec-stub.c               | 1 -
 arch_init.c                              | 1 -
 audio/audio_legacy.c                     | 1 -
 audio/audio_pt_int.c                     | 1 -
 audio/mixeng.c                           | 1 -
 balloon.c                                | 1 -
 block/bochs.c                            | 1 -
 block/cloop.c                            | 1 -
 block/dirty-bitmap.c                     | 1 -
 block/dmg-bz2.c                          | 1 -
 block/dmg.c                              | 1 -
 block/dmg.h                              | 1 -
 block/file-posix.c                       | 1 +
 block/iscsi.c                            | 1 +
 block/linux-aio.c                        | 1 -
 block/nbd-client.h                       | 1 -
 block/qapi.c                             | 1 +
 block/qcow2-cache.c                      | 1 -
 block/qcow2-cluster.c                    | 1 -
 block/qcow2-refcount.c                   | 1 -
 block/sheepdog.c                         | 1 +
 block/vhdx-endian.c                      | 1 -
 blockjob.c                               | 1 -
 bt-vhci.c                                | 1 -
 chardev/char-fd.c                        | 1 +
 chardev/char-pipe.c                      | 1 +
 chardev/char-pty.c                       | 1 +
 contrib/ivshmem-client/ivshmem-client.c  | 1 -
 contrib/ivshmem-client/main.c            | 1 -
 contrib/ivshmem-server/ivshmem-server.c  | 1 -
 cpus.c                                   | 1 +
 crypto/aes.c                             | 1 -
 disas.c                                  | 1 -
 disas/cris.c                             | 1 -
 disas/i386.c                             | 1 -
 disas/s390.c                             | 1 -
 dump.c                                   | 1 +
 exec.c                                   | 1 +
 gdbstub.c                                | 1 +
 hmp.h                                    | 1 -
 hw/9pfs/9p-proxy.c                       | 1 +
 hw/9pfs/coth.c                           | 1 -
 hw/acpi/bios-linker-loader.c             | 1 -
 hw/acpi/tco.c                            | 1 -
 hw/alpha/pci.c                           | 1 -
 hw/arm/aspeed.c                          | 1 -
 hw/arm/boot.c                            | 1 +
 hw/arm/cubieboard.c                      | 1 -
 hw/arm/exynos4210.c                      | 1 -
 hw/arm/exynos4_boards.c                  | 1 -
 hw/arm/fsl-imx25.c                       | 1 -
 hw/arm/fsl-imx31.c                       | 1 -
 hw/arm/highbank.c                        | 1 +
 hw/arm/imx25_pdk.c                       | 1 -
 hw/arm/integratorcp.c                    | 1 -
 hw/arm/kzm.c                             | 1 -
 hw/arm/mcimx6ul-evk.c                    | 1 -
 hw/arm/mcimx7d-sabre.c                   | 1 -
 hw/arm/msf2-soc.c                        | 1 -
 hw/arm/musicpal.c                        | 1 -
 hw/arm/nrf51_soc.c                       | 1 -
 hw/arm/omap2.c                           | 1 -
 hw/arm/pxa2xx.c                          | 1 +
 hw/arm/raspi.c                           | 1 -
 hw/arm/realview.c                        | 1 -
 hw/arm/sabrelite.c                       | 1 -
 hw/arm/strongarm.c                       | 1 +
 hw/arm/sysbus-fdt.c                      | 1 -
 hw/arm/versatilepb.c                     | 1 -
 hw/arm/virt-acpi-build.c                 | 1 -
 hw/arm/virt.c                            | 1 +
 hw/arm/xilinx_zynq.c                     | 1 -
 hw/arm/xlnx-zcu102.c                     | 1 -
 hw/audio/soundhw.c                       | 1 -
 hw/block/cdrom.c                         | 1 -
 hw/bt/core.c                             | 1 -
 hw/bt/hci.c                              | 1 -
 hw/bt/hid.c                              | 1 -
 hw/bt/l2cap.c                            | 1 -
 hw/bt/sdp.c                              | 1 -
 hw/core/irq.c                            | 1 -
 hw/core/loader.c                         | 1 +
 hw/core/null-machine.c                   | 1 -
 hw/cris/axis_dev88.c                     | 1 -
 hw/cris/boot.c                           | 1 -
 hw/display/blizzard.c                    | 1 -
 hw/display/cg3.c                         | 1 +
 hw/display/edid-generate.c               | 1 -
 hw/display/edid-region.c                 | 1 -
 hw/display/qxl.h                         | 1 -
 hw/display/tcx.c                         | 1 +
 hw/display/virtio-gpu-3d.c               | 1 -
 hw/dma/etraxfs_dma.c                     | 1 -
 hw/dma/omap_dma.c                        | 1 -
 hw/dma/pl330.c                           | 1 +
 hw/dma/soc_dma.c                         | 1 -
 hw/dma/xlnx_dpdma.c                      | 1 +
 hw/hppa/pci.c                            | 1 -
 hw/i386/acpi-build.c                     | 1 -
 hw/i386/pc_sysfw.c                       | 1 +
 hw/intc/apic.c                           | 1 -
 hw/intc/sh_intc.c                        | 1 -
 hw/isa/lpc_ich9.c                        | 1 -
 hw/lm32/lm32_boards.c                    | 1 -
 hw/lm32/lm32_hwsetup.h                   | 1 -
 hw/m68k/an5206.c                         | 1 -
 hw/m68k/mcf5206.c                        | 1 -
 hw/microblaze/petalogix_ml605_mmu.c      | 1 -
 hw/microblaze/petalogix_s3adsp1800_mmu.c | 1 -
 hw/microblaze/xlnx-zynqmp-pmu.c          | 1 -
 hw/mips/boston.c                         | 1 -
 hw/mips/mips_fulong2e.c                  | 1 +
 hw/mips/mips_jazz.c                      | 1 +
 hw/misc/macio/cuda.c                     | 1 +
 hw/misc/macio/pmu.c                      | 1 +
 hw/moxie/moxiesim.c                      | 1 -
 hw/net/rocker/qmp-norocker.c             | 1 -
 hw/nios2/10m50_devboard.c                | 1 -
 hw/nios2/cpu_pic.c                       | 1 -
 hw/nvram/fw_cfg.c                        | 1 +
 hw/openrisc/openrisc_sim.c               | 1 -
 hw/pci-bridge/dec.h                      | 1 -
 hw/pci-host/prep.c                       | 1 +
 hw/pci/pci.c                             | 1 +
 hw/pci/pcie.c                            | 1 -
 hw/pci/shpc.c                            | 1 -
 hw/ppc/e500.c                            | 1 +
 hw/ppc/e500plat.c                        | 1 -
 hw/ppc/mac_newworld.c                    | 3 ++-
 hw/ppc/mac_oldworld.c                    | 2 ++
 hw/ppc/mpc8544ds.c                       | 1 -
 hw/ppc/pnv.c                             | 1 +
 hw/ppc/ppc.c                             | 1 -
 hw/ppc/ppc405_uc.c                       | 1 -
 hw/ppc/ppc_booke.c                       | 1 -
 hw/ppc/spapr.c                           | 3 ++-
 hw/ppc/spapr_pci_vfio.c                  | 1 -
 hw/ppc/spapr_rtc.c                       | 1 +
 hw/ppc/virtex_ml507.c                    | 1 +
 hw/s390x/ipl.c                           | 1 +
 hw/s390x/s390-pci-inst.c                 | 1 -
 hw/s390x/tod-qemu.c                      | 1 +
 hw/scsi/megasas.c                        | 1 +
 hw/sh4/r2d.c                             | 1 -
 hw/sh4/shix.c                            | 1 -
 hw/sparc64/niagara.c                     | 1 -
 hw/timer/exynos4210_rtc.c                | 1 +
 hw/timer/m41t80.c                        | 1 +
 hw/timer/m48t59.c                        | 1 +
 hw/timer/mc146818rtc.c                   | 1 +
 hw/timer/pl031.c                         | 1 +
 hw/timer/twl92230.c                      | 1 +
 hw/timer/xlnx-zynqmp-rtc.c               | 1 +
 hw/tpm/tpm_passthrough.c                 | 1 +
 hw/tricore/tricore_testboard.c           | 1 -
 hw/usb/ccid-card-passthru.c              | 1 +
 hw/usb/combined-packet.c                 | 1 -
 hw/usb/core.c                            | 1 -
 hw/usb/dev-mtp.c                         | 1 +
 hw/usb/hcd-musb.c                        | 1 -
 hw/usb/host-stub.c                       | 1 -
 hw/usb/libhw.c                           | 1 -
 hw/usb/redirect.c                        | 1 +
 hw/vfio/pci.h                            | 1 -
 hw/xen/xen-host-pci-device.c             | 1 -
 hw/xen/xen_pt.h                          | 1 -
 hw/xtensa/sim.c                          | 1 -
 hw/xtensa/xtensa_memory.c                | 1 -
 hw/xtensa/xtensa_memory.h                | 1 -
 include/authz/base.h                     | 1 -
 include/block/aio.h                      | 1 -
 include/block/dirty-bitmap.h             | 1 -
 include/block/write-threshold.h          | 1 -
 include/chardev/char-io.h                | 1 -
 include/crypto/random.h                  | 1 -
 include/crypto/xts.h                     | 1 -
 include/disas/disas.h                    | 1 -
 include/exec/cpu-all.h                   | 1 -
 include/exec/exec-all.h                  | 1 -
 include/hw/acpi/tco.h                    | 1 -
 include/hw/arm/allwinner-a10.h           | 1 -
 include/hw/arm/bcm2835_peripherals.h     | 1 -
 include/hw/arm/exynos4210.h              | 1 -
 include/hw/arm/virt.h                    | 1 -
 include/hw/arm/xlnx-zynqmp.h             | 1 -
 include/hw/block/fdc.h                   | 1 -
 include/hw/dma/bcm2835_dma.h             | 1 -
 include/hw/fw-path-provider.h            | 1 -
 include/hw/i2c/ppc4xx_i2c.h              | 1 -
 include/hw/i386/apic.h                   | 1 -
 include/hw/ipmi/ipmi.h                   | 1 -
 include/hw/isa/apm.h                     | 1 -
 include/hw/isa/superio.h                 | 1 -
 include/hw/lm32/lm32_pic.h               | 1 -
 include/hw/nmi.h                         | 1 -
 include/hw/pci-host/pam.h                | 1 -
 include/hw/pci/msi.h                     | 1 -
 include/hw/pci/msix.h                    | 1 -
 include/hw/pci/shpc.h                    | 1 -
 include/hw/pci/slotid_cap.h              | 1 -
 include/hw/ppc/openpic.h                 | 1 -
 include/hw/ptimer.h                      | 1 -
 include/hw/sd/sdhci.h                    | 1 -
 include/hw/sh4/sh_intc.h                 | 1 -
 include/hw/sparc/sun4m_iommu.h           | 1 -
 include/hw/sparc/sun4u_iommu.h           | 1 -
 include/hw/stream.h                      | 1 -
 include/hw/timer/m48t59.h                | 1 -
 include/hw/vfio/vfio-common.h            | 1 -
 include/hw/virtio/vhost-scsi-common.h    | 1 -
 include/hw/virtio/vhost-scsi.h           | 1 -
 include/hw/virtio/vhost-user-blk.h       | 1 -
 include/hw/virtio/vhost-user-scsi.h      | 1 -
 include/hw/xen/xen.h                     | 1 -
 include/io/channel.h                     | 1 -
 include/io/dns-resolver.h                | 1 -
 include/io/task.h                        | 1 -
 include/migration/colo.h                 | 1 -
 include/migration/failover.h             | 1 -
 include/monitor/monitor.h                | 1 -
 include/net/announce.h                   | 1 -
 include/net/filter.h                     | 1 -
 include/net/queue.h                      | 1 -
 include/net/tap.h                        | 1 -
 include/qemu-common.h                    | 4 +---
 include/qemu-io.h                        | 1 -
 include/qemu/base64.h                    | 1 -
 include/qemu/buffer.h                    | 1 -
 include/qemu/crc32c.h                    | 1 -
 include/qemu/event_notifier.h            | 1 -
 include/qemu/filemonitor.h               | 1 -
 include/qemu/mmap-alloc.h                | 1 -
 include/qemu/qdist.h                     | 1 -
 include/qemu/throttle.h                  | 1 -
 include/qemu/timer.h                     | 1 -
 include/qemu/uuid.h                      | 1 -
 include/sysemu/cryptodev-vhost.h         | 1 -
 include/sysemu/cryptodev.h               | 1 -
 include/sysemu/hax.h                     | 1 -
 include/sysemu/hvf.h                     | 1 -
 include/sysemu/qtest.h                   | 1 -
 include/sysemu/rng.h                     | 1 -
 include/sysemu/tpm_backend.h             | 1 -
 include/sysemu/whpx.h                    | 1 -
 io/channel-socket.c                      | 2 +-
 ioport.c                                 | 1 -
 job-qmp.c                                | 1 -
 job.c                                    | 1 -
 linux-user/aarch64/cpu_loop.c            | 1 +
 linux-user/alpha/cpu_loop.c              | 1 +
 linux-user/arm/cpu_loop.c                | 1 +
 linux-user/cris/cpu_loop.c               | 1 +
 linux-user/i386/cpu_loop.c               | 1 +
 linux-user/m68k/cpu_loop.c               | 1 +
 linux-user/main.c                        | 1 +
 linux-user/microblaze/cpu_loop.c         | 1 +
 linux-user/mips/cpu_loop.c               | 1 +
 linux-user/mmap.c                        | 1 -
 linux-user/openrisc/cpu_loop.c           | 1 +
 linux-user/ppc/cpu_loop.c                | 1 +
 linux-user/riscv/cpu_loop.c              | 1 +
 linux-user/s390x/cpu_loop.c              | 1 +
 linux-user/sh4/cpu_loop.c                | 1 +
 linux-user/signal.c                      | 1 -
 linux-user/sparc/cpu_loop.c              | 1 +
 linux-user/syscall.c                     | 1 -
 linux-user/tilegx/cpu_loop.c             | 1 +
 memory_mapping.c                         | 1 -
 migration/migration.h                    | 1 -
 migration/page_cache.c                   | 1 -
 migration/qemu-file.c                    | 1 -
 migration/ram.h                          | 1 -
 migration/socket.c                       | 1 -
 migration/vmstate-types.c                | 1 -
 migration/vmstate.c                      | 1 -
 net/checksum.c                           | 1 -
 net/colo-compare.c                       | 2 +-
 net/dump.c                               | 1 +
 net/eth.c                                | 1 -
 net/filter-buffer.c                      | 1 -
 net/filter-mirror.c                      | 1 -
 net/filter-rewriter.c                    | 1 -
 net/hub.h                                | 1 -
 net/l2tpv3.c                             | 1 -
 net/tap-linux.c                          | 1 +
 net/tap_int.h                            | 1 -
 os-posix.c                               | 1 +
 os-win32.c                               | 2 ++
 qapi/qapi-dealloc-visitor.c              | 1 -
 qapi/qapi-visit-core.c                   | 1 -
 qapi/qmp-event.c                         | 1 -
 qapi/qobject-input-visitor.c             | 1 -
 qapi/qobject-output-visitor.c            | 1 -
 qapi/string-input-visitor.c              | 1 -
 qemu-edid.c                              | 1 -
 qemu-img.c                               | 1 +
 qemu-io.c                                | 1 +
 qemu-keymap.c                            | 1 -
 qemu-nbd.c                               | 1 +
 qga/commands-posix.c                     | 1 +
 qga/guest-agent-core.h                   | 1 -
 qga/main.c                               | 1 +
 qmp.c                                    | 1 +
 qom/qom-qobject.c                        | 1 -
 replay/replay-events.c                   | 1 -
 replay/replay-input.c                    | 1 -
 replay/replay-internal.c                 | 1 -
 replay/replay-snapshot.c                 | 1 -
 replay/replay-time.c                     | 1 -
 scripts/modules/module_block.py          | 2 --
 scripts/qapi/events.py                   | 1 -
 scripts/qapi/visit.py                    | 2 --
 scripts/tracetool/format/h.py            | 1 -
 scripts/tracetool/format/tcg_helper_c.py | 1 -
 scripts/tracetool/format/ust_events_h.py | 1 -
 scsi/qemu-pr-helper.c                    | 1 +
 stubs/bdrv-next-monitor-owned.c          | 1 -
 stubs/blk-commit-all.c                   | 1 -
 stubs/change-state-handler.c             | 1 -
 stubs/clock-warp.c                       | 1 -
 stubs/cpu-get-clock.c                    | 1 -
 stubs/cpu-get-icount.c                   | 1 -
 stubs/dump.c                             | 1 -
 stubs/error-printf.c                     | 1 -
 stubs/fd-register.c                      | 1 -
 stubs/fdset.c                            | 1 -
 stubs/iothread-lock.c                    | 1 -
 stubs/is-daemonized.c                    | 1 -
 stubs/machine-init-done.c                | 1 -
 stubs/migr-blocker.c                     | 1 -
 stubs/monitor.c                          | 1 -
 stubs/notify-event.c                     | 1 -
 stubs/set-fd-handler.c                   | 1 -
 stubs/uuid.c                             | 1 -
 stubs/vm-stop.c                          | 1 -
 stubs/vmstate.c                          | 1 -
 stubs/xen-common.c                       | 1 -
 stubs/xen-hvm.c                          | 1 -
 target/alpha/cpu.c                       | 1 -
 target/alpha/cpu.h                       | 1 -
 target/alpha/gdbstub.c                   | 1 -
 target/alpha/machine.c                   | 1 -
 target/arm/arm-semi.c                    | 1 -
 target/arm/cpu.c                         | 1 +
 target/arm/cpu.h                         | 1 -
 target/arm/gdbstub.c                     | 1 -
 target/arm/gdbstub64.c                   | 1 -
 target/arm/kvm-stub.c                    | 1 -
 target/arm/machine.c                     | 1 -
 target/cris/cpu.c                        | 1 -
 target/cris/cpu.h                        | 1 -
 target/cris/gdbstub.c                    | 1 -
 target/cris/machine.c                    | 1 -
 target/hppa/cpu.h                        | 1 -
 target/hppa/gdbstub.c                    | 1 -
 target/hppa/machine.c                    | 1 -
 target/i386/gdbstub.c                    | 1 -
 target/i386/kvm-stub.c                   | 1 -
 target/i386/kvm.c                        | 1 -
 target/i386/sev-stub.c                   | 1 -
 target/i386/xsave_helper.c               | 1 -
 target/lm32/cpu.c                        | 1 -
 target/lm32/cpu.h                        | 1 -
 target/lm32/gdbstub.c                    | 1 -
 target/lm32/machine.c                    | 1 -
 target/m68k/cpu.c                        | 1 -
 target/m68k/cpu.h                        | 1 -
 target/m68k/gdbstub.c                    | 1 -
 target/m68k/m68k-semi.c                  | 1 -
 target/microblaze/cpu.h                  | 1 -
 target/microblaze/gdbstub.c              | 1 -
 target/mips/cpu.h                        | 1 -
 target/mips/gdbstub.c                    | 1 -
 target/mips/machine.c                    | 1 -
 target/moxie/cpu.c                       | 1 -
 target/moxie/cpu.h                       | 1 -
 target/moxie/machine.c                   | 1 -
 target/nios2/cpu.h                       | 1 -
 target/nios2/mmu.c                       | 1 -
 target/openrisc/cpu.c                    | 1 -
 target/openrisc/cpu.h                    | 1 -
 target/openrisc/disas.c                  | 1 -
 target/openrisc/exception.h              | 1 -
 target/openrisc/gdbstub.c                | 1 -
 target/openrisc/interrupt.c              | 1 -
 target/openrisc/machine.c                | 1 -
 target/openrisc/mmu.c                    | 1 -
 target/openrisc/translate.c              | 1 -
 target/ppc/cpu.h                         | 1 -
 target/ppc/gdbstub.c                     | 1 -
 target/ppc/kvm-stub.c                    | 1 -
 target/ppc/machine.c                     | 1 -
 target/riscv/cpu.h                       | 1 -
 target/riscv/gdbstub.c                   | 1 -
 target/riscv/pmp.c                       | 1 -
 target/s390x/cpu.h                       | 1 -
 target/s390x/kvm-stub.c                  | 1 -
 target/s390x/vec_helper.c                | 1 -
 target/sh4/cpu.c                         | 1 -
 target/sh4/cpu.h                         | 1 -
 target/sh4/gdbstub.c                     | 1 -
 target/sparc/cpu.h                       | 1 -
 target/sparc/gdbstub.c                   | 1 -
 target/sparc/machine.c                   | 1 -
 target/tilegx/cpu.h                      | 1 -
 target/tilegx/helper.c                   | 1 -
 target/tilegx/simd_helper.c              | 1 -
 target/tricore/cpu.c                     | 1 -
 target/tricore/cpu.h                     | 1 -
 target/unicore32/cpu.c                   | 1 -
 target/unicore32/cpu.h                   | 1 -
 target/xtensa/core-dc233c.c              | 1 -
 target/xtensa/core-de212.c               | 1 -
 target/xtensa/core-fsf.c                 | 1 -
 target/xtensa/core-sample_controller.c   | 1 -
 target/xtensa/core-test_kc705_be.c       | 1 -
 target/xtensa/cpu.h                      | 1 -
 target/xtensa/gdbstub.c                  | 1 -
 tcg/optimize.c                           | 1 -
 tcg/tcg-common.c                         | 1 -
 tcg/tcg-op-gvec.c                        | 1 -
 tcg/tcg-op-vec.c                         | 1 -
 tcg/tcg-op.c                             | 1 -
 tcg/tcg.h                                | 1 -
 tests/crypto-tls-psk-helpers.h           | 1 -
 tests/crypto-tls-x509-helpers.h          | 1 -
 tests/e1000e-test.c                      | 1 +
 tests/test-filter-mirror.c               | 1 +
 tests/test-filter-redirector.c           | 1 +
 tests/virtio-net-test.c                  | 1 +
 trace/control.h                          | 1 -
 ui/console-gl.c                          | 1 -
 ui/cursor.c                              | 1 -
 ui/egl-context.c                         | 1 -
 ui/gtk-egl.c                             | 1 -
 ui/gtk-gl-area.c                         | 1 -
 ui/gtk.c                                 | 1 -
 ui/keymaps.c                             | 1 +
 ui/keymaps.h                             | 1 -
 ui/qemu-pixman.c                         | 1 -
 ui/sdl2-2d.c                             | 1 -
 ui/sdl2-gl.c                             | 1 -
 ui/sdl2-input.c                          | 1 -
 ui/shader.c                              | 1 -
 ui/spice-input.c                         | 1 -
 ui/vnc-enc-tight.c                       | 1 -
 ui/vnc.h                                 | 1 -
 util/aio-posix.c                         | 1 -
 util/async.c                             | 1 -
 util/bufferiszero.c                      | 1 -
 util/compatfd.c                          | 1 -
 util/coroutine-ucontext.c                | 1 -
 util/crc32c.c                            | 1 -
 util/cutils.c                            | 1 +
 util/envlist.c                           | 1 -
 util/error.c                             | 1 -
 util/fifo8.c                             | 1 -
 util/getauxval.c                         | 1 -
 util/guest-random.c                      | 1 -
 util/iohandler.c                         | 1 -
 util/log.c                               | 1 -
 util/module.c                            | 1 -
 util/notify.c                            | 1 -
 util/oslib-posix.c                       | 1 +
 util/oslib-win32.c                       | 2 ++
 util/qemu-config.c                       | 1 -
 util/qemu-coroutine-lock.c               | 1 -
 util/qemu-coroutine.c                    | 1 -
 util/qemu-option.c                       | 1 -
 util/qemu-sockets.c                      | 1 +
 util/rcu.c                               | 1 -
 util/thread-pool.c                       | 1 -
 util/uuid.c                              | 1 -
 vl.c                                     | 1 +
 win_dump.c                               | 1 +
 483 files changed, 101 insertions(+), 397 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 524c4ddfbd..b0c4bed6e3 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -18,7 +18,6 @@
=20
 #include <linux/kvm.h>
=20
-#include "qemu-common.h"
 #include "qemu/atomic.h"
 #include "qemu/option.h"
 #include "qemu/config-file.h"
diff --git a/accel/stubs/hax-stub.c b/accel/stubs/hax-stub.c
index c0e6f892e5..7ad190cae2 100644
--- a/accel/stubs/hax-stub.c
+++ b/accel/stubs/hax-stub.c
@@ -14,7 +14,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "cpu.h"
 #include "sysemu/hax.h"
=20
diff --git a/accel/stubs/hvf-stub.c b/accel/stubs/hvf-stub.c
index a79f9fc36f..e81dfe888c 100644
--- a/accel/stubs/hvf-stub.c
+++ b/accel/stubs/hvf-stub.c
@@ -12,7 +12,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "cpu.h"
 #include "sysemu/hvf.h"
=20
diff --git a/accel/stubs/kvm-stub.c b/accel/stubs/kvm-stub.c
index 02d5170031..6feb66ed80 100644
--- a/accel/stubs/kvm-stub.c
+++ b/accel/stubs/kvm-stub.c
@@ -11,7 +11,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "cpu.h"
 #include "sysemu/kvm.h"
=20
diff --git a/accel/stubs/whpx-stub.c b/accel/stubs/whpx-stub.c
index 5fb049c281..1efb89f25e 100644
--- a/accel/stubs/whpx-stub.c
+++ b/accel/stubs/whpx-stub.c
@@ -9,7 +9,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "cpu.h"
 #include "sysemu/whpx.h"
=20
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 45ef41ebb2..159397fbd4 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -16,7 +16,9 @@
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
  */
+
 #include "qemu/osdep.h"
+#include "qemu-common.h"
 #include "cpu.h"
 #include "trace.h"
 #include "disas/disas.h"
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 5f832d788f..3be1bbf36d 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -18,6 +18,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu-common.h"
=20
 #define NO_CPU_IO_DEFS
 #include "cpu.h"
diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index 8d65ead708..9226a348a3 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -8,7 +8,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "qemu/error-report.h"
 #include "cpu.h"
 #include "tcg/tcg.h"
diff --git a/accel/tcg/user-exec-stub.c b/accel/tcg/user-exec-stub.c
index a32b4496af..4bf00b8496 100644
--- a/accel/tcg/user-exec-stub.c
+++ b/accel/tcg/user-exec-stub.c
@@ -1,5 +1,4 @@
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "qom/cpu.h"
 #include "sysemu/replay.h"
 #include "sysemu/sysemu.h"
diff --git a/arch_init.c b/arch_init.c
index f4f3f610c8..74b0708634 100644
--- a/arch_init.c
+++ b/arch_init.c
@@ -22,7 +22,6 @@
  * THE SOFTWARE.
  */
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "cpu.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/arch_init.h"
diff --git a/audio/audio_legacy.c b/audio/audio_legacy.c
index 2fd58cb8ef..ebd7d9fa0d 100644
--- a/audio/audio_legacy.c
+++ b/audio/audio_legacy.c
@@ -24,7 +24,6 @@
 #include "qemu/osdep.h"
 #include "audio.h"
 #include "audio_int.h"
-#include "qemu-common.h"
 #include "qemu/cutils.h"
 #include "qemu/timer.h"
 #include "qapi/error.h"
diff --git a/audio/audio_pt_int.c b/audio/audio_pt_int.c
index 3fe56d8514..9f9d44ad4a 100644
--- a/audio/audio_pt_int.c
+++ b/audio/audio_pt_int.c
@@ -1,5 +1,4 @@
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "audio.h"
=20
 #define AUDIO_CAP "audio-pt"
diff --git a/audio/mixeng.c b/audio/mixeng.c
index 2ab22df2aa..2f5ba71381 100644
--- a/audio/mixeng.c
+++ b/audio/mixeng.c
@@ -23,7 +23,6 @@
  * THE SOFTWARE.
  */
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "qemu/bswap.h"
 #include "qemu/error-report.h"
 #include "audio.h"
diff --git a/balloon.c b/balloon.c
index 9319879838..914b3662db 100644
--- a/balloon.c
+++ b/balloon.c
@@ -25,7 +25,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "qemu/atomic.h"
 #include "exec/cpu-common.h"
 #include "sysemu/kvm.h"
diff --git a/block/bochs.c b/block/bochs.c
index 79f95d3b50..962f18592d 100644
--- a/block/bochs.c
+++ b/block/bochs.c
@@ -24,7 +24,6 @@
  */
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qemu-common.h"
 #include "block/block_int.h"
 #include "qemu/module.h"
 #include "qemu/bswap.h"
diff --git a/block/cloop.c b/block/cloop.c
index df2b85f723..384c9735bb 100644
--- a/block/cloop.c
+++ b/block/cloop.c
@@ -24,7 +24,6 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
-#include "qemu-common.h"
 #include "block/block_int.h"
 #include "qemu/module.h"
 #include "qemu/bswap.h"
diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index 49646a30e6..95a9c2a5d8 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -23,7 +23,6 @@
  */
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qemu-common.h"
 #include "trace.h"
 #include "block/block_int.h"
 #include "block/blockjob.h"
diff --git a/block/dmg-bz2.c b/block/dmg-bz2.c
index 9059492a9f..37f7ee04be 100644
--- a/block/dmg-bz2.c
+++ b/block/dmg-bz2.c
@@ -23,7 +23,6 @@
  * THE SOFTWARE.
  */
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "dmg.h"
 #include <bzlib.h>
=20
diff --git a/block/dmg.c b/block/dmg.c
index 43497bf343..45f6b28f17 100644
--- a/block/dmg.c
+++ b/block/dmg.c
@@ -23,7 +23,6 @@
  */
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qemu-common.h"
 #include "block/block_int.h"
 #include "qemu/bswap.h"
 #include "qemu/error-report.h"
diff --git a/block/dmg.h b/block/dmg.h
index f28929998f..e488601b62 100644
--- a/block/dmg.h
+++ b/block/dmg.h
@@ -26,7 +26,6 @@
 #ifndef BLOCK_DMG_H
 #define BLOCK_DMG_H
=20
-#include "qemu-common.h"
 #include "block/block_int.h"
 #include <zlib.h>
=20
diff --git a/block/file-posix.c b/block/file-posix.c
index d018429672..6e6bf3f4a5 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -23,6 +23,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu-common.h"
 #include "qapi/error.h"
 #include "qemu/cutils.h"
 #include "qemu/error-report.h"
diff --git a/block/iscsi.c b/block/iscsi.c
index cf9d66c07f..267f160bf6 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -28,6 +28,7 @@
 #include <poll.h>
 #include <math.h>
 #include <arpa/inet.h>
+#include "qemu-common.h"
 #include "qemu/config-file.h"
 #include "qemu/error-report.h"
 #include "qemu/bitops.h"
diff --git a/block/linux-aio.c b/block/linux-aio.c
index 27100c2fd1..c7eca9a256 100644
--- a/block/linux-aio.c
+++ b/block/linux-aio.c
@@ -8,7 +8,6 @@
  * See the COPYING file in the top-level directory.
  */
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "block/aio.h"
 #include "qemu/queue.h"
 #include "block/block.h"
diff --git a/block/nbd-client.h b/block/nbd-client.h
index 09e03013d2..4587053114 100644
--- a/block/nbd-client.h
+++ b/block/nbd-client.h
@@ -1,7 +1,6 @@
 #ifndef NBD_CLIENT_H
 #define NBD_CLIENT_H
=20
-#include "qemu-common.h"
 #include "block/nbd.h"
 #include "block/block_int.h"
 #include "io/channel-socket.h"
diff --git a/block/qapi.c b/block/qapi.c
index 0c13c86f4e..917435f022 100644
--- a/block/qapi.c
+++ b/block/qapi.c
@@ -23,6 +23,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu-common.h"
 #include "block/qapi.h"
 #include "block/block_int.h"
 #include "block/throttle-groups.h"
diff --git a/block/qcow2-cache.c b/block/qcow2-cache.c
index b33bcbc984..d29b038a67 100644
--- a/block/qcow2-cache.c
+++ b/block/qcow2-cache.c
@@ -23,7 +23,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "qcow2.h"
 #include "trace.h"
=20
diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index cf892f37a8..cc5609e27a 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -26,7 +26,6 @@
 #include <zlib.h>
=20
 #include "qapi/error.h"
-#include "qemu-common.h"
 #include "qcow2.h"
 #include "qemu/bswap.h"
 #include "trace.h"
diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index 22cadd79d5..ef965d7895 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -24,7 +24,6 @@
=20
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qemu-common.h"
 #include "qcow2.h"
 #include "qemu/range.h"
 #include "qemu/bswap.h"
diff --git a/block/sheepdog.c b/block/sheepdog.c
index 1e2d824a58..6f402e5d4d 100644
--- a/block/sheepdog.c
+++ b/block/sheepdog.c
@@ -13,6 +13,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu-common.h"
 #include "qapi/error.h"
 #include "qapi/qapi-visit-sockets.h"
 #include "qapi/qapi-visit-block-core.h"
diff --git a/block/vhdx-endian.c b/block/vhdx-endian.c
index ebfa33cb8a..52c8027d99 100644
--- a/block/vhdx-endian.c
+++ b/block/vhdx-endian.c
@@ -16,7 +16,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "block/block_int.h"
 #include "qemu/bswap.h"
 #include "vhdx.h"
diff --git a/blockjob.c b/blockjob.c
index 931d675c0c..1fac6bb8a7 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -24,7 +24,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "block/block.h"
 #include "block/blockjob_int.h"
 #include "block/block_int.h"
diff --git a/bt-vhci.c b/bt-vhci.c
index 9d277c32bf..886e146743 100644
--- a/bt-vhci.c
+++ b/bt-vhci.c
@@ -18,7 +18,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "sysemu/bt.h"
 #include "hw/bt.h"
 #include "qemu/main-loop.h"
diff --git a/chardev/char-fd.c b/chardev/char-fd.c
index 32092369bf..c2d8101106 100644
--- a/chardev/char-fd.c
+++ b/chardev/char-fd.c
@@ -23,6 +23,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu-common.h"
 #include "qemu/module.h"
 #include "qemu/sockets.h"
 #include "qapi/error.h"
diff --git a/chardev/char-pipe.c b/chardev/char-pipe.c
index cdaddb1e61..b200f9365c 100644
--- a/chardev/char-pipe.c
+++ b/chardev/char-pipe.c
@@ -23,6 +23,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu-common.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
 #include "qemu/option.h"
diff --git a/chardev/char-pty.c b/chardev/char-pty.c
index 8b34ce985a..1cc501a481 100644
--- a/chardev/char-pty.c
+++ b/chardev/char-pty.c
@@ -23,6 +23,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu-common.h"
 #include "qapi/error.h"
 #include "chardev/char.h"
 #include "io/channel-file.h"
diff --git a/contrib/ivshmem-client/ivshmem-client.c b/contrib/ivshmem-cl=
ient/ivshmem-client.c
index 44ae3646e1..b1274b236a 100644
--- a/contrib/ivshmem-client/ivshmem-client.c
+++ b/contrib/ivshmem-client/ivshmem-client.c
@@ -10,7 +10,6 @@
 #include <sys/socket.h>
 #include <sys/un.h>
=20
-#include "qemu-common.h"
 #include "qemu/queue.h"
=20
 #include "ivshmem-client.h"
diff --git a/contrib/ivshmem-client/main.c b/contrib/ivshmem-client/main.=
c
index 33ae1daa15..21f38f3fec 100644
--- a/contrib/ivshmem-client/main.c
+++ b/contrib/ivshmem-client/main.c
@@ -7,7 +7,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "qemu-common.h"
=20
 #include "ivshmem-client.h"
=20
diff --git a/contrib/ivshmem-server/ivshmem-server.c b/contrib/ivshmem-se=
rver/ivshmem-server.c
index e2f295bd43..77f97b209c 100644
--- a/contrib/ivshmem-server/ivshmem-server.c
+++ b/contrib/ivshmem-server/ivshmem-server.c
@@ -6,7 +6,6 @@
  * top-level directory.
  */
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "qemu/host-utils.h"
 #include "qemu/sockets.h"
=20
diff --git a/cpus.c b/cpus.c
index 3d30a76c13..874ea63ef7 100644
--- a/cpus.c
+++ b/cpus.c
@@ -23,6 +23,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu-common.h"
 #include "qemu/config-file.h"
 #include "cpu.h"
 #include "monitor/monitor.h"
diff --git a/crypto/aes.c b/crypto/aes.c
index 86b3092324..0f6a195af8 100644
--- a/crypto/aes.c
+++ b/crypto/aes.c
@@ -28,7 +28,6 @@
  * EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "crypto/aes.h"
=20
 typedef uint32_t u32;
diff --git a/disas.c b/disas.c
index 41ad0102e2..3e2bfa572b 100644
--- a/disas.c
+++ b/disas.c
@@ -1,6 +1,5 @@
 /* General "disassemble this chunk" code.  Used for debugging. */
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "disas/dis-asm.h"
 #include "elf.h"
 #include "qemu/qemu-print.h"
diff --git a/disas/cris.c b/disas/cris.c
index bf9eafc415..2f43c9b209 100644
--- a/disas/cris.c
+++ b/disas/cris.c
@@ -19,7 +19,6 @@
    along with this program; if not, see <http://www.gnu.org/licenses/>. =
*/
=20
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "disas/dis-asm.h"
 #include "target/cris/opcode-cris.h"
=20
diff --git a/disas/i386.c b/disas/i386.c
index 4c1f0f877b..06c835236e 100644
--- a/disas/i386.c
+++ b/disas/i386.c
@@ -153,7 +153,6 @@
 #define MAX_REG_NAME_SIZE 8
=20
 /* opcodes/i386-dis.c r1.126 */
-#include "qemu-common.h"
=20
 static int fetch_data2(struct disassemble_info *, bfd_byte *);
 static int fetch_data(struct disassemble_info *, bfd_byte *);
diff --git a/disas/s390.c b/disas/s390.c
index b1f4e2a0c1..a9ec8fa593 100644
--- a/disas/s390.c
+++ b/disas/s390.c
@@ -21,7 +21,6 @@
    02110-1301, USA.  */
=20
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "disas/dis-asm.h"
=20
 /* include/opcode/s390.h revision 1.9 */
diff --git a/dump.c b/dump.c
index 107a67165a..e99554628c 100644
--- a/dump.c
+++ b/dump.c
@@ -12,6 +12,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu-common.h"
 #include "qemu/cutils.h"
 #include "elf.h"
 #include "cpu.h"
diff --git a/exec.c b/exec.c
index 0bc59e9a30..e7622d1956 100644
--- a/exec.c
+++ b/exec.c
@@ -18,6 +18,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu-common.h"
 #include "qapi/error.h"
=20
 #include "qemu/cutils.h"
diff --git a/gdbstub.c b/gdbstub.c
index 1ba80f09f6..17dcd9186d 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -18,6 +18,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu-common.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qemu/ctype.h"
diff --git a/hmp.h b/hmp.h
index 43617f2646..1d095d5837 100644
--- a/hmp.h
+++ b/hmp.h
@@ -14,7 +14,6 @@
 #ifndef HMP_H
 #define HMP_H
=20
-#include "qemu-common.h"
 #include "qemu/readline.h"
=20
 void hmp_info_name(Monitor *mon, const QDict *qdict);
diff --git a/hw/9pfs/9p-proxy.c b/hw/9pfs/9p-proxy.c
index 47a94e088d..57a8c1c808 100644
--- a/hw/9pfs/9p-proxy.c
+++ b/hw/9pfs/9p-proxy.c
@@ -13,6 +13,7 @@
 #include "qemu/osdep.h"
 #include <sys/socket.h>
 #include <sys/un.h>
+#include "qemu-common.h"
 #include "9p.h"
 #include "qapi/error.h"
 #include "qemu/cutils.h"
diff --git a/hw/9pfs/coth.c b/hw/9pfs/coth.c
index 89018de6bf..c3b43368f8 100644
--- a/hw/9pfs/coth.c
+++ b/hw/9pfs/coth.c
@@ -13,7 +13,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "block/thread-pool.h"
 #include "qemu/coroutine.h"
 #include "coth.h"
diff --git a/hw/acpi/bios-linker-loader.c b/hw/acpi/bios-linker-loader.c
index 626c04a39f..108061828b 100644
--- a/hw/acpi/bios-linker-loader.c
+++ b/hw/acpi/bios-linker-loader.c
@@ -19,7 +19,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "hw/acpi/bios-linker-loader.h"
 #include "hw/nvram/fw_cfg.h"
=20
diff --git a/hw/acpi/tco.c b/hw/acpi/tco.c
index a9143963ab..acfb65e8f2 100644
--- a/hw/acpi/tco.c
+++ b/hw/acpi/tco.c
@@ -7,7 +7,6 @@
  * See the COPYING file in the top-level directory.
  */
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "sysemu/watchdog.h"
 #include "hw/i386/ich9.h"
=20
diff --git a/hw/alpha/pci.c b/hw/alpha/pci.c
index 8dde637bfe..fb902bb92d 100644
--- a/hw/alpha/pci.c
+++ b/hw/alpha/pci.c
@@ -7,7 +7,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "alpha_sys.h"
 #include "qemu/log.h"
 #include "sysemu/sysemu.h"
diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 33070a6df8..d2ad2da24b 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -11,7 +11,6 @@
=20
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qemu-common.h"
 #include "cpu.h"
 #include "exec/address-spaces.h"
 #include "hw/arm/boot.h"
diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index 7279185bd9..0261fdabab 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -8,6 +8,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu-common.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include <libfdt.h>
diff --git a/hw/arm/cubieboard.c b/hw/arm/cubieboard.c
index 84187d3916..f7c8a5985a 100644
--- a/hw/arm/cubieboard.c
+++ b/hw/arm/cubieboard.c
@@ -17,7 +17,6 @@
=20
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qemu-common.h"
 #include "cpu.h"
 #include "hw/sysbus.h"
 #include "hw/boards.h"
diff --git a/hw/arm/exynos4210.c b/hw/arm/exynos4210.c
index e99e9cd11b..becd864c19 100644
--- a/hw/arm/exynos4210.c
+++ b/hw/arm/exynos4210.c
@@ -23,7 +23,6 @@
=20
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qemu-common.h"
 #include "qemu/log.h"
 #include "cpu.h"
 #include "hw/cpu/a9mpcore.h"
diff --git a/hw/arm/exynos4_boards.c b/hw/arm/exynos4_boards.c
index 71f58586c1..ac0b0dc2a9 100644
--- a/hw/arm/exynos4_boards.c
+++ b/hw/arm/exynos4_boards.c
@@ -25,7 +25,6 @@
 #include "qemu/units.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
-#include "qemu-common.h"
 #include "cpu.h"
 #include "sysemu/sysemu.h"
 #include "hw/sysbus.h"
diff --git a/hw/arm/fsl-imx25.c b/hw/arm/fsl-imx25.c
index bd07040a4a..869ee89b15 100644
--- a/hw/arm/fsl-imx25.c
+++ b/hw/arm/fsl-imx25.c
@@ -24,7 +24,6 @@
=20
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qemu-common.h"
 #include "cpu.h"
 #include "hw/arm/fsl-imx25.h"
 #include "sysemu/sysemu.h"
diff --git a/hw/arm/fsl-imx31.c b/hw/arm/fsl-imx31.c
index ec8239a967..662fe78f1b 100644
--- a/hw/arm/fsl-imx31.c
+++ b/hw/arm/fsl-imx31.c
@@ -21,7 +21,6 @@
=20
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qemu-common.h"
 #include "cpu.h"
 #include "hw/arm/fsl-imx31.h"
 #include "sysemu/sysemu.h"
diff --git a/hw/arm/highbank.c b/hw/arm/highbank.c
index a89a1d3a7c..72ca78108a 100644
--- a/hw/arm/highbank.c
+++ b/hw/arm/highbank.c
@@ -18,6 +18,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu-common.h"
 #include "qapi/error.h"
 #include "hw/sysbus.h"
 #include "hw/arm/boot.h"
diff --git a/hw/arm/imx25_pdk.c b/hw/arm/imx25_pdk.c
index a0423ffb67..5d673e47bc 100644
--- a/hw/arm/imx25_pdk.c
+++ b/hw/arm/imx25_pdk.c
@@ -25,7 +25,6 @@
=20
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qemu-common.h"
 #include "cpu.h"
 #include "hw/arm/fsl-imx25.h"
 #include "hw/boards.h"
diff --git a/hw/arm/integratorcp.c b/hw/arm/integratorcp.c
index d18caab8bd..200c0107f0 100644
--- a/hw/arm/integratorcp.c
+++ b/hw/arm/integratorcp.c
@@ -9,7 +9,6 @@
=20
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qemu-common.h"
 #include "cpu.h"
 #include "hw/sysbus.h"
 #include "hw/boards.h"
diff --git a/hw/arm/kzm.c b/hw/arm/kzm.c
index 44cba8782b..59d2102dc5 100644
--- a/hw/arm/kzm.c
+++ b/hw/arm/kzm.c
@@ -15,7 +15,6 @@
=20
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qemu-common.h"
 #include "cpu.h"
 #include "hw/arm/fsl-imx31.h"
 #include "hw/boards.h"
diff --git a/hw/arm/mcimx6ul-evk.c b/hw/arm/mcimx6ul-evk.c
index fb2b015bf6..31511059e4 100644
--- a/hw/arm/mcimx6ul-evk.c
+++ b/hw/arm/mcimx6ul-evk.c
@@ -12,7 +12,6 @@
=20
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qemu-common.h"
 #include "hw/arm/fsl-imx6ul.h"
 #include "hw/boards.h"
 #include "sysemu/sysemu.h"
diff --git a/hw/arm/mcimx7d-sabre.c b/hw/arm/mcimx7d-sabre.c
index 9c5f0e70c3..d6b190d85d 100644
--- a/hw/arm/mcimx7d-sabre.c
+++ b/hw/arm/mcimx7d-sabre.c
@@ -14,7 +14,6 @@
=20
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qemu-common.h"
 #include "hw/arm/fsl-imx7.h"
 #include "hw/boards.h"
 #include "sysemu/sysemu.h"
diff --git a/hw/arm/msf2-soc.c b/hw/arm/msf2-soc.c
index d700b212f8..1ccb644df7 100644
--- a/hw/arm/msf2-soc.c
+++ b/hw/arm/msf2-soc.c
@@ -25,7 +25,6 @@
 #include "qemu/osdep.h"
 #include "qemu/units.h"
 #include "qapi/error.h"
-#include "qemu-common.h"
 #include "exec/address-spaces.h"
 #include "hw/char/serial.h"
 #include "hw/boards.h"
diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
index 5645997b56..95d56f3208 100644
--- a/hw/arm/musicpal.c
+++ b/hw/arm/musicpal.c
@@ -11,7 +11,6 @@
=20
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qemu-common.h"
 #include "cpu.h"
 #include "hw/sysbus.h"
 #include "hw/arm/boot.h"
diff --git a/hw/arm/nrf51_soc.c b/hw/arm/nrf51_soc.c
index ce618edc7b..fc067cd8ee 100644
--- a/hw/arm/nrf51_soc.c
+++ b/hw/arm/nrf51_soc.c
@@ -10,7 +10,6 @@
=20
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qemu-common.h"
 #include "hw/arm/boot.h"
 #include "hw/sysbus.h"
 #include "hw/boards.h"
diff --git a/hw/arm/omap2.c b/hw/arm/omap2.c
index 23e72db79e..87ced7f3a2 100644
--- a/hw/arm/omap2.c
+++ b/hw/arm/omap2.c
@@ -21,7 +21,6 @@
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
-#include "qemu-common.h"
 #include "cpu.h"
 #include "sysemu/qtest.h"
 #include "hw/boards.h"
diff --git a/hw/arm/pxa2xx.c b/hw/arm/pxa2xx.c
index 432876958d..e2e43ae6e8 100644
--- a/hw/arm/pxa2xx.c
+++ b/hw/arm/pxa2xx.c
@@ -8,6 +8,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu-common.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
 #include "qapi/error.h"
diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index 8c249fcabb..cb23330940 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -14,7 +14,6 @@
 #include "qemu/osdep.h"
 #include "qemu/units.h"
 #include "qapi/error.h"
-#include "qemu-common.h"
 #include "cpu.h"
 #include "hw/arm/bcm2836.h"
 #include "qemu/error-report.h"
diff --git a/hw/arm/realview.c b/hw/arm/realview.c
index d42a76e7a1..12d6e93a35 100644
--- a/hw/arm/realview.c
+++ b/hw/arm/realview.c
@@ -9,7 +9,6 @@
=20
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qemu-common.h"
 #include "cpu.h"
 #include "hw/sysbus.h"
 #include "hw/arm/boot.h"
diff --git a/hw/arm/sabrelite.c b/hw/arm/sabrelite.c
index f1b00de229..97230ac827 100644
--- a/hw/arm/sabrelite.c
+++ b/hw/arm/sabrelite.c
@@ -12,7 +12,6 @@
=20
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qemu-common.h"
 #include "hw/arm/fsl-imx6.h"
 #include "hw/boards.h"
 #include "sysemu/sysemu.h"
diff --git a/hw/arm/strongarm.c b/hw/arm/strongarm.c
index a1ecbddaab..fed51a8183 100644
--- a/hw/arm/strongarm.c
+++ b/hw/arm/strongarm.c
@@ -28,6 +28,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu-common.h"
 #include "cpu.h"
 #include "hw/boards.h"
 #include "hw/sysbus.h"
diff --git a/hw/arm/sysbus-fdt.c b/hw/arm/sysbus-fdt.c
index ad698d4832..57f94e6581 100644
--- a/hw/arm/sysbus-fdt.c
+++ b/hw/arm/sysbus-fdt.c
@@ -24,7 +24,6 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include <libfdt.h>
-#include "qemu-common.h"
 #ifdef CONFIG_LINUX
 #include <linux/vfio.h>
 #endif
diff --git a/hw/arm/versatilepb.c b/hw/arm/versatilepb.c
index f471fb7025..e5857117ac 100644
--- a/hw/arm/versatilepb.c
+++ b/hw/arm/versatilepb.c
@@ -9,7 +9,6 @@
=20
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qemu-common.h"
 #include "cpu.h"
 #include "hw/sysbus.h"
 #include "hw/arm/boot.h"
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 4a64f9985c..9e8b84988d 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -28,7 +28,6 @@
=20
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qemu-common.h"
 #include "qemu/bitmap.h"
 #include "trace.h"
 #include "qom/cpu.h"
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index fae6779de3..431e2900fd 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -29,6 +29,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu-common.h"
 #include "qemu/units.h"
 #include "qemu/option.h"
 #include "qapi/error.h"
diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
index 198e3f9763..89da34808b 100644
--- a/hw/arm/xilinx_zynq.c
+++ b/hw/arm/xilinx_zynq.c
@@ -17,7 +17,6 @@
=20
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qemu-common.h"
 #include "cpu.h"
 #include "hw/sysbus.h"
 #include "hw/arm/boot.h"
diff --git a/hw/arm/xlnx-zcu102.c b/hw/arm/xlnx-zcu102.c
index c802f26fbd..044d3394c0 100644
--- a/hw/arm/xlnx-zcu102.c
+++ b/hw/arm/xlnx-zcu102.c
@@ -17,7 +17,6 @@
=20
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qemu-common.h"
 #include "cpu.h"
 #include "hw/arm/xlnx-zynqmp.h"
 #include "hw/boards.h"
diff --git a/hw/audio/soundhw.c b/hw/audio/soundhw.c
index e698909d34..c750473c8f 100644
--- a/hw/audio/soundhw.c
+++ b/hw/audio/soundhw.c
@@ -22,7 +22,6 @@
  * THE SOFTWARE.
  */
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "qemu/help_option.h"
 #include "qemu/error-report.h"
 #include "qom/object.h"
diff --git a/hw/block/cdrom.c b/hw/block/cdrom.c
index da937fe33a..c6bfa50ad0 100644
--- a/hw/block/cdrom.c
+++ b/hw/block/cdrom.c
@@ -26,7 +26,6 @@
    here.  */
=20
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "hw/scsi/scsi.h"
=20
 static void lba_to_msf(uint8_t *buf, int lba)
diff --git a/hw/bt/core.c b/hw/bt/core.c
index 78370e64f5..dfb196e2a4 100644
--- a/hw/bt/core.c
+++ b/hw/bt/core.c
@@ -19,7 +19,6 @@
=20
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
-#include "qemu-common.h"
 #include "sysemu/bt.h"
 #include "hw/bt.h"
=20
diff --git a/hw/bt/hci.c b/hw/bt/hci.c
index c6b2cc1d48..c7958f6c35 100644
--- a/hw/bt/hci.c
+++ b/hw/bt/hci.c
@@ -21,7 +21,6 @@
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
-#include "qemu-common.h"
 #include "qemu/timer.h"
 #include "hw/usb.h"
 #include "sysemu/bt.h"
diff --git a/hw/bt/hid.c b/hw/bt/hid.c
index 056291f9b5..066ca99ed2 100644
--- a/hw/bt/hid.c
+++ b/hw/bt/hid.c
@@ -19,7 +19,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "qemu/timer.h"
 #include "ui/console.h"
 #include "hw/input/hid.h"
diff --git a/hw/bt/l2cap.c b/hw/bt/l2cap.c
index 9cf27f0df6..d67098a719 100644
--- a/hw/bt/l2cap.c
+++ b/hw/bt/l2cap.c
@@ -19,7 +19,6 @@
=20
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
-#include "qemu-common.h"
 #include "qemu/timer.h"
 #include "qemu/bswap.h"
 #include "hw/bt.h"
diff --git a/hw/bt/sdp.c b/hw/bt/sdp.c
index f4aba9d74f..2860d76c85 100644
--- a/hw/bt/sdp.c
+++ b/hw/bt/sdp.c
@@ -19,7 +19,6 @@
=20
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
-#include "qemu-common.h"
 #include "qemu/host-utils.h"
 #include "hw/bt.h"
=20
diff --git a/hw/core/irq.c b/hw/core/irq.c
index b98d1d69f5..7cc0295d0e 100644
--- a/hw/core/irq.c
+++ b/hw/core/irq.c
@@ -23,7 +23,6 @@
  */
 #include "qemu/osdep.h"
 #include "qemu/main-loop.h"
-#include "qemu-common.h"
 #include "hw/irq.h"
 #include "qom/object.h"
=20
diff --git a/hw/core/loader.c b/hw/core/loader.c
index a097bbe30a..425bf69a99 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -43,6 +43,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu-common.h"
 #include "qapi/error.h"
 #include "hw/hw.h"
 #include "disas/disas.h"
diff --git a/hw/core/null-machine.c b/hw/core/null-machine.c
index 76d3f8e39c..04a1e2b02a 100644
--- a/hw/core/null-machine.c
+++ b/hw/core/null-machine.c
@@ -12,7 +12,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "qemu/error-report.h"
 #include "hw/hw.h"
 #include "hw/boards.h"
diff --git a/hw/cris/axis_dev88.c b/hw/cris/axis_dev88.c
index 191292eebf..940c7dd122 100644
--- a/hw/cris/axis_dev88.c
+++ b/hw/cris/axis_dev88.c
@@ -25,7 +25,6 @@
 #include "qemu/osdep.h"
 #include "qemu/units.h"
 #include "qapi/error.h"
-#include "qemu-common.h"
 #include "cpu.h"
 #include "hw/sysbus.h"
 #include "net/net.h"
diff --git a/hw/cris/boot.c b/hw/cris/boot.c
index 95cba2151b..602f538ef6 100644
--- a/hw/cris/boot.c
+++ b/hw/cris/boot.c
@@ -23,7 +23,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "cpu.h"
 #include "hw/hw.h"
 #include "hw/loader.h"
diff --git a/hw/display/blizzard.c b/hw/display/blizzard.c
index 471bd0ed99..359e399c2a 100644
--- a/hw/display/blizzard.c
+++ b/hw/display/blizzard.c
@@ -19,7 +19,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "ui/console.h"
 #include "hw/display/blizzard.h"
 #include "ui/pixel_ops.h"
diff --git a/hw/display/cg3.c b/hw/display/cg3.c
index c6b7361be2..a7340dc1c2 100644
--- a/hw/display/cg3.c
+++ b/hw/display/cg3.c
@@ -24,6 +24,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu-common.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "ui/console.h"
diff --git a/hw/display/edid-generate.c b/hw/display/edid-generate.c
index 77d9127344..75c945a948 100644
--- a/hw/display/edid-generate.c
+++ b/hw/display/edid-generate.c
@@ -5,7 +5,6 @@
  * See the COPYING file in the top-level directory.
  */
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "qemu/bswap.h"
 #include "hw/display/edid.h"
=20
diff --git a/hw/display/edid-region.c b/hw/display/edid-region.c
index 9a15734d3a..d0d31bad3d 100644
--- a/hw/display/edid-region.c
+++ b/hw/display/edid-region.c
@@ -1,5 +1,4 @@
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "hw/display/edid.h"
=20
 static uint64_t edid_region_read(void *ptr, hwaddr addr, unsigned size)
diff --git a/hw/display/qxl.h b/hw/display/qxl.h
index 6f9d1f21fa..4adfdb1e5d 100644
--- a/hw/display/qxl.h
+++ b/hw/display/qxl.h
@@ -1,7 +1,6 @@
 #ifndef HW_QXL_H
 #define HW_QXL_H
=20
-#include "qemu-common.h"
=20
 #include "hw/hw.h"
 #include "hw/pci/pci.h"
diff --git a/hw/display/tcx.c b/hw/display/tcx.c
index bd5ac8f823..cdabcbc746 100644
--- a/hw/display/tcx.c
+++ b/hw/display/tcx.c
@@ -23,6 +23,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu-common.h"
 #include "qapi/error.h"
 #include "ui/console.h"
 #include "ui/pixel_ops.h"
diff --git a/hw/display/virtio-gpu-3d.c b/hw/display/virtio-gpu-3d.c
index b918167aec..96621576c2 100644
--- a/hw/display/virtio-gpu-3d.c
+++ b/hw/display/virtio-gpu-3d.c
@@ -12,7 +12,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "qemu/iov.h"
 #include "trace.h"
 #include "hw/virtio/virtio.h"
diff --git a/hw/dma/etraxfs_dma.c b/hw/dma/etraxfs_dma.c
index d5650eb885..85783eb847 100644
--- a/hw/dma/etraxfs_dma.c
+++ b/hw/dma/etraxfs_dma.c
@@ -24,7 +24,6 @@
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "exec/address-spaces.h"
-#include "qemu-common.h"
 #include "sysemu/sysemu.h"
=20
 #include "hw/cris/etraxfs_dma.h"
diff --git a/hw/dma/omap_dma.c b/hw/dma/omap_dma.c
index cbb920f31d..eab83c5c3a 100644
--- a/hw/dma/omap_dma.c
+++ b/hw/dma/omap_dma.c
@@ -19,7 +19,6 @@
  */
 #include "qemu/osdep.h"
 #include "qemu/log.h"
-#include "qemu-common.h"
 #include "qemu/timer.h"
 #include "hw/arm/omap.h"
 #include "hw/irq.h"
diff --git a/hw/dma/pl330.c b/hw/dma/pl330.c
index 62ad356156..58df965a46 100644
--- a/hw/dma/pl330.c
+++ b/hw/dma/pl330.c
@@ -15,6 +15,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu-common.h"
 #include "hw/sysbus.h"
 #include "qapi/error.h"
 #include "qemu/timer.h"
diff --git a/hw/dma/soc_dma.c b/hw/dma/soc_dma.c
index 58502721fa..c3e41581b6 100644
--- a/hw/dma/soc_dma.c
+++ b/hw/dma/soc_dma.c
@@ -19,7 +19,6 @@
  */
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
-#include "qemu-common.h"
 #include "qemu/timer.h"
 #include "hw/arm/soc_dma.h"
=20
diff --git a/hw/dma/xlnx_dpdma.c b/hw/dma/xlnx_dpdma.c
index 040df70a93..e834f81e17 100644
--- a/hw/dma/xlnx_dpdma.c
+++ b/hw/dma/xlnx_dpdma.c
@@ -23,6 +23,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu-common.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "hw/dma/xlnx_dpdma.h"
diff --git a/hw/hppa/pci.c b/hw/hppa/pci.c
index 766420254e..b6606d9719 100644
--- a/hw/hppa/pci.c
+++ b/hw/hppa/pci.c
@@ -4,7 +4,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "hppa_sys.h"
 #include "qemu/log.h"
 #include "sysemu/sysemu.h"
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 85dc1640bc..45c369c923 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -24,7 +24,6 @@
 #include "qapi/error.h"
 #include "qapi/qmp/qnum.h"
 #include "acpi-build.h"
-#include "qemu-common.h"
 #include "qemu/bitmap.h"
 #include "qemu/error-report.h"
 #include "hw/pci/pci.h"
diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
index 751fcafa12..de43943af8 100644
--- a/hw/i386/pc_sysfw.c
+++ b/hw/i386/pc_sysfw.c
@@ -24,6 +24,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu-common.h"
 #include "qapi/error.h"
 #include "sysemu/block-backend.h"
 #include "qemu/error-report.h"
diff --git a/hw/intc/apic.c b/hw/intc/apic.c
index 6ea619c360..bce89911dc 100644
--- a/hw/intc/apic.c
+++ b/hw/intc/apic.c
@@ -17,7 +17,6 @@
  * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>
  */
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "cpu.h"
 #include "qemu/thread.h"
 #include "hw/i386/apic_internal.h"
diff --git a/hw/intc/sh_intc.c b/hw/intc/sh_intc.c
index 6ce2a8084f..bac7886f25 100644
--- a/hw/intc/sh_intc.c
+++ b/hw/intc/sh_intc.c
@@ -9,7 +9,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "cpu.h"
 #include "hw/sh4/sh_intc.h"
 #include "hw/hw.h"
diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
index 35d17246e9..a7081bd52d 100644
--- a/hw/isa/lpc_ich9.c
+++ b/hw/isa/lpc_ich9.c
@@ -28,7 +28,6 @@
  * THE SOFTWARE.
  */
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "cpu.h"
 #include "hw/hw.h"
 #include "qapi/visitor.h"
diff --git a/hw/lm32/lm32_boards.c b/hw/lm32/lm32_boards.c
index b820c9114b..fb9d52d54f 100644
--- a/hw/lm32/lm32_boards.c
+++ b/hw/lm32/lm32_boards.c
@@ -20,7 +20,6 @@
 #include "qemu/osdep.h"
 #include "qemu/units.h"
 #include "qemu/error-report.h"
-#include "qemu-common.h"
 #include "cpu.h"
 #include "hw/sysbus.h"
 #include "hw/hw.h"
diff --git a/hw/lm32/lm32_hwsetup.h b/hw/lm32/lm32_hwsetup.h
index a01f6bc5df..de94de177a 100644
--- a/hw/lm32/lm32_hwsetup.h
+++ b/hw/lm32/lm32_hwsetup.h
@@ -25,7 +25,6 @@
 #ifndef QEMU_HW_LM32_HWSETUP_H
 #define QEMU_HW_LM32_HWSETUP_H
=20
-#include "qemu-common.h"
 #include "qemu/cutils.h"
 #include "hw/loader.h"
=20
diff --git a/hw/m68k/an5206.c b/hw/m68k/an5206.c
index 06e3803258..68d15a6ebe 100644
--- a/hw/m68k/an5206.c
+++ b/hw/m68k/an5206.c
@@ -8,7 +8,6 @@
=20
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qemu-common.h"
 #include "cpu.h"
 #include "hw/hw.h"
 #include "hw/m68k/mcf.h"
diff --git a/hw/m68k/mcf5206.c b/hw/m68k/mcf5206.c
index d7f26d6810..1c17f83eed 100644
--- a/hw/m68k/mcf5206.c
+++ b/hw/m68k/mcf5206.c
@@ -7,7 +7,6 @@
  */
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
-#include "qemu-common.h"
 #include "cpu.h"
 #include "hw/hw.h"
 #include "hw/m68k/mcf.h"
diff --git a/hw/microblaze/petalogix_ml605_mmu.c b/hw/microblaze/petalogi=
x_ml605_mmu.c
index a907604116..a88bf16cc8 100644
--- a/hw/microblaze/petalogix_ml605_mmu.c
+++ b/hw/microblaze/petalogix_ml605_mmu.c
@@ -28,7 +28,6 @@
 #include "qemu/osdep.h"
 #include "qemu/units.h"
 #include "qapi/error.h"
-#include "qemu-common.h"
 #include "cpu.h"
 #include "hw/sysbus.h"
 #include "hw/hw.h"
diff --git a/hw/microblaze/petalogix_s3adsp1800_mmu.c b/hw/microblaze/pet=
alogix_s3adsp1800_mmu.c
index 88ce570f9a..8d83474262 100644
--- a/hw/microblaze/petalogix_s3adsp1800_mmu.c
+++ b/hw/microblaze/petalogix_s3adsp1800_mmu.c
@@ -26,7 +26,6 @@
 #include "qemu/osdep.h"
 #include "qemu/units.h"
 #include "qapi/error.h"
-#include "qemu-common.h"
 #include "cpu.h"
 #include "hw/sysbus.h"
 #include "hw/hw.h"
diff --git a/hw/microblaze/xlnx-zynqmp-pmu.c b/hw/microblaze/xlnx-zynqmp-=
pmu.c
index df6c0048aa..67cedec4ef 100644
--- a/hw/microblaze/xlnx-zynqmp-pmu.c
+++ b/hw/microblaze/xlnx-zynqmp-pmu.c
@@ -17,7 +17,6 @@
=20
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qemu-common.h"
 #include "exec/address-spaces.h"
 #include "hw/boards.h"
 #include "hw/qdev-properties.h"
diff --git a/hw/mips/boston.c b/hw/mips/boston.c
index 1ffccc8da9..749582e5aa 100644
--- a/hw/mips/boston.c
+++ b/hw/mips/boston.c
@@ -19,7 +19,6 @@
=20
 #include "qemu/osdep.h"
 #include "qemu/units.h"
-#include "qemu-common.h"
=20
 #include "exec/address-spaces.h"
 #include "hw/boards.h"
diff --git a/hw/mips/mips_fulong2e.c b/hw/mips/mips_fulong2e.c
index 05a5a823a1..5dbaa3bfcc 100644
--- a/hw/mips/mips_fulong2e.c
+++ b/hw/mips/mips_fulong2e.c
@@ -19,6 +19,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu-common.h"
 #include "qemu/units.h"
 #include "qapi/error.h"
 #include "cpu.h"
diff --git a/hw/mips/mips_jazz.c b/hw/mips/mips_jazz.c
index 1afbe3ce6a..fa8775d428 100644
--- a/hw/mips/mips_jazz.c
+++ b/hw/mips/mips_jazz.c
@@ -23,6 +23,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu-common.h"
 #include "hw/hw.h"
 #include "hw/mips/mips.h"
 #include "hw/mips/cpudevs.h"
diff --git a/hw/misc/macio/cuda.c b/hw/misc/macio/cuda.c
index 5fd904b79d..4f532efe34 100644
--- a/hw/misc/macio/cuda.c
+++ b/hw/misc/macio/cuda.c
@@ -24,6 +24,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu-common.h"
 #include "hw/hw.h"
 #include "hw/ppc/mac.h"
 #include "hw/input/adb.h"
diff --git a/hw/misc/macio/pmu.c b/hw/misc/macio/pmu.c
index 7201cf4f9a..753561d3f1 100644
--- a/hw/misc/macio/pmu.c
+++ b/hw/misc/macio/pmu.c
@@ -29,6 +29,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu-common.h"
 #include "hw/hw.h"
 #include "hw/ppc/mac.h"
 #include "hw/input/adb.h"
diff --git a/hw/moxie/moxiesim.c b/hw/moxie/moxiesim.c
index eddeed915d..d771d393c2 100644
--- a/hw/moxie/moxiesim.c
+++ b/hw/moxie/moxiesim.c
@@ -27,7 +27,6 @@
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
-#include "qemu-common.h"
 #include "cpu.h"
 #include "hw/sysbus.h"
 #include "hw/hw.h"
diff --git a/hw/net/rocker/qmp-norocker.c b/hw/net/rocker/qmp-norocker.c
index 0d60513c01..5ef4f9324c 100644
--- a/hw/net/rocker/qmp-norocker.c
+++ b/hw/net/rocker/qmp-norocker.c
@@ -16,7 +16,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-rocker.h"
 #include "qapi/qmp/qerror.h"
diff --git a/hw/nios2/10m50_devboard.c b/hw/nios2/10m50_devboard.c
index 36b49a420c..2c3388f5cf 100644
--- a/hw/nios2/10m50_devboard.c
+++ b/hw/nios2/10m50_devboard.c
@@ -24,7 +24,6 @@
=20
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qemu-common.h"
 #include "cpu.h"
=20
 #include "hw/sysbus.h"
diff --git a/hw/nios2/cpu_pic.c b/hw/nios2/cpu_pic.c
index 6bccce2f32..2d896bf385 100644
--- a/hw/nios2/cpu_pic.c
+++ b/hw/nios2/cpu_pic.c
@@ -19,7 +19,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "cpu.h"
=20
 #include "qemu/config-file.h"
diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index 9f7b7789bc..dcfd6d2ed3 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -23,6 +23,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu-common.h"
 #include "hw/hw.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/dma.h"
diff --git a/hw/openrisc/openrisc_sim.c b/hw/openrisc/openrisc_sim.c
index 0a906d815e..87b9feaa96 100644
--- a/hw/openrisc/openrisc_sim.c
+++ b/hw/openrisc/openrisc_sim.c
@@ -21,7 +21,6 @@
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
-#include "qemu-common.h"
 #include "cpu.h"
 #include "hw/hw.h"
 #include "hw/boards.h"
diff --git a/hw/pci-bridge/dec.h b/hw/pci-bridge/dec.h
index ae17ca7362..869e90b136 100644
--- a/hw/pci-bridge/dec.h
+++ b/hw/pci-bridge/dec.h
@@ -1,7 +1,6 @@
 #ifndef HW_PCI_BRIDGE_DEC_H
 #define HW_PCI_BRIDGE_DEC_H
=20
-#include "qemu-common.h"
=20
 #define TYPE_DEC_21154 "dec-21154-sysbus"
=20
diff --git a/hw/pci-host/prep.c b/hw/pci-host/prep.c
index 8b9e1fd0d3..c564f234af 100644
--- a/hw/pci-host/prep.c
+++ b/hw/pci-host/prep.c
@@ -24,6 +24,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu-common.h"
 #include "qemu/units.h"
 #include "qapi/error.h"
 #include "hw/hw.h"
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index d3893bdfe1..8076a80ab3 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -23,6 +23,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu-common.h"
 #include "hw/hw.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_bridge.h"
diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index cf1ca30f93..88c30ff74c 100644
--- a/hw/pci/pcie.c
+++ b/hw/pci/pcie.c
@@ -20,7 +20,6 @@
=20
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qemu-common.h"
 #include "hw/pci/pci_bridge.h"
 #include "hw/pci/pcie.h"
 #include "hw/pci/msix.h"
diff --git a/hw/pci/shpc.c b/hw/pci/shpc.c
index 49bbb841bd..5a10c6e9a5 100644
--- a/hw/pci/shpc.c
+++ b/hw/pci/shpc.c
@@ -1,6 +1,5 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qemu-common.h"
 #include "qemu/host-utils.h"
 #include "qemu/range.h"
 #include "qemu/error-report.h"
diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index beb2efd694..bfda1266af 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -15,6 +15,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu-common.h"
 #include "qemu/units.h"
 #include "qapi/error.h"
 #include "e500.h"
diff --git a/hw/ppc/e500plat.c b/hw/ppc/e500plat.c
index 963d429cc8..2b82a58592 100644
--- a/hw/ppc/e500plat.c
+++ b/hw/ppc/e500plat.c
@@ -11,7 +11,6 @@
=20
 #include "qemu/osdep.h"
 #include "qemu/units.h"
-#include "qemu-common.h"
 #include "e500.h"
 #include "hw/net/fsl_etsec/etsec.h"
 #include "hw/boards.h"
diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
index 02d8559621..4d835f32b5 100644
--- a/hw/ppc/mac_newworld.c
+++ b/hw/ppc/mac_newworld.c
@@ -44,9 +44,10 @@
  * 0001:03:0e.0 FireWire (IEEE 1394) [0c00]: Apple Computer Inc. K2 Fire=
Wire [106b:0042]
  * 0001:04:0f.0 Ethernet controller [0200]: Apple Computer Inc. K2 GMAC =
(Sun GEM) [106b:004c]
  * 0001:05:0c.0 IDE interface [0101]: Broadcom K2 SATA [1166:0240]
- *
  */
+
 #include "qemu/osdep.h"
+#include "qemu-common.h"
 #include "qapi/error.h"
 #include "hw/hw.h"
 #include "hw/ppc/ppc.h"
diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
index 460cbc7923..eddd005a7c 100644
--- a/hw/ppc/mac_oldworld.c
+++ b/hw/ppc/mac_oldworld.c
@@ -23,7 +23,9 @@
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
  * THE SOFTWARE.
  */
+
 #include "qemu/osdep.h"
+#include "qemu-common.h"
 #include "qemu/units.h"
 #include "qapi/error.h"
 #include "hw/hw.h"
diff --git a/hw/ppc/mpc8544ds.c b/hw/ppc/mpc8544ds.c
index ab30a2a99e..6a4657c3cd 100644
--- a/hw/ppc/mpc8544ds.c
+++ b/hw/ppc/mpc8544ds.c
@@ -10,7 +10,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "e500.h"
 #include "hw/boards.h"
 #include "sysemu/device_tree.h"
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 046f0a83c8..3ae09b3db9 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -18,6 +18,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu-common.h"
 #include "qemu/units.h"
 #include "qapi/error.h"
 #include "sysemu/sysemu.h"
diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
index ad20584f26..4fc86edd50 100644
--- a/hw/ppc/ppc.c
+++ b/hw/ppc/ppc.c
@@ -22,7 +22,6 @@
  * THE SOFTWARE.
  */
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "cpu.h"
 #include "hw/hw.h"
 #include "hw/ppc/ppc.h"
diff --git a/hw/ppc/ppc405_uc.c b/hw/ppc/ppc405_uc.c
index 3ae7f6d4df..4059207103 100644
--- a/hw/ppc/ppc405_uc.c
+++ b/hw/ppc/ppc405_uc.c
@@ -24,7 +24,6 @@
 #include "qemu/osdep.h"
 #include "qemu/units.h"
 #include "qapi/error.h"
-#include "qemu-common.h"
 #include "cpu.h"
 #include "hw/hw.h"
 #include "hw/ppc/ppc.h"
diff --git a/hw/ppc/ppc_booke.c b/hw/ppc/ppc_booke.c
index 4f11e00a17..bc75f4210f 100644
--- a/hw/ppc/ppc_booke.c
+++ b/hw/ppc/ppc_booke.c
@@ -22,7 +22,6 @@
  * THE SOFTWARE.
  */
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "cpu.h"
 #include "hw/hw.h"
 #include "hw/ppc/ppc.h"
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index e2b33e5890..d7e0bd21f8 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -22,9 +22,10 @@
  * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISI=
NG FROM,
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
  * THE SOFTWARE.
- *
  */
+
 #include "qemu/osdep.h"
+#include "qemu-common.h"
 #include "qapi/error.h"
 #include "qapi/visitor.h"
 #include "sysemu/sysemu.h"
diff --git a/hw/ppc/spapr_pci_vfio.c b/hw/ppc/spapr_pci_vfio.c
index 5f5dde567d..ecb34aaade 100644
--- a/hw/ppc/spapr_pci_vfio.c
+++ b/hw/ppc/spapr_pci_vfio.c
@@ -19,7 +19,6 @@
=20
 #include "qemu/osdep.h"
 #include <linux/vfio.h>
-#include "qemu-common.h"
 #include "cpu.h"
 #include "hw/ppc/spapr.h"
 #include "hw/pci-host/spapr.h"
diff --git a/hw/ppc/spapr_rtc.c b/hw/ppc/spapr_rtc.c
index b178e05666..af1ef30a53 100644
--- a/hw/ppc/spapr_rtc.c
+++ b/hw/ppc/spapr_rtc.c
@@ -26,6 +26,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu-common.h"
 #include "cpu.h"
 #include "qemu/timer.h"
 #include "sysemu/sysemu.h"
diff --git a/hw/ppc/virtex_ml507.c b/hw/ppc/virtex_ml507.c
index 0e4c7409e0..834053a7d2 100644
--- a/hw/ppc/virtex_ml507.c
+++ b/hw/ppc/virtex_ml507.c
@@ -23,6 +23,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu-common.h"
 #include "qemu/units.h"
 #include "cpu.h"
 #include "hw/sysbus.h"
diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index 1f3aef051b..60bd081d3e 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -12,6 +12,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu-common.h"
 #include "qapi/error.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/tcg.h"
diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
index be2896232d..61f30b8e55 100644
--- a/hw/s390x/s390-pci-inst.c
+++ b/hw/s390x/s390-pci-inst.c
@@ -12,7 +12,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "cpu.h"
 #include "s390-pci-inst.h"
 #include "s390-pci-bus.h"
diff --git a/hw/s390x/tod-qemu.c b/hw/s390x/tod-qemu.c
index 58b66d2d98..e91b9590f5 100644
--- a/hw/s390x/tod-qemu.c
+++ b/hw/s390x/tod-qemu.c
@@ -9,6 +9,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu-common.h"
 #include "qapi/error.h"
 #include "hw/s390x/tod.h"
 #include "qemu/timer.h"
diff --git a/hw/scsi/megasas.c b/hw/scsi/megasas.c
index 06f618dbf7..0c4399930a 100644
--- a/hw/scsi/megasas.c
+++ b/hw/scsi/megasas.c
@@ -19,6 +19,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu-common.h"
 #include "hw/hw.h"
 #include "hw/pci/pci.h"
 #include "sysemu/dma.h"
diff --git a/hw/sh4/r2d.c b/hw/sh4/r2d.c
index 0bcb769c85..f22c79c867 100644
--- a/hw/sh4/r2d.c
+++ b/hw/sh4/r2d.c
@@ -26,7 +26,6 @@
 #include "qemu/osdep.h"
 #include "qemu/units.h"
 #include "qapi/error.h"
-#include "qemu-common.h"
 #include "cpu.h"
 #include "hw/sysbus.h"
 #include "hw/hw.h"
diff --git a/hw/sh4/shix.c b/hw/sh4/shix.c
index 4add2309eb..6a1c7238e9 100644
--- a/hw/sh4/shix.c
+++ b/hw/sh4/shix.c
@@ -29,7 +29,6 @@
 */
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qemu-common.h"
 #include "cpu.h"
 #include "hw/hw.h"
 #include "hw/sh4/sh.h"
diff --git a/hw/sparc64/niagara.c b/hw/sparc64/niagara.c
index f8a856f611..dc0ce7eda4 100644
--- a/hw/sparc64/niagara.c
+++ b/hw/sparc64/niagara.c
@@ -24,7 +24,6 @@
=20
 #include "qemu/osdep.h"
 #include "qemu/units.h"
-#include "qemu-common.h"
 #include "cpu.h"
 #include "hw/hw.h"
 #include "hw/boards.h"
diff --git a/hw/timer/exynos4210_rtc.c b/hw/timer/exynos4210_rtc.c
index 0d65f6f3e3..0ecedf7394 100644
--- a/hw/timer/exynos4210_rtc.c
+++ b/hw/timer/exynos4210_rtc.c
@@ -26,6 +26,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu-common.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "hw/sysbus.h"
diff --git a/hw/timer/m41t80.c b/hw/timer/m41t80.c
index 5b9192c28d..914ecac8f4 100644
--- a/hw/timer/m41t80.c
+++ b/hw/timer/m41t80.c
@@ -8,6 +8,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu-common.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "qemu/timer.h"
diff --git a/hw/timer/m48t59.c b/hw/timer/m48t59.c
index 5d26e9aef0..030c8872a2 100644
--- a/hw/timer/m48t59.c
+++ b/hw/timer/m48t59.c
@@ -24,6 +24,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu-common.h"
 #include "hw/hw.h"
 #include "hw/timer/m48t59.h"
 #include "qemu/timer.h"
diff --git a/hw/timer/mc146818rtc.c b/hw/timer/mc146818rtc.c
index b61b4ddeaf..0d79e000d2 100644
--- a/hw/timer/mc146818rtc.c
+++ b/hw/timer/mc146818rtc.c
@@ -23,6 +23,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu-common.h"
 #include "qemu/cutils.h"
 #include "qemu/module.h"
 #include "qemu/bcd.h"
diff --git a/hw/timer/pl031.c b/hw/timer/pl031.c
index abac73ab42..3378084f4a 100644
--- a/hw/timer/pl031.c
+++ b/hw/timer/pl031.c
@@ -12,6 +12,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu-common.h"
 #include "hw/timer/pl031.h"
 #include "hw/sysbus.h"
 #include "qemu/timer.h"
diff --git a/hw/timer/twl92230.c b/hw/timer/twl92230.c
index 7785b96c0b..0ef4fc1fc1 100644
--- a/hw/timer/twl92230.c
+++ b/hw/timer/twl92230.c
@@ -20,6 +20,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu-common.h"
 #include "hw/hw.h"
 #include "qemu/timer.h"
 #include "hw/i2c/i2c.h"
diff --git a/hw/timer/xlnx-zynqmp-rtc.c b/hw/timer/xlnx-zynqmp-rtc.c
index be078ae72a..36daf0c7e7 100644
--- a/hw/timer/xlnx-zynqmp-rtc.c
+++ b/hw/timer/xlnx-zynqmp-rtc.c
@@ -25,6 +25,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu-common.h"
 #include "hw/sysbus.h"
 #include "hw/register.h"
 #include "qemu/bitops.h"
diff --git a/hw/tpm/tpm_passthrough.c b/hw/tpm/tpm_passthrough.c
index e87bd126c6..897e3d5864 100644
--- a/hw/tpm/tpm_passthrough.c
+++ b/hw/tpm/tpm_passthrough.c
@@ -23,6 +23,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu-common.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
 #include "qemu/sockets.h"
diff --git a/hw/tricore/tricore_testboard.c b/hw/tricore/tricore_testboar=
d.c
index b40cc997d0..be397ebf92 100644
--- a/hw/tricore/tricore_testboard.c
+++ b/hw/tricore/tricore_testboard.c
@@ -21,7 +21,6 @@
 #include "qemu/osdep.h"
 #include "qemu/units.h"
 #include "qapi/error.h"
-#include "qemu-common.h"
 #include "cpu.h"
 #include "hw/hw.h"
 #include "net/net.h"
diff --git a/hw/usb/ccid-card-passthru.c b/hw/usb/ccid-card-passthru.c
index 081bcfd70a..d1dac6e012 100644
--- a/hw/usb/ccid-card-passthru.c
+++ b/hw/usb/ccid-card-passthru.c
@@ -9,6 +9,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu-common.h"
 #include "qemu/units.h"
 #include <libcacard.h>
 #include "chardev/char-fe.h"
diff --git a/hw/usb/combined-packet.c b/hw/usb/combined-packet.c
index 37b23e20ef..5d57e883dc 100644
--- a/hw/usb/combined-packet.c
+++ b/hw/usb/combined-packet.c
@@ -21,7 +21,6 @@
  */
 #include "qemu/osdep.h"
 #include "qemu/units.h"
-#include "qemu-common.h"
 #include "hw/usb.h"
 #include "qemu/iov.h"
 #include "trace.h"
diff --git a/hw/usb/core.c b/hw/usb/core.c
index 3ab48a1607..5abd128b6b 100644
--- a/hw/usb/core.c
+++ b/hw/usb/core.c
@@ -24,7 +24,6 @@
  * THE SOFTWARE.
  */
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "hw/usb.h"
 #include "qemu/iov.h"
 #include "trace.h"
diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
index 38a8a33dc7..855853dc0d 100644
--- a/hw/usb/dev-mtp.c
+++ b/hw/usb/dev-mtp.c
@@ -10,6 +10,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu-common.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include <wchar.h>
diff --git a/hw/usb/hcd-musb.c b/hw/usb/hcd-musb.c
index 85d7796554..c29fbef6fc 100644
--- a/hw/usb/hcd-musb.c
+++ b/hw/usb/hcd-musb.c
@@ -21,7 +21,6 @@
  * Only host-mode and non-DMA accesses are currently supported.
  */
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "qemu/timer.h"
 #include "hw/usb.h"
 #include "hw/irq.h"
diff --git a/hw/usb/host-stub.c b/hw/usb/host-stub.c
index 41d93ec8a0..538ed29684 100644
--- a/hw/usb/host-stub.c
+++ b/hw/usb/host-stub.c
@@ -31,7 +31,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "ui/console.h"
 #include "hw/usb.h"
 #include "monitor/monitor.h"
diff --git a/hw/usb/libhw.c b/hw/usb/libhw.c
index 73cdf0c97d..adbee2f642 100644
--- a/hw/usb/libhw.c
+++ b/hw/usb/libhw.c
@@ -20,7 +20,6 @@
  * THE SOFTWARE.
  */
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "hw/hw.h"
 #include "hw/usb.h"
 #include "sysemu/dma.h"
diff --git a/hw/usb/redirect.c b/hw/usb/redirect.c
index 084b8f2161..998fc6e4b0 100644
--- a/hw/usb/redirect.c
+++ b/hw/usb/redirect.c
@@ -26,6 +26,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu-common.h"
 #include "qemu/units.h"
 #include "qapi/error.h"
 #include "qemu/timer.h"
diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index cfcd1a81b8..834a90d646 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -12,7 +12,6 @@
 #ifndef HW_VFIO_VFIO_PCI_H
 #define HW_VFIO_VFIO_PCI_H
=20
-#include "qemu-common.h"
 #include "exec/memory.h"
 #include "hw/pci/pci.h"
 #include "hw/vfio/vfio-common.h"
diff --git a/hw/xen/xen-host-pci-device.c b/hw/xen/xen-host-pci-device.c
index eed8cc88e3..1b44dcafaf 100644
--- a/hw/xen/xen-host-pci-device.c
+++ b/hw/xen/xen-host-pci-device.c
@@ -8,7 +8,6 @@
=20
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qemu-common.h"
 #include "qemu/cutils.h"
 #include "xen-host-pci-device.h"
=20
diff --git a/hw/xen/xen_pt.h b/hw/xen/xen_pt.h
index dbee3308fd..9167bbaf6d 100644
--- a/hw/xen/xen_pt.h
+++ b/hw/xen/xen_pt.h
@@ -1,7 +1,6 @@
 #ifndef XEN_PT_H
 #define XEN_PT_H
=20
-#include "qemu-common.h"
 #include "hw/xen/xen_common.h"
 #include "hw/pci/pci.h"
 #include "xen-host-pci-device.h"
diff --git a/hw/xtensa/sim.c b/hw/xtensa/sim.c
index 12c7437398..b6922c39d5 100644
--- a/hw/xtensa/sim.c
+++ b/hw/xtensa/sim.c
@@ -27,7 +27,6 @@
=20
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qemu-common.h"
 #include "cpu.h"
 #include "sysemu/sysemu.h"
 #include "hw/boards.h"
diff --git a/hw/xtensa/xtensa_memory.c b/hw/xtensa/xtensa_memory.c
index 394967f842..394d0cf227 100644
--- a/hw/xtensa/xtensa_memory.c
+++ b/hw/xtensa/xtensa_memory.c
@@ -27,7 +27,6 @@
=20
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qemu-common.h"
 #include "cpu.h"
 #include "sysemu/sysemu.h"
 #include "hw/boards.h"
diff --git a/hw/xtensa/xtensa_memory.h b/hw/xtensa/xtensa_memory.h
index 89125c4a0d..d50a3cccc0 100644
--- a/hw/xtensa/xtensa_memory.h
+++ b/hw/xtensa/xtensa_memory.h
@@ -28,7 +28,6 @@
 #ifndef XTENSA_MEMORY_H
 #define XTENSA_MEMORY_H
=20
-#include "qemu-common.h"
 #include "cpu.h"
 #include "exec/memory.h"
=20
diff --git a/include/authz/base.h b/include/authz/base.h
index 14a59a0425..0782981ad8 100644
--- a/include/authz/base.h
+++ b/include/authz/base.h
@@ -21,7 +21,6 @@
 #ifndef QAUTHZ_BASE_H
 #define QAUTHZ_BASE_H
=20
-#include "qemu-common.h"
 #include "qapi/error.h"
 #include "qom/object.h"
=20
diff --git a/include/block/aio.h b/include/block/aio.h
index 0ca25dfec6..6b0d52f732 100644
--- a/include/block/aio.h
+++ b/include/block/aio.h
@@ -14,7 +14,6 @@
 #ifndef QEMU_AIO_H
 #define QEMU_AIO_H
=20
-#include "qemu-common.h"
 #include "qemu/queue.h"
 #include "qemu/event_notifier.h"
 #include "qemu/thread.h"
diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap.h
index 8044ace63e..62682eb865 100644
--- a/include/block/dirty-bitmap.h
+++ b/include/block/dirty-bitmap.h
@@ -1,7 +1,6 @@
 #ifndef BLOCK_DIRTY_BITMAP_H
 #define BLOCK_DIRTY_BITMAP_H
=20
-#include "qemu-common.h"
 #include "qapi/qapi-types-block-core.h"
 #include "qemu/hbitmap.h"
=20
diff --git a/include/block/write-threshold.h b/include/block/write-thresh=
old.h
index 234d2193e0..80d8aab5d0 100644
--- a/include/block/write-threshold.h
+++ b/include/block/write-threshold.h
@@ -12,7 +12,6 @@
 #ifndef BLOCK_WRITE_THRESHOLD_H
 #define BLOCK_WRITE_THRESHOLD_H
=20
-#include "qemu-common.h"
=20
 /*
  * bdrv_write_threshold_set:
diff --git a/include/chardev/char-io.h b/include/chardev/char-io.h
index 9638da5100..1709b59c9f 100644
--- a/include/chardev/char-io.h
+++ b/include/chardev/char-io.h
@@ -24,7 +24,6 @@
 #ifndef CHAR_IO_H
 #define CHAR_IO_H
=20
-#include "qemu-common.h"
 #include "io/channel.h"
 #include "chardev/char.h"
=20
diff --git a/include/crypto/random.h b/include/crypto/random.h
index fde592904e..c09998894f 100644
--- a/include/crypto/random.h
+++ b/include/crypto/random.h
@@ -21,7 +21,6 @@
 #ifndef QCRYPTO_RANDOM_H
 #define QCRYPTO_RANDOM_H
=20
-#include "qemu-common.h"
=20
 /**
  * qcrypto_random_bytes:
diff --git a/include/crypto/xts.h b/include/crypto/xts.h
index 3c8967ac6c..39ccaed822 100644
--- a/include/crypto/xts.h
+++ b/include/crypto/xts.h
@@ -26,7 +26,6 @@
 #ifndef QCRYPTO_XTS_H
 #define QCRYPTO_XTS_H
=20
-#include "qemu-common.h"
=20
 #define XTS_BLOCK_SIZE 16
=20
diff --git a/include/disas/disas.h b/include/disas/disas.h
index 4d48c13c65..15da511f49 100644
--- a/include/disas/disas.h
+++ b/include/disas/disas.h
@@ -1,7 +1,6 @@
 #ifndef QEMU_DISAS_H
 #define QEMU_DISAS_H
=20
-#include "qemu-common.h"
=20
 #ifdef NEED_CPU_H
 #include "cpu.h"
diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index da07ce311f..0c7cd7af7f 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -19,7 +19,6 @@
 #ifndef CPU_ALL_H
 #define CPU_ALL_H
=20
-#include "qemu-common.h"
 #include "exec/cpu-common.h"
 #include "exec/memory.h"
 #include "qemu/thread.h"
diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 31f0ecc461..16034ee651 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -20,7 +20,6 @@
 #ifndef EXEC_ALL_H
 #define EXEC_ALL_H
=20
-#include "qemu-common.h"
 #include "exec/tb-context.h"
 #include "sysemu/cpus.h"
=20
diff --git a/include/hw/acpi/tco.h b/include/hw/acpi/tco.h
index 52ad767ddd..d19dd59353 100644
--- a/include/hw/acpi/tco.h
+++ b/include/hw/acpi/tco.h
@@ -9,7 +9,6 @@
 #ifndef HW_ACPI_TCO_H
 #define HW_ACPI_TCO_H
=20
-#include "qemu-common.h"
=20
 /* As per ICH9 spec, the internal timer has an error of ~0.6s on every t=
ick */
 #define TCO_TICK_NSEC 600000000LL
diff --git a/include/hw/arm/allwinner-a10.h b/include/hw/arm/allwinner-a1=
0.h
index 6305b9c586..bbfbaf01c7 100644
--- a/include/hw/arm/allwinner-a10.h
+++ b/include/hw/arm/allwinner-a10.h
@@ -1,6 +1,5 @@
 #ifndef ALLWINNER_H_
=20
-#include "qemu-common.h"
 #include "qemu/error-report.h"
 #include "hw/char/serial.h"
 #include "hw/arm/boot.h"
diff --git a/include/hw/arm/bcm2835_peripherals.h b/include/hw/arm/bcm283=
5_peripherals.h
index e79c21771f..6b17f6a382 100644
--- a/include/hw/arm/bcm2835_peripherals.h
+++ b/include/hw/arm/bcm2835_peripherals.h
@@ -11,7 +11,6 @@
 #ifndef BCM2835_PERIPHERALS_H
 #define BCM2835_PERIPHERALS_H
=20
-#include "qemu-common.h"
 #include "hw/sysbus.h"
 #include "hw/char/pl011.h"
 #include "hw/char/bcm2835_aux.h"
diff --git a/include/hw/arm/exynos4210.h b/include/hw/arm/exynos4210.h
index 27c684e851..aa137271c0 100644
--- a/include/hw/arm/exynos4210.h
+++ b/include/hw/arm/exynos4210.h
@@ -25,7 +25,6 @@
 #ifndef EXYNOS4210_H
 #define EXYNOS4210_H
=20
-#include "qemu-common.h"
 #include "exec/memory.h"
 #include "target/arm/cpu-qom.h"
=20
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 73005f05ae..a72094204e 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -30,7 +30,6 @@
 #ifndef QEMU_ARM_VIRT_H
 #define QEMU_ARM_VIRT_H
=20
-#include "qemu-common.h"
 #include "exec/hwaddr.h"
 #include "qemu/notify.h"
 #include "hw/boards.h"
diff --git a/include/hw/arm/xlnx-zynqmp.h b/include/hw/arm/xlnx-zynqmp.h
index cd90b04310..1b17f13b0b 100644
--- a/include/hw/arm/xlnx-zynqmp.h
+++ b/include/hw/arm/xlnx-zynqmp.h
@@ -17,7 +17,6 @@
=20
 #ifndef XLNX_ZYNQMP_H
=20
-#include "qemu-common.h"
 #include "hw/arm/boot.h"
 #include "hw/intc/arm_gic.h"
 #include "hw/net/cadence_gem.h"
diff --git a/include/hw/block/fdc.h b/include/hw/block/fdc.h
index 3b813c7f7d..8cece84326 100644
--- a/include/hw/block/fdc.h
+++ b/include/hw/block/fdc.h
@@ -1,7 +1,6 @@
 #ifndef HW_FDC_H
 #define HW_FDC_H
=20
-#include "qemu-common.h"
 #include "qapi/qapi-types-block.h"
=20
 /* fdc.c */
diff --git a/include/hw/dma/bcm2835_dma.h b/include/hw/dma/bcm2835_dma.h
index 60138f4d31..91ed8d05d1 100644
--- a/include/hw/dma/bcm2835_dma.h
+++ b/include/hw/dma/bcm2835_dma.h
@@ -6,7 +6,6 @@
 #ifndef BCM2835_DMA_H
 #define BCM2835_DMA_H
=20
-#include "qemu-common.h"
 #include "hw/sysbus.h"
=20
 typedef struct {
diff --git a/include/hw/fw-path-provider.h b/include/hw/fw-path-provider.=
h
index 5df893a3d8..10d1bd4959 100644
--- a/include/hw/fw-path-provider.h
+++ b/include/hw/fw-path-provider.h
@@ -18,7 +18,6 @@
 #ifndef FW_PATH_PROVIDER_H
 #define FW_PATH_PROVIDER_H
=20
-#include "qemu-common.h"
 #include "qom/object.h"
=20
 #define TYPE_FW_PATH_PROVIDER "fw-path-provider"
diff --git a/include/hw/i2c/ppc4xx_i2c.h b/include/hw/i2c/ppc4xx_i2c.h
index b3450bacf7..aa2a2bf9de 100644
--- a/include/hw/i2c/ppc4xx_i2c.h
+++ b/include/hw/i2c/ppc4xx_i2c.h
@@ -27,7 +27,6 @@
 #ifndef PPC4XX_I2C_H
 #define PPC4XX_I2C_H
=20
-#include "qemu-common.h"
 #include "hw/sysbus.h"
 #include "hw/i2c/i2c.h"
=20
diff --git a/include/hw/i386/apic.h b/include/hw/i386/apic.h
index a9f6c0aa33..da1d2fe155 100644
--- a/include/hw/i386/apic.h
+++ b/include/hw/i386/apic.h
@@ -1,7 +1,6 @@
 #ifndef APIC_H
 #define APIC_H
=20
-#include "qemu-common.h"
=20
 /* apic.c */
 void apic_deliver_irq(uint8_t dest, uint8_t dest_mode, uint8_t delivery_=
mode,
diff --git a/include/hw/ipmi/ipmi.h b/include/hw/ipmi/ipmi.h
index 99661d2bf0..011faf22e9 100644
--- a/include/hw/ipmi/ipmi.h
+++ b/include/hw/ipmi/ipmi.h
@@ -26,7 +26,6 @@
 #define HW_IPMI_H
=20
 #include "exec/memory.h"
-#include "qemu-common.h"
 #include "hw/qdev.h"
=20
 #define MAX_IPMI_MSG_SIZE 300
diff --git a/include/hw/isa/apm.h b/include/hw/isa/apm.h
index b7098bf7ca..0f93602936 100644
--- a/include/hw/isa/apm.h
+++ b/include/hw/isa/apm.h
@@ -1,7 +1,6 @@
 #ifndef APM_H
 #define APM_H
=20
-#include "qemu-common.h"
 #include "hw/hw.h"
 #include "exec/memory.h"
=20
diff --git a/include/hw/isa/superio.h b/include/hw/isa/superio.h
index 345f006081..b151dcd753 100644
--- a/include/hw/isa/superio.h
+++ b/include/hw/isa/superio.h
@@ -10,7 +10,6 @@
 #ifndef HW_ISA_SUPERIO_H
 #define HW_ISA_SUPERIO_H
=20
-#include "qemu-common.h"
 #include "sysemu/sysemu.h"
 #include "hw/isa/isa.h"
=20
diff --git a/include/hw/lm32/lm32_pic.h b/include/hw/lm32/lm32_pic.h
index e6479b8f63..9e5e038437 100644
--- a/include/hw/lm32/lm32_pic.h
+++ b/include/hw/lm32/lm32_pic.h
@@ -1,7 +1,6 @@
 #ifndef QEMU_HW_LM32_PIC_H
 #define QEMU_HW_LM32_PIC_H
=20
-#include "qemu-common.h"
=20
 uint32_t lm32_pic_get_ip(DeviceState *d);
 uint32_t lm32_pic_get_im(DeviceState *d);
diff --git a/include/hw/nmi.h b/include/hw/nmi.h
index ad857f3832..a1e128724e 100644
--- a/include/hw/nmi.h
+++ b/include/hw/nmi.h
@@ -22,7 +22,6 @@
 #ifndef NMI_H
 #define NMI_H
=20
-#include "qemu-common.h"
 #include "qom/object.h"
=20
 #define TYPE_NMI "nmi"
diff --git a/include/hw/pci-host/pam.h b/include/hw/pci-host/pam.h
index 6116c638f9..fec5cd35d6 100644
--- a/include/hw/pci-host/pam.h
+++ b/include/hw/pci-host/pam.h
@@ -50,7 +50,6 @@
  * 0xf0000 - 0xfffff System BIOS Area Memory Segments
  */
=20
-#include "qemu-common.h"
 #include "exec/memory.h"
=20
 #define SMRAM_C_BASE    0xa0000
diff --git a/include/hw/pci/msi.h b/include/hw/pci/msi.h
index 8440eaee11..4087688486 100644
--- a/include/hw/pci/msi.h
+++ b/include/hw/pci/msi.h
@@ -21,7 +21,6 @@
 #ifndef QEMU_MSI_H
 #define QEMU_MSI_H
=20
-#include "qemu-common.h"
 #include "hw/pci/pci.h"
=20
 struct MSIMessage {
diff --git a/include/hw/pci/msix.h b/include/hw/pci/msix.h
index 08acfa836e..4c4a60c739 100644
--- a/include/hw/pci/msix.h
+++ b/include/hw/pci/msix.h
@@ -1,7 +1,6 @@
 #ifndef QEMU_MSIX_H
 #define QEMU_MSIX_H
=20
-#include "qemu-common.h"
 #include "hw/pci/pci.h"
=20
 #define MSIX_CAP_LENGTH 12
diff --git a/include/hw/pci/shpc.h b/include/hw/pci/shpc.h
index 18f6ec1cd5..bd8204f64e 100644
--- a/include/hw/pci/shpc.h
+++ b/include/hw/pci/shpc.h
@@ -1,7 +1,6 @@
 #ifndef SHPC_H
 #define SHPC_H
=20
-#include "qemu-common.h"
 #include "exec/memory.h"
 #include "hw/hotplug.h"
 #include "hw/pci/pci.h"
diff --git a/include/hw/pci/slotid_cap.h b/include/hw/pci/slotid_cap.h
index a777ea0e49..8b4dc0ce83 100644
--- a/include/hw/pci/slotid_cap.h
+++ b/include/hw/pci/slotid_cap.h
@@ -1,7 +1,6 @@
 #ifndef PCI_SLOTID_CAP_H
 #define PCI_SLOTID_CAP_H
=20
-#include "qemu-common.h"
=20
 int slotid_cap_init(PCIDevice *dev, int nslots,
                     uint8_t chassis,
diff --git a/include/hw/ppc/openpic.h b/include/hw/ppc/openpic.h
index dad08fe9be..7642a8ea1d 100644
--- a/include/hw/ppc/openpic.h
+++ b/include/hw/ppc/openpic.h
@@ -1,7 +1,6 @@
 #ifndef OPENPIC_H
 #define OPENPIC_H
=20
-#include "qemu-common.h"
 #include "hw/sysbus.h"
 #include "hw/qdev-core.h"
 #include "qom/cpu.h"
diff --git a/include/hw/ptimer.h b/include/hw/ptimer.h
index 0731d9aef1..2b866902aa 100644
--- a/include/hw/ptimer.h
+++ b/include/hw/ptimer.h
@@ -8,7 +8,6 @@
 #ifndef PTIMER_H
 #define PTIMER_H
=20
-#include "qemu-common.h"
 #include "qemu/timer.h"
 #include "migration/vmstate.h"
=20
diff --git a/include/hw/sd/sdhci.h b/include/hw/sd/sdhci.h
index f321767c56..cbf415e43a 100644
--- a/include/hw/sd/sdhci.h
+++ b/include/hw/sd/sdhci.h
@@ -25,7 +25,6 @@
 #ifndef SDHCI_H
 #define SDHCI_H
=20
-#include "qemu-common.h"
 #include "hw/pci/pci.h"
 #include "hw/sysbus.h"
 #include "hw/sd/sd.h"
diff --git a/include/hw/sh4/sh_intc.h b/include/hw/sh4/sh_intc.h
index adfedb2efc..b7c2404334 100644
--- a/include/hw/sh4/sh_intc.h
+++ b/include/hw/sh4/sh_intc.h
@@ -1,7 +1,6 @@
 #ifndef SH_INTC_H
 #define SH_INTC_H
=20
-#include "qemu-common.h"
 #include "hw/irq.h"
=20
 typedef unsigned char intc_enum;
diff --git a/include/hw/sparc/sun4m_iommu.h b/include/hw/sparc/sun4m_iomm=
u.h
index 938937eb04..482266c6a7 100644
--- a/include/hw/sparc/sun4m_iommu.h
+++ b/include/hw/sparc/sun4m_iommu.h
@@ -25,7 +25,6 @@
 #ifndef SUN4M_IOMMU_H
 #define SUN4M_IOMMU_H
=20
-#include "qemu-common.h"
 #include "hw/sysbus.h"
=20
 #define IOMMU_NREGS         (4 * 4096 / 4)
diff --git a/include/hw/sparc/sun4u_iommu.h b/include/hw/sparc/sun4u_iomm=
u.h
index a760172e8e..5472d489cf 100644
--- a/include/hw/sparc/sun4u_iommu.h
+++ b/include/hw/sparc/sun4u_iommu.h
@@ -27,7 +27,6 @@
 #ifndef SUN4U_IOMMU_H
 #define SUN4U_IOMMU_H
=20
-#include "qemu-common.h"
 #include "hw/sysbus.h"
=20
 #define IOMMU_NREGS             3
diff --git a/include/hw/stream.h b/include/hw/stream.h
index 15774f07ab..d02f62ca89 100644
--- a/include/hw/stream.h
+++ b/include/hw/stream.h
@@ -1,7 +1,6 @@
 #ifndef STREAM_H
 #define STREAM_H
=20
-#include "qemu-common.h"
 #include "qom/object.h"
=20
 /* stream slave. Used until qdev provides a generic way.  */
diff --git a/include/hw/timer/m48t59.h b/include/hw/timer/m48t59.h
index 6f8db04fce..43efc91f56 100644
--- a/include/hw/timer/m48t59.h
+++ b/include/hw/timer/m48t59.h
@@ -1,7 +1,6 @@
 #ifndef HW_M48T59_H
 #define HW_M48T59_H
=20
-#include "qemu-common.h"
 #include "qom/object.h"
=20
 #define TYPE_NVRAM "nvram"
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.=
h
index 1155b79678..e05bc09794 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -21,7 +21,6 @@
 #ifndef HW_VFIO_VFIO_COMMON_H
 #define HW_VFIO_VFIO_COMMON_H
=20
-#include "qemu-common.h"
 #include "exec/memory.h"
 #include "qemu/queue.h"
 #include "qemu/notify.h"
diff --git a/include/hw/virtio/vhost-scsi-common.h b/include/hw/virtio/vh=
ost-scsi-common.h
index 4eab767ee8..54357164f0 100644
--- a/include/hw/virtio/vhost-scsi-common.h
+++ b/include/hw/virtio/vhost-scsi-common.h
@@ -14,7 +14,6 @@
 #ifndef VHOST_SCSI_COMMON_H
 #define VHOST_SCSI_COMMON_H
=20
-#include "qemu-common.h"
 #include "hw/qdev.h"
 #include "hw/virtio/virtio-scsi.h"
 #include "hw/virtio/vhost.h"
diff --git a/include/hw/virtio/vhost-scsi.h b/include/hw/virtio/vhost-scs=
i.h
index 04658d14f5..df5bfdb188 100644
--- a/include/hw/virtio/vhost-scsi.h
+++ b/include/hw/virtio/vhost-scsi.h
@@ -14,7 +14,6 @@
 #ifndef VHOST_SCSI_H
 #define VHOST_SCSI_H
=20
-#include "qemu-common.h"
 #include "hw/qdev.h"
 #include "hw/virtio/virtio-scsi.h"
 #include "hw/virtio/vhost.h"
diff --git a/include/hw/virtio/vhost-user-blk.h b/include/hw/virtio/vhost=
-user-blk.h
index 51457fb857..8dbf11c6f0 100644
--- a/include/hw/virtio/vhost-user-blk.h
+++ b/include/hw/virtio/vhost-user-blk.h
@@ -16,7 +16,6 @@
 #define VHOST_USER_BLK_H
=20
 #include "standard-headers/linux/virtio_blk.h"
-#include "qemu-common.h"
 #include "hw/qdev.h"
 #include "hw/block/block.h"
 #include "chardev/char-fe.h"
diff --git a/include/hw/virtio/vhost-user-scsi.h b/include/hw/virtio/vhos=
t-user-scsi.h
index 738f9288bd..1b332ea910 100644
--- a/include/hw/virtio/vhost-user-scsi.h
+++ b/include/hw/virtio/vhost-user-scsi.h
@@ -17,7 +17,6 @@
 #ifndef VHOST_USER_SCSI_H
 #define VHOST_USER_SCSI_H
=20
-#include "qemu-common.h"
 #include "hw/qdev.h"
 #include "hw/virtio/virtio-scsi.h"
 #include "hw/virtio/vhost.h"
diff --git a/include/hw/xen/xen.h b/include/hw/xen/xen.h
index ba039c146d..9c7b5f78dc 100644
--- a/include/hw/xen/xen.h
+++ b/include/hw/xen/xen.h
@@ -8,7 +8,6 @@
  *   /usr/include/xen, so it can be included unconditionally.
  */
=20
-#include "qemu-common.h"
 #include "exec/cpu-common.h"
 #include "hw/irq.h"
=20
diff --git a/include/io/channel.h b/include/io/channel.h
index 59460cb1ec..d4557f0930 100644
--- a/include/io/channel.h
+++ b/include/io/channel.h
@@ -21,7 +21,6 @@
 #ifndef QIO_CHANNEL_H
 #define QIO_CHANNEL_H
=20
-#include "qemu-common.h"
 #include "qom/object.h"
 #include "qemu/coroutine.h"
 #include "block/aio.h"
diff --git a/include/io/dns-resolver.h b/include/io/dns-resolver.h
index 1a162185cc..a475e978c8 100644
--- a/include/io/dns-resolver.h
+++ b/include/io/dns-resolver.h
@@ -21,7 +21,6 @@
 #ifndef QIO_DNS_RESOLVER_H
 #define QIO_DNS_RESOLVER_H
=20
-#include "qemu-common.h"
 #include "qapi/qapi-types-sockets.h"
 #include "qom/object.h"
 #include "io/task.h"
diff --git a/include/io/task.h b/include/io/task.h
index 57d8ba835e..5cb9faf9f2 100644
--- a/include/io/task.h
+++ b/include/io/task.h
@@ -21,7 +21,6 @@
 #ifndef QIO_TASK_H
 #define QIO_TASK_H
=20
-#include "qemu-common.h"
 #include "qom/object.h"
=20
 typedef struct QIOTask QIOTask;
diff --git a/include/migration/colo.h b/include/migration/colo.h
index f6fbe23ec9..1636e6f907 100644
--- a/include/migration/colo.h
+++ b/include/migration/colo.h
@@ -13,7 +13,6 @@
 #ifndef QEMU_COLO_H
 #define QEMU_COLO_H
=20
-#include "qemu-common.h"
 #include "qapi/qapi-types-migration.h"
=20
 enum colo_event {
diff --git a/include/migration/failover.h b/include/migration/failover.h
index 4c37218dcc..475f88f533 100644
--- a/include/migration/failover.h
+++ b/include/migration/failover.h
@@ -13,7 +13,6 @@
 #ifndef QEMU_FAILOVER_H
 #define QEMU_FAILOVER_H
=20
-#include "qemu-common.h"
 #include "qapi/qapi-types-migration.h"
=20
 void failover_init_state(void);
diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
index 86656297f1..06cfcd8f36 100644
--- a/include/monitor/monitor.h
+++ b/include/monitor/monitor.h
@@ -1,7 +1,6 @@
 #ifndef MONITOR_H
 #define MONITOR_H
=20
-#include "qemu-common.h"
 #include "block/block.h"
 #include "qapi/qapi-types-misc.h"
 #include "qemu/readline.h"
diff --git a/include/net/announce.h b/include/net/announce.h
index 892d302b65..04a035f679 100644
--- a/include/net/announce.h
+++ b/include/net/announce.h
@@ -9,7 +9,6 @@
 #ifndef QEMU_NET_ANNOUNCE_H
 #define QEMU_NET_ANNOUNCE_H
=20
-#include "qemu-common.h"
 #include "qapi/qapi-types-net.h"
 #include "qemu/timer.h"
=20
diff --git a/include/net/filter.h b/include/net/filter.h
index 49da666ac0..9bc6fa3cc6 100644
--- a/include/net/filter.h
+++ b/include/net/filter.h
@@ -11,7 +11,6 @@
=20
 #include "qapi/qapi-types-net.h"
 #include "qom/object.h"
-#include "qemu-common.h"
 #include "net/queue.h"
=20
 #define TYPE_NETFILTER "netfilter"
diff --git a/include/net/queue.h b/include/net/queue.h
index 5469fdbeaa..c0269bb1dc 100644
--- a/include/net/queue.h
+++ b/include/net/queue.h
@@ -24,7 +24,6 @@
 #ifndef QEMU_NET_QUEUE_H
 #define QEMU_NET_QUEUE_H
=20
-#include "qemu-common.h"
=20
 typedef struct NetPacket NetPacket;
 typedef struct NetQueue NetQueue;
diff --git a/include/net/tap.h b/include/net/tap.h
index ce6f8418ac..5d585515f9 100644
--- a/include/net/tap.h
+++ b/include/net/tap.h
@@ -26,7 +26,6 @@
 #ifndef QEMU_NET_TAP_H
 #define QEMU_NET_TAP_H
=20
-#include "qemu-common.h"
 #include "standard-headers/linux/virtio_net.h"
=20
 int tap_enable(NetClientState *nc);
diff --git a/include/qemu-common.h b/include/qemu-common.h
index e15adc20dc..0235cd3b91 100644
--- a/include/qemu-common.h
+++ b/include/qemu-common.h
@@ -1,6 +1,4 @@
-
-/* Common header file that is included by all of QEMU.
- *
+/*
  * This file is supposed to be included only by .c files. No header file=
 should
  * depend on qemu-common.h, as this would easily lead to circular header
  * dependencies.
diff --git a/include/qemu-io.h b/include/qemu-io.h
index 7433239372..3af513004a 100644
--- a/include/qemu-io.h
+++ b/include/qemu-io.h
@@ -18,7 +18,6 @@
 #ifndef QEMU_IO_H
 #define QEMU_IO_H
=20
-#include "qemu-common.h"
=20
 #define CMD_FLAG_GLOBAL ((int)0x80000000) /* don't iterate "args" */
=20
diff --git a/include/qemu/base64.h b/include/qemu/base64.h
index 815d85267d..0a3c5c9c53 100644
--- a/include/qemu/base64.h
+++ b/include/qemu/base64.h
@@ -21,7 +21,6 @@
 #ifndef QEMU_BASE64_H
 #define QEMU_BASE64_H
=20
-#include "qemu-common.h"
=20
=20
 /**
diff --git a/include/qemu/buffer.h b/include/qemu/buffer.h
index b2ead1f051..3a909aeca4 100644
--- a/include/qemu/buffer.h
+++ b/include/qemu/buffer.h
@@ -21,7 +21,6 @@
 #ifndef QEMU_BUFFER_H
 #define QEMU_BUFFER_H
=20
-#include "qemu-common.h"
=20
 typedef struct Buffer Buffer;
=20
diff --git a/include/qemu/crc32c.h b/include/qemu/crc32c.h
index dafb6a1ada..5b78884c38 100644
--- a/include/qemu/crc32c.h
+++ b/include/qemu/crc32c.h
@@ -28,7 +28,6 @@
 #ifndef QEMU_CRC32C_H
 #define QEMU_CRC32C_H
=20
-#include "qemu-common.h"
=20
 uint32_t crc32c(uint32_t crc, const uint8_t *data, unsigned int length);
=20
diff --git a/include/qemu/event_notifier.h b/include/qemu/event_notifier.=
h
index 599c99f1a5..3380b662f3 100644
--- a/include/qemu/event_notifier.h
+++ b/include/qemu/event_notifier.h
@@ -13,7 +13,6 @@
 #ifndef QEMU_EVENT_NOTIFIER_H
 #define QEMU_EVENT_NOTIFIER_H
=20
-#include "qemu-common.h"
=20
 #ifdef _WIN32
 #include <windows.h>
diff --git a/include/qemu/filemonitor.h b/include/qemu/filemonitor.h
index 70e613dfe3..a41ceb0244 100644
--- a/include/qemu/filemonitor.h
+++ b/include/qemu/filemonitor.h
@@ -21,7 +21,6 @@
 #ifndef QEMU_FILEMONITOR_H
 #define QEMU_FILEMONITOR_H
=20
-#include "qemu-common.h"
=20
=20
 typedef struct QFileMonitor QFileMonitor;
diff --git a/include/qemu/mmap-alloc.h b/include/qemu/mmap-alloc.h
index eec98d82c1..e786266b92 100644
--- a/include/qemu/mmap-alloc.h
+++ b/include/qemu/mmap-alloc.h
@@ -1,7 +1,6 @@
 #ifndef QEMU_MMAP_ALLOC_H
 #define QEMU_MMAP_ALLOC_H
=20
-#include "qemu-common.h"
=20
 size_t qemu_fd_getpagesize(int fd);
=20
diff --git a/include/qemu/qdist.h b/include/qemu/qdist.h
index 54ece760d6..bfb3211537 100644
--- a/include/qemu/qdist.h
+++ b/include/qemu/qdist.h
@@ -7,7 +7,6 @@
 #ifndef QEMU_QDIST_H
 #define QEMU_QDIST_H
=20
-#include "qemu-common.h"
 #include "qemu/bitops.h"
=20
 /*
diff --git a/include/qemu/throttle.h b/include/qemu/throttle.h
index abeb886d93..05f6346137 100644
--- a/include/qemu/throttle.h
+++ b/include/qemu/throttle.h
@@ -25,7 +25,6 @@
 #ifndef THROTTLE_H
 #define THROTTLE_H
=20
-#include "qemu-common.h"
 #include "qapi/qapi-types-block-core.h"
 #include "qemu/timer.h"
=20
diff --git a/include/qemu/timer.h b/include/qemu/timer.h
index a86330c987..5d978e1634 100644
--- a/include/qemu/timer.h
+++ b/include/qemu/timer.h
@@ -1,7 +1,6 @@
 #ifndef QEMU_TIMER_H
 #define QEMU_TIMER_H
=20
-#include "qemu-common.h"
 #include "qemu/bitops.h"
 #include "qemu/notify.h"
 #include "qemu/host-utils.h"
diff --git a/include/qemu/uuid.h b/include/qemu/uuid.h
index 037357d990..129c45f2c5 100644
--- a/include/qemu/uuid.h
+++ b/include/qemu/uuid.h
@@ -16,7 +16,6 @@
 #ifndef QEMU_UUID_H
 #define QEMU_UUID_H
=20
-#include "qemu-common.h"
=20
 /* Version 4 UUID (pseudo random numbers), RFC4122 4.4. */
=20
diff --git a/include/sysemu/cryptodev-vhost.h b/include/sysemu/cryptodev-=
vhost.h
index fb26b86977..f42824fbde 100644
--- a/include/sysemu/cryptodev-vhost.h
+++ b/include/sysemu/cryptodev-vhost.h
@@ -24,7 +24,6 @@
 #ifndef CRYPTODEV_VHOST_H
 #define CRYPTODEV_VHOST_H
=20
-#include "qemu-common.h"
 #include "hw/virtio/vhost.h"
 #include "hw/virtio/vhost-backend.h"
 #include "chardev/char.h"
diff --git a/include/sysemu/cryptodev.h b/include/sysemu/cryptodev.h
index faeb6f891a..92bbb79131 100644
--- a/include/sysemu/cryptodev.h
+++ b/include/sysemu/cryptodev.h
@@ -24,7 +24,6 @@
 #define CRYPTODEV_H
=20
 #include "qom/object.h"
-#include "qemu-common.h"
=20
 /**
  * CryptoDevBackend:
diff --git a/include/sysemu/hax.h b/include/sysemu/hax.h
index 1f6c46186d..f005995c50 100644
--- a/include/sysemu/hax.h
+++ b/include/sysemu/hax.h
@@ -22,7 +22,6 @@
 #ifndef QEMU_HAX_H
 #define QEMU_HAX_H
=20
-#include "qemu-common.h"
=20
 int hax_sync_vcpus(void);
 int hax_init_vcpu(CPUState *cpu);
diff --git a/include/sysemu/hvf.h b/include/sysemu/hvf.h
index 300bf3e9a8..d275b5a843 100644
--- a/include/sysemu/hvf.h
+++ b/include/sysemu/hvf.h
@@ -13,7 +13,6 @@
 #ifndef HVF_H
 #define HVF_H
=20
-#include "qemu-common.h"
 #include "qemu/bitops.h"
 #include "exec/memory.h"
 #include "sysemu/accel.h"
diff --git a/include/sysemu/qtest.h b/include/sysemu/qtest.h
index 096ddfc20c..cd114b8d80 100644
--- a/include/sysemu/qtest.h
+++ b/include/sysemu/qtest.h
@@ -14,7 +14,6 @@
 #ifndef QTEST_H
 #define QTEST_H
=20
-#include "qemu-common.h"
=20
 extern bool qtest_allowed;
=20
diff --git a/include/sysemu/rng.h b/include/sysemu/rng.h
index 27b37da05d..2a02f47771 100644
--- a/include/sysemu/rng.h
+++ b/include/sysemu/rng.h
@@ -14,7 +14,6 @@
 #define QEMU_RNG_H
=20
 #include "qom/object.h"
-#include "qemu-common.h"
=20
 #define TYPE_RNG_BACKEND "rng-backend"
 #define RNG_BACKEND(obj) \
diff --git a/include/sysemu/tpm_backend.h b/include/sysemu/tpm_backend.h
index 14488820f6..9e7451fb52 100644
--- a/include/sysemu/tpm_backend.h
+++ b/include/sysemu/tpm_backend.h
@@ -14,7 +14,6 @@
 #define TPM_BACKEND_H
=20
 #include "qom/object.h"
-#include "qemu-common.h"
 #include "qemu/option.h"
 #include "sysemu/tpm.h"
 #include "qapi/error.h"
diff --git a/include/sysemu/whpx.h b/include/sysemu/whpx.h
index d200ee01d0..4794e8effe 100644
--- a/include/sysemu/whpx.h
+++ b/include/sysemu/whpx.h
@@ -13,7 +13,6 @@
 #ifndef QEMU_WHPX_H
 #define QEMU_WHPX_H
=20
-#include "qemu-common.h"
=20
 int whpx_init_vcpu(CPUState *cpu);
 int whpx_vcpu_exec(CPUState *cpu);
diff --git a/io/channel-socket.c b/io/channel-socket.c
index d898cfcd47..bec3d931d1 100644
--- a/io/channel-socket.c
+++ b/io/channel-socket.c
@@ -15,10 +15,10 @@
  *
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
- *
  */
=20
 #include "qemu/osdep.h"
+#include "qemu-common.h"
 #include "qapi/error.h"
 #include "qapi/qapi-visit-sockets.h"
 #include "qemu/module.h"
diff --git a/ioport.c b/ioport.c
index 1a65addb66..04e360e79a 100644
--- a/ioport.c
+++ b/ioport.c
@@ -26,7 +26,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "cpu.h"
 #include "exec/ioport.h"
 #include "trace-root.h"
diff --git a/job-qmp.c b/job-qmp.c
index a969b2bbf0..fbfed25a00 100644
--- a/job-qmp.c
+++ b/job-qmp.c
@@ -24,7 +24,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "qemu/job.h"
 #include "qapi/qapi-commands-job.h"
 #include "qapi/error.h"
diff --git a/job.c b/job.c
index 2167d53717..28dd48f8a5 100644
--- a/job.c
+++ b/job.c
@@ -24,7 +24,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "qapi/error.h"
 #include "qemu/job.h"
 #include "qemu/id.h"
diff --git a/linux-user/aarch64/cpu_loop.c b/linux-user/aarch64/cpu_loop.=
c
index 2f2f63e3e8..d80131a457 100644
--- a/linux-user/aarch64/cpu_loop.c
+++ b/linux-user/aarch64/cpu_loop.c
@@ -18,6 +18,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu-common.h"
 #include "qemu.h"
 #include "cpu_loop-common.h"
 #include "qemu/guest-random.h"
diff --git a/linux-user/alpha/cpu_loop.c b/linux-user/alpha/cpu_loop.c
index 61992571e1..6b29672038 100644
--- a/linux-user/alpha/cpu_loop.c
+++ b/linux-user/alpha/cpu_loop.c
@@ -18,6 +18,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu-common.h"
 #include "qemu.h"
 #include "cpu_loop-common.h"
=20
diff --git a/linux-user/arm/cpu_loop.c b/linux-user/arm/cpu_loop.c
index ee68aa60bf..7970185712 100644
--- a/linux-user/arm/cpu_loop.c
+++ b/linux-user/arm/cpu_loop.c
@@ -18,6 +18,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu-common.h"
 #include "qemu.h"
 #include "elf.h"
 #include "cpu_loop-common.h"
diff --git a/linux-user/cris/cpu_loop.c b/linux-user/cris/cpu_loop.c
index af8c128bf8..f4e1dfb5e3 100644
--- a/linux-user/cris/cpu_loop.c
+++ b/linux-user/cris/cpu_loop.c
@@ -18,6 +18,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu-common.h"
 #include "qemu.h"
 #include "cpu_loop-common.h"
=20
diff --git a/linux-user/i386/cpu_loop.c b/linux-user/i386/cpu_loop.c
index 51cfa006c9..ad11c64516 100644
--- a/linux-user/i386/cpu_loop.c
+++ b/linux-user/i386/cpu_loop.c
@@ -18,6 +18,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu-common.h"
 #include "qemu.h"
 #include "cpu_loop-common.h"
=20
diff --git a/linux-user/m68k/cpu_loop.c b/linux-user/m68k/cpu_loop.c
index bfb41bbcc5..dd87e5cfb3 100644
--- a/linux-user/m68k/cpu_loop.c
+++ b/linux-user/m68k/cpu_loop.c
@@ -18,6 +18,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu-common.h"
 #include "qemu.h"
 #include "cpu_loop-common.h"
=20
diff --git a/linux-user/main.c b/linux-user/main.c
index ef88ba3679..d4d0d9049c 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -18,6 +18,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu-common.h"
 #include "qemu/units.h"
 #include "sysemu/tcg.h"
 #include "qemu-version.h"
diff --git a/linux-user/microblaze/cpu_loop.c b/linux-user/microblaze/cpu=
_loop.c
index 076bdb9a61..d2c2e15e4a 100644
--- a/linux-user/microblaze/cpu_loop.c
+++ b/linux-user/microblaze/cpu_loop.c
@@ -18,6 +18,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu-common.h"
 #include "qemu.h"
 #include "cpu_loop-common.h"
=20
diff --git a/linux-user/mips/cpu_loop.c b/linux-user/mips/cpu_loop.c
index 61dc90d51c..1134e44d60 100644
--- a/linux-user/mips/cpu_loop.c
+++ b/linux-user/mips/cpu_loop.c
@@ -18,6 +18,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu-common.h"
 #include "qemu.h"
 #include "cpu_loop-common.h"
 #include "elf.h"
diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index af41339d57..46a6e3a761 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -19,7 +19,6 @@
 #include "qemu/osdep.h"
=20
 #include "qemu.h"
-#include "qemu-common.h"
=20
 //#define DEBUG_MMAP
=20
diff --git a/linux-user/openrisc/cpu_loop.c b/linux-user/openrisc/cpu_loo=
p.c
index f496e4b48a..282864c6ba 100644
--- a/linux-user/openrisc/cpu_loop.c
+++ b/linux-user/openrisc/cpu_loop.c
@@ -18,6 +18,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu-common.h"
 #include "qemu.h"
 #include "cpu_loop-common.h"
=20
diff --git a/linux-user/ppc/cpu_loop.c b/linux-user/ppc/cpu_loop.c
index 801f5ace29..c14bb03b56 100644
--- a/linux-user/ppc/cpu_loop.c
+++ b/linux-user/ppc/cpu_loop.c
@@ -18,6 +18,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu-common.h"
 #include "qemu.h"
 #include "cpu_loop-common.h"
=20
diff --git a/linux-user/riscv/cpu_loop.c b/linux-user/riscv/cpu_loop.c
index a9bac4ca79..9154a6b6bd 100644
--- a/linux-user/riscv/cpu_loop.c
+++ b/linux-user/riscv/cpu_loop.c
@@ -18,6 +18,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu-common.h"
 #include "qemu/error-report.h"
 #include "qemu.h"
 #include "cpu_loop-common.h"
diff --git a/linux-user/s390x/cpu_loop.c b/linux-user/s390x/cpu_loop.c
index b8bd1c956c..48fbdc42d6 100644
--- a/linux-user/s390x/cpu_loop.c
+++ b/linux-user/s390x/cpu_loop.c
@@ -18,6 +18,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu-common.h"
 #include "qemu.h"
 #include "cpu_loop-common.h"
=20
diff --git a/linux-user/sh4/cpu_loop.c b/linux-user/sh4/cpu_loop.c
index 59cbbeda7e..d85a4e22fe 100644
--- a/linux-user/sh4/cpu_loop.c
+++ b/linux-user/sh4/cpu_loop.c
@@ -18,6 +18,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu-common.h"
 #include "qemu.h"
 #include "cpu_loop-common.h"
=20
diff --git a/linux-user/signal.c b/linux-user/signal.c
index 44b2d3b35a..762f077576 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -22,7 +22,6 @@
 #include <sys/resource.h>
=20
 #include "qemu.h"
-#include "qemu-common.h"
 #include "trace.h"
 #include "signal-common.h"
=20
diff --git a/linux-user/sparc/cpu_loop.c b/linux-user/sparc/cpu_loop.c
index 9e357229c0..02c385a532 100644
--- a/linux-user/sparc/cpu_loop.c
+++ b/linux-user/sparc/cpu_loop.c
@@ -18,6 +18,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu-common.h"
 #include "qemu.h"
 #include "cpu_loop-common.h"
=20
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 5e29e675e9..610ada048f 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -55,7 +55,6 @@
 #include <linux/icmpv6.h>
 #include <linux/errqueue.h>
 #include <linux/random.h>
-#include "qemu-common.h"
 #ifdef CONFIG_TIMERFD
 #include <sys/timerfd.h>
 #endif
diff --git a/linux-user/tilegx/cpu_loop.c b/linux-user/tilegx/cpu_loop.c
index 4f39eb9ad3..a51c98de11 100644
--- a/linux-user/tilegx/cpu_loop.c
+++ b/linux-user/tilegx/cpu_loop.c
@@ -18,6 +18,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu-common.h"
 #include "qemu.h"
 #include "cpu_loop-common.h"
=20
diff --git a/memory_mapping.c b/memory_mapping.c
index e3ec70624f..18d0b8067c 100644
--- a/memory_mapping.c
+++ b/memory_mapping.c
@@ -14,7 +14,6 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
=20
-#include "qemu-common.h"
 #include "cpu.h"
 #include "sysemu/memory_mapping.h"
 #include "exec/memory.h"
diff --git a/migration/migration.h b/migration/migration.h
index 780a096857..5e8f09c6db 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -14,7 +14,6 @@
 #ifndef QEMU_MIGRATION_H
 #define QEMU_MIGRATION_H
=20
-#include "qemu-common.h"
 #include "qapi/qapi-types-migration.h"
 #include "qemu/thread.h"
 #include "exec/cpu-common.h"
diff --git a/migration/page_cache.c b/migration/page_cache.c
index acc252b100..775582f453 100644
--- a/migration/page_cache.c
+++ b/migration/page_cache.c
@@ -16,7 +16,6 @@
=20
 #include "qapi/qmp/qerror.h"
 #include "qapi/error.h"
-#include "qemu-common.h"
 #include "qemu/host-utils.h"
 #include "page_cache.h"
=20
diff --git a/migration/qemu-file.c b/migration/qemu-file.c
index 977b9ae07c..0431585502 100644
--- a/migration/qemu-file.c
+++ b/migration/qemu-file.c
@@ -23,7 +23,6 @@
  */
 #include "qemu/osdep.h"
 #include <zlib.h>
-#include "qemu-common.h"
 #include "qemu/error-report.h"
 #include "qemu/iov.h"
 #include "migration.h"
diff --git a/migration/ram.h b/migration/ram.h
index 936177b3e9..bd0eee79b6 100644
--- a/migration/ram.h
+++ b/migration/ram.h
@@ -29,7 +29,6 @@
 #ifndef QEMU_MIGRATION_RAM_H
 #define QEMU_MIGRATION_RAM_H
=20
-#include "qemu-common.h"
 #include "qapi/qapi-types-migration.h"
 #include "exec/cpu-common.h"
 #include "io/channel.h"
diff --git a/migration/socket.c b/migration/socket.c
index 49bacf78fd..98efdc0286 100644
--- a/migration/socket.c
+++ b/migration/socket.c
@@ -17,7 +17,6 @@
 #include "qemu/osdep.h"
 #include "qemu/cutils.h"
=20
-#include "qemu-common.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "channel.h"
diff --git a/migration/vmstate-types.c b/migration/vmstate-types.c
index 6f75f97a07..845f4649ee 100644
--- a/migration/vmstate-types.c
+++ b/migration/vmstate-types.c
@@ -11,7 +11,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "exec/cpu-common.h"
 #include "qemu-file.h"
 #include "migration.h"
diff --git a/migration/vmstate.c b/migration/vmstate.c
index 1305d1a528..7dd8ef66c6 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -11,7 +11,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "migration.h"
 #include "migration/vmstate.h"
 #include "savevm.h"
diff --git a/net/checksum.c b/net/checksum.c
index 273bc9c6bc..aaa4000238 100644
--- a/net/checksum.c
+++ b/net/checksum.c
@@ -16,7 +16,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "net/checksum.h"
 #include "net/eth.h"
=20
diff --git a/net/colo-compare.c b/net/colo-compare.c
index fcb491121b..103297b7f4 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -13,9 +13,9 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu-common.h"
 #include "qemu/error-report.h"
 #include "trace.h"
-#include "qemu-common.h"
 #include "qapi/error.h"
 #include "net/net.h"
 #include "net/eth.h"
diff --git a/net/dump.c b/net/dump.c
index cd34f51759..23b3628dde 100644
--- a/net/dump.c
+++ b/net/dump.c
@@ -23,6 +23,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu-common.h"
 #include "clients.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
diff --git a/net/eth.c b/net/eth.c
index ae5d881aae..0c1d413ee2 100644
--- a/net/eth.c
+++ b/net/eth.c
@@ -18,7 +18,6 @@
 #include "qemu/osdep.h"
 #include "net/eth.h"
 #include "net/checksum.h"
-#include "qemu-common.h"
 #include "net/tap.h"
=20
 void eth_setup_vlan_headers_ex(struct eth_header *ehdr, uint16_t vlan_ta=
g,
diff --git a/net/filter-buffer.c b/net/filter-buffer.c
index f7265c50a8..88da78f821 100644
--- a/net/filter-buffer.c
+++ b/net/filter-buffer.c
@@ -10,7 +10,6 @@
 #include "net/filter.h"
 #include "net/queue.h"
 #include "qapi/error.h"
-#include "qemu-common.h"
 #include "qemu/timer.h"
 #include "qemu/iov.h"
 #include "qapi/qapi-builtin-visit.h"
diff --git a/net/filter-mirror.c b/net/filter-mirror.c
index 3a61cf21e8..8d36009c53 100644
--- a/net/filter-mirror.c
+++ b/net/filter-mirror.c
@@ -12,7 +12,6 @@
 #include "qemu/osdep.h"
 #include "net/filter.h"
 #include "net/net.h"
-#include "qemu-common.h"
 #include "qapi/error.h"
 #include "qom/object.h"
 #include "qemu/main-loop.h"
diff --git a/net/filter-rewriter.c b/net/filter-rewriter.c
index b464abe5e8..31da08a2f4 100644
--- a/net/filter-rewriter.c
+++ b/net/filter-rewriter.c
@@ -14,7 +14,6 @@
 #include "colo.h"
 #include "net/filter.h"
 #include "net/net.h"
-#include "qemu-common.h"
 #include "qemu/error-report.h"
 #include "qom/object.h"
 #include "qemu/main-loop.h"
diff --git a/net/hub.h b/net/hub.h
index 6a16f0487a..66d3322fac 100644
--- a/net/hub.h
+++ b/net/hub.h
@@ -15,7 +15,6 @@
 #ifndef NET_HUB_H
 #define NET_HUB_H
=20
-#include "qemu-common.h"
=20
 NetClientState *net_hub_add_port(int hub_id, const char *name,
                                  NetClientState *hubpeer);
diff --git a/net/l2tpv3.c b/net/l2tpv3.c
index 81db24dc8c..55fea17c0f 100644
--- a/net/l2tpv3.c
+++ b/net/l2tpv3.c
@@ -29,7 +29,6 @@
 #include "net/net.h"
 #include "clients.h"
 #include "qapi/error.h"
-#include "qemu-common.h"
 #include "qemu/error-report.h"
 #include "qemu/option.h"
 #include "qemu/sockets.h"
diff --git a/net/tap-linux.c b/net/tap-linux.c
index 535b1ddb61..941a45d7c3 100644
--- a/net/tap-linux.c
+++ b/net/tap-linux.c
@@ -24,6 +24,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu-common.h"
 #include "tap_int.h"
 #include "tap-linux.h"
 #include "net/tap.h"
diff --git a/net/tap_int.h b/net/tap_int.h
index 9f931d52d6..e3194b23f4 100644
--- a/net/tap_int.h
+++ b/net/tap_int.h
@@ -26,7 +26,6 @@
 #ifndef NET_TAP_INT_H
 #define NET_TAP_INT_H
=20
-#include "qemu-common.h"
 #include "qapi/qapi-types-net.h"
=20
 int tap_open(char *ifname, int ifname_size, int *vnet_hdr,
diff --git a/os-posix.c b/os-posix.c
index 4bd80e44e6..3ba7df8d75 100644
--- a/os-posix.c
+++ b/os-posix.c
@@ -29,6 +29,7 @@
 #include <grp.h>
 #include <libgen.h>
=20
+#include "qemu-common.h"
 /* Needed early for CONFIG_BSD etc. */
 #include "sysemu/sysemu.h"
 #include "net/slirp.h"
diff --git a/os-win32.c b/os-win32.c
index 0e0d7f50f3..6d92189810 100644
--- a/os-win32.c
+++ b/os-win32.c
@@ -22,9 +22,11 @@
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
  * THE SOFTWARE.
  */
+
 #include "qemu/osdep.h"
 #include <windows.h>
 #include <mmsystem.h>
+#include "qemu-common.h"
 #include "sysemu/sysemu.h"
 #include "qemu-options.h"
=20
diff --git a/qapi/qapi-dealloc-visitor.c b/qapi/qapi-dealloc-visitor.c
index 6b24afd367..89ccd905ec 100644
--- a/qapi/qapi-dealloc-visitor.c
+++ b/qapi/qapi-dealloc-visitor.c
@@ -16,7 +16,6 @@
 #include "qapi/dealloc-visitor.h"
 #include "qapi/qmp/qnull.h"
 #include "qemu/queue.h"
-#include "qemu-common.h"
 #include "qapi/visitor-impl.h"
=20
 struct QapiDeallocVisitor
diff --git a/qapi/qapi-visit-core.c b/qapi/qapi-visit-core.c
index d9a113726f..5365561b07 100644
--- a/qapi/qapi-visit-core.c
+++ b/qapi/qapi-visit-core.c
@@ -14,7 +14,6 @@
=20
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qemu-common.h"
 #include "qapi/qmp/qerror.h"
 #include "qapi/visitor.h"
 #include "qapi/visitor-impl.h"
diff --git a/qapi/qmp-event.c b/qapi/qmp-event.c
index 81ddd5331f..19d3cd0038 100644
--- a/qapi/qmp-event.c
+++ b/qapi/qmp-event.c
@@ -13,7 +13,6 @@
=20
 #include "qemu/osdep.h"
=20
-#include "qemu-common.h"
 #include "qapi/qmp-event.h"
 #include "qapi/qmp/qstring.h"
 #include "qapi/qmp/qdict.h"
diff --git a/qapi/qobject-input-visitor.c b/qapi/qobject-input-visitor.c
index 07465f9947..32236cbcb1 100644
--- a/qapi/qobject-input-visitor.c
+++ b/qapi/qobject-input-visitor.c
@@ -18,7 +18,6 @@
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/visitor-impl.h"
 #include "qemu/queue.h"
-#include "qemu-common.h"
 #include "qapi/qmp/qjson.h"
 #include "qapi/qmp/qbool.h"
 #include "qapi/qmp/qdict.h"
diff --git a/qapi/qobject-output-visitor.c b/qapi/qobject-output-visitor.=
c
index 89ffd8a7bf..26d7be5ec9 100644
--- a/qapi/qobject-output-visitor.c
+++ b/qapi/qobject-output-visitor.c
@@ -16,7 +16,6 @@
 #include "qapi/qobject-output-visitor.h"
 #include "qapi/visitor-impl.h"
 #include "qemu/queue.h"
-#include "qemu-common.h"
 #include "qapi/qmp/qbool.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qlist.h"
diff --git a/qapi/string-input-visitor.c b/qapi/string-input-visitor.c
index bd92080667..9be418b6d6 100644
--- a/qapi/string-input-visitor.c
+++ b/qapi/string-input-visitor.c
@@ -12,7 +12,6 @@
=20
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qemu-common.h"
 #include "qapi/string-input-visitor.h"
 #include "qapi/visitor-impl.h"
 #include "qapi/qmp/qerror.h"
diff --git a/qemu-edid.c b/qemu-edid.c
index ae8b8a6d9b..46eef70498 100644
--- a/qemu-edid.c
+++ b/qemu-edid.c
@@ -5,7 +5,6 @@
  * See the COPYING file in the top-level directory.
  */
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "qemu/bswap.h"
 #include "qemu/cutils.h"
 #include "hw/display/edid.h"
diff --git a/qemu-img.c b/qemu-img.c
index c221e3cb24..fd62e3ad5d 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -25,6 +25,7 @@
 #include "qemu/osdep.h"
 #include <getopt.h>
=20
+#include "qemu-common.h"
 #include "qemu-version.h"
 #include "qapi/error.h"
 #include "qapi/qapi-visit-block-core.h"
diff --git a/qemu-io.c b/qemu-io.c
index 968f0e3dbf..f64eca6940 100644
--- a/qemu-io.c
+++ b/qemu-io.c
@@ -15,6 +15,7 @@
 #include <termios.h>
 #endif
=20
+#include "qemu-common.h"
 #include "qapi/error.h"
 #include "qemu-io.h"
 #include "qemu/error-report.h"
diff --git a/qemu-keymap.c b/qemu-keymap.c
index 4d00468747..536e8f2385 100644
--- a/qemu-keymap.c
+++ b/qemu-keymap.c
@@ -10,7 +10,6 @@
  * See the COPYING file in the top-level directory.
  */
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "qemu/notify.h"
 #include "ui/input.h"
=20
diff --git a/qemu-nbd.c b/qemu-nbd.c
index 410373a321..e24dd2f767 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -21,6 +21,7 @@
 #include <libgen.h>
 #include <pthread.h>
=20
+#include "qemu-common.h"
 #include "qapi/error.h"
 #include "qemu/cutils.h"
 #include "sysemu/block-backend.h"
diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index 7ee6a33cce..dfc05f5b8a 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -16,6 +16,7 @@
 #include <sys/utsname.h>
 #include <sys/wait.h>
 #include <dirent.h>
+#include "qemu-common.h"
 #include "guest-agent-core.h"
 #include "qga-qapi-commands.h"
 #include "qapi/error.h"
diff --git a/qga/guest-agent-core.h b/qga/guest-agent-core.h
index 60eae16f27..9d01ea9c82 100644
--- a/qga/guest-agent-core.h
+++ b/qga/guest-agent-core.h
@@ -14,7 +14,6 @@
 #define GUEST_AGENT_CORE_H
=20
 #include "qapi/qmp/dispatch.h"
-#include "qemu-common.h"
 #include "qga-qapi-types.h"
=20
 #define QGA_READ_COUNT_DEFAULT 4096
diff --git a/qga/main.c b/qga/main.c
index b54b55589d..c35c2a2120 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -18,6 +18,7 @@
 #include <syslog.h>
 #include <sys/wait.h>
 #endif
+#include "qemu-common.h"
 #include "qapi/qmp/json-parser.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qjson.h"
diff --git a/qmp.c b/qmp.c
index fa1b3c1577..6797568444 100644
--- a/qmp.c
+++ b/qmp.c
@@ -14,6 +14,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu-common.h"
 #include "qemu-version.h"
 #include "qemu/cutils.h"
 #include "qemu/option.h"
diff --git a/qom/qom-qobject.c b/qom/qom-qobject.c
index 4aec20d73c..c3b95aa354 100644
--- a/qom/qom-qobject.c
+++ b/qom/qom-qobject.c
@@ -11,7 +11,6 @@
=20
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qemu-common.h"
 #include "qom/object.h"
 #include "qom/qom-qobject.h"
 #include "qapi/visitor.h"
diff --git a/replay/replay-events.c b/replay/replay-events.c
index d9a2d495b9..60d17f6edb 100644
--- a/replay/replay-events.c
+++ b/replay/replay-events.c
@@ -10,7 +10,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "qemu/error-report.h"
 #include "sysemu/replay.h"
 #include "replay-internal.h"
diff --git a/replay/replay-input.c b/replay/replay-input.c
index 6ee8b5f8db..1147e3d34e 100644
--- a/replay/replay-input.c
+++ b/replay/replay-input.c
@@ -10,7 +10,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "sysemu/replay.h"
 #include "replay-internal.h"
 #include "qemu/notify.h"
diff --git a/replay/replay-internal.c b/replay/replay-internal.c
index 8f87e9b957..9e41ed1dcf 100644
--- a/replay/replay-internal.c
+++ b/replay/replay-internal.c
@@ -10,7 +10,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "sysemu/replay.h"
 #include "replay-internal.h"
 #include "qemu/error-report.h"
diff --git a/replay/replay-snapshot.c b/replay/replay-snapshot.c
index 16bacc98bc..756f48bc02 100644
--- a/replay/replay-snapshot.c
+++ b/replay/replay-snapshot.c
@@ -11,7 +11,6 @@
=20
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qemu-common.h"
 #include "sysemu/replay.h"
 #include "replay-internal.h"
 #include "sysemu/sysemu.h"
diff --git a/replay/replay-time.c b/replay/replay-time.c
index 0df1693337..5154cb0ce9 100644
--- a/replay/replay-time.c
+++ b/replay/replay-time.c
@@ -10,7 +10,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "sysemu/replay.h"
 #include "replay-internal.h"
 #include "qemu/error-report.h"
diff --git a/scripts/modules/module_block.py b/scripts/modules/module_blo=
ck.py
index 3f73007640..08646af92c 100644
--- a/scripts/modules/module_block.py
+++ b/scripts/modules/module_block.py
@@ -68,8 +68,6 @@ def print_top(fheader):
     fheader.write('''#ifndef QEMU_MODULE_BLOCK_H
 #define QEMU_MODULE_BLOCK_H
=20
-#include "qemu-common.h"
-
 static const struct {
     const char *format_name;
     const char *protocol_name;
diff --git a/scripts/qapi/events.py b/scripts/qapi/events.py
index 2067660be4..b732581046 100644
--- a/scripts/qapi/events.py
+++ b/scripts/qapi/events.py
@@ -148,7 +148,6 @@ class QAPISchemaGenEventVisitor(QAPISchemaModularCVis=
itor):
         visit =3D self._module_basename('qapi-visit', name)
         self._genc.add(mcgen('''
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "%(prefix)sqapi-emit-events.h"
 #include "%(events)s.h"
 #include "%(visit)s.h"
diff --git a/scripts/qapi/visit.py b/scripts/qapi/visit.py
index 826b8066e1..fd356151d2 100644
--- a/scripts/qapi/visit.py
+++ b/scripts/qapi/visit.py
@@ -287,7 +287,6 @@ class QAPISchemaGenVisitVisitor(QAPISchemaModularCVis=
itor):
         self._add_system_module(None, ' * Built-in QAPI visitors')
         self._genc.preamble_add(mcgen('''
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "qapi/error.h"
 #include "qapi/qapi-builtin-visit.h"
 '''))
@@ -303,7 +302,6 @@ class QAPISchemaGenVisitVisitor(QAPISchemaModularCVis=
itor):
         visit =3D self._module_basename('qapi-visit', name)
         self._genc.preamble_add(mcgen('''
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "qapi/error.h"
 #include "qapi/qmp/qerror.h"
 #include "%(visit)s.h"
diff --git a/scripts/tracetool/format/h.py b/scripts/tracetool/format/h.p=
y
index e06f0f27c5..338a2365ee 100644
--- a/scripts/tracetool/format/h.py
+++ b/scripts/tracetool/format/h.py
@@ -22,7 +22,6 @@ def generate(events, backend, group):
         '#ifndef TRACE_%s_GENERATED_TRACERS_H' % group.upper(),
         '#define TRACE_%s_GENERATED_TRACERS_H' % group.upper(),
         '',
-        '#include "qemu-common.h"',
         '#include "trace/control.h"',
         '')
=20
diff --git a/scripts/tracetool/format/tcg_helper_c.py b/scripts/tracetool=
/format/tcg_helper_c.py
index bbbd6ad0f4..03344ef825 100644
--- a/scripts/tracetool/format/tcg_helper_c.py
+++ b/scripts/tracetool/format/tcg_helper_c.py
@@ -52,7 +52,6 @@ def generate(events, backend, group):
     out('/* This file is autogenerated by tracetool, do not edit. */',
         '',
         '#include "qemu/osdep.h"',
-        '#include "qemu-common.h"',
         '#include "cpu.h"',
         '#include "exec/helper-proto.h"',
         '#include "%s"' % header,
diff --git a/scripts/tracetool/format/ust_events_h.py b/scripts/tracetool=
/format/ust_events_h.py
index 4e95e9b3f9..b14054ac01 100644
--- a/scripts/tracetool/format/ust_events_h.py
+++ b/scripts/tracetool/format/ust_events_h.py
@@ -37,7 +37,6 @@ def generate(events, backend, group):
         '     defined(TRACEPOINT_HEADER_MULTI_READ)',
         '#define TRACE_%s_GENERATED_UST_H' % group.upper(),
         '',
-        '#include "qemu-common.h"',
         '#include <lttng/tracepoint.h>',
         '',
         '/*',
diff --git a/scsi/qemu-pr-helper.c b/scsi/qemu-pr-helper.c
index 72acdc7527..a256ce490b 100644
--- a/scsi/qemu-pr-helper.c
+++ b/scsi/qemu-pr-helper.c
@@ -36,6 +36,7 @@
 #include <mpath_persist.h>
 #endif
=20
+#include "qemu-common.h"
 #include "qapi/error.h"
 #include "qemu/cutils.h"
 #include "qemu/main-loop.h"
diff --git a/stubs/bdrv-next-monitor-owned.c b/stubs/bdrv-next-monitor-ow=
ned.c
index 2acf6c3ec0..e62c289862 100644
--- a/stubs/bdrv-next-monitor-owned.c
+++ b/stubs/bdrv-next-monitor-owned.c
@@ -1,5 +1,4 @@
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "block/block.h"
=20
 BlockDriverState *bdrv_next_monitor_owned(BlockDriverState *bs)
diff --git a/stubs/blk-commit-all.c b/stubs/blk-commit-all.c
index c82fb7f5f8..e156c57f8d 100644
--- a/stubs/blk-commit-all.c
+++ b/stubs/blk-commit-all.c
@@ -1,5 +1,4 @@
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "sysemu/block-backend.h"
=20
 int blk_commit_all(void)
diff --git a/stubs/change-state-handler.c b/stubs/change-state-handler.c
index 01b1c6986d..d14194b36b 100644
--- a/stubs/change-state-handler.c
+++ b/stubs/change-state-handler.c
@@ -1,5 +1,4 @@
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "sysemu/sysemu.h"
=20
 VMChangeStateEntry *qemu_add_vm_change_state_handler(VMChangeStateHandle=
r *cb,
diff --git a/stubs/clock-warp.c b/stubs/clock-warp.c
index 8acb58a775..b53e5dd94c 100644
--- a/stubs/clock-warp.c
+++ b/stubs/clock-warp.c
@@ -1,5 +1,4 @@
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "qemu/timer.h"
=20
 void qemu_start_warp_timer(void)
diff --git a/stubs/cpu-get-clock.c b/stubs/cpu-get-clock.c
index 1d07523b86..5a92810e87 100644
--- a/stubs/cpu-get-clock.c
+++ b/stubs/cpu-get-clock.c
@@ -1,5 +1,4 @@
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "qemu/timer.h"
=20
 int64_t cpu_get_clock(void)
diff --git a/stubs/cpu-get-icount.c b/stubs/cpu-get-icount.c
index 35f0c1e24c..b35f844638 100644
--- a/stubs/cpu-get-icount.c
+++ b/stubs/cpu-get-icount.c
@@ -1,5 +1,4 @@
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "qemu/timer.h"
 #include "sysemu/cpus.h"
 #include "qemu/main-loop.h"
diff --git a/stubs/dump.c b/stubs/dump.c
index 8e5032c3af..1f28ec2be3 100644
--- a/stubs/dump.c
+++ b/stubs/dump.c
@@ -12,7 +12,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "sysemu/dump-arch.h"
=20
 int cpu_get_dump_info(ArchDumpInfo *info,
diff --git a/stubs/error-printf.c b/stubs/error-printf.c
index 1f9d3b3714..a2f61521a1 100644
--- a/stubs/error-printf.c
+++ b/stubs/error-printf.c
@@ -1,5 +1,4 @@
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "qemu/error-report.h"
=20
 int error_vprintf(const char *fmt, va_list ap)
diff --git a/stubs/fd-register.c b/stubs/fd-register.c
index f91aa34185..63a4abdb20 100644
--- a/stubs/fd-register.c
+++ b/stubs/fd-register.c
@@ -1,5 +1,4 @@
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "qemu/main-loop.h"
=20
 void qemu_fd_register(int fd)
diff --git a/stubs/fdset.c b/stubs/fdset.c
index 4f3edf2ea4..f3d9980b7e 100644
--- a/stubs/fdset.c
+++ b/stubs/fdset.c
@@ -1,5 +1,4 @@
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "monitor/monitor.h"
=20
 int monitor_fdset_dup_fd_add(int64_t fdset_id, int dup_fd)
diff --git a/stubs/iothread-lock.c b/stubs/iothread-lock.c
index eb745d7d6a..2a6efad64a 100644
--- a/stubs/iothread-lock.c
+++ b/stubs/iothread-lock.c
@@ -1,5 +1,4 @@
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "qemu/main-loop.h"
=20
 bool qemu_mutex_iothread_locked(void)
diff --git a/stubs/is-daemonized.c b/stubs/is-daemonized.c
index d5cd1dc371..8f63325bb2 100644
--- a/stubs/is-daemonized.c
+++ b/stubs/is-daemonized.c
@@ -1,5 +1,4 @@
 #include "qemu/osdep.h"
-#include "qemu-common.h"
=20
 /* Win32 has its own inline stub */
 #ifndef _WIN32
diff --git a/stubs/machine-init-done.c b/stubs/machine-init-done.c
index 4121f1709b..cd8e81392d 100644
--- a/stubs/machine-init-done.c
+++ b/stubs/machine-init-done.c
@@ -1,5 +1,4 @@
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "sysemu/sysemu.h"
=20
 bool machine_init_done =3D true;
diff --git a/stubs/migr-blocker.c b/stubs/migr-blocker.c
index 2b64ac9560..5676a2f93c 100644
--- a/stubs/migr-blocker.c
+++ b/stubs/migr-blocker.c
@@ -1,5 +1,4 @@
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "migration/blocker.h"
=20
 int migrate_add_blocker(Error *reason, Error **errp)
diff --git a/stubs/monitor.c b/stubs/monitor.c
index b2ea975e40..cdbf5c5f9a 100644
--- a/stubs/monitor.c
+++ b/stubs/monitor.c
@@ -1,7 +1,6 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qapi/qapi-emit-events.h"
-#include "qemu-common.h"
 #include "monitor/monitor.h"
=20
 __thread Monitor *cur_mon;
diff --git a/stubs/notify-event.c b/stubs/notify-event.c
index 14e52268a8..827bb52d1a 100644
--- a/stubs/notify-event.c
+++ b/stubs/notify-event.c
@@ -1,5 +1,4 @@
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "qemu/main-loop.h"
=20
 void qemu_notify_event(void)
diff --git a/stubs/set-fd-handler.c b/stubs/set-fd-handler.c
index 26965de4c3..bff7e0a45a 100644
--- a/stubs/set-fd-handler.c
+++ b/stubs/set-fd-handler.c
@@ -1,5 +1,4 @@
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "qemu/main-loop.h"
=20
 void qemu_set_fd_handler(int fd,
diff --git a/stubs/uuid.c b/stubs/uuid.c
index a802e9836b..67f182fa3a 100644
--- a/stubs/uuid.c
+++ b/stubs/uuid.c
@@ -1,5 +1,4 @@
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "qapi/qapi-commands-misc.h"
 #include "qemu/uuid.h"
=20
diff --git a/stubs/vm-stop.c b/stubs/vm-stop.c
index 8271cad65d..68e5f20eaf 100644
--- a/stubs/vm-stop.c
+++ b/stubs/vm-stop.c
@@ -1,5 +1,4 @@
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "sysemu/sysemu.h"
=20
 void qemu_system_vmstop_request_prepare(void)
diff --git a/stubs/vmstate.c b/stubs/vmstate.c
index 6399474e49..e1e89b87f0 100644
--- a/stubs/vmstate.c
+++ b/stubs/vmstate.c
@@ -1,5 +1,4 @@
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "migration/vmstate.h"
=20
 const VMStateDescription vmstate_dummy =3D {};
diff --git a/stubs/xen-common.c b/stubs/xen-common.c
index 09fce2dd36..f5efcae362 100644
--- a/stubs/xen-common.c
+++ b/stubs/xen-common.c
@@ -6,7 +6,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "hw/xen/xen.h"
=20
 void xenstore_store_pv_console_info(int i, Chardev *chr)
diff --git a/stubs/xen-hvm.c b/stubs/xen-hvm.c
index 0067bcc6db..b7d53b5e2f 100644
--- a/stubs/xen-hvm.c
+++ b/stubs/xen-hvm.c
@@ -9,7 +9,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "hw/xen/xen.h"
 #include "exec/memory.h"
 #include "qapi/qapi-commands-misc.h"
diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
index 7c81be4111..5570bc88c7 100644
--- a/target/alpha/cpu.c
+++ b/target/alpha/cpu.c
@@ -23,7 +23,6 @@
 #include "qapi/error.h"
 #include "qemu/qemu-print.h"
 #include "cpu.h"
-#include "qemu-common.h"
 #include "exec/exec-all.h"
=20
=20
diff --git a/target/alpha/cpu.h b/target/alpha/cpu.h
index ba6bc31b15..7f07bafddd 100644
--- a/target/alpha/cpu.h
+++ b/target/alpha/cpu.h
@@ -20,7 +20,6 @@
 #ifndef ALPHA_CPU_H
 #define ALPHA_CPU_H
=20
-#include "qemu-common.h"
 #include "cpu-qom.h"
=20
 #define TARGET_LONG_BITS 64
diff --git a/target/alpha/gdbstub.c b/target/alpha/gdbstub.c
index d64bcccfa0..7f9cc092a9 100644
--- a/target/alpha/gdbstub.c
+++ b/target/alpha/gdbstub.c
@@ -18,7 +18,6 @@
  * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
  */
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "cpu.h"
 #include "exec/gdbstub.h"
=20
diff --git a/target/alpha/machine.c b/target/alpha/machine.c
index abc81cef7b..fdab596438 100644
--- a/target/alpha/machine.c
+++ b/target/alpha/machine.c
@@ -1,5 +1,4 @@
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "cpu.h"
 #include "hw/hw.h"
 #include "hw/boards.h"
diff --git a/target/arm/arm-semi.c b/target/arm/arm-semi.c
index 53e807ab72..e7b0c8e7fb 100644
--- a/target/arm/arm-semi.c
+++ b/target/arm/arm-semi.c
@@ -34,7 +34,6 @@
=20
 #define ARM_ANGEL_HEAP_SIZE (128 * 1024 * 1024)
 #else
-#include "qemu-common.h"
 #include "exec/gdbstub.h"
 #include "qemu/cutils.h"
 #endif
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index cf21f0bdc6..4764293609 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -19,6 +19,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu-common.h"
 #include "target/arm/idau.h"
 #include "qemu/module.h"
 #include "qapi/error.h"
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index c34207611b..957c3e0c4d 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -35,7 +35,6 @@
=20
 #define CPUArchState struct CPUARMState
=20
-#include "qemu-common.h"
 #include "cpu-qom.h"
 #include "exec/cpu-defs.h"
=20
diff --git a/target/arm/gdbstub.c b/target/arm/gdbstub.c
index 0c64c0292e..1239abd984 100644
--- a/target/arm/gdbstub.c
+++ b/target/arm/gdbstub.c
@@ -18,7 +18,6 @@
  * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
  */
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "cpu.h"
 #include "exec/gdbstub.h"
=20
diff --git a/target/arm/gdbstub64.c b/target/arm/gdbstub64.c
index 49bc3fc521..665ebb3ef6 100644
--- a/target/arm/gdbstub64.c
+++ b/target/arm/gdbstub64.c
@@ -17,7 +17,6 @@
  * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
  */
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "cpu.h"
 #include "exec/gdbstub.h"
=20
diff --git a/target/arm/kvm-stub.c b/target/arm/kvm-stub.c
index b2c66df532..56a7099e6b 100644
--- a/target/arm/kvm-stub.c
+++ b/target/arm/kvm-stub.c
@@ -10,7 +10,6 @@
  *
  */
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "cpu.h"
 #include "kvm_arm.h"
=20
diff --git a/target/arm/machine.c b/target/arm/machine.c
index 96d032f2a7..3fd319a309 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -1,5 +1,4 @@
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "cpu.h"
 #include "hw/hw.h"
 #include "hw/boards.h"
diff --git a/target/cris/cpu.c b/target/cris/cpu.c
index 4e5288ae80..c214bc2070 100644
--- a/target/cris/cpu.c
+++ b/target/cris/cpu.c
@@ -25,7 +25,6 @@
 #include "qapi/error.h"
 #include "qemu/qemu-print.h"
 #include "cpu.h"
-#include "qemu-common.h"
 #include "mmu.h"
=20
=20
diff --git a/target/cris/cpu.h b/target/cris/cpu.h
index 857de79e24..847100d94c 100644
--- a/target/cris/cpu.h
+++ b/target/cris/cpu.h
@@ -21,7 +21,6 @@
 #ifndef CRIS_CPU_H
 #define CRIS_CPU_H
=20
-#include "qemu-common.h"
 #include "cpu-qom.h"
=20
 #define TARGET_LONG_BITS 32
diff --git a/target/cris/gdbstub.c b/target/cris/gdbstub.c
index 3a72ee2a98..a3d76d2e8c 100644
--- a/target/cris/gdbstub.c
+++ b/target/cris/gdbstub.c
@@ -18,7 +18,6 @@
  * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
  */
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "cpu.h"
 #include "exec/gdbstub.h"
=20
diff --git a/target/cris/machine.c b/target/cris/machine.c
index 6b797e8c1d..ecec41c2c8 100644
--- a/target/cris/machine.c
+++ b/target/cris/machine.c
@@ -19,7 +19,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "cpu.h"
 #include "hw/hw.h"
 #include "migration/cpu.h"
diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index c1e0215e66..dcc55a71ed 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -20,7 +20,6 @@
 #ifndef HPPA_CPU_H
 #define HPPA_CPU_H
=20
-#include "qemu-common.h"
 #include "cpu-qom.h"
=20
 #ifdef TARGET_HPPA64
diff --git a/target/hppa/gdbstub.c b/target/hppa/gdbstub.c
index 983bf92aaf..341888a9da 100644
--- a/target/hppa/gdbstub.c
+++ b/target/hppa/gdbstub.c
@@ -18,7 +18,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "cpu.h"
 #include "exec/gdbstub.h"
=20
diff --git a/target/hppa/machine.c b/target/hppa/machine.c
index a1bee9796f..73e8121bde 100644
--- a/target/hppa/machine.c
+++ b/target/hppa/machine.c
@@ -18,7 +18,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "cpu.h"
 #include "hw/hw.h"
 #include "hw/boards.h"
diff --git a/target/i386/gdbstub.c b/target/i386/gdbstub.c
index 1221433bc7..aef25b70f1 100644
--- a/target/i386/gdbstub.c
+++ b/target/i386/gdbstub.c
@@ -18,7 +18,6 @@
  * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
  */
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "cpu.h"
 #include "exec/gdbstub.h"
=20
diff --git a/target/i386/kvm-stub.c b/target/i386/kvm-stub.c
index e7a673e5db..872ef7df4c 100644
--- a/target/i386/kvm-stub.c
+++ b/target/i386/kvm-stub.c
@@ -10,7 +10,6 @@
  *
  */
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "cpu.h"
 #include "kvm_i386.h"
=20
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 3b29ce5c0d..6899061b4e 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -20,7 +20,6 @@
 #include <linux/kvm.h>
 #include "standard-headers/asm-x86/kvm_para.h"
=20
-#include "qemu-common.h"
 #include "cpu.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/hw_accel.h"
diff --git a/target/i386/sev-stub.c b/target/i386/sev-stub.c
index 59a003a4eb..e5ee13309c 100644
--- a/target/i386/sev-stub.c
+++ b/target/i386/sev-stub.c
@@ -12,7 +12,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "sev_i386.h"
=20
 SevInfo *sev_get_info(void)
diff --git a/target/i386/xsave_helper.c b/target/i386/xsave_helper.c
index 52ea7e654b..818115e7d2 100644
--- a/target/i386/xsave_helper.c
+++ b/target/i386/xsave_helper.c
@@ -4,7 +4,6 @@
  */
 #include "qemu/osdep.h"
=20
-#include "qemu-common.h"
 #include "cpu.h"
=20
 void x86_cpu_xsave_all_areas(X86CPU *cpu, X86XSaveArea *buf)
diff --git a/target/lm32/cpu.c b/target/lm32/cpu.c
index 57c50c1578..b0ead0d69a 100644
--- a/target/lm32/cpu.c
+++ b/target/lm32/cpu.c
@@ -22,7 +22,6 @@
 #include "qapi/error.h"
 #include "qemu/qemu-print.h"
 #include "cpu.h"
-#include "qemu-common.h"
=20
=20
 static void lm32_cpu_set_pc(CPUState *cs, vaddr value)
diff --git a/target/lm32/cpu.h b/target/lm32/cpu.h
index d224d4426e..8561bbad76 100644
--- a/target/lm32/cpu.h
+++ b/target/lm32/cpu.h
@@ -24,7 +24,6 @@
=20
 #define CPUArchState struct CPULM32State
=20
-#include "qemu-common.h"
 #include "cpu-qom.h"
 #include "exec/cpu-defs.h"
 struct CPULM32State;
diff --git a/target/lm32/gdbstub.c b/target/lm32/gdbstub.c
index cf929dd392..82ede436e1 100644
--- a/target/lm32/gdbstub.c
+++ b/target/lm32/gdbstub.c
@@ -18,7 +18,6 @@
  * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
  */
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "cpu.h"
 #include "exec/gdbstub.h"
 #include "hw/lm32/lm32_pic.h"
diff --git a/target/lm32/machine.c b/target/lm32/machine.c
index 3c258a4bcc..cc46f77324 100644
--- a/target/lm32/machine.c
+++ b/target/lm32/machine.c
@@ -1,5 +1,4 @@
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "cpu.h"
 #include "hw/hw.h"
 #include "hw/boards.h"
diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index b16957934a..91bb30c17a 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -21,7 +21,6 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "cpu.h"
-#include "qemu-common.h"
 #include "migration/vmstate.h"
 #include "fpu/softfloat.h"
=20
diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index 9deff9e234..98aaf8c5ad 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -25,7 +25,6 @@
=20
 #define CPUArchState struct CPUM68KState
=20
-#include "qemu-common.h"
 #include "exec/cpu-defs.h"
 #include "cpu-qom.h"
=20
diff --git a/target/m68k/gdbstub.c b/target/m68k/gdbstub.c
index fd2bb46c42..e6baf0601e 100644
--- a/target/m68k/gdbstub.c
+++ b/target/m68k/gdbstub.c
@@ -18,7 +18,6 @@
  * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
  */
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "cpu.h"
 #include "exec/gdbstub.h"
=20
diff --git a/target/m68k/m68k-semi.c b/target/m68k/m68k-semi.c
index 1402145c8f..2b7c4f3c79 100644
--- a/target/m68k/m68k-semi.c
+++ b/target/m68k/m68k-semi.c
@@ -24,7 +24,6 @@
 #include "qemu.h"
 #define SEMIHOSTING_HEAP_SIZE (128 * 1024 * 1024)
 #else
-#include "qemu-common.h"
 #include "exec/gdbstub.h"
 #include "exec/softmmu-semi.h"
 #endif
diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index 7a9fb8f4aa..113e421e50 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -20,7 +20,6 @@
 #ifndef MICROBLAZE_CPU_H
 #define MICROBLAZE_CPU_H
=20
-#include "qemu-common.h"
 #include "cpu-qom.h"
=20
 #define TARGET_LONG_BITS 64
diff --git a/target/microblaze/gdbstub.c b/target/microblaze/gdbstub.c
index 7fb076c2e9..30677b6d1f 100644
--- a/target/microblaze/gdbstub.c
+++ b/target/microblaze/gdbstub.c
@@ -18,7 +18,6 @@
  * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
  */
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "cpu.h"
 #include "exec/gdbstub.h"
=20
diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 06a8ed4748..0fc22cf546 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -5,7 +5,6 @@
=20
 #define CPUArchState struct CPUMIPSState
=20
-#include "qemu-common.h"
 #include "cpu-qom.h"
 #include "mips-defs.h"
 #include "exec/cpu-defs.h"
diff --git a/target/mips/gdbstub.c b/target/mips/gdbstub.c
index 18e0e6dce4..ebcc98bdde 100644
--- a/target/mips/gdbstub.c
+++ b/target/mips/gdbstub.c
@@ -18,7 +18,6 @@
  * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
  */
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "cpu.h"
 #include "internal.h"
 #include "exec/gdbstub.h"
diff --git a/target/mips/machine.c b/target/mips/machine.c
index 70d277db51..eb2d97001d 100644
--- a/target/mips/machine.c
+++ b/target/mips/machine.c
@@ -1,5 +1,4 @@
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "cpu.h"
 #include "internal.h"
 #include "hw/hw.h"
diff --git a/target/moxie/cpu.c b/target/moxie/cpu.c
index 02b2b47574..a0fa23c549 100644
--- a/target/moxie/cpu.c
+++ b/target/moxie/cpu.c
@@ -20,7 +20,6 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "cpu.h"
-#include "qemu-common.h"
 #include "migration/vmstate.h"
 #include "machine.h"
=20
diff --git a/target/moxie/cpu.h b/target/moxie/cpu.h
index a63a96bc05..a258bc488b 100644
--- a/target/moxie/cpu.h
+++ b/target/moxie/cpu.h
@@ -20,7 +20,6 @@
 #ifndef MOXIE_CPU_H
 #define MOXIE_CPU_H
=20
-#include "qemu-common.h"
=20
 #define TARGET_LONG_BITS 32
=20
diff --git a/target/moxie/machine.c b/target/moxie/machine.c
index 282dcd869f..322a724e6f 100644
--- a/target/moxie/machine.c
+++ b/target/moxie/machine.c
@@ -1,5 +1,4 @@
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "cpu.h"
 #include "hw/hw.h"
 #include "hw/boards.h"
diff --git a/target/nios2/cpu.h b/target/nios2/cpu.h
index 35d3886dc2..f5d0b9d231 100644
--- a/target/nios2/cpu.h
+++ b/target/nios2/cpu.h
@@ -21,7 +21,6 @@
 #ifndef NIOS2_CPU_H
 #define NIOS2_CPU_H
=20
-#include "qemu-common.h"
=20
 #define TARGET_LONG_BITS 32
=20
diff --git a/target/nios2/mmu.c b/target/nios2/mmu.c
index 47fa474efb..72a47065b6 100644
--- a/target/nios2/mmu.c
+++ b/target/nios2/mmu.c
@@ -19,7 +19,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "qemu/qemu-print.h"
 #include "cpu.h"
 #include "exec/exec-all.h"
diff --git a/target/openrisc/cpu.c b/target/openrisc/cpu.c
index 3816baee70..8d43687e7c 100644
--- a/target/openrisc/cpu.c
+++ b/target/openrisc/cpu.c
@@ -21,7 +21,6 @@
 #include "qapi/error.h"
 #include "qemu/qemu-print.h"
 #include "cpu.h"
-#include "qemu-common.h"
=20
 static void openrisc_cpu_set_pc(CPUState *cs, vaddr value)
 {
diff --git a/target/openrisc/cpu.h b/target/openrisc/cpu.h
index 9473d94d0c..950e0e1449 100644
--- a/target/openrisc/cpu.h
+++ b/target/openrisc/cpu.h
@@ -27,7 +27,6 @@
 /* cpu_openrisc_map_address_* in CPUOpenRISCTLBContext need this decl.  =
*/
 struct OpenRISCCPU;
=20
-#include "qemu-common.h"
 #include "exec/cpu-defs.h"
 #include "qom/cpu.h"
=20
diff --git a/target/openrisc/disas.c b/target/openrisc/disas.c
index 5923b2429e..7091832347 100644
--- a/target/openrisc/disas.c
+++ b/target/openrisc/disas.c
@@ -18,7 +18,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "disas/dis-asm.h"
 #include "qemu/bitops.h"
 #include "cpu.h"
diff --git a/target/openrisc/exception.h b/target/openrisc/exception.h
index c9c4e471d2..333bf84638 100644
--- a/target/openrisc/exception.h
+++ b/target/openrisc/exception.h
@@ -21,7 +21,6 @@
 #define TARGET_OPENRISC_EXCEPTION_H
=20
 #include "cpu.h"
-#include "qemu-common.h"
=20
 void QEMU_NORETURN raise_exception(OpenRISCCPU *cpu, uint32_t excp);
=20
diff --git a/target/openrisc/gdbstub.c b/target/openrisc/gdbstub.c
index 43b1a18d4b..0fcdb79668 100644
--- a/target/openrisc/gdbstub.c
+++ b/target/openrisc/gdbstub.c
@@ -18,7 +18,6 @@
  * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
  */
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "cpu.h"
 #include "exec/gdbstub.h"
=20
diff --git a/target/openrisc/interrupt.c b/target/openrisc/interrupt.c
index ee280df895..3eab771dcd 100644
--- a/target/openrisc/interrupt.c
+++ b/target/openrisc/interrupt.c
@@ -20,7 +20,6 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "exec/exec-all.h"
-#include "qemu-common.h"
 #include "exec/gdbstub.h"
 #include "qemu/host-utils.h"
 #ifndef CONFIG_USER_ONLY
diff --git a/target/openrisc/machine.c b/target/openrisc/machine.c
index c9e084814c..9fa285217d 100644
--- a/target/openrisc/machine.c
+++ b/target/openrisc/machine.c
@@ -18,7 +18,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "cpu.h"
 #include "hw/hw.h"
 #include "hw/boards.h"
diff --git a/target/openrisc/mmu.c b/target/openrisc/mmu.c
index a73b12af03..94df8c7bef 100644
--- a/target/openrisc/mmu.c
+++ b/target/openrisc/mmu.c
@@ -21,7 +21,6 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "exec/exec-all.h"
-#include "qemu-common.h"
 #include "exec/gdbstub.h"
 #include "qemu/host-utils.h"
 #ifndef CONFIG_USER_ONLY
diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index 36821948c0..4360ce4045 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -23,7 +23,6 @@
 #include "exec/exec-all.h"
 #include "disas/disas.h"
 #include "tcg-op.h"
-#include "qemu-common.h"
 #include "qemu/log.h"
 #include "qemu/bitops.h"
 #include "qemu/qemu-print.h"
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index d7f23ad5e0..0815b10a6c 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -20,7 +20,6 @@
 #ifndef PPC_CPU_H
 #define PPC_CPU_H
=20
-#include "qemu-common.h"
 #include "qemu/int128.h"
=20
 /* #define PPC_EMULATE_32BITS_HYPV */
diff --git a/target/ppc/gdbstub.c b/target/ppc/gdbstub.c
index ce3625f44e..823759c92e 100644
--- a/target/ppc/gdbstub.c
+++ b/target/ppc/gdbstub.c
@@ -18,7 +18,6 @@
  * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
  */
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "cpu.h"
 #include "exec/gdbstub.h"
=20
diff --git a/target/ppc/kvm-stub.c b/target/ppc/kvm-stub.c
index b8aa97f2d4..b98e1d404f 100644
--- a/target/ppc/kvm-stub.c
+++ b/target/ppc/kvm-stub.c
@@ -10,7 +10,6 @@
  *
  */
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "cpu.h"
 #include "hw/ppc/openpic_kvm.h"
=20
diff --git a/target/ppc/machine.c b/target/ppc/machine.c
index 25cdb9088b..5ad7b40f45 100644
--- a/target/ppc/machine.c
+++ b/target/ppc/machine.c
@@ -1,5 +1,4 @@
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "cpu.h"
 #include "exec/exec-all.h"
 #include "hw/hw.h"
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 74e726c1c9..ebec36811b 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -36,7 +36,6 @@
=20
 #define CPUArchState struct CPURISCVState
=20
-#include "qemu-common.h"
 #include "qom/cpu.h"
 #include "exec/cpu-defs.h"
 #include "fpu/softfloat.h"
diff --git a/target/riscv/gdbstub.c b/target/riscv/gdbstub.c
index dfcdd834cf..27be93279b 100644
--- a/target/riscv/gdbstub.c
+++ b/target/riscv/gdbstub.c
@@ -17,7 +17,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "exec/gdbstub.h"
 #include "cpu.h"
=20
diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
index b11c4ae22f..fed1c3c030 100644
--- a/target/riscv/pmp.c
+++ b/target/riscv/pmp.c
@@ -27,7 +27,6 @@
 #include "qemu/log.h"
 #include "qapi/error.h"
 #include "cpu.h"
-#include "qemu-common.h"
=20
 #ifndef CONFIG_USER_ONLY
=20
diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 7305cacc7b..fca6d87dfb 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -21,7 +21,6 @@
 #ifndef S390X_CPU_H
 #define S390X_CPU_H
=20
-#include "qemu-common.h"
 #include "cpu-qom.h"
 #include "cpu_models.h"
=20
diff --git a/target/s390x/kvm-stub.c b/target/s390x/kvm-stub.c
index 22b4514ca6..5152e2bdf1 100644
--- a/target/s390x/kvm-stub.c
+++ b/target/s390x/kvm-stub.c
@@ -8,7 +8,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "cpu.h"
 #include "kvm_s390x.h"
=20
diff --git a/target/s390x/vec_helper.c b/target/s390x/vec_helper.c
index bb4c9304f0..986e7cc825 100644
--- a/target/s390x/vec_helper.c
+++ b/target/s390x/vec_helper.c
@@ -10,7 +10,6 @@
  * See the COPYING file in the top-level directory.
  */
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "cpu.h"
 #include "internal.h"
 #include "vec.h"
diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
index c4736a0a73..13e48f7099 100644
--- a/target/sh4/cpu.c
+++ b/target/sh4/cpu.c
@@ -23,7 +23,6 @@
 #include "qapi/error.h"
 #include "qemu/qemu-print.h"
 #include "cpu.h"
-#include "qemu-common.h"
 #include "migration/vmstate.h"
 #include "exec/exec-all.h"
 #include "fpu/softfloat.h"
diff --git a/target/sh4/cpu.h b/target/sh4/cpu.h
index 547194aac7..111a5feb62 100644
--- a/target/sh4/cpu.h
+++ b/target/sh4/cpu.h
@@ -20,7 +20,6 @@
 #ifndef SH4_CPU_H
 #define SH4_CPU_H
=20
-#include "qemu-common.h"
 #include "cpu-qom.h"
=20
 #define TARGET_LONG_BITS 32
diff --git a/target/sh4/gdbstub.c b/target/sh4/gdbstub.c
index 54568e96f9..44c1679e9d 100644
--- a/target/sh4/gdbstub.c
+++ b/target/sh4/gdbstub.c
@@ -18,7 +18,6 @@
  * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
  */
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "cpu.h"
 #include "exec/gdbstub.h"
=20
diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index f31e8535df..7dab07822a 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -1,7 +1,6 @@
 #ifndef SPARC_CPU_H
 #define SPARC_CPU_H
=20
-#include "qemu-common.h"
 #include "qemu/bswap.h"
 #include "cpu-qom.h"
=20
diff --git a/target/sparc/gdbstub.c b/target/sparc/gdbstub.c
index ffc2baa2e7..8be742b5a3 100644
--- a/target/sparc/gdbstub.c
+++ b/target/sparc/gdbstub.c
@@ -18,7 +18,6 @@
  * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
  */
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "cpu.h"
 #include "exec/gdbstub.h"
=20
diff --git a/target/sparc/machine.c b/target/sparc/machine.c
index 7791c84963..32d453c008 100644
--- a/target/sparc/machine.c
+++ b/target/sparc/machine.c
@@ -1,5 +1,4 @@
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "cpu.h"
 #include "exec/exec-all.h"
 #include "hw/hw.h"
diff --git a/target/tilegx/cpu.h b/target/tilegx/cpu.h
index 238f8d36d7..ffd5803c4c 100644
--- a/target/tilegx/cpu.h
+++ b/target/tilegx/cpu.h
@@ -20,7 +20,6 @@
 #ifndef TILEGX_CPU_H
 #define TILEGX_CPU_H
=20
-#include "qemu-common.h"
=20
 #define TARGET_LONG_BITS 64
=20
diff --git a/target/tilegx/helper.c b/target/tilegx/helper.c
index 4964bb9111..8de5acc037 100644
--- a/target/tilegx/helper.c
+++ b/target/tilegx/helper.c
@@ -21,7 +21,6 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "exec/exec-all.h"
-#include "qemu-common.h"
 #include "exec/helper-proto.h"
 #include <zlib.h> /* For crc32 */
 #include "syscall_defs.h"
diff --git a/target/tilegx/simd_helper.c b/target/tilegx/simd_helper.c
index 2d40ddb63e..0fdfad2fa9 100644
--- a/target/tilegx/simd_helper.c
+++ b/target/tilegx/simd_helper.c
@@ -20,7 +20,6 @@
=20
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "qemu-common.h"
 #include "exec/helper-proto.h"
=20
=20
diff --git a/target/tricore/cpu.c b/target/tricore/cpu.c
index ea1199d27e..c9502552cf 100644
--- a/target/tricore/cpu.c
+++ b/target/tricore/cpu.c
@@ -20,7 +20,6 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "cpu.h"
-#include "qemu-common.h"
 #include "exec/exec-all.h"
 #include "qemu/error-report.h"
=20
diff --git a/target/tricore/cpu.h b/target/tricore/cpu.h
index 287f4328a3..1723f09bb2 100644
--- a/target/tricore/cpu.h
+++ b/target/tricore/cpu.h
@@ -21,7 +21,6 @@
 #define TRICORE_CPU_H
=20
 #include "tricore-defs.h"
-#include "qemu-common.h"
 #include "cpu-qom.h"
 #include "exec/cpu-defs.h"
=20
diff --git a/target/unicore32/cpu.c b/target/unicore32/cpu.c
index 3f57c508a0..2c16d57ce9 100644
--- a/target/unicore32/cpu.c
+++ b/target/unicore32/cpu.c
@@ -15,7 +15,6 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "cpu.h"
-#include "qemu-common.h"
 #include "migration/vmstate.h"
 #include "exec/exec-all.h"
 #include "fpu/softfloat.h"
diff --git a/target/unicore32/cpu.h b/target/unicore32/cpu.h
index f052ee08bf..a8cf8498da 100644
--- a/target/unicore32/cpu.h
+++ b/target/unicore32/cpu.h
@@ -20,7 +20,6 @@
=20
 #define CPUArchState                struct CPUUniCore32State
=20
-#include "qemu-common.h"
 #include "cpu-qom.h"
 #include "exec/cpu-defs.h"
=20
diff --git a/target/xtensa/core-dc233c.c b/target/xtensa/core-dc233c.c
index 8853bfd4d0..f8204f7045 100644
--- a/target/xtensa/core-dc233c.c
+++ b/target/xtensa/core-dc233c.c
@@ -28,7 +28,6 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "exec/gdbstub.h"
-#include "qemu-common.h"
 #include "qemu/host-utils.h"
=20
 #include "core-dc233c/core-isa.h"
diff --git a/target/xtensa/core-de212.c b/target/xtensa/core-de212.c
index 7322179b56..a061158f6e 100644
--- a/target/xtensa/core-de212.c
+++ b/target/xtensa/core-de212.c
@@ -28,7 +28,6 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "exec/gdbstub.h"
-#include "qemu-common.h"
 #include "qemu/host-utils.h"
=20
 #include "core-de212/core-isa.h"
diff --git a/target/xtensa/core-fsf.c b/target/xtensa/core-fsf.c
index e100e212b9..1221a296fa 100644
--- a/target/xtensa/core-fsf.c
+++ b/target/xtensa/core-fsf.c
@@ -28,7 +28,6 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "exec/gdbstub.h"
-#include "qemu-common.h"
 #include "qemu/host-utils.h"
=20
 #include "core-fsf/core-isa.h"
diff --git a/target/xtensa/core-sample_controller.c b/target/xtensa/core-=
sample_controller.c
index f433ea8d66..a1d220bb9a 100644
--- a/target/xtensa/core-sample_controller.c
+++ b/target/xtensa/core-sample_controller.c
@@ -28,7 +28,6 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "exec/gdbstub.h"
-#include "qemu-common.h"
 #include "qemu/host-utils.h"
=20
 #include "core-sample_controller/core-isa.h"
diff --git a/target/xtensa/core-test_kc705_be.c b/target/xtensa/core-test=
_kc705_be.c
index 6fc20f3cdd..ab73c3885f 100644
--- a/target/xtensa/core-test_kc705_be.c
+++ b/target/xtensa/core-test_kc705_be.c
@@ -28,7 +28,6 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "exec/gdbstub.h"
-#include "qemu-common.h"
 #include "qemu/host-utils.h"
=20
 #include "core-test_kc705_be/core-isa.h"
diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index a0df46f73b..701de7de8a 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -36,7 +36,6 @@
=20
 #define CPUArchState struct CPUXtensaState
=20
-#include "qemu-common.h"
 #include "cpu-qom.h"
 #include "exec/cpu-defs.h"
 #include "xtensa-isa.h"
diff --git a/target/xtensa/gdbstub.c b/target/xtensa/gdbstub.c
index d43bb190c6..54727881f3 100644
--- a/target/xtensa/gdbstub.c
+++ b/target/xtensa/gdbstub.c
@@ -18,7 +18,6 @@
  * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
  */
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "cpu.h"
 #include "exec/gdbstub.h"
 #include "qemu/log.h"
diff --git a/tcg/optimize.c b/tcg/optimize.c
index 24faa06260..d7c71a6085 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -24,7 +24,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "exec/cpu-common.h"
 #include "tcg-op.h"
=20
diff --git a/tcg/tcg-common.c b/tcg/tcg-common.c
index 2f139de802..907d58d0f0 100644
--- a/tcg/tcg-common.c
+++ b/tcg/tcg-common.c
@@ -23,7 +23,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "exec/cpu-common.h"
 #include "tcg/tcg.h"
=20
diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
index f18464cf07..17679b6e2f 100644
--- a/tcg/tcg-op-gvec.c
+++ b/tcg/tcg-op-gvec.c
@@ -18,7 +18,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "tcg.h"
 #include "tcg-op.h"
 #include "tcg-op-gvec.h"
diff --git a/tcg/tcg-op-vec.c b/tcg/tcg-op-vec.c
index 501d9630a2..c8fdc24f56 100644
--- a/tcg/tcg-op-vec.c
+++ b/tcg/tcg-op-vec.c
@@ -18,7 +18,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "cpu.h"
 #include "tcg.h"
 #include "tcg-op.h"
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 0ac291f1c4..587d092238 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -23,7 +23,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "cpu.h"
 #include "exec/exec-all.h"
 #include "tcg.h"
diff --git a/tcg/tcg.h b/tcg/tcg.h
index 21cd6f1249..b411e17a28 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -25,7 +25,6 @@
 #ifndef TCG_H
 #define TCG_H
=20
-#include "qemu-common.h"
 #include "cpu.h"
 #include "exec/tb-context.h"
 #include "qemu/bitops.h"
diff --git a/tests/crypto-tls-psk-helpers.h b/tests/crypto-tls-psk-helper=
s.h
index 9aec29f1a0..7cc81dc1b7 100644
--- a/tests/crypto-tls-psk-helpers.h
+++ b/tests/crypto-tls-psk-helpers.h
@@ -21,7 +21,6 @@
 #include <gnutls/gnutls.h>
=20
 #ifdef QCRYPTO_HAVE_TLS_TEST_SUPPORT
-# include "qemu-common.h"
=20
 void test_tls_psk_init(const char *keyfile);
 void test_tls_psk_cleanup(const char *keyfile);
diff --git a/tests/crypto-tls-x509-helpers.h b/tests/crypto-tls-x509-help=
ers.h
index 88c30d7c94..0690c618e2 100644
--- a/tests/crypto-tls-x509-helpers.h
+++ b/tests/crypto-tls-x509-helpers.h
@@ -29,7 +29,6 @@
 #ifdef QCRYPTO_HAVE_TLS_TEST_SUPPORT
 # include <libtasn1.h>
=20
-# include "qemu-common.h"
=20
 /*
  * This contains parameter about how to generate
diff --git a/tests/e1000e-test.c b/tests/e1000e-test.c
index 781fcbfd89..445787a7e4 100644
--- a/tests/e1000e-test.c
+++ b/tests/e1000e-test.c
@@ -25,6 +25,7 @@
=20
=20
 #include "qemu/osdep.h"
+#include "qemu-common.h"
 #include "libqtest.h"
 #include "qemu-common.h"
 #include "libqos/pci-pc.h"
diff --git a/tests/test-filter-mirror.c b/tests/test-filter-mirror.c
index d942c74a3f..1e3ced84a9 100644
--- a/tests/test-filter-mirror.c
+++ b/tests/test-filter-mirror.c
@@ -9,6 +9,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu-common.h"
 #include "libqtest.h"
 #include "qapi/qmp/qdict.h"
 #include "qemu/iov.h"
diff --git a/tests/test-filter-redirector.c b/tests/test-filter-redirecto=
r.c
index 6dc21dd4fb..e4d53220fd 100644
--- a/tests/test-filter-redirector.c
+++ b/tests/test-filter-redirector.c
@@ -51,6 +51,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu-common.h"
 #include "libqtest.h"
 #include "qapi/qmp/qdict.h"
 #include "qemu/iov.h"
diff --git a/tests/virtio-net-test.c b/tests/virtio-net-test.c
index 6a008bb552..663cf7ea7e 100644
--- a/tests/virtio-net-test.c
+++ b/tests/virtio-net-test.c
@@ -8,6 +8,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu-common.h"
 #include "libqtest.h"
 #include "qemu/iov.h"
 #include "qemu/module.h"
diff --git a/trace/control.h b/trace/control.h
index 0716f90f45..570492d6e8 100644
--- a/trace/control.h
+++ b/trace/control.h
@@ -10,7 +10,6 @@
 #ifndef TRACE__CONTROL_H
 #define TRACE__CONTROL_H
=20
-#include "qemu-common.h"
 #include "event-internal.h"
=20
 typedef struct TraceEventIter {
diff --git a/ui/console-gl.c b/ui/console-gl.c
index c1cb3bd673..0a6478161f 100644
--- a/ui/console-gl.c
+++ b/ui/console-gl.c
@@ -25,7 +25,6 @@
  * THE SOFTWARE.
  */
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "ui/console.h"
 #include "ui/shader.h"
=20
diff --git a/ui/cursor.c b/ui/cursor.c
index 26ce69fe5e..1d62ddd4d0 100644
--- a/ui/cursor.c
+++ b/ui/cursor.c
@@ -1,5 +1,4 @@
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "ui/console.h"
=20
 #include "cursor_hidden.xpm"
diff --git a/ui/egl-context.c b/ui/egl-context.c
index 78e6c7ab7c..4aa1cbb50c 100644
--- a/ui/egl-context.c
+++ b/ui/egl-context.c
@@ -1,5 +1,4 @@
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "ui/egl-context.h"
=20
 QEMUGLContext qemu_egl_create_context(DisplayChangeListener *dcl,
diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
index 42801b688b..99231a3597 100644
--- a/ui/gtk-egl.c
+++ b/ui/gtk-egl.c
@@ -12,7 +12,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "qemu-common.h"
=20
 #include "trace.h"
=20
diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c
index 147ad6f9b5..85f9d14c51 100644
--- a/ui/gtk-gl-area.c
+++ b/ui/gtk-gl-area.c
@@ -8,7 +8,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "qemu-common.h"
=20
 #include "trace.h"
=20
diff --git a/ui/gtk.c b/ui/gtk.c
index e96e15435a..ad6963d4f5 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -31,7 +31,6 @@
 #define LOCALEDIR "po"
=20
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-misc.h"
 #include "qemu/cutils.h"
diff --git a/ui/keymaps.c b/ui/keymaps.c
index 38fd22ed2b..6e8a321971 100644
--- a/ui/keymaps.c
+++ b/ui/keymaps.c
@@ -23,6 +23,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu-common.h"
 #include "keymaps.h"
 #include "sysemu/sysemu.h"
 #include "trace.h"
diff --git a/ui/keymaps.h b/ui/keymaps.h
index b6d48aac40..6473405485 100644
--- a/ui/keymaps.h
+++ b/ui/keymaps.h
@@ -25,7 +25,6 @@
 #ifndef QEMU_KEYMAPS_H
 #define QEMU_KEYMAPS_H
=20
-#include "qemu-common.h"
 #include "ui/kbd-state.h"
=20
 typedef struct {
diff --git a/ui/qemu-pixman.c b/ui/qemu-pixman.c
index 1429cf08d5..85f2945e88 100644
--- a/ui/qemu-pixman.c
+++ b/ui/qemu-pixman.c
@@ -4,7 +4,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "ui/console.h"
 #include "standard-headers/drm/drm_fourcc.h"
=20
diff --git a/ui/sdl2-2d.c b/ui/sdl2-2d.c
index 091ecfcc7f..db191aaa79 100644
--- a/ui/sdl2-2d.c
+++ b/ui/sdl2-2d.c
@@ -24,7 +24,6 @@
 /* Ported SDL 1.2 code to 2.0 by Dave Airlie. */
=20
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "ui/console.h"
 #include "ui/input.h"
 #include "ui/sdl2.h"
diff --git a/ui/sdl2-gl.c b/ui/sdl2-gl.c
index 1bf4542d8d..7a37e7c995 100644
--- a/ui/sdl2-gl.c
+++ b/ui/sdl2-gl.c
@@ -26,7 +26,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "ui/console.h"
 #include "ui/input.h"
 #include "ui/sdl2.h"
diff --git a/ui/sdl2-input.c b/ui/sdl2-input.c
index fb345f45fb..b1daae4111 100644
--- a/ui/sdl2-input.c
+++ b/ui/sdl2-input.c
@@ -24,7 +24,6 @@
 /* Ported SDL 1.2 code to 2.0 by Dave Airlie. */
=20
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "ui/console.h"
 #include "ui/input.h"
 #include "ui/sdl2.h"
diff --git a/ui/shader.c b/ui/shader.c
index 008458bf94..d78829f43b 100644
--- a/ui/shader.c
+++ b/ui/shader.c
@@ -25,7 +25,6 @@
  * THE SOFTWARE.
  */
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "ui/shader.h"
=20
 #include "shader/texture-blit-vert.h"
diff --git a/ui/spice-input.c b/ui/spice-input.c
index a426c03b5e..cd4bb0043f 100644
--- a/ui/spice-input.c
+++ b/ui/spice-input.c
@@ -20,7 +20,6 @@
 #include <spice.h>
 #include <spice/enums.h>
=20
-#include "qemu-common.h"
 #include "ui/qemu-spice.h"
 #include "ui/console.h"
 #include "keymaps.h"
diff --git a/ui/vnc-enc-tight.c b/ui/vnc-enc-tight.c
index d20cd1d86d..9084c2201b 100644
--- a/ui/vnc-enc-tight.c
+++ b/ui/vnc-enc-tight.c
@@ -31,7 +31,6 @@
 /* This needs to be before jpeglib.h line because of conflict with
    INT32 definitions between jmorecfg.h (included by jpeglib.h) and
    Win32 basetsd.h (included by windows.h). */
-#include "qemu-common.h"
=20
 #ifdef CONFIG_VNC_PNG
 /* The following define is needed by pngconf.h. Otherwise it won't compi=
le,
diff --git a/ui/vnc.h b/ui/vnc.h
index ee3da08f4a..2f84db3142 100644
--- a/ui/vnc.h
+++ b/ui/vnc.h
@@ -27,7 +27,6 @@
 #ifndef QEMU_VNC_H
 #define QEMU_VNC_H
=20
-#include "qemu-common.h"
 #include "qapi/qapi-types-ui.h"
 #include "qemu/queue.h"
 #include "qemu/thread.h"
diff --git a/util/aio-posix.c b/util/aio-posix.c
index db11021287..a4977f538e 100644
--- a/util/aio-posix.c
+++ b/util/aio-posix.c
@@ -14,7 +14,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "block/block.h"
 #include "qemu/rcu_queue.h"
 #include "qemu/sockets.h"
diff --git a/util/async.c b/util/async.c
index c10642a385..8d2105729c 100644
--- a/util/async.c
+++ b/util/async.c
@@ -25,7 +25,6 @@
=20
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qemu-common.h"
 #include "block/aio.h"
 #include "block/thread-pool.h"
 #include "qemu/main-loop.h"
diff --git a/util/bufferiszero.c b/util/bufferiszero.c
index 2178d8ab9d..bfb2605466 100644
--- a/util/bufferiszero.c
+++ b/util/bufferiszero.c
@@ -22,7 +22,6 @@
  * THE SOFTWARE.
  */
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "qemu/cutils.h"
 #include "qemu/bswap.h"
=20
diff --git a/util/compatfd.c b/util/compatfd.c
index 980bd33e52..c296f55d14 100644
--- a/util/compatfd.c
+++ b/util/compatfd.c
@@ -14,7 +14,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "qemu/thread.h"
=20
 #include <sys/syscall.h>
diff --git a/util/coroutine-ucontext.c b/util/coroutine-ucontext.c
index 090ba21a13..bd593e61bc 100644
--- a/util/coroutine-ucontext.c
+++ b/util/coroutine-ucontext.c
@@ -24,7 +24,6 @@
 #endif
 #include "qemu/osdep.h"
 #include <ucontext.h>
-#include "qemu-common.h"
 #include "qemu/coroutine_int.h"
=20
 #ifdef CONFIG_VALGRIND_H
diff --git a/util/crc32c.c b/util/crc32c.c
index 7e99555c16..762657d853 100644
--- a/util/crc32c.c
+++ b/util/crc32c.c
@@ -26,7 +26,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "qemu/crc32c.h"
=20
 /*
diff --git a/util/cutils.c b/util/cutils.c
index 53e4af59f8..dfc605f1ef 100644
--- a/util/cutils.c
+++ b/util/cutils.c
@@ -26,6 +26,7 @@
 #include "qemu/host-utils.h"
 #include <math.h>
=20
+#include "qemu-common.h"
 #include "qemu/sockets.h"
 #include "qemu/iov.h"
 #include "net/net.h"
diff --git a/util/envlist.c b/util/envlist.c
index 1eeb7fca87..2bcc13f094 100644
--- a/util/envlist.c
+++ b/util/envlist.c
@@ -1,5 +1,4 @@
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "qemu/queue.h"
 #include "qemu/envlist.h"
=20
diff --git a/util/error.c b/util/error.c
index ea6d1a3d7e..d4532ce318 100644
--- a/util/error.c
+++ b/util/error.c
@@ -14,7 +14,6 @@
=20
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qemu-common.h"
 #include "qemu/error-report.h"
=20
 struct Error
diff --git a/util/fifo8.c b/util/fifo8.c
index d38b3bdaa5..a9aa20a9f7 100644
--- a/util/fifo8.c
+++ b/util/fifo8.c
@@ -13,7 +13,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "qemu/fifo8.h"
=20
 void fifo8_create(Fifo8 *fifo, uint32_t capacity)
diff --git a/util/getauxval.c b/util/getauxval.c
index 0b3bae2dcb..36afdfb9e6 100644
--- a/util/getauxval.c
+++ b/util/getauxval.c
@@ -23,7 +23,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "qemu-common.h"
=20
 #ifdef CONFIG_GETAUXVAL
 /* Don't inline this in qemu/osdep.h, because pulling in <sys/auxv.h> fo=
r
diff --git a/util/guest-random.c b/util/guest-random.c
index 00a08fd981..9453968bd7 100644
--- a/util/guest-random.c
+++ b/util/guest-random.c
@@ -10,7 +10,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "qemu/cutils.h"
 #include "qapi/error.h"
 #include "qemu/guest-random.h"
diff --git a/util/iohandler.c b/util/iohandler.c
index 623b55b9ec..bece8825dc 100644
--- a/util/iohandler.c
+++ b/util/iohandler.c
@@ -24,7 +24,6 @@
=20
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qemu-common.h"
 #include "qemu/queue.h"
 #include "block/aio.h"
 #include "qemu/main-loop.h"
diff --git a/util/log.c b/util/log.c
index c0dbbd4700..1d1b33f7d9 100644
--- a/util/log.c
+++ b/util/log.c
@@ -18,7 +18,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "qemu/log.h"
 #include "qemu/range.h"
 #include "qemu/error-report.h"
diff --git a/util/module.c b/util/module.c
index 1259dd3686..142db7e911 100644
--- a/util/module.c
+++ b/util/module.c
@@ -14,7 +14,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #ifdef CONFIG_MODULES
 #include <gmodule.h>
 #endif
diff --git a/util/notify.c b/util/notify.c
index 06de63a839..aee8d93cb0 100644
--- a/util/notify.c
+++ b/util/notify.c
@@ -14,7 +14,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "qemu/notify.h"
=20
 void notifier_list_init(NotifierList *list)
diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index d97b1717d5..fe0309ce7a 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -31,6 +31,7 @@
=20
 #include <glib/gprintf.h>
=20
+#include "qemu-common.h"
 #include "sysemu/sysemu.h"
 #include "trace.h"
 #include "qapi/error.h"
diff --git a/util/oslib-win32.c b/util/oslib-win32.c
index bd633afab6..9583fb4ca4 100644
--- a/util/oslib-win32.c
+++ b/util/oslib-win32.c
@@ -29,8 +29,10 @@
  * this file are based on code from GNOME glib-2 and use a different lic=
ense,
  * see the license comment there.
  */
+
 #include "qemu/osdep.h"
 #include <windows.h>
+#include "qemu-common.h"
 #include "qapi/error.h"
 #include "sysemu/sysemu.h"
 #include "qemu/main-loop.h"
diff --git a/util/qemu-config.c b/util/qemu-config.c
index 9d2e278e29..772f5a219e 100644
--- a/util/qemu-config.c
+++ b/util/qemu-config.c
@@ -4,7 +4,6 @@
 #include "qapi/qapi-commands-misc.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qlist.h"
-#include "qemu-common.h"
 #include "qemu/error-report.h"
 #include "qemu/option.h"
 #include "qemu/config-file.h"
diff --git a/util/qemu-coroutine-lock.c b/util/qemu-coroutine-lock.c
index 27438a1858..5da5234155 100644
--- a/util/qemu-coroutine-lock.c
+++ b/util/qemu-coroutine-lock.c
@@ -27,7 +27,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "qemu/coroutine.h"
 #include "qemu/coroutine_int.h"
 #include "qemu/processor.h"
diff --git a/util/qemu-coroutine.c b/util/qemu-coroutine.c
index 2295928d33..c3caa6c770 100644
--- a/util/qemu-coroutine.c
+++ b/util/qemu-coroutine.c
@@ -14,7 +14,6 @@
=20
 #include "qemu/osdep.h"
 #include "trace.h"
-#include "qemu-common.h"
 #include "qemu/thread.h"
 #include "qemu/atomic.h"
 #include "qemu/coroutine.h"
diff --git a/util/qemu-option.c b/util/qemu-option.c
index ef60af70fc..97172b5eaa 100644
--- a/util/qemu-option.c
+++ b/util/qemu-option.c
@@ -26,7 +26,6 @@
 #include "qemu/osdep.h"
=20
 #include "qapi/error.h"
-#include "qemu-common.h"
 #include "qemu/error-report.h"
 #include "qapi/qmp/qbool.h"
 #include "qapi/qmp/qdict.h"
diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
index 8850a280a8..a5092dbd12 100644
--- a/util/qemu-sockets.c
+++ b/util/qemu-sockets.c
@@ -21,6 +21,7 @@
 #include <linux/vm_sockets.h>
 #endif /* CONFIG_AF_VSOCK */
=20
+#include "qemu-common.h"
 #include "monitor/monitor.h"
 #include "qapi/clone-visitor.h"
 #include "qapi/error.h"
diff --git a/util/rcu.c b/util/rcu.c
index 5676c22bd1..177a675619 100644
--- a/util/rcu.c
+++ b/util/rcu.c
@@ -27,7 +27,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "qemu/rcu.h"
 #include "qemu/atomic.h"
 #include "qemu/thread.h"
diff --git a/util/thread-pool.c b/util/thread-pool.c
index 610646d131..4ed9b89ab2 100644
--- a/util/thread-pool.c
+++ b/util/thread-pool.c
@@ -15,7 +15,6 @@
  * GNU GPL, version 2 or (at your option) any later version.
  */
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "qemu/queue.h"
 #include "qemu/thread.h"
 #include "qemu/coroutine.h"
diff --git a/util/uuid.c b/util/uuid.c
index 5787f0978c..b1108dde78 100644
--- a/util/uuid.c
+++ b/util/uuid.c
@@ -14,7 +14,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "qemu/uuid.h"
 #include "qemu/bswap.h"
=20
diff --git a/vl.c b/vl.c
index efdfea26ee..005468cbfb 100644
--- a/vl.c
+++ b/vl.c
@@ -23,6 +23,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu-common.h"
 #include "qemu/units.h"
 #include "qapi/error.h"
 #include "qemu-version.h"
diff --git a/win_dump.c b/win_dump.c
index e10a7831c2..0142655d3d 100644
--- a/win_dump.c
+++ b/win_dump.c
@@ -9,6 +9,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu-common.h"
 #include "qemu/cutils.h"
 #include "elf.h"
 #include "cpu.h"
--=20
2.21.0


