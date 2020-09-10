Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA467C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 19:50:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94E05208E4
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 19:50:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VfGcX69L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94E05208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGSaZ-0005YL-JQ
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 15:50:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54158)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kGSZd-0003gb-Ae
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 15:49:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25573
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kGSZb-0000ad-BU
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 15:49:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599767374;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z/LWhJt78DIlQuX716+Xlg+qW9v9IeHJblIBLpCOQpc=;
 b=VfGcX69LeS28s5O70c3R1Fs+kxb1DrCZIpcuOAXrV7Fm/MSiwszVhtsfu9GsOSr0B9g+lO
 Z1zTGtpNud1xJHfIlejeBpMFZ5VL990EFSu0i2ya3pFM8jukZgmt2pcR28G8r5SND43yYx
 WMHXzHoUIkkfZvc5BvXPRNJWLHwt/bU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-332-pLKoXy7AOcCB2TgCh48p4g-1; Thu, 10 Sep 2020 15:49:33 -0400
X-MC-Unique: pLKoXy7AOcCB2TgCh48p4g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EF5A22FD04;
 Thu, 10 Sep 2020 19:49:31 +0000 (UTC)
Received: from localhost (ovpn-66-226.rdu2.redhat.com [10.10.66.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CCE9819C4F;
 Thu, 10 Sep 2020 19:49:25 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 04/18] chardev: Rename MOUSE_CHARDEV to CHARDEV_MSMOUSE
Date: Thu, 10 Sep 2020 15:48:49 -0400
Message-Id: <20200910194903.4104696-5-ehabkost@redhat.com>
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
Received-SPF: pass client-ip=205.139.110.120; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 09:07:42
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
TYPE_CHARDEV_MSMOUSE constant name and the QOM type name string
("chardev-msmouse").

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 chardev/msmouse.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/chardev/msmouse.c b/chardev/msmouse.c
index eb9231dcdb..5cc3055c53 100644
--- a/chardev/msmouse.c
+++ b/chardev/msmouse.c
@@ -45,12 +45,12 @@ struct MouseChardev {
 typedef struct MouseChardev MouseChardev;
 
 #define TYPE_CHARDEV_MSMOUSE "chardev-msmouse"
-DECLARE_INSTANCE_CHECKER(MouseChardev, MOUSE_CHARDEV,
+DECLARE_INSTANCE_CHECKER(MouseChardev, CHARDEV_MSMOUSE,
                          TYPE_CHARDEV_MSMOUSE)
 
 static void msmouse_chr_accept_input(Chardev *chr)
 {
-    MouseChardev *mouse = MOUSE_CHARDEV(chr);
+    MouseChardev *mouse = CHARDEV_MSMOUSE(chr);
     int len;
 
     len = qemu_chr_be_can_write(chr);
@@ -105,7 +105,7 @@ static void msmouse_queue_event(MouseChardev *mouse)
 static void msmouse_input_event(DeviceState *dev, QemuConsole *src,
                                 InputEvent *evt)
 {
-    MouseChardev *mouse = MOUSE_CHARDEV(dev);
+    MouseChardev *mouse = CHARDEV_MSMOUSE(dev);
     InputMoveEvent *move;
     InputBtnEvent *btn;
 
@@ -129,7 +129,7 @@ static void msmouse_input_event(DeviceState *dev, QemuConsole *src,
 
 static void msmouse_input_sync(DeviceState *dev)
 {
-    MouseChardev *mouse = MOUSE_CHARDEV(dev);
+    MouseChardev *mouse = CHARDEV_MSMOUSE(dev);
     Chardev *chr = CHARDEV(dev);
 
     msmouse_queue_event(mouse);
@@ -144,7 +144,7 @@ static int msmouse_chr_write(struct Chardev *s, const uint8_t *buf, int len)
 
 static void char_msmouse_finalize(Object *obj)
 {
-    MouseChardev *mouse = MOUSE_CHARDEV(obj);
+    MouseChardev *mouse = CHARDEV_MSMOUSE(obj);
 
     qemu_input_handler_unregister(mouse->hs);
 }
@@ -161,7 +161,7 @@ static void msmouse_chr_open(Chardev *chr,
                              bool *be_opened,
                              Error **errp)
 {
-    MouseChardev *mouse = MOUSE_CHARDEV(chr);
+    MouseChardev *mouse = CHARDEV_MSMOUSE(chr);
 
     *be_opened = false;
     mouse->hs = qemu_input_handler_register((DeviceState *)mouse,
-- 
2.26.2


