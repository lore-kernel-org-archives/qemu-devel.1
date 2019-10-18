Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1183CA9EA1
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 10:19:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAC632064B
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 10:19:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAC632064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLPM0-0007N4-7D
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 06:19:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53298)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1iLPJv-0005NT-1h
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 06:17:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1iLPJt-0002XS-Ut
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 06:17:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47996)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1iLPJt-0002Wt-P8
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 06:17:17 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0BD2810CC1E6;
 Fri, 18 Oct 2019 10:17:17 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-43.ams2.redhat.com
 [10.36.116.43])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 41EEA5D712;
 Fri, 18 Oct 2019 10:17:12 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 4DA719D34; Fri, 18 Oct 2019 12:17:11 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 4/4] ui: fix keymap file search in input-barrier object
Date: Fri, 18 Oct 2019 12:17:11 +0200
Message-Id: <20191018101711.24105-5-kraxel@redhat.com>
In-Reply-To: <20191018101711.24105-1-kraxel@redhat.com>
References: <20191018101711.24105-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.65]); Fri, 18 Oct 2019 10:17:17 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Laurent Vivier <laurent@vivier.eu>

If we try to start QEMU with "-k en-us", qemu prints a message and exits
with:

    qemu-system-i386: could not read keymap file: 'en-us'

It's because this function is called way too early, before
qemu_add_data_dir() is called, and so qemu_find_file() fails.

To fix that, move init_keyboard_layout() from the class init function to the
instance init function.

Reported-by: Anthony PERARD <anthony.perard@citrix.com>
Reviewed-by: Anthony PERARD <anthony.perard@citrix.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Message-id: 20190923220658.27007-1-laurent@vivier.eu
Fixes: 6105683da35b ("ui: add an embedded Barrier client")
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/input-barrier.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/ui/input-barrier.c b/ui/input-barrier.c
index a2c961f285a4..fe35049b83a2 100644
--- a/ui/input-barrier.c
+++ b/ui/input-barrier.c
@@ -682,6 +682,13 @@ static void input_barrier_instance_init(Object *obj)
 {
     InputBarrier *ib = INPUT_BARRIER(obj);
 
+    /* always use generic keymaps */
+    if (keyboard_layout && !kbd_layout) {
+        /* We use X11 key id, so use VNC name2keysym */
+        kbd_layout = init_keyboard_layout(name2keysym, keyboard_layout,
+                                          &error_fatal);
+    }
+
     ib->saddr.type = SOCKET_ADDRESS_TYPE_INET;
     ib->saddr.u.inet.host = g_strdup("localhost");
     ib->saddr.u.inet.port = g_strdup("24800");
@@ -719,13 +726,6 @@ static void input_barrier_class_init(ObjectClass *oc, void *data)
     UserCreatableClass *ucc = USER_CREATABLE_CLASS(oc);
 
     ucc->complete = input_barrier_complete;
-
-    /* always use generic keymaps */
-    if (keyboard_layout) {
-        /* We use X11 key id, so use VNC name2keysym */
-        kbd_layout = init_keyboard_layout(name2keysym, keyboard_layout,
-                                          &error_fatal);
-    }
 }
 
 static const TypeInfo input_barrier_info = {
-- 
2.18.1


