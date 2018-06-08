Received: from eggs.gnu.org ([2001:4830:134:3::10]:50570)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fRGlq-000375-LS
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 08:45:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fRGlp-0004JW-SK
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 08:45:34 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:42598)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fRGlp-0004Hv-J7
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 08:45:33 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fRGlo-0003j9-Fy
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:45:32 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  8 Jun 2018 13:45:05 +0100
Message-Id: <20180608124517.29475-20-peter.maydell@linaro.org>
In-Reply-To: <20180608124517.29475-1-peter.maydell@linaro.org>
References: <20180608124517.29475-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 19/31] hw/core/register: Add trailing '\n' to
 qemu_log() call
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 20180606152128.449-6-f4bug@amsat.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/core/register.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/core/register.c b/hw/core/register.c
index 0741a1af32a..d2d1636250b 100644
--- a/hw/core/register.c
+++ b/hw/core/register.c
@@ -96,7 +96,7 @@ void register_write(RegisterInfo *reg, uint64_t val, uint64_t we,
     if (test) {
         qemu_log_mask(LOG_UNIMP,
                       "%s:%s writing %#" PRIx64 " to unimplemented bits:" \
-                      " %#" PRIx64 "",
+                      " %#" PRIx64 "\n",
                       prefix, reg->access->name, val, ac->unimp);
     }
 
-- 
2.17.1
