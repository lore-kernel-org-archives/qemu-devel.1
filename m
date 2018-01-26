Received: from eggs.gnu.org ([2001:4830:134:3::10]:44567)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ef5nW-0007BK-Pe
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 10:20:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ef5nS-0000hm-Pl
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 10:20:10 -0500
From: Alberto Garcia <berto@igalia.com>
Date: Fri, 26 Jan 2018 17:00:06 +0200
Message-Id: <9f551b36d688079dcda4838c788f41a190b5219c.1516978645.git.berto@igalia.com>
In-Reply-To: <cover.1516978645.git.berto@igalia.com>
References: <cover.1516978645.git.berto@igalia.com>
In-Reply-To: <cover.1516978645.git.berto@igalia.com>
References: <cover.1516978645.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH v3 39/39] iotests: Add l2-cache-entry-size to
 iotest 137
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>

This test tries reopening a qcow2 image with valid and invalid
options. This patch adds l2-cache-entry-size to the set.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 tests/qemu-iotests/137     | 5 +++++
 tests/qemu-iotests/137.out | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/tests/qemu-iotests/137 b/tests/qemu-iotests/137
index 5a01250005..87965625d8 100755
--- a/tests/qemu-iotests/137
+++ b/tests/qemu-iotests/137
@@ -83,6 +83,9 @@ $QEMU_IO \
     -c "reopen -o overlap-check.inactive-l2=off" \
     -c "reopen -o cache-size=1M" \
     -c "reopen -o l2-cache-size=512k" \
+    -c "reopen -o l2-cache-entry-size=512" \
+    -c "reopen -o l2-cache-entry-size=4k" \
+    -c "reopen -o l2-cache-entry-size=64k" \
     -c "reopen -o refcount-cache-size=128k" \
     -c "reopen -o cache-clean-interval=5" \
     -c "reopen -o cache-clean-interval=0" \
@@ -107,6 +110,8 @@ $QEMU_IO \
     -c "reopen -o cache-size=1M,l2-cache-size=2M" \
     -c "reopen -o cache-size=1M,refcount-cache-size=2M" \
     -c "reopen -o l2-cache-size=256T" \
+    -c "reopen -o l2-cache-entry-size=33k" \
+    -c "reopen -o l2-cache-entry-size=128k" \
     -c "reopen -o refcount-cache-size=256T" \
     -c "reopen -o overlap-check=constant,overlap-check.template=all" \
     -c "reopen -o overlap-check=blubb" \
diff --git a/tests/qemu-iotests/137.out b/tests/qemu-iotests/137.out
index 05efd74d17..e28e1eadba 100644
--- a/tests/qemu-iotests/137.out
+++ b/tests/qemu-iotests/137.out
@@ -20,6 +20,8 @@ cache-size, l2-cache-size and refcount-cache-size may not be set the same time
 l2-cache-size may not exceed cache-size
 refcount-cache-size may not exceed cache-size
 L2 cache size too big
+L2 cache entry size must be a power of two between 512 and the cluster size (65536)
+L2 cache entry size must be a power of two between 512 and the cluster size (65536)
 L2 cache size too big
 Conflicting values for qcow2 options 'overlap-check' ('constant') and 'overlap-check.template' ('all')
 Unsupported value 'blubb' for qcow2 option 'overlap-check'. Allowed are any of the following: none, constant, cached, all
-- 
2.11.0
