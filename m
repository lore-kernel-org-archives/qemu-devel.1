Received: from eggs.gnu.org ([2001:4830:134:3::10]:42805)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e4oBe-00040c-BN
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 09:15:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e4oBY-0005M6-5j
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 09:15:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43330)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1e4oBX-0005Lw-Vy
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 09:15:00 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1F00B820E7
	for <qemu-devel@nongnu.org>; Wed, 18 Oct 2017 13:14:59 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Wed, 18 Oct 2017 14:14:56 +0100
Message-Id: <20171018131456.17536-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH] test: fix detection of errors from iasl
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

The conditional looking for errors while loading asl files would ignore
errors from loading the expected data, if the actual data succeeded.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 tests/bios-tables-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
index ee441f1e17..be05e8bcc2 100644
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
2.13.6
