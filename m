Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A365EC31E46
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 11:17:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68D87208C2
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 11:17:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68D87208C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58928 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hb1G9-0007JN-Kk
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 07:17:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60173)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <quintela@redhat.com>) id 1hb0t8-0008Ko-1X
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 06:53:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1hb0t5-0004nU-94
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 06:53:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37992)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1hb0t3-0004l3-U2
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 06:53:51 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B63AC3082EF1
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2019 10:53:44 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-241.ams2.redhat.com
 [10.36.116.241])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D08BC17C21;
 Wed, 12 Jun 2019 10:53:42 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 12 Jun 2019 12:53:22 +0200
Message-Id: <20190612105323.7051-6-quintela@redhat.com>
In-Reply-To: <20190612105323.7051-1-quintela@redhat.com>
References: <20190612105323.7051-1-quintela@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Wed, 12 Jun 2019 10:53:44 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v4 5/6] migration: Make no compression
 operations into its own structure
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
 Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It will be used later.

Signed-off-by: Juan Quintela <quintela@redhat.com>

---
Move setup of ->ops helper to proper place (wei)
Rename s/none/nocomp/ (dave)
---
 migration/migration.c |   9 ++
 migration/migration.h |   1 +
 migration/ram.c       | 188 ++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 190 insertions(+), 8 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 3f17d8f2f8..a3526d395b 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2174,6 +2174,15 @@ int migrate_multifd_channels(void)
     return s->parameters.multifd_channels;
 }
=20
+int migrate_multifd_method(void)
+{
+    MigrationState *s;
+
+    s =3D migrate_get_current();
+
+    return s->parameters.multifd_compress;
+}
+
 int migrate_use_xbzrle(void)
 {
     MigrationState *s;
diff --git a/migration/migration.h b/migration/migration.h
index 71c03353c3..437abf3405 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -270,6 +270,7 @@ bool migrate_auto_converge(void);
 bool migrate_use_multifd(void);
 bool migrate_pause_before_switchover(void);
 int migrate_multifd_channels(void);
+int migrate_multifd_method(void);
=20
 int migrate_use_xbzrle(void);
 int64_t migrate_xbzrle_cache_size(void);
diff --git a/migration/ram.c b/migration/ram.c
index b0ca989160..3b0002ddba 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -45,6 +45,7 @@
 #include "page_cache.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
+#include "qapi/qapi-types-migration.h"
 #include "qapi/qapi-events-migration.h"
 #include "qapi/qmp/qerror.h"
 #include "trace.h"
@@ -661,6 +662,8 @@ typedef struct {
     uint64_t num_packets;
     /* pages sent through this channel */
     uint64_t num_pages;
+    /* used for compression methods */
+    void *data;
 }  MultiFDSendParams;
=20
 typedef struct {
@@ -696,8 +699,152 @@ typedef struct {
     uint64_t num_pages;
     /* syncs main thread and channels */
     QemuSemaphore sem_sync;
+    /* used for de-compression methods */
+    void *data;
 } MultiFDRecvParams;
=20
+typedef struct {
+    /* Setup for sending side */
+    int (*send_setup)(MultiFDSendParams *p, Error **errp);
+    /* Cleanup for sending side */
+    void (*send_cleanup)(MultiFDSendParams *p);
+    /* Prepare the send packet */
+    int (*send_prepare)(MultiFDSendParams *p, uint32_t used, Error **err=
p);
+    /* Write the send packet */
+    int (*send_write)(MultiFDSendParams *p, uint32_t used, Error **errp)=
;
+    /* Setup for receiving side */
+    int (*recv_setup)(MultiFDRecvParams *p, Error **errp);
+    /* Cleanup for receiving side */
+    void (*recv_cleanup)(MultiFDRecvParams *p);
+    /* Read all pages */
+    int (*recv_pages)(MultiFDRecvParams *p, uint32_t used, Error **errp)=
;
+} MultiFDMethods;
+
+/* Multifd without compression */
+
+/**
+ * nocomp_send_setup: setup send side
+ *
+ * For no compression this function does nothing.
+ *
+ * Returns 0 for success or -1 for error
+ *
+ * @p: Params for the channel that we are using
+ * @errp: pointer to an error
+ */
+static int nocomp_send_setup(MultiFDSendParams *p, Error **errp)
+{
+    return 0;
+}
+
+/**
+ * nocomp_send_cleanup: cleanup send side
+ *
+ * For no compression this function does nothing.
+ *
+ * @p: Params for the channel that we are using
+ */
+static void nocomp_send_cleanup(MultiFDSendParams *p)
+{
+    return;
+}
+
+/**
+ * nocomp_send_prepare: prepare date to be able to send
+ *
+ * For no compression we just have to calculate the size of the
+ * packet.
+ *
+ * Returns 0 for success or -1 for error
+ *
+ * @p: Params for the channel that we are using
+ * @used: number of pages used
+ * @errp: pointer to an error
+ */
+static int nocomp_send_prepare(MultiFDSendParams *p, uint32_t used,
+                               Error **errp)
+{
+    p->next_packet_size =3D used * qemu_target_page_size();
+    return 0;
+}
+
+/**
+ * nocomp_send_write: do the actual write of the data
+ *
+ * For no compression we just have to write the data.
+ *
+ * Returns 0 for success or -1 for error
+ *
+ * @p: Params for the channel that we are using
+ * @used: number of pages used
+ * @errp: pointer to an error
+ */
+static int nocomp_send_write(MultiFDSendParams *p, uint32_t used, Error =
**errp)
+{
+    return qio_channel_writev_all(p->c, p->pages->iov, used, errp);
+}
+
+/**
+ * nocomp_recv_setup: setup receive side
+ *
+ * For no compression this function does nothing.
+ *
+ * Returns 0 for success or -1 for error
+ *
+ * @p: Params for the channel that we are using
+ * @errp: pointer to an error
+ */
+static int nocomp_recv_setup(MultiFDRecvParams *p, Error **errp)
+{
+    return 0;
+}
+
+/**
+ * nocomp_recv_cleanup: setup receive side
+ *
+ * For no compression this function does nothing.
+ *
+ * @p: Params for the channel that we are using
+ */
+static void nocomp_recv_cleanup(MultiFDRecvParams *p)
+{
+}
+
+/**
+ * nocomp_recv_pages: read the data from the channel into actual pages
+ *
+ * For no compression we just need to read things into the correct place=
.
+ *
+ * Returns 0 for success or -1 for error
+ *
+ * @p: Params for the channel that we are using
+ * @used: number of pages used
+ * @errp: pointer to an error
+ */
+static int nocomp_recv_pages(MultiFDRecvParams *p, uint32_t used, Error =
**errp)
+{
+    if (p->flags !=3D 0) {
+        error_setg(errp, "multifd %d: flags received %x flags expected %=
x",
+                   p->id, MULTIFD_FLAG_ZLIB, p->flags);
+        return -1;
+    }
+    return qio_channel_readv_all(p->c, p->pages->iov, used, errp);
+}
+
+static MultiFDMethods multifd_nocomp_ops =3D {
+    .send_setup =3D nocomp_send_setup,
+    .send_cleanup =3D nocomp_send_cleanup,
+    .send_prepare =3D nocomp_send_prepare,
+    .send_write =3D nocomp_send_write,
+    .recv_setup =3D nocomp_recv_setup,
+    .recv_cleanup =3D nocomp_recv_cleanup,
+    .recv_pages =3D nocomp_recv_pages
+};
+
+static MultiFDMethods *multifd_ops[MULTIFD_COMPRESS__MAX] =3D {
+    [MULTIFD_COMPRESS_NONE] =3D &multifd_nocomp_ops,
+};
+
 static int multifd_send_initial_packet(MultiFDSendParams *p, Error **err=
p)
 {
     MultiFDInit_t msg;
@@ -900,6 +1047,8 @@ struct {
     uint64_t packet_num;
     /* send channels ready */
     QemuSemaphore channels_ready;
+    /* multifd ops */
+    MultiFDMethods *ops;
 } *multifd_send_state;
=20
 /*
@@ -1030,6 +1179,7 @@ void multifd_save_cleanup(void)
         p->packet_len =3D 0;
         g_free(p->packet);
         p->packet =3D NULL;
+        multifd_send_state->ops->send_cleanup(p);
     }
     qemu_sem_destroy(&multifd_send_state->channels_ready);
     qemu_sem_destroy(&multifd_send_state->sem_sync);
@@ -1097,7 +1247,14 @@ static void *multifd_send_thread(void *opaque)
             uint64_t packet_num =3D p->packet_num;
             uint32_t flags =3D p->flags;
=20
-            p->next_packet_size =3D used * qemu_target_page_size();
+            if (used) {
+                ret =3D multifd_send_state->ops->send_prepare(p, used,
+                                                            &local_err);
+                if (ret !=3D 0) {
+                    qemu_mutex_unlock(&p->mutex);
+                    break;
+                }
+            }
             multifd_send_fill_packet(p);
             p->flags =3D 0;
             p->num_packets++;
@@ -1115,8 +1272,7 @@ static void *multifd_send_thread(void *opaque)
             }
=20
             if (used) {
-                ret =3D qio_channel_writev_all(p->c, p->pages->iov,
-                                             used, &local_err);
+                ret =3D multifd_send_state->ops->send_write(p, used, &lo=
cal_err);
                 if (ret !=3D 0) {
                     break;
                 }
@@ -1176,6 +1332,7 @@ int multifd_save_setup(Error **errp)
 {
     int thread_count;
     uint32_t page_count =3D MULTIFD_PACKET_SIZE / qemu_target_page_size(=
);
+    int ret =3D 0;
     uint8_t i;
=20
     if (!migrate_use_multifd()) {
@@ -1187,9 +1344,11 @@ int multifd_save_setup(Error **errp)
     multifd_send_state->pages =3D multifd_pages_init(page_count);
     qemu_sem_init(&multifd_send_state->sem_sync, 0);
     qemu_sem_init(&multifd_send_state->channels_ready, 0);
+    multifd_send_state->ops =3D multifd_ops[migrate_multifd_method()];
=20
     for (i =3D 0; i < thread_count; i++) {
         MultiFDSendParams *p =3D &multifd_send_state->params[i];
+        int res;
=20
         qemu_mutex_init(&p->mutex);
         qemu_sem_init(&p->sem, 0);
@@ -1202,8 +1361,12 @@ int multifd_save_setup(Error **errp)
         p->packet =3D g_malloc0(p->packet_len);
         p->name =3D g_strdup_printf("multifdsend_%d", i);
         socket_send_channel_create(multifd_new_send_channel_async, p);
+        res =3D multifd_send_state->ops->send_setup(p, errp);
+        if (ret =3D=3D 0) {
+            ret =3D res;
+        }
     }
-    return 0;
+    return ret;
 }
=20
 struct {
@@ -1214,6 +1377,8 @@ struct {
     QemuSemaphore sem_sync;
     /* global number of generated multifd packets */
     uint64_t packet_num;
+    /* multifd ops */
+    MultiFDMethods *ops;
 } *multifd_recv_state;
=20
 static void multifd_recv_terminate_threads(Error *err)
@@ -1246,7 +1411,6 @@ static void multifd_recv_terminate_threads(Error *e=
rr)
 int multifd_load_cleanup(Error **errp)
 {
     int i;
-    int ret =3D 0;
=20
     if (!migrate_use_multifd()) {
         return 0;
@@ -1269,6 +1433,7 @@ int multifd_load_cleanup(Error **errp)
         p->packet_len =3D 0;
         g_free(p->packet);
         p->packet =3D NULL;
+        multifd_recv_state->ops->recv_cleanup(p);
     }
     qemu_sem_destroy(&multifd_recv_state->sem_sync);
     g_free(multifd_recv_state->params);
@@ -1276,7 +1441,7 @@ int multifd_load_cleanup(Error **errp)
     g_free(multifd_recv_state);
     multifd_recv_state =3D NULL;
=20
-    return ret;
+    return 0;
 }
=20
 static void multifd_recv_sync_main(void)
@@ -1337,6 +1502,8 @@ static void *multifd_recv_thread(void *opaque)
=20
         used =3D p->pages->used;
         flags =3D p->flags;
+        /* recv methods don't know how to handle the SYNC flag */
+        p->flags &=3D ~MULTIFD_FLAG_SYNC;
         trace_multifd_recv(p->id, p->packet_num, used, flags,
                            p->next_packet_size);
         p->num_packets++;
@@ -1344,8 +1511,7 @@ static void *multifd_recv_thread(void *opaque)
         qemu_mutex_unlock(&p->mutex);
=20
         if (used) {
-            ret =3D qio_channel_readv_all(p->c, p->pages->iov,
-                                        used, &local_err);
+            ret =3D multifd_recv_state->ops->recv_pages(p, used, &local_=
err);
             if (ret !=3D 0) {
                 break;
             }
@@ -1384,9 +1550,11 @@ int multifd_load_setup(Error **errp)
     multifd_recv_state->params =3D g_new0(MultiFDRecvParams, thread_coun=
t);
     atomic_set(&multifd_recv_state->count, 0);
     qemu_sem_init(&multifd_recv_state->sem_sync, 0);
+    multifd_recv_state->ops =3D multifd_ops[migrate_multifd_method()];
=20
     for (i =3D 0; i < thread_count; i++) {
         MultiFDRecvParams *p =3D &multifd_recv_state->params[i];
+        int ret;
=20
         qemu_mutex_init(&p->mutex);
         qemu_sem_init(&p->sem_sync, 0);
@@ -1396,6 +1564,10 @@ int multifd_load_setup(Error **errp)
                       + sizeof(ram_addr_t) * page_count;
         p->packet =3D g_malloc0(p->packet_len);
         p->name =3D g_strdup_printf("multifdrecv_%d", i);
+        ret =3D multifd_recv_state->ops->recv_setup(p, errp);
+        if (ret !=3D 0) {
+            return ret;
+        }
     }
     return 0;
 }
--=20
2.21.0


