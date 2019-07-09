Return-Path: <SRS0=huOX=VG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E8FAC73C53
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 15:25:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3773C21537
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 15:25:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3773C21537
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hks0C-00064m-BN
	for qemu-devel@archiver.kernel.org; Tue, 09 Jul 2019 11:25:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43320)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hkrvZ-0001Un-74
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 11:21:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hkrvX-00071O-7p
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 11:21:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48638)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hkrvV-000706-6Y
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 11:21:07 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0BB1230ADC80;
 Tue,  9 Jul 2019 15:20:56 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-111.ams2.redhat.com
 [10.36.116.111])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CECB084904;
 Tue,  9 Jul 2019 15:20:54 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6378E1138648; Tue,  9 Jul 2019 17:20:53 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue,  9 Jul 2019 17:20:51 +0200
Message-Id: <20190709152053.16670-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Tue, 09 Jul 2019 15:20:58 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 0/2] Move some machine core code to proper
 places
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
Cc: ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a follow-up to my "Move QOM, qdev, machine core and dump code"
series, merged in commit 374f63f6810.

Markus Armbruster (2):
  hw/core: Move cpu.c, cpu.h from qom/ to hw/core/
  qapi: Move query-target from misc.json to machine.json

 MAINTAINERS                    |  6 ++---
 accel/tcg/user-exec-stub.c     |  2 +-
 arch_init.c                    | 11 --------
 cpus-common.c                  |  2 +-
 docs/interop/firmware.json     |  2 +-
 hw/acpi/cpu_hotplug.c          |  2 +-
 hw/acpi/piix4.c                |  2 +-
 hw/arm/smmu-common.c           |  2 +-
 hw/arm/virt-acpi-build.c       |  2 +-
 hw/core/Makefile.objs          |  1 +
 {qom =3D> hw/core}/cpu.c         |  2 +-
 hw/core/generic-loader.c       |  2 +-
 hw/core/machine-qmp-cmds.c     | 10 +++++++
 hw/core/null-machine.c         |  2 +-
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
 include/exec/cpu-all.h         |  2 +-
 include/exec/cpu-defs.h        |  2 +-
 include/exec/log.h             |  2 +-
 include/hw/boards.h            |  2 +-
 include/{qom =3D> hw/core}/cpu.h |  0
 include/hw/ppc/openpic.h       |  2 +-
 include/sysemu/hw_accel.h      |  2 +-
 include/sysemu/kvm.h           |  2 +-
 qapi/common.json               | 25 ------------------
 qapi/machine.json              | 48 +++++++++++++++++++++++++++++++++-
 qapi/misc.json                 | 23 ----------------
 qom/Makefile.objs              |  1 -
 target/alpha/cpu-qom.h         |  2 +-
 target/arm/cpu-qom.h           |  2 +-
 target/cris/cpu-qom.h          |  2 +-
 target/hppa/cpu-qom.h          |  2 +-
 target/hppa/int_helper.c       |  2 +-
 target/hppa/mem_helper.c       |  2 +-
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
 trace/control-internal.h       |  2 +-
 ui/cocoa.m                     |  2 +-
 63 files changed, 114 insertions(+), 119 deletions(-)
 rename {qom =3D> hw/core}/cpu.c (99%)
 rename include/{qom =3D> hw/core}/cpu.h (100%)

--=20
2.21.0


