Received: from eggs.gnu.org ([2001:4830:134:3::10]:38212)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cg939-0005YT-Ei
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 06:56:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cg938-0005G6-P4
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 06:56:07 -0500
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Tue, 21 Feb 2017 11:55:09 +0000
Message-Id: <20170221115512.21918-16-berrange@redhat.com>
In-Reply-To: <20170221115512.21918-1-berrange@redhat.com>
References: <20170221115512.21918-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v5 15/18] iotests: enable tests 134 and 158 to
 work with qcow (v1)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, Eric Blake <eblake@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

The 138 and 158 iotests exercise the legacy qcow2 aes encryption
code path and they work fine with qcow v1 too.

Reviewed-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 tests/qemu-iotests/134 | 2 +-
 tests/qemu-iotests/158 | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/134 b/tests/qemu-iotests/134
index dd080a2..1a24a70 100755
--- a/tests/qemu-iotests/134
+++ b/tests/qemu-iotests/134
@@ -37,7 +37,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.rc
 . ./common.filter
 
-_supported_fmt qcow2
+_supported_fmt qcow qcow2
 _supported_proto generic
 _supported_os Linux
 
diff --git a/tests/qemu-iotests/158 b/tests/qemu-iotests/158
index 7a1eb5c..2b53d9f 100755
--- a/tests/qemu-iotests/158
+++ b/tests/qemu-iotests/158
@@ -37,7 +37,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.rc
 . ./common.filter
 
-_supported_fmt qcow2
+_supported_fmt qcow qcow2
 _supported_proto generic
 _supported_os Linux
 
-- 
2.9.3
