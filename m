Received: from eggs.gnu.org ([2001:4830:134:3::10]:55597)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1evnoh-00007B-Bz
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 13:34:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1evnof-0007xo-Dr
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 13:34:27 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:47571)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1evnof-0007wH-2I
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 13:34:25 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue, 13 Mar 2018 18:33:52 +0100
Message-Id: <20180313173355.4468-16-laurent@vivier.eu>
In-Reply-To: <20180313173355.4468-1-laurent@vivier.eu>
References: <20180313173355.4468-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 15/18] linux-user: init_guest_commpage: Add a
 comment about size check
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
Message-Id: <20171228180814.9749-7-lukeshu@lukeshu.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/elfload.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 653157876c..8699f430b1 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -374,6 +374,11 @@ static int init_guest_commpage(unsigned long guest_base,
 
     /* If the commpage lies within the already allocated guest space,
      * then there is no way we can allocate it.
+     *
+     * You may be thinking that that this check is redundant because
+     * we already validated the guest size against MAX_RESERVED_VA;
+     * but if qemu_host_page_mask is unusually large, then
+     * test_page_addr may be lower.
      */
     if (test_page_addr >= guest_base
         && test_page_addr < (guest_base + guest_size)) {
-- 
2.14.3
