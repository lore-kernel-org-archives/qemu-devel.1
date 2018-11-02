Received: from eggs.gnu.org ([2001:4830:134:3::10]:50789)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gIVHu-0000s1-02
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 04:58:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gIVHn-00081o-Ns
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 04:58:41 -0400
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Fri,  2 Nov 2018 09:58:00 +0100
Message-Id: <20181102085800.21860-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] qemu/units: Move out QCow2 specific definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Leonid Bloch <lbloch@janustech.com>, Alberto Garcia <berto@igalia.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>

This definitions are QCow2 specific, there is no need to expose them
in the global namespace.

This partially reverts commit 540b8492618eb.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 block/qcow2.h        | 56 +++++++++++++++++++++++++++++++++++++++++++-
 include/qemu/units.h | 55 -------------------------------------------
 2 files changed, 55 insertions(+), 56 deletions(-)

diff --git a/block/qcow2.h b/block/qcow2.h
index 29c98d87a0..74d200c8cb 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -27,12 +27,66 @@
=20
 #include "crypto/block.h"
 #include "qemu/coroutine.h"
-#include "qemu/units.h"
=20
 //#define DEBUG_ALLOC
 //#define DEBUG_ALLOC2
 //#define DEBUG_EXT
=20
+#define S_1KiB                  1024
+#define S_2KiB                  2048
+#define S_4KiB                  4096
+#define S_8KiB                  8192
+#define S_16KiB                16384
+#define S_32KiB                32768
+#define S_64KiB                65536
+#define S_128KiB              131072
+#define S_256KiB              262144
+#define S_512KiB              524288
+#define S_1MiB               1048576
+#define S_2MiB               2097152
+#define S_4MiB               4194304
+#define S_8MiB               8388608
+#define S_16MiB             16777216
+#define S_32MiB             33554432
+#define S_64MiB             67108864
+#define S_128MiB           134217728
+#define S_256MiB           268435456
+#define S_512MiB           536870912
+#define S_1GiB            1073741824
+#define S_2GiB            2147483648
+#define S_4GiB            4294967296
+#define S_8GiB            8589934592
+#define S_16GiB          17179869184
+#define S_32GiB          34359738368
+#define S_64GiB          68719476736
+#define S_128GiB        137438953472
+#define S_256GiB        274877906944
+#define S_512GiB        549755813888
+#define S_1TiB         1099511627776
+#define S_2TiB         2199023255552
+#define S_4TiB         4398046511104
+#define S_8TiB         8796093022208
+#define S_16TiB       17592186044416
+#define S_32TiB       35184372088832
+#define S_64TiB       70368744177664
+#define S_128TiB     140737488355328
+#define S_256TiB     281474976710656
+#define S_512TiB     562949953421312
+#define S_1PiB      1125899906842624
+#define S_2PiB      2251799813685248
+#define S_4PiB      4503599627370496
+#define S_8PiB      9007199254740992
+#define S_16PiB    18014398509481984
+#define S_32PiB    36028797018963968
+#define S_64PiB    72057594037927936
+#define S_128PiB  144115188075855872
+#define S_256PiB  288230376151711744
+#define S_512PiB  576460752303423488
+#define S_1EiB   1152921504606846976
+#define S_2EiB   2305843009213693952
+#define S_4EiB   4611686018427387904
+#define S_8EiB   9223372036854775808
+
 #define QCOW_MAGIC (('Q' << 24) | ('F' << 16) | ('I' << 8) | 0xfb)
=20
 #define QCOW_CRYPT_NONE 0
diff --git a/include/qemu/units.h b/include/qemu/units.h
index 68a7758650..692db3fbb2 100644
--- a/include/qemu/units.h
+++ b/include/qemu/units.h
@@ -17,59 +17,4 @@
 #define PiB     (INT64_C(1) << 50)
 #define EiB     (INT64_C(1) << 60)
=20
-#define S_1KiB                  1024
-#define S_2KiB                  2048
-#define S_4KiB                  4096
-#define S_8KiB                  8192
-#define S_16KiB                16384
-#define S_32KiB                32768
-#define S_64KiB                65536
-#define S_128KiB              131072
-#define S_256KiB              262144
-#define S_512KiB              524288
-#define S_1MiB               1048576
-#define S_2MiB               2097152
-#define S_4MiB               4194304
-#define S_8MiB               8388608
-#define S_16MiB             16777216
-#define S_32MiB             33554432
-#define S_64MiB             67108864
-#define S_128MiB           134217728
-#define S_256MiB           268435456
-#define S_512MiB           536870912
-#define S_1GiB            1073741824
-#define S_2GiB            2147483648
-#define S_4GiB            4294967296
-#define S_8GiB            8589934592
-#define S_16GiB          17179869184
-#define S_32GiB          34359738368
-#define S_64GiB          68719476736
-#define S_128GiB        137438953472
-#define S_256GiB        274877906944
-#define S_512GiB        549755813888
-#define S_1TiB         1099511627776
-#define S_2TiB         2199023255552
-#define S_4TiB         4398046511104
-#define S_8TiB         8796093022208
-#define S_16TiB       17592186044416
-#define S_32TiB       35184372088832
-#define S_64TiB       70368744177664
-#define S_128TiB     140737488355328
-#define S_256TiB     281474976710656
-#define S_512TiB     562949953421312
-#define S_1PiB      1125899906842624
-#define S_2PiB      2251799813685248
-#define S_4PiB      4503599627370496
-#define S_8PiB      9007199254740992
-#define S_16PiB    18014398509481984
-#define S_32PiB    36028797018963968
-#define S_64PiB    72057594037927936
-#define S_128PiB  144115188075855872
-#define S_256PiB  288230376151711744
-#define S_512PiB  576460752303423488
-#define S_1EiB   1152921504606846976
-#define S_2EiB   2305843009213693952
-#define S_4EiB   4611686018427387904
-#define S_8EiB   9223372036854775808
-
 #endif
--=20
2.17.2
