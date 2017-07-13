Received: from eggs.gnu.org ([2001:4830:134:3::10]:46722)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dVhDc-0005QM-9E
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 12:44:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dVhDb-0005Qu-Fa
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 12:44:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42532)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dVhDb-0005QT-8u
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 12:43:59 -0400
Date: Thu, 13 Jul 2017 19:43:57 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1499964233-24206-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] [PATCH] tests: switch pxe and vm gen id tests to use
 kvm
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Ben Warren <ben@skyportsystems.com>

Speed up tests on host systems with kvm by using it.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/pxe-test.c     | 2 +-
 tests/vmgenid-test.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/pxe-test.c b/tests/pxe-test.c
index 34282d3..cf6e225 100644
--- a/tests/pxe-test.c
+++ b/tests/pxe-test.c
@@ -25,7 +25,7 @@ static void test_pxe_one(const char *params, bool ipv6)
 {
     char *args;
 
-    args = g_strdup_printf("-machine accel=tcg -nodefaults -boot order=n "
+    args = g_strdup_printf("-machine accel=kvm:tcg -nodefaults -boot order=n "
                            "-netdev user,id=" NETNAME ",tftp=./,bootfile=%s,"
                            "ipv4=%s,ipv6=%s %s", disk, ipv6 ? "off" : "on",
                            ipv6 ? "on" : "off", params);
diff --git a/tests/vmgenid-test.c b/tests/vmgenid-test.c
index 0556ba2..6477dcc 100644
--- a/tests/vmgenid-test.c
+++ b/tests/vmgenid-test.c
@@ -132,7 +132,7 @@ static char disk[] = "tests/vmgenid-test-disk-XXXXXX";
 
 static char *guid_cmd_strdup(const char *guid)
 {
-    return g_strdup_printf("-machine accel=tcg "
+    return g_strdup_printf("-machine accel=kvm:tcg "
                            "-device vmgenid,id=testvgid,guid=%s "
                            "-drive id=hd0,if=none,file=%s,format=raw "
                            "-device ide-hd,drive=hd0 ",
-- 
MST
