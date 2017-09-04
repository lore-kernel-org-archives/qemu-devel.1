Received: from eggs.gnu.org ([2001:4830:134:3::10]:44634)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1dovJj-0007uV-2S
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 13:37:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1dovJe-0002bq-HX
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 13:37:47 -0400
Received: from mout.gmx.net ([212.227.15.15]:61518)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <n54@gmx.com>) id 1dovJe-0002ap-2X
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 13:37:42 -0400
From: Kamil Rytarowski <n54@gmx.com>
Date: Mon,  4 Sep 2017 19:25:00 +0200
Message-Id: <20170904172500.26513-1-n54@gmx.com>
In-Reply-To: <20170903163455.15132-1-n54@gmx.com>
References: <20170903163455.15132-1-n54@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2] usb-mtp: Add fallback definition of NAME_MAX
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kraxel@redhat.com
Cc: qemu-devel@nongnu.org, f4bug@amsat.org, Kamil Rytarowski <n54@gmx.com>

This fixes build on SmartOS (Joyent).

Patch cherry-picked from pkgsrc by jperkin (Joyent).

Signed-off-by: Kamil Rytarowski <n54@gmx.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/qemu/osdep.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 6855b94bbf..5d3860f80e 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -306,6 +306,11 @@ void qemu_anon_ram_free(void *ptr, size_t size);
 #endif
 #endif
 
+/* Required by SmartOS (SunOS) */
+#ifndef NAME_MAX
+#define NAME_MAX 255
+#endif
+
 #if defined(__linux__) && \
     (defined(__x86_64__) || defined(__arm__) || defined(__aarch64__))
    /* Use 2 MiB alignment so transparent hugepages can be used by KVM.
-- 
2.14.1
