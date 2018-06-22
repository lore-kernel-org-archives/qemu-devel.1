Received: from eggs.gnu.org ([2001:4830:134:3::10]:38472)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fWMnN-00065V-Ro
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 10:12:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fWMnM-00067d-BU
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 10:12:13 -0400
Received: from mail-wr0-x234.google.com ([2a00:1450:400c:c0c::234]:37668)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fWMnM-000675-4l
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 10:12:12 -0400
Received: by mail-wr0-x234.google.com with SMTP id k6-v6so6862379wrp.4
	for <qemu-devel@nongnu.org>; Fri, 22 Jun 2018 07:12:12 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 22 Jun 2018 15:11:48 +0100
Message-Id: <20180622141205.16306-6-alex.bennee@linaro.org>
In-Reply-To: <20180622141205.16306-1-alex.bennee@linaro.org>
References: <20180622141205.16306-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RISU PATCH v4 05/22] risu: add zlib indication to
 help text
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

This is a simple aide-memoir as it can be tricky to determine this
with a simple statically compiled binary.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 risu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/risu.c b/risu.c
index 616fc33..c684c90 100644
--- a/risu.c
+++ b/risu.c
@@ -39,6 +39,9 @@ size_t signal_count;
 #ifdef HAVE_ZLIB
 #include <zlib.h>
 gzFile gz_trace_file;
+#define TRACE_TYPE "compressed"
+#else
+#define TRACE_TYPE "uncompressed"
 #endif
 
 sigjmp_buf jmpbuf;
@@ -273,7 +276,7 @@ void usage(void)
     fprintf(stderr, "between master and apprentice risu processes.\n\n");
     fprintf(stderr, "Options:\n");
     fprintf(stderr, "  --master          Be the master (server)\n");
-    fprintf(stderr, "  -t, --trace=FILE  Record/playback trace file\n");
+    fprintf(stderr, "  -t, --trace=FILE  Record/playback " TRACE_TYPE " trace file\n");
     fprintf(stderr,
             "  -h, --host=HOST   Specify master host machine (apprentice only)"
             "\n");
-- 
2.17.1
