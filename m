Received: from eggs.gnu.org ([2001:4830:134:3::10]:41763)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cFJgM-0007FI-RL
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 06:49:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cFJgJ-0007o7-Dp
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 06:49:42 -0500
Received: from mail-wm0-f43.google.com ([74.125.82.43]:36556)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cFJgJ-0007nm-7X
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 06:49:39 -0500
Received: by mail-wm0-f43.google.com with SMTP id g23so23074738wme.1
	for <qemu-devel@nongnu.org>; Fri, 09 Dec 2016 03:49:39 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri,  9 Dec 2016 11:48:26 +0000
Message-Id: <20161209114830.9158-7-alex.bennee@linaro.org>
In-Reply-To: <20161209114830.9158-1-alex.bennee@linaro.org>
References: <20161209114830.9158-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RISU PATCH v3 06/10] risu_aarch64: it's -> it is
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, joserz@linux.vnet.ibm.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 risu_aarch64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/risu_aarch64.c b/risu_aarch64.c
index 7f9f612..8e3539e 100644
--- a/risu_aarch64.c
+++ b/risu_aarch64.c
@@ -97,7 +97,7 @@ int send_register_info(write_fn write_fn, void *uc)
  * NB: called from a signal handler.
  *
  * We don't have any kind of identifying info in the incoming data
- * that says whether it's register or memory data, so if the two
+ * that says whether it is register or memory data, so if the two
  * sides get out of sync then we will fail obscurely.
  */
 int recv_and_compare_register_info(read_fn read_fn, respond_fn resp_fn, void *uc)
-- 
2.11.0
