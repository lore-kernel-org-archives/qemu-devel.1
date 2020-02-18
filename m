Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60860C34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 14:09:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DFE620722
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 14:09:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cvXK/IFo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DFE620722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j43Yr-0000oK-8w
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 09:09:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52709)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1j43Xe-0006pH-9z
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 09:08:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1j43Xc-0001Nn-S1
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 09:08:02 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:38843
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1j43Xc-0001NO-O3
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 09:08:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582034880;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=32S+yagRdJ0urv8w/F8UpR54cSuNCC7ndizWk6RWnBU=;
 b=cvXK/IFo2TDv7E6mPKm0OXRqYGpzmIWagkAWMe4zyvcUtPR6ZJrTCge180nqSc8N+Hhnj9
 xkxn/nnjf/olS2qZmZTg5VVYYMVzK7/3QhzM/cLiZy0H5spSerqBDQ8y4xLDfzXoS7GMX7
 vicW63/E5YfsPyBvQa5HwWnGzxAPAMg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-344-5HWmzbbIPzCIvWyBK0LXNw-1; Tue, 18 Feb 2020 09:07:52 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EF96F800D55;
 Tue, 18 Feb 2020 14:07:51 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-117-181.ams2.redhat.com
 [10.36.117.181])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EA0B88B54F;
 Tue, 18 Feb 2020 14:07:50 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 00/36] Block layer patches
Date: Tue, 18 Feb 2020 15:06:46 +0100
Message-Id: <20200218140722.23876-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: 5HWmzbbIPzCIvWyBK0LXNw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 6c599282f8ab382fe59f03a6cae755b89561a7b3=
:

  Merge remote-tracking branch 'remotes/armbru/tags/pull-monitor-2020-02-15=
-v2' into staging (2020-02-17 13:32:25 +0000)

are available in the Git repository at:

  git://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to c45a88f4429d7a8f384b75f3fd3fed5138a6edca:

  iotests: Check that @replaces can replace filters (2020-02-18 14:52:16 +0=
100)

----------------------------------------------------------------
Block layer patches:

- Fix check_to_replace_node()
- commit: Expose on-error option in QMP
- qcow2: Fix qcow2_alloc_cluster_abort() for external data file
- mirror: Fix deadlock
- vvfat: Fix segfault while closing read-write node
- Code cleanups

----------------------------------------------------------------
Alberto Garcia (1):
      qcow2: Fix alignment checks in encrypted images

Hikaru Nishida (1):
      block/vvfat: Do not unref qcow on closing backing bdrv

Kevin Wolf (12):
      mirror: Store MirrorOp.co for debuggability
      mirror: Don't let an operation wait for itself
      qcow2: update_refcount(): Reset old_table_index after qcow2_cache_put=
()
      qcow2: Fix qcow2_alloc_cluster_abort() for external data file
      iotests: Test copy offloading with external data file
      qapi: Document meaning of 'ignore' BlockdevOnError for jobs
      commit: Remove unused bytes_written
      commit: Fix argument order for block_job_error_action()
      commit: Inline commit_populate()
      commit: Fix is_read for block_job_error_action()
      commit: Expose on-error option in QMP
      iotests: Test error handling policies with block-commit

Max Reitz (19):
      blockdev: Allow external snapshots everywhere
      blockdev: Allow resizing everywhere
      block: Drop bdrv_is_first_non_filter()
      iotests: Let 041 use -blockdev for quorum children
      quorum: Fix child permissions
      block: Add bdrv_recurse_can_replace()
      blkverify: Implement .bdrv_recurse_can_replace()
      quorum: Implement .bdrv_recurse_can_replace()
      block: Use bdrv_recurse_can_replace()
      block: Remove bdrv_recurse_is_first_non_filter()
      mirror: Double-check immediately before replacing
      quorum: Stop marking it as a filter
      iotests: Use complete_and_wait() in 155
      iotests: Add VM.assert_block_path()
      iotests/041: Drop superfluous shutdowns
      iotests: Resolve TODOs in 041
      iotests: Use self.image_len in TestRepairQuorum
      iotests: Add tests for invalid Quorum @replaces
      iotests: Check that @replaces can replace filters

Philippe Mathieu-Daud=C3=A9 (3):
      block/qcow2-bitmap: Remove unneeded variable assignment
      block: Remove superfluous semicolons
      block/io_uring: Remove superfluous semicolon

 qapi/block-core.json          |   9 +-
 include/block/block.h         |   5 -
 include/block/block_int.h     |  16 +--
 block.c                       |  89 ++++++-------
 block/blkverify.c             |  20 +--
 block/commit.c                |  37 ++----
 block/copy-on-read.c          |   9 --
 block/filter-compress.c       |   9 --
 block/io_uring.c              |   2 +-
 block/mirror.c                |  37 ++++--
 block/qcow2-bitmap.c          |   1 -
 block/qcow2-cluster.c         |   7 +-
 block/qcow2-refcount.c        |   1 +
 block/qcow2-threads.c         |  12 +-
 block/qcow2.c                 |   2 -
 block/quorum.c                |  70 +++++++++--
 block/replication.c           |   7 --
 block/throttle.c              |   8 --
 block/vvfat.c                 |   7 --
 blockdev.c                    |  18 +--
 tests/qemu-iotests/iotests.py |  59 +++++++++
 tests/qemu-iotests/040        | 283 ++++++++++++++++++++++++++++++++++++++=
++++
 tests/qemu-iotests/040.out    |   4 +-
 tests/qemu-iotests/041        | 138 +++++++++++++++++---
 tests/qemu-iotests/041.out    |   4 +-
 tests/qemu-iotests/155        |   7 +-
 tests/qemu-iotests/244        |  14 +++
 tests/qemu-iotests/244.out    |   6 +
 28 files changed, 675 insertions(+), 206 deletions(-)


