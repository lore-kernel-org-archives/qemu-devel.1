Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBD37C47247
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 12:43:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C5E024979
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 12:43:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gd0S+hkE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C5E024979
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX2LT-0001ZW-O0
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 08:43:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49110)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jX2K3-0008A1-Ka
 for qemu-devel@nongnu.org; Fri, 08 May 2020 08:41:47 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:48767
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jX2K2-0007je-IF
 for qemu-devel@nongnu.org; Fri, 08 May 2020 08:41:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588941705;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ObKd0vIz2u4y8eHzM4/CJLhvFtjnb+aadTXia3kYg5A=;
 b=gd0S+hkEydazInwqfCfjHNH6YT32/HA2UyC6Q2IKxH+XLHwp6AMyQxQLS3SJoeJFhamhHa
 H1bSxyqz7VUL2efFiAtSEiBSod4EOiaaWi3ev2EBZxbFe3shVhwIQHgL3U12+xVzyr4SOZ
 ibQunN7p+LRkJ8tMFEHNadNPkyelJBs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-110-nho8HgRaMd6ktfFPjsQ4rA-1; Fri, 08 May 2020 08:41:43 -0400
X-MC-Unique: nho8HgRaMd6ktfFPjsQ4rA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6E05FEC1A0;
 Fri,  8 May 2020 12:41:42 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-113-190.ams2.redhat.com
 [10.36.113.190])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6F7E119167;
 Fri,  8 May 2020 12:41:41 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 00/30] Block layer patches
Date: Fri,  8 May 2020 14:41:05 +0200
Message-Id: <20200508124135.252565-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/08 08:00:48
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 1b8c45899715d292398152ba97ef755ccaf84680=
:

  Merge remote-tracking branch 'remotes/dgilbert/tags/pull-migration-202005=
07a' into staging (2020-05-07 18:43:20 +0100)

are available in the Git repository at:

  git://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to 47e0b38a13935cb666f88964c3096654092f42d6:

  block: Drop unused .bdrv_has_zero_init_truncate (2020-05-08 13:26:35 +020=
0)

----------------------------------------------------------------
Block layer patches:

- qcow2: Fix preallocation on block devices
- backup: Make sure that source and target size match
- vmdk: Fix zero cluster handling
- Follow-up cleanups and fixes for the truncate changes
- iotests: Skip more tests if required drivers are missing

----------------------------------------------------------------
Alberto Garcia (1):
      qcow2: Avoid integer wraparound in qcow2_co_truncate()

Eric Blake (9):
      gluster: Drop useless has_zero_init callback
      file-win32: Support BDRV_REQ_ZERO_WRITE for truncate
      nfs: Support BDRV_REQ_ZERO_WRITE for truncate
      rbd: Support BDRV_REQ_ZERO_WRITE for truncate
      sheepdog: Support BDRV_REQ_ZERO_WRITE for truncate
      ssh: Support BDRV_REQ_ZERO_WRITE for truncate
      parallels: Rework truncation logic
      vhdx: Rework truncation logic
      block: Drop unused .bdrv_has_zero_init_truncate

Kevin Wolf (11):
      vmdk: Rename VmdkMetaData.valid to new_allocation
      vmdk: Fix zero cluster allocation
      vmdk: Fix partial overwrite of zero cluster
      vmdk: Don't update L2 table for zero write on zero cluster
      vmdk: Flush only once in vmdk_L2update()
      iotests: vmdk: Enable zeroed_grained=3Don by default
      iotests/283: Use consistent size for source and target
      backup: Improve error for bdrv_getlength() failure
      backup: Make sure that source and target size match
      iotests: Backup with different source/target size
      iotests/055: Use cache.no-flush for vmdk target

Max Reitz (1):
      qcow2: Fix preallocation on block devices

Vladimir Sementsov-Ogievskiy (8):
      iotests: handle tmpfs
      iotests/082: require bochs
      iotests/148: use skip_if_unsupported
      iotests/041: drop self.assert_no_active_block_jobs()
      iotests/055: refactor compressed backup to vmdk
      iotests/055: skip vmdk target tests if vmdk is not whitelisted
      iotests/109: mark required formats as required to support whitelistin=
g
      iotests/113: mark bochs as required to support whitelisting

 include/block/block.h        |   1 -
 include/block/block_int.h    |   7 ---
 block.c                      |  21 --------
 block/backup-top.c           |  14 +++--
 block/backup.c               |  18 +++++--
 block/file-posix.c           |   1 -
 block/file-win32.c           |   4 +-
 block/gluster.c              |  14 -----
 block/nfs.c                  |   4 +-
 block/parallels.c            |  25 +++++----
 block/qcow2.c                |  23 ++++++---
 block/qed.c                  |   1 -
 block/raw-format.c           |   6 ---
 block/rbd.c                  |   4 +-
 block/sheepdog.c             |   4 +-
 block/ssh.c                  |   5 +-
 block/vhdx.c                 |  89 ++++++++++++++++++--------------
 block/vmdk.c                 |  47 ++++++++++-------
 tests/qemu-iotests/041       |   8 ---
 tests/qemu-iotests/055       | 120 ++++++++++++++++++++++++++++++---------=
----
 tests/qemu-iotests/055.out   |   4 +-
 tests/qemu-iotests/059       |   6 +--
 tests/qemu-iotests/082       |   1 +
 tests/qemu-iotests/091       |   2 +-
 tests/qemu-iotests/109       |   1 +
 tests/qemu-iotests/113       |   4 +-
 tests/qemu-iotests/148       |   1 +
 tests/qemu-iotests/283       |   6 ++-
 tests/qemu-iotests/283.out   |   2 +-
 tests/qemu-iotests/292       |  73 ++++++++++++++++++++++++++
 tests/qemu-iotests/292.out   |  24 +++++++++
 tests/qemu-iotests/check     |   3 ++
 tests/qemu-iotests/common.rc |  37 ++++++++++++-
 tests/qemu-iotests/group     |   1 +
 34 files changed, 386 insertions(+), 195 deletions(-)
 create mode 100755 tests/qemu-iotests/292
 create mode 100644 tests/qemu-iotests/292.out


