Received: from eggs.gnu.org ([2001:4830:134:3::10]:41604)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1e32lS-0002Pc-Lx
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 12:24:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1e32lR-0006Ul-4A
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 12:24:46 -0400
Received: from mail-wr0-x232.google.com ([2a00:1450:400c:c0c::232]:44335)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1e32lQ-0006Tu-T2
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 12:24:45 -0400
Received: by mail-wr0-x232.google.com with SMTP id l24so1420968wre.1
	for <qemu-devel@nongnu.org>; Fri, 13 Oct 2017 09:24:44 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 13 Oct 2017 17:24:12 +0100
Message-Id: <20171013162438.32458-5-alex.bennee@linaro.org>
In-Reply-To: <20171013162438.32458-1-alex.bennee@linaro.org>
References: <20171013162438.32458-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 04/30] target/arm/cpu.h: update comment for
 half-precision values
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: richard.henderson@linaro.org
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/cpu.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 3a0f27c782..521b82d46e 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -488,6 +488,7 @@ typedef struct CPUARMState {
          *  Qn = regs[2n+1]:regs[2n]
          *  Dn = regs[2n]
          *  Sn = regs[2n] bits 31..0
+         *  Hn = regs[2n] bits 15..0 for even n, and bits 31..16 for odd n
          * This corresponds to the architecturally defined mapping between
          * the two execution states, and means we do not need to explicitly
          * map these registers when changing states.
-- 
2.14.1
