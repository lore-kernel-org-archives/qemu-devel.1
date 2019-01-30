Received: from eggs.gnu.org ([209.51.188.92]:37216)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gopq5-0001mh-NT
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 08:23:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gopq2-0006pm-2d
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 08:23:36 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Wed, 30 Jan 2019 14:22:09 +0100
Message-Id: <20190130132214.25493-9-laurent@vivier.eu>
In-Reply-To: <20190130132214.25493-1-laurent@vivier.eu>
References: <20190130132214.25493-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 08/13] target/tricore: Fix LGPL version number
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

Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Acked-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <1548252536-6242-4-git-send-email-thuth@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 target/tricore/cpu-qom.h         | 2 +-
 target/tricore/cpu.c             | 2 +-
 target/tricore/cpu.h             | 2 +-
 target/tricore/fpu_helper.c      | 2 +-
 target/tricore/helper.c          | 2 +-
 target/tricore/helper.h          | 2 +-
 target/tricore/op_helper.c       | 2 +-
 target/tricore/translate.c       | 2 +-
 target/tricore/tricore-defs.h    | 2 +-
 target/tricore/tricore-opcodes.h | 2 +-
 10 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/target/tricore/cpu-qom.h b/target/tricore/cpu-qom.h
index 6a69756126..93c9d77fe3 100644
--- a/target/tricore/cpu-qom.h
+++ b/target/tricore/cpu-qom.h
@@ -4,7 +4,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/tricore/cpu.c b/target/tricore/cpu.c
index 2edaef1aef..e8d37e4040 100644
--- a/target/tricore/cpu.c
+++ b/target/tricore/cpu.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/tricore/cpu.h b/target/tricore/cpu.h
index c3665c6ddd..00e69dc154 100644
--- a/target/tricore/cpu.h
+++ b/target/tricore/cpu.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/tricore/fpu_helper.c b/target/tricore/fpu_helper.c
index 31df462e4a..d8a6c0d25b 100644
--- a/target/tricore/fpu_helper.c
+++ b/target/tricore/fpu_helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/tricore/helper.c b/target/tricore/helper.c
index dad7eea085..0769046993 100644
--- a/target/tricore/helper.c
+++ b/target/tricore/helper.c
@@ -4,7 +4,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/tricore/helper.h b/target/tricore/helper.h
index e634d0c680..f60e81096b 100644
--- a/target/tricore/helper.h
+++ b/target/tricore/helper.h
@@ -4,7 +4,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/tricore/op_helper.c b/target/tricore/op_helper.c
index b57f35387d..ed9dc0c83e 100644
--- a/target/tricore/op_helper.c
+++ b/target/tricore/op_helper.c
@@ -4,7 +4,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index b5ab40d4a2..14f0ddfa1e 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/tricore/tricore-defs.h b/target/tricore/tricore-defs.h
index 40abfaac14..e871aa1c6b 100644
--- a/target/tricore/tricore-defs.h
+++ b/target/tricore/tricore-defs.h
@@ -4,7 +4,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/tricore/tricore-opcodes.h b/target/tricore/tricore-opcodes.h
index 2c3baab694..40bc121ba4 100644
--- a/target/tricore/tricore-opcodes.h
+++ b/target/tricore/tricore-opcodes.h
@@ -4,7 +4,7 @@
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
