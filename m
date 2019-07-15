Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6F00C76191
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 13:51:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B28AF20651
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 13:51:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B28AF20651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hn1OO-0007Ct-J7
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 09:51:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53828)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <quintela@redhat.com>) id 1hn1OA-0006Vo-FC
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 09:51:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1hn1O9-00033D-8X
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 09:51:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58030)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1hn1O9-00032v-0w
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 09:51:33 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6037F3DE0E;
 Mon, 15 Jul 2019 13:51:32 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.36.118.16])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 798FA5D705;
 Mon, 15 Jul 2019 13:51:30 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 15 Jul 2019 15:51:04 +0200
Message-Id: <20190715135125.17770-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Mon, 15 Jul 2019 13:51:32 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 00/21] Migration pull request
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 kvm@vger.kernel.org, Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit b9404bf592e7ba74180e1a54ed7a266ec6ee67=
f2:

  Merge remote-tracking branch 'remotes/dgilbert/tags/pull-hmp-20190715' =
into staging (2019-07-15 12:22:07 +0100)

are available in the Git repository at:

  https://github.com/juanquintela/qemu.git tags/migration-pull-request

for you to fetch changes up to 40c4d4a835453452a262f32450a0449886aa19ce:

  migration: always initial RAMBlock.bmap to 1 for new migration (2019-07=
-15 15:47:47 +0200)

----------------------------------------------------------------
Pull request:
- update last pull requset
- drop multifd test: For some reason, 32bit and a packed struct are
  giving me too much trouble.  Still investigating.
- New fixes from upstream.

----------------------------------------------------------------

Ivan Ren (1):
  migration: always initial RAMBlock.bmap to 1 for new migration

Juan Quintela (2):
  migration: fix multifd_recv event typo
  migration-test: rename parameter to parameter_int

Peng Tao (1):
  migration: allow private destination ram with x-ignore-shared

Peter Xu (10):
  migration: No need to take rcu during sync_dirty_bitmap
  memory: Don't set migration bitmap when without migration
  bitmap: Add bitmap_copy_with_{src|dst}_offset()
  memory: Pass mr into snapshot_and_clear_dirty
  memory: Introduce memory listener hook log_clear()
  kvm: Update comments for sync_dirty_bitmap
  kvm: Persistent per kvmslot dirty bitmap
  kvm: Introduce slots lock for memory listener
  kvm: Support KVM_CLEAR_DIRTY_LOG
  migration: Split log_clear() into smaller chunks

Wei Yang (7):
  migration/multifd: call multifd_send_sync_main when sending
    RAM_SAVE_FLAG_EOS
  migration/xbzrle: update cache and current_data in one place
  cutils: remove one unnecessary pointer operation
  migration/multifd: sync packet_num after all thread are done
  migration/ram.c: reset complete_round when we gets a queued page
  migration/postcopy: fix document of postcopy_send_discard_bm_ram()
  migration/postcopy: remove redundant cpu_synchronize_all_post_init

 accel/kvm/kvm-all.c      | 260 ++++++++++++++++++++++++++++++++++++---
 accel/kvm/trace-events   |   1 +
 exec.c                   |  15 ++-
 include/exec/memory.h    |  19 +++
 include/exec/ram_addr.h  |  92 +++++++++++++-
 include/qemu/bitmap.h    |   9 ++
 include/sysemu/kvm_int.h |   4 +
 memory.c                 |  56 ++++++++-
 migration/migration.c    |   4 +
 migration/migration.h    |  27 ++++
 migration/ram.c          | 113 ++++++++++++-----
 migration/savevm.c       |   1 -
 migration/trace-events   |   3 +-
 tests/Makefile.include   |   2 +
 tests/migration-test.c   |  55 +++++----
 tests/test-bitmap.c      |  72 +++++++++++
 util/bitmap.c            |  85 +++++++++++++
 util/cutils.c            |   8 +-
 18 files changed, 732 insertions(+), 94 deletions(-)
 create mode 100644 tests/test-bitmap.c

--=20
2.21.0


