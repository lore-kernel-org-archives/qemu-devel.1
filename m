Return-Path: <SRS0=08iY=SU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79C12C10F14
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 20:40:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 402C7214C6
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 20:40:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 402C7214C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46933 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHDpr-0005oD-Dq
	for qemu-devel@archiver.kernel.org; Thu, 18 Apr 2019 16:40:43 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51247)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hHDnx-0001J6-4U
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 16:38:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hHDnv-0002dS-HK
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 16:38:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54040)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hHDnv-0002c5-8z
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 16:38:43 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 579DEC05681F
	for <qemu-devel@nongnu.org>; Thu, 18 Apr 2019 20:38:42 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-116.ams2.redhat.com
	[10.36.116.116])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 004EC60851
	for <qemu-devel@nongnu.org>; Thu, 18 Apr 2019 20:38:41 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 64B131138648; Thu, 18 Apr 2019 22:38:40 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 18 Apr 2019 22:38:31 +0200
Message-Id: <20190418203840.10528-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.32]);
	Thu, 18 Apr 2019 20:38:42 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL for-4.1 0/9] Miscellaneous patches for 2019-04-18
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190418203831.t4dHxJnSgWdbZdYR1Occ6zaT9-uAGk0NNYoAmP5xXzE@z>

Early pull request because I'll be on vacation when 4.1 opens.  Hope
that's okay.

The following changes since commit eeba63fc7fface36f438bcbc0d3b02e7dcb599=
83:

  Update version for v4.0.0-rc4 release (2019-04-16 21:53:00 +0100)

are available in the Git repository at:

  git://repo.or.cz/qemu/armbru.git tags/pull-misc-2019-04-18

for you to fetch changes up to 15136db27efaf0bdcf1131d41ad57832a2acadcc:

  Clean up decorations and whitespace around header guards (2019-04-17 19=
:20:46 +0200)

----------------------------------------------------------------
Miscellaneous patches for 2019-04-18

----------------------------------------------------------------
Markus Armbruster (9):
      Clean up includes
      Use #include "..." for our own headers, <...> for others
      authz: Normalize #include "authz/trace.h" to "trace.h"
      linux-user/nios2 linux-user/riscv: Clean up header guards
      target/xtensa: Clean up core-isa.h header guards
      Clean up header guards that don't match their file name
      Clean up ill-advised or unusual header guards
      Normalize header guard symbol definition.
      Clean up decorations and whitespace around header guards

 authz/base.c                                    |  2 +-
 authz/list.c                                    |  2 +-
 authz/listfile.c                                |  2 +-
 authz/pamacct.c                                 |  2 +-
 authz/simple.c                                  |  2 +-
 block/crypto.h                                  |  6 +++---
 contrib/elf2dmp/main.c                          |  3 +--
 contrib/elf2dmp/pdb.c                           |  3 +--
 contrib/elf2dmp/qemu_elf.h                      |  6 +++---
 contrib/rdmacm-mux/main.c                       | 18 +++++++++---------
 contrib/rdmacm-mux/rdmacm-mux.h                 |  6 +++---
 disas/nanomips.h                                |  4 ++--
 fsdev/qemu-fsdev-throttle.h                     |  7 ++++---
 hw/arm/smmuv3-internal.h                        |  4 ++--
 hw/display/ati.c                                |  1 +
 hw/display/ati_2d.c                             |  1 +
 hw/display/ati_dbg.c                            |  1 +
 hw/display/ati_int.h                            |  1 -
 hw/display/vga_regs.h                           |  6 +++---
 hw/i386/amd_iommu.h                             |  4 ++--
 hw/ide/ahci_internal.h                          |  2 +-
 hw/rdma/rdma_utils.h                            |  1 -
 hw/rdma/vmw/pvrdma_qp_ops.h                     |  4 ++--
 hw/sd/sdmmc-internal.h                          |  5 +++--
 hw/timer/m48t59-internal.h                      |  3 ++-
 hw/tpm/tpm_ioctl.h                              |  7 ++++---
 hw/xtensa/xtensa_memory.h                       |  4 ++--
 include/authz/base.h                            |  7 +++----
 include/authz/list.h                            |  7 +++----
 include/authz/listfile.h                        |  8 +++-----
 include/authz/pamacct.h                         |  7 +++----
 include/authz/simple.h                          |  7 +++----
 include/block/aio-wait.h                        |  2 +-
 include/chardev/spice.h                         |  4 ++--
 include/disas/capstone.h                        |  2 +-
 include/exec/translator.h                       |  2 +-
 include/hw/arm/nrf51_soc.h                      |  1 -
 include/hw/arm/smmu-common.h                    |  2 +-
 include/hw/audio/soundhw.h                      |  4 ++--
 include/hw/cpu/cluster.h                        |  1 -
 include/hw/i386/x86-iommu.h                     |  4 ++--
 include/hw/intc/heathrow_pic.h                  |  6 +++---
 include/hw/intc/xlnx-pmu-iomod-intc.h           |  6 +++---
 include/hw/misc/armsse-mhu.h                    |  4 ++--
 include/hw/misc/imx2_wdt.h                      |  2 +-
 include/hw/misc/nrf51_rng.h                     |  3 ++-
 include/hw/pci-host/designware.h                |  2 +-
 include/hw/pci-host/sabre.h                     |  4 ++--
 include/hw/ppc/pnv.h                            |  7 ++++---
 include/hw/ppc/pnv_core.h                       |  7 ++++---
 include/hw/ppc/pnv_lpc.h                        |  7 ++++---
 include/hw/ppc/pnv_occ.h                        |  7 ++++---
 include/hw/ppc/pnv_psi.h                        |  7 ++++---
 include/hw/ppc/pnv_xscom.h                      |  7 ++++---
 include/hw/ppc/spapr_ovec.h                     |  7 ++++---
 include/hw/riscv/sifive_plic.h                  |  1 -
 include/hw/scsi/emulation.h                     |  2 +-
 include/hw/timer/pl031.h                        |  4 ++--
 include/hw/virtio/vhost-vsock.h                 |  6 +++---
 include/hw/virtio/virtio-crypto.h               |  6 +++---
 include/hw/watchdog/wdt_aspeed.h                |  7 ++++---
 include/hw/xen/start_info.h                     |  6 +++---
 include/hw/xen/xen-legacy-backend.h             |  6 +++---
 include/hw/xtensa/mx_pic.h                      |  4 ++--
 include/hw/xtensa/xtensa-isa.h                  |  6 +++---
 include/migration/qemu-file-types.h             |  4 ++--
 include/qemu/drm.h                              |  4 ++--
 include/qemu/filemonitor.h                      |  6 +++---
 include/qemu/jhash.h                            |  6 +++---
 include/qemu/pmem.h                             |  2 +-
 include/qemu/stats64.h                          |  2 +-
 include/qemu/sys_membarrier.h                   |  2 +-
 include/qemu/systemd.h                          |  2 +-
 include/scsi/constants.h                        |  4 ++--
 include/scsi/utils.h                            |  2 +-
 include/sysemu/hvf.h                            |  5 +++--
 include/ui/kbd-state.h                          |  3 ++-
 linux-user/nios2/target_cpu.h                   |  4 ++--
 linux-user/nios2/target_signal.h                |  6 +++---
 linux-user/nios2/target_structs.h               |  4 ++--
 linux-user/nios2/target_syscall.h               |  6 +++---
 linux-user/riscv/target_cpu.h                   |  4 ++--
 linux-user/riscv/target_signal.h                |  6 +++---
 linux-user/riscv/target_structs.h               |  4 ++--
 linux-user/xtensa/syscall_nr.h                  |  6 +++---
 linux-user/xtensa/target_structs.h              |  4 ++--
 linux-user/xtensa/termbits.h                    |  6 +++---
 net/colo.h                                      |  6 +++---
 qga/vss-win32/vss-handles.h                     |  4 ++--
 scsi/pr-helper.h                                |  3 ++-
 target/i386/hax-i386.h                          |  4 ++--
 target/i386/hax-interface.h                     |  4 ++--
 target/i386/hax-posix.h                         |  6 +++---
 target/i386/hvf/hvf-i386.h                      |  4 ++--
 target/i386/hvf/vmcs.h                          |  4 ++--
 target/i386/hvf/x86.h                           |  2 +-
 target/i386/hvf/x86_decode.h                    |  2 +-
 target/i386/hvf/x86_descr.h                     |  2 +-
 target/i386/hvf/x86_emu.h                       |  5 +++--
 target/i386/hvf/x86_flags.h                     |  7 ++++---
 target/i386/hvf/x86_mmu.h                       |  7 ++++---
 target/i386/hvf/x86_task.h                      |  6 ++++--
 target/i386/whp-dispatch.h                      |  2 +-
 target/i386/whpx-all.c                          |  1 -
 target/nios2/cpu.h                              |  7 ++++---
 target/nios2/mmu.h                              |  7 ++++---
 target/ppc/mmu-book3s-v3.h                      |  6 +++---
 target/riscv/pmp.h                              |  4 ++--
 target/sparc/asi.h                              |  6 +++---
 target/xtensa/core-de212/core-isa.h             |  8 +++-----
 target/xtensa/core-sample_controller/core-isa.h |  8 +++-----
 target/xtensa/core-test_kc705_be/core-isa.h     |  8 +++-----
 target/xtensa/core-test_mmuhifi_c3/core-isa.h   |  8 +++-----
 target/xtensa/xtensa-isa-internal.h             |  2 +-
 tests/acpi-utils.h                              |  2 +-
 tests/fp/platform.h                             |  1 -
 tests/libqos/e1000e.h                           |  4 ++--
 tests/libqos/qgraph.h                           |  4 ----
 tests/libqos/qgraph_internal.h                  |  4 ++--
 tests/libqos/sdhci.h                            |  4 ++--
 tests/migration/migration-test.h                |  7 ++++---
 tests/qos-test.c                                |  2 +-
 tests/tpm-emu.h                                 |  2 +-
 123 files changed, 272 insertions(+), 272 deletions(-)

--=20
2.17.2


