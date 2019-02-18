Received: from eggs.gnu.org ([209.51.188.92]:52251)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gvgqD-0006pa-6E
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 06:12:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gvgq9-0006dA-81
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 06:12:05 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Mon, 18 Feb 2019 12:11:44 +0100
Message-Id: <20190218111153.22681-2-cohuck@redhat.com>
In-Reply-To: <20190218111153.22681-1-cohuck@redhat.com>
References: <20190218111153.22681-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 01/10] s390x: Fix the confusing
 contributions-after-2012 license statements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>

From: Thomas Huth <thuth@redhat.com>

The license information in these files is rather confusing. The text
declares LGPL first, but then says that contributions after 2012 are
licensed under the GPL instead. How should the average user who just
downloaded the release tarball know which part is now GPL and which
is LGPL?

Looking at the text of the LGPL (see COPYING.LIB in the top directory),
the license clearly states how this should be done instead:

"3. You may opt to apply the terms of the ordinary GNU General Public
 License instead of this License to a given copy of the Library. To do
 this, you must alter all the notices that refer to this License, so
 that they refer to the ordinary GNU General Public License, version 2,
 instead of to this License."

Thus let's clean up the confusing statements and use the proper GPL
text only.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <1549456893-16589-1-git-send-email-thuth@redhat.com>
Acked-by: Laurent Vivier <laurent@vivier.eu>
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 linux-user/s390x/target_cpu.h | 19 ++++++++-----------
 target/s390x/cpu.c            | 19 ++++++++-----------
 target/s390x/cpu.h            | 19 ++++++++-----------
 target/s390x/kvm.c            | 19 ++++++++-----------
 4 files changed, 32 insertions(+), 44 deletions(-)

diff --git a/linux-user/s390x/target_cpu.h b/linux-user/s390x/target_cpu.h
index 66ef8aa8c27f..aa181ceaee83 100644
--- a/linux-user/s390x/target_cpu.h
+++ b/linux-user/s390x/target_cpu.h
@@ -3,21 +3,18 @@
  *
  * Copyright (c) 2009 Ulrich Hecht
  *
- * This library is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
  *
- * This library is distributed in the hope that it will be useful,
+ * This program is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Lesser General Public License for more details.
+ * General Public License for more details.
  *
- * Contributions after 2012-10-29 are licensed under the terms of the
- * GNU GPL, version 2 or (at your option) any later version.
- *
- * You should have received a copy of the GNU (Lesser) General Public
- * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 #ifndef S390X_TARGET_CPU_H
 #define S390X_TARGET_CPU_H
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 18ba7f85a5f1..698dd9cb82ab 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -6,21 +6,18 @@
  * Copyright (c) 2012 SUSE LINUX Products GmbH
  * Copyright (c) 2012 IBM Corp.
  *
- * This library is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; either
- * version 2.1 of the License, or (at your option) any later version.
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
  *
- * This library is distributed in the hope that it will be useful,
+ * This program is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Lesser General Public License for more details.
+ * General Public License for more details.
  *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, see
- * <http://www.gnu.org/licenses/lgpl-2.1.html>
- * Contributions after 2012-12-11 are licensed under the terms of the
- * GNU GPL, version 2 or (at your option) any later version.
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #include "qemu/osdep.h"
diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 47d2c2e9cf2b..b71ac5183dee 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -4,21 +4,18 @@
  *  Copyright (c) 2009 Ulrich Hecht
  *  Copyright IBM Corp. 2012, 2018
  *
- * This library is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
  *
- * This library is distributed in the hope that it will be useful,
+ * This program is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Lesser General Public License for more details.
+ * General Public License for more details.
  *
- * Contributions after 2012-10-29 are licensed under the terms of the
- * GNU GPL, version 2 or (at your option) any later version.
- *
- * You should have received a copy of the GNU (Lesser) General Public
- * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #ifndef S390X_CPU_H
diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index 8613e19d1143..9ff80c8461d0 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -4,21 +4,18 @@
  * Copyright (c) 2009 Alexander Graf <agraf@suse.de>
  * Copyright IBM Corp. 2012
  *
- * This library is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
  *
- * This library is distributed in the hope that it will be useful,
+ * This program is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Lesser General Public License for more details.
+ * General Public License for more details.
  *
- * Contributions after 2012-10-29 are licensed under the terms of the
- * GNU GPL, version 2 or (at your option) any later version.
- *
- * You should have received a copy of the GNU (Lesser) General Public
- * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #include "qemu/osdep.h"
-- 
2.17.2
