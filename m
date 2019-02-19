Received: from eggs.gnu.org ([209.51.188.92]:49655)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gvye2-0005cE-5f
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 01:12:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gvydx-0007Bu-Dj
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 01:12:42 -0500
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:42525)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1gvydw-00079L-7Q
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 01:12:37 -0500
Received: by mail-lf1-x141.google.com with SMTP id l10so13996725lfh.9
	for <qemu-devel@nongnu.org>; Mon, 18 Feb 2019 22:12:30 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Mon, 18 Feb 2019 22:11:05 -0800
Message-Id: <20190219061111.10231-18-jcmvbkbc@gmail.com>
In-Reply-To: <20190219061111.10231-1-jcmvbkbc@gmail.com>
References: <20190219061111.10231-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH 17/23] tests/tcg/xtensa: conditionalize
 MMU-related tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>

Make MMU-related tests conditional on the presence of MMUv2 option.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 tests/tcg/xtensa/test_mmu.S      | 4 ++++
 tests/tcg/xtensa/test_phys_mem.S | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/tests/tcg/xtensa/test_mmu.S b/tests/tcg/xtensa/test_mmu.S
index a15316ffb317..4cbd6ef4f9d8 100644
--- a/tests/tcg/xtensa/test_mmu.S
+++ b/tests/tcg/xtensa/test_mmu.S
@@ -2,6 +2,8 @@
 
 test_suite mmu
 
+#if XCHAL_HAVE_PTP_MMU && !XCHAL_HAVE_SPANNING_WAY
+
 .purgem test_init
 
 .macro clean_tlb_way way, page_size, n_entries
@@ -740,4 +742,6 @@ test cross_page_tb
     assert  eq, a2, a3
 test_end
 
+#endif
+
 test_suite_end
diff --git a/tests/tcg/xtensa/test_phys_mem.S b/tests/tcg/xtensa/test_phys_mem.S
index aae0a793a718..9bb3ee3866ed 100644
--- a/tests/tcg/xtensa/test_phys_mem.S
+++ b/tests/tcg/xtensa/test_phys_mem.S
@@ -2,6 +2,8 @@
 
 test_suite phys_mem
 
+#if XCHAL_HAVE_PTP_MMU && !XCHAL_HAVE_SPANNING_WAY
+
 .purgem test_init
 
 .macro test_init
@@ -67,6 +69,8 @@ test write_get_pte_no_phys
     assert  eq, a2, a3
 test_end
 
+#endif
+
 test inst_fetch_no_phys
     set_vector kernel, 2f
 
-- 
2.11.0
