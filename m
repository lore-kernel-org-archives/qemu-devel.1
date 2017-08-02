Received: from eggs.gnu.org ([2001:4830:134:3::10]:51721)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1dd03P-0000J6-2Z
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 16:15:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1dd03N-0006Hq-S1
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 16:15:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47178)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1dd03N-0006H9-MA
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 16:15:37 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B89A4C047B60
	for <qemu-devel@nongnu.org>; Wed,  2 Aug 2017 20:15:36 +0000 (UTC)
From: Cleber Rosa <crosa@redhat.com>
Date: Wed,  2 Aug 2017 16:15:10 -0400
Message-Id: <20170802201512.29142-5-crosa@redhat.com>
In-Reply-To: <20170802201512.29142-1-crosa@redhat.com>
References: <20170802201512.29142-1-crosa@redhat.com>
Subject: [Qemu-devel] [PATCH 4/6] tests/tcg/test-i386-fprem: build with
 $(QEMU_CFLAGS)
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

So that glib.h can be found.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 tests/tcg/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/tcg/Makefile b/tests/tcg/Makefile
index 89e3342..c946fde 100644
--- a/tests/tcg/Makefile
+++ b/tests/tcg/Makefile
@@ -98,7 +98,7 @@ test-i386: test-i386.c test-i386-code16.S test-i386-vm86.S \
               $(<D)/test-i386.c $(<D)/test-i386-code16.S $(<D)/test-i386-vm86.S -lm
 
 test-i386-fprem: test-i386-fprem.c
-	$(CC_I386) $(QEMU_INCLUDES) $(CFLAGS) $(LDFLAGS) -o $@ $^
+	$(CC_I386) $(QEMU_INCLUDES) $(QEMU_CFLAGS) $(CFLAGS) $(LDFLAGS) -o $@ $^
 
 test-x86_64: test-i386.c \
            test-i386.h test-i386-shift.h test-i386-muldiv.h
-- 
2.9.4
