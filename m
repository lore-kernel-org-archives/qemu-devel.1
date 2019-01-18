Received: from eggs.gnu.org ([209.51.188.92]:43353)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkVbl-00036d-A2
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:58:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkVbk-0007eW-J4
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:58:57 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:37112)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gkVbk-0007dP-DT
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:58:56 -0500
Received: by mail-wr1-x442.google.com with SMTP id s12so15436347wrt.4
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 06:58:56 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	e27sm92094561wra.67.2019.01.18.06.58.54 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 18 Jan 2019 06:58:54 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 Jan 2019 14:57:58 +0000
Message-Id: <20190118145805.6852-43-peter.maydell@linaro.org>
In-Reply-To: <20190118145805.6852-1-peter.maydell@linaro.org>
References: <20190118145805.6852-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 42/49] target/arm: Define FIELDs for ID_DFR0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Aaron Lindsay <aaron@os.amperecomputing.com>

This is immediately necessary for the PMUv3 implementation to check
ID_DFR0.PerfMon to enable/disable specific features, but defines the
full complement of fields for possible future use elsewhere.

Signed-off-by: Aaron Lindsay <aaron@os.amperecomputing.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20181211151945.29137-8-aaron@os.amperecomputing.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 964487d6863..79378df96e6 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1681,6 +1681,15 @@ FIELD(ID_AA64MMFR1, PAN, 20, 4)
 FIELD(ID_AA64MMFR1, SPECSEI, 24, 4)
 FIELD(ID_AA64MMFR1, XNX, 28, 4)
 
+FIELD(ID_DFR0, COPDBG, 0, 4)
+FIELD(ID_DFR0, COPSDBG, 4, 4)
+FIELD(ID_DFR0, MMAPDBG, 8, 4)
+FIELD(ID_DFR0, COPTRC, 12, 4)
+FIELD(ID_DFR0, MMAPTRC, 16, 4)
+FIELD(ID_DFR0, MPROFDBG, 20, 4)
+FIELD(ID_DFR0, PERFMON, 24, 4)
+FIELD(ID_DFR0, TRACEFILT, 28, 4)
+
 QEMU_BUILD_BUG_ON(ARRAY_SIZE(((ARMCPU *)0)->ccsidr) <= R_V7M_CSSELR_INDEX_MASK);
 
 /* If adding a feature bit which corresponds to a Linux ELF
-- 
2.20.1
