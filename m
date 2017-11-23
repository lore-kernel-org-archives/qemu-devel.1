Received: from eggs.gnu.org ([2001:4830:134:3::10]:33740)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eHgxE-0004z9-8T
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 21:09:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eHgxD-0001dD-Ek
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 21:09:28 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Thu, 23 Nov 2017 03:08:23 +0100
Message-Id: <20171123020832.8165-9-mreitz@redhat.com>
In-Reply-To: <20171123020832.8165-1-mreitz@redhat.com>
References: <20171123020832.8165-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH 08/17] iotests: Skip 103 for refcount_bits=1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>, Fam Zheng <famz@redhat.com>

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/103 | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/qemu-iotests/103 b/tests/qemu-iotests/103
index ecbd8ebd71..d0cfab8844 100755
--- a/tests/qemu-iotests/103
+++ b/tests/qemu-iotests/103
@@ -40,6 +40,8 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 _supported_fmt qcow2
 _supported_proto file nfs
 _supported_os Linux
+# Internal snapshots are (currently) impossible with refcount_bits=1
+_unsupported_imgopts 'refcount_bits=1[^0-9]'
 
 IMG_SIZE=64K
 
-- 
2.13.6
