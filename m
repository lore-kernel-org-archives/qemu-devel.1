Received: from eggs.gnu.org ([208.118.235.92]:49552)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gbtkN-0003za-Fx
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 15:56:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gbtkK-0006d7-CF
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 15:56:15 -0500
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531]:44204)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gbtkK-0006cT-6I
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 15:56:12 -0500
Received: by mail-pg1-x531.google.com with SMTP id t13so6805109pgr.11
	for <qemu-devel@nongnu.org>; Tue, 25 Dec 2018 12:56:12 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 26 Dec 2018 07:54:51 +1100
Message-Id: <20181225205529.10874-5-richard.henderson@linaro.org>
In-Reply-To: <20181225205529.10874-1-richard.henderson@linaro.org>
References: <20181225205529.10874-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 04/42] exec: Add RISC-V GCC poison macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Alistair Francis <Alistair.Francis@wdc.com>, Alistair Francis <alistair.francis@wdc.com>, Michael Clark <mjc@sifive.com>

From: Alistair Francis <Alistair.Francis@wdc.com>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Michael Clark <mjc@sifive.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <00d02e34f10b87fd61f8dc69ac93d1eb63df949c.1545246859.git.alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/poison.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/exec/poison.h b/include/exec/poison.h
index 32d53789f8..ecdc83c147 100644
--- a/include/exec/poison.h
+++ b/include/exec/poison.h
@@ -79,6 +79,7 @@
 #pragma GCC poison CONFIG_MOXIE_DIS
 #pragma GCC poison CONFIG_NIOS2_DIS
 #pragma GCC poison CONFIG_PPC_DIS
+#pragma GCC poison CONFIG_RISCV_DIS
 #pragma GCC poison CONFIG_S390_DIS
 #pragma GCC poison CONFIG_SH4_DIS
 #pragma GCC poison CONFIG_SPARC_DIS
-- 
2.17.2
