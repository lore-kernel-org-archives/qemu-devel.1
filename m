Received: from eggs.gnu.org ([2001:4830:134:3::10]:57498)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aaron@os.amperecomputing.com>) id 1gWjqB-0004ET-4c
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 10:20:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aaron@os.amperecomputing.com>) id 1gWjq6-0001dF-SO
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 10:20:55 -0500
From: Aaron Lindsay <aaron@os.amperecomputing.com>
Date: Tue, 11 Dec 2018 15:20:32 +0000
Message-ID: <20181211151945.29137-8-aaron@os.amperecomputing.com>
References: <20181211151945.29137-1-aaron@os.amperecomputing.com>
In-Reply-To: <20181211151945.29137-1-aaron@os.amperecomputing.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v10 07/14] target/arm: Define FIELDs for ID_DFR0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>, Wei Huang <wei@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <richard.henderson@linaro.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Michael Spradling <mspradli@codeaurora.org>, Digant Desai <digantd@codeaurora.org>, Aaron Lindsay <aaron@os.amperecomputing.com>

This is immediately necessary for the PMUv3 implementation to check
ID_DFR0.PerfMon to enable/disable specific features, but defines the
full complement of fields for possible future use elsewhere.

Signed-off-by: Aaron Lindsay <aaron@os.amperecomputing.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 627e5c1995..2a64c1d858 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1586,6 +1586,15 @@ FIELD(ID_AA64PFR0, GIC, 24, 4)
 FIELD(ID_AA64PFR0, RAS, 28, 4)
 FIELD(ID_AA64PFR0, SVE, 32, 4)
=20
+FIELD(ID_DFR0, COPDBG, 0, 4)
+FIELD(ID_DFR0, COPSDBG, 4, 4)
+FIELD(ID_DFR0, MMAPDBG, 8, 4)
+FIELD(ID_DFR0, COPTRC, 12, 4)
+FIELD(ID_DFR0, MMAPTRC, 16, 4)
+FIELD(ID_DFR0, MPROFDBG, 20, 4)
+FIELD(ID_DFR0, PERFMON, 24, 4)
+FIELD(ID_DFR0, TRACEFILT, 28, 4)
+
 QEMU_BUILD_BUG_ON(ARRAY_SIZE(((ARMCPU *)0)->ccsidr) <=3D R_V7M_CSSELR_INDE=
X_MASK);
=20
 /* If adding a feature bit which corresponds to a Linux ELF
--=20
2.19.2
