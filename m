Received: from eggs.gnu.org ([2001:4830:134:3::10]:37561)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1diP9W-00047u-6F
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 14:04:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1diP9R-0005Ja-98
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 14:04:18 -0400
Received: from mail-wr0-x232.google.com ([2a00:1450:400c:c0c::232]:36418)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1diP9R-0005J7-3p
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 14:04:13 -0400
Received: by mail-wr0-x232.google.com with SMTP id f8so6194330wrf.3
	for <qemu-devel@nongnu.org>; Thu, 17 Aug 2017 11:04:12 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 17 Aug 2017 19:04:01 +0100
Message-Id: <20170817180404.29334-7-alex.bennee@linaro.org>
In-Reply-To: <20170817180404.29334-1-alex.bennee@linaro.org>
References: <20170817180404.29334-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 6/9] target/arm/translate-a64: regnames ->
 x_regnames
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: rth@twiddle.net, cota@braap.org, batuzovk@ispras.ru
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>

These are the integer registers as will become clear when we start
declaring the vector ones.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/translate-a64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 2200e25be0..805af51900 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -43,7 +43,7 @@ static TCGv_i64 cpu_pc;
 static TCGv_i64 cpu_exclusive_high;
 static TCGv_i64 cpu_reg(DisasContext *s, int reg);
 
-static const char *regnames[] = {
+static const char *x_regnames[] = {
     "x0", "x1", "x2", "x3", "x4", "x5", "x6", "x7",
     "x8", "x9", "x10", "x11", "x12", "x13", "x14", "x15",
     "x16", "x17", "x18", "x19", "x20", "x21", "x22", "x23",
-- 
2.13.0
