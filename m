Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 443C4C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 10:06:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0ED5320739
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 10:06:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h6A2IEvB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ED5320739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43342 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsO0d-0004ZH-9i
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 06:05:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53214)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jsNzQ-0002a8-Go
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 06:04:44 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:60380
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jsNzM-0003za-Ky
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 06:04:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594029879;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=/BPo28YlJ57+VfG/SR2fhG6F/1v7/syCVKHonFD1hwU=;
 b=h6A2IEvBK21xzNJ+14zjonMvbORp26z5pZJYzirH0I3ia/7SbIipXSE4q/yxiqRATPIifv
 odkQRdTRxVdRTqMlA4Lyaai4qDkb5IqZQayNfGui9wKVqRFF+ffjOnakZgTjfbCzDOUk3Y
 X3wfBvwcZBJ7mJ3x1Sx7clI86ExQ6mc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-296-8F6crobEOx2slSadO4PViQ-1; Mon, 06 Jul 2020 06:04:35 -0400
X-MC-Unique: 8F6crobEOx2slSadO4PViQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 29648805F0C;
 Mon,  6 Jul 2020 10:04:34 +0000 (UTC)
Received: from localhost (ovpn-112-176.ams2.redhat.com [10.36.112.176])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B7CA65D9F3;
 Mon,  6 Jul 2020 10:04:33 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 00/31] Block patches
Date: Mon,  6 Jul 2020 12:04:01 +0200
Message-Id: <20200706100432.2301919-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/06 01:59:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit eb6490f544388dd24c0d054a96dd304bc7284450:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20200703' into staging (2020-07-04 16:08:41 +0100)

are available in the Git repository at:

  https://github.com/XanClic/qemu.git tags/pull-block-2020-07-06

for you to fetch changes up to 365fed5111b06d31c1632af63c7528dfe49d62a2:

  qed: Simplify backing reads (2020-07-06 10:34:14 +0200)

----------------------------------------------------------------
Block patches for 5.1:
- LUKS keyslot amendment
  (+ patches to make the iotests pass on non-Linux systems, and to keep
     the tests passing for qcow v1, and to skip LUKS tests (including
     qcow2 LUKS) when the built qemu does not support it)
- Refactoring in the block layer: Drop the basically unnecessary
  unallocated_blocks_are_zero field from BlockDriverInfo
- Fix qcow2 preallocation when the image size is not a multiple of the
  cluster size
- Fix in block-copy code

----------------------------------------------------------------
Alberto Garcia (1):
  qcow2: Fix preallocation on images with unaligned sizes

Eric Blake (1):
  qed: Simplify backing reads

Max Reitz (5):
  iotests: Make _filter_img_create more active
  iotests/common.rc: Add _require_working_luks
  iotests.py: Add qemu_img_pipe_and_status()
  iotests.py: Add (verify|has)_working_luks()
  iotests: Check whether luks works

Maxim Levitsky (14):
  iotests: filter few more luks specific create options
  qcrypto/core: add generic infrastructure for crypto options amendment
  qcrypto/luks: implement encryption key management
  block/amend: add 'force' option
  block/amend: separate amend and create options for qemu-img
  block/amend: refactor qcow2 amend options
  block/crypto: rename two functions
  block/crypto: implement the encryption key management
  block/qcow2: extend qemu-img amend interface with crypto options
  iotests: qemu-img tests for luks key management
  block/core: add generic infrastructure for x-blockdev-amend qmp
    command
  block/crypto: implement blockdev-amend
  block/qcow2: implement blockdev-amend
  iotests: add tests for blockdev-amend

Vladimir Sementsov-Ogievskiy (10):
  block/block-copy: block_copy_dirty_clusters: fix failure check
  qemu-img: convert: don't use unallocated_blocks_are_zero
  block: inline bdrv_unallocated_blocks_are_zero()
  block/vdi: return ZERO block-status when appropriate
  block/vpc: return ZERO block-status when appropriate
  block/crypto: drop unallocated_blocks_are_zero
  block/iscsi: drop unallocated_blocks_are_zero
  block/file-posix: drop unallocated_blocks_are_zero
  block/vhdx: drop unallocated_blocks_are_zero
  block: drop unallocated_blocks_are_zero

 docs/tools/qemu-img.rst          |   5 +-
 qapi/block-core.json             |  68 +++++
 qapi/crypto.json                 |  73 +++++-
 qapi/job.json                    |   4 +-
 block/crypto.h                   |  37 +++
 block/qed.h                      |   1 -
 crypto/blockpriv.h               |   8 +
 include/block/block.h            |   7 +-
 include/block/block_int.h        |  36 ++-
 include/crypto/block.h           |  22 ++
 block.c                          |  19 +-
 block/amend.c                    | 113 +++++++++
 block/block-copy.c               |   4 +-
 block/crypto.c                   | 207 +++++++++++++--
 block/file-posix.c               |   3 -
 block/io.c                       |   8 +-
 block/iscsi.c                    |   1 -
 block/qcow2.c                    | 350 +++++++++++++++-----------
 block/qed.c                      |  65 +----
 block/vdi.c                      |   3 +-
 block/vhdx.c                     |   3 -
 block/vpc.c                      |   3 +-
 crypto/block-luks.c              | 416 ++++++++++++++++++++++++++++++-
 crypto/block.c                   |  29 +++
 qemu-img.c                       |  48 ++--
 block/Makefile.objs              |   2 +-
 qemu-img-cmds.hx                 |   4 +-
 tests/qemu-iotests/049.out       | 102 ++++----
 tests/qemu-iotests/061.out       |  12 +-
 tests/qemu-iotests/082.out       | 185 ++++----------
 tests/qemu-iotests/085.out       |  38 +--
 tests/qemu-iotests/087           |   1 +
 tests/qemu-iotests/087.out       |   6 +-
 tests/qemu-iotests/112.out       |   2 +-
 tests/qemu-iotests/125           |  24 ++
 tests/qemu-iotests/125.out       |   9 +
 tests/qemu-iotests/134.out       |   2 +-
 tests/qemu-iotests/141           |   2 +-
 tests/qemu-iotests/144.out       |   4 +-
 tests/qemu-iotests/146           |  60 +++--
 tests/qemu-iotests/146.out       | 405 ++++++++++++++++++++++++++++--
 tests/qemu-iotests/153           |   9 +-
 tests/qemu-iotests/158.out       |   4 +-
 tests/qemu-iotests/178           |   1 +
 tests/qemu-iotests/182.out       |   2 +-
 tests/qemu-iotests/185.out       |   8 +-
 tests/qemu-iotests/188           |   1 +
 tests/qemu-iotests/188.out       |   2 +-
 tests/qemu-iotests/189           |   1 +
 tests/qemu-iotests/189.out       |   4 +-
 tests/qemu-iotests/198           |   1 +
 tests/qemu-iotests/198.out       |   4 +-
 tests/qemu-iotests/206           |   1 +
 tests/qemu-iotests/255.out       |   8 +-
 tests/qemu-iotests/263           |   1 +
 tests/qemu-iotests/263.out       |   4 +-
 tests/qemu-iotests/274.out       |  46 ++--
 tests/qemu-iotests/280.out       |   2 +-
 tests/qemu-iotests/284           |   1 +
 tests/qemu-iotests/284.out       |   6 +-
 tests/qemu-iotests/293           | 208 ++++++++++++++++
 tests/qemu-iotests/293.out       |  99 ++++++++
 tests/qemu-iotests/294           |  90 +++++++
 tests/qemu-iotests/294.out       |  30 +++
 tests/qemu-iotests/295           | 280 +++++++++++++++++++++
 tests/qemu-iotests/295.out       |  40 +++
 tests/qemu-iotests/296           | 234 +++++++++++++++++
 tests/qemu-iotests/296.out       |  33 +++
 tests/qemu-iotests/common.filter | 106 ++++++--
 tests/qemu-iotests/common.rc     |  30 +++
 tests/qemu-iotests/group         |   4 +
 tests/qemu-iotests/iotests.py    |  84 +++++--
 72 files changed, 3103 insertions(+), 632 deletions(-)
 create mode 100644 block/amend.c
 create mode 100755 tests/qemu-iotests/293
 create mode 100644 tests/qemu-iotests/293.out
 create mode 100755 tests/qemu-iotests/294
 create mode 100644 tests/qemu-iotests/294.out
 create mode 100755 tests/qemu-iotests/295
 create mode 100644 tests/qemu-iotests/295.out
 create mode 100755 tests/qemu-iotests/296
 create mode 100644 tests/qemu-iotests/296.out

-- 
2.26.2


