Received: from eggs.gnu.org ([2001:4830:134:3::10]:56670)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eMrno-00026c-N6
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 03:45:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eMrnj-0001sK-31
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 03:45:08 -0500
From: Fam Zheng <famz@redhat.com>
Date: Thu,  7 Dec 2017 16:44:53 +0800
Message-Id: <20171207084453.23773-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH] qemu-img: Document --force-share / -U
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 qemu-img.texi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/qemu-img.texi b/qemu-img.texi
index fdcf120f36..3aa63aad55 100644
--- a/qemu-img.texi
+++ b/qemu-img.texi
@@ -57,6 +57,14 @@ exclusive with the @var{-O} parameters. It is currently required to also use
 the @var{-n} parameter to skip image creation. This restriction may be relaxed
 in a future release.
 
+@item --force-share (-U)
+
+If specified, qemu-img will open the image with shared permissions, which makes
+it less likely to conflict with a running guest's permissions due to image
+locking. For example, this can be used to get the image information (with
+'info' subcommand) when the image is used by a running guest. Note that this
+could produce inconsistent result because of concurrent metadata changes, etc..
+
 @item fmt
 is the disk image format. It is guessed automatically in most cases. See below
 for a description of the supported disk formats.
-- 
2.14.3
