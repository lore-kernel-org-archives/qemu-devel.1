Received: from eggs.gnu.org ([2001:4830:134:3::10]:52115)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eZd40-0007Qo-2s
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 08:38:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eZd3z-00004u-6G
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 08:38:36 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:45842)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1eZd3y-0008Ns-Vc
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 08:38:35 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1eZd3u-0005dv-9b
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 13:38:30 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 11 Jan 2018 13:38:03 +0000
Message-Id: <1515677902-23436-8-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1515677902-23436-1-git-send-email-peter.maydell@linaro.org>
References: <1515677902-23436-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 07/26] linux-user: Activate armeb handler
 registration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Michael Weiser <michael.weiser@gmx.de>

armeb is missing from the target list in qemu-binfmt-conf.sh. Add it so
the handler for those binaries gets registered by the script.

Signed-off-by: Michael Weiser <michael.weiser@gmx.de>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-id: 20171220212308.12614-8-michael.weiser@gmx.de
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 scripts/qemu-binfmt-conf.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/qemu-binfmt-conf.sh b/scripts/qemu-binfmt-conf.sh
index 597efdb..ea5a748 100755
--- a/scripts/qemu-binfmt-conf.sh
+++ b/scripts/qemu-binfmt-conf.sh
@@ -2,7 +2,7 @@
 # enable automatic i386/ARM/M68K/MIPS/SPARC/PPC/s390/HPPA
 # program execution by the kernel
 
-qemu_target_list="i386 i486 alpha arm sparc32plus ppc ppc64 ppc64le m68k \
+qemu_target_list="i386 i486 alpha arm armeb sparc32plus ppc ppc64 ppc64le m68k \
 mips mipsel mipsn32 mipsn32el mips64 mips64el \
 sh4 sh4eb s390x aarch64 aarch64_be hppa"
 
-- 
2.7.4
