Received: from eggs.gnu.org ([2001:4830:134:3::10]:49951)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dcGck-0003HP-Vv
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 15:45:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dcGci-00059t-U2
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 15:45:07 -0400
Received: from mail-io0-x243.google.com ([2607:f8b0:4001:c06::243]:37709)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1dcGci-00059O-Px
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 15:45:04 -0400
Received: by mail-io0-x243.google.com with SMTP id c74so5518iod.4
	for <qemu-devel@nongnu.org>; Mon, 31 Jul 2017 12:45:04 -0700 (PDT)
From: John Arbuckle <programmingkidx@gmail.com>
Date: Mon, 31 Jul 2017 15:44:37 -0400
Message-Id: <20170731194437.4077-3-programmingkidx@gmail.com>
In-Reply-To: <20170731194437.4077-1-programmingkidx@gmail.com>
References: <20170731194437.4077-1-programmingkidx@gmail.com>
Subject: [Qemu-devel] [PATCH v3 2/2] Add more function keys to cocoa.m
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org, eblake@redhat.com, berrange@redhat.com
Cc: John Arbuckle <programmingkidx@gmail.com>

Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
Reviewed-by: Daniel P. Berrange <berrange@redhat.com>
---
 ui/cocoa.m | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/ui/cocoa.m b/ui/cocoa.m
index 93e56d0518..edc7a65f7c 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -225,6 +225,11 @@
     [kVK_F13] = Q_KEY_CODE_PRINT,
     [kVK_F14] = Q_KEY_CODE_SCROLL_LOCK,
     [kVK_F15] = Q_KEY_CODE_PAUSE,
+    [kVK_F16] = Q_KEY_CODE_F16,
+    [kVK_F17] = Q_KEY_CODE_F17,
+    [kVK_F18] = Q_KEY_CODE_F18,
+    [kVK_F19] = Q_KEY_CODE_F19,
+    [kVK_F20] = Q_KEY_CODE_F20
 
     /*
      * The eject and volume keys can't be used here because they are handled at
-- 
2.11.0 (Apple Git-81)
