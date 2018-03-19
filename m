Received: from eggs.gnu.org ([2001:4830:134:3::10]:56290)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1exufc-0003YU-Ru
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 09:17:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1exufb-0005Ct-St
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 09:17:48 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:40396)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1exufb-0005CM-MY
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 09:17:47 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 Mar 2018 13:17:43 +0000
Message-Id: <20180319131743.3885-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH for-2.12] gitmodules: Use the QEMU mirror of
 qemu-palcode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Stefan Hajnoczi <stefanha@redhat.com>, Richard Henderson <rth@twiddle.net>

We have a mirror of the qemu-palcode repository on
git.qemu.org; use that instead of the upstream github,
in line with our general policy of keeping and using
a mirror for submodules.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
We also currently have two submodules we don't have mirroring
for: seabios-hppa and u-boot-sam460ex.

 .gitmodules | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.gitmodules b/.gitmodules
index b76fb450a4..c613722e3c 100644
--- a/.gitmodules
+++ b/.gitmodules
@@ -18,7 +18,7 @@
 	url = git://git.qemu-project.org/openhackware.git
 [submodule "roms/qemu-palcode"]
 	path = roms/qemu-palcode
-	url = git://github.com/rth7680/qemu-palcode.git
+	url = git://git.qemu.org/qemu-palcode.git
 [submodule "roms/sgabios"]
 	path = roms/sgabios
 	url = git://git.qemu-project.org/sgabios.git
-- 
2.16.2
