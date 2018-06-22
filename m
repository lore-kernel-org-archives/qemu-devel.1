Received: from eggs.gnu.org ([2001:4830:134:3::10]:38514)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fWMnO-000661-D9
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 10:12:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fWMnN-00068a-6a
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 10:12:14 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:33027)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fWMnM-00067R-QM
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 10:12:13 -0400
Received: by mail-wr0-x242.google.com with SMTP id k16-v6so6883507wro.0
	for <qemu-devel@nongnu.org>; Fri, 22 Jun 2018 07:12:12 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 22 Jun 2018 15:11:49 +0100
Message-Id: <20180622141205.16306-7-alex.bennee@linaro.org>
In-Reply-To: <20180622141205.16306-1-alex.bennee@linaro.org>
References: <20180622141205.16306-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RISU PATCH v4 06/22] Makefile: include
 risu_reginfo_$(ARCH) in HDRS
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

Otherwise changes to reginfo don't cause the whole thing to be
re-built causing much confusion when bisecting.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 16e48a0..4aad448 100644
--- a/Makefile
+++ b/Makefile
@@ -21,7 +21,7 @@ ALL_CFLAGS = -Wall -D_GNU_SOURCE -DARCH=$(ARCH) $(BUILD_INC) $(CFLAGS) $(EXTRA_C
 
 PROG=risu
 SRCS=risu.c comms.c reginfo.c risu_$(ARCH).c risu_reginfo_$(ARCH).c
-HDRS=risu.h
+HDRS=risu.h risu_reginfo_$(ARCH).h
 BINS=test_$(ARCH).bin
 
 # For dumping test patterns
-- 
2.17.1
