Received: from eggs.gnu.org ([2001:4830:134:3::10]:47151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d6aFL-0002PC-Hz
	for qemu-devel@nongnu.org; Fri, 05 May 2017 06:14:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d6aFK-0006gA-Ot
	for qemu-devel@nongnu.org; Fri, 05 May 2017 06:13:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51120)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1d6aFK-0006fv-IN
	for qemu-devel@nongnu.org; Fri, 05 May 2017 06:13:58 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri,  5 May 2017 12:13:31 +0200
Message-Id: <20170505101337.4650-16-pbonzini@redhat.com>
In-Reply-To: <20170505101337.4650-1-pbonzini@redhat.com>
References: <20170505101337.4650-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 15/21] MAINTAINERS: Add "R:" tag for
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
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>

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
Reviewed-by: Thomas Huth <thuth@redhat.com>
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
