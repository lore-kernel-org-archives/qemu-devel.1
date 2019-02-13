Received: from eggs.gnu.org ([209.51.188.92]:60978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gtww6-0004Ur-IB
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 10:58:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gtww4-0005gr-Cb
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 10:58:58 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Wed, 13 Feb 2019 16:58:50 +0100
Message-Id: <1550073530-4138-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] target/sh4: Fix LGPL information in the file
 headers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>
Cc: qemu-trivial@nongnu.org

It's either "GNU *Library* General Public License version 2" or "GNU
Lesser General Public License version *2.1*", but there was no "version
2.0" of the "Lesser" license. So assume that version 2.1 is meant here.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 linux-user/sh4/target_cpu.h     | 2 +-
 linux-user/sh4/target_structs.h | 2 +-
 target/sh4/cpu.h                | 2 +-
 target/sh4/gdbstub.c            | 2 +-
 target/sh4/helper.c             | 2 +-
 target/sh4/op_helper.c          | 2 +-
 target/sh4/translate.c          | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/linux-user/sh4/target_cpu.h b/linux-user/sh4/target_cpu.h
index 1a647dd..b0be9a2 100644
--- a/linux-user/sh4/target_cpu.h
+++ b/linux-user/sh4/target_cpu.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/linux-user/sh4/target_structs.h b/linux-user/sh4/target_structs.h
index 3e832bf..00ac394 100644
--- a/linux-user/sh4/target_structs.h
+++ b/linux-user/sh4/target_structs.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/sh4/cpu.h b/target/sh4/cpu.h
index 775b574..02a9f74 100644
--- a/target/sh4/cpu.h
+++ b/target/sh4/cpu.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/sh4/gdbstub.c b/target/sh4/gdbstub.c
index 13bea00..54568e9 100644
--- a/target/sh4/gdbstub.c
+++ b/target/sh4/gdbstub.c
@@ -7,7 +7,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/sh4/helper.c b/target/sh4/helper.c
index 2ff0cf4..fa51269 100644
--- a/target/sh4/helper.c
+++ b/target/sh4/helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/sh4/op_helper.c b/target/sh4/op_helper.c
index 4f825ba..28027f9 100644
--- a/target/sh4/op_helper.c
+++ b/target/sh4/op_helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index ab254b0..631b576 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
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
1.8.3.1
