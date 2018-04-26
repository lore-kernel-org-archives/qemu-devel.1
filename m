Received: from eggs.gnu.org ([2001:4830:134:3::10]:43188)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1fBjdC-0003HP-OU
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 12:20:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1fBjd8-0000hl-F6
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 12:20:26 -0400
From: Roman Kagan <rkagan@virtuozzo.com>
Date: Thu, 26 Apr 2018 19:19:57 +0300
Message-Id: <20180426161958.2872-17-rkagan@virtuozzo.com>
In-Reply-To: <20180426161958.2872-1-rkagan@virtuozzo.com>
References: <20180426161958.2872-1-rkagan@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 16/17] iotest 147: notrun if nbd is disabled
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
 tests/qemu-iotests/147 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/qemu-iotests/147 b/tests/qemu-iotests/147
index d2081df84b..f66a777351 100755
--- a/tests/qemu-iotests/147
+++ b/tests/qemu-iotests/147
@@ -249,6 +249,7 @@ class BuiltinNBD(NBDBlockdevAddBase):
 
 
 if __name__ == '__main__':
+    iotests.require_formats('nbd')
     # Need to support image creation
     iotests.main(supported_fmts=['vpc', 'parallels', 'qcow', 'vdi', 'qcow2',
                                  'vmdk', 'raw', 'vhdx', 'qed'])
-- 
2.14.3
