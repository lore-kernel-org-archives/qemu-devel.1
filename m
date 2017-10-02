Received: from eggs.gnu.org ([2001:4830:134:3::10]:38914)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dz2bh-00082K-9M
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 11:26:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dz2bc-0007yC-1U
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 11:26:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34132)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dz2bb-0007wj-QE
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 11:26:03 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  2 Oct 2017 17:25:47 +0200
Message-Id: <20171002152552.27999-28-armbru@redhat.com>
In-Reply-To: <20171002152552.27999-1-armbru@redhat.com>
References: <20171002152552.27999-1-armbru@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 27/32] os-posix: Drop misleading comment
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com, marcandre.lureau@redhat.com, eblake@redhat.com
List-ID: <qemu-devel.nongnu.org>

Comments explaining why we include a header tend to go bad.  This
one's almost comical: not only doesn't qemu-options.hx use
MAP_POPULATE anymore (since commit ef36fa1, v2.0.0, 2013), even the
include it applies to got moved away in commit 02d0e09 (v2.7.0).

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 os-posix.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/os-posix.c b/os-posix.c
index 92e9d85215..b9c2343b1e 100644
--- a/os-posix.c
+++ b/os-posix.c
@@ -25,7 +25,6 @@
 
 #include "qemu/osdep.h"
 #include <sys/wait.h>
-/*needed for MAP_POPULATE before including qemu-options.h */
 #include <pwd.h>
 #include <grp.h>
 #include <libgen.h>
-- 
2.13.6
