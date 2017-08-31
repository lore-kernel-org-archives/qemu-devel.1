Received: from eggs.gnu.org ([2001:4830:134:3::10]:42387)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dnKk2-00059p-3b
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 04:22:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dnKk0-0005nO-Va
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 04:22:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53428)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dnKk0-0005mz-Pc
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 04:22:20 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Thu, 31 Aug 2017 09:21:57 +0100
Message-Id: <20170831082210.8362-3-stefanha@redhat.com>
In-Reply-To: <20170831082210.8362-1-stefanha@redhat.com>
References: <20170831082210.8362-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL for-2.10 02/15] throttle: Fix wrong variable
 name in the header documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Alberto Garcia <berto@igalia.com>, Stefan Hajnoczi <stefanha@redhat.com>

From: Alberto Garcia <berto@igalia.com>

The level of the burst bucket is stored in bkt.burst_level, not
bkt.burst_length.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
Message-id: 49aab2711d02f285567f3b3b13a113847af33812.1503580370.git.berto@igalia.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/qemu/throttle.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/qemu/throttle.h b/include/qemu/throttle.h
index d056008c18..66a8ac10a4 100644
--- a/include/qemu/throttle.h
+++ b/include/qemu/throttle.h
@@ -63,7 +63,7 @@ typedef enum {
  * - The bkt.avg rate does not apply until the bucket is full,
  *   allowing the user to do bursts until then. The I/O limit during
  *   bursts is bkt.max. To enforce this limit we keep an additional
- *   bucket in bkt.burst_length that leaks at a rate of bkt.max units
+ *   bucket in bkt.burst_level that leaks at a rate of bkt.max units
  *   per second.
  *
  * - Because of all of the above, the user can perform I/O at a
-- 
2.13.5
