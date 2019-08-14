Return-Path: <SRS0=fB5B=WK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D6ECC32750
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 02:07:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 226F020842
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 02:07:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 226F020842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56648 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxihQ-0007oV-BN
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 22:07:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51027)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1hxicZ-0001L3-NS
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 22:02:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1hxicY-0005K1-3J
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 22:02:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35806)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1hxicX-0005Jo-QK
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 22:02:38 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 921463175292
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2019 02:02:36 +0000 (UTC)
Received: from localhost.localdomain (ovpn-117-78.ams2.redhat.com
 [10.36.117.78])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1ECD17AB44;
 Wed, 14 Aug 2019 02:02:33 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 14 Aug 2019 04:02:17 +0200
Message-Id: <20190814020218.1868-6-quintela@redhat.com>
In-Reply-To: <20190814020218.1868-1-quintela@redhat.com>
References: <20190814020218.1868-1-quintela@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Wed, 14 Aug 2019 02:02:36 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 5/6] migration: add some multifd traces
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
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/ram.c        | 3 +++
 migration/trace-events | 4 ++++
 2 files changed, 7 insertions(+)

diff --git a/migration/ram.c b/migration/ram.c
index f1aec95f83..25a211c3fb 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1173,6 +1173,7 @@ static void *multifd_send_thread(void *opaque)
=20
 out:
     if (local_err) {
+        trace_multifd_send_error(p->id);
         multifd_send_terminate_threads(local_err);
     }
=20
@@ -1203,6 +1204,7 @@ static void multifd_new_send_channel_async(QIOTask =
*task, gpointer opaque)
     QIOChannel *sioc =3D QIO_CHANNEL(qio_task_get_source(task));
     Error *local_err =3D NULL;
=20
+    trace_multifd_new_send_channel_async(p->id);
     if (qio_task_propagate_error(task, &local_err)) {
         migrate_set_error(migrate_get_current(), local_err);
         multifd_save_cleanup();
@@ -1496,6 +1498,7 @@ bool multifd_recv_new_channel(QIOChannel *ioc, Erro=
r **errp)
                                 atomic_read(&multifd_recv_state->count))=
;
         return false;
     }
+    trace_multifd_recv_new_channel(id);
=20
     p =3D &multifd_recv_state->params[id];
     if (p->c !=3D NULL) {
diff --git a/migration/trace-events b/migration/trace-events
index 9fbef614ab..5d85f8bf83 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -81,7 +81,9 @@ migration_bitmap_sync_start(void) ""
 migration_bitmap_sync_end(uint64_t dirty_pages) "dirty_pages %" PRIu64
 migration_bitmap_clear_dirty(char *str, uint64_t start, uint64_t size, u=
nsigned long page) "rb %s start 0x%"PRIx64" size 0x%"PRIx64" page 0x%lx"
 migration_throttle(void) ""
+multifd_new_send_channel_async(uint8_t id) "channel %d"
 multifd_recv(uint8_t id, uint64_t packet_num, uint32_t used, uint32_t fl=
ags, uint32_t next_packet_size) "channel %d packet_num %" PRIu64 " pages =
%d flags 0x%x next packet size %d"
+multifd_recv_new_channel(uint8_t id) "channel %d"
 multifd_recv_sync_main(long packet_num) "packet num %ld"
 multifd_recv_sync_main_signal(uint8_t id) "channel %d"
 multifd_recv_sync_main_wait(uint8_t id) "channel %d"
@@ -89,7 +91,9 @@ multifd_recv_terminate_threads(bool error) "error %d"
 multifd_recv_thread_can_start(uint8_t id) "channel %d"
 multifd_recv_thread_end(uint8_t id, uint64_t packets, uint64_t pages) "c=
hannel %d packets %" PRIu64 " pages %" PRIu64
 multifd_recv_thread_start(uint8_t id) "%d"
+multifd_save_setup_wait(uint8_t id) "%d"
 multifd_send(uint8_t id, uint64_t packet_num, uint32_t used, uint32_t fl=
ags, uint32_t next_packet_size) "channel %d packet_num %" PRIu64 " pages =
%d flags 0x%x next packet size %d"
+multifd_send_error(uint8_t id) "channel %d"
 multifd_send_sync_main(long packet_num) "packet num %ld"
 multifd_send_sync_main_signal(uint8_t id) "channel %d"
 multifd_send_sync_main_wait(uint8_t id) "channel %d"
--=20
2.21.0


