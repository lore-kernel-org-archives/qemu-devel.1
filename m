Received: from eggs.gnu.org ([2001:4830:134:3::10]:38517)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dI0ou-0007nF-G7
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 18:49:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dI0or-0000GO-DL
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 18:49:56 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:56041)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dI0or-0000FC-9F
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 18:49:53 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Mon,  5 Jun 2017 18:49:38 -0400
Message-Id: <1496702979-26132-3-git-send-email-cota@braap.org>
In-Reply-To: <1496702979-26132-1-git-send-email-cota@braap.org>
References: <1496702979-26132-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH v2 2/3] tests: use QEMU_CACHELINE_SIZE instead
 of hard-coding it
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, alex.bennee@linaro.org, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Pranith Kumar <bobby.prani@gmail.com>

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 tests/atomic_add-bench.c | 4 ++--
 tests/qht-bench.c        | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/atomic_add-bench.c b/tests/atomic_add-bench.c
index caa1e8e..c219109 100644
--- a/tests/atomic_add-bench.c
+++ b/tests/atomic_add-bench.c
@@ -5,11 +5,11 @@
 
 struct thread_info {
     uint64_t r;
-} QEMU_ALIGNED(64);
+} QEMU_ALIGNED(QEMU_CACHELINE_SIZE);
 
 struct count {
     unsigned long val;
-} QEMU_ALIGNED(64);
+} QEMU_ALIGNED(QEMU_CACHELINE_SIZE);
 
 static QemuThread *threads;
 static struct thread_info *th_info;
diff --git a/tests/qht-bench.c b/tests/qht-bench.c
index 2afa09d..3f4b5eb 100644
--- a/tests/qht-bench.c
+++ b/tests/qht-bench.c
@@ -28,7 +28,7 @@ struct thread_info {
     uint64_t r;
     bool write_op; /* writes alternate between insertions and removals */
     bool resize_down;
-} QEMU_ALIGNED(64); /* avoid false sharing among threads */
+} QEMU_ALIGNED(QEMU_CACHELINE_SIZE); /* avoid false sharing among threads */
 
 static struct qht ht;
 static QemuThread *rw_threads;
-- 
2.7.4
