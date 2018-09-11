Received: from eggs.gnu.org ([2001:4830:134:3::10]:36294)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fzrDS-0004ls-C8
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 18:33:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fzrDR-0006pV-F2
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 18:33:02 -0400
From: Jeff Cody <jcody@redhat.com>
Date: Tue, 11 Sep 2018 18:32:33 -0400
Message-Id: <647f5b5ab7efd8bf567a504c832b1d2d6f719b23.1536704901.git.jcody@redhat.com>
In-Reply-To: <cover.1536704901.git.jcody@redhat.com>
References: <cover.1536704901.git.jcody@redhat.com>
In-Reply-To: <cover.1536704901.git.jcody@redhat.com>
References: <cover.1536704901.git.jcody@redhat.com>
Subject: [Qemu-devel] [PATCH v4 4/4] block/rbd: add deprecation
 documentation for filename keyvalue pairs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, qemu-stable@nongnu.org, jsnow@redhat.com, eblake@redhat.com, libvir-list@redhat.com, mreitz@redhat.com, kwolf@redhat.com

Signed-off-by: Jeff Cody <jcody@redhat.com>
---
 qemu-deprecated.texi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
index 1b9c007f12..8d285b281e 100644
--- a/qemu-deprecated.texi
+++ b/qemu-deprecated.texi
@@ -190,6 +190,21 @@ used instead.
 In order to prevent QEMU from automatically opening an image's backing
 chain, use ``"backing": null'' instead.
 
+@subsubsection rbd keyvalue pair encoded filenames: "" (since 3.1.0)
+
+Options for ``rbd'' should be specified according to its runtime options,
+like other block drivers.  Legacy parsing of keyvalue pair encoded
+filenames is useful to open images with the old format for backing files;
+These image files should be updated to use the current format.
+
+Example of legacy encoding:
+
+@code{json:@{"file.driver":"rbd", "file.filename":"rbd:rbd/name"@}}
+
+The above, converted to the current supported format:
+
+@code{json:@{"file.driver":"rbd", "file.pool":"rbd", "file.image":"name"@}}
+
 @subsection vio-spapr-device device options
 
 @subsubsection "irq": "" (since 3.0.0)
-- 
2.17.1
