Received: from eggs.gnu.org ([2001:4830:134:3::10]:40358)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gFjKp-0006hu-Dj
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:22:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gFjJk-0008OY-Mo
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:21:11 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:41487)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gFjJk-0008O1-Eq
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:21:08 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Thu, 25 Oct 2018 13:20:11 -0400
Message-Id: <20181025172057.20414-3-cota@braap.org>
In-Reply-To: <20181025172057.20414-1-cota@braap.org>
References: <20181025172057.20414-1-cota@braap.org>
Subject: [Qemu-devel] [RFC 02/48] trace: expand mem_info:size_shift to 3 bits
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, =?UTF-8?q?Llu=C3=ADs=20Vilanova?= <vilanova@ac.upc.edu>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>

This will allow us to trace 16B-long memory accesses.

While at it, add some defines for the mem_info bits and simplify
trace_mem_get_info by making it a wrapper around trace_mem_build_info.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 trace-events | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/trace-events b/trace-events
index 4fd2cb4b97..9d65d472d2 100644
--- a/trace-events
+++ b/trace-events
@@ -151,7 +151,7 @@ vcpu guest_cpu_reset(void)
 # Access information can be parsed as:
 #
 # struct mem_info {
-#     uint8_t size_shift : 2; /* interpreted as "1 << size_shift" bytes */
+#     uint8_t size_shift : 3; /* interpreted as "1 << size_shift" bytes */
 #     bool    sign_extend: 1; /* sign-extended */
 #     uint8_t endianness : 1; /* 0: little, 1: big */
 #     bool    store      : 1; /* wheter it's a store operation */
-- 
2.17.1
