Return-Path: <SRS0=MBD3=C4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2729DC43464
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2020 16:04:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBFA7208DB
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2020 16:04:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UzObs0KG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBFA7208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJfLh-0001N1-Kt
	for qemu-devel@archiver.kernel.org; Sat, 19 Sep 2020 12:04:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51096)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kJfGs-00059Y-MQ
 for qemu-devel@nongnu.org; Sat, 19 Sep 2020 11:59:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26837)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kJfGk-0007JX-Lg
 for qemu-devel@nongnu.org; Sat, 19 Sep 2020 11:59:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600531161;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=d0P2YESn3Qpy+JulSmDsTBIUJoxg9Wa3ixDqeUGbkoI=;
 b=UzObs0KG5YOQD9aFjcBfaYCqG0Ob832WXBzCPwLo8EcEd0FmDcv8LwwnHBDCrrw/GIJk1y
 525e+MQNHZ4d8aaOhXB5Nyoq5cschu/vMl24N+avKLVunWTipDT4c5V/Z4S6PRc/G5RftG
 V8XFIw8mbSnCxYYOHWqVgAxqNkj0pBc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-174-ESuTDGW1MDW3NXTGvVKYDg-1; Sat, 19 Sep 2020 11:59:17 -0400
X-MC-Unique: ESuTDGW1MDW3NXTGvVKYDg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E1ACE10066FC
 for <qemu-devel@nongnu.org>; Sat, 19 Sep 2020 15:59:16 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AEB811002388
 for <qemu-devel@nongnu.org>; Sat, 19 Sep 2020 15:59:16 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/57] Misc patches for 2020-09-19
Date: Sat, 19 Sep 2020 11:58:19 -0400
Message-Id: <20200919155916.1046398-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/19 11:03:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit de39a045bd8d2b49e4f3d07976622c29d58e0bac:

  Merge remote-tracking branch 'remotes/kraxel/tags/vga-20200915-pull-request' into staging (2020-09-15 14:25:05 +0100)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 2521f1f245101df93d12e40144af62aae0bb96a6:

  meson: fix installation of keymaps (2020-09-19 11:57:44 -0400)

----------------------------------------------------------------
* SCSI fix (Dmitry, Li Feng, Li Qiang)
* memory API fixes (Eduardo)
* removal of deprecated '-numa node' (Igor)
* ACPI fix for VMBus (Jon)
* relocatable install (myself)
* always remove docker containers (myself)
* serial cleanups (Philippe)
* vmware cpuid leaf for tsc and apic frequency (Sunil)
* KVM_FEATURE_ASYNC_PF_INT support (Vitaly)
* i386 XSAVE bugfix (Xiaoyao)

meson:
* fixes (Marc-André, Max, Stefan, myself)
* moved libmpathpersist, cocoa, malloc tests (myself)
* support for 0.56 introspected test dependencies (myself)

----------------------------------------------------------------
Anthony PERARD (1):
      meson: fix installation of keymaps

Claudio Fontana (1):
      tests: add missing genh dependency

Dmitry Fomichev (1):
      scsi-generic: Fix HM-zoned device scan

Eduardo Habkost (1):
      memory: Convert IOMMUMemoryRegionClass doc comment to kernel-doc

Igor Mammedov (3):
      numa: drop support for '-numa node' (without memory specified)
      doc: Cleanup "'-mem-path' fallback to RAM" deprecation text
      numa: remove fixup numa_state->num_nodes to MAX_NODES

Jon Doron (1):
      acpi: i386: Move VMBus DSDT entry to SB

Li Feng (1):
      vhost-scsi: support inflight io track

Li Qiang (2):
      hw: megasas: return -1 when 'megasas_map_sgl' fails
      hw: megasas: consider 'iov_count=0' is an error in megasas_map_sgl

Marc-André Lureau (2):
      meson: fix MSI rule
      meson: error out if qemu_suffix starts with /

Max Reitz (1):
      iotests: Work around failing readlink -f

Paolo Bonzini (25):
      meson: clean up build_by_default
      ninjatool: rebuild multi-output targets if outputs are missing
      meson: move libudev test
      meson: move libmpathpersist test
      meson: extend libmpathpersist test for static linking
      configure: move malloc_trim/tcmalloc/jemalloc to meson
      configure: fix --meson=/path/to/meson
      configure: move cocoa option to Meson
      configure: do not limit Hypervisor.framework test to Darwin
      meson: qtest: set "depends" correctly
      mtest2make: add support for introspected test dependencies
      meson: report accelerator support
      oslib: do not call g_strdup from qemu_get_exec_dir
      fuzz: use qemu_get_exec_dir
      oslib-posix: default exec_dir to bindir
      cutils: introduce get_relocated_path
      oslib-posix: relocate path to /var
      module: relocate path to modules
      net: relocate paths to helpers and scripts
      vl: relocate paths to data directories
      vl: relocate path to configuration file
      qemu-bridge-helper: relocate path to default ACL
      qga: relocate path to default configuration and hook
      ui: relocate paths to icons and translations
      configure: use a platform-neutral prefix

Philippe Mathieu-Daudé (11):
      configure: Do not intent to build WHPX on 32-bit host
      hw/mips/mipssim: Use MMIO serial device on fake ISA I/O
      hw/char/serial: Remove TYPE_SERIAL_IO
      hw/char/serial: Assert serial_ioport_read/write offset fits 8 bytes
      hw/char/serial: Replace commented DPRINTF() by trace event
      hw/char/serial: Remove old DEBUG_SERIAL commented code
      hw/char/serial: Rename I/O read/write trace events
      hw/char/serial: Make 'wakeup' property boolean
      hw/char/serial-{isa, pci}: Alias QDEV properties from generic serial object
      hw/i386/q35: Remove unreachable Xen code on Q35 machine
      exec: Remove MemoryRegion::global_locking field

Stefan Hajnoczi (2):
      MAINTAINERS: add Paolo Bonzini as RCU maintainer
      configure: rename QEMU_GA_MSI_ENABLED to CONFIG_QGA_MSI

Stefano Garzarella (1):
      checkpatch: avoid error on cover letter files

Sunil Muthuswamy (1):
      WHPX: vmware cpuid leaf for tsc and apic frequency

Thomas Huth (1):
      Simplify the .gitignore file

Vitaly Kuznetsov (1):
      target/i386: support KVM_FEATURE_ASYNC_PF_INT

Xiaoyao Li (1):
      i386/cpu: Clear FEAT_XSAVE_COMP_{LO,HI} when XSAVE is not available

 .gitignore                            | 152 ----------------------
 MAINTAINERS                           |   8 ++
 Makefile                              |   4 +-
 accel/tcg/cputlb.c                    |   4 +-
 configure                             | 237 ++++++----------------------------
 docs/devel/build-system.rst           |   5 +
 docs/system/deprecated.rst            |  44 ++++---
 exec.c                                |   2 +-
 hw/char/serial-isa.c                  |   4 +-
 hw/char/serial-pci.c                  |   3 +-
 hw/char/serial.c                      |  65 +---------
 hw/char/trace-events                  |   5 +-
 hw/core/machine.c                     |   1 -
 hw/core/numa.c                        |  59 ---------
 hw/i386/acpi-build.c                  |  12 +-
 hw/i386/pc_piix.c                     |   1 -
 hw/i386/pc_q35.c                      |  14 +-
 hw/mips/mipssim.c                     |   5 +-
 hw/ppc/spapr.c                        |   1 -
 hw/scsi/megasas.c                     |   6 +-
 hw/scsi/scsi-generic.c                |  10 +-
 hw/scsi/vhost-scsi-common.c           |  27 ++++
 include/exec/memory.h                 |  64 +++++----
 include/hw/boards.h                   |   2 -
 include/hw/char/serial.h              |  13 +-
 include/hw/virtio/vhost-scsi-common.h |   2 +
 include/net/net.h                     |   4 +-
 include/qemu-common.h                 |   1 -
 include/qemu/cutils.h                 |  12 ++
 include/qemu/osdep.h                  |   8 +-
 include/scsi/constants.h              |   1 +
 include/sysemu/numa.h                 |   4 -
 include/sysemu/sysemu.h               |   2 +-
 meson.build                           | 187 ++++++++++++++++++++++-----
 meson_options.txt                     |   9 ++
 net/tap.c                             |  26 +++-
 os-posix.c                            |  24 ----
 os-win32.c                            |  11 --
 pc-bios/keymaps/meson.build           |   2 +
 qemu-bridge-helper.c                  |   9 +-
 qga/main.c                            |   8 +-
 qga/meson.build                       |   1 +
 scripts/checkpatch.pl                 |   2 +-
 scripts/mtest2make.py                 |  19 ++-
 scripts/ninjatool.py                  |   3 +
 softmmu/memory.c                      |   6 -
 softmmu/vl.c                          |  43 ++++--
 target/i386/cpu.c                     |   6 +-
 target/i386/cpu.h                     |   1 +
 target/i386/kvm.c                     |  10 ++
 target/i386/machine.c                 |  19 +++
 target/i386/whp-dispatch.h            |   3 +-
 target/i386/whpx-all.c                |  96 ++++++++++++--
 tests/fp/meson.build                  |   2 -
 tests/meson.build                     |   9 +-
 tests/qemu-iotests/check              |   4 +
 tests/qemu-iotests/meson.build        |   3 +-
 tests/qtest/fuzz/fuzz.c               |  12 +-
 tests/qtest/meson.build               |   2 +
 trace/meson.build                     |   1 -
 ui/gtk.c                              |  10 +-
 ui/meson.build                        |   2 +-
 ui/sdl2.c                             |   9 +-
 ui/shader/meson.build                 |   1 -
 util/cutils.c                         |  61 +++++++++
 util/module.c                         |  10 +-
 util/oslib-posix.c                    |  35 +++--
 util/oslib-win32.c                    |  14 +-
 68 files changed, 699 insertions(+), 743 deletions(-)
-- 
2.26.2


