Received: from eggs.gnu.org ([209.51.188.92]:60104)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gm2O1-0007eL-W3
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 15:11:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gm2O0-0005yq-6D
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 15:11:05 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:43813)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gm2Nz-0005qF-Ee
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 15:11:03 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Tue, 22 Jan 2019 15:10:40 -0500
Message-Id: <20190122201042.26394-3-cota@braap.org>
In-Reply-To: <20190122201042.26394-1-cota@braap.org>
References: <20190122201042.26394-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH 2/4] tests/fp/Makefile: do not use gcc-only -W
 flags
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

The build of testfloat objects now completes with both
gcc and clang.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 tests/fp/Makefile | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tests/fp/Makefile b/tests/fp/Makefile
index 5019dcdca0..5a35e7c210 100644
--- a/tests/fp/Makefile
+++ b/tests/fp/Makefile
@@ -65,8 +65,7 @@ QEMU_CFLAGS += $(TF_OPTS)
 TF_CFLAGS :=
 TF_CFLAGS += -Wno-strict-prototypes
 TF_CFLAGS += -Wno-unknown-pragmas
-TF_CFLAGS += -Wno-discarded-qualifiers
-TF_CFLAGS += -Wno-maybe-uninitialized
+TF_CFLAGS += -Wno-uninitialized
 TF_CFLAGS += -Wno-missing-prototypes
 TF_CFLAGS += -Wno-return-type
 TF_CFLAGS += -Wno-unused-function
-- 
2.17.1
