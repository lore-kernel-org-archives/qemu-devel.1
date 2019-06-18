Return-Path: <SRS0=M8fn=UR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8E47C31E51
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 06:29:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5754F2166E
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 06:29:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5754F2166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54066 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hd7cs-0004R0-64
	for qemu-devel@archiver.kernel.org; Tue, 18 Jun 2019 02:29:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39774)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hd7Zu-0003Dy-2Y
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 02:26:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hd7Zs-0005vt-Bf
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 02:26:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34050)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hd7Zs-0005vB-4O
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 02:26:44 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 369D2308A963
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2019 06:26:43 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-177.ams2.redhat.com
 [10.36.117.177])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 069647E5DC
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2019 06:26:43 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8E6E911386A6; Tue, 18 Jun 2019 08:26:41 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 18 Jun 2019 08:26:40 +0200
Message-Id: <20190618062641.32214-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Tue, 18 Jun 2019 06:26:43 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL v2 00/16] Monitor patches for 2019-06-17
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

The following changes since commit 076243ffe6c1b687e9e6d98348c3bf3398df78=
f3:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-docs-20190617'=
 into staging (2019-06-17 16:41:25 +0100)

are available in the Git repository at:

  git://repo.or.cz/qemu/armbru.git tags/pull-monitor-2019-06-17-v2

for you to fetch changes up to 3c45f62570aeacadf4a05bfa1afaa12bea05ae86:

  vl: Deprecate -mon pretty=3D... for HMP monitors (2019-06-18 08:14:17 +=
0200)

----------------------------------------------------------------
Monitor patches for 2019-06-17

----------------------------------------------------------------
Kevin Wolf (15):
      monitor: Remove unused password prompting fields
      monitor: Split monitor_init in HMP and QMP function
      monitor: Make MonitorQMP a child class of Monitor
      monitor: Create MonitorHMP with readline state
      monitor: Remove Monitor.cmd_table indirection
      monitor: Rename HMP command type and tables
      Move monitor.c to monitor/misc.c
      monitor: Move {hmp, qmp}.c to monitor/{hmp, qmp}-cmds.c
      monitor: Create monitor-internal.h with common definitions
      monitor: Split out monitor/qmp.c
      monitor: Split out monitor/hmp.c
      monitor: Split out monitor/monitor.c
      monitor: Split Monitor.flags into separate bools
      monitor: Replace monitor_init() with monitor_init_{hmp, qmp}()
      vl: Deprecate -mon pretty=3D... for HMP monitors

Yury Kotov (1):
      monitor: Fix return type of monitor_fdset_dup_fd_find

 MAINTAINERS                         |   13 +-
 Makefile.objs                       |    4 +-
 Makefile.target                     |    3 +-
 chardev/char.c                      |    2 +-
 docs/devel/writing-qmp-commands.txt |   11 +-
 gdbstub.c                           |    2 +-
 hmp-commands.hx                     |    2 +-
 include/monitor/monitor.h           |   17 +-
 monitor.c                           | 4729 -----------------------------=
------
 monitor/Makefile.objs               |    3 +
 hmp.c =3D> monitor/hmp-cmds.c         |    7 +-
 monitor/hmp.c                       | 1417 +++++++++++
 monitor/misc.c                      | 2353 +++++++++++++++++
 monitor/monitor-internal.h          |  183 ++
 monitor/monitor.c                   |  628 +++++
 qmp.c =3D> monitor/qmp-cmds.c         |    2 +-
 monitor/qmp.c                       |  404 +++
 monitor/trace-events                |   15 +
 qemu-deprecated.texi                |    6 +
 stubs/fdset.c                       |    2 +-
 stubs/monitor.c                     |    6 +-
 tests/test-util-sockets.c           |    3 +-
 trace-events                        |   10 -
 vl.c                                |   28 +-
 24 files changed, 5073 insertions(+), 4777 deletions(-)
 delete mode 100644 monitor.c
 create mode 100644 monitor/Makefile.objs
 rename hmp.c =3D> monitor/hmp-cmds.c (99%)
 create mode 100644 monitor/hmp.c
 create mode 100644 monitor/misc.c
 create mode 100644 monitor/monitor-internal.h
 create mode 100644 monitor/monitor.c
 rename qmp.c =3D> monitor/qmp-cmds.c (99%)
 create mode 100644 monitor/qmp.c
 create mode 100644 monitor/trace-events

--=20
2.21.0


