Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C0C9C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 10:51:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36EC220720
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 10:51:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L0bpJWkF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36EC220720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46038 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo2zk-0000WH-Ds
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 06:51:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55638)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jo2y8-0006in-5T
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 06:49:29 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:48444
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jo2y1-0000eM-Op
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 06:49:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592995760;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=HVbnfpN7J8rwVYEM7vYpng/fziEjFHpSje4rIAuB7XY=;
 b=L0bpJWkFCJ6AOR89fEmcnMzBehg2LBNK5XusyoMDsLoW44PbIZcVymdDw6dW/CVctIlvlm
 9O9cw5fm2zMZ0sR/Bei1Y2/TGBofs98owBuut/loSsHsjXeKf5oj04cCn8RavrTfrLf6YV
 5j9WQPH1XxzEFBwlCPXgbHibRlsPUbE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-380-2qli9S2rMwqy7JfRPgV2aw-1; Wed, 24 Jun 2020 06:49:19 -0400
X-MC-Unique: 2qli9S2rMwqy7JfRPgV2aw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 202B787950B
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2020 10:49:18 +0000 (UTC)
Received: from virtlab511.virt.lab.eng.bos.redhat.com
 (virtlab511.virt.lab.eng.bos.redhat.com [10.19.152.198])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D160C7FE82
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2020 10:49:17 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/31] Misc patches for 2020-06-24
Date: Wed, 24 Jun 2020 06:48:45 -0400
Message-Id: <20200624104917.375143-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 00:34:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

The following changes since commit 171199f56f5f9bdf1e5d670d09ef1351d8f01bae:

  Merge remote-tracking branch 'remotes/alistair/tags/pull-riscv-to-apply-20200619-3' into staging (2020-06-22 14:45:25 +0100)

are available in the Git repository at:

  git://github.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 7fc58934d34e939489e20af4c97aeb095c1f2b20:

  i386: Mask SVM features if nested SVM is disabled (2020-06-24 04:37:59 -0400)

----------------------------------------------------------------
* Various fixes
* libdaxctl support to correctly align devdax character devices (Jingqi)
* initial-all-set support for live migration (Jay)
* forbid '-numa node, mem' for 5.1 and newer machine types (Igor)
* x87 fixes (Joseph)
* Tighten memory_region_access_valid (Michael) and fix fallout (myself)
* Replay fixes (Pavel)

----------------------------------------------------------------
Anthony PERARD (1):
      xen: Actually fix build without passthrough

David CARLIER (1):
      util/getauxval: Porting to FreeBSD getauxval feature

Eduardo Habkost (1):
      i386: Mask SVM features if nested SVM is disabled

Eric Blake (1):
      osdep: Make MIN/MAX evaluate arguments only once

Igor Mammedov (1):
      numa: forbid '-numa node, mem' for 5.1 and newer machine types

Jay Zhou (1):
      kvm: support to get/set dirty log initial-all-set capability

Jingqi Liu (3):
      configure: add libdaxctl support
      exec: fetch the alignment of Linux devdax pmem character device nodes
      docs/nvdimm: add description of alignment requirement of device dax

Jon Doron (1):
      hyperv: vmbus: Remove the 2nd IRQ

Joseph Myers (10):
      target/i386: reimplement f2xm1 using floatx80 operations
      softfloat: merge floatx80_mod and floatx80_rem
      softfloat: fix floatx80 remainder pseudo-denormal check for zero
      softfloat: do not return pseudo-denormal from floatx80 remainder
      softfloat: do not set denominator high bit for floatx80 remainder
      softfloat: return low bits of quotient from floatx80_modrem
      target/i386: reimplement fprem, fprem1 using floatx80 operations
      target/i386: reimplement fyl2xp1 using floatx80 operations
      target/i386: reimplement fyl2x using floatx80 operations
      target/i386: reimplement fpatan using floatx80 operations

Liao Pingfang (1):
      Makefile: Install qemu-[qmp/ga]-ref.* into the directory "interop"

Marcelo Tosatti (1):
      kvm: i386: allow TSC to differ by NTP correction bounds without TSC scaling

Michael S. Tsirkin (1):
      memory: Revert "memory: accept mismatching sizes in memory_region_access_valid"

Paolo Bonzini (4):
      libqos: usb-hcd-ehci: use 32-bit write for config register
      libqos: pci-pc: use 32-bit write for EJ register
      vmport: move compat properties to hw_compat_5_0
      ibex_uart: fix XOR-as-pow

Pavel Dovgaluk (2):
      replay: notify the main loop when there are no instructions
      replay: synchronize on every virtual timer callback

Tao Xu (1):
      target/i386: Add notes for versioned CPU models

Thomas Huth (1):
      hw/scsi/megasas: Fix possible out-of-bounds array access in tracepoints

 Makefile                            |   10 +-
 accel/kvm/kvm-all.c                 |   21 +-
 accel/tcg/translate-all.c           |    6 +-
 configure                           |   29 +
 cpus.c                              |   15 +-
 docs/index.html.in                  |    4 +-
 docs/nvdimm.txt                     |   10 +
 docs/system/deprecated.rst          |   37 +-
 exec.c                              |   54 +-
 fpu/softfloat.c                     |   87 ++-
 hw/arm/virt.c                       |    2 +-
 hw/char/ibex_uart.c                 |    2 +-
 hw/core/machine.c                   |    8 +-
 hw/core/numa.c                      |    7 +
 hw/hyperv/vmbus.c                   |    3 +-
 hw/i386/acpi-build.c                |    4 +-
 hw/i386/pc.c                        |    1 -
 hw/i386/pc_piix.c                   |    1 +
 hw/i386/pc_q35.c                    |    1 +
 hw/ppc/spapr.c                      |    2 +-
 hw/scsi/megasas.c                   |   36 +-
 hw/usb/hcd-xhci.h                   |    2 +-
 hw/xen/Makefile.objs                |    2 +-
 include/block/block.h               |    4 +-
 include/exec/cpu-all.h              |    8 +-
 include/exec/cpu-defs.h             |    7 +-
 include/fpu/softfloat.h             |    3 +
 include/hw/hyperv/vmbus-bridge.h    |    3 +-
 include/qemu/osdep.h                |   55 +-
 memory.c                            |   29 +-
 migration/qemu-file.c               |    2 +-
 qemu-options.hx                     |    9 +-
 replay/replay.c                     |    2 +-
 target/i386/cpu.c                   |    9 +
 target/i386/fpu_helper.c            | 1396 +++++++++++++++++++++++++++++++----
 target/i386/kvm.c                   |   46 +-
 target/m68k/softfloat.c             |   83 ---
 target/m68k/softfloat.h             |    1 -
 tests/qtest/libqos/pci-pc.c         |    2 +-
 tests/qtest/test-x86-cpuid-compat.c |    4 +-
 tests/qtest/usb-hcd-ehci-test.c     |    2 +-
 tests/tcg/i386/test-i386-f2xm1.c    | 1140 ++++++++++++++++++++++++++++
 tests/tcg/i386/test-i386-fpatan.c   | 1071 +++++++++++++++++++++++++++
 tests/tcg/i386/test-i386-fyl2x.c    | 1161 +++++++++++++++++++++++++++++
 tests/tcg/i386/test-i386-fyl2xp1.c  | 1156 +++++++++++++++++++++++++++++
 util/getauxval.c                    |   10 +
 util/qemu-timer.c                   |   32 +-
 47 files changed, 6209 insertions(+), 370 deletions(-)
 create mode 100644 tests/tcg/i386/test-i386-f2xm1.c
 create mode 100644 tests/tcg/i386/test-i386-fpatan.c
 create mode 100644 tests/tcg/i386/test-i386-fyl2x.c
 create mode 100644 tests/tcg/i386/test-i386-fyl2xp1.c
-- 
2.26.2


