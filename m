Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB537C4CEC5
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 14:10:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91A8F2053B
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 14:10:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91A8F2053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8Po1-0003LM-0b
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 10:10:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40362)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1i8PUJ-0006ao-PW
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 09:50:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1i8PUI-0002hE-Bt
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 09:50:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54053)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1i8PUH-0002gK-PR
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 09:50:18 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id ADE663082E44;
 Thu, 12 Sep 2019 13:50:16 +0000 (UTC)
Received: from dgilbert-t580.localhost (unknown [10.36.118.12])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B5A895D713;
 Thu, 12 Sep 2019 13:50:08 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, ivanren@tencent.com, peterx@redhat.com,
 richardw.yang@linux.intel.com, yury-kotov@yandex-team.ru,
 quintela@redhat.com
Date: Thu, 12 Sep 2019 14:49:54 +0100
Message-Id: <20190912135006.14820-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Thu, 12 Sep 2019 13:50:17 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 00/12] migration queue
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

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

The following changes since commit 89ea03a7dc83ca36b670ba7f787802791fcb04=
b1:

  Merge remote-tracking branch 'remotes/huth-gitlab/tags/m68k-pull-2019-0=
9-07' into staging (2019-09-09 09:48:34 +0100)

are available in the Git repository at:

  git://github.com/dagrh/qemu.git tags/pull-migration-20190912a

for you to fetch changes up to 268dcd46ae6d608a4ce93b191b51a318504bf1fb:

  migration: fix one typo in comment of function migration_total_bytes() =
(2019-09-12 11:25:06 +0100)

----------------------------------------------------------------
Migration pull 2019-09-12

New feature:
  UUID validation check from Yury Kotov

plus a bunch of fixes.

----------------------------------------------------------------
Dr. David Alan Gilbert (3):
      hw/net/vmxnet3: Fix leftover unregister_savevm
      migration: register_savevm_live doesn't need dev
      qemu-file: Rework old qemu_fflush comment

Ivan Ren (1):
      migration: multifd_send_thread always post p->sem_sync when error h=
appen

Peter Xu (1):
      migration: Fix postcopy bw for recovery

Wei Yang (4):
      migration: cleanup check on ops in savevm.handlers iterations
      migration/qemu-file: remove check on writev_buffer in qemu_put_comp=
ression_data
      migration/qemu-file: fix potential buf waste for extra buf_index ad=
justment
      migration: fix one typo in comment of function migration_total_byte=
s()

Yury Kotov (3):
      migration: Add validate-uuid capability
      tests/libqtest: Allow setting expected exit status
      tests/migration: Add a test for validate-uuid capability

 docs/devel/migration.rst       |   3 +-
 hw/net/vmxnet3.c               |   3 -
 hw/ppc/spapr.c                 |   2 +-
 hw/s390x/s390-skeys.c          |   2 +-
 hw/s390x/s390-stattrib.c       |   2 +-
 hw/s390x/tod.c                 |   2 +-
 include/migration/register.h   |   3 +-
 migration/block-dirty-bitmap.c |   2 +-
 migration/block.c              |   2 +-
 migration/migration.c          |  14 ++++-
 migration/migration.h          |   1 +
 migration/qemu-file.c          |  50 ++++++++-------
 migration/ram.c                |   7 +--
 migration/savevm.c             |  80 ++++++++++++++---------
 net/slirp.c                    |   2 +-
 qapi/migration.json            |   5 +-
 tests/libqtest.c               |  36 ++++++-----
 tests/libqtest.h               |   9 +++
 tests/migration-test.c         | 140 ++++++++++++++++++++++++++++++++---=
------
 19 files changed, 249 insertions(+), 116 deletions(-)

