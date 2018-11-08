Received: from eggs.gnu.org ([2001:4830:134:3::10]:53895)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gKjnh-0002DA-QI
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 07:52:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gKjnb-0002jw-Vq
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 07:52:45 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:52416)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gKjna-0002Pd-S6
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 07:52:39 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu,  8 Nov 2018 12:52:23 +0000
Message-Id: <20181108125223.30804-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] qga: Add multiple include guard to
 guest-agent-core.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Michael Roth <mdroth@linux.vnet.ibm.com>

The guest-agent-core.h header was missing the usual guards
against multiple inclusion; add them.

(Spotted by lgtm.com's static analyzer.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 qga/guest-agent-core.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/qga/guest-agent-core.h b/qga/guest-agent-core.h
index 6f4d214cb9f..60eae16f27a 100644
--- a/qga/guest-agent-core.h
+++ b/qga/guest-agent-core.h
@@ -10,6 +10,9 @@
  * This work is licensed under the terms of the GNU GPL, version 2 or later.
  * See the COPYING file in the top-level directory.
  */
+#ifndef GUEST_AGENT_CORE_H
+#define GUEST_AGENT_CORE_H
+
 #include "qapi/qmp/dispatch.h"
 #include "qemu-common.h"
 #include "qga-qapi-types.h"
@@ -46,3 +49,5 @@ int ga_parse_whence(GuestFileWhence *whence, Error **errp);
 #ifndef _WIN32
 void reopen_fd_to_null(int fd);
 #endif
+
+#endif /* GUEST_AGENT_CORE_H */
-- 
2.19.1
