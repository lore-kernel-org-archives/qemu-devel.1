Received: from eggs.gnu.org ([2001:4830:134:3::10]:60820)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dXLtE-0002P4-4O
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 02:21:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dXLtD-0001rW-9N
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 02:21:48 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 18 Jul 2017 03:10:03 -0300
Message-Id: <20170718061005.29518-28-f4bug@amsat.org>
In-Reply-To: <20170718061005.29518-1-f4bug@amsat.org>
References: <20170718061005.29518-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 27/29] tests/hbitmap: use ARRAY_SIZE macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-trivial@nongnu.org, Fam Zheng <famz@redhat.com>, John Snow <jsnow@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>

Applied using the Coccinelle semantic patch scripts/coccinelle/use_osdep.cocci

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/test-hbitmap.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/test-hbitmap.c b/tests/test-hbitmap.c
index 1acb353889..628e72122b 100644
--- a/tests/test-hbitmap.c
+++ b/tests/test-hbitmap.c
@@ -813,7 +813,7 @@ static void test_hbitmap_serialize_basic(TestHBitmapData *data,
     size_t buf_size;
     uint8_t *buf;
     uint64_t positions[] = { 0, 1, L1 - 1, L1, L2 - 1, L2, L2 + 1, L3 - 1 };
-    int num_positions = sizeof(positions) / sizeof(positions[0]);
+    int num_positions = ARRAY_SIZE(positions);
 
     hbitmap_test_init(data, L3, 0);
     g_assert(hbitmap_is_serializable(data->hb));
@@ -838,7 +838,7 @@ static void test_hbitmap_serialize_part(TestHBitmapData *data,
     size_t buf_size;
     uint8_t *buf;
     uint64_t positions[] = { 0, 1, L1 - 1, L1, L2 - 1, L2, L2 + 1, L3 - 1 };
-    int num_positions = sizeof(positions) / sizeof(positions[0]);
+    int num_positions = ARRAY_SIZE(positions);
 
     hbitmap_test_init(data, L3, 0);
     buf_size = L2;
@@ -880,7 +880,7 @@ static void test_hbitmap_serialize_zeroes(TestHBitmapData *data,
     int64_t next;
     uint64_t min_l1 = MAX(L1, 64);
     uint64_t positions[] = { 0, min_l1, L2, L3 - min_l1};
-    int num_positions = sizeof(positions) / sizeof(positions[0]);
+    int num_positions = ARRAY_SIZE(positions);
 
     hbitmap_test_init(data, L3, 0);
 
-- 
2.13.2
