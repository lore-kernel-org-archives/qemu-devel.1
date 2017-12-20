Received: from eggs.gnu.org ([2001:4830:134:3::10]:56075)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eReIG-0004sR-Te
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 08:20:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eReIA-0006bV-HL
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 08:20:20 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 20 Dec 2017 14:19:35 +0100
Message-Id: <20171220131939.27543-11-kwolf@redhat.com>
In-Reply-To: <20171220131939.27543-1-kwolf@redhat.com>
References: <20171220131939.27543-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 10/14] qemu-img: Document --force-share / -U
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
 qemu-img.texi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/qemu-img.texi b/qemu-img.texi
index fdcf120f36..bc24565ae9 100644
--- a/qemu-img.texi
+++ b/qemu-img.texi
@@ -57,6 +57,15 @@ exclusive with the @var{-O} parameters. It is currently required to also use
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
 @item fmt
 is the disk image format. It is guessed automatically in most cases. See below
 for a description of the supported disk formats.
-- 
2.13.6
