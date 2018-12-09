Received: from eggs.gnu.org ([2001:4830:134:3::10]:33241)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gW4u0-0000Qi-W6
	for qemu-devel@nongnu.org; Sun, 09 Dec 2018 14:38:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gW4tv-0004w5-TN
	for qemu-devel@nongnu.org; Sun, 09 Dec 2018 14:38:08 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:48825)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gW4tv-0004rS-HD
	for qemu-devel@nongnu.org; Sun, 09 Dec 2018 14:38:03 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Sun,  9 Dec 2018 14:37:12 -0500
Message-Id: <20181209193749.12277-2-cota@braap.org>
In-Reply-To: <20181209193749.12277-1-cota@braap.org>
References: <20181209193749.12277-1-cota@braap.org>
Subject: [Qemu-devel] [RFC v2 01/38] trace: expand mem_info:size_shift to 3
 bits
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>

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
