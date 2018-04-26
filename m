Received: from eggs.gnu.org ([2001:4830:134:3::10]:43074)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1fBjd7-0003DJ-6i
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 12:20:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1fBjd5-0000eo-Bs
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 12:20:21 -0400
From: Roman Kagan <rkagan@virtuozzo.com>
Date: Thu, 26 Apr 2018 19:19:51 +0300
Message-Id: <20180426161958.2872-11-rkagan@virtuozzo.com>
In-Reply-To: <20180426161958.2872-1-rkagan@virtuozzo.com>
References: <20180426161958.2872-1-rkagan@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 10/17] iotest 081: notrun if quorum is disabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org

Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
---
 tests/qemu-iotests/081 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/qemu-iotests/081 b/tests/qemu-iotests/081
index da3fb0984b..3489f2975f 100755
--- a/tests/qemu-iotests/081
+++ b/tests/qemu-iotests/081
@@ -42,6 +42,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 _supported_fmt raw
 _supported_proto file
 _supported_os Linux
+_require_format quorum
 
 function do_run_qemu()
 {
-- 
2.14.3
