Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5585BC43461
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 19:56:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01D4A21D92
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 19:56:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qh8de0zi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01D4A21D92
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGSfu-0007mo-4q
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 15:56:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54238)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kGSZu-0004ML-G7
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 15:49:54 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:50139
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kGSZs-0000bm-Lj
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 15:49:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599767392;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rX4kafdmfGZKxi2RxomZg4CDzZ1oTRFgvM+T8+rbqIs=;
 b=Qh8de0zikLcfdZTck9pojH36uvMwL7gIChAjUy2KQ296n00A5DXG/mJNrtC4NpuBlI3ioP
 euEB+D6IQM0LrGF7LCABVhqKuaAdbezL0Ie9Fbxa+MUfqOE6tKV+xqAZIXvHIG9hHF87JE
 vygpu9ktWEliNldVBRgtA6bfxeH9Kf0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-513-NXE0ar2EMg6j0XI-tD_zpQ-1; Thu, 10 Sep 2020 15:49:50 -0400
X-MC-Unique: NXE0ar2EMg6j0XI-tD_zpQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7A49E107465B;
 Thu, 10 Sep 2020 19:49:49 +0000 (UTC)
Received: from localhost (ovpn-66-226.rdu2.redhat.com [10.10.66.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A2A017EB7A;
 Thu, 10 Sep 2020 19:49:40 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 07/18] chardev: Rename MUX_CHARDEV to CHARDEV_MUX
Date: Thu, 10 Sep 2020 15:48:52 -0400
Message-Id: <20200910194903.4104696-8-ehabkost@redhat.com>
In-Reply-To: <20200910194903.4104696-1-ehabkost@redhat.com>
References: <20200910194903.4104696-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 08:38:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Rename instance and class type checkers to match the
TYPE_CHARDEV_* constant names and the QOM type name strings
("chardev-*").

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 chardev/chardev-internal.h |  2 +-
 chardev/char-fe.c          |  4 ++--
 chardev/char-mux.c         | 22 +++++++++++-----------
 chardev/char.c             |  2 +-
 4 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/chardev/chardev-internal.h b/chardev/chardev-internal.h
index aba0240759..740d56bf94 100644
--- a/chardev/chardev-internal.h
+++ b/chardev/chardev-internal.h
@@ -54,7 +54,7 @@ struct MuxChardev {
 };
 typedef struct MuxChardev MuxChardev;
 
-DECLARE_INSTANCE_CHECKER(MuxChardev, MUX_CHARDEV,
+DECLARE_INSTANCE_CHECKER(MuxChardev, CHARDEV_MUX,
                          TYPE_CHARDEV_MUX)
 #define CHARDEV_IS_MUX(chr)                             \
     object_dynamic_cast(OBJECT(chr), TYPE_CHARDEV_MUX)
diff --git a/chardev/char-fe.c b/chardev/char-fe.c
index 474715c5a9..419835c340 100644
--- a/chardev/char-fe.c
+++ b/chardev/char-fe.c
@@ -196,7 +196,7 @@ bool qemu_chr_fe_init(CharBackend *b, Chardev *s, Error **errp)
 
     if (s) {
         if (CHARDEV_IS_MUX(s)) {
-            MuxChardev *d = MUX_CHARDEV(s);
+            MuxChardev *d = CHARDEV_MUX(s);
 
             if (d->mux_cnt >= MAX_MUX) {
                 goto unavailable;
@@ -231,7 +231,7 @@ void qemu_chr_fe_deinit(CharBackend *b, bool del)
             b->chr->be = NULL;
         }
         if (CHARDEV_IS_MUX(b->chr)) {
-            MuxChardev *d = MUX_CHARDEV(b->chr);
+            MuxChardev *d = CHARDEV_MUX(b->chr);
             d->backends[b->tag] = NULL;
         }
         if (del) {
diff --git a/chardev/char-mux.c b/chardev/char-mux.c
index 6f980bb836..a9dcbf2cc0 100644
--- a/chardev/char-mux.c
+++ b/chardev/char-mux.c
@@ -36,7 +36,7 @@
 /* Called with chr_write_lock held.  */
 static int mux_chr_write(Chardev *chr, const uint8_t *buf, int len)
 {
-    MuxChardev *d = MUX_CHARDEV(chr);
+    MuxChardev *d = CHARDEV_MUX(chr);
     int ret;
     if (!d->timestamps) {
         ret = qemu_chr_fe_write(&d->chr, buf, len);
@@ -128,7 +128,7 @@ static void mux_chr_send_event(MuxChardev *d, int mux_nr, QEMUChrEvent event)
 
 static void mux_chr_be_event(Chardev *chr, QEMUChrEvent event)
 {
-    MuxChardev *d = MUX_CHARDEV(chr);
+    MuxChardev *d = CHARDEV_MUX(chr);
 
     if (d->focus != -1) {
         mux_chr_send_event(d, d->focus, event);
@@ -182,7 +182,7 @@ static int mux_proc_byte(Chardev *chr, MuxChardev *d, int ch)
 
 static void mux_chr_accept_input(Chardev *chr)
 {
-    MuxChardev *d = MUX_CHARDEV(chr);
+    MuxChardev *d = CHARDEV_MUX(chr);
     int m = d->focus;
     CharBackend *be = d->backends[m];
 
@@ -195,7 +195,7 @@ static void mux_chr_accept_input(Chardev *chr)
 
 static int mux_chr_can_read(void *opaque)
 {
-    MuxChardev *d = MUX_CHARDEV(opaque);
+    MuxChardev *d = CHARDEV_MUX(opaque);
     int m = d->focus;
     CharBackend *be = d->backends[m];
 
@@ -213,7 +213,7 @@ static int mux_chr_can_read(void *opaque)
 static void mux_chr_read(void *opaque, const uint8_t *buf, int size)
 {
     Chardev *chr = CHARDEV(opaque);
-    MuxChardev *d = MUX_CHARDEV(opaque);
+    MuxChardev *d = CHARDEV_MUX(opaque);
     int m = d->focus;
     CharBackend *be = d->backends[m];
     int i;
@@ -234,7 +234,7 @@ static void mux_chr_read(void *opaque, const uint8_t *buf, int size)
 
 void mux_chr_send_all_event(Chardev *chr, QEMUChrEvent event)
 {
-    MuxChardev *d = MUX_CHARDEV(chr);
+    MuxChardev *d = CHARDEV_MUX(chr);
     int i;
 
     if (!machine_init_done) {
@@ -254,7 +254,7 @@ static void mux_chr_event(void *opaque, QEMUChrEvent event)
 
 static GSource *mux_chr_add_watch(Chardev *s, GIOCondition cond)
 {
-    MuxChardev *d = MUX_CHARDEV(s);
+    MuxChardev *d = CHARDEV_MUX(s);
     Chardev *chr = qemu_chr_fe_get_driver(&d->chr);
     ChardevClass *cc = CHARDEV_GET_CLASS(chr);
 
@@ -267,7 +267,7 @@ static GSource *mux_chr_add_watch(Chardev *s, GIOCondition cond)
 
 static void char_mux_finalize(Object *obj)
 {
-    MuxChardev *d = MUX_CHARDEV(obj);
+    MuxChardev *d = CHARDEV_MUX(obj);
     int i;
 
     for (i = 0; i < d->mux_cnt; i++) {
@@ -281,7 +281,7 @@ static void char_mux_finalize(Object *obj)
 
 static void mux_chr_update_read_handlers(Chardev *chr)
 {
-    MuxChardev *d = MUX_CHARDEV(chr);
+    MuxChardev *d = CHARDEV_MUX(chr);
 
     /* Fix up the real driver with mux routines */
     qemu_chr_fe_set_handlers_full(&d->chr,
@@ -295,7 +295,7 @@ static void mux_chr_update_read_handlers(Chardev *chr)
 
 void mux_set_focus(Chardev *chr, int focus)
 {
-    MuxChardev *d = MUX_CHARDEV(chr);
+    MuxChardev *d = CHARDEV_MUX(chr);
 
     assert(focus >= 0);
     assert(focus < d->mux_cnt);
@@ -316,7 +316,7 @@ static void qemu_chr_open_mux(Chardev *chr,
 {
     ChardevMux *mux = backend->u.mux.data;
     Chardev *drv;
-    MuxChardev *d = MUX_CHARDEV(chr);
+    MuxChardev *d = CHARDEV_MUX(chr);
 
     drv = qemu_chr_find(mux->chardev);
     if (drv == NULL) {
diff --git a/chardev/char.c b/chardev/char.c
index 77e7ec814f..43fb8bd50e 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -308,7 +308,7 @@ static const TypeInfo char_type_info = {
 static bool qemu_chr_is_busy(Chardev *s)
 {
     if (CHARDEV_IS_MUX(s)) {
-        MuxChardev *d = MUX_CHARDEV(s);
+        MuxChardev *d = CHARDEV_MUX(s);
         return d->mux_cnt >= 0;
     } else {
         return s->be != NULL;
-- 
2.26.2


