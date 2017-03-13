Received: from eggs.gnu.org ([2001:4830:134:3::10]:42864)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnW4Y-0000dc-DB
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 15:56:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnW4X-0002Qd-JF
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 15:56:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46570)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cnW4X-0002PY-9r
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 15:56:01 -0400
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 46B641293
	for <qemu-devel@nongnu.org>; Mon, 13 Mar 2017 19:56:01 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Mon, 13 Mar 2017 14:55:24 -0500
Message-Id: <20170313195547.21466-8-eblake@redhat.com>
In-Reply-To: <20170313195547.21466-1-eblake@redhat.com>
References: <20170313195547.21466-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v2 07/30] trace: Fix parameter types in ui
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, Gerd Hoffmann <kraxel@redhat.com>

An upcoming patch will let the compiler warn us when we are silently
losing precision in traces; update the trace definitions to pass
through the full value at the callsite.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 ui/trace-events | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/ui/trace-events b/ui/trace-events
index 93fe548..47f72f5 100644
--- a/ui/trace-events
+++ b/ui/trace-events
@@ -6,7 +6,7 @@ console_putchar_csi(int esc_param0, int esc_param1, int ch, int nb_esc_params) "
 console_putchar_unhandled(int ch) "unhandled escape character '%c'"
 console_txt_new(int w, int h) "%dx%d"
 console_select(int nr) "%d"
-console_refresh(int interval) "interval %d ms"
+console_refresh(uint64_t interval) "interval %" PRId64 " ms"
 displaysurface_create(void *display_surface, int w, int h) "surface=%p, %dx%d"
 displaysurface_create_from(void *display_surface, int w, int h, uint32_t format) "surface=%p, %dx%d, format 0x%x"
 displaysurface_create_pixman(void *display_surface) "surface=%p"
@@ -31,11 +31,11 @@ vnc_key_sync_numlock(bool on) "%d"
 vnc_key_sync_capslock(bool on) "%d"

 # ui/input.c
-input_event_key_number(int conidx, int number, const char *qcode, bool down) "con %d, key number 0x%x [%s], down %d"
+input_event_key_number(int conidx, uint64_t number, const char *qcode, bool down) "con %d, key number 0x%" PRIx64 " [%s], down %d"
 input_event_key_qcode(int conidx, const char *qcode, bool down) "con %d, key qcode %s, down %d"
 input_event_btn(int conidx, const char *btn, bool down) "con %d, button %s, down %d"
-input_event_rel(int conidx, const char *axis, int value) "con %d, axis %s, value %d"
-input_event_abs(int conidx, const char *axis, int value) "con %d, axis %s, value 0x%x"
+input_event_rel(int conidx, const char *axis, uint64_t value) "con %d, axis %s, value %" PRId64
+input_event_abs(int conidx, const char *axis, uint64_t value) "con %d, axis %s, value 0x%" PRIx64
 input_event_sync(void) ""
 input_mouse_mode(int absolute) "absolute %d"

-- 
2.9.3
