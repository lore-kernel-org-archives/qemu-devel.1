Received: from eggs.gnu.org ([2001:4830:134:3::10]:55630)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1evnoi-000093-P2
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 13:34:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1evnog-0007yp-6F
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 13:34:28 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:43713)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1evnof-0007xJ-To
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 13:34:26 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue, 13 Mar 2018 18:33:55 +0100
Message-Id: <20180313173355.4468-19-laurent@vivier.eu>
In-Reply-To: <20180313173355.4468-1-laurent@vivier.eu>
References: <20180313173355.4468-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 18/18] linux-user: init_guest_space: Add a
 comment about search strategy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>, Luke Shumaker <lukeshu@parabola.nu>

From: Luke Shumaker <lukeshu@parabola.nu>

Signed-off-by: Luke Shumaker <lukeshu@parabola.nu>
Message-Id: <20171228180814.9749-10-lukeshu@lukeshu.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/elfload.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 5c64299961..9d10a5f592 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -1910,6 +1910,10 @@ unsigned long init_guest_space(unsigned long host_start,
          * happen often.  Probably means we got unlucky and host
          * address space randomization put a shared library somewhere
          * inconvenient.
+         *
+         * This is probably a good strategy if host_start, but is
+         * probably a bad strategy if not, which means we got here
+         * because of trouble with ARM commpage setup.
          */
         munmap((void *)real_start, real_size);
         current_start += qemu_host_page_size;
-- 
2.14.3
