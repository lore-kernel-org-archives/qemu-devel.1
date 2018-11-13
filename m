Received: from eggs.gnu.org ([2001:4830:134:3::10]:59600)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1gMOwz-0007lG-8W
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 22:01:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1gMOwx-0005QF-1W
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 22:01:13 -0500
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c]:37280)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <flukshun@gmail.com>) id 1gMOww-0005L9-IU
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 22:01:10 -0500
Received: by mail-oi1-x22c.google.com with SMTP id w66-v6so9068256oiw.4
	for <qemu-devel@nongnu.org>; Mon, 12 Nov 2018 19:01:10 -0800 (PST)
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 12 Nov 2018 21:00:47 -0600
Message-Id: <20181113030047.11711-3-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20181113030047.11711-1-mdroth@linux.vnet.ibm.com>
References: <20181113030047.11711-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL for-3.1 2/2] qga: Add multiple include guard to
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
Cc: peter.maydell@linaro.org

From: Peter Maydell <peter.maydell@linaro.org>

The guest-agent-core.h header was missing the usual guards
against multiple inclusion; add them.

(Spotted by lgtm.com's static analyzer.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 qga/guest-agent-core.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/qga/guest-agent-core.h b/qga/guest-agent-core.h
index 6f4d214cb9..60eae16f27 100644
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
2.17.1
