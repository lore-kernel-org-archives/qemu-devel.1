Received: from eggs.gnu.org ([2001:4830:134:3::10]:58320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eK7y5-00026v-Uh
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 14:24:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eK7y5-0001fc-3v
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 14:24:25 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Wed, 29 Nov 2017 20:24:11 +0100
Message-Id: <20171129192411.6637-1-mreitz@redhat.com>
In-Reply-To: <20171123020832.8165-1-mreitz@redhat.com>
References: <20171123020832.8165-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH 18/17] iotests: Make 059 pass on machines with
 little RAM
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
Based-on: <20171123020832.8165-1-mreitz@redhat.com>

(Depends on patch 12 of this series; I'll merge both if I have to
 respin.)
---
 tests/qemu-iotests/059 | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/059 b/tests/qemu-iotests/059
index a1c34eeb7c..40f89eae18 100755
--- a/tests/qemu-iotests/059
+++ b/tests/qemu-iotests/059
@@ -152,7 +152,9 @@ done
 echo
 echo "=== Testing afl image with a very large capacity ==="
 _use_sample_img afl9.vmdk.bz2
-_img_info
+# The sed makes this test pass on machines with little RAM
+# (and also with 32 bit builds)
+_img_info | sed -e 's/Cannot allocate memory/Invalid argument/'
 _cleanup_test_img
 
 # success, all done
-- 
2.13.6
