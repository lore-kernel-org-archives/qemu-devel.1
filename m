Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09E30C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 19:53:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 980A4208E4
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 19:53:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GdnEgjja"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 980A4208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGSdW-0003ZK-L5
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 15:53:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54308)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kGSa3-0004m3-3w
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 15:50:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40081
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kGSa1-0000cO-5N
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 15:50:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599767400;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tO1cF4uLddeS/rfTwEY8zoXQ+27FQblhXU4hYJJCTzo=;
 b=GdnEgjja+HSS5RFY6t5cyq0r2dLZi0KG0EXKMQO2wjOL1JXSIbZYoKkaWkvM16+v1xL9dY
 OkyqmbJpFZrdckE7OgUg0wPxxTm4NkRj75Iu5XHxdWbJZ0ehpeRmjVFXedvUvMimaUgSd5
 H0dR/gXiChOxpZ4OIKfXC5qQIBY2R14=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-451-WF6L2t5vMvGKhAiply5Tlg-1; Thu, 10 Sep 2020 15:49:58 -0400
X-MC-Unique: WF6L2t5vMvGKhAiply5Tlg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 763FB1007B00;
 Thu, 10 Sep 2020 19:49:57 +0000 (UTC)
Received: from localhost (ovpn-66-226.rdu2.redhat.com [10.10.66.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 38FF37EB7A;
 Thu, 10 Sep 2020 19:49:57 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 09/18] chardev: Rename PTY_CHARDEV to CHARDEV_PTY
Date: Thu, 10 Sep 2020 15:48:54 -0400
Message-Id: <20200910194903.4104696-10-ehabkost@redhat.com>
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
Received-SPF: pass client-ip=207.211.31.120; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 08:35:50
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
 chardev/char-pty.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/chardev/char-pty.c b/chardev/char-pty.c
index a2d1e7c985..4c1c877097 100644
--- a/chardev/char-pty.c
+++ b/chardev/char-pty.c
@@ -45,7 +45,7 @@ struct PtyChardev {
 };
 typedef struct PtyChardev PtyChardev;
 
-DECLARE_INSTANCE_CHECKER(PtyChardev, PTY_CHARDEV,
+DECLARE_INSTANCE_CHECKER(PtyChardev, CHARDEV_PTY,
                          TYPE_CHARDEV_PTY)
 
 static void pty_chr_state(Chardev *chr, int connected);
@@ -62,7 +62,7 @@ static void pty_chr_timer_cancel(PtyChardev *s)
 static gboolean pty_chr_timer(gpointer opaque)
 {
     struct Chardev *chr = CHARDEV(opaque);
-    PtyChardev *s = PTY_CHARDEV(opaque);
+    PtyChardev *s = CHARDEV_PTY(opaque);
 
     pty_chr_timer_cancel(s);
     if (!s->connected) {
@@ -74,7 +74,7 @@ static gboolean pty_chr_timer(gpointer opaque)
 
 static void pty_chr_rearm_timer(Chardev *chr, int ms)
 {
-    PtyChardev *s = PTY_CHARDEV(chr);
+    PtyChardev *s = CHARDEV_PTY(chr);
     char *name;
 
     pty_chr_timer_cancel(s);
@@ -86,7 +86,7 @@ static void pty_chr_rearm_timer(Chardev *chr, int ms)
 
 static void pty_chr_update_read_handler(Chardev *chr)
 {
-    PtyChardev *s = PTY_CHARDEV(chr);
+    PtyChardev *s = CHARDEV_PTY(chr);
     GPollFD pfd;
     int rc;
     QIOChannelFile *fioc = QIO_CHANNEL_FILE(s->ioc);
@@ -108,7 +108,7 @@ static void pty_chr_update_read_handler(Chardev *chr)
 
 static int char_pty_chr_write(Chardev *chr, const uint8_t *buf, int len)
 {
-    PtyChardev *s = PTY_CHARDEV(chr);
+    PtyChardev *s = CHARDEV_PTY(chr);
 
     if (!s->connected) {
         return len;
@@ -118,7 +118,7 @@ static int char_pty_chr_write(Chardev *chr, const uint8_t *buf, int len)
 
 static GSource *pty_chr_add_watch(Chardev *chr, GIOCondition cond)
 {
-    PtyChardev *s = PTY_CHARDEV(chr);
+    PtyChardev *s = CHARDEV_PTY(chr);
     if (!s->connected) {
         return NULL;
     }
@@ -128,7 +128,7 @@ static GSource *pty_chr_add_watch(Chardev *chr, GIOCondition cond)
 static int pty_chr_read_poll(void *opaque)
 {
     Chardev *chr = CHARDEV(opaque);
-    PtyChardev *s = PTY_CHARDEV(opaque);
+    PtyChardev *s = CHARDEV_PTY(opaque);
 
     s->read_bytes = qemu_chr_be_can_write(chr);
     return s->read_bytes;
@@ -137,7 +137,7 @@ static int pty_chr_read_poll(void *opaque)
 static gboolean pty_chr_read(QIOChannel *chan, GIOCondition cond, void *opaque)
 {
     Chardev *chr = CHARDEV(opaque);
-    PtyChardev *s = PTY_CHARDEV(opaque);
+    PtyChardev *s = CHARDEV_PTY(opaque);
     gsize len;
     uint8_t buf[CHR_READ_BUF_LEN];
     ssize_t ret;
@@ -162,7 +162,7 @@ static gboolean pty_chr_read(QIOChannel *chan, GIOCondition cond, void *opaque)
 
 static void pty_chr_state(Chardev *chr, int connected)
 {
-    PtyChardev *s = PTY_CHARDEV(chr);
+    PtyChardev *s = CHARDEV_PTY(chr);
 
     if (!connected) {
         remove_fd_in_watch(chr);
@@ -189,7 +189,7 @@ static void pty_chr_state(Chardev *chr, int connected)
 static void char_pty_finalize(Object *obj)
 {
     Chardev *chr = CHARDEV(obj);
-    PtyChardev *s = PTY_CHARDEV(obj);
+    PtyChardev *s = CHARDEV_PTY(obj);
 
     pty_chr_state(chr, 0);
     object_unref(OBJECT(s->ioc));
@@ -220,7 +220,7 @@ static void char_pty_open(Chardev *chr,
     qemu_printf("char device redirected to %s (label %s)\n",
                 pty_name, chr->label);
 
-    s = PTY_CHARDEV(chr);
+    s = CHARDEV_PTY(chr);
     s->ioc = QIO_CHANNEL(qio_channel_file_new_fd(master_fd));
     name = g_strdup_printf("chardev-pty-%s", chr->label);
     qio_channel_set_name(QIO_CHANNEL(s->ioc), name);
-- 
2.26.2


