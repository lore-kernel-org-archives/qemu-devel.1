Received: from eggs.gnu.org ([2001:4830:134:3::10]:54905)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ffOiR-0005XQ-0r
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 08:04:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ffOiQ-0007DK-8W
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 08:04:27 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38086 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1ffOiQ-0007CS-59
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 08:04:26 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BFF78808255B
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 12:04:25 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Tue, 17 Jul 2018 14:04:05 +0200
Message-Id: <20180717120414.5852-6-quintela@redhat.com>
In-Reply-To: <20180717120414.5852-1-quintela@redhat.com>
References: <20180717120414.5852-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 05/14] check: Only test sga when it is compiled
 in
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 tests/boot-serial-test.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/boot-serial-test.c b/tests/boot-serial-test.c
index 952a2e7ead..3f7c46fdf7 100644
--- a/tests/boot-serial-test.c
+++ b/tests/boot-serial-test.c
@@ -87,11 +87,13 @@ static testdef_t tests[] = {
     { "ppc64", "pseries", "", "Open Firmware" },
     { "ppc64", "powernv", "-cpu POWER8", "OPAL" },
     { "ppc64", "sam460ex", "-device e1000", "8086  100e" },
+#ifdef CONFIG_SGA
     { "i386", "isapc", "-cpu qemu32 -device sga", "SGABIOS" },
     { "i386", "pc", "-device sga", "SGABIOS" },
     { "i386", "q35", "-device sga", "SGABIOS" },
     { "x86_64", "isapc", "-cpu qemu32 -device sga", "SGABIOS" },
     { "x86_64", "q35", "-device sga", "SGABIOS" },
+#endif
     { "sparc", "LX", "", "TMS390S10" },
     { "sparc", "SS-4", "", "MB86904" },
     { "sparc", "SS-600MP", "", "TMS390Z55" },
-- 
2.17.1
