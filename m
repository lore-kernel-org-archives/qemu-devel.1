Return-Path: <SRS0=r3/N=VJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EE94C742BD
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 14:32:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 683B3206B8
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 14:32:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 683B3206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlwbU-0005EG-29
	for qemu-devel@archiver.kernel.org; Fri, 12 Jul 2019 10:32:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44784)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <quintela@redhat.com>) id 1hlwaz-000462-4W
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 10:32:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1hlwat-0001Xi-MG
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 10:32:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50154)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1hlwar-0001Vm-OK
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 10:32:14 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 525C2B9ADD;
 Fri, 12 Jul 2019 14:32:12 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.36.118.16])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 63BD864024;
 Fri, 12 Jul 2019 14:32:10 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 12 Jul 2019 16:31:48 +0200
Message-Id: <20190712143207.4214-1-quintela@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Fri, 12 Jul 2019 14:32:12 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 00/19] Migration patches
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

The following changes since commit a2a9d4adabe340617a24eb73a8b2a116d28a6b=
38:

  Merge remote-tracking branch 'remotes/dgibson/tags/ppc-for-4.1-20190712=
' into staging (2019-07-12 11:06:48 +0100)

are available in the Git repository at:

  https://github.com/juanquintela/qemu.git tags/migration-pull-request

for you to fetch changes up to a48ad5602f496236b4e1955d9e2e8228a7d0ad56:

  migration: allow private destination ram with x-ignore-shared (2019-07-=
12 16:25:59 +0200)

----------------------------------------------------------------
Migration pull request

Fix the issues with the previous pull request and 32 bits.

Please apply.

----------------------------------------------------------------

Juan Quintela (3):
  migration: fix multifd_recv event typo
  migration-test: rename parameter to parameter_int
  migration-test: Add migration multifd test

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

Wei Yang (5):
  migration/multifd: call multifd_send_sync_main when sending
    RAM_SAVE_FLAG_EOS
  migration/xbzrle: update cache and current_data in one place
  cutils: remove one unnecessary pointer operation
  migration/multifd: sync packet_num after all thread are done
  migration/ram.c: reset complete_round when we gets a queued page

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
 migration/ram.c          |  93 ++++++++++----
 migration/trace-events   |   3 +-
 tests/Makefile.include   |   2 +
 tests/migration-test.c   | 103 ++++++++++++----
 tests/test-bitmap.c      |  72 +++++++++++
 util/bitmap.c            |  85 +++++++++++++
 util/cutils.c            |   8 +-
 17 files changed, 770 insertions(+), 83 deletions(-)
 create mode 100644 tests/test-bitmap.c

--=20
2.21.0


