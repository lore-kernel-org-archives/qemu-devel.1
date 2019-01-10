Received: from eggs.gnu.org ([209.51.188.92]:56693)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ghfrf-0005ch-6Q
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 14:19:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ghfre-0000V8-As
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 14:19:39 -0500
From: Eric Blake <eblake@redhat.com>
Date: Thu, 10 Jan 2019 13:19:00 -0600
Message-Id: <20190110191901.5082-7-eblake@redhat.com>
In-Reply-To: <20190110191901.5082-1-eblake@redhat.com>
References: <20190110191901.5082-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 6/6] Revert "include: Add a lookup table of
 sizes"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: lbloch@janustech.com, armbru@redhat.com, kwolf@redhat.com, qemu-block@nongnu.org

This reverts commit 540b8492618ebbe98e7462bd7d31361b8cb10a05.

Now that QemuOpts can accept default values as integers, there
are no more clients of the S_*iB macros, and no longer a reason
to have a list of macros that contain a specific spelling of
special values merely for the sake of stringify(), when it is
a lot nicer to just compute integers in the first place using
ordinary arithmetic and our smaller list of xiB scaling macros.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 include/qemu/units.h | 55 --------------------------------------------
 1 file changed, 55 deletions(-)

diff --git a/include/qemu/units.h b/include/qemu/units.h
index 68a77586504..692db3fbb26 100644
--- a/include/qemu/units.h
+++ b/include/qemu/units.h
@@ -17,59 +17,4 @@
 #define PiB     (INT64_C(1) << 50)
 #define EiB     (INT64_C(1) << 60)

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
2.20.1
