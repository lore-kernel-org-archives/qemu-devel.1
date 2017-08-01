Received: from eggs.gnu.org ([2001:4830:134:3::10]:35749)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dcerB-0000xo-Lw
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 17:37:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dcer9-0004ah-Lf
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 17:37:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35970)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dcer9-0004a4-Fe
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 17:37:35 -0400
Date: Wed, 2 Aug 2017 00:37:33 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1501623438-31419-2-git-send-email-mst@redhat.com>
References: <1501623438-31419-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1501623438-31419-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 01/10] tests: switch pxe and vm gen id tests to
 use kvm
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Ben Warren <ben@skyportsystems.com>

Speed up tests on host systems with kvm support.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>
Cc: Laurent Vivier <lvivier@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
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
index a49de92..3d5c1c3 100644
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
