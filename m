Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83A1AC76188
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 13:44:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C0102173B
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 13:44:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C0102173B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoTBK-0003oI-Sw
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 09:44:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40212)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwolf@redhat.com>) id 1hoTB1-00031C-V3
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 09:44:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1hoTB0-0003RE-TU
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 09:43:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58988)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1hoTAy-0003Pu-Lu; Fri, 19 Jul 2019 09:43:56 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C66B046673;
 Fri, 19 Jul 2019 13:43:55 +0000 (UTC)
Received: from dhcp-200-226.str.redhat.com (dhcp-200-226.str.redhat.com
 [10.33.200.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DAC6B608AB;
 Fri, 19 Jul 2019 13:43:54 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Date: Fri, 19 Jul 2019 15:43:32 +0200
Message-Id: <20190719134345.23526-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Fri, 19 Jul 2019 13:43:55 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 00/13] Block layer patches
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

The following changes since commit 0274f45bdef73283f2c213610f11d4e5dcba43=
b6:

  Merge remote-tracking branch 'remotes/vivier2/tags/linux-user-for-4.1-p=
ull-request' into staging (2019-07-19 09:44:43 +0100)

are available in the Git repository at:

  git://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to 49278ec065da3fbf90f7effcde3b39ac606b2e9e:

  iotests: Test quitting with job on throttled node (2019-07-19 15:17:55 =
+0200)

----------------------------------------------------------------
Block layer patches:

- block: Fix forbidden use of polling in drained_end
- block: Don't wait for I/O throttling while exiting QEMU
- iotests: Use read-zeroes for the null driver to be Valgrind-friendly

----------------------------------------------------------------
Andrey Shinkevich (1):
      iotests: Set read-zeroes on in null block driver for Valgrind

Max Reitz (12):
      block: Introduce BdrvChild.parent_quiesce_counter
      tests: Add job commit by drained_end test
      block: Add @drained_end_counter
      block: Make bdrv_parent_drained_[^_]*() static
      tests: Lock AioContexts in test-block-iothread
      block: Do not poll in bdrv_do_drained_end()
      tests: Extend commit by drained_end test
      block: Loop unsafely in bdrv*drained_end()
      iotests: Add @has_quit to vm.shutdown()
      iotests: Test commit with a filter on the chain
      vl: Drain before (block) job cancel when quitting
      iotests: Test quitting with job on throttled node

 include/block/block.h         |  42 ++++++++----
 include/block/block_int.h     |  15 ++++-
 block.c                       |  52 ++++++++++-----
 block/block-backend.c         |   6 +-
 block/io.c                    | 134 +++++++++++++++++++++++++++---------=
-
 blockjob.c                    |   2 +-
 tests/test-bdrv-drain.c       | 147 ++++++++++++++++++++++++++++++++++++=
++++
 tests/test-block-iothread.c   |  40 +++++++----
 vl.c                          |  11 +++
 python/qemu/machine.py        |   5 +-
 tests/qemu-iotests/040        |  40 ++++++++++-
 tests/qemu-iotests/040.out    |   4 +-
 tests/qemu-iotests/051        |  10 +--
 tests/qemu-iotests/051.pc.out |  10 +--
 tests/qemu-iotests/093        |   9 +--
 tests/qemu-iotests/136        |   1 +
 tests/qemu-iotests/186        |  20 +++---
 tests/qemu-iotests/186.out    | 152 +++++++++++++++++++++---------------=
------
 tests/qemu-iotests/218        |  55 ++++++++++++++-
 tests/qemu-iotests/218.out    |   4 ++
 tests/qemu-iotests/227        |   4 +-
 tests/qemu-iotests/227.out    |   4 +-
 tests/qemu-iotests/238        |   2 +-
 tests/qemu-iotests/240        |   8 +--
 tests/qemu-iotests/255        |   2 +-
 25 files changed, 576 insertions(+), 203 deletions(-)

