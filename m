Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1672C47404
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 19:19:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80C04206CD
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 19:19:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80C04206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJ0Rb-00023o-Tp
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 15:19:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37369)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iJ0PJ-0008TR-Kf
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 15:16:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iJ0PI-0003gK-HK
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 15:16:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41548)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iJ0PI-0003fc-8a
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 15:16:56 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 82E9F59465;
 Fri, 11 Oct 2019 19:16:55 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-117-210.ams2.redhat.com
 [10.36.117.210])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3FD055D6C8;
 Fri, 11 Oct 2019 19:16:49 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, quintela@redhat.com, eric.auger@redhat.com,
 richardw.yang@linux.intel.com
Subject: [PULL 00/21] migration queue
Date: Fri, 11 Oct 2019 20:16:25 +0100
Message-Id: <20191011191646.226814-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Fri, 11 Oct 2019 19:16:55 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: peterx@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

The following changes since commit 98b2e3c9ab3abfe476a2b02f8f51813edb90e7=
2d:

  Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request'=
 into staging (2019-10-08 16:08:35 +0100)

are available in the Git repository at:

  git://github.com/dagrh/qemu.git tags/pull-migration-20191011a

for you to fetch changes up to 9a85e4b8f672016adbf7b7d5beaab2a99b9b5615:

  migration: Support gtree migration (2019-10-11 17:52:31 +0100)

----------------------------------------------------------------
Migration pull 2019-10-11

Mostly cleanups and minor fixes

[Note I'm seeing a hang on the aarch64 hosted x86-64 tcg migration
test in xbzrle; but I'm seeing that on current head as well]

----------------------------------------------------------------
Dr. David Alan Gilbert (6):
      rcu: Add automatically released rcu_read_lock variants
      migration: Fix missing rcu_read_unlock
      migration: Use automatic rcu_read unlock in ram.c
      migration: Use automatic rcu_read unlock in rdma.c
      rcu: Use automatic rc_read unlock in core memory/exec code
      migration: Don't try and recover return path in non-postcopy

Eric Auger (1):
      migration: Support gtree migration

Wei Yang (14):
      migration: use migration_is_active to represent active state
      migration/postcopy: allocate tmp_page in setup stage
      migration/postcopy: map large zero page in postcopy_ram_incoming_se=
tup()
      migration/postcopy: fix typo in mark_postcopy_blocktime_begin's com=
ment
      migration: pass in_postcopy instead of check state again
      migration: report SaveStateEntry id and name on failure
      migration/postcopy: mis->have_listen_thread check will never be tou=
ched
      migration/postcopy: postpone setting PostcopyState to END
      migration/postcopy: rename postcopy_ram_enable_notify to postcopy_r=
am_incoming_setup
      migration/postcopy: check PostcopyState before setting to POSTCOPY_=
INCOMING_RUNNING
      migration/multifd: fix a typo in comment of multifd_recv_unfill_pac=
ket()
      migration/multifd: use pages->allocated instead of the static max
      migration/multifd: initialize packet->magic/version once at setup s=
tage
      migration/multifd: pages->used would be cleared when attach to mult=
ifd_send_state

 docs/devel/rcu.txt          |  16 ++
 exec.c                      | 116 +++++-------
 include/exec/ram_addr.h     | 138 +++++++--------
 include/migration/misc.h    |   1 +
 include/migration/vmstate.h |  40 +++++
 include/qemu/rcu.h          |  25 +++
 memory.c                    |  15 +-
 migration/migration.c       |  17 +-
 migration/postcopy-ram.c    |  88 ++++-----
 migration/postcopy-ram.h    |   9 +-
 migration/ram.c             | 298 +++++++++++++++----------------
 migration/rdma.c            |  57 ++----
 migration/savevm.c          |  14 +-
 migration/trace-events      |   5 +
 migration/vmstate-types.c   | 152 ++++++++++++++++
 tests/test-vmstate.c        | 421 ++++++++++++++++++++++++++++++++++++++=
++++++
 16 files changed, 980 insertions(+), 432 deletions(-)

