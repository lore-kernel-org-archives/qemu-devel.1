Received: from eggs.gnu.org ([2001:4830:134:3::10]:54161)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ee1jW-0008Sb-HI
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 11:47:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ee1jV-0002hU-PS
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 11:47:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41724)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ee1jV-0002h4-IZ
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 11:47:37 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A284CB16E
	for <qemu-devel@nongnu.org>; Tue, 23 Jan 2018 16:47:36 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Tue, 23 Jan 2018 16:47:18 +0000
Message-Id: <20180123164718.12714-3-berrange@redhat.com>
In-Reply-To: <20180123164718.12714-1-berrange@redhat.com>
References: <20180123164718.12714-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v1 2/2] make: fix help message reference to
 bogus V=0 variable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

The make rules for building QEMU are mostly silent by default. They can
be made verbose by setting the variable V=1. The default state does not
however correspond to a V=0 setting - $(V) must be undefined / empty to
get the default quiet build.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index c263190b8d..554ba69ced 100644
--- a/Makefile
+++ b/Makefile
@@ -940,4 +940,5 @@ ifdef QEMU_GA_MSI_ENABLED
 endif
 	@echo  ''
 endif
-	@echo  '  $(MAKE) V=0|1 [targets] 0 => quiet build (default), 1 => verbose build'
+	@echo  '  $(MAKE) [targets]      (quiet build, default)'
+	@echo  '  $(MAKE) V=1 [targets]  (verbose build)'
-- 
2.14.3
