Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B1A3C3A589
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 16:36:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48EFE20578
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 16:36:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48EFE20578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyIjw-0002Pr-TP
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 12:36:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47089)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1hyIia-0001HT-Rl
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 12:35:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hyIiW-000240-Ei
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 12:35:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51422)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hyIiW-00023g-77
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 12:35:12 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2AD273083363;
 Thu, 15 Aug 2019 16:35:11 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-117-19.ams2.redhat.com
 [10.36.117.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DB75560F8C;
 Thu, 15 Aug 2019 16:35:06 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 15 Aug 2019 17:34:31 +0100
Message-Id: <20190815163504.18937-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Thu, 15 Aug 2019 16:35:11 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 00/33] migration queue
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
Cc: quintela@redhat.com, yury-kotov@yandex-team.ru,
 richardw.yang@linux.intel.com, marcandre.lureau@redhat.com,
 ivanren@tencent.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

The following changes since commit f28ed74fd116491e31329044d140fde4aa23b2=
a0:

  Update version for v4.1.0-rc5 release (2019-08-13 15:38:38 +0100)

are available in the Git repository at:

  git://github.com/dagrh/qemu.git tags/pull-migration-20190814a

for you to fetch changes up to 7dd59d01ddcc4a4ba0c44c2cc9e3b35c79aa7a29:

  migration: add some multifd traces (2019-08-14 17:33:14 +0100)

----------------------------------------------------------------
Migration pull 2019-08-15

Marcel's vmxnet3 live migration fix (that breaks vmxnet3 compatibility
but makes it work)

Error description improvements from Yury.

Multifd fixes from Ivan and Juan.

A load of small cleanups from Wei.

A small cleanup from Marc-Andr=C3=A9 for a future patch.

----------------------------------------------------------------
Ivan Ren (4):
      migration: always initialise ram_counters for a new migration
      migration: add qemu_file_update_transfer interface
      migration: add speed limit for multifd migration
      migration: update ram_counters for multifd sync packet

Juan Quintela (3):
      migration: Add traces for multifd terminate threads
      migration: Make global sem_sync semaphore by channel
      migration: add some multifd traces

Marc-Andr=C3=A9 Lureau (1):
      qemu-file: move qemu_{get,put}_counted_string() declarations

Marcel Apfelbaum (1):
      hw/net: fix vmxnet3 live migration

Wei Yang (23):
      migration: consolidate time info into populate_time_info
      migration/postcopy: the valid condition is one less then end
      migration/postcopy: break the loop when there is no more page to di=
scard
      migration/postcopy: discard_length must not be 0
      migration/postcopy: reduce one operation to calculate fixup_start_a=
ddr
      migration/postcopy: do_fixup is true when host_offset is non-zero
      migration/savevm: flush file for iterable_only case
      migration/savevm: split qemu_savevm_state_complete_precopy() into t=
wo parts
      migration/savevm: move non SaveStateEntry condition check out of it=
eration
      migration/postcopy: PostcopyState is already set in loadvm_postcopy=
_handle_advise()
      migration/postcopy: start_postcopy could be true only when migrate_=
postcopy() return true
      migration: use migration_in_postcopy() to check POSTCOPY_ACTIVE
      migration: just pass RAMBlock is enough
      migration: equation is more proper than and to check LOADVM_QUIT
      migration: return -EINVAL directly when version_id mismatch
      migration: extract ram_load_precopy
      migration/postcopy: make PostcopyDiscardState a static variable
      migration/postcopy: simplify calculation of run_start and fixup_sta=
rt_addr
      migration/postcopy: use QEMU_IS_ALIGNED to replace host_offset
      hmp: Remove migration capabilities from "info migrate"
      migration: remove unused field bytes_xfer
      migration: rename migration_bitmap_sync_range to ramblock_sync_dirt=
y_bitmap
      migration/postcopy: use mis->bh instead of allocating a QEMUBH

Yury Kotov (1):
      migration: Add error_desc for file channel errors

 hw/net/vmxnet3.c                    |  52 +--------
 include/migration/qemu-file-types.h |   4 +
 migration/migration.c               |  79 ++++++++-----
 migration/migration.h               |   1 -
 migration/postcopy-ram.c            |  70 +++++-------
 migration/postcopy-ram.h            |  13 +--
 migration/qemu-file-channel.c       |  30 ++---
 migration/qemu-file.c               |  68 +++++++++--
 migration/qemu-file.h               |  20 ++--
 migration/ram.c                     | 217 ++++++++++++++++++------------=
------
 migration/rdma.c                    |   6 +-
 migration/savevm.c                  |  96 ++++++++++------
 migration/trace-events              |   6 +
 monitor/hmp-cmds.c                  |  14 ---
 14 files changed, 348 insertions(+), 328 deletions(-)

