Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2230C3A59D
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 23:16:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C617D206C2
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 23:16:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C617D206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hylRv-0000ce-69
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 19:15:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46048)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1hylPY-0006BA-JQ
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 19:13:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1hylPX-0005hA-2g
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 19:13:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53678)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>)
 id 1hylPT-0005bo-DG; Fri, 16 Aug 2019 19:13:27 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AFFEA800DE1;
 Fri, 16 Aug 2019 23:13:22 +0000 (UTC)
Received: from probe.bos.redhat.com (dhcp-17-187.bos.redhat.com [10.18.17.187])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AAE0C19C6A;
 Fri, 16 Aug 2019 23:13:18 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 16 Aug 2019 19:12:42 -0400
Message-Id: <20190816231318.8650-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.67]); Fri, 16 Aug 2019 23:13:22 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 00/36] Bitmaps patches
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
Cc: peter.maydell@linaro.org, jsnow@redhat.com, qemu-stable@nongnu.org,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit afd760539308a5524accf964107cdb1d54a059=
e3:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-201=
90816' into staging (2019-08-16 17:21:40 +0100)

are available in the Git repository at:

  https://github.com/jnsnow/qemu.git tags/bitmaps-pull-request

for you to fetch changes up to a5f8a60b3eafd5563af48546d5d126d448e62ac5:

  tests/test-hbitmap: test next_zero and _next_dirty_area after truncate =
(2019-08-16 18:29:43 -0400)

----------------------------------------------------------------
Pull request

Rebase notes:

011/36:[0003] [FC] 'block/backup: upgrade copy_bitmap to BdrvDirtyBitmap'
016/36:[----] [-C] 'iotests: Add virtio-scsi device helper'
017/36:[0002] [FC] 'iotests: add test 257 for bitmap-mode backups'
030/36:[0011] [FC] 'block/backup: teach TOP to never copy unallocated reg=
ions'
032/36:[0018] [FC] 'iotests/257: test traditional sync modes'

11: A new hbitmap call was added late in 4.1, changed to
    bdrv_dirty_bitmap_next_zero.
16: Context-only (self.has_quit is new context in 040)
17: Removed 'auto' to follow upstream trends in iotest fashion
30: Handled explicitly on-list with R-B from Max.
32: Fix capitalization in test, as mentioned on-list.

----------------------------------------------------------------

John Snow (30):
  qapi/block-core: Introduce BackupCommon
  drive-backup: create do_backup_common
  blockdev-backup: utilize do_backup_common
  qapi: add BitmapSyncMode enum
  block/backup: Add mirror sync mode 'bitmap'
  block/backup: add 'never' policy to bitmap sync mode
  hbitmap: Fix merge when b is empty, and result is not an alias of a
  hbitmap: enable merging across granularities
  block/dirty-bitmap: add bdrv_dirty_bitmap_merge_internal
  block/dirty-bitmap: add bdrv_dirty_bitmap_get
  block/backup: upgrade copy_bitmap to BdrvDirtyBitmap
  block/backup: add 'always' bitmap sync policy
  iotests: add testing shim for script-style python tests
  iotests: teach run_job to cancel pending jobs
  iotests: teach FilePath to produce multiple paths
  iotests: Add virtio-scsi device helper
  iotests: add test 257 for bitmap-mode backups
  block/backup: loosen restriction on readonly bitmaps
  qapi: implement block-dirty-bitmap-remove transaction action
  iotests/257: add Pattern class
  iotests/257: add EmulatedBitmap class
  iotests/257: Refactor backup helpers
  block/backup: hoist bitmap check into QMP interface
  iotests/257: test API failures
  block/backup: improve sync=3Dbitmap work estimates
  block/backup: centralize copy_bitmap initialization
  block/backup: add backup_is_cluster_allocated
  block/backup: teach TOP to never copy unallocated regions
  block/backup: support bitmap sync modes for non-bitmap backups
  iotests/257: test traditional sync modes

Vladimir Sementsov-Ogievskiy (6):
  blockdev: reduce aio_context locked sections in bitmap add/remove
  iotests: test bitmap moving inside 254
  qapi: add dirty-bitmaps to query-named-block-nodes result
  block/backup: deal with zero detection
  block/backup: refactor write_flags
  tests/test-hbitmap: test next_zero and _next_dirty_area after truncate

 block.c                        |    2 +-
 block/backup.c                 |  312 +-
 block/dirty-bitmap.c           |   88 +-
 block/mirror.c                 |    8 +-
 block/qapi.c                   |    5 +
 block/replication.c            |    2 +-
 block/trace-events             |    1 +
 blockdev.c                     |  353 ++-
 include/block/block_int.h      |    7 +-
 include/block/dirty-bitmap.h   |    6 +-
 migration/block-dirty-bitmap.c |    2 +-
 migration/block.c              |    5 +-
 nbd/server.c                   |    2 +-
 qapi/block-core.json           |  146 +-
 qapi/transaction.json          |    2 +
 qemu-deprecated.texi           |   12 +
 tests/qemu-iotests/040         |    6 +-
 tests/qemu-iotests/093         |    6 +-
 tests/qemu-iotests/139         |    7 +-
 tests/qemu-iotests/238         |    5 +-
 tests/qemu-iotests/254         |   30 +-
 tests/qemu-iotests/254.out     |   82 +
 tests/qemu-iotests/256.out     |    4 +-
 tests/qemu-iotests/257         |  560 ++++
 tests/qemu-iotests/257.out     | 5421 ++++++++++++++++++++++++++++++++
 tests/qemu-iotests/group       |    1 +
 tests/qemu-iotests/iotests.py  |  102 +-
 tests/test-hbitmap.c           |   22 +
 util/hbitmap.c                 |   49 +-
 29 files changed, 6843 insertions(+), 405 deletions(-)
 create mode 100755 tests/qemu-iotests/257
 create mode 100644 tests/qemu-iotests/257.out

--=20
2.21.0


