Received: from eggs.gnu.org ([2001:4830:134:3::10]:38863)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eTfMY-0006lI-FV
	for qemu-devel@nongnu.org; Mon, 25 Dec 2017 21:53:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eTfMX-0004TS-PZ
	for qemu-devel@nongnu.org; Mon, 25 Dec 2017 21:53:06 -0500
From: Fam Zheng <famz@redhat.com>
Date: Tue, 26 Dec 2017 10:52:47 +0800
Message-Id: <20171226025247.11082-3-famz@redhat.com>
In-Reply-To: <20171226025247.11082-1-famz@redhat.com>
References: <20171226025247.11082-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v5 2/2] qemu-img: Document --force-share / -U
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, stefanha@redhat.com, kchamart@redhat.com, Kevin Wolf <kwolf@redhat.com>, eblake@redhat.com, Max Reitz <mreitz@redhat.com>

Signed-off-by: Fam Zheng <famz@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Kashyap Chamarthy <kchamart@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qemu-img.texi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/qemu-img.texi b/qemu-img.texi
index 60a0e080c6..e83e140f7a 100644
--- a/qemu-img.texi
+++ b/qemu-img.texi
@@ -86,6 +86,15 @@ exclusive with the @var{-O} parameters. It is currently required to also use
 the @var{-n} parameter to skip image creation. This restriction may be relaxed
 in a future release.
 
+@item --force-share (-U)
+
+If specified, @code{qemu-img} will open the image with shared permissions,
+which makes it less likely to conflict with a running guest's permissions due
+to image locking. For example, this can be used to get the image information
+(with 'info' subcommand) when the image is used by a running guest. Note that
+this could produce inconsistent results because of concurrent metadata changes,
+etc. This option is only allowed when opening images in read-only mode.
+
 @item --backing-chain
 will enumerate information about backing files in a disk image chain. Refer
 below for further description.
-- 
2.14.3
