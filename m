Received: from eggs.gnu.org ([209.51.188.92]:36897)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1goBEH-00038N-Vc
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 13:01:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1goB7r-0005WG-Iw
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 12:55:30 -0500
Received: from mail-it1-x142.google.com ([2607:f8b0:4864:20::142]:53885)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1goB7r-0005V9-EW
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 12:55:15 -0500
Received: by mail-it1-x142.google.com with SMTP id g85so21920893ita.3
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 09:55:14 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
From: minyard@acm.org
Date: Mon, 28 Jan 2019 11:54:51 -0600
Message-Id: <20190128175458.27255-13-minyard@acm.org>
In-Reply-To: <20190128175458.27255-1-minyard@acm.org>
References: <20190128175458.27255-1-minyard@acm.org>
Subject: [Qemu-devel] [PATCH v4 12/19] migration: Add a VMSTATE_BOOL_TEST()
 macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Corey Minyard <minyard@acm.org>, Peter Maydell <peter.maydell@linaro.org>, Corey Minyard <cminyard@mvista.com>

From: Corey Minyard <cminyard@mvista.com>

This will be needed by coming I2C changes.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 include/migration/vmstate.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 067b126cf1..a668ec75b8 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -851,6 +851,9 @@ extern const VMStateInfo vmstate_info_qtailq;
 #define VMSTATE_INT32_POSITIVE_LE(_f, _s)                             \
     VMSTATE_SINGLE(_f, _s, 0, vmstate_info_int32_le, int32_t)
 
+#define VMSTATE_BOOL_TEST(_f, _s, _t)                               \
+    VMSTATE_SINGLE_TEST(_f, _s, _t, 0, vmstate_info_bool, bool)
+
 #define VMSTATE_INT8_TEST(_f, _s, _t)                               \
     VMSTATE_SINGLE_TEST(_f, _s, _t, 0, vmstate_info_int8, int8_t)
 
-- 
2.17.1
