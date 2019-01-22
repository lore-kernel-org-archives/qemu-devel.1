Received: from eggs.gnu.org ([209.51.188.92]:60870)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gm3wL-0007OS-7n
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 16:50:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gm3wI-00084T-2o
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 16:50:35 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:43979)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gm3wH-0007n0-52
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 16:50:33 -0500
Received: by mail-wr1-x42f.google.com with SMTP id r10so56540wrs.10
	for <qemu-devel@nongnu.org>; Tue, 22 Jan 2019 13:50:20 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 22 Jan 2019 21:50:09 +0000
Message-Id: <20190122215016.18697-5-alex.bennee@linaro.org>
In-Reply-To: <20190122215016.18697-1-alex.bennee@linaro.org>
References: <20190122215016.18697-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 04/11] tests/fp/Makefile: do not use
 gcc-only -W flags
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

The build now completes in both gcc and clang.

Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
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
