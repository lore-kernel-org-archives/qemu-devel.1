Received: from eggs.gnu.org ([2001:4830:134:3::10]:33406)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dn6Rn-0005kT-6e
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 13:06:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dn6Rj-0002Rl-8I
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 13:06:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39984)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dn6Rj-0002QT-1S
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 13:06:31 -0400
From: David Hildenbrand <david@redhat.com>
Date: Wed, 30 Aug 2017 19:05:55 +0200
Message-Id: <20170830170601.15855-6-david@redhat.com>
In-Reply-To: <20170830170601.15855-1-david@redhat.com>
References: <20170830170601.15855-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 05/11] s390x: rename s390-virtio.h to
 s390-virtio-hcall.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>, thuth@redhat.com, cohuck@redhat.com, david@redhat.com, borntraeger@de.ibm.com, Alexander Graf <agraf@suse.de>

The only interface left, so let's properly rename it.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/s390x/s390-virtio-ccw.c                      | 2 +-
 hw/s390x/s390-virtio-hcall.c                    | 2 +-
 hw/s390x/{s390-virtio.h => s390-virtio-hcall.h} | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)
 rename hw/s390x/{s390-virtio.h => s390-virtio-hcall.h} (92%)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 41a9e976dc..03c88a524b 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -16,7 +16,7 @@
 #include "cpu.h"
 #include "hw/boards.h"
 #include "exec/address-spaces.h"
-#include "s390-virtio.h"
+#include "hw/s390x/s390-virtio-hcall.h"
 #include "hw/s390x/sclp.h"
 #include "hw/s390x/s390_flic.h"
 #include "hw/s390x/ioinst.h"
diff --git a/hw/s390x/s390-virtio-hcall.c b/hw/s390x/s390-virtio-hcall.c
index 23d67d6170..ec7cf8beb3 100644
--- a/hw/s390x/s390-virtio-hcall.c
+++ b/hw/s390x/s390-virtio-hcall.c
@@ -11,7 +11,7 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "hw/s390x/s390-virtio.h"
+#include "hw/s390x/s390-virtio-hcall.h"
 
 #define MAX_DIAG_SUBCODES 255
 
diff --git a/hw/s390x/s390-virtio.h b/hw/s390x/s390-virtio-hcall.h
similarity index 92%
rename from hw/s390x/s390-virtio.h
rename to hw/s390x/s390-virtio-hcall.h
index d984cd4115..64c5bbd827 100644
--- a/hw/s390x/s390-virtio.h
+++ b/hw/s390x/s390-virtio-hcall.h
@@ -1,5 +1,5 @@
 /*
- * Virtio interfaces for s390
+ * Support for virtio hypercalls on s390x
  *
  * Copyright 2012 IBM Corp.
  * Author(s): Cornelia Huck <cornelia.huck@de.ibm.com>
-- 
2.13.5
