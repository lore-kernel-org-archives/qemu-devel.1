Return-Path: <SRS0=6OCO=YI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F670ECE58F
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 21:39:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65B20217D6
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 21:39:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65B20217D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKUXD-0006Ac-2Y
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 17:39:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59801)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1iKUVs-0004or-6a
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 17:37:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1iKUVp-0006fD-9J
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 17:37:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52608)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1iKUVp-0006f2-0x
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 17:37:49 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A95DC8E1CEE;
 Tue, 15 Oct 2019 21:37:47 +0000 (UTC)
Received: from localhost (ovpn-116-20.phx2.redhat.com [10.3.116.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 475955D70D;
 Tue, 15 Oct 2019 21:37:47 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>,
 qemu-devel@nongnu.org
Subject: [PULL 00/18] x86 and machine queue, 2019-10-15
Date: Tue, 15 Oct 2019 18:37:27 -0300
Message-Id: <20191015213745.22174-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.69]); Tue, 15 Oct 2019 21:37:47 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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

The following changes since commit 69b81893bc28feb678188fbcdce52eff1609bd=
ad:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-201=
91015' into staging (2019-10-15 18:15:59 +0100)

are available in the Git repository at:

  git://github.com/ehabkost/qemu.git tags/machine-next-pull-request

for you to fetch changes up to 69edb0f37a52053978de65a81241ef171a6f2396:

  target/i386: Add Snowridge-v2 (no MPX) CPU model (2019-10-15 18:34:44 -=
0300)

----------------------------------------------------------------
x86 and machine queue, 2019-10-15

Features:
* Snowridge-v2 (no MPX) CPU model (Xiaoyao Li)

Bug fixes:
* cpu-plug-test: fix device_add for pc/q35 machines (Igor Mammedov)
* Fix legacy guest with xsave panic on older Linux kernel (Bingsong Si)
* Omit all-zeroes entries from KVM CPUID table (Eduardo Habkost)

Cleanups:
* Convert reset handlers to DeviceReset (Philippe Mathieu-Daud=C3=A9)
* MachineClass::auto_enable_numa field (Tao Xu)
* target/i386/cpu.h cleanups (Tao Xu)
* memory_device_get_free_addr() cleanups (Wei Yang)

----------------------------------------------------------------


Bingsong Si (1):
  i386: Fix legacy guest with xsave panic on host kvm without update
    cpuid.

Eduardo Habkost (1):
  i386: Omit all-zeroes entries from KVM CPUID table

Igor Mammedov (2):
  tests: add qtest_qmp_device_add_qdict() helper
  tests: cpu-plug-test: fix device_add for pc/q35 machines

Philippe Mathieu-Daud=C3=A9 (8):
  hw/acpi/piix4: Convert reset handler to DeviceReset
  hw/isa/piix4: Convert reset handler to DeviceReset
  hw/ide/piix: Convert reset handler to DeviceReset
  hw/ide/sii3112: Convert reset handler to DeviceReset
  hw/ide/via82c: Convert reset handler to DeviceReset
  hw/isa/vt82c686: Convert reset handler to DeviceReset
  hw/input/lm832x: Convert reset handler to DeviceReset
  hw/misc/vmcoreinfo: Add comment about reset handler

Tao Xu (3):
  numa: Introduce MachineClass::auto_enable_numa for implicit NUMA node
  target/i386: clean up comments over 80 chars per line
  target/i386: drop the duplicated definition of cpuid AVX512_VBMI macro

Wei Yang (2):
  memory-device: not necessary to use goto for the last check
  memory-device: break the loop if tmp exceed the hinted range

Xiaoyao Li (1):
  target/i386: Add Snowridge-v2 (no MPX) CPU model

 include/hw/boards.h         |   1 +
 target/i386/cpu.h           | 169 +++++++++++++++++++++++-------------
 tests/libqtest.h            |  12 +++
 hw/acpi/piix4.c             |   7 +-
 hw/core/numa.c              |  10 ++-
 hw/ide/piix.c               |   9 +-
 hw/ide/sii3112.c            |   7 +-
 hw/ide/via.c                |  10 +--
 hw/input/lm832x.c           |  12 ++-
 hw/isa/piix4.c              |   7 +-
 hw/isa/vt82c686.c           |  11 +--
 hw/mem/memory-device.c      |   3 +-
 hw/misc/vmcoreinfo.c        |   4 +
 hw/ppc/spapr.c              |   9 +-
 target/i386/cpu.c           |  28 ++++--
 target/i386/hvf/x86_cpuid.c |   2 +-
 target/i386/kvm.c           |  14 +++
 tests/cpu-plug-test.c       |  62 ++++++-------
 tests/libqtest.c            |  29 ++++---
 19 files changed, 247 insertions(+), 159 deletions(-)

--=20
2.21.0


