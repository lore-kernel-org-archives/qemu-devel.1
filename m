Received: from eggs.gnu.org ([209.51.188.92]:60119)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gm2O2-0007en-Eb
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 15:11:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gm2O0-0005yj-4A
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 15:11:06 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:56741)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gm2Nz-0005qD-H0
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 15:11:03 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Tue, 22 Jan 2019 15:10:41 -0500
Message-Id: <20190122201042.26394-4-cota@braap.org>
In-Reply-To: <20190122201042.26394-1-cota@braap.org>
References: <20190122201042.26394-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH 3/4] fp-test: fix signature of slow_clear_flags
 and qemu_clear_flags
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

To match the type in testfloat.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
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
