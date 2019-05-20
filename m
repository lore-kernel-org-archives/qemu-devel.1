Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAACEC04AAC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 16:17:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5327214DA
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 16:17:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5327214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38025 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSkyr-0001PW-W6
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 12:17:42 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38278)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hSkwn-0008Ag-Bw
	for qemu-devel@nongnu.org; Mon, 20 May 2019 12:15:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hSkwm-0003Tt-81
	for qemu-devel@nongnu.org; Mon, 20 May 2019 12:15:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35661)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>)
	id 1hSkwe-0003G1-Ey; Mon, 20 May 2019 12:15:26 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E912E308FF30;
	Mon, 20 May 2019 16:14:57 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-117-208.ams2.redhat.com
	[10.36.117.208])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0E70CD1E4;
	Mon, 20 May 2019 16:14:56 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Date: Mon, 20 May 2019 18:14:29 +0200
Message-Id: <20190520161453.30723-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.49]);
	Mon, 20 May 2019 16:14:57 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 00/24] Block layer patches
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 6d8e75d41c58892ccc5d4ad61c4da476684c1c=
83:

  Merge remote-tracking branch 'remotes/rth/tags/pull-axp-20190519' into =
staging (2019-05-20 11:38:36 +0100)

are available in the Git repository at:

  git://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to c423a6af592cf36b4f149c54e2966dd0016b7e96:

  iotests: Make 245 faster and more reliable (2019-05-20 17:08:57 +0200)

----------------------------------------------------------------
Block layer patches:

- block: AioContext management, part 1
- qmp: forbid qmp_cont in RUN_STATE_FINISH_MIGRATE
- nvme: fix copy direction in DMA reads going to CMB
- file-posix: Fix block status for unaligned raw images with O_DIRECT
- file-posix: Fix xfs_write_zeroes() after EOF
- Documentation and iotests improvements

----------------------------------------------------------------
Alberto Garcia (2):
      qcow2: Define and use QCOW2_COMPRESSED_SECTOR_SIZE
      block: Use BDRV_REQUEST_MAX_BYTES instead of BDRV_REQUEST_MAX_SECTO=
RS

Kevin Wolf (10):
      block: Add bdrv_try_set_aio_context()
      block: Make bdrv_attach/detach_aio_context() static
      block: Move recursion to bdrv_set_aio_context()
      block: Propagate AioContext change to parents
      test-block-iothread: Test AioContext propagation through the tree
      block: Implement .(can_)set_aio_ctx for BlockBackend
      block: Add blk_set_allow_aio_context_change()
      blockjob: Propagate AioContext change to all job nodes
      blockjob: Remove AioContext notifiers
      test-block-iothread: Test AioContext propagation for block jobs

Klaus Birkelund Jensen (1):
      nvme: fix copy direction in DMA reads going to CMB

Max Reitz (9):
      block/file-posix: Truncate in xfs_write_zeroes()
      block/file-posix: Unaligned O_DIRECT block-status
      iotests: Test unaligned raw images with O_DIRECT
      qemu-img.texi: Be specific about JSON object types
      qemu-img.texi: Describe human-readable info output
      block: Improve "Block node is read-only" message
      iotests.py: Let assert_qmp() accept an array
      iotests.py: Fix VM.run_job
      iotests: Make 245 faster and more reliable

Vladimir Sementsov-Ogievskiy (2):
      qmp: forbid qmp_cont in RUN_STATE_FINISH_MIGRATE
      iotest: fix 169: do not run qmp_cont in RUN_STATE_FINISH_MIGRATE

 block/qcow2.h                  |   4 +
 include/block/block.h          |  10 ++
 include/block/block_int.h      |  25 +----
 include/sysemu/block-backend.h |   1 +
 block.c                        | 174 +++++++++++++++++++++++++++++++----
 block/backup.c                 |   8 --
 block/block-backend.c          |  55 ++++++++++-
 block/file-posix.c             |  29 ++++++
 block/io.c                     |   6 +-
 block/mirror.c                 |  10 +-
 block/qcow2-cluster.c          |   5 +-
 block/qcow2-refcount.c         |  25 ++---
 block/qcow2.c                  |   3 +-
 blockjob.c                     |  77 ++++++++--------
 hw/block/nvme.c                |   2 +-
 qemu-io-cmds.c                 |   7 +-
 qmp.c                          |   3 +
 tests/test-block-iothread.c    | 202 +++++++++++++++++++++++++++++++++++=
++++++
 qemu-img.texi                  |  52 ++++++++++-
 tests/qemu-iotests/169         |   7 +-
 tests/qemu-iotests/221         |   4 +
 tests/qemu-iotests/245         |  22 +++--
 tests/qemu-iotests/245.out     |  12 +++
 tests/qemu-iotests/253         |  84 +++++++++++++++++
 tests/qemu-iotests/253.out     |  14 +++
 tests/qemu-iotests/group       |   1 +
 tests/qemu-iotests/iotests.py  |  20 +++-
 27 files changed, 728 insertions(+), 134 deletions(-)
 create mode 100755 tests/qemu-iotests/253
 create mode 100644 tests/qemu-iotests/253.out

