Received: from eggs.gnu.org ([2001:4830:134:3::10]:55689)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eqgPF-0003ZB-JV
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 09:39:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eqgPC-0007uw-TH
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 09:39:01 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:35970)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1eqgPC-0007uT-MN
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 09:38:58 -0500
Received: by mail-wm0-x242.google.com with SMTP id 188so23612239wme.1
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 06:38:58 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 27 Feb 2018 14:38:24 +0000
Message-Id: <20180227143852.11175-4-alex.bennee@linaro.org>
In-Reply-To: <20180227143852.11175-1-alex.bennee@linaro.org>
References: <20180227143852.11175-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 03/31] target/arm/cpu.h: update comment for
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
v4
  - fix comment
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
2.15.1
