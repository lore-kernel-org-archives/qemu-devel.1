Received: from eggs.gnu.org ([2001:4830:134:3::10]:44299)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1epFOt-0002j2-Jj
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 10:36:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1epFOs-0006x0-6b
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 10:36:43 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:33255)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1epFOr-0006vt-Vp
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 10:36:42 -0500
Received: by mail-wm0-x242.google.com with SMTP id s206so7424494wme.0
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 07:36:41 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 23 Feb 2018 15:36:08 +0000
Message-Id: <20180223153636.29809-4-alex.bennee@linaro.org>
In-Reply-To: <20180223153636.29809-1-alex.bennee@linaro.org>
References: <20180223153636.29809-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 03/31] target/arm/cpu.h: update comment for
 half-precision values
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 267a9d7e2f..c2bce23fa5 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -168,6 +168,7 @@ typedef struct {
  *  Qn = regs[n].d[1]:regs[n].d[0]
  *  Dn = regs[n].d[0]
  *  Sn = regs[n].d[0] bits 31..0
+ *  Hn = regs[n].d[0] bits 15..0 for even n, and bits 31..16 for odd n
  *
  * This corresponds to the architecturally defined mapping between
  * the two execution states, and means we do not need to explicitly
-- 
2.15.1
