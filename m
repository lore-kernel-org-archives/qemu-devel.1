Received: from eggs.gnu.org ([2001:4830:134:3::10]:44572)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dxXac-0000Oj-MG
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 08:06:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dxXaX-0007p5-4H
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 08:06:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34844)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dxXaW-0007og-Uj
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 08:06:45 -0400
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Thu, 28 Sep 2017 13:06:21 +0100
Message-Id: <20170928120621.30288-7-berrange@redhat.com>
In-Reply-To: <20170928120621.30288-1-berrange@redhat.com>
References: <20170928120621.30288-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v7 6/6] ui: don't export
 qemu_input_event_new_key
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Fam Zheng <famz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

All public code should use qemu_input_event_send_key* functions
instead of creating an event directly.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 include/ui/input.h | 1 -
 ui/input.c         | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/ui/input.h b/include/ui/input.h
index 479cc46cfc..f8cee43f65 100644
--- a/include/ui/input.h
+++ b/include/ui/input.h
@@ -38,7 +38,6 @@ void qemu_input_event_send_impl(QemuConsole *src, InputEvent *evt);
 void qemu_input_event_sync(void);
 void qemu_input_event_sync_impl(void);
 
-InputEvent *qemu_input_event_new_key(KeyValue *key, bool down);
 void qemu_input_event_send_key(QemuConsole *src, KeyValue *key, bool down);
 void qemu_input_event_send_key_number(QemuConsole *src, int num, bool down);
 void qemu_input_event_send_key_qcode(QemuConsole *src, QKeyCode q, bool down);
diff --git a/ui/input.c b/ui/input.c
index 4b241aa823..290b47354a 100644
--- a/ui/input.c
+++ b/ui/input.c
@@ -386,7 +386,7 @@ void qemu_input_event_sync(void)
     replay_input_sync_event();
 }
 
-InputEvent *qemu_input_event_new_key(KeyValue *key, bool down)
+static InputEvent *qemu_input_event_new_key(KeyValue *key, bool down)
 {
     InputEvent *evt = g_new0(InputEvent, 1);
     evt->u.key.data = g_new0(InputKeyEvent, 1);
-- 
2.13.5
