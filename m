Return-Path: <SRS0=GUf1=UD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B8EEC28D18
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 18:18:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A2C2207E0
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 18:18:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A2C2207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56200 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYE0j-0000id-8H
	for qemu-devel@archiver.kernel.org; Tue, 04 Jun 2019 14:18:13 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35950)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hYDyw-00085i-EZ
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 14:16:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hYDyv-0002w2-1y
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 14:16:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40038)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hYDyu-0002v5-Q1
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 14:16:20 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 21207821D1
	for <qemu-devel@nongnu.org>; Tue,  4 Jun 2019 18:16:20 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-148.ams2.redhat.com
	[10.36.116.148])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id BC2EA5B68A
	for <qemu-devel@nongnu.org>; Tue,  4 Jun 2019 18:16:19 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 356B411386A0; Tue,  4 Jun 2019 20:16:18 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue,  4 Jun 2019 20:16:14 +0200
Message-Id: <20190604181618.19980-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.28]);
	Tue, 04 Jun 2019 18:16:20 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 0/4] Header guards
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

Markus Armbruster (4):
  Normalize position of header guard
  scripts/clean-header-guards: Fix handling of trailing comments
  Clean up a few header guard symbols
  Supply missing header guards

 contrib/elf2dmp/qemu_elf.h                           |  5 ++---
 crypto/ivgen-essiv.h                                 |  9 ++++-----
 crypto/ivgen-plain.h                                 |  5 ++---
 crypto/ivgen-plain64.h                               |  9 ++++-----
 hw/9pfs/xen-9pfs.h                                   |  6 +++++-
 hw/hppa/hppa_hardware.h                              |  5 +++++
 hw/input/adb-internal.h                              |  4 ++++
 hw/net/e1000e_core.h                                 |  5 +++++
 hw/net/e1000x_common.h                               |  5 +++++
 hw/net/vmxnet3_defs.h                                |  6 +++++-
 hw/usb/hcd-xhci.h                                    |  5 +++++
 hw/usb/quirks.h                                      |  5 +++++
 include/disas/dis-asm.h                              |  6 +++---
 include/fpu/softfloat-macros.h                       |  5 +++++
 include/hw/arm/allwinner-a10.h                       |  4 ++--
 include/hw/arm/omap.h                                |  8 +++++---
 include/hw/arm/raspi_platform.h                      |  5 +++++
 include/hw/arm/xlnx-zynqmp.h                         |  2 +-
 include/hw/char/cadence_uart.h                       |  2 +-
 include/hw/display/xlnx_dp.h                         |  9 ++++-----
 include/hw/dma/xlnx-zynq-devcfg.h                    |  2 +-
 include/hw/kvm/clock.h                               |  6 +++++-
 include/hw/m68k/mcf_fec.h                            |  5 +++++
 include/hw/mips/bios.h                               |  5 +++++
 include/hw/net/cadence_gem.h                         |  2 +-
 include/hw/pci-bridge/simba.h                        |  5 +++++
 include/hw/pci/pci_regs.h                            |  5 +++++
 include/hw/qdev-dma.h                                |  6 ++++++
 include/hw/semihosting/console.h                     |  6 +++---
 include/hw/sparc/sparc64.h                           |  4 ++++
 include/hw/timer/xlnx-zynqmp-rtc.h                   |  5 +++++
 include/hw/xen/io/ring.h                             |  6 +++---
 include/ui/spice-display.h                           |  5 +++++
 linux-user/aarch64/syscall_nr.h                      |  4 ++++
 linux-user/aarch64/termbits.h                        |  5 +++++
 linux-user/alpha/syscall_nr.h                        |  5 +++++
 linux-user/alpha/termbits.h                          |  5 +++++
 linux-user/arm/syscall_nr.h                          |  5 +++++
 linux-user/arm/termbits.h                            |  5 +++++
 linux-user/cris/syscall_nr.h                         |  5 +++++
 linux-user/cris/termbits.h                           |  5 +++++
 linux-user/errno_defs.h                              |  6 ++++++
 linux-user/flat.h                                    |  5 +++++
 linux-user/hppa/sockbits.h                           |  5 +++++
 linux-user/hppa/syscall_nr.h                         |  5 +++++
 linux-user/hppa/termbits.h                           |  5 +++++
 linux-user/i386/syscall_nr.h                         |  5 +++++
 linux-user/i386/termbits.h                           |  5 +++++
 linux-user/m68k/syscall_nr.h                         |  5 +++++
 linux-user/m68k/termbits.h                           |  5 +++++
 linux-user/microblaze/syscall_nr.h                   |  5 +++++
 linux-user/microblaze/termbits.h                     |  5 +++++
 linux-user/mips/syscall_nr.h                         |  6 ++++++
 linux-user/mips/termbits.h                           |  5 +++++
 linux-user/mips64/syscall_nr.h                       |  5 +++++
 linux-user/nios2/syscall_nr.h                        |  5 +++++
 linux-user/nios2/termbits.h                          |  5 +++++
 linux-user/openrisc/syscall_nr.h                     |  5 +++++
 linux-user/openrisc/termbits.h                       |  5 +++++
 linux-user/ppc/syscall_nr.h                          |  6 ++++++
 linux-user/ppc/termbits.h                            |  5 +++++
 linux-user/riscv/syscall_nr.h                        |  5 +++++
 linux-user/riscv/target_syscall.h                    |  5 +++++
 linux-user/riscv/termbits.h                          |  5 +++++
 linux-user/s390x/syscall_nr.h                        |  5 +++++
 linux-user/s390x/termbits.h                          |  4 ++++
 linux-user/sh4/syscall_nr.h                          |  5 +++++
 linux-user/sh4/termbits.h                            |  5 +++++
 linux-user/socket.h                                  |  5 +++++
 linux-user/sparc/syscall_nr.h                        |  5 +++++
 linux-user/sparc/termbits.h                          |  5 +++++
 linux-user/sparc64/syscall_nr.h                      |  5 +++++
 linux-user/sparc64/termbits.h                        |  5 +++++
 linux-user/target_flat.h                             |  6 ++++++
 linux-user/x86_64/syscall_nr.h                       |  5 +++++
 linux-user/x86_64/termbits.h                         |  5 +++++
 linux-user/xtensa/target_flat.h                      |  8 +++++---
 scripts/clean-header-guards.pl                       | 12 +++++++-----
 target/cris/crisv10-decode.h                         |  4 ++++
 target/cris/mmu.h                                    |  5 +++++
 target/cris/opcode-cris.h                            |  6 +++---
 target/i386/whp-dispatch.h                           |  7 +++----
 target/microblaze/microblaze-decode.h                |  4 ++++
 target/microblaze/mmu.h                              |  5 +++++
 target/moxie/mmu.h                                   |  5 +++++
 target/riscv/cpu_bits.h                              |  5 +++++
 target/riscv/cpu_user.h                              |  5 +++++
 target/riscv/instmap.h                               |  5 +++++
 target/tilegx/spr_def_64.h                           | 10 +++-------
 target/tricore/tricore-opcodes.h                     |  5 +++++
 tcg/tcg-gvec-desc.h                                  |  5 +++++
 tcg/tcg-op-gvec.h                                    |  5 +++++
 tests/crypto-tls-psk-helpers.h                       |  5 +++++
 tests/crypto-tls-x509-helpers.h                      |  5 +++++
 tests/io-channel-helpers.h                           |  9 ++++-----
 tests/libqos/virtio-9p.h                             |  5 +++++
 tests/libqos/virtio-balloon.h                        |  5 +++++
 tests/libqos/virtio-blk.h                            |  5 +++++
 tests/libqos/virtio-net.h                            |  5 +++++
 tests/libqos/virtio-rng.h                            |  5 +++++
 tests/libqos/virtio-scsi.h                           |  5 +++++
 tests/libqos/virtio-serial.h                         |  5 +++++
 tests/migration/migration-test.h                     |  2 +-
 tests/socket-helpers.h                               |  6 +++++-
 .../UefiTestToolsPkg/Include/Guid/BiosTablesTest.h   |  6 +++---
 105 files changed, 479 insertions(+), 74 deletions(-)

--=20
2.21.0


