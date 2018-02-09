Received: from eggs.gnu.org ([2001:4830:134:3::10]:57509)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ek1Fi-00050M-OL
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 00:29:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ek1Fh-0003xw-Qv
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 00:29:38 -0500
From: Fam Zheng <famz@redhat.com>
Date: Fri,  9 Feb 2018 13:29:14 +0800
Message-Id: <20180209052915.12855-3-famz@redhat.com>
In-Reply-To: <20180209052915.12855-1-famz@redhat.com>
References: <20180209052915.12855-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v7 2/3] qemu-img: Document --force-share / -U
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, qemu-block@nongnu.org, kchamart@redhat.com, eblake@redhat.com, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

Signed-off-by: Fam Zheng <famz@redhat.com>
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
2.14.3
