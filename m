Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9338C3A589
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 17:04:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD34D206C1
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 17:04:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD34D206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyJB7-0001cb-TV
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 13:04:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47548)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1hyIkA-0003Ms-RX
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 12:36:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hyIk7-0003ZE-6m
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 12:36:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48632)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hyIk7-0003Yk-1w
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 12:36:51 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5B0283084242;
 Thu, 15 Aug 2019 16:36:50 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-117-19.ams2.redhat.com
 [10.36.117.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D4EA83737;
 Thu, 15 Aug 2019 16:36:48 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 15 Aug 2019 17:35:02 +0100
Message-Id: <20190815163504.18937-32-dgilbert@redhat.com>
In-Reply-To: <20190815163504.18937-1-dgilbert@redhat.com>
References: <20190815163504.18937-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Thu, 15 Aug 2019 16:36:50 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 31/33] migration: Add traces for multifd
 terminate threads
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

From: Juan Quintela <quintela@redhat.com>

Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-Id: <20190814020218.1868-2-quintela@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/ram.c        | 4 ++++
 migration/trace-events | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/migration/ram.c b/migration/ram.c
index 9e6cc1e685..b542929a7c 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -997,6 +997,8 @@ static void multifd_send_terminate_threads(Error *err=
)
 {
     int i;
=20
+    trace_multifd_send_terminate_threads(err !=3D NULL);
+
     if (err) {
         MigrationState *s =3D migrate_get_current();
         migrate_set_error(s, err);
@@ -1258,6 +1260,8 @@ static void multifd_recv_terminate_threads(Error *e=
rr)
 {
     int i;
=20
+    trace_multifd_recv_terminate_threads(err !=3D NULL);
+
     if (err) {
         MigrationState *s =3D migrate_get_current();
         migrate_set_error(s, err);
diff --git a/migration/trace-events b/migration/trace-events
index d8e54c367a..886ce70ca0 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -85,12 +85,14 @@ multifd_recv(uint8_t id, uint64_t packet_num, uint32_=
t used, uint32_t flags, uin
 multifd_recv_sync_main(long packet_num) "packet num %ld"
 multifd_recv_sync_main_signal(uint8_t id) "channel %d"
 multifd_recv_sync_main_wait(uint8_t id) "channel %d"
+multifd_recv_terminate_threads(bool error) "error %d"
 multifd_recv_thread_end(uint8_t id, uint64_t packets, uint64_t pages) "c=
hannel %d packets %" PRIu64 " pages %" PRIu64
 multifd_recv_thread_start(uint8_t id) "%d"
 multifd_send(uint8_t id, uint64_t packet_num, uint32_t used, uint32_t fl=
ags, uint32_t next_packet_size) "channel %d packet_num %" PRIu64 " pages =
%d flags 0x%x next packet size %d"
 multifd_send_sync_main(long packet_num) "packet num %ld"
 multifd_send_sync_main_signal(uint8_t id) "channel %d"
 multifd_send_sync_main_wait(uint8_t id) "channel %d"
+multifd_send_terminate_threads(bool error) "error %d"
 multifd_send_thread_end(uint8_t id, uint64_t packets, uint64_t pages) "c=
hannel %d packets %" PRIu64 " pages %"  PRIu64
 multifd_send_thread_start(uint8_t id) "%d"
 ram_discard_range(const char *rbname, uint64_t start, size_t len) "%s: s=
tart: %" PRIx64 " %zx"
--=20
2.21.0


