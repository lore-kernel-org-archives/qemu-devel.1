Received: from eggs.gnu.org ([2001:4830:134:3::10]:50561)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gSkXp-0004bF-2a
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 10:17:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gSkXo-0005T0-Ae
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 10:17:28 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 30 Nov 2018 15:17:12 +0000
Message-Id: <20181130151712.2312-11-peter.maydell@linaro.org>
In-Reply-To: <20181130151712.2312-1-peter.maydell@linaro.org>
References: <20181130151712.2312-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 10/10] include/hw/loader.h: Document
 load_image_size()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Stefan Hajnoczi <stefanha@redhat.com>, Eric Blake <eblake@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Philip Li <philip.li@intel.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alexander Graf <agraf@suse.de>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Igor Mammedov <imammedo@redhat.com>, qemu-block@nongnu.org, qemu-ppc@nongnu.org

Add a documentation comment for load_image_size().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/loader.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/hw/loader.h b/include/hw/loader.h
index 3766559bc24..0a0ad808ea3 100644
--- a/include/hw/loader.h
+++ b/include/hw/loader.h
@@ -11,6 +11,22 @@
  * On error, errno is also set as appropriate.
  */
 int64_t get_image_size(const char *filename);
+/**
+ * load_image_size: load an image file into specified buffer
+ * @filename: Path to the image file
+ * @addr: Buffer to load image into
+ * @size: Size of buffer in bytes
+ *
+ * Load an image file from disk into the specified buffer.
+ * If the image is larger than the specified buffer, only
+ * @size bytes are read (this is not considered an error).
+ *
+ * Prefer to use the GLib function g_file_get_contents() rather
+ * than a "get_image_size()/g_malloc()/load_image_size()" sequence.
+ *
+ * Returns the number of bytes read, or -1 on error. On error,
+ * errno is also set as appropriate.
+ */
 ssize_t load_image_size(const char *filename, void *addr, size_t size);
 
 /**load_image_targphys_as:
-- 
2.19.1
