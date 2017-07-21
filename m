Received: from eggs.gnu.org ([2001:4830:134:3::10]:33835)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1dYOvG-00047A-OE
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 23:48:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1dYOvG-0002ZH-4X
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 23:48:14 -0400
From: Cleber Rosa <crosa@redhat.com>
Date: Thu, 20 Jul 2017 23:47:30 -0400
Message-Id: <20170721034730.25612-4-crosa@redhat.com>
In-Reply-To: <20170721034730.25612-1-crosa@redhat.com>
References: <20170721034730.25612-1-crosa@redhat.com>
Subject: [Qemu-devel] [PATCH 3/3] qemu-iotests: require CONFIG_LINUX_AIO for
 test 087
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>, Jing Liu <liujbjl@linux.vnet.ibm.com>, Eric Blake <eblake@redhat.com>, Cleber Rosa <crosa@redhat.com>

One of the "sub-"tests of test 087 requires CONFIG_LINUX_AIO.

As a PoC/RFC, this goes the easy route and skips the test as a whole
when that feature is missing.  Other approaches include splitting
the test and adding extra filtering.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 tests/qemu-iotests/087 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/qemu-iotests/087 b/tests/qemu-iotests/087
index f8e4903..a2fb7de 100755
--- a/tests/qemu-iotests/087
+++ b/tests/qemu-iotests/087
@@ -34,6 +34,7 @@ status=1	# failure is the default!
 _supported_fmt qcow2
 _supported_proto file
 _supported_os Linux
+_require_feature CONFIG_LINUX_AIO
 
 function do_run_qemu()
 {
-- 
2.9.4
