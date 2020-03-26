Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46FB4C2D0EC
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 14:31:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16AE120714
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 14:31:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mwk12Q96"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16AE120714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHTXI-0005MP-2q
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 10:31:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41229)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jHTVy-0003KY-98
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 10:29:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1jHTVw-0002kp-LT
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 10:29:45 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:52730)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1jHTVw-0002kb-80
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 10:29:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585232983;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=2ToxR863tAsNLXiBFFHeJ7ggxv1jEUjqGqlz2up8BeY=;
 b=Mwk12Q96eZB7XLDhl7LmLcWRo9a5HdY4AxWfYHv4y6kjGOAxMuaZukSrGqP8QaDolgJWk1
 771qcwEU6EwxafZQP2KX2DfDgP3pd02aZJ+BLGmh2uiw21I58orUZhIDPdUOY1ikV6Ku1O
 OOK0pv+5KJxcywKdUbqlXFS+Ssek3lw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-283-qR4EKRSkMAaqPHjlV2tULg-1; Thu, 26 Mar 2020 10:29:38 -0400
X-MC-Unique: qR4EKRSkMAaqPHjlV2tULg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B0B3A1005512;
 Thu, 26 Mar 2020 14:29:36 +0000 (UTC)
Received: from localhost (ovpn-112-132.ams2.redhat.com [10.36.112.132])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 334F6CFE0;
 Thu, 26 Mar 2020 14:29:35 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 00/10] Block patches for 5.0-rc1
Date: Thu, 26 Mar 2020 15:29:23 +0100
Message-Id: <20200326142933.625037-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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

The following changes since commit 01e38186ecb1fc6275720c5425332eed280ea93d=
:

  Merge remote-tracking branch 'remotes/dgilbert/tags/pull-migration-202003=
25b' into staging (2020-03-26 09:28:11 +0000)

are available in the Git repository at:

  https://github.com/XanClic/qemu.git tags/pull-block-2020-03-26

for you to fetch changes up to a507c51790fa955c1fccd4deca3c50476a862b83:

  iotests/138: Test leaks/corruptions fixed report (2020-03-26 14:52:43 +01=
00)

----------------------------------------------------------------
Block patches for 5.0-rc1:
- Fix qemu-img convert with a host device or iscsi target
- Use-after-free fix in mirror
- Some minor qcow2 fixes
- Minor sheepdog fix
- Minor qemu-img check report fix

----------------------------------------------------------------
Eric Blake (4):
  qcow2: Comment typo fixes
  qcow2: List autoclear bit names in header
  qcow2: Avoid feature name extension on small cluster size
  sheepdog: Consistently set bdrv_has_zero_init_truncate

Max Reitz (3):
  qemu-img: Fix check's leak/corruption fix report
  iotests: Add poke_file_[bl]e functions
  iotests/138: Test leaks/corruptions fixed report

Maxim Levitsky (2):
  block: pass BlockDriver reference to the .bdrv_co_create
  block: trickle down the fallback image creation function use to the
    block drivers

Vladimir Sementsov-Ogievskiy (1):
  block/mirror: fix use after free of local_err

 docs/interop/qcow2.txt       |  3 ++-
 include/block/block.h        |  1 +
 include/block/block_int.h    | 14 +++++++++++-
 block.c                      | 38 +++++++++++++++++++--------------
 block/crypto.c               |  3 ++-
 block/file-posix.c           | 11 ++++++++--
 block/file-win32.c           |  4 +++-
 block/gluster.c              |  3 ++-
 block/iscsi.c                | 16 ++++----------
 block/mirror.c               |  1 +
 block/nbd.c                  |  6 ++++++
 block/nfs.c                  |  4 +++-
 block/nvme.c                 |  3 +++
 block/parallels.c            |  3 ++-
 block/qcow.c                 |  3 ++-
 block/qcow2.c                | 33 +++++++++++++++++++++++------
 block/qed.c                  |  3 ++-
 block/raw-format.c           |  4 +++-
 block/rbd.c                  |  3 ++-
 block/sheepdog.c             |  6 +++++-
 block/ssh.c                  |  4 +++-
 block/vdi.c                  |  4 +++-
 block/vhdx.c                 |  3 ++-
 block/vmdk.c                 |  4 +++-
 block/vpc.c                  |  6 ++++--
 qemu-img.c                   |  9 ++++++--
 tests/qemu-iotests/031.out   |  8 +++----
 tests/qemu-iotests/036       |  6 ++++--
 tests/qemu-iotests/036.out   |  4 ++--
 tests/qemu-iotests/061       |  6 ++++--
 tests/qemu-iotests/061.out   | 14 ++++++------
 tests/qemu-iotests/138       | 41 ++++++++++++++++++++++++++++++++++--
 tests/qemu-iotests/138.out   | 14 ++++++++++++
 tests/qemu-iotests/common.rc | 24 +++++++++++++++++++++
 34 files changed, 233 insertions(+), 76 deletions(-)

--=20
2.25.1


