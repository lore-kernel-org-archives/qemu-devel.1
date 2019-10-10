Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D2B4C10F14
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 12:07:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D638D20650
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 12:07:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D638D20650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIXEN-0007dL-Ec
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 08:07:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51526)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iIWqd-00067K-BM
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 07:43:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iIWqb-00082Q-Oe
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 07:43:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52624)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iIWqV-00080s-A8; Thu, 10 Oct 2019 07:43:03 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 89E403060396;
 Thu, 10 Oct 2019 11:43:02 +0000 (UTC)
Received: from localhost (unknown [10.36.118.5])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 29417600C4;
 Thu, 10 Oct 2019 11:43:02 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 00/36] Block patches
Date: Thu, 10 Oct 2019 13:42:24 +0200
Message-Id: <20191010114300.7746-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Thu, 10 Oct 2019 11:43:02 +0000 (UTC)
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 98b2e3c9ab3abfe476a2b02f8f51813edb90e7=
2d:

  Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request'=
 into staging (2019-10-08 16:08:35 +0100)

are available in the Git repository at:

  https://github.com/XanClic/qemu.git tags/pull-block-2019-10-10

for you to fetch changes up to 35f05b2e2ee59e077bf949057dc0959ddd6e5249:

  iotests/162: Fix for newer Linux 5.3+ (2019-10-10 12:13:23 +0200)

----------------------------------------------------------------
Block patches:
- Parallelized request handling for qcow2
- Backup job refactoring to use a filter node instead of before-write
  notifiers
- Add discard accounting information to file-posix nodes
- Allow trivial reopening of nbd nodes
- Some iotest fixes

----------------------------------------------------------------
Anton Nefedov (9):
  qapi: group BlockDeviceStats fields
  qapi: add unmap to BlockDeviceStats
  block: add empty account cookie type
  ide: account UNMAP (TRIM) operations
  scsi: store unmap offset and nb_sectors in request struct
  scsi: move unmap error checking to the complete callback
  scsi: account unmap operations
  file-posix: account discard operations
  qapi: query-blockstat: add driver specific file-posix stats

Daniel P. Berrang=C3=A9 (1):
  tests: fix I/O test for hosts defaulting to LUKSv2

Max Reitz (4):
  iotests: Fix 125 for growth_mode =3D metadata
  iotests: Disable 125 on broken XFS versions
  iotests: Use stat -c %b in 125
  iotests/162: Fix for newer Linux 5.3+

Maxim Levitsky (1):
  nbd: add empty .bdrv_reopen_prepare

Vladimir Sementsov-Ogievskiy (21):
  qemu-iotests: ignore leaks on failure paths in 026
  block: introduce aio task pool
  block/qcow2: refactor qcow2_co_preadv_part
  block/qcow2: refactor qcow2_co_pwritev_part
  block/qcow2: introduce parallel subrequest handling in read and write
  block/backup: fix max_transfer handling for copy_range
  block/backup: fix backup_cow_with_offload for last cluster
  block/backup: split shareable copying part from backup_do_cow
  block/backup: improve comment about image fleecing
  block/backup: introduce BlockCopyState
  block/backup: fix block-comment style
  block: move block_copy from block/backup.c to separate file
  block: teach bdrv_debug_breakpoint skip filters with backing
  iotests: prepare 124 and 257 bitmap querying for backup-top filter
  iotests: 257: drop unused Drive.device field
  iotests: 257: drop device_add
  block/backup: move in-flight requests handling from backup to
    block-copy
  block/backup: move write_flags calculation inside backup_job_create
  block/block-copy: split block_copy_set_callbacks function
  block: introduce backup-top filter driver
  block/backup: use backup-top instead of write notifiers

 block/Makefile.objs                |   4 +
 qapi/block-core.json               |  89 +++-
 block/backup-top.h                 |  41 ++
 block/qcow2.h                      |   3 +
 include/block/accounting.h         |   2 +
 include/block/aio_task.h           |  54 +++
 include/block/block-copy.h         |  93 ++++
 include/block/block.h              |   1 +
 include/block/block_int.h          |   2 +
 block.c                            |  43 +-
 block/accounting.c                 |   6 +
 block/aio_task.c                   | 124 +++++
 block/backup-top.c                 | 276 +++++++++++
 block/backup.c                     | 443 ++++--------------
 block/block-copy.c                 | 345 ++++++++++++++
 block/file-posix.c                 |  54 ++-
 block/nbd.c                        |  15 +
 block/qapi.c                       |  11 +
 block/qcow2.c                      | 466 ++++++++++++-------
 block/replication.c                |   2 +-
 blockdev.c                         |   1 +
 hw/ide/core.c                      |  12 +
 hw/scsi/scsi-disk.c                |  34 +-
 block/trace-events                 |  15 +-
 tests/qemu-iotests/026             |   6 +-
 tests/qemu-iotests/026.out         |  80 +---
 tests/qemu-iotests/026.out.nocache |  80 +---
 tests/qemu-iotests/056             |   8 +-
 tests/qemu-iotests/124             |  83 ++--
 tests/qemu-iotests/125             |  45 +-
 tests/qemu-iotests/141.out         |   2 +-
 tests/qemu-iotests/149             |   2 +-
 tests/qemu-iotests/149.out         |  44 +-
 tests/qemu-iotests/162             |   2 +-
 tests/qemu-iotests/162.out         |   2 +-
 tests/qemu-iotests/227.out         |  18 +
 tests/qemu-iotests/257             |  91 ++--
 tests/qemu-iotests/257.out         | 714 ++++++++++++-----------------
 tests/qemu-iotests/common.rc       |  17 +
 tests/qemu-iotests/iotests.py      |  27 ++
 40 files changed, 2108 insertions(+), 1249 deletions(-)
 create mode 100644 block/backup-top.h
 create mode 100644 include/block/aio_task.h
 create mode 100644 include/block/block-copy.h
 create mode 100644 block/aio_task.c
 create mode 100644 block/backup-top.c
 create mode 100644 block/block-copy.c

--=20
2.21.0


