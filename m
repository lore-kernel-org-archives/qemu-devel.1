Received: from eggs.gnu.org ([2001:4830:134:3::10]:58601)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eF2GU-0003Gr-Ia
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 13:18:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eF2GQ-000314-JM
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 13:18:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49814)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eF2GQ-00030i-D5
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 13:18:18 -0500
Date: Wed, 15 Nov 2017 20:18:13 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1510769835-31902-5-git-send-email-mst@redhat.com>
References: <1510769835-31902-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1510769835-31902-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 04/10] test: fix detection of errors from iasl
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, "Daniel P. Berrange" <berrange@redhat.com>, Igor Mammedov <imammedo@redhat.com>

From: "Daniel P. Berrange" <berrange@redhat.com>

The conditional looking for errors while loading asl files would ignore
errors from loading the expected data, if the actual data succeeded.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/bios-tables-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
index ee441f1..be05e8b 100644
--- a/tests/bios-tables-test.c
+++ b/tests/bios-tables-test.c
@@ -458,7 +458,7 @@ static void test_acpi_asl(test_data *data)
         exp_asl = normalize_asl(exp_sdt->asl);
 
         /* TODO: check for warnings */
-        g_assert(!err || exp_err);
+        g_assert(!err && !exp_err);
 
         if (g_strcmp0(asl->str, exp_asl->str)) {
             if (exp_err) {
-- 
MST
