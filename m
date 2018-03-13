Received: from eggs.gnu.org ([2001:4830:134:3::10]:55541)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1evnog-00005t-46
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 13:34:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1evnod-0007vP-Gn
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 13:34:26 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:39281)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1evnod-0007tk-3B
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 13:34:23 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue, 13 Mar 2018 18:33:49 +0100
Message-Id: <20180313173355.4468-13-laurent@vivier.eu>
In-Reply-To: <20180313173355.4468-1-laurent@vivier.eu>
References: <20180313173355.4468-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 12/18] linux-user: init_guest_space: Clean up if
 we can't initialize the commpage
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

We'll just exit with an error anyway, so it doesn't really matter, but it
is cleaned up in all of the other places were we error out.

Signed-off-by: Luke Shumaker <lukeshu@parabola.nu>
Message-Id: <20171228180814.9749-4-lukeshu@lukeshu.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/elfload.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index eaa52afe79..dcdd756908 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -1860,6 +1860,7 @@ unsigned long init_guest_space(unsigned long host_start,
             if (valid == 1) {
                 break;
             } else if (valid == -1) {
+                munmap((void *)real_start, host_size);
                 return (unsigned long)-1;
             }
             /* valid == 0, so try again. */
-- 
2.14.3
