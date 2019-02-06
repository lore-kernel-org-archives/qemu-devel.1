Received: from eggs.gnu.org ([209.51.188.92]:46046)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1grQIw-00037u-DC
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 11:44:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1grQIu-0005h7-8n
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 11:44:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48418)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1grQIu-0005eo-2n
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 11:44:04 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Wed,  6 Feb 2019 17:43:55 +0100
Message-Id: <1549471435-21887-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] hw/i2c/smbus_ich9: Fix the confusing
 contributions-after-2012 statement
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>

The license information in this file is rather confusing. The text
declares LGPL first, but then says that contributions after Jan 2012
are licensed under the GPL instead. How should the average user who
just downloaded the release tarball know which part is now GPL and
which is LGPL? Also, as far as I can see, the file has been added to
QEMU *after* January in 2012, so the whole file should be GPL by
default instead.

Furthermore, looking at the text of the LGPL (see COPYING.LIB in the
top directory), the license clearly states in section "3." that one
should rather replace the license information in such a case instead.
Thus let's clean up the confusing statements and use the proper GPL
text only.

While we're at it, also remove the comment about acpi.c, since that
file does not exist under this name in the QEMU tree anymore.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/i2c/smbus_ich9.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/hw/i2c/smbus_ich9.c b/hw/i2c/smbus_ich9.c
index 2a8b49e..484aef5 100644
--- a/hw/i2c/smbus_ich9.c
+++ b/hw/i2c/smbus_ich9.c
@@ -6,23 +6,18 @@
  *               VA Linux Systems Japan K.K.
  * Copyright (C) 2012 Jason Baron <jbaron@redhat.com>
  *
- * This is based on acpi.c, but heavily rewritten.
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
  *
- * This library is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License version 2 as published by the Free Software Foundation.
- *
- * This library is distributed in the hope that it will be useful,
+ * This program is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Lesser General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, see <http://www.gnu.org/licenses/>
- *
- * Contributions after 2012-01-13 are licensed under the terms of the
- * GNU GPL, version 2 or (at your option) any later version.
+ * General Public License for more details.
  *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>
  */
 #include "qemu/osdep.h"
 #include "hw/hw.h"
-- 
1.8.3.1
