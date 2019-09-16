Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B316AC49ED7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 14:34:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8742520830
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 14:34:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8742520830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9s57-00057P-0Z
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 10:34:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50326)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i9rqZ-0007BT-L0
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:19:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i9rqY-0007ua-Gh
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:19:19 -0400
Received: from relay.sw.ru ([185.231.240.75]:58106)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1i9rqV-0007sg-Bb; Mon, 16 Sep 2019 10:19:15 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1i9rqR-0003EA-UA; Mon, 16 Sep 2019 17:19:12 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Date: Mon, 16 Sep 2019 17:19:07 +0300
Message-Id: <20190916141911.5255-1-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH 0/4] bitmaps: some refactoring
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
Cc: fam@euphon.net, kwolf@redhat.com, vsementsov@virtuozzo.com,
 quintela@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org,
 stefanha@redhat.com, den@openvz.org, mreitz@redhat.com, jsnow@redhat.com,
 dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi all!

Here I suggest some refactoring patches for bitmaps.

Vladimir Sementsov-Ogievskiy (4):
  block/dirty-bitmap: drop meta
  block/dirty-bitmap: add bs link
  block/dirty-bitmap: drop BdrvDirtyBitmap.mutex
  block/dirty-bitmap: refactor bdrv_dirty_bitmap_next

 include/block/dirty-bitmap.h   |  28 +++---
 block.c                        |   4 +-
 block/backup.c                 |  14 ++-
 block/dirty-bitmap.c           | 165 ++++++++++++---------------------
 block/mirror.c                 |   4 +-
 block/qcow2-bitmap.c           |  14 +--
 blockdev.c                     |   6 +-
 migration/block-dirty-bitmap.c |  11 +--
 migration/block.c              |   4 +-
 9 files changed, 95 insertions(+), 155 deletions(-)

-- 
2.21.0


