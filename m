Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32028C433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:12:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E65C0207D3
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:12:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E65C0207D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD71R-0001wO-VX
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 10:12:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54880)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kD6z2-0004hR-L8; Tue, 01 Sep 2020 10:10:00 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:48075)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kD6z0-0003gc-L1; Tue, 01 Sep 2020 10:10:00 -0400
Received: from localhost.localdomain ([82.252.135.186]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1McpW6-1kltZO2EUM-00ZwQZ; Tue, 01 Sep 2020 16:09:56 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 00/44] Trivial branch for 5.2 patches
Date: Tue,  1 Sep 2020 16:09:10 +0200
Message-Id: <20200901140954.889743-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Kce9gQmdPvY6uFiPT37pOmY0Wk28d/NmJ9RO7DlCyHuZUL69sDX
 LJE/Ljplh+IE8QRbF/bEzZkcEM9oAfqU+ce59USzgPgaDHiNtGB1RyZ30opEddmILzRphKC
 tGdxE38vcukGe7475Fdictl3q1fA+tRJEy1uugXEvf1qxZv3UDIc18gW9wmLAD0Xwe+sWVp
 JbFEC0N8m1ycepu5tFe8A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WDoc4T7zjO8=:vwd4Q/GrTAJdpsgtrJ8c7w
 a74dePNXI7JXT4ARF36oEOFC0SbZElU1IJeg9GB9IcsDWc3hFAUF65MrK3n200dgw8pC/BYFt
 kmKtWg69BzHW6v8LDKOyl5IVo0RKpvuwx4lMvg2kAy45aULsa2NZH8OPvq65hyLrko9riv5Yy
 Agzj4di/7jtl1LCdadmQZB3lyACTzSn1MhLBFt1sNBSpdy61vpe3L9tdp2RUCq2nT08b4RnlR
 05NX6EbkeU2pz/mnQ/idpq/GLkcQFycrnymac5FJcCMgFKAV3iS6h8GH0uFddn+9lAYco/E9l
 UL9/HRE87GopCrZugBuIWIy6FTOf5fIE5N13Ce1oDHSkv7uGnxfk5s0ZQrxWcA6+B18X7v/F/
 kRPJ7MmMiCKWdptHhtXVlVjDi3s14snrqzm8S+PPkSsHnlrM0TSqLMtNFeZX8loQr4mjb+0MQ
 8DyLsgmzhMETOsXcLfz7bLO+5ty5eHy67gAYNfATZuMo+NH2JXXfOztgkI5AdhqRv16oMp8gr
 UogcuLK7796lXg4qWc7NODPgD5Ljbvu8Q42C6+8+iRx05G7PZi3iX9S7Og5JJaTw22MSRLVC2
 y/3S+YeyWs+9gPlZLkCAsmK0Lw9ThDWtFUQtd/BEk1Xmo+MdBGpP4aWsmPEf8mOeg9H/q7icl
 y7z80pBMZQsn9px/yi/xT1au8q3KN6J8b4kf/j2R7LAAmEuHLYKQDprFHmghtTDhMzFR86p6E
 16AuwmFqHNP5RfrJJKRU8KWiapD5NW/ZfQtVCBtABnhvCGgVyXVgtui7V+gpZBDVkfEZDLdpU
 DwJeTPfXEDkh9/uu6JEG+KfPYjRJhBtylZd52gajHSd+Tt86QMF09UMd0bop0WFy3mOnE9f
Received-SPF: none client-ip=212.227.126.187; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 10:09:57
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: qemu-trivial@nongnu.org, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 39335fab59e11cfda9b7cf63929825db2dd3a3e0=
:=0D
=0D
  Merge remote-tracking branch 'remotes/vivier2/tags/linux-user-for-5.2-pul=
l-=3D=0D
request' into staging (2020-08-28 22:30:11 +0100)=0D
=0D
are available in the Git repository at:=0D
=0D
  git://github.com/vivier/qemu.git tags/trivial-branch-for-5.2-pull-request=
=0D
=0D
for you to fetch changes up to 1eef4ba6be30f8b95c8cda1bcb50a176d680a34d:=0D
=0D
  docs/system: Fix grammar in documentation (2020-09-01 12:09:30 +0200)=0D
=0D
----------------------------------------------------------------=0D
Pull request trivial patches 20200901=0D
=0D
----------------------------------------------------------------=0D
=0D
Chen Qun (10):=0D
  hw/arm/virt-acpi-build:Remove dead assignment in build_madt()=0D
  hw/arm/omap1:Remove redundant statement in omap_clkdsp_read()=0D
  target/arm/translate-a64:Remove dead assignment in=0D
    handle_scalar_simd_shli()=0D
  target/arm/translate-a64:Remove redundant statement in=0D
    disas_simd_two_reg_misc_fp16()=0D
  hw/virtio/vhost-user:Remove dead assignment in scrub_shadow_regions()=0D
  hw/net/virtio-net:Remove redundant statement in=0D
    virtio_net_rsc_tcp_ctrl_check()=0D
  vfio/platform: Remove dead assignment in vfio_intp_interrupt()=0D
  usb/bus: Remove dead assignment in usb_get_fw_dev_path()=0D
  hw/intc: fix default registers value in exynos4210_combiner_read()=0D
  hw/display/vga:Remove redundant statement in vga_draw_graphic()=0D
=0D
Greg Kurz (1):=0D
  mailmap: Add entry for Greg Kurz=0D
=0D
Han Han (1):=0D
  docs: Fix broken links=0D
=0D
Kenta Ishiguro (1):=0D
  hw/i386/kvm/ioapic.c: fix typo in error message=0D
=0D
Liao Pingfang (8):=0D
  target/arm/kvm: Remove superfluous break=0D
  target/ppc: Remove superfluous breaks=0D
  scsi: Remove superfluous breaks=0D
  vnc: Remove the superfluous break=0D
  block/vmdk: Remove superfluous breaks=0D
  hw: Remove superfluous breaks=0D
  target/sh4: Remove superfluous breaks=0D
  target/cris: Remove superfluous breaks=0D
=0D
Mike Gelfand (1):=0D
  linux-user: Add strace support for printing OFD fcntl operations=0D
=0D
Philippe Mathieu-Daud=3DC3=3DA9 (17):=0D
  hw/register: Document register_init_block @memory_size=0D
  hw/isa/isa-superio: Fix IDE controller realization=0D
  stubs/cmos: Use correct include=0D
  hw/core/sysbus: Fix a typo=0D
  hw/core/sysbus: Assert memory region index is in range=0D
  Revert "mailmap: Update philmd email address"=0D
  .mailmap: Update Paul Burton email address=0D
  hw/i2c: Fix typo in description=0D
  util/qemu-timer: Fix typo in description=0D
  util/vfio-helpers: Fix typo in description=0D
  hw/ide/core: Trivial typo fix=0D
  hw/ide/ahci: Replace magic '512' value by BDRV_SECTOR_SIZE=0D
  hw/ide/atapi: Replace magic '512' value by BDRV_SECTOR_SIZE=0D
  hw/ide/pci: Replace magic '512' value by BDRV_SECTOR_SIZE=0D
  hw/scsi/scsi-disk: Replace magic '512' value by BDRV_SECTOR_SIZE=0D
  hw/net/xilinx_axienet: Remove unused code=0D
  util/vfio-helpers: Unify trace-events size format=0D
=0D
Stefan Weil (2):=0D
  main-loop: Fix comment=0D
  docs/system: Fix grammar in documentation=0D
=0D
Thomas Huth (2):=0D
  hw/net/can: Add missing fallthrough statements=0D
  docs/system/target-avr: Improve the AVR docs and add to MAINTAINERS=0D
=0D
Tianjia Zhang (1):=0D
  qemu-options.hx: Fix typo for netdev documentation=0D
=0D
 .mailmap                        |  9 ++++---=0D
 MAINTAINERS                     |  1 +=0D
 block/vmdk.c                    |  3 ---=0D
 docs/amd-memory-encryption.txt  |  4 +--=0D
 docs/pvrdma.txt                 |  2 +-=0D
 docs/system/build-platforms.rst |  6 ++---=0D
 docs/system/target-avr.rst      | 47 ++++++++++++++++++++-------------=0D
 hw/arm/omap1.c                  |  1 -=0D
 hw/arm/virt-acpi-build.c        |  3 +--=0D
 hw/block/pflash_cfi01.c         |  1 -=0D
 hw/core/sysbus.c                |  3 ++-=0D
 hw/display/cirrus_vga.c         |  1 -=0D
 hw/display/qxl-logger.c         |  2 --=0D
 hw/display/vga.c                |  1 -=0D
 hw/gpio/max7310.c               |  3 ---=0D
 hw/i386/intel_iommu.c           |  1 -=0D
 hw/i386/kvm/ioapic.c            |  2 +-=0D
 hw/ide/ahci.c                   |  5 ++--=0D
 hw/ide/atapi.c                  |  8 +++---=0D
 hw/ide/core.c                   |  2 +-=0D
 hw/ide/pci.c                    |  2 +-=0D
 hw/input/pxa2xx_keypad.c        | 10 -------=0D
 hw/intc/armv7m_nvic.c           |  1 -=0D
 hw/intc/exynos4210_combiner.c   |  1 -=0D
 hw/isa/isa-superio.c            |  2 +-=0D
 hw/net/can/can_sja1000.c        |  2 ++=0D
 hw/net/lan9118.c                |  2 --=0D
 hw/net/virtio-net.c             |  1 -=0D
 hw/net/xilinx_axienet.c         | 23 ----------------=0D
 hw/scsi/scsi-disk.c             | 44 +++++++++++++++---------------=0D
 hw/usb/bus.c                    |  4 +--=0D
 hw/usb/ccid-card-emulated.c     |  1 -=0D
 hw/vfio/platform.c              |  2 +-=0D
 hw/virtio/vhost-user.c          |  2 +-=0D
 include/hw/i2c/i2c.h            |  2 +-=0D
 include/hw/register.h           |  1 +=0D
 include/qemu/main-loop.h        |  2 +-=0D
 linux-user/strace.c             | 12 +++++++++=0D
 qemu-options.hx                 |  2 +-=0D
 scsi/utils.c                    |  4 ---=0D
 stubs/cmos.c                    |  2 +-=0D
 target/arm/kvm64.c              |  1 -=0D
 target/arm/translate-a64.c      |  7 ++---=0D
 target/cris/translate.c         |  7 +++--=0D
 target/cris/translate_v10.c.inc |  2 --=0D
 target/ppc/misc_helper.c        |  5 ----=0D
 target/sh4/translate.c          |  3 ---=0D
 ui/vnc-enc-tight.c              |  1 -=0D
 util/qemu-timer.c               |  2 +-=0D
 util/trace-events               |  6 ++---=0D
 util/vfio-helpers.c             |  4 +--=0D
 51 files changed, 112 insertions(+), 153 deletions(-)=0D
=0D
--=3D20=0D
2.26.2=0D
=0D

