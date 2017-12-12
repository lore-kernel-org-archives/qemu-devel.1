Received: from eggs.gnu.org ([2001:4830:134:3::10]:45365)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eOYnA-0003Rj-8D
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 19:51:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eOYn9-0001BB-GD
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 19:51:28 -0500
From: Fam Zheng <famz@redhat.com>
Date: Tue, 12 Dec 2017 08:51:13 +0800
Message-Id: <20171212005113.909-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v4] qemu-img: Document --force-share / -U
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

---

v4: "images". [Kevin]

v3: Document that the option is not allowed for read-write. [Stefan]

v2: - "code{qemu-img}". [Kashyap, Eric]
    - "etc.." -> "etc.".
---
 qemu-img.texi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/qemu-img.texi b/qemu-img.texi
index fdcf120f36..d93501f94f 100644
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
+this could produce inconsistent result because of concurrent metadata changes,
+etc. This option is only allowed when opening images in read-only mode.
+
 @item fmt
 is the disk image format. It is guessed automatically in most cases. See below
 for a description of the supported disk formats.
-- 
2.14.3
