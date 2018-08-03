Received: from eggs.gnu.org ([2001:4830:134:3::10]:46902)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1flVp8-0007w1-AY
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 04:52:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1flVp7-0003X8-Gu
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 04:52:38 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:43986)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1flVp7-0003Tb-8i
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 04:52:37 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  3 Aug 2018 09:52:26 +0100
Message-Id: <20180803085230.30574-2-peter.maydell@linaro.org>
In-Reply-To: <20180803085230.30574-1-peter.maydell@linaro.org>
References: <20180803085230.30574-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 1/5] tests/vm: Use -cpu max rather than -cpu
 host
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

Currently attempting to run the vm-build-* tests on a system
where the user does not have access to KVM will fail, because
although they avoid using -enable-kvm, they use "-cpu host",
which only works with KVM. Switch to "-cpu max" instead, which
works with any accelerator.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/vm/basevm.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index 36431178161..ae9ab128c7b 100755
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -65,7 +65,7 @@ class BaseVM(object):
             self._stdout = self._devnull
         self._args = [ \
             "-nodefaults", "-m", "2G",
-            "-cpu", "host",
+            "-cpu", "max",
             "-netdev", "user,id=vnet,hostfwd=:127.0.0.1:0-:22",
             "-device", "virtio-net-pci,netdev=vnet",
             "-vnc", "127.0.0.1:0,to=20",
-- 
2.17.1
