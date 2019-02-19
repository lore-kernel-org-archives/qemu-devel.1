Received: from eggs.gnu.org ([209.51.188.92]:50158)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gw9vv-0003CP-Ge
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 13:15:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gw9vh-0005QK-1R
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 13:15:44 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:53507 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gw9vf-0004um-SQ
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 13:15:40 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Tue, 19 Feb 2019 19:14:12 +0100
Message-Id: <1550600059-5789-3-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1550600059-5789-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1550600059-5789-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v2 2/9] tests/tcg: target/mips: Correct path to
 headers in some test source files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, amarkovic@wavecomp.com, peter.maydell@linaro.org, arikalo@wavecomp.com

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Correct path to headers in tests/tcg/mips/user/ase/msa/bit-counting/*
source files.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Reviewed-by: Aleksandar Rikalo <arikalo@wavecomp.com>
---
 tests/tcg/mips/user/ase/msa/bit-counting/test_msa_nloc_b.c | 6 +++---
 tests/tcg/mips/user/ase/msa/bit-counting/test_msa_nloc_d.c | 6 +++---
 tests/tcg/mips/user/ase/msa/bit-counting/test_msa_nloc_h.c | 6 +++---
 tests/tcg/mips/user/ase/msa/bit-counting/test_msa_nloc_w.c | 6 +++---
 tests/tcg/mips/user/ase/msa/bit-counting/test_msa_nlzc_b.c | 6 +++---
 tests/tcg/mips/user/ase/msa/bit-counting/test_msa_nlzc_d.c | 6 +++---
 tests/tcg/mips/user/ase/msa/bit-counting/test_msa_nlzc_h.c | 6 +++---
 tests/tcg/mips/user/ase/msa/bit-counting/test_msa_nlzc_w.c | 6 +++---
 tests/tcg/mips/user/ase/msa/bit-counting/test_msa_pcnt_b.c | 6 +++---
 tests/tcg/mips/user/ase/msa/bit-counting/test_msa_pcnt_d.c | 6 +++---
 tests/tcg/mips/user/ase/msa/bit-counting/test_msa_pcnt_h.c | 6 +++---
 tests/tcg/mips/user/ase/msa/bit-counting/test_msa_pcnt_w.c | 6 +++---
 12 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/tests/tcg/mips/user/ase/msa/bit-counting/test_msa_nloc_b.c b/tests/tcg/mips/user/ase/msa/bit-counting/test_msa_nloc_b.c
index eb46290..d629431 100644
--- a/tests/tcg/mips/user/ase/msa/bit-counting/test_msa_nloc_b.c
+++ b/tests/tcg/mips/user/ase/msa/bit-counting/test_msa_nloc_b.c
@@ -22,9 +22,9 @@
 #include <sys/time.h>
 #include <stdint.h>
 
-#include "../../../include/wrappers_msa.h"
-#include "../../../include/test_inputs.h"
-#include "../../../include/test_utils.h"
+#include "../../../../include/wrappers_msa.h"
+#include "../../../../include/test_inputs.h"
+#include "../../../../include/test_utils.h"
 
 #define TEST_COUNT_TOTAL (PATTERN_INPUTS_COUNT + RANDOM_INPUTS_COUNT)
 
diff --git a/tests/tcg/mips/user/ase/msa/bit-counting/test_msa_nloc_d.c b/tests/tcg/mips/user/ase/msa/bit-counting/test_msa_nloc_d.c
index bb1c0cf..fad220c 100644
--- a/tests/tcg/mips/user/ase/msa/bit-counting/test_msa_nloc_d.c
+++ b/tests/tcg/mips/user/ase/msa/bit-counting/test_msa_nloc_d.c
@@ -22,9 +22,9 @@
 #include <sys/time.h>
 #include <stdint.h>
 
-#include "../../../include/wrappers_msa.h"
-#include "../../../include/test_inputs.h"
-#include "../../../include/test_utils.h"
+#include "../../../../include/wrappers_msa.h"
+#include "../../../../include/test_inputs.h"
+#include "../../../../include/test_utils.h"
 
 #define TEST_COUNT_TOTAL (PATTERN_INPUTS_COUNT + RANDOM_INPUTS_COUNT)
 
diff --git a/tests/tcg/mips/user/ase/msa/bit-counting/test_msa_nloc_h.c b/tests/tcg/mips/user/ase/msa/bit-counting/test_msa_nloc_h.c
index da1cd83..84cf974 100644
--- a/tests/tcg/mips/user/ase/msa/bit-counting/test_msa_nloc_h.c
+++ b/tests/tcg/mips/user/ase/msa/bit-counting/test_msa_nloc_h.c
@@ -22,9 +22,9 @@
 #include <sys/time.h>
 #include <stdint.h>
 
-#include "../../../include/wrappers_msa.h"
-#include "../../../include/test_inputs.h"
-#include "../../../include/test_utils.h"
+#include "../../../../include/wrappers_msa.h"
+#include "../../../../include/test_inputs.h"
+#include "../../../../include/test_utils.h"
 
 #define TEST_COUNT_TOTAL (PATTERN_INPUTS_COUNT + RANDOM_INPUTS_COUNT)
 
diff --git a/tests/tcg/mips/user/ase/msa/bit-counting/test_msa_nloc_w.c b/tests/tcg/mips/user/ase/msa/bit-counting/test_msa_nloc_w.c
index a059763..a0ed202 100644
--- a/tests/tcg/mips/user/ase/msa/bit-counting/test_msa_nloc_w.c
+++ b/tests/tcg/mips/user/ase/msa/bit-counting/test_msa_nloc_w.c
@@ -22,9 +22,9 @@
 #include <sys/time.h>
 #include <stdint.h>
 
-#include "../../../include/wrappers_msa.h"
-#include "../../../include/test_inputs.h"
-#include "../../../include/test_utils.h"
+#include "../../../../include/wrappers_msa.h"
+#include "../../../../include/test_inputs.h"
+#include "../../../../include/test_utils.h"
 
 #define TEST_COUNT_TOTAL (PATTERN_INPUTS_COUNT + RANDOM_INPUTS_COUNT)
 
diff --git a/tests/tcg/mips/user/ase/msa/bit-counting/test_msa_nlzc_b.c b/tests/tcg/mips/user/ase/msa/bit-counting/test_msa_nlzc_b.c
index 9616d6e..9906eae 100644
--- a/tests/tcg/mips/user/ase/msa/bit-counting/test_msa_nlzc_b.c
+++ b/tests/tcg/mips/user/ase/msa/bit-counting/test_msa_nlzc_b.c
@@ -22,9 +22,9 @@
 #include <sys/time.h>
 #include <stdint.h>
 
-#include "../../../include/wrappers_msa.h"
-#include "../../../include/test_inputs.h"
-#include "../../../include/test_utils.h"
+#include "../../../../include/wrappers_msa.h"
+#include "../../../../include/test_inputs.h"
+#include "../../../../include/test_utils.h"
 
 #define TEST_COUNT_TOTAL (PATTERN_INPUTS_COUNT + RANDOM_INPUTS_COUNT)
 
diff --git a/tests/tcg/mips/user/ase/msa/bit-counting/test_msa_nlzc_d.c b/tests/tcg/mips/user/ase/msa/bit-counting/test_msa_nlzc_d.c
index 801c4bc..21222e3 100644
--- a/tests/tcg/mips/user/ase/msa/bit-counting/test_msa_nlzc_d.c
+++ b/tests/tcg/mips/user/ase/msa/bit-counting/test_msa_nlzc_d.c
@@ -22,9 +22,9 @@
 #include <sys/time.h>
 #include <stdint.h>
 
-#include "../../../include/wrappers_msa.h"
-#include "../../../include/test_inputs.h"
-#include "../../../include/test_utils.h"
+#include "../../../../include/wrappers_msa.h"
+#include "../../../../include/test_inputs.h"
+#include "../../../../include/test_utils.h"
 
 #define TEST_COUNT_TOTAL (PATTERN_INPUTS_COUNT + RANDOM_INPUTS_COUNT)
 
diff --git a/tests/tcg/mips/user/ase/msa/bit-counting/test_msa_nlzc_h.c b/tests/tcg/mips/user/ase/msa/bit-counting/test_msa_nlzc_h.c
index 03cb4cd..fbab9c3 100644
--- a/tests/tcg/mips/user/ase/msa/bit-counting/test_msa_nlzc_h.c
+++ b/tests/tcg/mips/user/ase/msa/bit-counting/test_msa_nlzc_h.c
@@ -22,9 +22,9 @@
 #include <sys/time.h>
 #include <stdint.h>
 
-#include "../../../include/wrappers_msa.h"
-#include "../../../include/test_inputs.h"
-#include "../../../include/test_utils.h"
+#include "../../../../include/wrappers_msa.h"
+#include "../../../../include/test_inputs.h"
+#include "../../../../include/test_utils.h"
 
 #define TEST_COUNT_TOTAL (PATTERN_INPUTS_COUNT + RANDOM_INPUTS_COUNT)
 
diff --git a/tests/tcg/mips/user/ase/msa/bit-counting/test_msa_nlzc_w.c b/tests/tcg/mips/user/ase/msa/bit-counting/test_msa_nlzc_w.c
index 2ca93de..dc33366 100644
--- a/tests/tcg/mips/user/ase/msa/bit-counting/test_msa_nlzc_w.c
+++ b/tests/tcg/mips/user/ase/msa/bit-counting/test_msa_nlzc_w.c
@@ -22,9 +22,9 @@
 #include <sys/time.h>
 #include <stdint.h>
 
-#include "../../../include/wrappers_msa.h"
-#include "../../../include/test_inputs.h"
-#include "../../../include/test_utils.h"
+#include "../../../../include/wrappers_msa.h"
+#include "../../../../include/test_inputs.h"
+#include "../../../../include/test_utils.h"
 
 #define TEST_COUNT_TOTAL (PATTERN_INPUTS_COUNT + RANDOM_INPUTS_COUNT)
 
diff --git a/tests/tcg/mips/user/ase/msa/bit-counting/test_msa_pcnt_b.c b/tests/tcg/mips/user/ase/msa/bit-counting/test_msa_pcnt_b.c
index b4cad43..f9033c7 100644
--- a/tests/tcg/mips/user/ase/msa/bit-counting/test_msa_pcnt_b.c
+++ b/tests/tcg/mips/user/ase/msa/bit-counting/test_msa_pcnt_b.c
@@ -22,9 +22,9 @@
 #include <sys/time.h>
 #include <stdint.h>
 
-#include "../../../include/wrappers_msa.h"
-#include "../../../include/test_inputs.h"
-#include "../../../include/test_utils.h"
+#include "../../../../include/wrappers_msa.h"
+#include "../../../../include/test_inputs.h"
+#include "../../../../include/test_utils.h"
 
 #define TEST_COUNT_TOTAL (PATTERN_INPUTS_COUNT + RANDOM_INPUTS_COUNT)
 
diff --git a/tests/tcg/mips/user/ase/msa/bit-counting/test_msa_pcnt_d.c b/tests/tcg/mips/user/ase/msa/bit-counting/test_msa_pcnt_d.c
index d6a8b0d..132b4d0 100644
--- a/tests/tcg/mips/user/ase/msa/bit-counting/test_msa_pcnt_d.c
+++ b/tests/tcg/mips/user/ase/msa/bit-counting/test_msa_pcnt_d.c
@@ -22,9 +22,9 @@
 #include <sys/time.h>
 #include <stdint.h>
 
-#include "../../../include/wrappers_msa.h"
-#include "../../../include/test_inputs.h"
-#include "../../../include/test_utils.h"
+#include "../../../../include/wrappers_msa.h"
+#include "../../../../include/test_inputs.h"
+#include "../../../../include/test_utils.h"
 
 #define TEST_COUNT_TOTAL (PATTERN_INPUTS_COUNT + RANDOM_INPUTS_COUNT)
 
diff --git a/tests/tcg/mips/user/ase/msa/bit-counting/test_msa_pcnt_h.c b/tests/tcg/mips/user/ase/msa/bit-counting/test_msa_pcnt_h.c
index 1cdcabd..f469c09 100644
--- a/tests/tcg/mips/user/ase/msa/bit-counting/test_msa_pcnt_h.c
+++ b/tests/tcg/mips/user/ase/msa/bit-counting/test_msa_pcnt_h.c
@@ -22,9 +22,9 @@
 #include <sys/time.h>
 #include <stdint.h>
 
-#include "../../../include/wrappers_msa.h"
-#include "../../../include/test_inputs.h"
-#include "../../../include/test_utils.h"
+#include "../../../../include/wrappers_msa.h"
+#include "../../../../include/test_inputs.h"
+#include "../../../../include/test_utils.h"
 
 #define TEST_COUNT_TOTAL (PATTERN_INPUTS_COUNT + RANDOM_INPUTS_COUNT)
 
diff --git a/tests/tcg/mips/user/ase/msa/bit-counting/test_msa_pcnt_w.c b/tests/tcg/mips/user/ase/msa/bit-counting/test_msa_pcnt_w.c
index 38ddc14..d73eff7 100644
--- a/tests/tcg/mips/user/ase/msa/bit-counting/test_msa_pcnt_w.c
+++ b/tests/tcg/mips/user/ase/msa/bit-counting/test_msa_pcnt_w.c
@@ -22,9 +22,9 @@
 #include <sys/time.h>
 #include <stdint.h>
 
-#include "../../../include/wrappers_msa.h"
-#include "../../../include/test_inputs.h"
-#include "../../../include/test_utils.h"
+#include "../../../../include/wrappers_msa.h"
+#include "../../../../include/test_inputs.h"
+#include "../../../../include/test_utils.h"
 
 #define TEST_COUNT_TOTAL (PATTERN_INPUTS_COUNT + RANDOM_INPUTS_COUNT)
 
-- 
2.7.4
