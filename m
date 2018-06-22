Received: from eggs.gnu.org ([2001:4830:134:3::10]:38435)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fWMnM-00064f-VN
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 10:12:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fWMnI-00064i-Hb
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 10:12:12 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:38321)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fWMnI-000642-Ag
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 10:12:08 -0400
Received: by mail-wm0-x242.google.com with SMTP id 69-v6so2783062wmf.3
	for <qemu-devel@nongnu.org>; Fri, 22 Jun 2018 07:12:08 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 22 Jun 2018 15:11:45 +0100
Message-Id: <20180622141205.16306-3-alex.bennee@linaro.org>
In-Reply-To: <20180622141205.16306-1-alex.bennee@linaro.org>
References: <20180622141205.16306-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RISU PATCH v4 02/22] comms: include header for writev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, richard.henderson@linaro.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

The compiler complains about implicit declarations otherwise.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 comms.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/comms.c b/comms.c
index 2900c33..6946fd9 100644
--- a/comms.c
+++ b/comms.c
@@ -17,6 +17,7 @@
 #include <errno.h>
 #include <sys/socket.h>
 #include <sys/types.h>
+#include <sys/uio.h>
 #include <netinet/in.h>
 #include <netdb.h>
 
-- 
2.17.1
