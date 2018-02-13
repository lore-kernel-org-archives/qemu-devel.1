Received: from eggs.gnu.org ([2001:4830:134:3::10]:51959)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ele1Z-0002l5-HI
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 12:05:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ele1X-0005Aw-T9
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 12:05:45 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 13 Feb 2018 18:04:37 +0100
Message-Id: <20180213170529.10858-4-kwolf@redhat.com>
In-Reply-To: <20180213170529.10858-1-kwolf@redhat.com>
References: <20180213170529.10858-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 03/55] qemu-img: Document --force-share / -U
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

From: Fam Zheng <famz@redhat.com>

Signed-off-by: Fam Zheng <famz@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Kashyap Chamarthy <kchamart@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qemu-img.texi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/qemu-img.texi b/qemu-img.texi
index 60a0e080c6..8a26400adb 100644
--- a/qemu-img.texi
+++ b/qemu-img.texi
@@ -86,6 +86,14 @@ exclusive with the @var{-O} parameters. It is currently required to also use
 the @var{-n} parameter to skip image creation. This restriction may be relaxed
 in a future release.
 
+@item --force-share (-U)
+If specified, @code{qemu-img} will open the image in shared mode, allowing
+other QEMU processes to open it in write mode. For example, this can be used to
+get the image information (with 'info' subcommand) when the image is used by a
+running guest.  Note that this could produce inconsistent results because of
+concurrent metadata changes, etc. This option is only allowed when opening
+images in read-only mode.
+
 @item --backing-chain
 will enumerate information about backing files in a disk image chain. Refer
 below for further description.
-- 
2.13.6
