Received: from eggs.gnu.org ([2001:4830:134:3::10]:57010)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fpmFU-0007Ee-Qc
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 23:13:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fpmFT-0001SC-Rx
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 23:13:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35728 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1fpmFT-0001PH-78
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 23:13:27 -0400
From: Fam Zheng <famz@redhat.com>
Date: Wed, 15 Aug 2018 11:12:45 +0800
Message-Id: <20180815031248.14908-15-famz@redhat.com>
In-Reply-To: <20180815031248.14908-1-famz@redhat.com>
References: <20180815031248.14908-1-famz@redhat.com>
Subject: [Qemu-devel] [PULL 14/17] tests/vm: Bump guest RAM up from 2G to 4G
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>

From: Peter Maydell <peter.maydell@linaro.org>

Currently we run the guests in a VM which is given only 2G of RAM.
Since the guests are configured without any swap space, builds
can fail because the system runs out of memory and kills the
compiler, especially if the job count is set for a lot of
parallelism. Bump the setting up from 2G to 4G to give us some
more headroom.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20180803085230.30574-5-peter.maydell@linaro.org>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 tests/vm/basevm.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index d73cba9edb..d7149dea7d 100755
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -64,7 +64,7 @@ class BaseVM(object):
         else:
             self._stdout = self._devnull
         self._args = [ \
-            "-nodefaults", "-m", "2G",
+            "-nodefaults", "-m", "4G",
             "-netdev", "user,id=vnet,hostfwd=:127.0.0.1:0-:22",
             "-device", "virtio-net-pci,netdev=vnet",
             "-vnc", "127.0.0.1:0,to=20",
-- 
2.17.1
