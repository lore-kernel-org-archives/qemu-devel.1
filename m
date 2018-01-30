Received: from eggs.gnu.org ([2001:4830:134:3::10]:46232)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1egPVM-0000DE-M2
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 01:34:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1egPVL-0002hI-Sn
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 01:34:52 -0500
From: Fam Zheng <famz@redhat.com>
Date: Tue, 30 Jan 2018 14:34:33 +0800
Message-Id: <20180130063433.11605-3-famz@redhat.com>
In-Reply-To: <20180130063433.11605-1-famz@redhat.com>
References: <20180130063433.11605-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v6 2/2] qemu-img: Document --force-share / -U
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
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qemu-img.texi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/qemu-img.texi b/qemu-img.texi
index 60a0e080c6..ec7e2f5d1e 100644
--- a/qemu-img.texi
+++ b/qemu-img.texi
@@ -86,6 +86,13 @@ exclusive with the @var{-O} parameters. It is currently required to also use
 the @var{-n} parameter to skip image creation. This restriction may be relaxed
 in a future release.
 
+@item --force-share (-U)
+If specified, @code{qemu-img} will open the image in shared mode, allowing
+concurrent writers. For example, this can be used to get the image information
+(with 'info' subcommand) when the image is used by a running guest.  Note that
+this could produce inconsistent results because of concurrent metadata changes,
+etc. This option is only allowed when opening images in read-only mode.
+
 @item --backing-chain
 will enumerate information about backing files in a disk image chain. Refer
 below for further description.
-- 
2.14.3
