Received: from eggs.gnu.org ([2001:4830:134:3::10]:52408)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cOjdK-0001in-NU
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 06:21:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cOjdJ-0001tV-HW
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 06:21:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38570)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cOjdJ-0001t3-Aq
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 06:21:29 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 870454E338
	for <qemu-devel@nongnu.org>; Wed,  4 Jan 2017 11:21:29 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed,  4 Jan 2017 12:21:19 +0100
Message-Id: <1483528883-1753-8-git-send-email-kraxel@redhat.com>
In-Reply-To: <1483528883-1753-1-git-send-email-kraxel@redhat.com>
References: <1483528883-1753-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 07/11] egl-helpers: Change file licensing to
 LGPLv2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Frediano Ziglio <fziglio@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

From: Frediano Ziglio <fziglio@redhat.com>

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
Acked-by: Gonglei <arei.gonglei@huawei.com>
Acked-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20161208104539.3045-1-fziglio@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/egl-helpers.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

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
1.8.3.1
