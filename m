Received: from eggs.gnu.org ([2001:4830:134:3::10]:60633)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1f5k90-0003iS-M3
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 23:40:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1f5k8z-0005zf-V7
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 23:40:30 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45210 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1f5k8z-0005zT-RG
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 23:40:29 -0400
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 10 Apr 2018 11:40:02 +0800
Message-Id: <1523331602-18781-7-git-send-email-jasowang@redhat.com>
In-Reply-To: <1523331602-18781-1-git-send-email-jasowang@redhat.com>
References: <1523331602-18781-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PULL 6/6] e1000: Old machine types,
 turn new subsection off
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Jason Wang <jasowang@redhat.com>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Turn the newly added subsection off for old machine types

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 include/hw/compat.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/hw/compat.h b/include/hw/compat.h
index bc9e3a6..13242b8 100644
--- a/include/hw/compat.h
+++ b/include/hw/compat.h
@@ -14,6 +14,10 @@
         .driver   = "vhost-user-blk-pci",\
         .property = "vectors",\
         .value    = "2",\
+    },{\
+        .driver   = "e1000",\
+        .property = "migrate_tso_props",\
+        .value    = "off",\
     },
 
 #define HW_COMPAT_2_10 \
-- 
2.7.4
