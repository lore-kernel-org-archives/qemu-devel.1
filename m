Received: from eggs.gnu.org ([2001:4830:134:3::10]:33908)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fziglio@redhat.com>) id 1cEwCz-0004Cy-V4
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 05:45:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fziglio@redhat.com>) id 1cEwCw-00065E-22
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 05:45:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53492)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <fziglio@redhat.com>) id 1cEwCv-00064l-R0
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 05:45:45 -0500
From: Frediano Ziglio <fziglio@redhat.com>
Date: Thu,  8 Dec 2016 10:45:39 +0000
Message-Id: <20161208104539.3045-1-fziglio@redhat.com>
Subject: [Qemu-devel] [PATCH v2] egl-helpers: Change file licensing to LGPLv2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Cole Robinson <crobinso@redhat.com>, Gonglei <arei.gonglei@huawei.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Frediano Ziglio <fziglio@redhat.com>

The relicense permits sharing the code with Spice which
is LGPL.

All people listed below have agreed to the
relicense:
- Arei Gonglei;
- Cole Robinson;
- Gerd Hoffmann;
- Peter Maydell.

Signed-off-by: Frediano Ziglio <fziglio@redhat.com>
Acked-by: Cole Robinson <crobinso@redhat.com>
---
 ui/egl-helpers.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

Changes since v1:
- extended commit message.

diff --git a/ui/egl-helpers.c b/ui/egl-helpers.c
index 79cee05..cd24568 100644
--- a/ui/egl-helpers.c
+++ b/ui/egl-helpers.c
@@ -1,3 +1,19 @@
+/*
+ * Copyright (C) 2015-2016 Gerd Hoffmann <kraxel@redhat.com>
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ */
 #include "qemu/osdep.h"
 #include <glob.h>
 #include <dirent.h>
-- 
2.9.3
