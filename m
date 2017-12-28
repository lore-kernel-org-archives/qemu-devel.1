Received: from eggs.gnu.org ([2001:4830:134:3::10]:54596)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lukeshu@lukeshu.com>) id 1eUcbQ-00083z-VG
	for qemu-devel@nongnu.org; Thu, 28 Dec 2017 13:08:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lukeshu@lukeshu.com>) id 1eUcbP-00013H-Ol
	for qemu-devel@nongnu.org; Thu, 28 Dec 2017 13:08:24 -0500
Received: from mav.lukeshu.com ([2001:19f0:5c00:8069:5400:ff:fe26:6a86]:41894)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lukeshu@lukeshu.com>) id 1eUcbP-0000zS-KC
	for qemu-devel@nongnu.org; Thu, 28 Dec 2017 13:08:23 -0500
From: Luke Shumaker <lukeshu@lukeshu.com>
Date: Thu, 28 Dec 2017 13:08:06 -0500
Message-Id: <20171228180814.9749-4-lukeshu@lukeshu.com>
In-Reply-To: <20171228180814.9749-1-lukeshu@lukeshu.com>
References: <20171228180814.9749-1-lukeshu@lukeshu.com>
Subject: [Qemu-devel] [PATCH 03/10] linux-user: init_guest_space: Clean up
 if we can't initialize the commpage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Luke Shumaker <lukeshu@parabola.nu>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>

From: Luke Shumaker <lukeshu@parabola.nu>

We'll just exit with an error anyway, so it doesn't really matter, but it
is cleaned up in all of the other places were we error out.

Signed-off-by: Luke Shumaker <lukeshu@parabola.nu>
---
 linux-user/elfload.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 453394239c..1a6b660b25 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -1886,6 +1886,7 @@ unsigned long init_guest_space(unsigned long host_start,
             if (valid == 1) {
                 break;
             } else if (valid == -1) {
+                munmap((void *)real_start, host_size);
                 return (unsigned long)-1;
             }
             /* valid == 0, so try again. */
-- 
2.15.1
