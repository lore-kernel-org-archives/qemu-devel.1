Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE1BDC433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 19:56:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A23B20882
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 19:56:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I07P92NJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A23B20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGSfu-0007oJ-FT
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 15:56:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54422)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kGSaa-0006CV-QY
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 15:50:36 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:55839
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kGSaY-0000l9-Sk
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 15:50:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599767434;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c2fYi56w25yKX3HrO4TcH8qU2ViT59jrGukaF3OOs3o=;
 b=I07P92NJuECMZv3tuPlVOXR+PIDofFj1mgW+RDCQR2wtvUFqOA+pDowQwqcvcPrU4lm2Cc
 c1hOGLdQU41ungAi02pj+aQZj+qNILJP+ueFJdprt74Lw0JvqYuhRzhtOOoQWjEotIke0F
 1zuaLvrnonzj0B44Sch1PKr4e6jh9Nc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-396-e7dMc9PcPuu8fwxKoiCH8A-1; Thu, 10 Sep 2020 15:50:32 -0400
X-MC-Unique: e7dMc9PcPuu8fwxKoiCH8A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 44403800683;
 Thu, 10 Sep 2020 19:50:31 +0000 (UTC)
Received: from localhost (ovpn-66-226.rdu2.redhat.com [10.10.66.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 95D7319C4F;
 Thu, 10 Sep 2020 19:50:25 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 15/18] chardev: Rename VC_CHARDEV to CHARDEV_VC
Date: Thu, 10 Sep 2020 15:49:00 -0400
Message-Id: <20200910194903.4104696-16-ehabkost@redhat.com>
In-Reply-To: <20200910194903.4104696-1-ehabkost@redhat.com>
References: <20200910194903.4104696-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 09:07:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 ui/console.c   | 10 +++++-----
 ui/gtk.c       |  8 ++++----
 ui/spice-app.c |  2 +-
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/ui/console.c b/ui/console.c
index f8d7643fe4..37a7c4a713 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -1090,12 +1090,12 @@ struct VCChardev {
 typedef struct VCChardev VCChardev;
 
 #define TYPE_CHARDEV_VC "chardev-vc"
-DECLARE_INSTANCE_CHECKER(VCChardev, VC_CHARDEV,
+DECLARE_INSTANCE_CHECKER(VCChardev, CHARDEV_VC,
                          TYPE_CHARDEV_VC)
 
 static int vc_chr_write(Chardev *chr, const uint8_t *buf, int len)
 {
-    VCChardev *drv = VC_CHARDEV(chr);
+    VCChardev *drv = CHARDEV_VC(chr);
     QemuConsole *s = drv->console;
     int i;
 
@@ -2108,7 +2108,7 @@ int qemu_console_get_height(QemuConsole *con, int fallback)
 
 static void vc_chr_set_echo(Chardev *chr, bool echo)
 {
-    VCChardev *drv = VC_CHARDEV(chr);
+    VCChardev *drv = CHARDEV_VC(chr);
     QemuConsole *s = drv->console;
 
     s->echo = echo;
@@ -2148,7 +2148,7 @@ static const GraphicHwOps text_console_ops = {
 
 static void text_console_do_init(Chardev *chr, DisplayState *ds)
 {
-    VCChardev *drv = VC_CHARDEV(chr);
+    VCChardev *drv = CHARDEV_VC(chr);
     QemuConsole *s = drv->console;
     int g_width = 80 * FONT_WIDTH;
     int g_height = 24 * FONT_HEIGHT;
@@ -2205,7 +2205,7 @@ static void vc_chr_open(Chardev *chr,
                         Error **errp)
 {
     ChardevVC *vc = backend->u.vc.data;
-    VCChardev *drv = VC_CHARDEV(chr);
+    VCChardev *drv = CHARDEV_VC(chr);
     QemuConsole *s;
     unsigned width = 0;
     unsigned height = 0;
diff --git a/ui/gtk.c b/ui/gtk.c
index 1c59de2af4..30c607a412 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -179,7 +179,7 @@ struct VCChardev {
 typedef struct VCChardev VCChardev;
 
 #define TYPE_CHARDEV_VC "chardev-vc"
-DECLARE_INSTANCE_CHECKER(VCChardev, VC_CHARDEV,
+DECLARE_INSTANCE_CHECKER(VCChardev, CHARDEV_VC,
                          TYPE_CHARDEV_VC)
 
 bool gtk_use_gl_area;
@@ -1693,7 +1693,7 @@ static void gd_vc_adjustment_changed(GtkAdjustment *adjustment, void *opaque)
 
 static int gd_vc_chr_write(Chardev *chr, const uint8_t *buf, int len)
 {
-    VCChardev *vcd = VC_CHARDEV(chr);
+    VCChardev *vcd = CHARDEV_VC(chr);
     VirtualConsole *vc = vcd->console;
 
     vte_terminal_feed(VTE_TERMINAL(vc->vte.terminal), (const char *)buf, len);
@@ -1702,7 +1702,7 @@ static int gd_vc_chr_write(Chardev *chr, const uint8_t *buf, int len)
 
 static void gd_vc_chr_set_echo(Chardev *chr, bool echo)
 {
-    VCChardev *vcd = VC_CHARDEV(chr);
+    VCChardev *vcd = CHARDEV_VC(chr);
     VirtualConsole *vc = vcd->console;
 
     if (vc) {
@@ -1784,7 +1784,7 @@ static GSList *gd_vc_vte_init(GtkDisplayState *s, VirtualConsole *vc,
     GtkWidget *box;
     GtkWidget *scrollbar;
     GtkAdjustment *vadjustment;
-    VCChardev *vcd = VC_CHARDEV(chr);
+    VCChardev *vcd = CHARDEV_VC(chr);
 
     vc->s = s;
     vc->vte.echo = vcd->echo;
diff --git a/ui/spice-app.c b/ui/spice-app.c
index 93e105c6ee..e66c422e02 100644
--- a/ui/spice-app.c
+++ b/ui/spice-app.c
@@ -47,7 +47,7 @@ struct VCChardev {
 typedef struct VCChardev VCChardev;
 
 #define TYPE_CHARDEV_VC "chardev-vc"
-DECLARE_INSTANCE_CHECKER(VCChardev, VC_CHARDEV,
+DECLARE_INSTANCE_CHECKER(VCChardev, CHARDEV_VC,
                          TYPE_CHARDEV_VC)
 
 static ChardevBackend *
-- 
2.26.2


