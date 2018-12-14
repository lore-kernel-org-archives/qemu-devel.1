Received: from eggs.gnu.org ([2001:4830:134:3::10]:38407)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gXofm-00008J-1i
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 09:42:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gXofj-0004Rh-C1
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 09:42:37 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:51898)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gXofj-0004RE-0L
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 09:42:35 -0500
Received: by mail-wm1-x32e.google.com with SMTP id s14so5926824wmh.1
	for <qemu-devel@nongnu.org>; Fri, 14 Dec 2018 06:42:34 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id m6sm3263204wrv.24.2018.12.14.06.42.32
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 14 Dec 2018 06:42:32 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 14 Dec 2018 14:42:06 +0000
Message-Id: <20181214144214.1260-15-peter.maydell@linaro.org>
In-Reply-To: <20181214144214.1260-1-peter.maydell@linaro.org>
References: <20181214144214.1260-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 14/22] device_tree.c: Don't use load_image()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The load_image() function is deprecated, as it does not let the
caller specify how large the buffer to read the file into is.
Instead use load_image_size().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-id: 20181130151712.2312-9-peter.maydell@linaro.org
---
 device_tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/device_tree.c b/device_tree.c
index 6d9c9726f66..296278e12ae 100644
--- a/device_tree.c
+++ b/device_tree.c
@@ -91,7 +91,7 @@ void *load_device_tree(const char *filename_path, int *sizep)
     /* First allocate space in qemu for device tree */
     fdt = g_malloc0(dt_size);
 
-    dt_file_load_size = load_image(filename_path, fdt);
+    dt_file_load_size = load_image_size(filename_path, fdt, dt_size);
     if (dt_file_load_size < 0) {
         error_report("Unable to open device tree file '%s'",
                      filename_path);
-- 
2.19.2
