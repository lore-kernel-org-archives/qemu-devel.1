Received: from eggs.gnu.org ([2001:4830:134:3::10]:60499)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fhsz9-0006l8-Dz
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 04:48:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fhsz8-0000Tg-I6
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 04:47:59 -0400
From: Fam Zheng <famz@redhat.com>
Date: Tue, 24 Jul 2018 16:47:38 +0800
Message-Id: <20180724084739.580-2-famz@redhat.com>
In-Reply-To: <20180724084739.580-1-famz@redhat.com>
References: <20180724084739.580-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH 1/2] docs: Describe using images in writing
 iotests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, eblake@redhat.com

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 docs/devel/testing.rst | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
index 5e19cd50da..8e1fa3a66e 100644
--- a/docs/devel/testing.rst
+++ b/docs/devel/testing.rst
@@ -255,6 +255,17 @@ comparable library support for invoking and interacting with QEMU programs. If
 you opt for Python, it is strongly recommended to write Python 3 compatible
 code.
 
+Both Python and Bash frameworks in iotests provide helpers to manage test
+images. They can be used to create and clean up images under the test
+directory. If no I/O or any protocol specific feature is needed, it is often
+more convenient to use the pseudo block driver, ``null-co://``, as the test
+image, which doesn't require image creation or cleaning up. Avoid system-wide
+devices or files whenever possible, such as ``/dev/null`` or ``/dev/zero``.
+Otherwise, image locking implications have to be considered.  For example,
+another application on the host may have locked the file, possibly leading to a
+test failure.  If using such devices are explicitly desired, consider adding
+``locking=off`` option to disable image locking.
+
 Docker based tests
 ==================
 
-- 
2.17.1
