Received: from eggs.gnu.org ([2001:4830:134:3::10]:39576)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1g052s-00082l-Ei
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 09:19:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1g052r-00032T-Kv
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 09:19:02 -0400
From: Jeff Cody <jcody@redhat.com>
Date: Wed, 12 Sep 2018 09:18:53 -0400
Message-Id: <20180912131853.1249324-5-jcody@redhat.com>
In-Reply-To: <20180912131853.1249324-1-jcody@redhat.com>
References: <20180912131853.1249324-1-jcody@redhat.com>
Subject: [Qemu-devel] [PULL 4/4] block/rbd: add deprecation documentation
 for filename keyvalue pairs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: peter.maydell@linaro.org, jcody@redhat.com, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>

Signed-off-by: Jeff Cody <jcody@redhat.com>
Message-id: 647f5b5ab7efd8bf567a504c832b1d2d6f719b23.1536704901.git.jcody@redhat.com
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
