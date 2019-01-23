Received: from eggs.gnu.org ([209.51.188.92]:45511)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gmJiE-0003gC-DA
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 09:41:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gmJiB-0005At-Aq
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 09:41:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58646)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gmJiB-00058H-2g
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 09:41:03 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A25625A1FB
	for <qemu-devel@nongnu.org>; Wed, 23 Jan 2019 14:41:00 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
Date: Wed, 23 Jan 2019 15:40:54 +0100
Message-Id: <1548254454-7659-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] hw/usb: Fix LGPL information in the file
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
Cc: Gerd Hoffmann <kraxel@redhat.com>

It's either "GNU *Library* General Public version 2" or "GNU Lesser
General Public version *2.1*", but there was no "version 2.0" of the
"Lesser" library. So assume that version 2.1 is meant here.
Additionally, suggest that the user should have received a copy of
the LGPL, and not the GPL here.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/usb/combined-packet.c | 4 ++--
 hw/usb/hcd-ehci-pci.c    | 4 ++--
 hw/usb/hcd-ehci-sysbus.c | 4 ++--
 hw/usb/hcd-ehci.c        | 5 ++---
 hw/usb/hcd-ehci.h        | 4 ++--
 5 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/hw/usb/combined-packet.c b/hw/usb/combined-packet.c
index fc98383..37b23e2 100644
--- a/hw/usb/combined-packet.c
+++ b/hw/usb/combined-packet.c
@@ -9,14 +9,14 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or(at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  * Lesser General Public License for more details.
  *
- * You should have received a copy of the GNU General Public License
+ * You should have received a copy of the GNU Lesser General Public License
  * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 #include "qemu/osdep.h"
diff --git a/hw/usb/hcd-ehci-pci.c b/hw/usb/hcd-ehci-pci.c
index 69abbf7..38b24b1 100644
--- a/hw/usb/hcd-ehci-pci.c
+++ b/hw/usb/hcd-ehci-pci.c
@@ -4,14 +4,14 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or(at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  * Lesser General Public License for more details.
  *
- * You should have received a copy of the GNU General Public License
+ * You should have received a copy of the GNU Lesser General Public License
  * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
diff --git a/hw/usb/hcd-ehci-sysbus.c b/hw/usb/hcd-ehci-sysbus.c
index 331faf8..9f7f128 100644
--- a/hw/usb/hcd-ehci-sysbus.c
+++ b/hw/usb/hcd-ehci-sysbus.c
@@ -4,14 +4,14 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or(at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  * Lesser General Public License for more details.
  *
- * You should have received a copy of the GNU General Public License
+ * You should have received a copy of the GNU Lesser General Public License
  * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c
index e233681..9b132cb 100644
--- a/hw/usb/hcd-ehci.c
+++ b/hw/usb/hcd-ehci.c
@@ -12,18 +12,17 @@
  * Niels de Vos.  David S. Ahern continued working on it.  Kevin Wolf,
  * Jan Kiszka and Vincent Palatin contributed bugfixes.
  *
- *
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or(at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  * Lesser General Public License for more details.
  *
- * You should have received a copy of the GNU General Public License
+ * You should have received a copy of the GNU Lesser General Public License
  * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
diff --git a/hw/usb/hcd-ehci.h b/hw/usb/hcd-ehci.h
index d660170..fedf82c 100644
--- a/hw/usb/hcd-ehci.h
+++ b/hw/usb/hcd-ehci.h
@@ -4,14 +4,14 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or(at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  * Lesser General Public License for more details.
  *
- * You should have received a copy of the GNU General Public License
+ * You should have received a copy of the GNU Lesser General Public License
  * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
-- 
1.8.3.1
