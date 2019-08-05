Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6AC7C0650F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 16:38:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B887B2064A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 16:38:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B887B2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55948 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hug0T-0007Ak-VU
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 12:38:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37428)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hufzX-0005c3-TI
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 12:37:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hufzW-0005oo-Od
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 12:37:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49084)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hufzU-0005o5-Gy; Mon, 05 Aug 2019 12:37:44 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 29F95E8CB3;
 Mon,  5 Aug 2019 16:37:43 +0000 (UTC)
Received: from localhost (unknown [10.40.205.217])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B62D6194B2;
 Mon,  5 Aug 2019 16:37:42 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Mon,  5 Aug 2019 18:37:33 +0200
Message-Id: <20190805163740.23616-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Mon, 05 Aug 2019 16:37:43 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 0/7] Block patches for 4.1.0-rc4
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

The following changes since commit 9bb68d34dda9be60335e73e65c8fb61bca0353=
62:

  Merge remote-tracking branch 'remotes/philmd-gitlab/tags/edk2-next-2019=
0803' into staging (2019-08-05 11:05:36 +0100)

are available in the Git repository at:

  https://github.com/XanClic/qemu.git tags/pull-block-2019-08-05

for you to fetch changes up to 07b0851c592efe188a87259adbda26a63c61dc92:

  block/backup: disable copy_range for compressed backup (2019-08-05 18:0=
5:05 +0200)

----------------------------------------------------------------
Block patches for 4.1.0-rc4:
- Fix the backup block job when using copy offloading
- Fix the mirror block job when using the write-blocking copy mode
- Fix incremental backups after the image has been grown with the
  respective bitmap attached to it

----------------------------------------------------------------
Max Reitz (5):
  backup: Copy only dirty areas
  iotests: Test backup job with two guest writes
  iotests: Test incremental backup after truncation
  mirror: Only mirror granularity-aligned chunks
  iotests: Test unaligned blocking mirror write

Vladimir Sementsov-Ogievskiy (2):
  util/hbitmap: update orig_size on truncate
  block/backup: disable copy_range for compressed backup

 block/backup.c             | 15 ++++++++++++---
 block/mirror.c             | 29 ++++++++++++++++++++++++++++
 util/hbitmap.c             |  6 +++++-
 tests/qemu-iotests/056     | 39 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/056.out |  4 ++--
 tests/qemu-iotests/124     | 38 +++++++++++++++++++++++++++++++++----
 tests/qemu-iotests/124.out |  4 ++--
 tests/qemu-iotests/151     | 25 ++++++++++++++++++++++++
 tests/qemu-iotests/151.out |  4 ++--
 9 files changed, 150 insertions(+), 14 deletions(-)

--=20
2.21.0


