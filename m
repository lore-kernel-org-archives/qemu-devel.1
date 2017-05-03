Received: from eggs.gnu.org ([2001:4830:134:3::10]:44107)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1d5qpI-000442-Pd
	for qemu-devel@nongnu.org; Wed, 03 May 2017 05:44:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1d5qpC-0006mT-QK
	for qemu-devel@nongnu.org; Wed, 03 May 2017 05:44:04 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:35340)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1d5qpC-0006m4-Jg
	for qemu-devel@nongnu.org; Wed, 03 May 2017 05:43:58 -0400
Received: by mail-wr0-x241.google.com with SMTP id g12so21848302wrg.2
	for <qemu-devel@nongnu.org>; Wed, 03 May 2017 02:43:58 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed,  3 May 2017 11:43:50 +0200
Message-Id: <20170503094351.5040-5-pbonzini@redhat.com>
In-Reply-To: <20170503094351.5040-1-pbonzini@redhat.com>
References: <20170503094351.5040-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 4/5] get_maintainer: --r (list reviewer) is on
 by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, thuth@redhat.com, pavel.dovgaluk@ispras.ru

From: Brian Norris <computersforpeace@gmail.com>

We don't consistenly document the default value next to the option
listing, but we do have a list of defaults here, so let's keep it up to
date.

Cherry picked from Linux commit 4f07510df2e8c47fd65b8ffaaf6c5d334d59d598.

Signed-off-by: Brian Norris <computersforpeace@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/get_maintainer.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
index 449bfbfccb..bf210c7fa6 100755
--- a/scripts/get_maintainer.pl
+++ b/scripts/get_maintainer.pl
@@ -748,7 +748,7 @@ Other options:
   --help => show this help information
 
 Default options:
-  [--email --nogit --git-fallback --m --n --l --multiline --pattern-depth=0
+  [--email --nogit --git-fallback --m --r --n --l --multiline --pattern-depth=0
    --remove-duplicates --rolestats]
 
 Notes:
-- 
2.12.2
