Received: from eggs.gnu.org ([2001:4830:134:3::10]:39215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jinguojie@loongson.cn>) id 1cQWlt-0007iB-3B
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 05:01:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jinguojie@loongson.cn>) id 1cQWln-0006BK-71
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 05:01:45 -0500
Received: from [114.242.206.163] (port=51981 helo=mail.loongson.cn)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jinguojie@loongson.cn>) id 1cQWlm-0006AF-Ap
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 05:01:39 -0500
From: Jin Guojie <jinguojie@loongson.cn>
Date: Mon,  9 Jan 2017 18:01:23 +0800
Message-Id: <20170109100123.5080-2-jinguojie@loongson.cn>
In-Reply-To: <20170109100123.5080-1-jinguojie@loongson.cn>
References: <20170109100123.5080-1-jinguojie@loongson.cn>
Subject: [Qemu-devel] [PATCH 1/1] Change default CFLAGS to -O3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jin Guojie <jinguojie@loongson.cn>

For better performance.

Signed-off-by: Jin Guojie <jinguojie@loongson.cn>
---
 configure | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/configure b/configure
index 218df87..8ebc286 100755
--- a/configure
+++ b/configure
@@ -4753,9 +4753,9 @@ if test "$gcov" = "yes" ; then
   CFLAGS="-fprofile-arcs -ftest-coverage -g $CFLAGS"
   LDFLAGS="-fprofile-arcs -ftest-coverage $LDFLAGS"
 elif test "$fortify_source" = "yes" ; then
-  CFLAGS="-O2 -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=2 $CFLAGS"
+  CFLAGS="-O3 -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=2 $CFLAGS"
 elif test "$debug" = "no"; then
-  CFLAGS="-O2 $CFLAGS"
+  CFLAGS="-O3 $CFLAGS"
 fi
 
 ##########################################
-- 
2.9.3
