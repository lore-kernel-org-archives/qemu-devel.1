Received: from eggs.gnu.org ([2001:4830:134:3::10]:41762)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fWMww-0005uG-J4
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 10:22:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fWMwv-0003XC-Ia
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 10:22:06 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:46726)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fWMwv-0003Wc-Bz
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 10:22:05 -0400
Received: by mail-wr0-x242.google.com with SMTP id l14-v6so1827272wrq.13
	for <qemu-devel@nongnu.org>; Fri, 22 Jun 2018 07:22:05 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 22 Jun 2018 15:12:04 +0100
Message-Id: <20180622141205.16306-22-alex.bennee@linaro.org>
In-Reply-To: <20180622141205.16306-1-alex.bennee@linaro.org>
References: <20180622141205.16306-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RISU PATCH v4 21/22] risu_reginfo_aarch64: limit
 SVE_VQ_MAX to current architecture
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

From: Richard Henderson <richard.henderson@linaro.org>

The kernel headers optimistically assume it's going to grow but as we
are never going to use that many on current hardware we limit
SVE_VQ_MAX to what we will.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 risu_reginfo_aarch64.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/risu_reginfo_aarch64.h b/risu_reginfo_aarch64.h
index b3701b3..c33b86f 100644
--- a/risu_reginfo_aarch64.h
+++ b/risu_reginfo_aarch64.h
@@ -31,6 +31,11 @@ struct sve_reginfo {
 };
 #endif
 
+/* The kernel headers set this based on future arch extensions.
+   The current arch maximum is 16.  Save space below.  */
+#undef SVE_VQ_MAX
+#define SVE_VQ_MAX 16
+
 struct reginfo {
     uint64_t fault_address;
     uint64_t regs[31];
-- 
2.17.1
