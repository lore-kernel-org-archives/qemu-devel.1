Received: from eggs.gnu.org ([209.51.188.92]:45239)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gmcdD-0002VI-Qv
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 05:53:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gmcdC-0003b5-B4
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 05:53:11 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Thu, 24 Jan 2019 11:53:04 +0100
Message-Id: <1548327184-13416-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] target/m68k: Fix LGPL information in the file
 headers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Laurent Vivier <laurent@vivier.eu>

It's either "GNU *Library* General Public version 2" or "GNU Lesser
General Public version *2.1*", but there was no "version 2.0" of the
"Lesser" library. So assume that version 2.1 is meant here.
Also some files mentioned the GPL instead of the LGPL after declaring
that the files are licensed under the LGPL, so change these spots to
use LGPL, too.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 linux-user/m68k/target_cpu.h     | 4 ++--
 linux-user/m68k/target_structs.h | 2 +-
 target/m68k/cpu.h                | 4 ++--
 target/m68k/fpu_helper.c         | 4 ++--
 target/m68k/gdbstub.c            | 2 +-
 target/m68k/helper.c             | 4 ++--
 target/m68k/op_helper.c          | 2 +-
 target/m68k/translate.c          | 4 ++--
 8 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/linux-user/m68k/target_cpu.h b/linux-user/m68k/target_cpu.h
index 611df06..7a26f3c 100644
--- a/linux-user/m68k/target_cpu.h
+++ b/linux-user/m68k/target_cpu.h
@@ -7,12 +7,12 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
+ * Lesser General Public License for more details.
  *
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
diff --git a/linux-user/m68k/target_structs.h b/linux-user/m68k/target_structs.h
index a003676..e373d48 100644
--- a/linux-user/m68k/target_structs.h
+++ b/linux-user/m68k/target_structs.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index b288a38..f154565 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -7,12 +7,12 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
+ * Lesser General Public License for more details.
  *
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
diff --git a/target/m68k/fpu_helper.c b/target/m68k/fpu_helper.c
index 6eeffdf..b35489b 100644
--- a/target/m68k/fpu_helper.c
+++ b/target/m68k/fpu_helper.c
@@ -7,12 +7,12 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
+ * Lesser General Public License for more details.
  *
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
diff --git a/target/m68k/gdbstub.c b/target/m68k/gdbstub.c
index 99e5be8..fd2bb46 100644
--- a/target/m68k/gdbstub.c
+++ b/target/m68k/gdbstub.c
@@ -7,7 +7,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/m68k/helper.c b/target/m68k/helper.c
index 917d46e..3e26d33 100644
--- a/target/m68k/helper.c
+++ b/target/m68k/helper.c
@@ -7,12 +7,12 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
+ * Lesser General Public License for more details.
  *
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
diff --git a/target/m68k/op_helper.c b/target/m68k/op_helper.c
index 8d09ed9..76f4399 100644
--- a/target/m68k/op_helper.c
+++ b/target/m68k/op_helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 752e46e..6217a68 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -7,12 +7,12 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
+ * Lesser General Public License for more details.
  *
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
-- 
1.8.3.1
