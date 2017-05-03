Received: from eggs.gnu.org ([2001:4830:134:3::10]:44108)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1d5qpI-000444-Pu
	for qemu-devel@nongnu.org; Wed, 03 May 2017 05:44:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1d5qpC-0006m9-2L
	for qemu-devel@nongnu.org; Wed, 03 May 2017 05:44:04 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:34509)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1d5qpB-0006lf-RB
	for qemu-devel@nongnu.org; Wed, 03 May 2017 05:43:57 -0400
Received: by mail-wr0-x241.google.com with SMTP id 6so21840582wrb.1
	for <qemu-devel@nongnu.org>; Wed, 03 May 2017 02:43:57 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed,  3 May 2017 11:43:49 +0200
Message-Id: <20170503094351.5040-4-pbonzini@redhat.com>
In-Reply-To: <20170503094351.5040-1-pbonzini@redhat.com>
References: <20170503094351.5040-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 3/5] get_maintainer: it's '--pattern-depth',
 not '-pattern-depth'
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

Though it appears that Perl's GetOptions will take either, the latter is
not documented in the options listing.

Cherry picked from Linux commit cc7ff0ef6eca3deeea4a424ca47a67c8450d5424.

Signed-off-by: Brian Norris <computersforpeace@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/get_maintainer.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
index 2bde32f64b..449bfbfccb 100755
--- a/scripts/get_maintainer.pl
+++ b/scripts/get_maintainer.pl
@@ -748,7 +748,7 @@ Other options:
   --help => show this help information
 
 Default options:
-  [--email --nogit --git-fallback --m --n --l --multiline -pattern-depth=0
+  [--email --nogit --git-fallback --m --n --l --multiline --pattern-depth=0
    --remove-duplicates --rolestats]
 
 Notes:
-- 
2.12.2
