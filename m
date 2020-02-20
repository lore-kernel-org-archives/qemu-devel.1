Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED2FDC11D05
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 16:08:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA333207FD
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 16:08:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PLCEbUVV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA333207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4oNC-0002L4-Ri
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 11:08:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54441)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1j4oMP-0001T1-BO
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 11:07:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1j4oMN-0003zJ-GF
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 11:07:32 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:35965
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1j4oMN-0003yh-9a
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 11:07:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582214850;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=EdL1jEjJnPgMqrPpXEQFCTmRofKZNyoYI0wJAsHdn7o=;
 b=PLCEbUVVmBxjZXRiDhb1S3hvcLhuXDBNBrSwI4XFwZwMPCif4QU/8pPBUGbweHUBA6qn/9
 FSbbBuLtTJSg+JW/h2yK5xTKUpgWhahuWTtNFt2zXTkh5+/VQGE7x3YCFmzPc+y375kp9H
 X0zFf11UTb2gPSpmrhvWfLADjvlG/7I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-208-FvH458DePym2E1bTZjTopA-1; Thu, 20 Feb 2020 11:07:25 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 840E110CE782;
 Thu, 20 Feb 2020 16:07:24 +0000 (UTC)
Received: from localhost (unknown [10.36.118.38])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BF9BD100EBA9;
 Thu, 20 Feb 2020 16:07:19 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 00/18] Block patches
Date: Thu, 20 Feb 2020 17:06:52 +0100
Message-Id: <20200220160710.533297-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: FvH458DePym2E1bTZjTopA-1
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 672f9d0df10a68a5c5f2b32cbc8284abf9f5ee18=
:

  Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into stagi=
ng (2020-02-18 14:23:43 +0000)

are available in the Git repository at:

  https://github.com/XanClic/qemu.git tags/pull-block-2020-02-20

for you to fetch changes up to dff8d44c96f128480430b0c59ed8760917dbd427:

  iotests: Test snapshot -l field separation (2020-02-20 16:43:42 +0100)

----------------------------------------------------------------
Block patches:
- qemu-img convert: New --target-is-zero parameter
- qcow2: Specify non-default compression type flag
- optionally flat output for query-named-block-nodes
- some fixes
- pseudo-creation of images on block devices is now done by a generic
  block layer function

----------------------------------------------------------------
Daniel P. Berrang=C3=A9 (1):
  block: always fill entire LUKS header space with zeros

David Edmondson (1):
  qemu-img: Add --target-is-zero to convert

Max Reitz (11):
  iotests/147: Fix drive parameters
  iotests/279: Fix for non-qcow2 formats
  block/nbd: Fix hang in .bdrv_close()
  block: Generic file creation fallback
  file-posix: Drop hdev_co_create_opts()
  iscsi: Drop iscsi_co_create_opts()
  iotests: Add test for image creation fallback
  qemu-img: Fix convert -n -B for backing-less targets
  iotests: Test convert -n -B to backing-less target
  block: Fix VM size field width in snapshot dump
  iotests: Test snapshot -l field separation

Peter Krempa (1):
  qapi: Allow getting flat output from 'query-named-block-nodes'

Thomas Huth (1):
  iotests: Remove the superfluous 2nd check for the availability of
    quorum

Vladimir Sementsov-Ogievskiy (3):
  docs: improve qcow2 spec about extending image header
  docs: qcow2: introduce compression type feature
  block/backup-top: fix flags handling

 block.c                    | 164 +++++++++++++++++++++++++++++++++----
 block/backup-top.c         |  31 ++++---
 block/file-posix.c         |  67 ---------------
 block/iscsi.c              |  56 -------------
 block/nbd.c                |  14 +++-
 block/qapi.c               |  15 +++-
 block/qcow2.c              |  11 ++-
 blockdev.c                 |   8 +-
 docs/interop/qcow2.txt     |  64 ++++++++++++++-
 docs/interop/qemu-img.rst  |   9 +-
 include/block/block.h      |   2 +-
 include/block/qapi.h       |   4 +-
 monitor/hmp-cmds.c         |   2 +-
 qapi/block-core.json       |   7 +-
 qemu-img-cmds.hx           |   4 +-
 qemu-img.c                 |  28 ++++++-
 tests/qemu-iotests/122     |  14 ++++
 tests/qemu-iotests/122.out |   5 ++
 tests/qemu-iotests/139     |   3 -
 tests/qemu-iotests/147     |   2 +-
 tests/qemu-iotests/259     |  62 ++++++++++++++
 tests/qemu-iotests/259.out |  14 ++++
 tests/qemu-iotests/279     |   7 +-
 tests/qemu-iotests/284     |  97 ++++++++++++++++++++++
 tests/qemu-iotests/284.out |  62 ++++++++++++++
 tests/qemu-iotests/286     |  76 +++++++++++++++++
 tests/qemu-iotests/286.out |   8 ++
 tests/qemu-iotests/group   |   3 +
 28 files changed, 659 insertions(+), 180 deletions(-)
 create mode 100755 tests/qemu-iotests/259
 create mode 100644 tests/qemu-iotests/259.out
 create mode 100755 tests/qemu-iotests/284
 create mode 100644 tests/qemu-iotests/284.out
 create mode 100755 tests/qemu-iotests/286
 create mode 100644 tests/qemu-iotests/286.out

--=20
2.24.1


