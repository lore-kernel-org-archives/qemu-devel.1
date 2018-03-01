Received: from eggs.gnu.org ([2001:4830:134:3::10]:33720)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1erMJt-0003hJ-EV
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 06:24:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1erMJp-00084X-Fi
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 06:24:17 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:46698)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1erMJp-00082m-9W
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 06:24:13 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1erMJo-0000Zc-0m
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 11:24:12 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu,  1 Mar 2018 11:23:32 +0000
Message-Id: <20180301112403.12487-12-peter.maydell@linaro.org>
In-Reply-To: <20180301112403.12487-1-peter.maydell@linaro.org>
References: <20180301112403.12487-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 11/42] target/arm/cpu.h: update comment for
 half-precision values
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Alex Bennée <alex.bennee@linaro.org>

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20180227143852.11175-4-alex.bennee@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 267a9d7e2f..25f31a4e21 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -168,6 +168,7 @@ typedef struct {
  *  Qn = regs[n].d[1]:regs[n].d[0]
  *  Dn = regs[n].d[0]
  *  Sn = regs[n].d[0] bits 31..0
+ *  Hn = regs[n].d[0] bits 15..0
  *
  * This corresponds to the architecturally defined mapping between
  * the two execution states, and means we do not need to explicitly
-- 
2.16.2
