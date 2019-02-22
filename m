Received: from eggs.gnu.org ([209.51.188.92]:60456)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gx5eO-0006xv-7q
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 02:53:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gx5eM-0001YE-4f
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 02:53:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39122)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gx5eL-0001Ko-HG
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 02:53:37 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 97278307D977
	for <qemu-devel@nongnu.org>; Fri, 22 Feb 2019 07:53:27 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 22 Feb 2019 08:53:15 +0100
Message-Id: <20190222075326.9850-5-kraxel@redhat.com>
In-Reply-To: <20190222075326.9850-1-kraxel@redhat.com>
References: <20190222075326.9850-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 04/15] ui/gtk: Fix the license information
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Thomas Huth <thuth@redhat.com>

From: Thomas Huth <thuth@redhat.com>

The license information in this file is very messy. A short note at
the beginning says GPL first, but the long boilerplate code then
talks about "GNU Lesser General Public License version 2.0". First,
there is no such version of the "GNU Lesser GPL", it only started with
version 2.1. In version 2.0, it was still called "GNU Library GPL"
instead. Second, you can easily get the license of this file wrong
if you only quickly glance at the long boilerplate code.

Anyway, looking at the text of the LGPL (see COPYING.LIB in the top
directory), the license clearly states in section "3." that one should
rather replace the license information with the GPL information in
such a case of a mixture instead. Thus let's clean up the confusing
statements and use the proper GPL text only.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Message-id: 1550731902-28842-1-git-send-email-thuth@redhat.com

[ kraxel: s/v2/v2+/ as requested by Daniel ]

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/gtk.c | 30 +++++++++++++-----------------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/ui/gtk.c b/ui/gtk.c
index 949b143e4e4e..e96e15435a2f 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -6,29 +6,25 @@
  * Authors:
  *  Anthony Liguori   <aliguori@us.ibm.com>
  *
- * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
- * See the COPYING file in the top-level directory.
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
  *
- * Portions from gtk-vnc:
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ *
+ * Portions from gtk-vnc (originally licensed under the LGPL v2+):
  *
  * GTK VNC Widget
  *
  * Copyright (C) 2006  Anthony Liguori <anthony@codemonkey.ws>
  * Copyright (C) 2009-2010 Daniel P. Berrange <dan@berrange.com>
- *
- * This library is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; either
- * version 2.0 of the License, or (at your option) any later version.
- *
- * This library is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Lesser General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-=
1301 USA
  */
=20
 #define GETTEXT_PACKAGE "qemu"
--=20
2.9.3
