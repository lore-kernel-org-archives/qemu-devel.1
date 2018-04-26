Received: from eggs.gnu.org ([2001:4830:134:3::10]:43094)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1fBjd7-0003E6-OA
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 12:20:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1fBjd5-0000fU-QB
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 12:20:21 -0400
From: Roman Kagan <rkagan@virtuozzo.com>
Date: Thu, 26 Apr 2018 19:19:48 +0300
Message-Id: <20180426161958.2872-8-rkagan@virtuozzo.com>
In-Reply-To: <20180426161958.2872-1-rkagan@virtuozzo.com>
References: <20180426161958.2872-1-rkagan@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 07/17] iotest 055: require blkdebug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org

This test uses blkdebug extensively so notrun it if blkdebug is
disabled in QEMU.

Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
---
 tests/qemu-iotests/055 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/qemu-iotests/055 b/tests/qemu-iotests/055
index 3a47aaa886..02ea3cb72d 100755
--- a/tests/qemu-iotests/055
+++ b/tests/qemu-iotests/055
@@ -575,4 +575,5 @@ class TestDriveCompression(iotests.QMPTestCase):
                                         target='drive1')
 
 if __name__ == '__main__':
+    iotests.require_formats('blkdebug')
     iotests.main(supported_fmts=['raw', 'qcow2'])
-- 
2.14.3
