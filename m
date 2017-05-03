Received: from eggs.gnu.org ([2001:4830:134:3::10]:44110)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1d5qpI-000446-QG
	for qemu-devel@nongnu.org; Wed, 03 May 2017 05:44:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1d5qpA-0006kj-2P
	for qemu-devel@nongnu.org; Wed, 03 May 2017 05:44:04 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:35333)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1d5qp9-0006kC-R7
	for qemu-devel@nongnu.org; Wed, 03 May 2017 05:43:55 -0400
Received: by mail-wr0-x244.google.com with SMTP id g12so21848064wrg.2
	for <qemu-devel@nongnu.org>; Wed, 03 May 2017 02:43:55 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed,  3 May 2017 11:43:47 +0200
Message-Id: <20170503094351.5040-2-pbonzini@redhat.com>
In-Reply-To: <20170503094351.5040-1-pbonzini@redhat.com>
References: <20170503094351.5040-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 1/5] MAINTAINERS: Add "R:" tag for
 self-appointed reviewers
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

From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>

Some people are not content with the amount of mail they get, and would
like to be CCed on patches for areas they do not maintain.  Let them
satisfy their own appetite for qemu-devel messages.

Seriously: the purpose here is a bit different from the Linux kernel.
While Linux uses "R" to designate non-maintainers for reviewing patches
in a given area, in QEMU I would also like to use "R" so that people can
delegate sending pull requests while keeping some degree of oversight.

Based on Linux commit eafbaac3093760d1fd3b2a5b9f016362dd68af36.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a1d2b3a4d3..46cf4870f9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12,6 +12,8 @@ consult qemu-devel and not any specific individual privately.
 Descriptions of section entries:
 
 	M: Mail patches to: FullName <address@domain>
+	R: Designated reviewer: FullName <address@domain>
+	   These reviewers should be CCed on patches.
 	L: Mailing list that is relevant to this area
 	W: Web-page with status/info
 	Q: Patchwork web based patch tracking system site
-- 
2.12.2
