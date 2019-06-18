Return-Path: <SRS0=M8fn=UR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C904EC31E5B
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 15:59:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CE5820873
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 15:59:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CE5820873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59254 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdGWF-0004TD-Ox
	for qemu-devel@archiver.kernel.org; Tue, 18 Jun 2019 11:59:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55732)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwolf@redhat.com>) id 1hdFxN-0007yz-0J
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 11:23:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1hdFxJ-0000RG-3M
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 11:23:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34448)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1hdFxE-0000JB-7L; Tue, 18 Jun 2019 11:23:24 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C4BEE30860A5;
 Tue, 18 Jun 2019 15:23:22 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-116-185.ams2.redhat.com
 [10.36.116.185])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BE0035792;
 Tue, 18 Jun 2019 15:23:21 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Date: Tue, 18 Jun 2019 17:23:04 +0200
Message-Id: <20190618152318.24953-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Tue, 18 Jun 2019 15:23:22 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 00/14] Block layer patches
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

The following changes since commit cdfaa2720f4a09e5254868bd1f6e33f3e9eae7=
6f:

  Merge remote-tracking branch 'remotes/armbru/tags/pull-monitor-2019-06-=
17-v2' into staging (2019-06-18 10:47:00 +0100)

are available in the Git repository at:

  git://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to 128b05f7e00765d883164631b974a27af5b4b613:

  block/null: Expose read-zeroes option in QAPI schema (2019-06-18 16:41:=
10 +0200)

----------------------------------------------------------------
Block layer patches:

- block: Remove bs->job
- block: Ignore loosening perm restrictions failures
- block/null: Expose read-zeroes option in QAPI schema
- iotests: Hide timestamps for skipped tests

----------------------------------------------------------------
Kevin Wolf (1):
      block/null: Expose read-zeroes option in QAPI schema

Max Reitz (9):
      iotests: Hide timestamps for skipped tests
      file-posix: Update open_flags in raw_set_perm()
      block: Add bdrv_child_refresh_perms()
      block/mirror: Fix child permissions
      block/commit: Drop bdrv_child_try_set_perm()
      block: Fix order in bdrv_replace_child()
      block: Add *tighten_restrictions to *check*_perm()
      block: Ignore loosening perm restrictions failures
      iotests: Test failure to loosen restrictions

Vladimir Sementsov-Ogievskiy (4):
      block/replication: drop usage of bs->job
      block/block-backend: blk_iostatus_reset: drop usage of bs->job
      blockdev: blockdev_mark_auto_del: drop usage of bs->job
      block: drop bs->job

 qapi/block-core.json       |   4 +-
 include/block/block_int.h  |  30 ++++++---
 include/block/blockjob.h   |   9 +++
 block.c                    | 155 +++++++++++++++++++++++++++++++++++++--=
------
 block/block-backend.c      |   4 --
 block/commit.c             |   2 -
 block/file-posix.c         |   4 ++
 block/mirror.c             |  70 ++++++++++++--------
 block/replication.c        |  21 +++---
 blockdev.c                 |  19 +++---
 blockjob.c                 |  22 ++++---
 monitor/qmp-cmds.c         |   5 ++
 tests/test-blockjob.c      |   5 +-
 block/trace-events         |   2 +-
 tests/qemu-iotests/182     |  21 ++++++
 tests/qemu-iotests/182.out |   6 ++
 tests/qemu-iotests/check   |   1 +
 17 files changed, 283 insertions(+), 97 deletions(-)

