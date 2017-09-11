Received: from eggs.gnu.org ([2001:4830:134:3::10]:48993)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1drQXb-0004CP-Ap
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 11:22:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1drQXW-0008PP-Cx
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 11:22:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51700)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1drQXW-0008Nh-70
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 11:22:22 -0400
From: David Hildenbrand <david@redhat.com>
Date: Mon, 11 Sep 2017 17:21:33 +0200
Message-Id: <20170911152150.12535-5-david@redhat.com>
In-Reply-To: <20170911152150.12535-1-david@redhat.com>
References: <20170911152150.12535-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v4 04/21] s390x: rename s390-virtio.h to
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
Cc: Richard Henderson <richard.henderson@linaro.org>, thuth@redhat.com, cohuck@redhat.com, david@redhat.com, borntraeger@de.ibm.com, Alexander Graf <agraf@suse.de>, Eduardo Habkost <ehabkost@redhat.com>, Matthew Rosato <mjrosato@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>

The only interface left, so let's properly rename it.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/s390x/s390-virtio-ccw.c                      | 2 +-
 hw/s390x/s390-virtio-hcall.c                    | 2 +-
 hw/s390x/{s390-virtio.h => s390-virtio-hcall.h} | 8 ++++----
 3 files changed, 6 insertions(+), 6 deletions(-)
 rename hw/s390x/{s390-virtio.h => s390-virtio-hcall.h} (77%)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 4c3a3e177b..f67b4b5d58 100644
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
similarity index 77%
rename from hw/s390x/s390-virtio.h
rename to hw/s390x/s390-virtio-hcall.h
index d984cd4115..59fcba3a06 100644
--- a/hw/s390x/s390-virtio.h
+++ b/hw/s390x/s390-virtio-hcall.h
@@ -1,5 +1,5 @@
 /*
- * Virtio interfaces for s390
+ * Support for virtio hypercalls on s390x
  *
  * Copyright 2012 IBM Corp.
  * Author(s): Cornelia Huck <cornelia.huck@de.ibm.com>
@@ -9,12 +9,12 @@
  * directory.
  */
 
-#ifndef HW_S390_VIRTIO_H
-#define HW_S390_VIRTIO_H
+#ifndef HW_S390_VIRTIO_HCALL_H
+#define HW_S390_VIRTIO_HCALL_H
 
 #include "standard-headers/asm-s390/kvm_virtio.h"
 #include "standard-headers/asm-s390/virtio-ccw.h"
 
 typedef int (*s390_virtio_fn)(const uint64_t *args);
 void s390_register_virtio_hypercall(uint64_t code, s390_virtio_fn fn);
-#endif
+#endif /* HW_S390_VIRTIO_HCALL_H */
-- 
2.13.5
