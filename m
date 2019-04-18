Received: from eggs.gnu.org ([209.51.188.92]:47757)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1hHFoZ-0002co-AE
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 18:47:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1hHFoW-0002y0-AV
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 18:47:30 -0400
Received: from mail-it1-x141.google.com ([2607:f8b0:4864:20::141]:37980)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1hHFoT-0002qk-09
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 18:47:26 -0400
Received: by mail-it1-x141.google.com with SMTP id f22so5810815ita.3
	for <qemu-devel@nongnu.org>; Thu, 18 Apr 2019 15:47:18 -0700 (PDT)
From: John Arbuckle <programmingkidx@gmail.com>
Date: Thu, 18 Apr 2019 18:47:06 -0400
Message-Id: <20190418224706.14014-1-programmingkidx@gmail.com>
Subject: [Qemu-devel] [PATCH] configure: Change capstone's default state to
 disabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, qemu-devel@nongnu.org
Cc: John Arbuckle <programmingkidx@gmail.com>

Capstone is not necessary in order to use QEMU. Disable it by default.
This will save the user the pain of having to figure why QEMU isn't
building when this library is missing.

Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
---
 configure | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure b/configure
index 1c563a7027..77d7967f92 100755
--- a/configure
+++ b/configure
@@ -433,7 +433,7 @@ opengl_dmabuf="no"
 cpuid_h="no"
 avx2_opt=""
 zlib="yes"
-capstone=""
+capstone="no"
 lzo=""
 snappy=""
 bzip2=""
-- 
2.14.3 (Apple Git-98)
