Received: from eggs.gnu.org ([2001:4830:134:3::10]:38441)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gXofq-0000Cs-E5
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 09:42:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gXofm-0004TE-9S
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 09:42:42 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:35707)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gXofm-0004SE-2g
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 09:42:38 -0500
Received: by mail-wr1-x429.google.com with SMTP id 96so5680232wrb.2
	for <qemu-devel@nongnu.org>; Fri, 14 Dec 2018 06:42:37 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id m6sm3263204wrv.24.2018.12.14.06.42.35
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 14 Dec 2018 06:42:35 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 14 Dec 2018 14:42:08 +0000
Message-Id: <20181214144214.1260-17-peter.maydell@linaro.org>
In-Reply-To: <20181214144214.1260-1-peter.maydell@linaro.org>
References: <20181214144214.1260-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 16/22] include/hw/loader.h: Document
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

Add a documentation comment for load_image_size().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-id: 20181130151712.2312-11-peter.maydell@linaro.org
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
2.19.2
