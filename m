Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56CC6ECE58C
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 19:32:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F7722089C
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 19:32:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F7722089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK65L-0007qY-Uv
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 15:32:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40178)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1iK623-0005NR-Gj
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 15:29:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1iK621-0001st-IF
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 15:29:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38710)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>)
 id 1iK61w-0001Vp-AQ; Mon, 14 Oct 2019 15:29:20 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id CFDAB10C0938;
 Mon, 14 Oct 2019 19:29:18 +0000 (UTC)
Received: from probe.bos.redhat.com (dhcp-17-152.bos.redhat.com [10.18.17.152])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8BEC860BE2;
 Mon, 14 Oct 2019 19:29:09 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PULL v2 00/19] Bitmaps patches
Date: Mon, 14 Oct 2019 15:28:50 -0400
Message-Id: <20191014192909.16044-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.66]); Mon, 14 Oct 2019 19:29:18 +0000 (UTC)
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>, libvir-list@redhat.com,
 John Snow <jsnow@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit c760cb77e511eb05094df67c1b30029a952efa=
35:

  Merge remote-tracking branch 'remotes/dgilbert/tags/pull-migration-2019=
1011a' into staging (2019-10-14 16:09:52 +0100)

are available in the Git repository at:

  https://github.com/jnsnow/qemu.git tags/bitmaps-pull-request

for you to fetch changes up to b2ca29ee390743c42a6062d44ee3b10fb51f9fa6:

  dirty-bitmaps: remove deprecated autoload parameter (2019-10-14 15:28:1=
7 -0400)

----------------------------------------------------------------
Pull request

----------------------------------------------------------------

John Snow (2):
  MAINTAINERS: Add Vladimir as a reviewer for bitmaps
  dirty-bitmaps: remove deprecated autoload parameter

Vladimir Sementsov-Ogievskiy (17):
  util/hbitmap: strict hbitmap_reset
  block: move bdrv_can_store_new_dirty_bitmap to block/dirty-bitmap.c
  block/dirty-bitmap: return int from
    bdrv_remove_persistent_dirty_bitmap
  block/qcow2: proper locking on bitmap add/remove paths
  block/dirty-bitmap: drop meta
  block/dirty-bitmap: add bs link
  block/dirty-bitmap: drop BdrvDirtyBitmap.mutex
  block/dirty-bitmap: refactor bdrv_dirty_bitmap_next
  block: switch reopen queue from QSIMPLEQ to QTAILQ
  block: reverse order for reopen commits
  iotests: add test-case to 165 to test reopening qcow2 bitmaps to RW
  block/qcow2-bitmap: get rid of bdrv_has_changed_persistent_bitmaps
  block/qcow2-bitmap: drop qcow2_reopen_bitmaps_rw_hint()
  block/qcow2-bitmap: do not remove bitmaps on reopen-ro
  iotests: add test 260 to check bitmap life after snapshot + commit
  block/qcow2-bitmap: fix and improve qcow2_reopen_bitmaps_rw
  qcow2-bitmap: move bitmap reopen-rw code to qcow2_reopen_commit

 qemu-deprecated.texi           |  20 ++-
 qapi/block-core.json           |   6 +-
 block/qcow2.h                  |  19 +--
 include/block/block.h          |   2 +-
 include/block/block_int.h      |  20 +--
 include/block/dirty-bitmap.h   |  34 ++--
 include/qemu/hbitmap.h         |   5 +
 block.c                        |  79 +++------
 block/backup.c                 |   8 +-
 block/block-copy.c             |   2 +-
 block/dirty-bitmap.c           | 290 +++++++++++++++++++--------------
 block/mirror.c                 |   4 +-
 block/qcow2-bitmap.c           | 212 +++++++++++++++---------
 block/qcow2.c                  |  22 ++-
 blockdev.c                     |  40 ++---
 migration/block-dirty-bitmap.c |  11 +-
 migration/block.c              |   4 +-
 tests/test-hbitmap.c           |   2 +-
 util/hbitmap.c                 |   4 +
 MAINTAINERS                    |   3 +-
 tests/qemu-iotests/165         |  57 ++++++-
 tests/qemu-iotests/165.out     |   4 +-
 tests/qemu-iotests/260         |  89 ++++++++++
 tests/qemu-iotests/260.out     |  52 ++++++
 tests/qemu-iotests/group       |   1 +
 25 files changed, 623 insertions(+), 367 deletions(-)
 create mode 100755 tests/qemu-iotests/260
 create mode 100644 tests/qemu-iotests/260.out

--=20
2.21.0


