Received: from eggs.gnu.org ([2001:4830:134:3::10]:49698)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alastair@au1.ibm.com>) id 1cHOuo-00074b-QD
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 00:49:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alastair@au1.ibm.com>) id 1cHOul-0003Ip-8J
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 00:49:14 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45193)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alastair@au1.ibm.com>)
	id 1cHOuk-0003I3-Tc
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 00:49:11 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uBF5mg5h042601
	for <qemu-devel@nongnu.org>; Thu, 15 Dec 2016 00:49:09 -0500
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
	by mx0a-001b2d01.pphosted.com with ESMTP id 27bdm4abs5-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 15 Dec 2016 00:49:09 -0500
Received: from localhost
	by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <alastair@au1.ibm.com>;
	Thu, 15 Dec 2016 15:49:07 +1000
From: "Alastair D'Silva" <alastair@au1.ibm.com>
Date: Thu, 15 Dec 2016 16:48:08 +1100
In-Reply-To: <20161215054812.12602-1-alastair@au1.ibm.com>
References: <20161215054812.12602-1-alastair@au1.ibm.com>
Message-Id: <20161215054812.12602-5-alastair@au1.ibm.com>
Subject: [Qemu-devel] [PATCH v4 4/8] qtest: Fix whitespace
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Andrew Jeffery <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>, Alastair D'Silva <alastair@d-silva.org>

From: Alastair D'Silva <alastair@d-silva.org>

Fix 2 cases of incorrect indentation

Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
---
 qtest.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/qtest.c b/qtest.c
index a947892..143077e 100644
--- a/qtest.c
+++ b/qtest.c
@@ -309,7 +309,7 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
         if (!dev) {
             qtest_send_prefix(chr);
             qtest_send(chr, "FAIL Unknown device\n");
-	    return;
+            return;
         }
 
         if (irq_intercept_dev) {
@@ -319,7 +319,7 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
             } else {
                 qtest_send(chr, "OK\n");
             }
-	    return;
+            return;
         }
 
         QLIST_FOREACH(ngl, &dev->gpios, node) {
-- 
2.9.3
