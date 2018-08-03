Received: from eggs.gnu.org ([2001:4830:134:3::10]:46927)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1flVpA-0007wA-6i
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 04:52:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1flVp9-0003aE-EP
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 04:52:40 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:43986)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1flVp9-0003Tb-77
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 04:52:39 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  3 Aug 2018 09:52:29 +0100
Message-Id: <20180803085230.30574-5-peter.maydell@linaro.org>
In-Reply-To: <20180803085230.30574-1-peter.maydell@linaro.org>
References: <20180803085230.30574-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 4/5] tests/vm: Bump guest RAM up from 2G to 4G
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

Currently we run the guests in a VM which is given only 2G of RAM.
Since the guests are configured without any swap space, builds
can fail because the system runs out of memory and kills the
compiler, especially if the job count is set for a lot of
parallelism. Bump the setting up from 2G to 4G to give us some
more headroom.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Specifically I found the NetBSD build was falling over
with a J=16 level of parallelism.
---
 tests/vm/basevm.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index bf8b1bcfc5e..879229379d8 100755
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -64,7 +64,7 @@ class BaseVM(object):
         else:
             self._stdout = self._devnull
         self._args = [ \
-            "-nodefaults", "-m", "2G",
+            "-nodefaults", "-m", "4G",
             "-cpu", "max",
             "-netdev", "user,id=vnet,hostfwd=:127.0.0.1:0-:22",
             "-device", "virtio-net-pci,netdev=vnet",
-- 
2.17.1
