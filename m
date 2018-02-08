Received: from eggs.gnu.org ([2001:4830:134:3::10]:54229)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ejq3O-0003LP-8A
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 12:32:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ejq3I-0006T1-Cv
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 12:32:10 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:39047)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1ejq3I-0006Rp-68
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 12:32:04 -0500
Received: by mail-wm0-x244.google.com with SMTP id b21so11472819wme.4
	for <qemu-devel@nongnu.org>; Thu, 08 Feb 2018 09:32:04 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu,  8 Feb 2018 17:31:29 +0000
Message-Id: <20180208173157.24705-5-alex.bennee@linaro.org>
In-Reply-To: <20180208173157.24705-1-alex.bennee@linaro.org>
References: <20180208173157.24705-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 04/32] target/arm/cpu.h: update comment for
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
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index c793250186..f976969011 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -486,6 +486,7 @@ typedef struct CPUARMState {
          *  Qn = regs[2n+1]:regs[2n]
          *  Dn = regs[2n]
          *  Sn = regs[2n] bits 31..0
+         *  Hn = regs[2n] bits 15..0 for even n, and bits 31..16 for odd n
          * This corresponds to the architecturally defined mapping between
          * the two execution states, and means we do not need to explicitly
          * map these registers when changing states.
-- 
2.15.1
