Received: from eggs.gnu.org ([2001:4830:134:3::10]:58656)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <riku.voipio@linaro.org>) id 1e4nXe-0005HZ-0U
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 08:33:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <riku.voipio@linaro.org>) id 1e4nXa-0003zt-Ij
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 08:33:46 -0400
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242]:56610)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <riku.voipio@linaro.org>)
	id 1e4nXa-0003zc-Bm
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 08:33:42 -0400
Received: by mail-lf0-x242.google.com with SMTP id 90so5615949lfs.13
	for <qemu-devel@nongnu.org>; Wed, 18 Oct 2017 05:33:42 -0700 (PDT)
From: riku.voipio@linaro.org
Date: Wed, 18 Oct 2017 15:33:23 +0300
Message-Id: <8423fa9010f2cadd50e8c21a20c62dc5b977704c.1508329282.git.riku.voipio@linaro.org>
In-Reply-To: <cover.1508329282.git.riku.voipio@linaro.org>
References: <cover.1508329282.git.riku.voipio@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 09/10] linux-user/main: support dfilter
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

From: Alex Bennée <alex.bennee@linaro.org>

This adds the -dfilter support to linux-user. There is a minor
checkpatch complaint about formatting which I've ignored for aesthetic
reasons.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Riku Voipio <riku.voipio@linaro.org>
---
 linux-user/main.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/linux-user/main.c b/linux-user/main.c
index fd54d344bb..dde04c769a 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -3869,6 +3869,11 @@ static void handle_arg_log(const char *arg)
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
@@ -4066,6 +4071,8 @@ static const struct qemu_argument arg_table[] = {
     {"d",          "QEMU_LOG",         true,  handle_arg_log,
      "item[,...]", "enable logging of specified items "
      "(use '-d help' for a list of items)"},
+    {"dfilter",    "QEMU_DFILTER",     true,  handle_arg_dfilter,
+     "range[,...]","filter logging based on address range"},
     {"D",          "QEMU_LOG_FILENAME", true, handle_arg_log_filename,
      "logfile",     "write logs to 'logfile' (default stderr)"},
     {"p",          "QEMU_PAGESIZE",    true,  handle_arg_pagesize,
-- 
2.14.2
