Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ED5CC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 20:57:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B18E20809
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 20:57:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UrzaHaH5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B18E20809
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0ABZ-0006YZ-Jh
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 16:57:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34718)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k0AA7-0004mV-EZ
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 16:55:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42621
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k0AA3-0004r0-MK
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 16:55:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595883350;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=3WSoViD1INQELnLZIjX3ZhssaegdLQW2k6yg4s06dKk=;
 b=UrzaHaH5VROopeABPZkclg+FVYrpoJQ/9lxZWH8QmE23+u41YJnVmuw5Jc0luhY+FqfJ7Q
 9m4u9qm1A9G3IKeXY1Q+pf0RYP0nm5i3wd0a/wwFicvV9sTYgBUz3vvqjdRQxub9gxrux8
 ybZDLre0YlAYewzHxoue+ELhBP4E9As=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-411-LkPH-01HNhSeGVNLJhfNgA-1; Mon, 27 Jul 2020 16:55:46 -0400
X-MC-Unique: LkPH-01HNhSeGVNLJhfNgA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C9B4E186A825
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2020 20:55:45 +0000 (UTC)
Received: from blue.redhat.com (ovpn-118-248.rdu2.redhat.com [10.10.118.248])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 74FD419724
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2020 20:55:45 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/24] bitmaps patches for -rc2, 2020-07-27
Date: Mon, 27 Jul 2020 15:55:19 -0500
Message-Id: <20200727205543.206624-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 15:02:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 9303ecb658a0194560d1eecde165a1511223c2d8:

  Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20200727' into staging (2020-07-27 17:25:06 +0100)

are available in the Git repository at:

  https://repo.or.cz/qemu/ericb.git tags/pull-bitmaps-2020-07-27

for you to fetch changes up to 37931e006f05cb768b78dcc47453b13f76ea43c5:

  migration: Fix typos in bitmap migration comments (2020-07-27 15:42:21 -0500)

----------------------------------------------------------------
bitmaps patches for 2020-07-27

- Improve handling of various post-copy bitmap migration scenarios. A lost
bitmap should merely mean that the next backup must be full rather than
incremental, rather than abruptly breaking the entire guest migration.
- Associated iotest improvements

----------------------------------------------------------------
Andrey Shinkevich (1):
      qcow2: Fix capitalization of header extension constant.

Eric Blake (2):
      iotests: Adjust which migration tests are quick
      migration: Fix typos in bitmap migration comments

Vladimir Sementsov-Ogievskiy (21):
      qemu-iotests/199: fix style
      qemu-iotests/199: drop extra constraints
      qemu-iotests/199: better catch postcopy time
      qemu-iotests/199: improve performance: set bitmap by discard
      qemu-iotests/199: change discard patterns
      qemu-iotests/199: increase postcopy period
      migration/block-dirty-bitmap: fix dirty_bitmap_mig_before_vm_start
      migration/block-dirty-bitmap: rename state structure types
      migration/block-dirty-bitmap: rename dirty_bitmap_mig_cleanup
      migration/block-dirty-bitmap: move mutex init to dirty_bitmap_mig_init
      migration/block-dirty-bitmap: refactor state global variables
      migration/block-dirty-bitmap: rename finish_lock to just lock
      migration/block-dirty-bitmap: simplify dirty_bitmap_load_complete
      migration/block-dirty-bitmap: keep bitmap state for all bitmaps
      migration/block-dirty-bitmap: relax error handling in incoming part
      migration/block-dirty-bitmap: cancel migration on shutdown
      migration/savevm: don't worry if bitmap migration postcopy failed
      qemu-iotests/199: prepare for new test-cases addition
      qemu-iotests/199: check persistent bitmaps
      qemu-iotests/199: add early shutdown case to bitmaps postcopy
      qemu-iotests/199: add source-killed case to bitmaps postcopy

 docs/interop/qcow2.txt         |   2 +-
 migration/migration.h          |   3 +-
 block/qcow2.c                  |   2 +-
 migration/block-dirty-bitmap.c | 472 ++++++++++++++++++++++++++---------------
 migration/migration.c          |  15 +-
 migration/savevm.c             |  37 +++-
 tests/qemu-iotests/199         | 254 +++++++++++++++++-----
 tests/qemu-iotests/199.out     |   4 +-
 tests/qemu-iotests/group       |  12 +-
 9 files changed, 556 insertions(+), 245 deletions(-)

-- 
2.27.0


