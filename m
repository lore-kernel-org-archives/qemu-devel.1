Received: from eggs.gnu.org ([2001:4830:134:3::10]:53715)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1gRN81-0001lM-EE
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 15:05:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1gRN7y-0001LD-Ny
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 15:05:09 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:33660)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1gRN7y-0001If-Cg
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 15:05:06 -0500
Received: by mail-ot1-x341.google.com with SMTP id i20so17912772otl.0
	for <qemu-devel@nongnu.org>; Mon, 26 Nov 2018 12:05:01 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
From: minyard@acm.org
Date: Mon, 26 Nov 2018 14:04:28 -0600
Message-Id: <20181126200435.23408-10-minyard@acm.org>
In-Reply-To: <20181126200435.23408-1-minyard@acm.org>
References: <20181126200435.23408-1-minyard@acm.org>
Subject: [Qemu-devel] [PATCH v3 09/16] migration: Add a VMSTATE_BOOL_TEST()
 macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Corey Minyard <minyard@acm.org>, Corey Minyard <cminyard@mvista.com>

From: Corey Minyard <cminyard@mvista.com>

This will be needed by coming I2C changes.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
---
 include/migration/vmstate.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 2b501d0466..0861e18138 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -850,6 +850,9 @@ extern const VMStateInfo vmstate_info_qtailq;
 #define VMSTATE_INT32_POSITIVE_LE(_f, _s)                             \
     VMSTATE_SINGLE(_f, _s, 0, vmstate_info_int32_le, int32_t)
 
+#define VMSTATE_BOOL_TEST(_f, _s, _t)                               \
+    VMSTATE_SINGLE_TEST(_f, _s, _t, 0, vmstate_info_bool, bool)
+
 #define VMSTATE_INT8_TEST(_f, _s, _t)                               \
     VMSTATE_SINGLE_TEST(_f, _s, _t, 0, vmstate_info_int8, int8_t)
 
-- 
2.17.1
