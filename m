Received: from eggs.gnu.org ([209.51.188.92]:60971)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gm3wR-0007TM-2g
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 16:50:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gm3wP-0008GK-Sh
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 16:50:42 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:39877)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gm3wP-0007p5-I0
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 16:50:41 -0500
Received: by mail-wm1-x341.google.com with SMTP id y8so75583wmi.4
	for <qemu-devel@nongnu.org>; Tue, 22 Jan 2019 13:50:22 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 22 Jan 2019 21:50:10 +0000
Message-Id: <20190122215016.18697-6-alex.bennee@linaro.org>
In-Reply-To: <20190122215016.18697-1-alex.bennee@linaro.org>
References: <20190122215016.18697-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 05/11] fp-test: fix signature of
 slow_clear_flags and qemu_clear_flags
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Emilio G. Cota" <cota@braap.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>, Peter Maydell <peter.maydell@linaro.org>

From: "Emilio G. Cota" <cota@braap.org>

To match the type in testfloat.

Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/fp/fp-test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/fp/fp-test.c b/tests/fp/fp-test.c
index fca576309c..2a35ef601d 100644
--- a/tests/fp/fp-test.c
+++ b/tests/fp/fp-test.c
@@ -789,7 +789,7 @@ static int set_init_flags(const char *flags)
     return 0;
 }
 
-static uint8_t slow_clear_flags(void)
+static uint_fast8_t slow_clear_flags(void)
 {
     uint8_t prev = slowfloat_exceptionFlags;
 
@@ -797,7 +797,7 @@ static uint8_t slow_clear_flags(void)
     return prev;
 }
 
-static uint8_t qemu_clear_flags(void)
+static uint_fast8_t qemu_clear_flags(void)
 {
     uint8_t prev = qemu_flags_to_sf(qsf.float_exception_flags);
 
-- 
2.17.1
