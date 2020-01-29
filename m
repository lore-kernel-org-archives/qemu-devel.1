Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 725FBC33CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 11:16:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BA4C2070E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 11:16:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UUdm/icb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BA4C2070E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwlKt-0001vC-An
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 06:16:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59894)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1iwlJx-0000Xq-V5
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 06:15:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1iwlJw-0005u4-Bu
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 06:15:45 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38301
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1iwlJw-0005sw-8M
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 06:15:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580296543;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=0KvfCDC4XFt1Npt4g0bfbx6kU4yH7bgHr+nMpqkoYBk=;
 b=UUdm/icbNTqdMCP2JPd7om+jxvCe53zv67du9KYm1OJrlcOIP8+qeJ+LfJzfMITEABPHfJ
 zRT7WYsQp82lMv3VbXvUtrcd41Aghy+ma4vxrOWm65he2IQX4GDOxywElo1PK2CIR/sGFa
 jT0sseLW/rijTSFFWBIXO5Psj25KYy4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-350-5PUFPCDGNYGyDpd9CFA1Gg-1; Wed, 29 Jan 2020 06:15:39 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E4B67DB21
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2020 11:15:38 +0000 (UTC)
Received: from secure.mitica (ovpn-116-64.ams2.redhat.com [10.36.116.64])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5C27089D2E;
 Wed, 29 Jan 2020 11:15:37 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/18] Pull migration patches
Date: Wed, 29 Jan 2020 12:15:18 +0100
Message-Id: <20200129111536.9497-1-quintela@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: 5PUFPCDGNYGyDpd9CFA1Gg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 4c60e3289875ae6c516a37523bcecb87f68ce67c=
:

  Merge remote-tracking branch 'remotes/rth/tags/pull-pa-20200127' into sta=
ging (2020-01-28 15:11:04 +0000)

are available in the Git repository at:

  https://github.com/juanquintela/qemu.git tags/pull-migration-pull-request

for you to fetch changes up to 42d24611afc7610808ecb8770cf40e84714dd28e:

  migration/compress: compress QEMUFile is not writable (2020-01-29 11:28:5=
9 +0100)

----------------------------------------------------------------
Migration pull request

(this is a rerun of the previous pull request without the --- bits and
rebased to latest)

This pull request include:                                                 =
           |
- simplify get_qlist (eric)                                                =
           |
- fix null in multifd_send_terminate_threads (zhimin)                      =
           |
- small fix for compress (wei)                                             =
           |
- migrate multifd + cancel fixes (juan)                                    =
           |
- migrate compression: the bits that are reviewed (juan)   =20

----------------------------------------------------------------

Eric Auger (1):
  migration: Simplify get_qlist

Juan Quintela (15):
  migration-test: Use g_free() instead of free()
  multifd: Make sure that we don't do any IO after an error
  qemu-file: Don't do IO after shutdown
  migration: Don't send data if we have stopped
  migration-test: Make sure that multifd and cancel works
  migration: Create migration_is_running()
  ram_addr: Split RAMBlock definition
  multifd: multifd_send_pages only needs the qemufile
  multifd: multifd_queue_page only needs the qemufile
  multifd: multifd_send_sync_main only needs the qemufile
  multifd: Use qemu_target_page_size()
  migration: Make checkpatch happy with comments
  multifd: Make multifd_save_setup() get an Error parameter
  multifd: Make multifd_load_setup() get an Error parameter
  multifd: Split multifd code into its own file

Wei Yang (1):
  migration/compress: compress QEMUFile is not writable

Zhimin Feng (1):
  migration/multifd: fix nullptr access in
    multifd_send_terminate_threads

 MAINTAINERS                  |    1 +
 include/exec/ram_addr.h      |   40 +-
 include/exec/ramblock.h      |   64 +++
 include/qemu/queue.h         |   19 +-
 migration/Makefile.objs      |    1 +
 migration/migration.c        |   69 ++-
 migration/migration.h        |    3 +-
 migration/multifd.c          |  899 ++++++++++++++++++++++++++++++
 migration/multifd.h          |  139 +++++
 migration/qemu-file.c        |   38 +-
 migration/ram.c              | 1004 +---------------------------------
 migration/ram.h              |    7 -
 migration/rdma.c             |    2 +-
 migration/savevm.c           |    4 +-
 migration/vmstate-types.c    |   10 +-
 tests/qtest/migration-test.c |  114 +++-
 16 files changed, 1332 insertions(+), 1082 deletions(-)
 create mode 100644 include/exec/ramblock.h
 create mode 100644 migration/multifd.c
 create mode 100644 migration/multifd.h

--=20
2.24.1


