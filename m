Return-Path: <SRS0=MhU4=WC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2243C31E40
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 12:01:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6EA220B1F
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 12:01:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6EA220B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1huy9I-0002Kb-1Y
	for qemu-devel@archiver.kernel.org; Tue, 06 Aug 2019 08:01:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60046)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1huy8F-0000Sq-PE
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 08:00:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1huy8E-0001cu-KN
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 07:59:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53366)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1huy8C-0001Zr-Bq; Tue, 06 Aug 2019 07:59:56 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C4DF987633;
 Tue,  6 Aug 2019 11:59:54 +0000 (UTC)
Received: from localhost (ovpn-204-49.brq.redhat.com [10.40.204.49])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5E22C5D6D0;
 Tue,  6 Aug 2019 11:59:54 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Tue,  6 Aug 2019 13:59:45 +0200
Message-Id: <20190806115952.8456-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Tue, 06 Aug 2019 11:59:54 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL v2 0/7] Block patches for 4.1.0-rc4
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
 qemu-stable@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 9bb68d34dda9be60335e73e65c8fb61bca0353=
62:

  Merge remote-tracking branch 'remotes/philmd-gitlab/tags/edk2-next-2019=
0803' into staging (2019-08-05 11:05:36 +0100)

are available in the Git repository at:

  https://github.com/XanClic/qemu.git tags/pull-block-2019-08-06

for you to fetch changes up to 110571be4e70ac015628e76d2731f96dd8d1998c:

  block/backup: disable copy_range for compressed backup (2019-08-06 13:1=
7:27 +0200)
----------------------------------------------------------------
v2: Added =E2=80=9CCc: qemu-stable=E2=80=9D tag where necessary

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


