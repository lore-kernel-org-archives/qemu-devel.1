Received: from eggs.gnu.org ([2001:4830:134:3::10]:48544)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dIGGU-0006Dg-Ti
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 11:19:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dIGGP-0004nm-Tr
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 11:19:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51576)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dIGGP-0004mk-Nb
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 11:19:21 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CACFA142A68
	for <qemu-devel@nongnu.org>; Tue,  6 Jun 2017 15:19:20 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  6 Jun 2017 17:19:19 +0200
Message-Id: <20170606151919.772-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH] qemu-doc: include version number
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qemu-doc.texi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/qemu-doc.texi b/qemu-doc.texi
index 965ba5929e..8e5c4a951f 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -1,6 +1,7 @@
 \input texinfo @c -*- texinfo -*-
 @c %**start of header
 @setfilename qemu-doc.info
+@include version.texi
 
 @documentlanguage en
 @documentencoding UTF-8
@@ -19,7 +20,7 @@
 @iftex
 @titlepage
 @sp 7
-@center @titlefont{QEMU Emulator}
+@center @titlefont{QEMU version @value{VERSION}}
 @sp 1
 @center @titlefont{User Documentation}
 @sp 3
-- 
2.13.0
