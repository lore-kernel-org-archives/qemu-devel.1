Received: from eggs.gnu.org ([209.51.188.92]:46735)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1gzQFm-0000ZF-5g
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 13:18:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1gzQFY-0002JW-7S
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 13:17:53 -0500
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231]:43867)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1gzQFV-0002CH-TM
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 13:17:40 -0500
Received: by mail-oi1-x231.google.com with SMTP id i8so17259350oib.10
	for <qemu-devel@nongnu.org>; Thu, 28 Feb 2019 10:17:25 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
From: minyard@acm.org
Date: Thu, 28 Feb 2019 12:17:03 -0600
Message-Id: <20190228181710.2477-13-minyard@acm.org>
In-Reply-To: <20190228181710.2477-1-minyard@acm.org>
References: <20190228181710.2477-1-minyard@acm.org>
Subject: [Qemu-devel] [PULL 12/19] migration: Add a VMSTATE_BOOL_TEST() macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, minyard@acm.org, Corey Minyard <cminyard@mvista.com>

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
