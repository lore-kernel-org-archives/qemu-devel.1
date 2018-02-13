Received: from eggs.gnu.org ([2001:4830:134:3::10]:41565)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1elZHB-0003yC-Fq
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 07:01:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1elZH7-0007Ui-Pm
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 07:01:33 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:52535)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1elZH7-0007UW-KI
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 07:01:29 -0500
Received: by mail-wm0-x242.google.com with SMTP id j199so3412004wmj.2
	for <qemu-devel@nongnu.org>; Tue, 13 Feb 2018 04:01:29 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 13 Feb 2018 13:00:06 +0100
Message-Id: <1518523252-49106-3-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1518523252-49106-1-git-send-email-pbonzini@redhat.com>
References: <1518523252-49106-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 02/48] make: fix help message reference to bogus
 V=0 variable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: "Daniel P. Berrange" <berrange@redhat.com>

The make rules for building QEMU are mostly silent by default. They can
be made verbose by setting the variable V=1. The default state does not
however correspond to a V=0 setting - $(V) must be undefined / empty to
get the default quiet build.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
Message-Id: <20180123164718.12714-3-berrange@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 9b4291b..b5a6d60 100644
--- a/Makefile
+++ b/Makefile
@@ -958,4 +958,5 @@ ifdef QEMU_GA_MSI_ENABLED
 endif
 	@echo  ''
 endif
-	@echo  '  $(MAKE) V=0|1 [targets] 0 => quiet build (default), 1 => verbose build'
+	@echo  '  $(MAKE) [targets]      (quiet build, default)'
+	@echo  '  $(MAKE) V=1 [targets]  (verbose build)'
-- 
1.8.3.1
