Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 604C9C32771
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 06:14:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34B4120673
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 06:14:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34B4120673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipR53-0006sT-AG
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 01:14:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40540)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dovgaluk@ispras.ru>) id 1ipR4J-0006EQ-Tx
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 01:13:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dovgaluk@ispras.ru>) id 1ipR4G-0007qq-VO
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 01:13:19 -0500
Received: from mail.ispras.ru ([83.149.199.45]:53844)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <dovgaluk@ispras.ru>) id 1ipR4G-0007el-G3
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 01:13:16 -0500
Received: from PASHAISP (unknown [85.142.117.226])
 by mail.ispras.ru (Postfix) with ESMTPSA id 07925A2201;
 Thu,  9 Jan 2020 09:13:11 +0300 (MSK)
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
To: "'Pavel Dovgalyuk'" <pavel.dovgaluk@gmail.com>,
	<qemu-devel@nongnu.org>
References: <157709434917.12933.4351155074716553976.stgit@pasha-Precision-3630-Tower>
In-Reply-To: <157709434917.12933.4351155074716553976.stgit@pasha-Precision-3630-Tower>
Subject: RE: [for-5.0 PATCH 00/11] Support for reverse debugging with GDB
Date: Thu, 9 Jan 2020 09:13:11 +0300
Message-ID: <003a01d5c6b3$df62afd0$9e280f70$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Thread-Index: AdW5dchLWdUIxCsjSTynAOt3PgDYHANPhEXQ
Content-Language: ru
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 83.149.199.45
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, pavel.dovgaluk@ispras.ru,
 quintela@redhat.com, ciro.santilli@gmail.com, jasowang@redhat.com,
 crosthwaite.peter@gmail.com, armbru@redhat.com, mreitz@redhat.com,
 alex.bennee@linaro.org, maria.klimushenkova@ispras.ru, mst@redhat.com,
 kraxel@redhat.com, boost.lists@gmail.com, thomas.dullien@googlemail.com,
 pbonzini@redhat.com, artem.k.pisarenko@gmail.com, dgilbert@redhat.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Ping.



Pavel Dovgalyuk

> -----Original Message-----
> From: Pavel Dovgalyuk [mailto:pavel.dovgaluk@gmail.com]
> Sent: Monday, December 23, 2019 12:46 PM
> To: qemu-devel@nongnu.org
> Cc: kwolf@redhat.com; peter.maydell@linaro.org; crosthwaite.peter@gmail.com;
> boost.lists@gmail.com; artem.k.pisarenko@gmail.com; quintela@redhat.com;
> ciro.santilli@gmail.com; jasowang@redhat.com; mst@redhat.com; armbru@redhat.com;
> mreitz@redhat.com; maria.klimushenkova@ispras.ru; dovgaluk@ispras.ru; kraxel@redhat.com;
> pavel.dovgaluk@ispras.ru; thomas.dullien@googlemail.com; pbonzini@redhat.com;
> alex.bennee@linaro.org; dgilbert@redhat.com; rth@twiddle.net
> Subject: [for-5.0 PATCH 00/11] Support for reverse debugging with GDB
> 
> GDB remote protocol supports reverse debugging of the targets.
> It includes 'reverse step' and 'reverse continue' operations.
> The first one finds the previous step of the execution,
> and the second one is intended to stop at the last breakpoint that
> would happen when the program is executed normally.
> 
> Reverse debugging is possible in the replay mode, when at least
> one snapshot was created at the record or replay phase.
> QEMU can use these snapshots for travelling back in time with GDB.
> 
> Running the execution in replay mode allows using GDB reverse debugging
> commands:
>  - reverse-stepi (or rsi): Steps one instruction to the past.
>    QEMU loads on of the prior snapshots and proceeds to the desired
>    instruction forward. When that step is reaches, execution stops.
>  - reverse-continue (or rc): Runs execution "backwards".
>    QEMU tries to find breakpoint or watchpoint by loaded prior snapshot
>    and replaying the execution. Then QEMU loads snapshots again and
>    replays to the latest breakpoint. When there are no breakpoints in
>    the examined section of the execution, QEMU finds one more snapshot
>    and tries again. After the first snapshot is processed, execution
>    stops at this snapshot.
> 
> The set of patches include the following modifications:
>  - gdbstub update for reverse debugging support
>  - functions that automatically perform reverse step and reverse
>    continue operations
>  - hmp/qmp commands for manipulating the replay process
>  - improvement of the snapshotting for saving the execution step
>    in the snapshot parameters
> 
> The patches are available in the repository:
> https://github.com/ispras/qemu/tree/rr-191223
> 
> ---
> 
> Pavel Dovgaluk (11):
>       replay: provide an accessor for rr filename
>       qcow2: introduce icount field for snapshots
>       migration: introduce icount field for snapshots
>       qapi: introduce replay.json for record/replay-related stuff
>       replay: introduce info hmp/qmp command
>       replay: introduce breakpoint at the specified step
>       replay: implement replay-seek command
>       replay: flush rr queue before loading the vmstate
>       gdbstub: add reverse step support in replay mode
>       gdbstub: add reverse continue support in replay mode
>       replay: describe reverse debugging in docs/replay.txt
> 
> 
>  MAINTAINERS               |    1
>  accel/tcg/translator.c    |    1
>  block/qapi.c              |   18 ++
>  block/qcow2-snapshot.c    |    9 +
>  block/qcow2.h             |    3
>  blockdev.c                |   10 +
>  cpus.c                    |   19 ++-
>  docs/interop/qcow2.txt    |    4 +
>  docs/replay.txt           |   33 +++++
>  exec.c                    |    8 +
>  gdbstub.c                 |   64 ++++++++-
>  hmp-commands-info.hx      |   14 ++
>  hmp-commands.hx           |   53 +++++++
>  include/block/snapshot.h  |    1
>  include/monitor/hmp.h     |    4 +
>  include/sysemu/replay.h   |   24 +++
>  migration/savevm.c        |   17 ++
>  qapi/Makefile.objs        |    2
>  qapi/block-core.json      |    8 +
>  qapi/block.json           |    3
>  qapi/misc.json            |   18 --
>  qapi/qapi-schema.json     |    1
>  qapi/replay.json          |  121 +++++++++++++++++
>  replay/Makefile.objs      |    1
>  replay/replay-debugging.c |  325 +++++++++++++++++++++++++++++++++++++++++++++
>  replay/replay-internal.h  |    6 +
>  replay/replay.c           |   22 +++
>  stubs/replay.c            |   10 +
>  28 files changed, 761 insertions(+), 39 deletions(-)
>  create mode 100644 qapi/replay.json
>  create mode 100644 replay/replay-debugging.c
> 
> --
> Pavel Dovgalyuk


