Received: from eggs.gnu.org ([2001:4830:134:3::10]:51701)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1dd03O-0000IU-8A
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 16:15:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1dd03N-0006HJ-CT
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 16:15:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47152)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1dd03N-0006GG-70
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 16:15:37 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 41F49C04B328
	for <qemu-devel@nongnu.org>; Wed,  2 Aug 2017 20:15:36 +0000 (UTC)
From: Cleber Rosa <crosa@redhat.com>
Date: Wed,  2 Aug 2017 16:15:09 -0400
Message-Id: <20170802201512.29142-4-crosa@redhat.com>
In-Reply-To: <20170802201512.29142-1-crosa@redhat.com>
References: <20170802201512.29142-1-crosa@redhat.com>
Subject: [Qemu-devel] [PATCH 3/6] tests/tcg/linux-test.c: include
 definitions for getrusage()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>

A include for <sys/resources.h> is missing, and prevents
tests/tcg/linux-test from compiling.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 tests/tcg/linux-test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/tcg/linux-test.c b/tests/tcg/linux-test.c
index 1c6c013..15c9d7f 100644
--- a/tests/tcg/linux-test.c
+++ b/tests/tcg/linux-test.c
@@ -39,6 +39,7 @@
 #include <dirent.h>
 #include <setjmp.h>
 #include <sys/shm.h>
+#include <sys/resource.h>
 
 #define TESTPATH "/tmp/linux-test.tmp"
 #define TESTPORT 7654
-- 
2.9.4
