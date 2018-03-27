Received: from eggs.gnu.org ([2001:4830:134:3::10]:35643)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1f0msd-0005aR-7G
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 07:35:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1f0msY-0007Hc-N4
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 07:35:07 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44076 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1f0msY-0007HS-Jt
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 07:35:02 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Tue, 27 Mar 2018 12:34:52 +0100
Message-Id: <20180327113452.19613-4-dgilbert@redhat.com>
In-Reply-To: <20180327113452.19613-1-dgilbert@redhat.com>
References: <20180327113452.19613-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH 3/3] e1000: Old machine types,
 turn new subsection off
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, eswierk@skyportsystems.com, jasowang@redhat.com
Cc: quintela@redhat.com, peterx@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Turn the newly added subsection off for old machine types

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 include/hw/compat.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/hw/compat.h b/include/hw/compat.h
index bc9e3a6627..13242b831a 100644
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
2.14.3
