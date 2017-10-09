Received: from eggs.gnu.org ([2001:4830:134:3::10]:39749)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1e1ZqE-000068-8z
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 11:19:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1e1Zq8-00053p-SU
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 11:19:38 -0400
Received: from mail-wm0-x229.google.com ([2a00:1450:400c:c09::229]:47180)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1e1Zq8-00053K-K1
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 11:19:32 -0400
Received: by mail-wm0-x229.google.com with SMTP id t69so23526919wmt.2
	for <qemu-devel@nongnu.org>; Mon, 09 Oct 2017 08:19:32 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon,  9 Oct 2017 16:19:26 +0100
Message-Id: <20171009151926.1708-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH] linux-user/main: support dfilter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 linux-user/main.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/linux-user/main.c b/linux-user/main.c
index 829f974662..5072aa855b 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -3854,6 +3854,11 @@ static void handle_arg_log(const char *arg)
     qemu_set_log(mask);
 }
 
+static void handle_arg_dfilter(const char *arg)
+{
+    qemu_set_dfilter_ranges(arg, NULL);
+}
+
 static void handle_arg_log_filename(const char *arg)
 {
     qemu_set_log_filename(arg, &error_fatal);
@@ -4054,6 +4059,8 @@ static const struct qemu_argument arg_table[] = {
     {"d",          "QEMU_LOG",         true,  handle_arg_log,
      "item[,...]", "enable logging of specified items "
      "(use '-d help' for a list of items)"},
+    {"dfilter",    "QEMU_DFILTER",     true,  handle_arg_dfilter,
+     "range[,...]","filter logging based on address range"},
     {"D",          "QEMU_LOG_FILENAME", true, handle_arg_log_filename,
      "logfile",     "write logs to 'logfile' (default stderr)"},
     {"p",          "QEMU_PAGESIZE",    true,  handle_arg_pagesize,
-- 
2.14.1
