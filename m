Received: from eggs.gnu.org ([209.51.188.92]:37555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gopqJ-000203-EF
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 08:23:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gopqH-0007Ek-TM
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 08:23:51 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Wed, 30 Jan 2019 14:22:10 +0100
Message-Id: <20190130132214.25493-10-laurent@vivier.eu>
In-Reply-To: <20190130132214.25493-1-laurent@vivier.eu>
References: <20190130132214.25493-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 09/13] tcg: Fix LGPL version number
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Jiri Slaby <jslaby@suse.cz>, qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Richard Henderson <rth@twiddle.net>, Igor Mammedov <imammedo@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Riku Voipio <riku.voipio@iki.fi>, Stefan Hajnoczi <stefanha@redhat.com>, Stafford Horne <shorne@gmail.com>, Laurent Vivier <laurent@vivier.eu>, Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org, qemu-trivial@nongnu.org, Max Reitz <mreitz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Michael Tokarev <mjt@tls.msk.ru>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Thomas Huth <thuth@redhat.com>, Richard Henderson <richard.henderson@linaro.org>

From: Thomas Huth <thuth@redhat.com>

It's either "GNU *Library* General Public version 2" or "GNU Lesser
General Public version *2.1*", but there was no "version 2.0" of the
"Lesser" library. So assume that version 2.1 is meant here.

Cc: Richard Henderson <rth@twiddle.net>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <1548252536-6242-5-git-send-email-thuth@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 accel/tcg/atomic_template.h  | 2 +-
 accel/tcg/cpu-exec-common.c  | 2 +-
 accel/tcg/cpu-exec.c         | 2 +-
 accel/tcg/cputlb.c           | 2 +-
 accel/tcg/softmmu_template.h | 2 +-
 accel/tcg/tcg-runtime-gvec.c | 2 +-
 accel/tcg/translate-all.c    | 2 +-
 accel/tcg/translate-all.h    | 2 +-
 accel/tcg/user-exec.c        | 2 +-
 tcg/tcg-gvec-desc.h          | 2 +-
 tcg/tcg-op-gvec.c            | 2 +-
 tcg/tcg-op-gvec.h            | 2 +-
 tcg/tcg-op-vec.c             | 2 +-
 13 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/accel/tcg/atomic_template.h b/accel/tcg/atomic_template.h
index efde12fdb2..685602b076 100644
--- a/accel/tcg/atomic_template.h
+++ b/accel/tcg/atomic_template.h
@@ -7,7 +7,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/accel/tcg/cpu-exec-common.c b/accel/tcg/cpu-exec-common.c
index 2988fde650..462a1f1865 100644
--- a/accel/tcg/cpu-exec-common.c
+++ b/accel/tcg/cpu-exec-common.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 6c4a33262f..7cf1292546 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index dad9b7796c..f580e4dd7e 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/accel/tcg/softmmu_template.h b/accel/tcg/softmmu_template.h
index b0adea045e..1fdd262ea4 100644
--- a/accel/tcg/softmmu_template.h
+++ b/accel/tcg/softmmu_template.h
@@ -11,7 +11,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/accel/tcg/tcg-runtime-gvec.c b/accel/tcg/tcg-runtime-gvec.c
index 9358749741..e2c6f24262 100644
--- a/accel/tcg/tcg-runtime-gvec.c
+++ b/accel/tcg/tcg-runtime-gvec.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 7364e8a071..8f593b926f 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/accel/tcg/translate-all.h b/accel/tcg/translate-all.h
index 08e2f23a46..64f5fd9a05 100644
--- a/accel/tcg/translate-all.h
+++ b/accel/tcg/translate-all.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index 66cc818e3f..0789984fe6 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/tcg/tcg-gvec-desc.h b/tcg/tcg-gvec-desc.h
index 3b4c2d9c69..2dda7d6ba1 100644
--- a/tcg/tcg-gvec-desc.h
+++ b/tcg/tcg-gvec-desc.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
index 3ee44fcb75..0996ef0812 100644
--- a/tcg/tcg-op-gvec.c
+++ b/tcg/tcg-op-gvec.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/tcg/tcg-op-gvec.h b/tcg/tcg-op-gvec.h
index 4734eef7de..850da32ded 100644
--- a/tcg/tcg-op-gvec.h
+++ b/tcg/tcg-op-gvec.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/tcg/tcg-op-vec.c b/tcg/tcg-op-vec.c
index 36f35022ac..27f65600c3 100644
--- a/tcg/tcg-op-vec.c
+++ b/tcg/tcg-op-vec.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
-- 
2.20.1
