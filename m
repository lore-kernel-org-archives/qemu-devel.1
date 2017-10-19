Received: from eggs.gnu.org ([2001:4830:134:3::10]:53711)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e5Boi-0000Mk-JB
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 10:29:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e5Bog-0005hp-Jk
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 10:29:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38115)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1e5Bog-0005hW-Dy
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 10:28:58 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 846443E2CE
	for <qemu-devel@nongnu.org>; Thu, 19 Oct 2017 14:28:57 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Thu, 19 Oct 2017 15:28:40 +0100
Message-Id: <20171019142848.572-2-berrange@redhat.com>
In-Reply-To: <20171019142848.572-1-berrange@redhat.com>
References: <20171019142848.572-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v1 1/9] input: use hex in ps2 keycode trace
 events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

Hardware scancodes are all documented in hex, so use that in trace
events to make it easier to understand.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 hw/input/trace-events | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/input/trace-events b/hw/input/trace-events
index 6fcb3c063f..d04132d342 100644
--- a/hw/input/trace-events
+++ b/hw/input/trace-events
@@ -1,7 +1,7 @@
 # See docs/devel/tracing.txt for syntax documentation.
 
 # hw/input/ps2.c
-ps2_put_keycode(void *opaque, int keycode) "%p keycode %d"
+ps2_put_keycode(void *opaque, int keycode) "%p keycode 0x%02x"
 ps2_read_data(void *opaque) "%p"
 ps2_set_ledstate(void *s, int ledstate) "%p ledstate %d"
 ps2_reset_keyboard(void *s) "%p"
-- 
2.13.6
