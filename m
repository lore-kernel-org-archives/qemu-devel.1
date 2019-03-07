Received: from eggs.gnu.org ([209.51.188.92]:47465)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1h1xLX-0004b0-SD
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 13:02:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1h1xLP-0003um-Ap
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 13:02:19 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:60381 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1h1xLO-0003sK-9O
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 13:02:11 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Thu,  7 Mar 2019 19:01:56 +0100
Message-Id: <1551981716-30664-3-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1551981716-30664-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1551981716-30664-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v2 2/2] tests/tcg: target/mips: Rename two
 header files for consistency
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, amarkovic@wavecomp.com, arikalo@wavecomp.com

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Rename two header files for consistency and clarity. Do all other
changes to accommodate new names.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Reviewed-by: Aleksandar Rikalo <amarkovic@wavecomp.com>
---
 tests/tcg/mips/include/{test_inputs.h => test_inputs_128.h} | 4 ++--
 tests/tcg/mips/include/{test_utils.h => test_utils_128.h}   | 4 ++--
 tests/tcg/mips/user/ase/msa/bit-count/test_msa_nloc_b.c     | 4 ++--
 tests/tcg/mips/user/ase/msa/bit-count/test_msa_nloc_d.c     | 4 ++--
 tests/tcg/mips/user/ase/msa/bit-count/test_msa_nloc_h.c     | 4 ++--
 tests/tcg/mips/user/ase/msa/bit-count/test_msa_nloc_w.c     | 4 ++--
 tests/tcg/mips/user/ase/msa/bit-count/test_msa_nlzc_b.c     | 4 ++--
 tests/tcg/mips/user/ase/msa/bit-count/test_msa_nlzc_d.c     | 4 ++--
 tests/tcg/mips/user/ase/msa/bit-count/test_msa_nlzc_h.c     | 4 ++--
 tests/tcg/mips/user/ase/msa/bit-count/test_msa_nlzc_w.c     | 4 ++--
 tests/tcg/mips/user/ase/msa/bit-count/test_msa_pcnt_b.c     | 4 ++--
 tests/tcg/mips/user/ase/msa/bit-count/test_msa_pcnt_d.c     | 4 ++--
 tests/tcg/mips/user/ase/msa/bit-count/test_msa_pcnt_h.c     | 4 ++--
 tests/tcg/mips/user/ase/msa/bit-count/test_msa_pcnt_w.c     | 4 ++--
 tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_b.c      | 4 ++--
 tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_d.c      | 4 ++--
 tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_h.c      | 4 ++--
 tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_w.c      | 4 ++--
 tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_b.c     | 4 ++--
 tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_d.c     | 4 ++--
 tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_h.c     | 4 ++--
 tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_w.c     | 4 ++--
 tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_b.c     | 4 ++--
 tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_d.c     | 4 ++--
 tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_h.c     | 4 ++--
 tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_w.c     | 4 ++--
 tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_b.c     | 4 ++--
 tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_d.c     | 4 ++--
 tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_h.c     | 4 ++--
 tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_w.c     | 4 ++--
 tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_b.c       | 4 ++--
 tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_d.c       | 4 ++--
 tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_h.c       | 4 ++--
 tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_w.c       | 4 ++--
 tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_s_d.c     | 4 ++--
 tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_s_h.c     | 4 ++--
 tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_s_w.c     | 4 ++--
 tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_u_d.c     | 4 ++--
 tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_u_h.c     | 4 ++--
 tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_u_w.c     | 4 ++--
 tests/tcg/mips/user/ase/msa/int-compare/test_msa_ceq_b.c    | 4 ++--
 tests/tcg/mips/user/ase/msa/int-compare/test_msa_ceq_d.c    | 4 ++--
 tests/tcg/mips/user/ase/msa/int-compare/test_msa_ceq_h.c    | 4 ++--
 tests/tcg/mips/user/ase/msa/int-compare/test_msa_ceq_w.c    | 4 ++--
 tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_s_b.c  | 4 ++--
 tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_s_d.c  | 4 ++--
 tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_s_h.c  | 4 ++--
 tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_s_w.c  | 4 ++--
 tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_u_b.c  | 4 ++--
 tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_u_d.c  | 4 ++--
 tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_u_h.c  | 4 ++--
 tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_u_w.c  | 4 ++--
 tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_s_b.c  | 4 ++--
 tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_s_d.c  | 4 ++--
 tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_s_h.c  | 4 ++--
 tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_s_w.c  | 4 ++--
 tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_u_b.c  | 4 ++--
 tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_u_d.c  | 4 ++--
 tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_u_h.c  | 4 ++--
 tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_u_w.c  | 4 ++--
 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_a_b.c  | 4 ++--
 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_a_d.c  | 4 ++--
 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_a_h.c  | 4 ++--
 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_a_w.c  | 4 ++--
 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_s_b.c  | 4 ++--
 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_s_d.c  | 4 ++--
 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_s_h.c  | 4 ++--
 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_s_w.c  | 4 ++--
 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_u_b.c  | 4 ++--
 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_u_d.c  | 4 ++--
 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_u_h.c  | 4 ++--
 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_u_w.c  | 4 ++--
 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_a_b.c  | 4 ++--
 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_a_d.c  | 4 ++--
 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_a_h.c  | 4 ++--
 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_a_w.c  | 4 ++--
 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_s_b.c  | 4 ++--
 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_s_d.c  | 4 ++--
 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_s_h.c  | 4 ++--
 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_s_w.c  | 4 ++--
 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_u_b.c  | 4 ++--
 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_u_d.c  | 4 ++--
 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_u_h.c  | 4 ++--
 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_u_w.c  | 4 ++--
 tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvev_b.c   | 4 ++--
 tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvev_d.c   | 4 ++--
 tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvev_h.c   | 4 ++--
 tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvev_w.c   | 4 ++--
 tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvl_b.c    | 4 ++--
 tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvl_d.c    | 4 ++--
 tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvl_h.c    | 4 ++--
 tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvl_w.c    | 4 ++--
 tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvod_b.c   | 4 ++--
 tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvod_d.c   | 4 ++--
 tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvod_h.c   | 4 ++--
 tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvod_w.c   | 4 ++--
 tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvr_b.c    | 4 ++--
 tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvr_d.c    | 4 ++--
 tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvr_h.c    | 4 ++--
 tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvr_w.c    | 4 ++--
 tests/tcg/mips/user/ase/msa/logic/test_msa_and_v.c          | 4 ++--
 tests/tcg/mips/user/ase/msa/logic/test_msa_nor_v.c          | 4 ++--
 tests/tcg/mips/user/ase/msa/logic/test_msa_or_v.c           | 4 ++--
 tests/tcg/mips/user/ase/msa/logic/test_msa_xor_v.c          | 4 ++--
 tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_b.c         | 4 ++--
 tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_d.c         | 4 ++--
 tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_h.c         | 4 ++--
 tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_w.c         | 4 ++--
 tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_b.c         | 4 ++--
 tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_d.c         | 4 ++--
 tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_h.c         | 4 ++--
 tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_w.c         | 4 ++--
 tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_b.c          | 4 ++--
 tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_d.c          | 4 ++--
 tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_h.c          | 4 ++--
 tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_w.c          | 4 ++--
 116 files changed, 232 insertions(+), 232 deletions(-)
 rename tests/tcg/mips/include/{test_inputs.h => test_inputs_128.h} (99%)
 rename tests/tcg/mips/include/{test_utils.h => test_utils_128.h} (97%)

diff --git a/tests/tcg/mips/include/test_inputs.h b/tests/tcg/mips/include/test_inputs_128.h
similarity index 99%
rename from tests/tcg/mips/include/test_inputs.h
rename to tests/tcg/mips/include/test_inputs_128.h
index a0bbbdf..e4c22dd 100644
--- a/tests/tcg/mips/include/test_inputs.h
+++ b/tests/tcg/mips/include/test_inputs_128.h
@@ -19,8 +19,8 @@
  *
  */
 
-#ifndef TEST_INPUTS_H
-#define TEST_INPUTS_H
+#ifndef TEST_INPUTS_128_H
+#define TEST_INPUTS_128_H
 
 #include <stdint.h>
 
diff --git a/tests/tcg/mips/include/test_utils.h b/tests/tcg/mips/include/test_utils_128.h
similarity index 97%
rename from tests/tcg/mips/include/test_utils.h
rename to tests/tcg/mips/include/test_utils_128.h
index 0b3af3d..cfd7ad3 100644
--- a/tests/tcg/mips/include/test_utils.h
+++ b/tests/tcg/mips/include/test_utils_128.h
@@ -19,8 +19,8 @@
  *
  */
 
-#ifndef TEST_UTILS_H
-#define TEST_UTILS_H
+#ifndef TEST_UTILS_128_H
+#define TEST_UTILS_128_H
 
 #include <stdio.h>
 #include <stdint.h>
diff --git a/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nloc_b.c b/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nloc_b.c
index 574fd75..c73ed24 100644
--- a/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nloc_b.c
+++ b/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nloc_b.c
@@ -23,8 +23,8 @@
 #include <stdint.h>
 
 #include "../../../../include/wrappers_msa.h"
-#include "../../../../include/test_inputs.h"
-#include "../../../../include/test_utils.h"
+#include "../../../../include/test_inputs_128.h"
+#include "../../../../include/test_utils_128.h"
 
 #define TEST_COUNT_TOTAL (PATTERN_INPUTS_COUNT + RANDOM_INPUTS_COUNT)
 
diff --git a/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nloc_d.c b/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nloc_d.c
index eec0bfe..b10fb23 100644
--- a/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nloc_d.c
+++ b/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nloc_d.c
@@ -23,8 +23,8 @@
 #include <stdint.h>
 
 #include "../../../../include/wrappers_msa.h"
-#include "../../../../include/test_inputs.h"
-#include "../../../../include/test_utils.h"
+#include "../../../../include/test_inputs_128.h"
+#include "../../../../include/test_utils_128.h"
 
 #define TEST_COUNT_TOTAL (PATTERN_INPUTS_COUNT + RANDOM_INPUTS_COUNT)
 
diff --git a/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nloc_h.c b/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nloc_h.c
index b338266..c1dc075 100644
--- a/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nloc_h.c
+++ b/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nloc_h.c
@@ -23,8 +23,8 @@
 #include <stdint.h>
 
 #include "../../../../include/wrappers_msa.h"
-#include "../../../../include/test_inputs.h"
-#include "../../../../include/test_utils.h"
+#include "../../../../include/test_inputs_128.h"
+#include "../../../../include/test_utils_128.h"
 
 #define TEST_COUNT_TOTAL (PATTERN_INPUTS_COUNT + RANDOM_INPUTS_COUNT)
 
diff --git a/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nloc_w.c b/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nloc_w.c
index e6f4546..4f7a556 100644
--- a/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nloc_w.c
+++ b/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nloc_w.c
@@ -23,8 +23,8 @@
 #include <stdint.h>
 
 #include "../../../../include/wrappers_msa.h"
-#include "../../../../include/test_inputs.h"
-#include "../../../../include/test_utils.h"
+#include "../../../../include/test_inputs_128.h"
+#include "../../../../include/test_utils_128.h"
 
 #define TEST_COUNT_TOTAL (PATTERN_INPUTS_COUNT + RANDOM_INPUTS_COUNT)
 
diff --git a/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nlzc_b.c b/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nlzc_b.c
index 430f30b..c202ba4 100644
--- a/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nlzc_b.c
+++ b/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nlzc_b.c
@@ -23,8 +23,8 @@
 #include <stdint.h>
 
 #include "../../../../include/wrappers_msa.h"
-#include "../../../../include/test_inputs.h"
-#include "../../../../include/test_utils.h"
+#include "../../../../include/test_inputs_128.h"
+#include "../../../../include/test_utils_128.h"
 
 #define TEST_COUNT_TOTAL (PATTERN_INPUTS_COUNT + RANDOM_INPUTS_COUNT)
 
diff --git a/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nlzc_d.c b/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nlzc_d.c
index 8dcd771..1edead2 100644
--- a/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nlzc_d.c
+++ b/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nlzc_d.c
@@ -23,8 +23,8 @@
 #include <stdint.h>
 
 #include "../../../../include/wrappers_msa.h"
-#include "../../../../include/test_inputs.h"
-#include "../../../../include/test_utils.h"
+#include "../../../../include/test_inputs_128.h"
+#include "../../../../include/test_utils_128.h"
 
 #define TEST_COUNT_TOTAL (PATTERN_INPUTS_COUNT + RANDOM_INPUTS_COUNT)
 
diff --git a/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nlzc_h.c b/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nlzc_h.c
index b329432..b2724c5 100644
--- a/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nlzc_h.c
+++ b/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nlzc_h.c
@@ -23,8 +23,8 @@
 #include <stdint.h>
 
 #include "../../../../include/wrappers_msa.h"
-#include "../../../../include/test_inputs.h"
-#include "../../../../include/test_utils.h"
+#include "../../../../include/test_inputs_128.h"
+#include "../../../../include/test_utils_128.h"
 
 #define TEST_COUNT_TOTAL (PATTERN_INPUTS_COUNT + RANDOM_INPUTS_COUNT)
 
diff --git a/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nlzc_w.c b/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nlzc_w.c
index 6cf28c3..b547c73 100644
--- a/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nlzc_w.c
+++ b/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nlzc_w.c
@@ -23,8 +23,8 @@
 #include <stdint.h>
 
 #include "../../../../include/wrappers_msa.h"
-#include "../../../../include/test_inputs.h"
-#include "../../../../include/test_utils.h"
+#include "../../../../include/test_inputs_128.h"
+#include "../../../../include/test_utils_128.h"
 
 #define TEST_COUNT_TOTAL (PATTERN_INPUTS_COUNT + RANDOM_INPUTS_COUNT)
 
diff --git a/tests/tcg/mips/user/ase/msa/bit-count/test_msa_pcnt_b.c b/tests/tcg/mips/user/ase/msa/bit-count/test_msa_pcnt_b.c
index cf2c088..5918e7f 100644
--- a/tests/tcg/mips/user/ase/msa/bit-count/test_msa_pcnt_b.c
+++ b/tests/tcg/mips/user/ase/msa/bit-count/test_msa_pcnt_b.c
@@ -23,8 +23,8 @@
 #include <stdint.h>
 
 #include "../../../../include/wrappers_msa.h"
-#include "../../../../include/test_inputs.h"
-#include "../../../../include/test_utils.h"
+#include "../../../../include/test_inputs_128.h"
+#include "../../../../include/test_utils_128.h"
 
 #define TEST_COUNT_TOTAL (PATTERN_INPUTS_COUNT + RANDOM_INPUTS_COUNT)
 
diff --git a/tests/tcg/mips/user/ase/msa/bit-count/test_msa_pcnt_d.c b/tests/tcg/mips/user/ase/msa/bit-count/test_msa_pcnt_d.c
index 26acf0c..667ca31 100644
--- a/tests/tcg/mips/user/ase/msa/bit-count/test_msa_pcnt_d.c
+++ b/tests/tcg/mips/user/ase/msa/bit-count/test_msa_pcnt_d.c
@@ -23,8 +23,8 @@
 #include <stdint.h>
 
 #include "../../../../include/wrappers_msa.h"
-#include "../../../../include/test_inputs.h"
-#include "../../../../include/test_utils.h"
+#include "../../../../include/test_inputs_128.h"
+#include "../../../../include/test_utils_128.h"
 
 #define TEST_COUNT_TOTAL (PATTERN_INPUTS_COUNT + RANDOM_INPUTS_COUNT)
 
diff --git a/tests/tcg/mips/user/ase/msa/bit-count/test_msa_pcnt_h.c b/tests/tcg/mips/user/ase/msa/bit-count/test_msa_pcnt_h.c
index ab76914..2951f86 100644
--- a/tests/tcg/mips/user/ase/msa/bit-count/test_msa_pcnt_h.c
+++ b/tests/tcg/mips/user/ase/msa/bit-count/test_msa_pcnt_h.c
@@ -23,8 +23,8 @@
 #include <stdint.h>
 
 #include "../../../../include/wrappers_msa.h"
-#include "../../../../include/test_inputs.h"
-#include "../../../../include/test_utils.h"
+#include "../../../../include/test_inputs_128.h"
+#include "../../../../include/test_utils_128.h"
 
 #define TEST_COUNT_TOTAL (PATTERN_INPUTS_COUNT + RANDOM_INPUTS_COUNT)
 
diff --git a/tests/tcg/mips/user/ase/msa/bit-count/test_msa_pcnt_w.c b/tests/tcg/mips/user/ase/msa/bit-count/test_msa_pcnt_w.c
index 2e6f290..ab43ea9 100644
--- a/tests/tcg/mips/user/ase/msa/bit-count/test_msa_pcnt_w.c
+++ b/tests/tcg/mips/user/ase/msa/bit-count/test_msa_pcnt_w.c
@@ -23,8 +23,8 @@
 #include <stdint.h>
 
 #include "../../../../include/wrappers_msa.h"
-#include "../../../../include/test_inputs.h"
-#include "../../../../include/test_utils.h"
+#include "../../../../include/test_inputs_128.h"
+#include "../../../../include/test_utils_128.h"
 
 #define TEST_COUNT_TOTAL (PATTERN_INPUTS_COUNT + RANDOM_INPUTS_COUNT)
 
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_b.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_b.c
index 8207b00..d2ea54f 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_b.c
@@ -23,8 +23,8 @@
 #include <stdint.h>
 
 #include "../../../../include/wrappers_msa.h"
-#include "../../../../include/test_inputs.h"
-#include "../../../../include/test_utils.h"
+#include "../../../../include/test_inputs_128.h"
+#include "../../../../include/test_utils_128.h"
 
 #define TEST_COUNT_TOTAL (                                                \
             (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_d.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_d.c
index 2cc0041..56b81f9 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_d.c
@@ -23,8 +23,8 @@
 #include <stdint.h>
 
 #include "../../../../include/wrappers_msa.h"
-#include "../../../../include/test_inputs.h"
-#include "../../../../include/test_utils.h"
+#include "../../../../include/test_inputs_128.h"
+#include "../../../../include/test_utils_128.h"
 
 #define TEST_COUNT_TOTAL (                                                \
             (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_h.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_h.c
index 24295bb..fe3c664 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_h.c
@@ -23,8 +23,8 @@
 #include <stdint.h>
 
 #include "../../../../include/wrappers_msa.h"
-#include "../../../../include/test_inputs.h"
-#include "../../../../include/test_utils.h"
+#include "../../../../include/test_inputs_128.h"
+#include "../../../../include/test_utils_128.h"
 
 #define TEST_COUNT_TOTAL (                                                \
             (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_w.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_w.c
index 03f8fd2..205117e 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_w.c
@@ -23,8 +23,8 @@
 #include <stdint.h>
 
 #include "../../../../include/wrappers_msa.h"
-#include "../../../../include/test_inputs.h"
-#include "../../../../include/test_utils.h"
+#include "../../../../include/test_inputs_128.h"
+#include "../../../../include/test_utils_128.h"
 
 #define TEST_COUNT_TOTAL (                                                \
             (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_b.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_b.c
index 0c8004b..6939e91 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_b.c
@@ -23,8 +23,8 @@
 #include <stdint.h>
 
 #include "../../../../include/wrappers_msa.h"
-#include "../../../../include/test_inputs.h"
-#include "../../../../include/test_utils.h"
+#include "../../../../include/test_inputs_128.h"
+#include "../../../../include/test_utils_128.h"
 
 #define TEST_COUNT_TOTAL (                                                \
             (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_d.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_d.c
index c21346f..af0f3d3 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_d.c
@@ -23,8 +23,8 @@
 #include <stdint.h>
 
 #include "../../../../include/wrappers_msa.h"
-#include "../../../../include/test_inputs.h"
-#include "../../../../include/test_utils.h"
+#include "../../../../include/test_inputs_128.h"
+#include "../../../../include/test_utils_128.h"
 
 #define TEST_COUNT_TOTAL (                                                \
             (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_h.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_h.c
index 2831580..4d3774f 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_h.c
@@ -23,8 +23,8 @@
 #include <stdint.h>
 
 #include "../../../../include/wrappers_msa.h"
-#include "../../../../include/test_inputs.h"
-#include "../../../../include/test_utils.h"
+#include "../../../../include/test_inputs_128.h"
+#include "../../../../include/test_utils_128.h"
 
 #define TEST_COUNT_TOTAL (                                                \
             (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_w.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_w.c
index b502c3b..6f06fdc 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_w.c
@@ -23,8 +23,8 @@
 #include <stdint.h>
 
 #include "../../../../include/wrappers_msa.h"
-#include "../../../../include/test_inputs.h"
-#include "../../../../include/test_utils.h"
+#include "../../../../include/test_inputs_128.h"
+#include "../../../../include/test_utils_128.h"
 
 #define TEST_COUNT_TOTAL (                                                \
             (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_b.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_b.c
index e4846c4..e6cb987 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_b.c
@@ -23,8 +23,8 @@
 #include <stdint.h>
 
 #include "../../../../include/wrappers_msa.h"
-#include "../../../../include/test_inputs.h"
-#include "../../../../include/test_utils.h"
+#include "../../../../include/test_inputs_128.h"
+#include "../../../../include/test_utils_128.h"
 
 #define TEST_COUNT_TOTAL (                                                \
             (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_d.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_d.c
index c733dba..2cda5d9 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_d.c
@@ -23,8 +23,8 @@
 #include <stdint.h>
 
 #include "../../../../include/wrappers_msa.h"
-#include "../../../../include/test_inputs.h"
-#include "../../../../include/test_utils.h"
+#include "../../../../include/test_inputs_128.h"
+#include "../../../../include/test_utils_128.h"
 
 #define TEST_COUNT_TOTAL (                                                \
             (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_h.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_h.c
index ec4edb8..5539322 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_h.c
@@ -23,8 +23,8 @@
 #include <stdint.h>
 
 #include "../../../../include/wrappers_msa.h"
-#include "../../../../include/test_inputs.h"
-#include "../../../../include/test_utils.h"
+#include "../../../../include/test_inputs_128.h"
+#include "../../../../include/test_utils_128.h"
 
 #define TEST_COUNT_TOTAL (                                                \
             (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_w.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_w.c
index b7385d6..4f2cc38 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_w.c
@@ -23,8 +23,8 @@
 #include <stdint.h>
 
 #include "../../../../include/wrappers_msa.h"
-#include "../../../../include/test_inputs.h"
-#include "../../../../include/test_utils.h"
+#include "../../../../include/test_inputs_128.h"
+#include "../../../../include/test_utils_128.h"
 
 #define TEST_COUNT_TOTAL (                                                \
             (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_b.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_b.c
index 341c420..e2d9be3 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_b.c
@@ -23,8 +23,8 @@
 #include <stdint.h>
 
 #include "../../../../include/wrappers_msa.h"
-#include "../../../../include/test_inputs.h"
-#include "../../../../include/test_utils.h"
+#include "../../../../include/test_inputs_128.h"
+#include "../../../../include/test_utils_128.h"
 
 #define TEST_COUNT_TOTAL (                                                \
             (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_d.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_d.c
index 414be70..8418c63 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_d.c
@@ -23,8 +23,8 @@
 #include <stdint.h>
 
 #include "../../../../include/wrappers_msa.h"
-#include "../../../../include/test_inputs.h"
-#include "../../../../include/test_utils.h"
+#include "../../../../include/test_inputs_128.h"
+#include "../../../../include/test_utils_128.h"
 
 #define TEST_COUNT_TOTAL (                                                \
             (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_h.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_h.c
index b6ca9c9..8a3b5c5 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_h.c
@@ -23,8 +23,8 @@
 #include <stdint.h>
 
 #include "../../../../include/wrappers_msa.h"
-#include "../../../../include/test_inputs.h"
-#include "../../../../include/test_utils.h"
+#include "../../../../include/test_inputs_128.h"
+#include "../../../../include/test_utils_128.h"
 
 #define TEST_COUNT_TOTAL (                                                \
             (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_w.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_w.c
index af30676..b18bdc3 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_w.c
@@ -23,8 +23,8 @@
 #include <stdint.h>
 
 #include "../../../../include/wrappers_msa.h"
-#include "../../../../include/test_inputs.h"
-#include "../../../../include/test_utils.h"
+#include "../../../../include/test_inputs_128.h"
+#include "../../../../include/test_utils_128.h"
 
 #define TEST_COUNT_TOTAL (                                                \
             (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_b.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_b.c
index 61aee3b..c86c992 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_b.c
@@ -23,8 +23,8 @@
 #include <stdint.h>
 
 #include "../../../../include/wrappers_msa.h"
-#include "../../../../include/test_inputs.h"
-#include "../../../../include/test_utils.h"
+#include "../../../../include/test_inputs_128.h"
+#include "../../../../include/test_utils_128.h"
 
 #define TEST_COUNT_TOTAL (                                                \
             (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_d.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_d.c
index 0e1b76f..0f30151 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_d.c
@@ -23,8 +23,8 @@
 #include <stdint.h>
 
 #include "../../../../include/wrappers_msa.h"
-#include "../../../../include/test_inputs.h"
-#include "../../../../include/test_utils.h"
+#include "../../../../include/test_inputs_128.h"
+#include "../../../../include/test_utils_128.h"
 
 #define TEST_COUNT_TOTAL (                                                \
             (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_h.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_h.c
index 35b79cf..c6b4cf6 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_h.c
@@ -23,8 +23,8 @@
 #include <stdint.h>
 
 #include "../../../../include/wrappers_msa.h"
-#include "../../../../include/test_inputs.h"
-#include "../../../../include/test_utils.h"
+#include "../../../../include/test_inputs_128.h"
+#include "../../../../include/test_utils_128.h"
 
 #define TEST_COUNT_TOTAL (                                                \
             (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_w.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_w.c
index b3c8e32..2a565e8 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_w.c
@@ -23,8 +23,8 @@
 #include <stdint.h>
 
 #include "../../../../include/wrappers_msa.h"
-#include "../../../../include/test_inputs.h"
-#include "../../../../include/test_utils.h"
+#include "../../../../include/test_inputs_128.h"
+#include "../../../../include/test_utils_128.h"
 
 #define TEST_COUNT_TOTAL (                                                \
             (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_s_d.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_s_d.c
index c455db5..7845dc0 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_s_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_s_d.c
@@ -23,8 +23,8 @@
 #include <stdint.h>
 
 #include "../../../../include/wrappers_msa.h"
-#include "../../../../include/test_inputs.h"
-#include "../../../../include/test_utils.h"
+#include "../../../../include/test_inputs_128.h"
+#include "../../../../include/test_utils_128.h"
 
 #define TEST_COUNT_TOTAL (                                                \
             (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_s_h.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_s_h.c
index 2b0e9d2..ddc2de3 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_s_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_s_h.c
@@ -23,8 +23,8 @@
 #include <stdint.h>
 
 #include "../../../../include/wrappers_msa.h"
-#include "../../../../include/test_inputs.h"
-#include "../../../../include/test_utils.h"
+#include "../../../../include/test_inputs_128.h"
+#include "../../../../include/test_utils_128.h"
 
 #define TEST_COUNT_TOTAL (                                                \
             (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_s_w.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_s_w.c
index 2c09066..887cd1c 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_s_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_s_w.c
@@ -23,8 +23,8 @@
 #include <stdint.h>
 
 #include "../../../../include/wrappers_msa.h"
-#include "../../../../include/test_inputs.h"
-#include "../../../../include/test_utils.h"
+#include "../../../../include/test_inputs_128.h"
+#include "../../../../include/test_utils_128.h"
 
 #define TEST_COUNT_TOTAL (                                                \
             (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_u_d.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_u_d.c
index 5662050..f0710f1 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_u_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_u_d.c
@@ -23,8 +23,8 @@
 #include <stdint.h>
 
 #include "../../../../include/wrappers_msa.h"
-#include "../../../../include/test_inputs.h"
-#include "../../../../include/test_utils.h"
+#include "../../../../include/test_inputs_128.h"
+#include "../../../../include/test_utils_128.h"
 
 #define TEST_COUNT_TOTAL (                                                \
             (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_u_h.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_u_h.c
index e23ac0a..fe55d3e 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_u_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_u_h.c
@@ -23,8 +23,8 @@
 #include <stdint.h>
 
 #include "../../../../include/wrappers_msa.h"
-#include "../../../../include/test_inputs.h"
-#include "../../../../include/test_utils.h"
+#include "../../../../include/test_inputs_128.h"
+#include "../../../../include/test_utils_128.h"
 
 #define TEST_COUNT_TOTAL (                                                \
             (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
diff --git a/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_u_w.c b/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_u_w.c
index c71d82a..babe04d 100644
--- a/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_u_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_u_w.c
@@ -23,8 +23,8 @@
 #include <stdint.h>
 
 #include "../../../../include/wrappers_msa.h"
-#include "../../../../include/test_inputs.h"
-#include "../../../../include/test_utils.h"
+#include "../../../../include/test_inputs_128.h"
+#include "../../../../include/test_utils_128.h"
 
 #define TEST_COUNT_TOTAL (                                                \
             (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
diff --git a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_ceq_b.c b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_ceq_b.c
index 1c38460..bb884ee 100644
--- a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_ceq_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_ceq_b.c
@@ -23,8 +23,8 @@
 #include <stdint.h>
 
 #include "../../../../include/wrappers_msa.h"
-#include "../../../../include/test_inputs.h"
-#include "../../../../include/test_utils.h"
+#include "../../../../include/test_inputs_128.h"
+#include "../../../../include/test_utils_128.h"
 
 #define TEST_COUNT_TOTAL (                                                \
             (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
diff --git a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_ceq_d.c b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_ceq_d.c
index 95c7c86..ef13f7d 100644
--- a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_ceq_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_ceq_d.c
@@ -23,8 +23,8 @@
 #include <stdint.h>
 
 #include "../../../../include/wrappers_msa.h"
-#include "../../../../include/test_inputs.h"
-#include "../../../../include/test_utils.h"
+#include "../../../../include/test_inputs_128.h"
+#include "../../../../include/test_utils_128.h"
 
 #define TEST_COUNT_TOTAL (                                                \
             (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
diff --git a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_ceq_h.c b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_ceq_h.c
index c54ed95..1c43d40 100644
--- a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_ceq_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_ceq_h.c
@@ -23,8 +23,8 @@
 #include <stdint.h>
 
 #include "../../../../include/wrappers_msa.h"
-#include "../../../../include/test_inputs.h"
-#include "../../../../include/test_utils.h"
+#include "../../../../include/test_inputs_128.h"
+#include "../../../../include/test_utils_128.h"
 
 #define TEST_COUNT_TOTAL (                                                \
             (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
diff --git a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_ceq_w.c b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_ceq_w.c
index 387b15d..1297d41 100644
--- a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_ceq_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_ceq_w.c
@@ -23,8 +23,8 @@
 #include <stdint.h>
 
 #include "../../../../include/wrappers_msa.h"
-#include "../../../../include/test_inputs.h"
-#include "../../../../include/test_utils.h"
+#include "../../../../include/test_inputs_128.h"
+#include "../../../../include/test_utils_128.h"
 
 #define TEST_COUNT_TOTAL (                                                \
             (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
diff --git a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_s_b.c b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_s_b.c
index 4c266cd..afd5f635 100644
--- a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_s_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_s_b.c
@@ -23,8 +23,8 @@
 #include <stdint.h>
 
 #include "../../../../include/wrappers_msa.h"
-#include "../../../../include/test_inputs.h"
-#include "../../../../include/test_utils.h"
+#include "../../../../include/test_inputs_128.h"
+#include "../../../../include/test_utils_128.h"
 
 #define TEST_COUNT_TOTAL (                                                \
             (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
diff --git a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_s_d.c b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_s_d.c
index d35ff2a..04d58d1 100644
--- a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_s_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_s_d.c
@@ -23,8 +23,8 @@
 #include <stdint.h>
 
 #include "../../../../include/wrappers_msa.h"
-#include "../../../../include/test_inputs.h"
-#include "../../../../include/test_utils.h"
+#include "../../../../include/test_inputs_128.h"
+#include "../../../../include/test_utils_128.h"
 
 #define TEST_COUNT_TOTAL (                                                \
             (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
diff --git a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_s_h.c b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_s_h.c
index 1dd23de..ed1a1e2 100644
--- a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_s_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_s_h.c
@@ -23,8 +23,8 @@
 #include <stdint.h>
 
 #include "../../../../include/wrappers_msa.h"
-#include "../../../../include/test_inputs.h"
-#include "../../../../include/test_utils.h"
+#include "../../../../include/test_inputs_128.h"
+#include "../../../../include/test_utils_128.h"
 
 #define TEST_COUNT_TOTAL (                                                \
             (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
diff --git a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_s_w.c b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_s_w.c
index 54c9696..ea4dc1a 100644
--- a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_s_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_s_w.c
@@ -23,8 +23,8 @@
 #include <stdint.h>
 
 #include "../../../../include/wrappers_msa.h"
-#include "../../../../include/test_inputs.h"
-#include "../../../../include/test_utils.h"
+#include "../../../../include/test_inputs_128.h"
+#include "../../../../include/test_utils_128.h"
 
 #define TEST_COUNT_TOTAL (                                                \
             (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
diff --git a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_u_b.c b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_u_b.c
index b8cc844..6e4fdd8 100644
--- a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_u_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_u_b.c
@@ -23,8 +23,8 @@
 #include <stdint.h>
 
 #include "../../../../include/wrappers_msa.h"
-#include "../../../../include/test_inputs.h"
-#include "../../../../include/test_utils.h"
+#include "../../../../include/test_inputs_128.h"
+#include "../../../../include/test_utils_128.h"
 
 #define TEST_COUNT_TOTAL (                                                \
             (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
diff --git a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_u_d.c b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_u_d.c
index e10e35f..b2b2f55 100644
--- a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_u_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_u_d.c
@@ -23,8 +23,8 @@
 #include <stdint.h>
 
 #include "../../../../include/wrappers_msa.h"
-#include "../../../../include/test_inputs.h"
-#include "../../../../include/test_utils.h"
+#include "../../../../include/test_inputs_128.h"
+#include "../../../../include/test_utils_128.h"
 
 #define TEST_COUNT_TOTAL (                                                \
             (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
diff --git a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_u_h.c b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_u_h.c
index af151f4..b226775 100644
--- a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_u_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_u_h.c
@@ -23,8 +23,8 @@
 #include <stdint.h>
 
 #include "../../../../include/wrappers_msa.h"
-#include "../../../../include/test_inputs.h"
-#include "../../../../include/test_utils.h"
+#include "../../../../include/test_inputs_128.h"
+#include "../../../../include/test_utils_128.h"
 
 #define TEST_COUNT_TOTAL (                                                \
             (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
diff --git a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_u_w.c b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_u_w.c
index 3ff612e..00e930c 100644
--- a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_u_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_u_w.c
@@ -23,8 +23,8 @@
 #include <stdint.h>
 
 #include "../../../../include/wrappers_msa.h"
-#include "../../../../include/test_inputs.h"
-#include "../../../../include/test_utils.h"
+#include "../../../../include/test_inputs_128.h"
+#include "../../../../include/test_utils_128.h"
 
 #define TEST_COUNT_TOTAL (                                                \
             (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
diff --git a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_s_b.c b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_s_b.c
index 32e6348..4a52ebe 100644
--- a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_s_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_s_b.c
@@ -23,8 +23,8 @@
 #include <stdint.h>
 
 #include "../../../../include/wrappers_msa.h"
-#include "../../../../include/test_inputs.h"
-#include "../../../../include/test_utils.h"
+#include "../../../../include/test_inputs_128.h"
+#include "../../../../include/test_utils_128.h"
 
 #define TEST_COUNT_TOTAL (                                                \
             (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
diff --git a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_s_d.c b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_s_d.c
index 39796cb..cc945cd 100644
--- a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_s_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_s_d.c
@@ -23,8 +23,8 @@
 #include <stdint.h>
 
 #include "../../../../include/wrappers_msa.h"
-#include "../../../../include/test_inputs.h"
-#include "../../../../include/test_utils.h"
+#include "../../../../include/test_inputs_128.h"
+#include "../../../../include/test_utils_128.h"
 
 #define TEST_COUNT_TOTAL (                                                \
             (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
diff --git a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_s_h.c b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_s_h.c
index ab9f6bc..b228dfe 100644
--- a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_s_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_s_h.c
@@ -23,8 +23,8 @@
 #include <stdint.h>
 
 #include "../../../../include/wrappers_msa.h"
-#include "../../../../include/test_inputs.h"
-#include "../../../../include/test_utils.h"
+#include "../../../../include/test_inputs_128.h"
+#include "../../../../include/test_utils_128.h"
 
 #define TEST_COUNT_TOTAL (                                                \
             (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
diff --git a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_s_w.c b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_s_w.c
index f7d0db4..6cb192a 100644
--- a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_s_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_s_w.c
@@ -23,8 +23,8 @@
 #include <stdint.h>
 
 #include "../../../../include/wrappers_msa.h"
-#include "../../../../include/test_inputs.h"
-#include "../../../../include/test_utils.h"
+#include "../../../../include/test_inputs_128.h"
+#include "../../../../include/test_utils_128.h"
 
 #define TEST_COUNT_TOTAL (                                                \
             (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
diff --git a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_u_b.c b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_u_b.c
index fc7a497..b6189d6 100644
--- a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_u_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_u_b.c
@@ -23,8 +23,8 @@
 #include <stdint.h>
 
 #include "../../../../include/wrappers_msa.h"
-#include "../../../../include/test_inputs.h"
-#include "../../../../include/test_utils.h"
+#include "../../../../include/test_inputs_128.h"
+#include "../../../../include/test_utils_128.h"
 
 #define TEST_COUNT_TOTAL (                                                \
             (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
diff --git a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_u_d.c b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_u_d.c
index 5072d09..4f547d8 100644
--- a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_u_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_u_d.c
@@ -23,8 +23,8 @@
 #include <stdint.h>
 
 #include "../../../../include/wrappers_msa.h"
-#include "../../../../include/test_inputs.h"
-#include "../../../../include/test_utils.h"
+#include "../../../../include/test_inputs_128.h"
+#include "../../../../include/test_utils_128.h"
 
 #define TEST_COUNT_TOTAL (                                                \
             (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
diff --git a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_u_h.c b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_u_h.c
index face857..9fcd81c 100644
--- a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_u_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_u_h.c
@@ -23,8 +23,8 @@
 #include <stdint.h>
 
 #include "../../../../include/wrappers_msa.h"
-#include "../../../../include/test_inputs.h"
-#include "../../../../include/test_utils.h"
+#include "../../../../include/test_inputs_128.h"
+#include "../../../../include/test_utils_128.h"
 
 #define TEST_COUNT_TOTAL (                                                \
             (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
diff --git a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_u_w.c b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_u_w.c
index bddda8a..8f648af 100644
--- a/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_u_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_u_w.c
@@ -23,8 +23,8 @@
 #include <stdint.h>
 
 #include "../../../../include/wrappers_msa.h"
-#include "../../../../include/test_inputs.h"
-#include "../../../../include/test_utils.h"
+#include "../../../../include/test_inputs_128.h"
+#include "../../../../include/test_utils_128.h"
 
 #define TEST_COUNT_TOTAL (                                                \
             (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
diff --git a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_a_b.c b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_a_b.c
index c9e3bd5..5fa2644 100644
--- a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_a_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_a_b.c
@@ -23,8 +23,8 @@
 #include <stdint.h>
 
 #include "../../../../include/wrappers_msa.h"
-#include "../../../../include/test_inputs.h"
-#include "../../../../include/test_utils.h"
+#include "../../../../include/test_inputs_128.h"
+#include "../../../../include/test_utils_128.h"
 
 #define TEST_COUNT_TOTAL (                                                \
             (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
diff --git a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_a_d.c b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_a_d.c
index efe4569..9d97982 100644
--- a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_a_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_a_d.c
@@ -23,8 +23,8 @@
 #include <stdint.h>
 
 #include "../../../../include/wrappers_msa.h"
-#include "../../../../include/test_inputs.h"
-#include "../../../../include/test_utils.h"
+#include "../../../../include/test_inputs_128.h"
+#include "../../../../include/test_utils_128.h"
 
 #define TEST_COUNT_TOTAL (                                                \
             (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
diff --git a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_a_h.c b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_a_h.c
index e8cee19..3365f72 100644
--- a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_a_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_a_h.c
@@ -23,8 +23,8 @@
 #include <stdint.h>
 
 #include "../../../../include/wrappers_msa.h"
-#include "../../../../include/test_inputs.h"
-#include "../../../../include/test_utils.h"
+#include "../../../../include/test_inputs_128.h"
+#include "../../../../include/test_utils_128.h"
 
 #define TEST_COUNT_TOTAL (                                                \
             (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
diff --git a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_a_w.c b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_a_w.c
index 6f1eb68..b33f4b7 100644
--- a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_a_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_a_w.c
@@ -23,8 +23,8 @@
 #include <stdint.h>
 
 #include "../../../../include/wrappers_msa.h"
-#include "../../../../include/test_inputs.h"
-#include "../../../../include/test_utils.h"
+#include "../../../../include/test_inputs_128.h"
+#include "../../../../include/test_utils_128.h"
 
 #define TEST_COUNT_TOTAL (                                                \
             (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
diff --git a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_s_b.c b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_s_b.c
index c26ef59..71e571d 100644
--- a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_s_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_s_b.c
@@ -23,8 +23,8 @@
 #include <stdint.h>
 
 #include "../../../../include/wrappers_msa.h"
-#include "../../../../include/test_inputs.h"
-#include "../../../../include/test_utils.h"
+#include "../../../../include/test_inputs_128.h"
+#include "../../../../include/test_utils_128.h"
 
 #define TEST_COUNT_TOTAL (                                                \
             (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
diff --git a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_s_d.c b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_s_d.c
index b5407b0..e088ab9 100644
--- a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_s_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_s_d.c
@@ -23,8 +23,8 @@
 #include <stdint.h>
 
 #include "../../../../include/wrappers_msa.h"
-#include "../../../../include/test_inputs.h"
-#include "../../../../include/test_utils.h"
+#include "../../../../include/test_inputs_128.h"
+#include "../../../../include/test_utils_128.h"
 
 #define TEST_COUNT_TOTAL (                                                \
             (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
diff --git a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_s_h.c b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_s_h.c
index 8c3d58c..6d1b81a 100644
--- a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_s_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_s_h.c
@@ -23,8 +23,8 @@
 #include <stdint.h>
 
 #include "../../../../include/wrappers_msa.h"
-#include "../../../../include/test_inputs.h"
-#include "../../../../include/test_utils.h"
+#include "../../../../include/test_inputs_128.h"
+#include "../../../../include/test_utils_128.h"
 
 #define TEST_COUNT_TOTAL (                                                \
             (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
diff --git a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_s_w.c b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_s_w.c
index aa22faf..bd64294 100644
--- a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_s_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_s_w.c
@@ -23,8 +23,8 @@
 #include <stdint.h>
 
 #include "../../../../include/wrappers_msa.h"
-#include "../../../../include/test_inputs.h"
-#include "../../../../include/test_utils.h"
+#include "../../../../include/test_inputs_128.h"
+#include "../../../../include/test_utils_128.h"
 
 #define TEST_COUNT_TOTAL (                                                \
             (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
diff --git a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_u_b.c b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_u_b.c
index 5e648dc..206d907 100644
--- a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_u_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_u_b.c
@@ -23,8 +23,8 @@
 #include <stdint.h>
 
 #include "../../../../include/wrappers_msa.h"
-#include "../../../../include/test_inputs.h"
-#include "../../../../include/test_utils.h"
+#include "../../../../include/test_inputs_128.h"
+#include "../../../../include/test_utils_128.h"
 
 #define TEST_COUNT_TOTAL (                                                \
             (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
diff --git a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_u_d.c b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_u_d.c
index 17067d3..4dd247f 100644
--- a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_u_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_u_d.c
@@ -23,8 +23,8 @@
 #include <stdint.h>
 
 #include "../../../../include/wrappers_msa.h"
-#include "../../../../include/test_inputs.h"
-#include "../../../../include/test_utils.h"
+#include "../../../../include/test_inputs_128.h"
+#include "../../../../include/test_utils_128.h"
 
 #define TEST_COUNT_TOTAL (                                                \
             (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
diff --git a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_u_h.c b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_u_h.c
index 8bf11a0..0e6a765 100644
--- a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_u_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_u_h.c
@@ -23,8 +23,8 @@
 #include <stdint.h>
 
 #include "../../../../include/wrappers_msa.h"
-#include "../../../../include/test_inputs.h"
-#include "../../../../include/test_utils.h"
+#include "../../../../include/test_inputs_128.h"
+#include "../../../../include/test_utils_128.h"
 
 #define TEST_COUNT_TOTAL (                                                \
             (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
diff --git a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_u_w.c b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_u_w.c
index 6eecc46..db61440 100644
--- a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_u_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_u_w.c
@@ -23,8 +23,8 @@
 #include <stdint.h>
 
 #include "../../../../include/wrappers_msa.h"
-#include "../../../../include/test_inputs.h"
-#include "../../../../include/test_utils.h"
+#include "../../../../include/test_inputs_128.h"
+#include "../../../../include/test_utils_128.h"
 
 #define TEST_COUNT_TOTAL (                                                \
             (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
diff --git a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_a_b.c b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_a_b.c
index 48026a2..d2a93a2 100644
--- a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_a_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_a_b.c
@@ -23,8 +23,8 @@
 #include <stdint.h>
 
 #include "../../../../include/wrappers_msa.h"
-#include "../../../../include/test_inputs.h"
-#include "../../../../include/test_utils.h"
+#include "../../../../include/test_inputs_128.h"
+#include "../../../../include/test_utils_128.h"
 
 #define TEST_COUNT_TOTAL (                                                \
             (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
diff --git a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_a_d.c b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_a_d.c
index 5f65fb4..69fd3c7 100644
--- a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_a_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_a_d.c
@@ -23,8 +23,8 @@
 #include <stdint.h>
 
 #include "../../../../include/wrappers_msa.h"
-#include "../../../../include/test_inputs.h"
-#include "../../../../include/test_utils.h"
+#include "../../../../include/test_inputs_128.h"
+#include "../../../../include/test_utils_128.h"
 
 #define TEST_COUNT_TOTAL (                                                \
             (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
diff --git a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_a_h.c b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_a_h.c
index a2eb7fa..9f45b55 100644
--- a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_a_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_a_h.c
@@ -23,8 +23,8 @@
 #include <stdint.h>
 
 #include "../../../../include/wrappers_msa.h"
-#include "../../../../include/test_inputs.h"
-#include "../../../../include/test_utils.h"
+#include "../../../../include/test_inputs_128.h"
+#include "../../../../include/test_utils_128.h"
 
 #define TEST_COUNT_TOTAL (                                                \
             (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
diff --git a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_a_w.c b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_a_w.c
index ca1acfb..b08231d 100644
--- a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_a_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_a_w.c
@@ -23,8 +23,8 @@
 #include <stdint.h>
 
 #include "../../../../include/wrappers_msa.h"
-#include "../../../../include/test_inputs.h"
-#include "../../../../include/test_utils.h"
+#include "../../../../include/test_inputs_128.h"
+#include "../../../../include/test_utils_128.h"
 
 #define TEST_COUNT_TOTAL (                                                \
             (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
diff --git a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_s_b.c b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_s_b.c
index ce56619..80b5201 100644
--- a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_s_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_s_b.c
@@ -23,8 +23,8 @@
 #include <stdint.h>
 
 #include "../../../../include/wrappers_msa.h"
-#include "../../../../include/test_inputs.h"
-#include "../../../../include/test_utils.h"
+#include "../../../../include/test_inputs_128.h"
+#include "../../../../include/test_utils_128.h"
 
 #define TEST_COUNT_TOTAL (                                                \
             (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
diff --git a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_s_d.c b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_s_d.c
index d775889..0ed3190 100644
--- a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_s_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_s_d.c
@@ -23,8 +23,8 @@
 #include <stdint.h>
 
 #include "../../../../include/wrappers_msa.h"
-#include "../../../../include/test_inputs.h"
-#include "../../../../include/test_utils.h"
+#include "../../../../include/test_inputs_128.h"
+#include "../../../../include/test_utils_128.h"
 
 #define TEST_COUNT_TOTAL (                                                \
             (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
diff --git a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_s_h.c b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_s_h.c
index 5a984d3..b049054 100644
--- a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_s_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_s_h.c
@@ -23,8 +23,8 @@
 #include <stdint.h>
 
 #include "../../../../include/wrappers_msa.h"
-#include "../../../../include/test_inputs.h"
-#include "../../../../include/test_utils.h"
+#include "../../../../include/test_inputs_128.h"
+#include "../../../../include/test_utils_128.h"
 
 #define TEST_COUNT_TOTAL (                                                \
             (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
diff --git a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_s_w.c b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_s_w.c
index 9e6ee5a..2bcd0a0 100644
--- a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_s_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_s_w.c
@@ -23,8 +23,8 @@
 #include <stdint.h>
 
 #include "../../../../include/wrappers_msa.h"
-#include "../../../../include/test_inputs.h"
-#include "../../../../include/test_utils.h"
+#include "../../../../include/test_inputs_128.h"
+#include "../../../../include/test_utils_128.h"
 
 #define TEST_COUNT_TOTAL (                                                \
             (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
diff --git a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_u_b.c b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_u_b.c
index 57b702d..2a06b43 100644
--- a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_u_b.c
+++ b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_u_b.c
@@ -23,8 +23,8 @@
 #include <stdint.h>
 
 #include "../../../../include/wrappers_msa.h"
-#include "../../../../include/test_inputs.h"
-#include "../../../../include/test_utils.h"
+#include "../../../../include/test_inputs_128.h"
+#include "../../../../include/test_utils_128.h"
 
 #define TEST_COUNT_TOTAL (                                                \
             (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
diff --git a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_u_d.c b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_u_d.c
index f2f98ac..37924f3 100644
--- a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_u_d.c
+++ b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_u_d.c
@@ -23,8 +23,8 @@
 #include <stdint.h>
 
 #include "../../../../include/wrappers_msa.h"
-#include "../../../../include/test_inputs.h"
-#include "../../../../include/test_utils.h"
+#include "../../../../include/test_inputs_128.h"
+#include "../../../../include/test_utils_128.h"
 
 #define TEST_COUNT_TOTAL (                                                \
             (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
diff --git a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_u_h.c b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_u_h.c
index b89ba3b..1846995 100644
--- a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_u_h.c
+++ b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_u_h.c
@@ -23,8 +23,8 @@
 #include <stdint.h>
 
 #include "../../../../include/wrappers_msa.h"
-#include "../../../../include/test_inputs.h"
-#include "../../../../include/test_utils.h"
+#include "../../../../include/test_inputs_128.h"
+#include "../../../../include/test_utils_128.h"
 
 #define TEST_COUNT_TOTAL (                                                \
             (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
diff --git a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_u_w.c b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_u_w.c
index 20992b3..8b20c05 100644
--- a/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_u_w.c
+++ b/tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_u_w.c
@@ -23,8 +23,8 @@
 #include <stdint.h>
 
 #include "../../../../include/wrappers_msa.h"
-#include "../../../../include/test_inputs.h"
-#include "../../../../include/test_utils.h"
+#include "../../../../include/test_inputs_128.h"
+#include "../../../../include/test_utils_128.h"
 
 #define TEST_COUNT_TOTAL (                                                \
             (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
diff --git a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvev_b.c b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvev_b.c
index 5690c5c..d720dc3 100644
--- a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvev_b.c
+++ b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvev_b.c
@@ -23,8 +23,8 @@
 #include <stdint.h>
 
 #include "../../../../include/wrappers_msa.h"
-#include "../../../../include/test_inputs.h"
-#include "../../../../include/test_utils.h"
+#include "../../../../include/test_inputs_128.h"
+#include "../../../../include/test_utils_128.h"
 
 #define TEST_COUNT_TOTAL (                                                \
             (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
diff --git a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvev_d.c b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvev_d.c
index a8b1a0a..8323994 100644
--- a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvev_d.c
+++ b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvev_d.c
@@ -23,8 +23,8 @@
 #include <stdint.h>
 
 #include "../../../../include/wrappers_msa.h"
-#include "../../../../include/test_inputs.h"
-#include "../../../../include/test_utils.h"
+#include "../../../../include/test_inputs_128.h"
+#include "../../../../include/test_utils_128.h"
 
 #define TEST_COUNT_TOTAL (                                                \
             (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
diff --git a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvev_h.c b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvev_h.c
index 5bd7189..3f6fc26 100644
--- a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvev_h.c
+++ b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvev_h.c
@@ -23,8 +23,8 @@
 #include <stdint.h>
 
 #include "../../../../include/wrappers_msa.h"
-#include "../../../../include/test_inputs.h"
-#include "../../../../include/test_utils.h"
+#include "../../../../include/test_inputs_128.h"
+#include "../../../../include/test_utils_128.h"
 
 #define TEST_COUNT_TOTAL (                                                \
             (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
diff --git a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvev_w.c b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvev_w.c
index ecb3ded..30d2e38 100644
--- a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvev_w.c
+++ b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvev_w.c
@@ -23,8 +23,8 @@
 #include <stdint.h>
 
 #include "../../../../include/wrappers_msa.h"
-#include "../../../../include/test_inputs.h"
-#include "../../../../include/test_utils.h"
+#include "../../../../include/test_inputs_128.h"
+#include "../../../../include/test_utils_128.h"
 
 #define TEST_COUNT_TOTAL (                                                \
             (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
diff --git a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvl_b.c b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvl_b.c
index acf0ebf..c771287 100644
--- a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvl_b.c
+++ b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvl_b.c
@@ -23,8 +23,8 @@
 #include <stdint.h>
 
 #include "../../../../include/wrappers_msa.h"
-#include "../../../../include/test_inputs.h"
-#include "../../../../include/test_utils.h"
+#include "../../../../include/test_inputs_128.h"
+#include "../../../../include/test_utils_128.h"
 
 #define TEST_COUNT_TOTAL (                                                \
             (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
diff --git a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvl_d.c b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvl_d.c
index ef31f0d..b7d5fcd 100644
--- a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvl_d.c
+++ b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvl_d.c
@@ -23,8 +23,8 @@
 #include <stdint.h>
 
 #include "../../../../include/wrappers_msa.h"
-#include "../../../../include/test_inputs.h"
-#include "../../../../include/test_utils.h"
+#include "../../../../include/test_inputs_128.h"
+#include "../../../../include/test_utils_128.h"
 
 #define TEST_COUNT_TOTAL (                                                \
             (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
diff --git a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvl_h.c b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvl_h.c
index dc4066b..af72876 100644
--- a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvl_h.c
+++ b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvl_h.c
@@ -23,8 +23,8 @@
 #include <stdint.h>
 
 #include "../../../../include/wrappers_msa.h"
-#include "../../../../include/test_inputs.h"
-#include "../../../../include/test_utils.h"
+#include "../../../../include/test_inputs_128.h"
+#include "../../../../include/test_utils_128.h"
 
 #define TEST_COUNT_TOTAL (                                                \
             (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
diff --git a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvl_w.c b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvl_w.c
index 68e5562..e06c9d9 100644
--- a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvl_w.c
+++ b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvl_w.c
@@ -23,8 +23,8 @@
 #include <stdint.h>
 
 #include "../../../../include/wrappers_msa.h"
-#include "../../../../include/test_inputs.h"
-#include "../../../../include/test_utils.h"
+#include "../../../../include/test_inputs_128.h"
+#include "../../../../include/test_utils_128.h"
 
 #define TEST_COUNT_TOTAL (                                                \
             (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
diff --git a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvod_b.c b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvod_b.c
index 8923caf..8e7f1c4 100644
--- a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvod_b.c
+++ b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvod_b.c
@@ -23,8 +23,8 @@
 #include <stdint.h>
 
 #include "../../../../include/wrappers_msa.h"
-#include "../../../../include/test_inputs.h"
-#include "../../../../include/test_utils.h"
+#include "../../../../include/test_inputs_128.h"
+#include "../../../../include/test_utils_128.h"
 
 #define TEST_COUNT_TOTAL (                                                \
             (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
diff --git a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvod_d.c b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvod_d.c
index 1580080..acbd94a 100644
--- a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvod_d.c
+++ b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvod_d.c
@@ -23,8 +23,8 @@
 #include <stdint.h>
 
 #include "../../../../include/wrappers_msa.h"
-#include "../../../../include/test_inputs.h"
-#include "../../../../include/test_utils.h"
+#include "../../../../include/test_inputs_128.h"
+#include "../../../../include/test_utils_128.h"
 
 #define TEST_COUNT_TOTAL (                                                \
             (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
diff --git a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvod_h.c b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvod_h.c
index 32c2a4e..8a82def4 100644
--- a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvod_h.c
+++ b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvod_h.c
@@ -23,8 +23,8 @@
 #include <stdint.h>
 
 #include "../../../../include/wrappers_msa.h"
-#include "../../../../include/test_inputs.h"
-#include "../../../../include/test_utils.h"
+#include "../../../../include/test_inputs_128.h"
+#include "../../../../include/test_utils_128.h"
 
 #define TEST_COUNT_TOTAL (                                                \
             (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
diff --git a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvod_w.c b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvod_w.c
index 7f65239..e19170c 100644
--- a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvod_w.c
+++ b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvod_w.c
@@ -23,8 +23,8 @@
 #include <stdint.h>
 
 #include "../../../../include/wrappers_msa.h"
-#include "../../../../include/test_inputs.h"
-#include "../../../../include/test_utils.h"
+#include "../../../../include/test_inputs_128.h"
+#include "../../../../include/test_utils_128.h"
 
 #define TEST_COUNT_TOTAL (                                                \
             (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
diff --git a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvr_b.c b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvr_b.c
index ddf2eef..1e519e6 100644
--- a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvr_b.c
+++ b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvr_b.c
@@ -23,8 +23,8 @@
 #include <stdint.h>
 
 #include "../../../../include/wrappers_msa.h"
-#include "../../../../include/test_inputs.h"
-#include "../../../../include/test_utils.h"
+#include "../../../../include/test_inputs_128.h"
+#include "../../../../include/test_utils_128.h"
 
 #define TEST_COUNT_TOTAL (                                                \
             (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
diff --git a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvr_d.c b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvr_d.c
index 898b4e3..be76043 100644
--- a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvr_d.c
+++ b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvr_d.c
@@ -23,8 +23,8 @@
 #include <stdint.h>
 
 #include "../../../../include/wrappers_msa.h"
-#include "../../../../include/test_inputs.h"
-#include "../../../../include/test_utils.h"
+#include "../../../../include/test_inputs_128.h"
+#include "../../../../include/test_utils_128.h"
 
 #define TEST_COUNT_TOTAL (                                                \
             (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
diff --git a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvr_h.c b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvr_h.c
index 3295ed8..cbd4685 100644
--- a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvr_h.c
+++ b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvr_h.c
@@ -23,8 +23,8 @@
 #include <stdint.h>
 
 #include "../../../../include/wrappers_msa.h"
-#include "../../../../include/test_inputs.h"
-#include "../../../../include/test_utils.h"
+#include "../../../../include/test_inputs_128.h"
+#include "../../../../include/test_utils_128.h"
 
 #define TEST_COUNT_TOTAL (                                                \
             (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
diff --git a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvr_w.c b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvr_w.c
index 2c1ebc7..5f4cfd0 100644
--- a/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvr_w.c
+++ b/tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvr_w.c
@@ -23,8 +23,8 @@
 #include <stdint.h>
 
 #include "../../../../include/wrappers_msa.h"
-#include "../../../../include/test_inputs.h"
-#include "../../../../include/test_utils.h"
+#include "../../../../include/test_inputs_128.h"
+#include "../../../../include/test_utils_128.h"
 
 #define TEST_COUNT_TOTAL (                                                \
             (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
diff --git a/tests/tcg/mips/user/ase/msa/logic/test_msa_and_v.c b/tests/tcg/mips/user/ase/msa/logic/test_msa_and_v.c
index 42479ef..534c420 100644
--- a/tests/tcg/mips/user/ase/msa/logic/test_msa_and_v.c
+++ b/tests/tcg/mips/user/ase/msa/logic/test_msa_and_v.c
@@ -23,8 +23,8 @@
 #include <stdint.h>
 
 #include "../../../../include/wrappers_msa.h"
-#include "../../../../include/test_inputs.h"
-#include "../../../../include/test_utils.h"
+#include "../../../../include/test_inputs_128.h"
+#include "../../../../include/test_utils_128.h"
 
 #define TEST_COUNT_TOTAL (                                                \
             (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
diff --git a/tests/tcg/mips/user/ase/msa/logic/test_msa_nor_v.c b/tests/tcg/mips/user/ase/msa/logic/test_msa_nor_v.c
index a956e03..f781a8b 100644
--- a/tests/tcg/mips/user/ase/msa/logic/test_msa_nor_v.c
+++ b/tests/tcg/mips/user/ase/msa/logic/test_msa_nor_v.c
@@ -23,8 +23,8 @@
 #include <stdint.h>
 
 #include "../../../../include/wrappers_msa.h"
-#include "../../../../include/test_inputs.h"
-#include "../../../../include/test_utils.h"
+#include "../../../../include/test_inputs_128.h"
+#include "../../../../include/test_utils_128.h"
 
 #define TEST_COUNT_TOTAL (                                                \
             (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
diff --git a/tests/tcg/mips/user/ase/msa/logic/test_msa_or_v.c b/tests/tcg/mips/user/ase/msa/logic/test_msa_or_v.c
index 46ac112..924f216 100644
--- a/tests/tcg/mips/user/ase/msa/logic/test_msa_or_v.c
+++ b/tests/tcg/mips/user/ase/msa/logic/test_msa_or_v.c
@@ -23,8 +23,8 @@
 #include <stdint.h>
 
 #include "../../../../include/wrappers_msa.h"
-#include "../../../../include/test_inputs.h"
-#include "../../../../include/test_utils.h"
+#include "../../../../include/test_inputs_128.h"
+#include "../../../../include/test_utils_128.h"
 
 #define TEST_COUNT_TOTAL (                                                \
             (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
diff --git a/tests/tcg/mips/user/ase/msa/logic/test_msa_xor_v.c b/tests/tcg/mips/user/ase/msa/logic/test_msa_xor_v.c
index dd3668c..f0442e6 100644
--- a/tests/tcg/mips/user/ase/msa/logic/test_msa_xor_v.c
+++ b/tests/tcg/mips/user/ase/msa/logic/test_msa_xor_v.c
@@ -23,8 +23,8 @@
 #include <stdint.h>
 
 #include "../../../../include/wrappers_msa.h"
-#include "../../../../include/test_inputs.h"
-#include "../../../../include/test_utils.h"
+#include "../../../../include/test_inputs_128.h"
+#include "../../../../include/test_utils_128.h"
 
 #define TEST_COUNT_TOTAL (                                                \
             (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
diff --git a/tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_b.c b/tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_b.c
index ee1aa5d..409773d 100644
--- a/tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_b.c
+++ b/tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_b.c
@@ -23,8 +23,8 @@
 #include <stdint.h>
 
 #include "../../../../include/wrappers_msa.h"
-#include "../../../../include/test_inputs.h"
-#include "../../../../include/test_utils.h"
+#include "../../../../include/test_inputs_128.h"
+#include "../../../../include/test_utils_128.h"
 
 #define TEST_COUNT_TOTAL (                                                \
             (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
diff --git a/tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_d.c b/tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_d.c
index 5df658a..8e89716 100644
--- a/tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_d.c
+++ b/tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_d.c
@@ -23,8 +23,8 @@
 #include <stdint.h>
 
 #include "../../../../include/wrappers_msa.h"
-#include "../../../../include/test_inputs.h"
-#include "../../../../include/test_utils.h"
+#include "../../../../include/test_inputs_128.h"
+#include "../../../../include/test_utils_128.h"
 
 #define TEST_COUNT_TOTAL (                                                \
             (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
diff --git a/tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_h.c b/tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_h.c
index 90a5123..b389587 100644
--- a/tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_h.c
+++ b/tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_h.c
@@ -23,8 +23,8 @@
 #include <stdint.h>
 
 #include "../../../../include/wrappers_msa.h"
-#include "../../../../include/test_inputs.h"
-#include "../../../../include/test_utils.h"
+#include "../../../../include/test_inputs_128.h"
+#include "../../../../include/test_utils_128.h"
 
 #define TEST_COUNT_TOTAL (                                                \
             (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
diff --git a/tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_w.c b/tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_w.c
index 364b835..d393ad50 100644
--- a/tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_w.c
+++ b/tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_w.c
@@ -23,8 +23,8 @@
 #include <stdint.h>
 
 #include "../../../../include/wrappers_msa.h"
-#include "../../../../include/test_inputs.h"
-#include "../../../../include/test_utils.h"
+#include "../../../../include/test_inputs_128.h"
+#include "../../../../include/test_utils_128.h"
 
 #define TEST_COUNT_TOTAL (                                                \
             (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
diff --git a/tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_b.c b/tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_b.c
index e637237..ab363a0 100644
--- a/tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_b.c
+++ b/tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_b.c
@@ -23,8 +23,8 @@
 #include <stdint.h>
 
 #include "../../../../include/wrappers_msa.h"
-#include "../../../../include/test_inputs.h"
-#include "../../../../include/test_utils.h"
+#include "../../../../include/test_inputs_128.h"
+#include "../../../../include/test_utils_128.h"
 
 #define TEST_COUNT_TOTAL (                                                \
             (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
diff --git a/tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_d.c b/tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_d.c
index d0b17f4..09a6140 100644
--- a/tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_d.c
+++ b/tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_d.c
@@ -23,8 +23,8 @@
 #include <stdint.h>
 
 #include "../../../../include/wrappers_msa.h"
-#include "../../../../include/test_inputs.h"
-#include "../../../../include/test_utils.h"
+#include "../../../../include/test_inputs_128.h"
+#include "../../../../include/test_utils_128.h"
 
 #define TEST_COUNT_TOTAL (                                                \
             (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
diff --git a/tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_h.c b/tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_h.c
index 034c9e8..d7a8c5b 100644
--- a/tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_h.c
+++ b/tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_h.c
@@ -23,8 +23,8 @@
 #include <stdint.h>
 
 #include "../../../../include/wrappers_msa.h"
-#include "../../../../include/test_inputs.h"
-#include "../../../../include/test_utils.h"
+#include "../../../../include/test_inputs_128.h"
+#include "../../../../include/test_utils_128.h"
 
 #define TEST_COUNT_TOTAL (                                                \
             (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
diff --git a/tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_w.c b/tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_w.c
index 2ff1c36..4b732d0 100644
--- a/tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_w.c
+++ b/tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_w.c
@@ -23,8 +23,8 @@
 #include <stdint.h>
 
 #include "../../../../include/wrappers_msa.h"
-#include "../../../../include/test_inputs.h"
-#include "../../../../include/test_utils.h"
+#include "../../../../include/test_inputs_128.h"
+#include "../../../../include/test_utils_128.h"
 
 #define TEST_COUNT_TOTAL (                                                \
             (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
diff --git a/tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_b.c b/tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_b.c
index 1f4853a..d9ccf57 100644
--- a/tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_b.c
+++ b/tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_b.c
@@ -23,8 +23,8 @@
 #include <stdint.h>
 
 #include "../../../../include/wrappers_msa.h"
-#include "../../../../include/test_inputs.h"
-#include "../../../../include/test_utils.h"
+#include "../../../../include/test_inputs_128.h"
+#include "../../../../include/test_utils_128.h"
 
 #define TEST_COUNT_TOTAL (                                                \
             (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
diff --git a/tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_d.c b/tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_d.c
index 0c42d27..6c555fb 100644
--- a/tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_d.c
+++ b/tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_d.c
@@ -23,8 +23,8 @@
 #include <stdint.h>
 
 #include "../../../../include/wrappers_msa.h"
-#include "../../../../include/test_inputs.h"
-#include "../../../../include/test_utils.h"
+#include "../../../../include/test_inputs_128.h"
+#include "../../../../include/test_utils_128.h"
 
 #define TEST_COUNT_TOTAL (                                                \
             (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
diff --git a/tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_h.c b/tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_h.c
index f3f0e93..9dfcb51 100644
--- a/tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_h.c
+++ b/tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_h.c
@@ -23,8 +23,8 @@
 #include <stdint.h>
 
 #include "../../../../include/wrappers_msa.h"
-#include "../../../../include/test_inputs.h"
-#include "../../../../include/test_utils.h"
+#include "../../../../include/test_inputs_128.h"
+#include "../../../../include/test_utils_128.h"
 
 #define TEST_COUNT_TOTAL (                                                \
             (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
diff --git a/tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_w.c b/tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_w.c
index c5f2026..97074c0 100644
--- a/tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_w.c
+++ b/tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_w.c
@@ -23,8 +23,8 @@
 #include <stdint.h>
 
 #include "../../../../include/wrappers_msa.h"
-#include "../../../../include/test_inputs.h"
-#include "../../../../include/test_utils.h"
+#include "../../../../include/test_inputs_128.h"
+#include "../../../../include/test_utils_128.h"
 
 #define TEST_COUNT_TOTAL (                                                \
             (PATTERN_INPUTS_SHORT_COUNT) * (PATTERN_INPUTS_SHORT_COUNT) + \
-- 
2.7.4
