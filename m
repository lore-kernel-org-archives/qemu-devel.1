Received: from eggs.gnu.org ([2001:4830:134:3::10]:35514)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Antonios.Motakis@huawei.com>) id 1ejqTz-0002S6-73
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 12:59:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Antonios.Motakis@huawei.com>) id 1ejqTw-0006sO-6B
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 12:59:39 -0500
Received: from lhrrgout.huawei.com ([194.213.3.17]:43312 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Antonios.Motakis@huawei.com>)
	id 1ejqTv-0006r5-Vm
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 12:59:36 -0500
From: <antonios.motakis@huawei.com>
Date: Thu, 8 Feb 2018 19:00:16 +0100
Message-ID: <20180208180019.13683-2-antonios.motakis@huawei.com>
In-Reply-To: <20180208180019.13683-1-antonios.motakis@huawei.com>
References: <20180208180019.13683-1-antonios.motakis@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 1/4] 9pfs: V9fsQID: set type of version and
 path to unsigned
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, groug@kaod.org
Cc: veaceslav.falico@huawei.com, Eduard.Shishkin@huawei.com, andy.wangguoli@huawei.com, Jani.Kokkonen@huawei.com, cota@braap.org, berrange@redhat.com, Antonios Motakis <antonios.motakis@huawei.com>

From: Antonios Motakis <antonios.motakis@huawei.com>

There is no need for signedness on these QID fields for 9p.

Signed-off-by: Antonios Motakis <antonios.motakis@huawei.com>
---
 fsdev/9p-marshal.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fsdev/9p-marshal.h b/fsdev/9p-marshal.h
index c8823d8..d1ad364 100644
--- a/fsdev/9p-marshal.h
+++ b/fsdev/9p-marshal.h
@@ -10,8 +10,8 @@ typedef struct V9fsString
 typedef struct V9fsQID
 {
     int8_t type;
-    int32_t version;
-    int64_t path;
+    uint32_t version;
+    uint64_t path;
 } V9fsQID;
 
 typedef struct V9fsStat
-- 
1.8.3.1
