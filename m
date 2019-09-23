Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE7AC432C1
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 22:07:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0FEB207FD
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 22:07:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0FEB207FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCWUu-0002HN-Uy
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 18:07:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56197)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iCWUE-0001pw-5N
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 18:07:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iCWUC-0006nT-Vx
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 18:07:14 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:36271)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iCWUC-0006fv-Mh
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 18:07:12 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MfYHQ-1hfgmD0W4W-00fxIH; Tue, 24 Sep 2019 00:07:01 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PATCH] ui: fix keymap file search in input-barrier object
Date: Tue, 24 Sep 2019 00:06:58 +0200
Message-Id: <20190923220658.27007-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:mSi8BYRgH1OAeHMEnXJMtlW5a8MRBrybG0+fUaQdttbIPIJiY/n
 /cX3PelUfTEgjeLFTVVjH7zpFSUiu/8hTV/7C2Kkiv8fFnzMlcxJyYZ3X4tAmf4CdG+FteM
 I1Ej8Wjpmq5vxdhveGG1awqPPL+YO1/bdQmBSmCGoMGaZUl/cdHt5rV+KHhnx4SrtNOE6UG
 Wld4IzQRF3YssCmug2eOQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:IU5MZxMyJaQ=:M+O7TgQGFZEg+ZaUVGssQN
 agT/SL4JJDujNIJ68ZTU+lXuzvEn8GEzhIYeAfKWJwBvNLlm2AsZR9cz70LwtzwFCer2PzGHH
 hPFO9/Ige+JwPbetNwRMplMI4xBAgYNqzt/hKUsp3kSa0i0SIs1iXn+sRiYZKp8wOjuIC1u7Q
 Ln62YHYR3dvGhr6lKr0TJYqMHfjt59Bs+YjLBEtOs2GLkIfxmNkppM7mt5WBrhPYRpJvhthFv
 YJl6frr4lVM2RJQuBt2In4Iog8UjCyLHiqbHTD40gabprTmteCankRtYalmJNtGHLRiVw/ZqI
 ivtDYOa/SyMNZKvVPtK6undJ+dKdMRFHZVwaj2W3Qrie+oeTnKcCRiAmrsuw+xbOCVxe00esG
 shv0n+Ai/I1DPyS/JmEaOpRWQmtWGDmBDXwtq7/uQXH2vNfcktClMPulDjouVxC7/5OTzZJB8
 drCaOZDhKVdwU3Z+m14iyuBlQQI2cRQwWYcgBTK+cGPKPe2bFSzNjFSP7WJw1QKPObqoLVNK9
 TeBOyCKmq6jdi9RzVsfB4NFJ6q13A4ybXDpDl1H39P1YIv6Vh92UeKGI9vL6YJueNr/rbrEZM
 54dMF31l+XsTUZbT1a4s9U7OfA6pZVtsDtDBuiRwTu04eCyAqiPUuB6riELfYA5fcB4hJ9WE6
 K4sP4AC86mdM7CzJ731CuONitCpy+zAnqR+EK3oOKpNGmhAiBUztLn3XXVU7CtRf5VjKSxX/f
 C9HV5AhXg0BClzk3/UTPweITjdDb+MHHlNBcENVGWz+LIFz8c8ussTiiTI6ZTOZySuE5MJiEI
 qIy8swcjKFjmbty0PnSr36g+RXCU1CG7LC7IjWRSCqFfmUYyuza7o7TEQc//Yu8KALwXOmAgr
 Mh5V6h7fk/VWWVPbht4A==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.187
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
Cc: Anthony PERARD <anthony.perard@citrix.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If we try to start QEMU with "-k en-us", qemu prints a message and exits
with:

    qemu-system-i386: could not read keymap file: 'en-us'

It's because this function is called way too early, before
qemu_add_data_dir() is called, and so qemu_find_file() fails.

To fix that, move init_keyboard_layout() from the class init function to the
instance init function.

Reported-by: Anthony PERARD <anthony.perard@citrix.com>
Fixes: 6105683da35b ("ui: add an embedded Barrier client")
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
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
2.21.0


