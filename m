Received: from eggs.gnu.org ([2001:4830:134:3::10]:52325)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vyasevic@redhat.com>) id 1dDafj-00044n-4N
	for qemu-devel@nongnu.org; Wed, 24 May 2017 14:06:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vyasevic@redhat.com>) id 1dDafi-0001Qn-EP
	for qemu-devel@nongnu.org; Wed, 24 May 2017 14:06:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54370)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vyasevic@redhat.com>) id 1dDafi-0001QV-97
	for qemu-devel@nongnu.org; Wed, 24 May 2017 14:06:10 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 557CEC04B943
	for <qemu-devel@nongnu.org>; Wed, 24 May 2017 18:06:09 +0000 (UTC)
From: Vladislav Yasevich <vyasevic@redhat.com>
Date: Wed, 24 May 2017 14:05:27 -0400
Message-Id: <1495649128-10529-12-git-send-email-vyasevic@redhat.com>
In-Reply-To: <1495649128-10529-1-git-send-email-vyasevic@redhat.com>
References: <1495649128-10529-1-git-send-email-vyasevic@redhat.com>
Subject: [Qemu-devel] [PATCH 11/12] tests/test-hmp: Add announce parameter
 tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, dgilbert@redhat.com, quintela@redhat.com
Cc: germano@redhat.com, lvivier@redhat.com, jasowang@redhat.com, jdenemar@redhat.com, kashyap@redhat.com, armbru@redhat.com, mst@redhat.com, Vladislav Yasevich <vyasevic@redhat.com>

Add 2 new commands for announce parameters to the test.

Signed-off-by: Vladislav Yasevich <vyasevic@redhat.com>
---
 tests/test-hmp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/test-hmp.c b/tests/test-hmp.c
index 99e35ec..f3887d1 100644
--- a/tests/test-hmp.c
+++ b/tests/test-hmp.c
@@ -65,6 +65,8 @@ static const char *hmp_cmds[] = {
     "sum 0 512",
     "x /8i 0x100",
     "xp /16x 0",
+    "info announce_parameters",
+    "announce_set_parameter rounds 10",
     NULL
 };
 
-- 
2.7.4
