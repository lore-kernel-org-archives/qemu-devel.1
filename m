Received: from eggs.gnu.org ([2001:4830:134:3::10]:54045)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fzqZI-0002uX-6c
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 17:51:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fzqJv-0002F5-Pw
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 17:35:41 -0400
From: Jeff Cody <jcody@redhat.com>
Date: Tue, 11 Sep 2018 17:34:56 -0400
Message-Id: <fb330b4c21bf6c53cc4ada53f3f33e13e531ee6c.1536701561.git.jcody@redhat.com>
In-Reply-To: <cover.1536701561.git.jcody@redhat.com>
References: <cover.1536701561.git.jcody@redhat.com>
In-Reply-To: <cover.1536701561.git.jcody@redhat.com>
References: <cover.1536701561.git.jcody@redhat.com>
Subject: [Qemu-devel] [PATCH v3 4/4] block/rbd: add deprecation documenation
 for filename keyvalue pairs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, qemu-stable@nongnu.org, jsnow@redhat.com, eblake@redhat.com

Signed-off-by: Jeff Cody <jcody@redhat.com>
---
 qemu-deprecated.texi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
index 1b9c007f12..4df8ac442d 100644
--- a/qemu-deprecated.texi
+++ b/qemu-deprecated.texi
@@ -190,6 +190,13 @@ used instead.
 In order to prevent QEMU from automatically opening an image's backing
 chain, use ``"backing": null'' instead.
 
+@subsubsection "rbd keyvalue pair encoded filenames": "" (since 3.1.0)
+
+Options for ``rbd'' should be specified according to its runtime options,
+like other block drivers.  Legacy parsing of keyvalue pair encoded
+filenames is useful to open images with the old format for backing files;
+These image files should be updated to use the current format.
+
 @subsection vio-spapr-device device options
 
 @subsubsection "irq": "" (since 3.0.0)
-- 
2.17.1
