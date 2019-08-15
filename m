Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F1EDC3A589
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 17:02:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31565206C1
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 17:02:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31565206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyJ8y-0008DU-5z
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 13:02:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47518)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1hyIk5-0003Ey-Nh
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 12:36:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hyIk2-0003Wd-4Y
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 12:36:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55606)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hyIk1-0003WB-Vx
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 12:36:46 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E8EAA8535C;
 Thu, 15 Aug 2019 16:36:44 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-117-19.ams2.redhat.com
 [10.36.117.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E0B7F3737;
 Thu, 15 Aug 2019 16:36:40 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 15 Aug 2019 17:34:59 +0100
Message-Id: <20190815163504.18937-29-dgilbert@redhat.com>
In-Reply-To: <20190815163504.18937-1-dgilbert@redhat.com>
References: <20190815163504.18937-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Thu, 15 Aug 2019 16:36:45 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 28/33] migration: rename
 migration_bitmap_sync_range to ramblock_sync_dirty_bitmap
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

From: Wei Yang <richardw.yang@linux.intel.com>

Rename for better understanding of the code.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
Message-Id: <20190808033155.30162-1-richardw.yang@linux.intel.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/ram.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 30f13ffbdd..9e6cc1e685 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1752,7 +1752,7 @@ static inline bool migration_bitmap_clear_dirty(RAM=
State *rs,
 }
=20
 /* Called with RCU critical section */
-static void migration_bitmap_sync_range(RAMState *rs, RAMBlock *rb)
+static void ramblock_sync_dirty_bitmap(RAMState *rs, RAMBlock *rb)
 {
     rs->migration_dirty_pages +=3D
         cpu_physical_memory_sync_dirty_bitmap(rb, 0, rb->used_length,
@@ -1844,7 +1844,7 @@ static void migration_bitmap_sync(RAMState *rs)
     qemu_mutex_lock(&rs->bitmap_mutex);
     rcu_read_lock();
     RAMBLOCK_FOREACH_NOT_IGNORED(block) {
-        migration_bitmap_sync_range(rs, block);
+        ramblock_sync_dirty_bitmap(rs, block);
     }
     ram_counters.remaining =3D ram_bytes_remaining();
     rcu_read_unlock();
@@ -4265,7 +4265,7 @@ static void colo_flush_ram_cache(void)
     memory_global_dirty_log_sync();
     rcu_read_lock();
     RAMBLOCK_FOREACH_NOT_IGNORED(block) {
-        migration_bitmap_sync_range(ram_state, block);
+        ramblock_sync_dirty_bitmap(ram_state, block);
     }
     rcu_read_unlock();
=20
--=20
2.21.0


