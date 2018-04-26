Received: from eggs.gnu.org ([2001:4830:134:3::10]:43221)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1fBjdE-0003KA-Px
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 12:20:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1fBjdC-0000j3-NP
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 12:20:28 -0400
From: Roman Kagan <rkagan@virtuozzo.com>
Date: Thu, 26 Apr 2018 19:19:54 +0300
Message-Id: <20180426161958.2872-14-rkagan@virtuozzo.com>
In-Reply-To: <20180426161958.2872-1-rkagan@virtuozzo.com>
References: <20180426161958.2872-1-rkagan@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 13/17] iotest 099: notrun if blkdebug or
 blkverify is disabled
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
 tests/qemu-iotests/099 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/qemu-iotests/099 b/tests/qemu-iotests/099
index caaf58eee5..80dab909d5 100755
--- a/tests/qemu-iotests/099
+++ b/tests/qemu-iotests/099
@@ -45,6 +45,7 @@ _supported_proto file
 _supported_os Linux
 _unsupported_imgopts "subformat=monolithicFlat" "subformat=twoGbMaxExtentFlat" \
     "subformat=twoGbMaxExtentSparse"
+_require_format blkdebug blkverify
 
 function do_run_qemu()
 {
-- 
2.14.3
