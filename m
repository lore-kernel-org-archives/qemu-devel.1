Received: from eggs.gnu.org ([209.51.188.92]:39137)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hLW2G-00048d-QF
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 12:55:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hLVzl-0000iF-3X
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 12:52:41 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:54122)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hLVzk-0000hm-UK
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 12:52:41 -0400
Received: by mail-wm1-x344.google.com with SMTP id 26so4621120wmj.3
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 09:52:40 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 30 Apr 2019 17:52:24 +0100
Message-Id: <20190430165234.32272-6-alex.bennee@linaro.org>
In-Reply-To: <20190430165234.32272-1-alex.bennee@linaro.org>
References: <20190430165234.32272-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v5 05/15] tests/tcg/minilib: support %c format
 char
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, mark.cave-ayland@ilande.co.uk, cota@braap.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/minilib/printf.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tests/tcg/minilib/printf.c b/tests/tcg/minilib/printf.c
index 121620cb16..d530b32be5 100644
--- a/tests/tcg/minilib/printf.c
+++ b/tests/tcg/minilib/printf.c
@@ -47,7 +47,7 @@ static void print_num(unsigned long long value, int base)
 void ml_printf(const char *fmt, ...)
 {
     va_list ap;
-    char *str;
+    char *str, c;
     int base;
     int has_long;
     int alt_form;
@@ -119,6 +119,10 @@ void ml_printf(const char *fmt, ...)
             str = va_arg(ap, char*);
             print_str(str);
             break;
+        case 'c':
+            c = (char) va_arg(ap, int);
+            __sys_outc(c);
+            break;
         case '%':
             __sys_outc(*fmt);
             break;
-- 
2.20.1
