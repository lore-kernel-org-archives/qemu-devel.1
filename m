Received: from eggs.gnu.org ([2001:4830:134:3::10]:45121)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1cibfq-00079a-SQ
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 01:54:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1cibfo-0005tL-IA
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 01:54:14 -0500
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Tue, 28 Feb 2017 09:44:54 +0300
Message-Id: <79cad2faace2175f2f21dc4f8f40c3b7722cf999.1488264243.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1488264243.git.mjt@msgid.tls.msk.ru>
References: <cover.1488264243.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1488264243.git.mjt@msgid.tls.msk.ru>
References: <cover.1488264243.git.mjt@msgid.tls.msk.ru>
Subject: [Qemu-devel] [PULL 11/14] qemu-options.hx: add missing id=chr0
 chardev argument in vhost-user example
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Vincenzo Maffione <v.maffione@gmail.com>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>

From: Vincenzo Maffione <v.maffione@gmail.com>

In the vhost-user example, a chardev with id chr0 is referenced by the
vhost-user net backend, but the id is not specified in the chardev option.

Signed-off-by: Vincenzo Maffione <v.maffione@gmail.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 qemu-options.hx | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index bf458f8..faf5cf8 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -2146,7 +2146,7 @@ Example:
 @example
 qemu -m 512 -object memory-backend-file,id=mem,size=512M,mem-path=/hugetlbfs,share=on \
      -numa node,memdev=mem \
-     -chardev socket,path=/path/to/socket \
+     -chardev socket,id=chr0,path=/path/to/socket \
      -netdev type=vhost-user,id=net0,chardev=chr0 \
      -device virtio-net-pci,netdev=net0
 @end example
-- 
2.1.4
