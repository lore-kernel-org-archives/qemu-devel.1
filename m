Received: from eggs.gnu.org ([2001:4830:134:3::10]:56464)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1foAwO-00074l-QA
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 13:11:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1foAwM-0007if-IZ
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 13:11:08 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:38829)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1foAwM-0007he-Ag
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 13:11:06 -0400
Received: by mail-wr1-x444.google.com with SMTP id v14-v6so8907442wro.5
	for <qemu-devel@nongnu.org>; Fri, 10 Aug 2018 10:11:06 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 10 Aug 2018 18:10:59 +0100
Message-Id: <20180810171102.16451-2-alex.bennee@linaro.org>
In-Reply-To: <20180810171102.16451-1-alex.bennee@linaro.org>
References: <20180810171102.16451-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 1/3] HACKING: mention the C GNU extensions
 we use
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

QEMU is not a pure C99 code-base as anyone attempting to build with
-std=c99 will find out.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 HACKING | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/HACKING b/HACKING
index 0fc3e0fc04..e042dd1f4f 100644
--- a/HACKING
+++ b/HACKING
@@ -189,6 +189,11 @@ In addition, QEMU assumes that the compiler does not use the latitude
 given in C99 and C11 to treat aspects of signed '<<' as undefined, as
 documented in the GNU Compiler Collection manual starting at version 4.0.
 
+Finally QEMU also uses some GNU extensions to the C language including
+making extensive use of the typeof keyword for type inference. While
+typeof() is a GCC extension it is fairly widely understood by other
+compilers.
+
 7. Error handling and reporting
 
 7.1 Reporting errors to the human user
-- 
2.17.1
