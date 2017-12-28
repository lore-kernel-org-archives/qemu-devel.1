Received: from eggs.gnu.org ([2001:4830:134:3::10]:54709)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lukeshu@lukeshu.com>) id 1eUcbT-00086C-Ka
	for qemu-devel@nongnu.org; Thu, 28 Dec 2017 13:08:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lukeshu@lukeshu.com>) id 1eUcbQ-00013r-55
	for qemu-devel@nongnu.org; Thu, 28 Dec 2017 13:08:27 -0500
Received: from mav.lukeshu.com ([104.207.138.63]:58414)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lukeshu@lukeshu.com>) id 1eUcbQ-00013E-1l
	for qemu-devel@nongnu.org; Thu, 28 Dec 2017 13:08:24 -0500
From: Luke Shumaker <lukeshu@lukeshu.com>
Date: Thu, 28 Dec 2017 13:08:12 -0500
Message-Id: <20171228180814.9749-10-lukeshu@lukeshu.com>
In-Reply-To: <20171228180814.9749-1-lukeshu@lukeshu.com>
References: <20171228180814.9749-1-lukeshu@lukeshu.com>
Subject: [Qemu-devel] [PATCH 09/10] linux-user: init_guest_space: Add a
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
Cc: Luke Shumaker <lukeshu@parabola.nu>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>

From: Luke Shumaker <lukeshu@parabola.nu>

Signed-off-by: Luke Shumaker <lukeshu@parabola.nu>
---
 linux-user/elfload.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 1b7583d659..7736ea2c3a 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -1936,6 +1936,10 @@ unsigned long init_guest_space(unsigned long host_start,
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
2.15.1
