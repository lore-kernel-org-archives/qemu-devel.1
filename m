Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62195C3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 16:11:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34DB922CE3
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 16:11:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34DB922CE3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0TD1-000850-Cu
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 12:11:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55326)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1i0T9f-0002qD-1N
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 12:08:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1i0T9d-0002hf-M1
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 12:08:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:64267)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1i0T9a-0002ge-3J
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 12:08:07 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 09B427F756
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 16:08:05 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A535E60BF3
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 16:08:04 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 21EDC11655EE; Wed, 21 Aug 2019 18:08:03 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 21 Aug 2019 18:07:59 +0200
Message-Id: <20190821160803.10026-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.71]); Wed, 21 Aug 2019 16:08:05 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 0/4] Monitor patches for 2019-08-21
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

The following changes since commit 17dc57990320edaad52ac9ea808be9719c91ce=
a6:

  Merge remote-tracking branch 'remotes/huth-gitlab/tags/pull-request-201=
9-08-20' into staging (2019-08-20 14:14:20 +0100)

are available in the Git repository at:

  git://repo.or.cz/qemu/armbru.git tags/pull-monitor-2019-08-21

for you to fetch changes up to eb707eac58dfc2d17281f67dde40cab3b8b26cc0:

  monitor/qmp: Update comment for commit 4eaca8de268 (2019-08-21 17:33:38=
 +0200)

----------------------------------------------------------------
Monitor patches for 2019-08-21

----------------------------------------------------------------
Markus Armbruster (4):
      hw/core: Move cpu.c, cpu.h from qom/ to hw/core/
      qapi: Move query-target from misc.json to machine.json
      qdev: Collect HMP handlers command handlers in qdev-monitor.c
      monitor/qmp: Update comment for commit 4eaca8de268

 docs/interop/firmware.json     |  2 +-
 qapi/common.json               | 25 ----------------------
 qapi/machine.json              | 48 ++++++++++++++++++++++++++++++++++++=
+++++-
 qapi/misc.json                 | 23 --------------------
 include/exec/cpu-all.h         |  2 +-
 include/exec/cpu-defs.h        |  2 +-
 include/exec/log.h             |  2 +-
 include/hw/boards.h            |  2 +-
 include/{qom =3D> hw/core}/cpu.h |  0
 include/hw/ppc/openpic.h       |  2 +-
 include/sysemu/hw_accel.h      |  2 +-
 include/sysemu/kvm.h           |  2 +-
 target/alpha/cpu-qom.h         |  2 +-
 target/arm/cpu-qom.h           |  2 +-
 target/cris/cpu-qom.h          |  2 +-
 target/hppa/cpu-qom.h          |  2 +-
 target/i386/cpu-qom.h          |  2 +-
 target/lm32/cpu-qom.h          |  2 +-
 target/m68k/cpu-qom.h          |  2 +-
 target/microblaze/cpu-qom.h    |  2 +-
 target/mips/cpu-qom.h          |  2 +-
 target/moxie/cpu.h             |  2 +-
 target/nios2/cpu.h             |  2 +-
 target/openrisc/cpu.h          |  2 +-
 target/ppc/cpu-qom.h           |  2 +-
 target/riscv/cpu.h             |  2 +-
 target/s390x/cpu-qom.h         |  2 +-
 target/s390x/cpu_models.h      |  2 +-
 target/sh4/cpu-qom.h           |  2 +-
 target/sparc/cpu-qom.h         |  2 +-
 target/tilegx/cpu.h            |  2 +-
 target/tricore/cpu-qom.h       |  2 +-
 target/unicore32/cpu-qom.h     |  2 +-
 target/xtensa/cpu-qom.h        |  2 +-
 trace/control-vcpu.h           |  2 +-
 accel/tcg/user-exec-stub.c     |  2 +-
 arch_init.c                    | 11 ----------
 cpus-common.c                  |  2 +-
 exec.c                         |  2 +-
 hw/acpi/cpu_hotplug.c          |  2 +-
 hw/acpi/ich9.c                 |  2 +-
 hw/acpi/piix4.c                |  2 +-
 hw/arm/smmu-common.c           |  2 +-
 hw/arm/virt-acpi-build.c       |  2 +-
 {qom =3D> hw/core}/cpu.c         |  2 +-
 hw/core/generic-loader.c       |  2 +-
 hw/core/machine-qmp-cmds.c     | 10 +++++++++
 hw/core/null-machine.c         |  2 +-
 hw/core/numa.c                 |  2 +-
 hw/cpu/a9mpcore.c              |  2 +-
 hw/cpu/cluster.c               |  2 +-
 hw/i386/acpi-build.c           |  2 +-
 hw/i386/pc.c                   |  2 +-
 hw/intc/arm_gic.c              |  2 +-
 hw/intc/arm_gicv3_common.c     |  2 +-
 hw/isa/lpc_ich9.c              |  2 +-
 hw/misc/imx6_src.c             |  2 +-
 hw/ppc/spapr.c                 |  2 +-
 hw/timer/a9gtimer.c            |  2 +-
 hw/timer/arm_mptimer.c         |  2 +-
 monitor/hmp-cmds.c             | 19 -----------------
 monitor/qmp.c                  |  2 +-
 qdev-monitor.c                 | 18 ++++++++++++++++
 target/hppa/int_helper.c       |  2 +-
 target/hppa/mem_helper.c       |  2 +-
 MAINTAINERS                    |  6 ++----
 hw/core/Makefile.objs          |  1 +
 qom/Makefile.objs              |  1 -
 trace-events                   |  2 +-
 ui/cocoa.m                     |  2 +-
 70 files changed, 137 insertions(+), 143 deletions(-)
 rename include/{qom =3D> hw/core}/cpu.h (100%)
 rename {qom =3D> hw/core}/cpu.c (99%)

--=20
2.21.0


