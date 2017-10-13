Received: from eggs.gnu.org ([2001:4830:134:3::10]:41598)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1e32lS-0002PY-Kr
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 12:24:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1e32lO-0006Sq-8D
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 12:24:46 -0400
Received: from mail-wr0-x229.google.com ([2a00:1450:400c:c0c::229]:51101)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1e32lO-0006S8-2W
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 12:24:42 -0400
Received: by mail-wr0-x229.google.com with SMTP id q42so1429456wrb.7
	for <qemu-devel@nongnu.org>; Fri, 13 Oct 2017 09:24:41 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 13 Oct 2017 17:24:09 +0100
Message-Id: <20171013162438.32458-2-alex.bennee@linaro.org>
In-Reply-To: <20171013162438.32458-1-alex.bennee@linaro.org>
References: <20171013162438.32458-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 01/30] linux-user/main: support dfilter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: richard.henderson@linaro.org
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>

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
