Return-Path: <SRS0=2W3W=T4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE827C04AB6
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 19:31:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD453208C3
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 19:31:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD453208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41517 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVhos-0001qb-If
	for qemu-devel@archiver.kernel.org; Tue, 28 May 2019 15:31:34 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36595)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hVhml-0000W1-Ix
	for qemu-devel@nongnu.org; Tue, 28 May 2019 15:29:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hVhmW-0000M7-DS
	for qemu-devel@nongnu.org; Tue, 28 May 2019 15:29:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53398)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hVhmJ-0008SS-70; Tue, 28 May 2019 15:28:56 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6308AC0578F8;
	Tue, 28 May 2019 19:28:49 +0000 (UTC)
Received: from localhost (unknown [10.40.205.223])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id E9B0C611B4;
	Tue, 28 May 2019 19:28:48 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Tue, 28 May 2019 21:28:26 +0200
Message-Id: <20190528192847.2730-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.31]);
	Tue, 28 May 2019 19:28:49 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 00/21] Block patches
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 8c1ecb590497b0349c550607db923972b37f69=
63:

  Merge remote-tracking branch 'remotes/stsquad/tags/pull-testing-next-28=
0519-2' into staging (2019-05-28 17:38:32 +0100)

are available in the Git repository at:

  https://github.com/XanClic/qemu.git tags/pull-block-2019-05-28

for you to fetch changes up to a2d665c1bc3624a8375e2f9a7d569f7565cc1358:

  blockdev: loosen restrictions on drive-backup source node (2019-05-28 2=
0:30:55 +0200)

----------------------------------------------------------------
Block patches:
- qcow2: Use threads for encrypted I/O
- qemu-img rebase: Optimizations
- backup job: Allow any source node, and some refactoring
- Some general simplifications in the block layer

----------------------------------------------------------------
Alberto Garcia (2):
  block: Use bdrv_unref_child() for all children in bdrv_close()
  block: Make bdrv_root_attach_child() unref child_bs on failure

Andrey Shinkevich (1):
  qcow2-bitmap: initialize bitmap directory alignment

Anton Nefedov (1):
  qcow2: skip writing zero buffers to empty COW areas

John Snow (1):
  blockdev: loosen restrictions on drive-backup source node

Sam Eiderman (3):
  qemu-img: rebase: Reuse parent BlockDriverState
  qemu-img: rebase: Reduce reads on in-chain rebase
  qemu-img: rebase: Reuse in-chain BlockDriverState

Vladimir Sementsov-Ogievskiy (13):
  qcow2.h: add missing include
  qcow2: add separate file for threaded data processing functions
  qcow2-threads: use thread_pool_submit_co
  qcow2-threads: qcow2_co_do_compress: protect queuing by mutex
  qcow2-threads: split out generic path
  qcow2: qcow2_co_preadv: improve locking
  qcow2: bdrv_co_pwritev: move encryption code out of the lock
  qcow2: do encryption in threads
  block/backup: simplify backup_incremental_init_copy_bitmap
  block/backup: move to copy_bitmap with granularity
  block/backup: refactor and tolerate unallocated cluster skipping
  block/backup: unify different modes code path
  block/backup: refactor: split out backup_calculate_cluster_size

 block/Makefile.objs         |   2 +-
 qapi/block-core.json        |   4 +-
 block/qcow2.h               |  26 ++-
 block.c                     |  46 +++---
 block/backup.c              | 243 ++++++++++++---------------
 block/block-backend.c       |   3 +-
 block/qcow2-bitmap.c        |   3 +-
 block/qcow2-cache.c         |   1 -
 block/qcow2-cluster.c       |  10 +-
 block/qcow2-refcount.c      |   1 -
 block/qcow2-snapshot.c      |   1 -
 block/qcow2-threads.c       | 268 ++++++++++++++++++++++++++++++
 block/qcow2.c               | 320 +++++++++++++-----------------------
 block/quorum.c              |   1 -
 blockdev.c                  |   7 +-
 blockjob.c                  |   2 +-
 qemu-img.c                  |  85 ++++++----
 tests/test-bdrv-drain.c     |   6 -
 tests/test-bdrv-graph-mod.c |   1 -
 block/trace-events          |   1 +
 tests/qemu-iotests/056      |   2 +-
 tests/qemu-iotests/060      |   7 +-
 tests/qemu-iotests/060.out  |   5 +-
 23 files changed, 615 insertions(+), 430 deletions(-)
 create mode 100644 block/qcow2-threads.c

--=20
2.21.0


