Received: from eggs.gnu.org ([2001:4830:134:3::10]:36154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1diLnT-0005hH-Br
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 10:29:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1diLnQ-0006uU-5U
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 10:29:19 -0400
From: Alberto Garcia <berto@igalia.com>
Date: Thu, 17 Aug 2017 17:28:12 +0300
Message-Id: <427228619067b0a029d2ae7706a3743a6da38128.1502979710.git.berto@igalia.com>
In-Reply-To: <cover.1502979710.git.berto@igalia.com>
References: <cover.1502979710.git.berto@igalia.com>
In-Reply-To: <cover.1502979710.git.berto@igalia.com>
References: <cover.1502979710.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH 1/4] throttle: Fix wrong variable name in the
 header documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Manos Pitsidianakis <el13635@mail.ntua.gr>

The level of the burst bucket is stored in bkt.burst_level, not
bkt.burst_lenght.

Signed-off-by: Alberto Garcia <berto@igalia.com>
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
2.11.0
