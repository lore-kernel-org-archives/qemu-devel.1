Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EBEEC3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 16:20:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2605822CE9
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 16:20:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2605822CE9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzkOJ-0004uo-S0
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 12:20:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35210)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1hzkLe-0002ej-Fs
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 12:17:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hzkLd-0006Cj-6s
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 12:17:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57352)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hzkLX-0006AH-UE; Mon, 19 Aug 2019 12:17:28 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 19C5430917AC;
 Mon, 19 Aug 2019 16:17:26 +0000 (UTC)
Received: from localhost (ovpn-204-64.brq.redhat.com [10.40.204.64])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 60D53863A0;
 Mon, 19 Aug 2019 16:17:25 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Mon, 19 Aug 2019 18:17:06 +0200
Message-Id: <20190819161723.7746-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Mon, 19 Aug 2019 16:17:26 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 00/17] Block patches
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

The following changes since commit 3fbd3405d2b0604ea530fc7a1828f19da1e95f=
f9:

  Merge remote-tracking branch 'remotes/huth-gitlab/tags/pull-request-201=
9-08-17' into staging (2019-08-19 14:14:09 +0100)

are available in the Git repository at:

  https://github.com/XanClic/qemu.git tags/pull-block-2019-08-19

for you to fetch changes up to fa27c478102a6b5d1c6b02c005607ad9404b915f:

  doc: Preallocation does not require writing zeroes (2019-08-19 17:13:26=
 +0200)

----------------------------------------------------------------
Block patches:
- preallocation=3Dfalloc/full support for LUKS
- Various minor fixes

----------------------------------------------------------------
Max Reitz (16):
  qemu-img: Fix bdrv_has_zero_init() use in convert
  mirror: Fix bdrv_has_zero_init() use
  block: Add bdrv_has_zero_init_truncate()
  block: Implement .bdrv_has_zero_init_truncate()
  block: Use bdrv_has_zero_init_truncate()
  qcow2: Fix .bdrv_has_zero_init()
  vdi: Fix .bdrv_has_zero_init()
  vhdx: Fix .bdrv_has_zero_init()
  iotests: Convert to preallocated encrypted qcow2
  iotests: Test convert -n to pre-filled image
  iotests: Full mirror to existing non-zero image
  vdi: Make block_status recurse for fixed images
  vmdk: Make block_status recurse for flat extents
  vpc: Do not return RAW from block_status
  iotests: Fix 141 when run with qed
  doc: Preallocation does not require writing zeroes

Maxim Levitsky (1):
  LUKS: support preallocation

 qapi/block-core.json             | 15 +++++---
 include/block/block.h            |  1 +
 include/block/block_int.h        |  9 +++++
 block.c                          | 21 +++++++++++
 block/crypto.c                   | 30 ++++++++++++++--
 block/file-posix.c               |  1 +
 block/file-win32.c               |  1 +
 block/gluster.c                  |  4 +++
 block/mirror.c                   | 11 ++++--
 block/nfs.c                      |  1 +
 block/parallels.c                |  2 +-
 block/qcow2.c                    | 30 +++++++++++++++-
 block/qed.c                      |  1 +
 block/raw-format.c               |  6 ++++
 block/rbd.c                      |  1 +
 block/sheepdog.c                 |  1 +
 block/ssh.c                      |  1 +
 block/vdi.c                      | 16 +++++++--
 block/vhdx.c                     | 28 +++++++++++++--
 block/vmdk.c                     |  3 ++
 block/vpc.c                      |  2 +-
 blockdev.c                       | 16 +++++++--
 qemu-img.c                       | 11 ++++--
 tests/test-block-iothread.c      |  2 +-
 docs/qemu-block-drivers.texi     |  4 +--
 qemu-img.texi                    |  4 +--
 tests/qemu-iotests/041           | 62 +++++++++++++++++++++++++++++---
 tests/qemu-iotests/041.out       |  4 +--
 tests/qemu-iotests/122           | 17 +++++++++
 tests/qemu-iotests/122.out       |  8 +++++
 tests/qemu-iotests/141           |  9 +++--
 tests/qemu-iotests/141.out       |  5 ---
 tests/qemu-iotests/188           | 20 ++++++++++-
 tests/qemu-iotests/188.out       |  4 +++
 tests/qemu-iotests/common.filter |  5 +++
 35 files changed, 313 insertions(+), 43 deletions(-)

--=20
2.21.0


