Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 347AFC3A59C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 09:37:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 086BB206C1
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 09:37:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 086BB206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyYfL-0001ix-W8
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 05:37:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59376)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1hyYdI-0008GT-CA
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 05:34:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1hyYdH-0003YZ-6E
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 05:34:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54959)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1hyYdB-0003Op-VH; Fri, 16 Aug 2019 05:34:47 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2C9793083392;
 Fri, 16 Aug 2019 09:34:44 +0000 (UTC)
Received: from localhost.localdomain.com (dhcp-200-226.str.redhat.com
 [10.33.200.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 696D95C1D6;
 Fri, 16 Aug 2019 09:34:43 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Date: Fri, 16 Aug 2019 11:34:23 +0200
Message-Id: <20190816093439.14262-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Fri, 16 Aug 2019 09:34:44 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 00/16] Block layer patches
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 9e06029aea3b2eca1d5261352e695edc1e7d7b=
8b:

  Update version for v4.1.0 release (2019-08-15 13:03:37 +0100)

are available in the Git repository at:

  git://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to a6b257a08e3d72219f03e461a52152672fec0612:

  file-posix: Handle undetectable alignment (2019-08-16 11:29:11 +0200)

----------------------------------------------------------------
Block layer patches:

- file-posix: Fix O_DIRECT alignment detection
- Fixes for concurrent block jobs
- block-backend: Queue requests while drained (fix IDE vs. job crashes)
- qemu-img convert: Deprecate using -n and -o together
- iotests: Migration tests with filter nodes
- iotests: More media change tests

----------------------------------------------------------------
Kevin Wolf (10):
      iotests/118: Test media change for scsi-cd
      iotests/118: Create test classes dynamically
      iotests/118: Add -blockdev based tests
      iotests: Move migration helpers to iotests.py
      iotests: Test migration with all kinds of filter nodes
      block: Simplify bdrv_filter_default_perms()
      block: Remove blk_pread_unthrottled()
      mirror: Keep mirror_top_bs drained after dropping permissions
      block-backend: Queue requests while drained
      qemu-img convert: Deprecate using -n and -o together

Max Reitz (5):
      block: Keep subtree drained in drop_intermediate
      block: Reduce (un)drains when replacing a child
      tests: Test polling in bdrv_drop_intermediate()
      tests: Test mid-drain bdrv_replace_child_noperm()
      iotests: Add test for concurrent stream/commit

Nir Soffer (1):
      file-posix: Handle undetectable alignment

 include/sysemu/block-backend.h |   3 +-
 block.c                        |  63 +++---
 block/backup.c                 |   1 +
 block/block-backend.c          |  69 ++++--
 block/commit.c                 |   2 +
 block/file-posix.c             |  36 +++-
 block/mirror.c                 |   7 +-
 blockjob.c                     |   3 +
 hw/block/hd-geometry.c         |   7 +-
 qemu-img.c                     |   5 +
 tests/test-bdrv-drain.c        | 476 +++++++++++++++++++++++++++++++++++=
++++++
 qemu-deprecated.texi           |   7 +
 tests/qemu-iotests/118         |  84 ++++----
 tests/qemu-iotests/118.out     |   4 +-
 tests/qemu-iotests/234         |  30 +--
 tests/qemu-iotests/258         | 163 ++++++++++++++
 tests/qemu-iotests/258.out     |  33 +++
 tests/qemu-iotests/262         |  82 +++++++
 tests/qemu-iotests/262.out     |  17 ++
 tests/qemu-iotests/group       |   2 +
 tests/qemu-iotests/iotests.py  |  16 ++
 21 files changed, 983 insertions(+), 127 deletions(-)
 create mode 100755 tests/qemu-iotests/258
 create mode 100644 tests/qemu-iotests/258.out
 create mode 100755 tests/qemu-iotests/262
 create mode 100644 tests/qemu-iotests/262.out

