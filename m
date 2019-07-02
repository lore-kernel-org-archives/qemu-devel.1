Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A296BC06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 11:47:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77E0A21473
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 11:47:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77E0A21473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiHFU-00054x-Mg
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 07:47:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34175)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hiHCX-0003zk-Df
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 07:43:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hiHCW-00065T-31
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 07:43:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32219)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hiHCT-0005un-BB
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 07:43:54 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5263281F0D
 for <qemu-devel@nongnu.org>; Tue,  2 Jul 2019 11:43:45 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-102.ams2.redhat.com
 [10.36.116.102])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F01D318226
 for <qemu-devel@nongnu.org>; Tue,  2 Jul 2019 11:43:44 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 64D011132ABF; Tue,  2 Jul 2019 13:43:43 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue,  2 Jul 2019 13:43:42 +0200
Message-Id: <20190702114343.21699-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Tue, 02 Jul 2019 11:43:45 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL v2 00/18] Monitor patches for 2019-07-02
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

The following changes since commit 7d0e02405fc02a181319b1ab8681d2f72246b7=
c6:

  Merge remote-tracking branch 'remotes/vivier2/tags/trivial-patches-pull=
-request' into staging (2019-07-01 17:40:32 +0100)

are available in the Git repository at:

  git://repo.or.cz/qemu/armbru.git tags/pull-monitor-2019-07-02-v2

for you to fetch changes up to 2608b3df8f9cd91baee9d04e246a0255dbb612db:

  dump: Move HMP command handlers to dump/ (2019-07-02 13:37:00 +0200)

----------------------------------------------------------------
Monitor patches for 2019-07-02

v2: Correct PATCH 7

----------------------------------------------------------------
Markus Armbruster (17):
      MAINTAINERS: Make section "QOM" cover qdev as well
      Makefile: Don't add monitor/ twice to common-obj-y
      hmp: Move hmp.h to include/monitor/
      qapi: Split qom.json and qdev.json off misc.json
      qom: Move QMP command handlers to qom/
      qom: Move HMP command handlers to qom/
      MAINTAINERS: Merge sections CPU, NUMA into Machine core
      qapi: Split machine.json off misc.json
      hw/core: Move numa.c to hw/core/
      hw/core: Collect QMP command handlers in hw/core/
      hw/core: Collect HMP command handlers in hw/core/
      qapi: Split machine-target.json off target.json and misc.json
      qapi: Rename target.json to misc-target.json
      qapi: Split dump.json off misc.json
      dump: Move the code to dump/
      MAINTAINERS: Add Windows dump to section "Dump"
      dump: Move HMP command handlers to dump/

Paolo Bonzini (1):
      MAINTAINERS: new maintainers for QOM

 MAINTAINERS                               |   36 +-
 Makefile.objs                             |    2 +-
 Makefile.target                           |    5 +-
 cpus.c                                    |  187 -----
 dump/Makefile.objs                        |    3 +
 dump/dump-hmp-cmds.c                      |   88 ++
 dump.c =3D> dump/dump.c                     |    4 +-
 win_dump.c =3D> dump/win_dump.c             |    0
 win_dump.h =3D> dump/win_dump.h             |    0
 hw/block/xen-block.c                      |    2 +-
 hw/core/Makefile.objs                     |    4 +
 hw/core/machine-hmp-cmds.c                |  164 ++++
 hw/core/machine-qmp-cmds.c                |  328 ++++++++
 numa.c =3D> hw/core/numa.c                  |   64 +-
 hw/core/qdev.c                            |    2 +-
 hw/ppc/spapr_rtc.c                        |    2 +-
 hw/s390x/s390-skeys.c                     |    2 +-
 hw/timer/mc146818rtc.c                    |    4 +-
 include/hw/boards.h                       |    1 +
 hmp.h =3D> include/monitor/hmp.h            |    4 +
 include/monitor/qdev.h                    |    1 -
 include/sysemu/dump.h                     |    2 +-
 include/sysemu/hostmem.h                  |    2 +-
 include/sysemu/numa.h                     |    2 +
 monitor/hmp-cmds.c                        |  238 +-----
 monitor/misc.c                            |   47 +-
 monitor/qmp-cmds.c                        |  315 +------
 qapi/Makefile.objs                        |    7 +-
 qapi/dump.json                            |  200 +++++
 qapi/{target.json =3D> machine-target.json} |  304 ++-----
 qapi/machine.json                         |  697 +++++++++++++++
 qapi/misc-target.json                     |  268 ++++++
 qapi/misc.json                            | 1304 -----------------------=
------
 qapi/qapi-schema.json                     |    7 +-
 qapi/qdev.json                            |  125 +++
 qapi/qom.json                             |  244 ++++++
 qdev-monitor.c                            |   59 +-
 qom/Makefile.objs                         |    1 +
 qom/qom-hmp-cmds.c                        |  120 +++
 qom/qom-qmp-cmds.c                        |  323 +++++++
 target/arm/helper.c                       |    2 +-
 target/arm/monitor.c                      |    2 +-
 target/i386/cpu.c                         |    4 +-
 target/i386/monitor.c                     |    2 +-
 target/i386/sev_i386.h                    |    2 +-
 target/mips/helper.c                      |    2 +-
 target/nios2/monitor.c                    |    2 +-
 target/ppc/monitor.c                      |    2 +-
 target/ppc/translate_init.inc.c           |    2 +-
 target/s390x/cpu.c                        |    2 +-
 target/s390x/cpu_models.c                 |    2 +-
 target/s390x/sigp.c                       |    2 +-
 target/sh4/monitor.c                      |    2 +-
 target/sparc/monitor.c                    |    2 +-
 target/xtensa/monitor.c                   |    2 +-
 vl.c                                      |   45 -
 56 files changed, 2695 insertions(+), 2550 deletions(-)
 create mode 100644 dump/Makefile.objs
 create mode 100644 dump/dump-hmp-cmds.c
 rename dump.c =3D> dump/dump.c (99%)
 rename win_dump.c =3D> dump/win_dump.c (100%)
 rename win_dump.h =3D> dump/win_dump.h (100%)
 create mode 100644 hw/core/machine-hmp-cmds.c
 create mode 100644 hw/core/machine-qmp-cmds.c
 rename numa.c =3D> hw/core/numa.c (90%)
 rename hmp.h =3D> include/monitor/hmp.h (98%)
 create mode 100644 qapi/dump.json
 rename qapi/{target.json =3D> machine-target.json} (61%)
 create mode 100644 qapi/machine.json
 create mode 100644 qapi/misc-target.json
 create mode 100644 qapi/qdev.json
 create mode 100644 qapi/qom.json
 create mode 100644 qom/qom-hmp-cmds.c
 create mode 100644 qom/qom-qmp-cmds.c

--=20
2.21.0


